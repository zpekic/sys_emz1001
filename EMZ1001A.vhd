----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:27:39 11/25/2022 
-- Design Name: 
-- Module Name:    EMZ1001A - Behavioral 
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

entity EMZ1001A is
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
end EMZ1001A;

architecture Behavioral of EMZ1001A is

type mem64x4 is array(0 to 63) of std_logic_vector(3 downto 0);

-- programming model accessible registers
signal mr_mem: mem64x4 := (others => X"0");


-- non-accessible internal registers
signal t: std_logic_vector(3 downto 0);
alias t1: std_logic is t(0);
alias t3: std_logic is t(1);
alias t5: std_logic is t(2);
alias t7: std_logic is t(3);

signal pc: std_logic_vector(12 downto 0);
constant bank0: mem1k8 := firmware;

-- other
signal dbg_int: std_logic_vector(3 downto 0);

begin

-- select debug outputs
dbg_mem <= mr_mem(to_integer(unsigned(dbg_sel)));

with dbg_sel(5 downto 4) select dbg_reg <=
	'0' & pc(12 downto 10) when "00",-- show as octal (bank)
	pc(9 downto 6) when "01",			-- show as hex	(page)
	'0' & pc(5 downto 3) when "10",	-- show as octal	(within a page)
	dbg_int when others;
	
with dbg_sel(3 downto 0) select dbg_int <=
	'0' & pc(2 downto 0) when X"F",	-- show as octal	(within a page)
	-- TODO add other internal regs here!
	t when others;

A <= pc;
D <= bank0(to_integer(unsigned(pc(9 downto 0))));
--

-- temporary t
on_clk: process(CLK, nPOR)
begin
	if (nPOR = '0') then
		t <= "0001";
		pc <= (others => '0');
	else
		if (falling_edge(CLK)) then
			t <= t(2 downto 0) & t(3); -- one hot ring counter
			pc <= std_logic_vector(unsigned(pc) + 1);
		end if;
	end if;
end process;


end Behavioral;

