----------------------------------------------------------------------------------
-- Company: @Home
-- Engineer: zpekic@hotmail.com
-- 
-- Create Date: 10/15/2022 11:13:02 PM
-- Design Name: FPGA implementation of Iskra EMZ1001 4-bit microcontroller
-- Module Name: sys_emz1001_mercury - Behavioral
-- Project Name: 
-- Target Devices: https://www.micro-nova.com/mercury/ + Baseboard
-- Input devices: 
--
-- Tool Versions: ISE 14.7 (nt)
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.99 - Kinda works...
-- Additional Comments:
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
				-- SW(0) -- 
				-- SW(1) -- 
				-- SW(2) -- 
				-- SW(3) -- 
				-- SW(4) -- 
				-- SW(5) -- 
				-- SW(6) -- 
				-- SW(7)	-- 

				SW: in std_logic_vector(7 downto 0); 

				-- Push buttons on baseboard
				-- BTN0 - not used, test DP3 on 7seg LED
				-- BTN1 - not used, test DP2 on 7seg LED
				-- BTN2 - not used, test DP1 on 7seg LED
				-- BTN3 - not used, test DP0 on 7seg LED
				BTN: in std_logic_vector(3 downto 0); 

				-- Stereo audio output on baseboard
				--AUDIO_OUT_L, AUDIO_OUT_R: out std_logic;

				-- 7seg LED on baseboard 
				--A_TO_G: out std_logic_vector(6 downto 0); 
				--AN: out std_logic_vector(3 downto 0); 
				--DOT: out std_logic; 
				-- 4 LEDs on Mercury board (3 and 2 are used by VGA VSYNC and HSYNC)
				LED: inout std_logic_vector(3 downto 0);

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
				--HSYNC: out std_logic;
				--VSYNC: out std_logic;
				--RED: out std_logic_vector(2 downto 0);
				--GRN: out std_logic_vector(2 downto 0);
				--BLU: out std_logic_vector(1 downto 0);
				
				--PMOD interface
				PMOD: inout std_logic_vector(7 downto 0)
          );
end sys_emz1001_mercury;

architecture Structural of sys_emz1001_mercury is

-- core components

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
           freq50Hz : out  STD_LOGIC);
end component;

component debouncer8channel is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           signal_raw : in STD_LOGIC_VECTOR (7 downto 0);
           signal_debounced : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component uart_ser2par is
    Port ( reset : in  STD_LOGIC;
           rxd_clk : in  STD_LOGIC;
           mode : in  STD_LOGIC_VECTOR (2 downto 0);
           char : out  STD_LOGIC_VECTOR (7 downto 0);
           ready : buffer  STD_LOGIC;
           valid : out  STD_LOGIC;
           rxd : in  STD_LOGIC);
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

signal RESET: std_logic;

-- Connect to PmodUSBUART 
-- https://digilent.com/reference/pmod/pmodusbuart/reference-manual
alias PMOD_RTS: std_logic is PMOD(0);	
alias PMOD_RXD: std_logic is PMOD(1);
alias PMOD_TXD: std_logic is PMOD(2);
alias PMOD_CTS: std_logic is PMOD(3);	

--
signal switch: std_logic_vector(7 downto 0);

--
signal button: std_logic_vector(3 downto 0);
alias btn_ss: std_logic is button(0);

--- frequency signals
signal dot_clk: std_logic;
signal debounce_clk: std_logic;
signal baudrate_x4, baudrate: std_logic;	
signal cpu_clk: std_logic;

-- loopback
signal rx_char, tx_char: std_logic_vector(7 downto 0);
signal rx_ready, tx_send: std_logic;

begin   

-- master reset
RESET <= USR_BTN;

-- generate various frequencies
clocks: clockgen Port map ( 
		CLK => CLK, 	-- 50MHz on Mercury board
		RESET => RESET,
		baudrate_sel => switch(2 downto 0),
		cpuclk_sel =>	 switch(6 downto 4),
		pulse => btn_ss,
		cpu_clk => cpu_clk,
		debounce_clk => debounce_clk,
		vga_clk => open,
		baudrate_x4 => baudrate_x4,
		baudrate => baudrate,
		freq50Hz => open
		);

-- simple loopback
uart_rx: uart_ser2par Port map ( 
		reset => RESET, 
		rxd_clk => baudrate_x4,
		mode => "000",	-- 8N1
		char => rx_char,
		ready => rx_ready,
		valid => open,
		rxd => PMOD_TXD
		);
		
tx_char <= rx_char;
tx_send <= rx_ready;
		
uart_tx: uart_par2ser Port map (
		reset => RESET,
		txd_clk => baudrate,
		send => tx_send,
		mode => "000",	-- 8N1
		data => tx_char,
		ready => open,
		txd => PMOD_RXD
		);		
		
-- LEDs
LED(0) <= cpu_clk;
LED(1) <= PMOD_TXD;
LED(2) <= PMOD_RXD;
LED(3) <= rx_ready;
	
-- condition input signals (switches and buttons)
	debounce_sw: debouncer8channel Port map ( 
		clock => debounce_clk, 
		reset => RESET,
		signal_raw => SW,
		signal_debounced => switch
	);

	debounce_btn: debouncer8channel Port map ( 
		clock => debounce_clk, 
		reset => RESET,
		signal_raw(7 downto 4) => "0000",
		signal_raw(3 downto 0) => BTN,
		signal_debounced(7 downto 4) => open,
		signal_debounced(3 downto 0) => button
	);
	
		
end;
