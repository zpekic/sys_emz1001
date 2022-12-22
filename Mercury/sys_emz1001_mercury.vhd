----------------------------------------------------------------------------------
-- Company: 	https://hackaday.io/projects/hacker/233652
-- Engineer:	zpekic@hotmail.com
---------------------------------------------------------------------------------- 
-- Create Date: 10/15/2022 11:13:02 PM
-- Design Name: FPGA implementation of Iskra EMZ1001 4-bit microcontroller
-- Module Name: sys_emz1001_mercury - Behavioral
-- Project Name: 
-- Target Devices: https://www.micro-nova.com/mercury/ + Baseboard
-- Input devices: 
--
-- Tool Versions: ISE 14.7 (nt)
-- Description:    EMZ1001 series was the only microcontroller designed and produced in 
--						 ex-Yugoslavia. It was a co-production with AMI (known as S2000)
-- 					 https://hackaday.io/project/188614-iskra-emz1001a-a-virtual-resurrection
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.99 - Kinda works...
-- Additional Comments: 
-- https://hackaday.io/project/188614-iskra-emz1001a-a-virtual-resurrection/log/214192-system-description
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.emz1001_package.all;

entity sys_emz1001_mercury is
    Port ( 
				-- 50MHz on the Mercury board
				CLK: in std_logic;
				
				-- 12MHz external clock
				EXT_CLK: in std_logic;
				
				-- Master reset button on Mercury board
				USR_BTN: in std_logic; 

				-- Switches on baseboard
				-- SW(0) -- BAUDRATE SEL 0
				-- SW(1) -- BAUDRATE SEL 1
				-- SW(2) -- BAUDRATE SEL 2
				-- SW(3) -- OFF: EXTERNAL ROM, ON: INTERNAL ROM
				-- SW(4) -- CPUCLK SEL 0
				-- SW(5) -- CPUCLK SEL 1
				-- SW(6) -- CPUCLK SEL 2
				-- SW(7)	-- OFF: STOP, ON: RUN

				SW: in std_logic_vector(7 downto 0); 

				-- Push buttons on baseboard
				-- BTN0 - single step (effective if SW(6 downto 4)) = "000"
				-- BTN1 - not used
				-- BTN2 - not used
				-- BTN3 - not used
				BTN: in std_logic_vector(3 downto 0); 

				-- Stereo audio output on baseboard
				--AUDIO_OUT_L, AUDIO_OUT_R: out std_logic;

				-- 7seg LED on baseboard 
				A_TO_G: out std_logic_vector(6 downto 0); 
				AN: out std_logic_vector(3 downto 0); 
				DOT: out std_logic; 
				-- 4 LEDs on Mercury board (3 and 2 are used by VGA VSYNC and HSYNC)
				LED: out std_logic_vector(1 downto 0);

				-- ADC interface
				-- channel	input
				-- 0			Audio Left
				-- 1 			Audio Right
				-- 2			Temperature
				-- 3			Light	
				-- 4			Pot
				-- 5			Channel 5 (free)
				-- 6			Channel 6 (free)
				-- 7			Channel 7 (free)
				--ADC_MISO: in std_logic;
				--ADC_MOSI: out std_logic;
				--ADC_SCK: out std_logic;
				--ADC_CSN: out std_logic;
				--PS2_DATA: in std_logic;
				--PS2_CLOCK: in std_logic;

				--VGA interface
				--register state is traced to VGA after each instruction if SW0 = on
				--640*480 50Hz mode is used, which give 80*60 character display
				--but to save memory, only 80*50 are used which fits into 4k video RAM
				HSYNC: out std_logic;
				VSYNC: out std_logic;
				RED: out std_logic_vector(2 downto 0);
				GRN: out std_logic_vector(2 downto 0);
				BLU: out std_logic_vector(1 downto 0);
				
				--PMOD interface
				PMOD: inout std_logic_vector(3 downto 0)
          );
end sys_emz1001_mercury;

architecture Structural of sys_emz1001_mercury is

