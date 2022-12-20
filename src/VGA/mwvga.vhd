----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:47:42 05/11/2019 
-- Design Name: 
-- Module Name:    mwvga - Behavioral 
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
--use work.tms0800_package.all;

entity mwvga is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  mem_char: in STD_LOGIC_VECTOR (7 downto 0);
			  win_char: in STD_LOGIC_VECTOR (7 downto 0);
			  win: in STD_LOGIC;
			  win_color: in STD_LOGIC;
           hactive : buffer  STD_LOGIC;
           vactive : buffer  STD_LOGIC;
           x : out  STD_LOGIC_VECTOR (7 downto 0);
           y : out  STD_LOGIC_VECTOR (7 downto 0);
			  cursor_enable : in  STD_LOGIC;
			  cursor_type : in  STD_LOGIC;
			  -- VGA connections
			  color: out STD_LOGIC_VECTOR(11 downto 0);
           hsync : out  STD_LOGIC;
           vsync : out  STD_LOGIC);
end mwvga;

architecture Behavioral of mwvga is

component chargen_rom is
    Port ( a : in  STD_LOGIC_VECTOR (10 downto 0);
           h : in  STD_LOGIC_VECTOR (2 downto 0);
			  pixel: out STD_LOGIC
			);
end component;

-- basic colors (RRRRGGGGBBBB)
constant color8_black : std_logic_vector(11 downto 0) := X"000"; 
constant color8_red	 : std_logic_vector(11 downto 0) := X"F00"; 
constant color8_green : std_logic_vector(11 downto 0) := X"0F0"; 
constant color8_blue	 : std_logic_vector(11 downto 0) := X"00F"; 
constant color8_cyan  : std_logic_vector(11 downto 0) := X"0FF"; 
constant color8_purple: std_logic_vector(11 downto 0) := X"F0F"; 
constant color8_yellow: std_logic_vector(11 downto 0) := X"FF0"; 
constant color8_white : std_logic_vector(11 downto 0) := X"FFF"; 

type table8x12 is array(0 to 7) of std_logic_vector(11 downto 0);
constant palette: table8x12 :=(
	color8_blue,
	color8_cyan,
	color8_blue,
	color8_cyan,
	color8_black,
	color8_red,
	color8_black,
	color8_yellow
	);

signal hpulse, h, hfp: std_logic_vector(11 downto 0);
signal vpulse, v, vfp: std_logic_vector(11 downto 0);
signal h_clk, v_clk: std_logic;
signal pixel: std_logic;
signal reverse: std_logic;
signal color_index: STD_LOGIC_VECTOR(2 downto 0);
signal a: std_logic_vector(7 downto 0);

begin

hsync <= not hpulse(11);
hactive <= hfp(11) and (not h(11));
x <= h(10 downto 3);

vsync <= not vpulse(11);
vactive <= vfp(11) and (not v(11));
y <= v(10 downto 3);

h_clk <= clk;
h_drive: process(reset, h_clk)
begin
	if (reset = '1') then
		--hfp <= X"00F";
		hfp <= (others => '0');
	else
		if (rising_edge(h_clk)) then
			--index <= color_index;
			if (hfp = X"00F") then
				hpulse <= X"FA0"; -- -96
				h <= X"F70";		-- -(96 + 48)
				hfp <= X"CF0";		-- 16 - 800
			else
				hpulse <= std_logic_vector(unsigned(hpulse) + 1);
				h <= std_logic_vector(unsigned(h) + 1);
				hfp <= std_logic_vector(unsigned(hfp) + 1);
			end if;
			--color <= palette(to_integer(unsigned(color_index)));
			color_index <= win & win_color & pixel;
		end if;
		-- prevent any change outside of pixel periods
		--if (falling_edge(h_clk)) then
			--if (win = '1') then
			--	color <= palette_win(to_integer(unsigned('1' & pixel_win)));
			--else
			--	color <= palette_tty(to_integer(unsigned(')));
			--end if;
			--color <= palette(to_integer(unsigned(color_index)));
		--end if;
	end if;
end process;

v_clk <= hfp(11); -- generate pulse at the end of horizontal line
v_drive: process(reset, v_clk)
begin
	if (reset = '1') then
		--vfp <= X"009";
		vfp <= (others => '0');
	else
		if (rising_edge(v_clk)) then
			if (vfp = X"009") then
				vpulse <= X"FFE"; 	-- -2
				v <= X"FDD";			-- -(2 + 33)
				vfp <= X"DFD";			-- 10 - 525
			else
				vpulse <= std_logic_vector(unsigned(vpulse) + 1);
				v <= std_logic_vector(unsigned(v) + 1);
				vfp <= std_logic_vector(unsigned(vfp) + 1);
			end if;
		end if;
	end if;
end process;

reverse <= mem_char(7) xor (cursor_enable and ((cursor_type and v(2) and v(1)) or (not cursor_type)));
a <= reverse & mem_char(6 downto 0) when (win = '0') else win_char;

chargen: chargen_rom port map (
		a(10 downto 3) => a,					-- 256 chars (128 duplicated, upper 128 reversed)
		a(2 downto 0) => v(2 downto 0),	-- 8 rows per char
		h => h(2 downto 0),
		pixel => pixel
	);
	
color <= palette(to_integer(unsigned(color_index)));

end Behavioral;

