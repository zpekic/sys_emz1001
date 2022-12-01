--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
use work.fibonacci_code.all;

package emz1001_package is

constant char_zero: std_logic_vector(7 downto 0) := X"00";
constant char_lf: std_logic_vector(7 downto 0) := X"0A";
constant char_cr: std_logic_vector(7 downto 0) := X"0D";

impure function c(char: in character) return std_logic_vector;
impure function i(char: in character) return std_logic_vector;

type mem1k8 is array(0 to 1023) of std_logic_vector(7 downto 0);
type mem2k8 is array(0 to 2047) of std_logic_vector(7 downto 0);
type mem256x8 is array(0 to 255) of std_logic_vector(7 downto 0);
type mem64x12 is array(0 to 63) of std_logic_vector(11 downto 0);
type mem4x10 is array(0 to 3) of std_logic_vector(9 downto 0);
type mem4x14 is array(0 to 3) of std_logic_vector(13 downto 0);

impure function firmware return mem1k8;

type mem16x8 is array(0 to 15) of std_logic_vector(7 downto 0);
constant hex2ascii: mem16x8 := (
	c('0'),
	c('1'),
	c('2'),
	c('3'),
	c('4'),
	c('5'),
	c('6'),
	c('7'),
	c('8'),
	c('9'),
	c('A'),
	c('B'),
	c('C'),
	c('D'),
	c('E'),
	c('F')
);

type mem16x16 is array (0 to 15) of std_logic_vector(15 downto 0);
constant decode4to16: mem16x16 := (
	"0000000000000001",
	"0000000000000010",
	"0000000000000100",
	"0000000000001000",
	"0000000000010000",
	"0000000000100000",
	"0000000001000000",
	"0000000010000000",
	"0000000100000000",
	"0000001000000000",
	"0000010000000000",
	"0000100000000000",
	"0001000000000000",
	"0010000000000000",
	"0100000000000000",
	"1000000000000000"
);


	
-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

end emz1001_package;

package body emz1001_package is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
impure function c(char: in character) return std_logic_vector is
begin
	return std_logic_vector(to_unsigned(natural(character'pos(char)), 8));
end c;
 
impure function i(char: in character) return std_logic_vector is
begin
	return X"80" xor c(char);
end i;

impure function firmware return mem1k8 is
variable temp: mem1k8;
begin
	assert true report "FIRMWARE: start initializing" severity note;
	for i in 0 to 1023 loop
		temp(i) := emz_microcode(i);
	end loop;
	assert true report "FIRMWARE: done initializing" severity note;

	return temp;
end firmware;

end emz1001_package;
