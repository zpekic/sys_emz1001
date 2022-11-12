----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:23:43 11/11/2022 
-- Design Name: 
-- Module Name:    clockgen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clockgen is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           baudrate_sel : in  STD_LOGIC_VECTOR (2 downto 0);
           cpuclk_sel : in  STD_LOGIC_VECTOR (2 downto 0);
			  pulse: in STD_LOGIC;
           cpu_clk : out  STD_LOGIC;
           debounce_clk : out  STD_LOGIC;
           vga_clk : out  STD_LOGIC;
           baudrate_x4 : out  STD_LOGIC;
           baudrate : out  STD_LOGIC;
           freq50Hz : out  STD_LOGIC);
end clockgen;

architecture Behavioral of clockgen is

component sn74hc4040 is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR(11 downto 0));
end component;

constant clk_board: integer := 50000000;	-- 50MHz

type prescale_lookup is array (0 to 7) of integer range 0 to 65535;
constant prescale_value: prescale_lookup := (
		(clk_board / (16 * 600)),
		(clk_board / (16 * 1200)),
		(clk_board / (16 * 2400)),
		(clk_board / (16 * 4800)),
		(clk_board / (16 * 9600)),
		(clk_board / (16 * 19200)),
		(clk_board / (16 * 38400)),
		(clk_board / (16 * 57600))
	);
	
signal freq_25M, freq_2048, freq_1600: std_logic_vector(11 downto 0);

signal baudrate_x8: std_logic;	
signal freq4096, freq3200: std_logic;
signal prescale_baud, prescale_4096, prescale_3200: integer range 0 to 65535;
	
begin

-- connect to outputs
with cpuclk_sel select cpu_clk <=
	pulse when "000",	-- single step
	freq_2048(11)	when "001",	-- 1
	freq_2048(10)	when "010",	-- 2
	freq_2048(9)	when "011",	-- 4
	freq_1600(7)	when "100",	-- 12.5
	freq_1600(6)	when "101",	-- 25
	freq_1600(5)	when "110",	-- 50
	freq_1600(4)	when others;	-- 100 
	
debounce_clk <= freq_25M(8);	-- 25MHz/256 = 97.65625 kHz
vga_clk <= freq_25M(0);			-- 25MHz/1 = 25MHz
freq50Hz <= freq_1600(5);		-- 1600/32 = 50Hz
	
prescale: process(CLK, baudrate_x8, freq4096, freq3200, baudrate_sel)
begin
	if (rising_edge(CLK)) then
		if (prescale_baud = 0) then
			baudrate_x8 <= not baudrate_x8;
			prescale_baud <= prescale_value(to_integer(unsigned(baudrate_sel)));
		else
			prescale_baud <= prescale_baud - 1;
		end if;
		if (prescale_4096 = 0) then
			freq4096 <= not freq4096;
			prescale_4096 <= (clk_board / (2 * 4096));
		else
			prescale_4096 <= prescale_4096 - 1;
			--key_delayed <= key;
		end if;
		if (prescale_3200 = 0) then
			freq3200 <= not freq3200;
			prescale_3200 <= (clk_board / (2 * 3200));
		else
			prescale_3200 <= prescale_3200 - 1;
			--key_delayed <= key;
		end if;
	end if;
end process; 	

baudgen: sn74hc4040 port map (
			clock => baudrate_x8,
			reset => RESET,
			q(0) => baudrate_x4, 
			q(1) => open,
			q(2) => baudrate,
			q(11 downto 3) => open		
		);	

clockgen: sn74hc4040 port map (
			clock => CLK,	-- 50MHz crystal on Anvyl board
			reset => RESET,
			q => freq_25M
		);

powergen: sn74hc4040 port map (
			clock => freq4096,
			reset => RESET,
			q => freq_2048
		);
		
mainsgen: sn74hc4040 port map (
			clock => freq3200,
			reset => RESET,
			q => freq_1600
		);


end Behavioral;