-- core components
component EMZ1001A is
    Port ( CLK : in  STD_LOGIC;
           nPOR : in  STD_LOGIC;
           RUN : in  STD_LOGIC;
           ROMS : in  STD_LOGIC;
           KREF : in  STD_LOGIC;	-- not used
           K : in  STD_LOGIC_VECTOR (3 downto 0);
           I : in  STD_LOGIC_VECTOR (3 downto 0);
           nEXTERNAL : out  STD_LOGIC;
           SYNC : out  STD_LOGIC;
           STATUS : out  STD_LOGIC;
           A : out  STD_LOGIC_VECTOR (12 downto 0);
           D : inout  STD_LOGIC_VECTOR (7 downto 0);
			  -- debug
			  dbg_sel: in STD_LOGIC_VECTOR(5 downto 0);
			  dbg_mem: out STD_LOGIC_VECTOR(3 downto 0);
			  dbg_reg: out STD_LOGIC_VECTOR(3 downto 0)
			  );
end component;

component rom1k is
	generic (
		filename: string := "";
		default_value: STD_LOGIC_VECTOR(7 downto 0) := X"00"
	);
	Port ( 
		A : in  STD_LOGIC_VECTOR (9 downto 0);
		nOE : in  STD_LOGIC;
		D : out  STD_LOGIC_VECTOR (7 downto 0)
	);
end component;

-- Misc components
component clockgen is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           baudrate_sel : in  STD_LOGIC_VECTOR (2 downto 0);
           cpuclk_sel : in  STD_LOGIC_VECTOR (2 downto 0);
			  pulse : in STD_LOGIC;
           cpu_clk : out  STD_LOGIC;
           debounce_clk : out  STD_LOGIC;
           vga_clk : out  STD_LOGIC;
           baudrate_x4 : out  STD_LOGIC;
           baudrate : out  STD_LOGIC;
           freq100Hz : out  STD_LOGIC;
           freq50Hz : out  STD_LOGIC;
			  freq1Hz : out STD_LOGIC);
end component;

component ttyvgawin is
    Port ( reset : in  STD_LOGIC;
           vga_clk : in  STD_LOGIC;
			  tty_clk : in  STD_LOGIC;
			  cur_clk : in  STD_LOGIC;
           hsync : out  STD_LOGIC;
           vsync : out  STD_LOGIC;
           color : out  STD_LOGIC_VECTOR (11 downto 0);
           row : out  STD_LOGIC_VECTOR (7 downto 0);
           col : out  STD_LOGIC_VECTOR (7 downto 0);
           win : in  STD_LOGIC;
           win_color : in  STD_LOGIC;
           win_char : in  STD_LOGIC_VECTOR (7 downto 0);
           tty_send : in  STD_LOGIC;
           tty_char : in  STD_LOGIC_VECTOR (7 downto 0);
           tty_sent : out  STD_LOGIC;  
			  -- not part of real device, used for debugging
           debug : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component uart_par2ser is
    Port ( reset : in  STD_LOGIC;
			  txd_clk: in STD_LOGIC;
			  send: in STD_LOGIC;
			  mode: in STD_LOGIC_VECTOR(2 downto 0);
			  data: in STD_LOGIC_VECTOR(7 downto 0);
           ready : buffer STD_LOGIC;
           txd : out  STD_LOGIC);
end component;

component debouncer is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           signal_in : in  STD_LOGIC;
           signal_out : out  STD_LOGIC);
end component;

-- mask for a 16*16 window on VGA screen to display EMZ1001 internal data
-- i00tmmmm -- hex value selected by "mmmm" looked up throug table "t" and possibly "i"nverted
-- ixxxxxxx -- all other characters are ASCII, possibly "i"verted
constant mask: mem256x8 := (
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '),i(' '),i(' '),i(' '),i(' '),i(' '),i('T'),X"11",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '),i(' '),i(' '),i('R'),i('O'),i('M'),i('S'),X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('A'),i('H'),i('I'),i(' '),i(' '),i(' '),X"07", X"06",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('A'),i('L'),i('O'),i(' '),i(' '),i(' '),X"05", X"04",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('D'),i(' '),i(' '),i(' '),i(' '),i(' '),X"03", X"02",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('R'),i('N'),i('/'),i('S'),i('K'),i('P'),X"01", X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('F'),i('2'),i('/'),i('F'),i('1'),i(' '),X"01", X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('C'),i('Y'),i('/'),i('S'),i('E'),i('C'),X"01", X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('E'),i(' '),i(' '),i(' '),i(' '),i(' '),i(' '),X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('A'),i(' '),i(' '),i(' '),i(' '),i(' '),i(' '),X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('P'),i('S'),i('X'),i('H'),i('I'),i(' '),X"01", X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('B'),i('U'),i('/'),i('B'),i('L'),i(' '),X"01" ,X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('R'),i('A'),i('M'),i(' '),i(' '),i(' '),i(' '),X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('S'),i('P'),i(' '),i(' '),i(' '),i(' '),i(' '),X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('I'),i('N'),i('S'),i('T'),i('R'),i(' '),X"01", X"01",
	i(' '), X"00",i(' '), X"00",i(' '), X"00",i(' '), X"00",i('P'),i('C'),i(' '),i(' '),X"01" ,X"01" ,X"01" ,X"01"
);	

