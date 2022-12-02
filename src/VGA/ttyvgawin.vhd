----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:53:13 11/12/2022 
-- Design Name: 
-- Module Name:    ttyvgawin - Behavioral 
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
use work.emz1001_package.all;

entity ttyvgawin is
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
			  win_color: in STD_LOGIC;
           win_char : in  STD_LOGIC_VECTOR (7 downto 0);
           tty_send : in  STD_LOGIC;
           tty_char : in  STD_LOGIC_VECTOR (7 downto 0);
           tty_sent : out  STD_LOGIC;
			  
			  -- not part of real device, used for debugging
           debug : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end ttyvgawin;

architecture Behavioral of ttyvgawin is

component mwvga is
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
end component;

component tty_screen is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  enable: in STD_LOGIC;
			  ---
           char : in  STD_LOGIC_VECTOR (7 downto 0);
			  char_sent: out STD_LOGIC;
			  ---
			  maxRow: in STD_LOGIC_VECTOR (7 downto 0);
			  maxCol: in STD_LOGIC_VECTOR (7 downto 0);
           mrd : out  STD_LOGIC;
           mwr : out  STD_LOGIC;
           x : out  STD_LOGIC_VECTOR (7 downto 0);
           y : out  STD_LOGIC_VECTOR (7 downto 0);
			  mready: in STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
			  
			  -- not part of real device, used for debugging
           debug : out  STD_LOGIC_VECTOR (31 downto 0)
          );
end component;

signal hactive, vactive, vga_active: std_logic;
signal tty_cell, vga_cell: std_logic_vector(15 downto 0);
signal cur_x, cur_y, cursor_enable: std_logic;
signal vram_dout, tty_dout: std_logic_vector(7 downto 0);
signal tty_wr, tty_rd: std_logic;

signal vram_a, vga_a, tty_a: std_logic_vector(10 downto 0);
signal mem: std_logic;
signal mem_char: std_logic_vector(7 downto 0);
signal mem_row, mem_col: std_logic_vector(7 downto 0);
signal vram: mem2k8 := (others => c(' '));	-- initialize video RAM with space

signal char: std_logic_vector(7 downto 0);
signal char_clk, char_is_zero, char_sent: std_logic;

begin

row <= vga_cell(15 downto 8);
col <= vga_cell(7 downto 0);
-- across whole 640*480 (80*60)
vga_active <= hactive and vactive;

-- vram address generated by VGA and TTY
tty_a <= tty_cell(12 downto 8) & tty_cell(5 downto 0);
vga_a <= std_logic_vector(unsigned(vga_cell(12 downto 8)) - 14) & std_logic_vector(unsigned(vga_cell(5 downto 0)) - 8);

-- 2k video RAM read and write
vram_a <= tty_a when ((tty_rd or tty_wr) = '1') else vga_a;
--vram_a <= tty_a when (mem = '0') else vga_a;
vram_dout <= vram(to_integer(unsigned(vram_a)));

on_tty_clk: process(tty_clk, tty_wr, tty_dout, vram_a)
begin
	if (rising_edge(tty_clk) and (tty_wr = '1')) then
--		vram(to_integer(unsigned(tty_a))) <= tty_dout;
		vram(to_integer(unsigned(vram_a))) <= tty_dout;
	end if;
end process;

-- to minimize video RAM, only show center 64*32
-- show 16*16 window with top, left at screen center
mem_row <= std_logic_vector(unsigned(vga_cell(15 downto 8)) - 14);
mem_col <= std_logic_vector(unsigned(vga_cell(7 downto 0)) - 8);
mem <= not (mem_row(7) or mem_row(6) or mem_row(5) or mem_col(7) or mem_col(6));

-- give VGA either vram content (if in 64*16 window), or a space
mem_char <= vram_dout when (mem = '1') else (X"0" & vga_cell(9 downto 8) & vga_cell(1 downto 0));

-- cursor is active if VGA row, col coincide with TTY ones
cur_x <= '1' when (mem_col = tty_cell(7 downto 0)) else '0';
cur_y <= '1' when (mem_row = tty_cell(15 downto 8)) else '0';
cursor_enable <= cur_clk and cur_x and cur_y;

vga: mwvga Port map (
		reset => reset,
		clk => vga_clk,
		mem_char => mem_char,
		win_char => win_char,
		win => win,
		win_color => win_color,
		hactive => hactive,
		vactive => vactive,
		x => vga_cell(7 downto 0),
		y => vga_cell(15 downto 8),
		cursor_enable => cursor_enable,
		cursor_type => '0',	-- full block 
		-- VGA connections
		color => color,
		hsync => hsync,
		vsync => vsync
		);

tty_sent <= char_sent;	-- TODO, remove?
char_is_zero <= '1' when (char = X"00") else '0';
char_clk <= tty_send when (char_is_zero = '1') else char_sent; 

on_char_clk: process(char_clk, reset, tty_char)
begin
	if (reset = '1') then
		char <= X"00";
	else
		if (rising_edge(char_clk)) then
			if (char_is_zero = '1') then
				char <= tty_char;
			else
				char <= X"00";
			end if;
		end if;
	end if;
end process;

tty: tty_screen Port map (
		clk => tty_clk,
		reset  => reset,
		enable => '1',
		---
		char => char,
		char_sent => char_sent,
		---
		maxRow => X"20",	-- 32
		maxCol => X"40",	-- 64
		mrd => tty_rd,
		mwr => tty_wr,
		x => tty_cell(7 downto 0),
		y => tty_cell(15 downto 8),
		mready => '1',
		din => vram_dout,
		dout => tty_dout,

		-- not part of real device, used for debugging
		debug => debug
      );

end Behavioral;