-- used for Tx cycles etc.
constant lookup1: mem16x8 := (
	c('?'),
	c('1'),
	c('3'),
	c('?'),
	c('5'),
	c('?'),
	c('?'),
	c('?'),
	c('7'),
	c('?'),
	c('?'),
	c('?'),
	c('?'),
	c('?'),
	c('?'),
	c('?')
);

signal RESET: std_logic;

-- Connect to PmodUSBUART 
-- https://digilent.com/reference/pmod/pmodusbuart/reference-manual
alias PMOD_RTS: std_logic is PMOD(0);	
alias PMOD_RXD: std_logic is PMOD(1);
alias PMOD_TXD: std_logic is PMOD(2);
alias PMOD_CTS: std_logic is PMOD(3);	

--
signal switch: std_logic_vector(7 downto 0);
alias sw_run: std_logic is switch(7);
alias sw_cpuclk: std_logic_vector(2 downto 0) is switch(6 downto 4);
alias sw_internalrom: std_logic is switch(3);
alias sw_baudrate: std_logic_vector(2 downto 0) is switch(2 downto 0);

--
signal button: std_logic_vector(3 downto 0);
alias btn_ss: std_logic is button(0);

--- frequency signals
signal vga_clk: std_logic;
signal debounce_clk: std_logic;
signal baudrate_x4, baudrate: std_logic;	
signal cpu_clk: std_logic;
signal freq100Hz, freq50Hz, freq1Hz: std_logic;

-- loopback
signal rx_char, tx_char: std_logic_vector(7 downto 0);
signal rx_ready, tx_send, tx_ready, tty_sent: std_logic;

-- video
signal vga_row, vga_col: std_logic_vector(7 downto 0);
signal win_row, win_col: std_logic_vector(7 downto 0);
signal win: std_logic;
signal mask_index: std_logic_vector(7 downto 0);
signal win_mask, win_char: std_logic_vector(7 downto 0);
signal win_hex: std_logic_vector(3 downto 0);

-- 7seg LED
signal blank: std_logic;

-- EMZ1001A bus
signal A: std_logic_vector(12 downto 0);
signal D: std_logic_vector(7 downto 0);
signal SYNC, ROMS: std_logic;
signal emz_i: std_logic_vector(3 downto 0);
signal emz_nExt: std_logic;
-- EMZ1001A debug
signal dbg_sel: std_logic_vector(5 downto 0);
signal dbg_mem, dbg_reg: std_logic_vector(3 downto 0); 
 

begin   

-- master reset
RESET <= USR_BTN;

-- 1k of external ROM contains the "Fibonacci" program
appware: rom1k generic map(
		filename => "..\prog\fibonacci_code.hex",
		default_value => nop
	)	
	port map(
		D => D,
		A => A(9 downto 0),
		nOE => SYNC
	);

-- microcontroller!
mc: EMZ1001A Port map ( 
			CLK => cpu_clk,
			nPOR => not RESET,
			RUN => sw_run,
			ROMS => ROMS,
			KREF => '1',	-- not used
			K => button,
			I => emz_i,		-- only I(3) and I(0) used
			nEXTERNAL => emz_nExt,
			SYNC => SYNC,
			STATUS => open,
			A => A,
			D => D,
			-- debug
			dbg_sel => dbg_sel, 
			dbg_mem => dbg_mem,
			dbg_reg => dbg_reg
		);

-- use internal ROM when switch(3) is on, or external when off
ROMS <= sw_internalrom or SYNC;

-- feed for SOS and SZI
emz_i <= freq50Hz & "00" & (tx_ready and tty_sent);

-- generate various frequencies
clocks: clockgen Port map ( 
		CLK => CLK, 	-- 50MHz on Mercury board
		RESET => RESET,
		baudrate_sel => sw_baudrate,
		cpuclk_sel =>	 sw_cpuclk,
		pulse => btn_ss,
		cpu_clk => cpu_clk,
		debounce_clk => debounce_clk,
		vga_clk => vga_clk,
		baudrate_x4 => baudrate_x4,
		baudrate => baudrate,
		freq100Hz => freq100Hz,
		freq50Hz => freq50Hz,
		freq1Hz => freq1Hz
		);

-- video
video: ttyvgawin port map ( 
		reset => RESET,
		vga_clk => vga_clk,
		tty_clk => vga_clk,
		cur_clk => freq1Hz,
		hsync => HSYNC,
		vsync => VSYNC,
		-- convert RRRRGGGGBBBB to RRRGGGBB (drop 1-2 LSB bits)
		color(11 downto 9) => RED,
		color(8) => open,
		color(7 downto 5) => GRN,
		color(4) => open,
		color(3 downto 2) => BLU,
		color(1 downto 0) => open,
		row => vga_row,
		col => vga_col,
		win => win,
		win_color => sw_run,	-- show run and stop mode in different colors 
		win_char(7) => win_mask(7),
		win_char(6 downto 0) => win_char(6 downto 0),
		tty_send => tx_send,
		tty_char => tx_char,
		tty_sent => tty_sent,
		debug => open --dbg_tty
	  );

-- show 16*16 window with top, left at screen center
win_row <= std_logic_vector(unsigned(vga_row) - 30);
win_col <= std_logic_vector(unsigned(vga_col) - 40);
win <= not (win_row(7) or win_row(6) or win_row(5) or win_row(4) or win_col(7) or win_col(6) or win_col(5) or win_col(4));
mask_index <= win_row(3 downto 0) & win_col(3 downto 0);
win_mask <= mask(to_integer(unsigned(mask_index)));
dbg_sel(3 downto 0) <= win_row(3 downto 0);
dbg_sel(5 downto 4) <= win_col(2 downto 1) when (win_col(3) = '0') else win_col(1 downto 0); 

-- select if character is direct pass-through or from data
with win_mask(6 downto 4) select win_char <=
	hex2ascii(to_integer(unsigned(win_hex))) when "000",	-- binary, octal, dec, hex
	lookup1(to_integer(unsigned(win_hex))) when "001",		-- special
	win_mask when others;

-- select data for display (0 and 1 come internally from EMZ, 2 - F are external)
with win_mask(3 downto 0) select win_hex <=
	dbg_mem when X"0",
	dbg_reg when X"1",
	D(3 downto 0) when X"2",
	D(7 downto 4) when X"3",
	A(3 downto 0) when X"4",
	A(7 downto 4) when X"5",
	A(11 downto 8) when X"6",
	"000" & A(12) when X"7",
	X"F" when others;

-- simple loopback
--uart_rx: uart_ser2par Port map ( 
--		reset => RESET, 
--		rxd_clk => baudrate_x4,
--		mode => "000",	-- 8N1
--		char => rx_char,
--		ready => rx_ready,
--		valid => open,
--		rxd => PMOD_TXD
--		);

tx_char <= D; 
tx_send <= not (emz_nExt); 
		
uart_tx: uart_par2ser Port map (
		reset => RESET,
		txd_clk => baudrate,
		send => tx_send,
		mode => "000",	-- 8N1
		data => tx_char,
		ready => tx_ready,
		txd => PMOD_RXD
		);		
		
-- LEDs
LED(0) <= emz_nExt; 
LED(1) <= PMOD_TXD;
	
-- when using external ROM, prevent A and D messing up the LEDs when SYNC is low
blank <= not (SYNC or sw_internalrom);
	
DOT <= D(7);
A_TO_G <= D(6 downto 0);
AN <= "1111" when (blank = '1') else A(3 downto 0);
	
-- generate 4 debouncers for buttons and 8 for switches to clean input signals
debouncer_generate: for i in 0 to 7 generate
begin
	dbc: if (i < 4) generate
		db_btn: debouncer port map 
		(
			clock => debounce_clk,
			reset => RESET,
			signal_in => BTN(i),
			signal_out => button(i)
		);
	end generate;
	
	db_sw: debouncer port map 
	(
		clock => debounce_clk,
		reset => RESET,
		signal_in => SW(i),
		signal_out => switch(i)
	);
end generate;
		
end;
