----------------------------------------------------------------------------------
-- Company:  		https://hackaday.io/projects/hacker/233652
-- Engineer: 		zpekic@hotmail.com
---------------------------------------------------------------------------------- 
-- Create Date:    12:27:39 11/25/2022 
-- Design Name:    Iskra 
-- Module Name:    EMZ1001A - Behavioral 
-- Project Name:   https://github.com/zpekic/sys_emz1001
-- Target Devices: Any standard FPGA
-- Tool versions:  Xilinx ISE 14.7 (last free)
-- Description:    EMZ1001 series was the only microcontroller designed and produced in 
--						 ex-Yugoslavia. It was a co-production with AMI (known as S2000)
-- 					 https://hackaday.io/project/188614-iskra-emz1001a-a-virtual-resurrection
-- Dependencies: 	 Standard VHDL libraries only
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
-- https://hackaday.io/project/188614-iskra-emz1001a-a-virtual-resurrection/log/214193-emz1001a-implementation-in-vhdl
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

-- PLA constants
constant skp_0: std_logic_vector(3 downto 0) := X"0";
constant skp_1: std_logic_vector(3 downto 0) := X"1";
constant skp_sec: std_logic_vector(3 downto 0) := X"2";
constant skp_ble: std_logic_vector(3 downto 0) := X"3";
constant skp_cy0: std_logic_vector(3 downto 0) := X"4";
constant skp_cout: std_logic_vector(3 downto 0) := X"5";
constant skp_am: std_logic_vector(3 downto 0) := X"6";
constant skp_bit: std_logic_vector(3 downto 0) := X"7";
constant skp_blf: std_logic_vector(3 downto 0) := X"8";
constant skp_bl0: std_logic_vector(3 downto 0) := X"9";
constant skp_xa: std_logic_vector(3 downto 0) := X"a";
constant skp_xb: std_logic_vector(3 downto 0) := X"b";
constant skp_ik: std_logic_vector(3 downto 0) := X"c";
constant skp_skp: std_logic_vector(3 downto 0) := X"d";
constant skp_f1: std_logic_vector(3 downto 0) := X"e";
constant skp_f2: std_logic_vector(3 downto 0) := X"f";

constant alu_nop: std_logic_vector(2 downto 0) := O"0";
constant alu_add: std_logic_vector(2 downto 0) := O"1";
constant alu_adcs: std_logic_vector(2 downto 0) := O"2";
constant alu_adis: std_logic_vector(2 downto 0) := O"3";
constant alu_and: std_logic_vector(2 downto 0) := O"4";
constant alu_xor: std_logic_vector(2 downto 0) := O"5";
constant alu_cma: std_logic_vector(2 downto 0) := O"6";
constant alu_cry: std_logic_vector(2 downto 0) := O"7";

constant opr_nop: std_logic_vector(4 downto 0) := '0' & X"0";
constant opr_brk: std_logic_vector(4 downto 0) := '0' & X"1";
constant opr_ret: std_logic_vector(4 downto 0) := '0' & X"2";
constant opr_sos: std_logic_vector(4 downto 0) := '0' & X"3";
constant opr_psx: std_logic_vector(4 downto 0) := '0' & X"4";
constant opr_lae: std_logic_vector(4 downto 0) := '0' & X"5";	
constant opr_alu: std_logic_vector(4 downto 0) := '0' & X"6";
constant opr_xae: std_logic_vector(4 downto 0) := '0' & X"7";
constant opr_inp: std_logic_vector(4 downto 0) := '0' & X"8";
constant opr_eur: std_logic_vector(4 downto 0) := '0' & X"9";
constant opr_dsb: std_logic_vector(4 downto 0) := '0' & X"a";
constant opr_dsn: std_logic_vector(4 downto 0) := '0' & X"b";
constant opr_out: std_logic_vector(4 downto 0) := '0' & X"c";
constant opr_xab: std_logic_vector(4 downto 0) := '0' & X"d";
constant opr_jms: std_logic_vector(4 downto 0) := '0' & X"e";
constant opr_jmp: std_logic_vector(4 downto 0) := '0' & X"f";
constant opr_lab: std_logic_vector(4 downto 0) := '1' & X"0";
constant opr_sfx: std_logic_vector(4 downto 0) := '1' & X"1";
constant opr_xc0: std_logic_vector(4 downto 0) := '1' & X"2";
constant opr_xci: std_logic_vector(4 downto 0) := '1' & X"3";
constant opr_xcd: std_logic_vector(4 downto 0) := '1' & X"4";
constant opr_lam: std_logic_vector(4 downto 0) := '1' & X"5";
constant opr_xbu: std_logic_vector(4 downto 0) := '1' & X"6";
constant opr_mvs: std_logic_vector(4 downto 0) := '1' & X"7";
constant opr_stm: std_logic_vector(4 downto 0) := '1' & X"8";
constant opr_rsm: std_logic_vector(4 downto 0) := '1' & X"9";
constant opr_lbf: std_logic_vector(4 downto 0) := '1' & X"a";
constant opr_lbe: std_logic_vector(4 downto 0) := '1' & X"b";
constant opr_lbz: std_logic_vector(4 downto 0) := '1' & X"c";
constant opr_lbp: std_logic_vector(4 downto 0) := '1' & X"d";
constant opr_lai: std_logic_vector(4 downto 0) := '1' & X"e";
constant opr_spp: std_logic_vector(4 downto 0) := '1' & X"f";

-- PLA for instruction decode, codes 0x00 .. 0x3F
constant pla_00: mem64x12 := (
skp_0 & alu_nop & opr_nop,	-- NOP
skp_0 & alu_nop & opr_brk,	-- BRK
skp_0 & alu_nop & opr_ret,	--	RT
skp_1 & alu_nop & opr_ret,	-- RTS
skp_0 & alu_nop & opr_psx,	-- PSH
skp_0 & alu_nop & opr_psx,	-- PSL
skp_0 & alu_and & opr_alu,	-- AND
skp_sec & alu_nop & opr_sos,	-- SOS
skp_ble & alu_nop & opr_nop,	-- SBE
skp_cy0 & alu_nop & opr_nop,	-- SZC
skp_0 & alu_cry & opr_alu,	-- STC
skp_0 & alu_cry & opr_alu,	-- RSC
skp_0 & alu_nop & opr_lae,	-- LAE
skp_0 & alu_nop & opr_xae,	-- XAE
skp_0 & alu_nop & opr_inp,	-- INP
skp_0 & alu_nop & opr_eur,	-- EUR
skp_0 & alu_cma & opr_alu,	-- CMA
skp_0 & alu_nop & opr_xbu,	-- XABU
skp_0 & alu_nop & opr_lab,	-- LAB
skp_0 & alu_nop & opr_xab,	-- XAB
skp_cout & alu_adcs & opr_alu,	-- ADCS 
skp_0 & alu_xor & opr_alu,	-- XOR
skp_0 & alu_add & opr_alu,	-- ADD
skp_am & alu_nop & opr_nop,	-- SAM
skp_0 & alu_nop & opr_dsb,	-- DISB
skp_0 & alu_nop & opr_mvs,	-- MVS
skp_0 & alu_nop & opr_out,	-- OUT
skp_0 & alu_nop & opr_dsn,	-- DISN
skp_bit & alu_nop & opr_nop,	-- SZM
skp_bit & alu_nop & opr_nop,	-- SZM
skp_bit & alu_nop & opr_nop,	-- SZM
skp_bit & alu_nop & opr_nop,	-- SZM
skp_0 & alu_nop & opr_stm,	-- STM
skp_0 & alu_nop & opr_stm,	-- STM
skp_0 & alu_nop & opr_stm,	-- STM
skp_0 & alu_nop & opr_stm,	-- STM
skp_0 & alu_nop & opr_rsm,	-- RSM
skp_0 & alu_nop & opr_rsm,	-- RSM
skp_0 & alu_nop & opr_rsm,	-- RSM
skp_0 & alu_nop & opr_rsm,	-- RSM
skp_ik & alu_nop & opr_nop,	-- SZK
skp_ik & alu_nop & opr_nop,	-- SZI
skp_0 & alu_nop & opr_sfx,	-- RF1
skp_0 & alu_nop & opr_sfx,	-- SF1
skp_0 & alu_nop & opr_sfx,	-- RF2
skp_0 & alu_nop & opr_sfx,	-- SF2
skp_f1 & alu_nop & opr_nop,	-- TF1
skp_f2 & alu_nop & opr_nop,	-- TF2
skp_blf & alu_nop & opr_xci,	-- XCI
skp_blf & alu_nop & opr_xci,	-- XCI
skp_blf & alu_nop & opr_xci,	-- XCI
skp_blf & alu_nop & opr_xci,	-- XCI
skp_bl0 & alu_nop & opr_xcd,	-- XCD
skp_bl0 & alu_nop & opr_xcd,	-- XCD
skp_bl0 & alu_nop & opr_xcd,	-- XCD
skp_bl0 & alu_nop & opr_xcd,	-- XCD
skp_0 & alu_nop & opr_xc0,	-- XC
skp_0 & alu_nop & opr_xc0,	-- XC
skp_0 & alu_nop & opr_xc0,	-- XC
skp_0 & alu_nop & opr_xc0,	-- XC
skp_0 & alu_nop & opr_lam,	-- LAM
skp_0 & alu_nop & opr_lam,	-- LAM
skp_0 & alu_nop & opr_lam,	-- LAM
skp_0 & alu_nop & opr_lam 	-- LAM
);



-- PLA for instruction decode, codes 0x40 .. 0x7F
constant pla_01: mem64x12 := (
skp_0 & alu_nop & opr_lbz,	-- LBZ
skp_0 & alu_nop & opr_lbz,	-- LBZ
skp_0 & alu_nop & opr_lbz,	-- LBZ
skp_0 & alu_nop & opr_lbz,	-- LBZ
skp_0 & alu_nop & opr_lbf,	-- LBF
skp_0 & alu_nop & opr_lbf,	-- LBF
skp_0 & alu_nop & opr_lbf,	-- LBF
skp_0 & alu_nop & opr_lbf,	-- LBF
skp_0 & alu_nop & opr_lbe,	-- LBE
skp_0 & alu_nop & opr_lbe,	-- LBE
skp_0 & alu_nop & opr_lbe,	-- LBE
skp_0 & alu_nop & opr_lbe,	-- LBE
skp_0 & alu_nop & opr_lbp,	-- LBEP
skp_0 & alu_nop & opr_lbp,	-- LBEP
skp_0 & alu_nop & opr_lbp,	-- LBEP
skp_0 & alu_nop & opr_lbp,	-- LBEP
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_cout & alu_adis & opr_alu,	-- ADIS
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_skp & alu_nop & opr_spp,	-- PP
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai,	-- LAI
skp_0 & alu_nop & opr_lai	-- LAI
); 

-- used for PSH (OR, non-inverted) and PSL (AND, inverted)
constant psx_mask: mem16x40 := (
	X"1F" & "11111111111111100000000000000001",
	X"20" & "11111111111111010000000000000010",
	X"31" & "11111111111110110000000000000100",
	X"42" & "11111111111101110000000000001000",
	X"53" & "11111111111011110000000000010000",
	X"64" & "11111111110111110000000000100000",
	X"75" & "11111111101111110000000001000000",
	X"86" & "11111111011111110000000010000000",
	X"97" & "11111110111111110000000100000000",
	X"A8" & "11111101111111110000001000000000",
	X"B9" & "11111011111111110000010000000000",
	X"CA" & "11110111111111110000100000000000",
	X"DB" & "11101111111111110001000000000000",
	X"EC" & "11011111111111110010000000000000",
	X"FD" & "10111111111111110100000000000000",
	X"0E" & "00000000000000001111111111111111"	-- set (or clear) all bits
);

-- seven segment pattern for DISN instruction
constant sevseg: mem16x8 := (
	"01111110",	-- 0
	"00110000",	-- 1
	"01101101",	-- 2
	"01111001",	-- 3
	"00110011",	-- 4
	"01011011",	-- 5
	"01011111",	-- 6
	"01110000",	-- 7
	"01111111",	-- 8
	"01111011",	-- 9
	"01110111",	-- A
	"00011111",	-- B
	"01001110",	-- C
	"00111101",	-- d
	"01001111",	-- E
	"01000111"	-- F
);

--constant incdec: mem16x8 := (
--	X"1F",
--	X"20",
--	X"31",
--	X"42",
--	X"53",
--	X"64",
--	X"75",
--	X"86",
--	X"97",
--	X"A8",
--	X"B9",
--	X"CA",
--	X"DB",
--	X"EC",
--	X"FD",
--	X"0E"
--);

-- EUR lookup
constant eur_lookup: mem4x14 := (
	O"73" & X"FF",	-- 00	60Hz, inverting
	O"73" & X"00",	-- 01 60Hz, not inverting (power-up default)
	O"61" & X"FF",	-- 10	50Hz, inverting
	O"61" & X"00"	-- 11 50Hz, not inverting
);

-- 4 phase timing clock
signal t: std_logic_vector(3 downto 0);
alias t1: std_logic is t(0);
alias t3: std_logic is t(1);
alias t5: std_logic is t(2);
alias t7: std_logic is t(3);

-- non-accessible internal registers
signal ir_skp, ir_run, ir_lai, ir_lbx: std_logic;
signal ir_slave: std_logic_vector(12 downto 0);	-- only 13 bits go to A outputs
signal ir_dout: std_logic_vector(7 downto 0);
signal ir_k, ir_i: std_logic_vector(3 downto 0); 
signal ir_mask: std_logic_vector(3 downto 0); -- inverted before loading! 
signal ir_bank: std_logic_vector(2 downto 0); -- one of 8 1k banks

signal ir_eur:	std_logic_vector(1 downto 0);		-- middle 2-bits from A are ignored
signal ir_sec: std_logic:= '1';	-- set when 1 second expires
signal ir_cnt: std_logic_vector(5 downto 0);		-- counts to 50 or 60, so 6 bits are enough

-- captures ROMS state when SYNC is low and high
-- 00 ROMS tied low			-- internal ROM for bank 0, external for banks 1 .. 7
-- 01	ROMS tied to SYNC		-- always external ROM, regardless of the bank
-- 10	ROMS tied to /SYNC 	-- test mode (not implemented)
-- 11	ROMS tied to high		-- always internal ROM, regardless of the bank
signal ir_roms: std_logic_vector(1 downto 0);
signal ir_introm: std_logic;
signal introm: std_logic_vector(7 downto 0);	-- internal ROM value addressed by PC
signal readexternal, readdata: std_logic;

-- program control
signal ir_stack : mem4x10;
signal ir_sp: std_logic_vector(1 downto 0);		-- 4 deep level stack (1 more than original, yay!)
signal ir_pp: std_logic_vector(1 downto 0);		-- indicates if page/bank has been set up by PP instruction
signal ir_newpage: std_logic_vector(3 downto 0);	-- new page initialized by PP
signal ir_newbank: std_logic_vector(3 downto 0);	-- new bank initialized by PP (bit3 ignored)

signal ir_current: std_logic_vector(7 downto 0);
alias ir_target: std_logic_vector(5 downto 0) is ir_current(5 downto 0); -- 6-bit branch target for JMS, JMP

-- programming model accessible registers
signal mr_ram: mem64x4 := (others => X"F");
signal mr_bl, mr_a, mr_e: std_logic_vector(3 downto 0);
signal mr_bu: std_logic_vector(1 downto 0);
signal mr_cy, mr_f1, mr_f2: std_logic;

signal mr_master: std_logic_vector(15 downto 0); 		-- MSB ignored, then 2 control, 13 may go to ir_slave
alias mr_d_driven: std_logic is mr_master(14);			-- 0: FLOAT mode on reset
alias mr_a_multiplexed: std_logic is mr_master(13);	-- 0: STATIC mode on reset

-- other
signal pc: std_logic_vector(9 downto 0);	-- covers lower 10 bits (1k bank)
alias page: std_logic_vector(3 downto 0) is pc(9 downto 6);
signal ram: std_logic_vector(3 downto 0);	-- represents currently selected RAM cell
signal ram_addr: std_logic_vector(5 downto 0);
signal y_alu: std_logic_vector(5 downto 0);	-- 6-bit ALU output
signal y_skp: std_logic;
signal bl_equals_e, a_equals_m, bit_is_1: std_logic;
signal ik: std_logic_vector(3 downto 0);
signal disn_out, disb_out, dout: std_logic_vector(7 downto 0);
signal skp_mask, mask8: std_logic_vector(7 downto 0);
signal out_exe, sos_clr: std_logic;
signal bu_xor: std_logic_vector(1 downto 0);

alias i_clk: std_logic is I(3);	-- assume I3 is hooked up to 50/60Hz mains frequency

signal psx: std_logic_vector(39 downto 0);
alias psx_ormask: std_logic_vector(15 downto 0) is psx(15 downto 0);
alias psx_andmask: std_logic_vector(15 downto 0) is psx(31 downto 16);
alias bl_dec: std_logic_vector(3 downto 0) is psx(35 downto 32);
alias bl_inc: std_logic_vector(3 downto 0) is psx(39 downto 36); 
alias bl_is_0: std_logic is psx(0);
alias bl_is_13: std_logic is psx(13);
alias bl_is_15: std_logic is psx(15);

signal eur: std_logic_vector(13 downto 0);	-- combines mains counter limit with xor mask
alias eur_invert: std_logic_vector(7 downto 0) is eur(7 downto 0);	-- for XOR of DISP, DISN outputs
alias eur_limit: std_logic_vector(5 downto 0) is eur(13 downto 8);	-- to count toward 1s 

signal sp_incdec: std_logic_vector(3 downto 0);
alias sp_inc: std_logic_vector(1 downto 0) is sp_incdec(3 downto 2);	-- 4 values, 2 bits
alias sp_dec: std_logic_vector(1 downto 0) is sp_incdec(1 downto 0);

-- instruction decode
signal pla: std_logic_vector(11 downto 0);
alias skp: std_logic_vector(3 downto 0) is pla(11 downto 8);
alias alu: std_logic_vector(2 downto 0) is pla(7 downto 5);
alias opr: std_logic_vector(4 downto 0) is pla(4 downto 0);

-- debug
signal dbg_hi, dbg_lo: std_logic_vector(3 downto 0);

begin

-- 1k of internal ROM contains the "Hello world!" program
firmware: rom1k generic map(
		filename => "..\prog\helloworld_code.hex",
		default_value => nop
	)	
	port map(
		D => introm,
		A => pc,
		nOE => '0'
	);

-- SYNC is low at T1 and T3, high at T5 and T7
SYNC <= t5 or t7; 

-- STATUS is a 4 to 1 mux
STATUS <= (t1 and (not mr_d_driven)) or (t3 and bl_is_13) or (t5 and mr_cy) or (t7 and ir_skp);

-- nEXT goes low when executing OUT during T7
nEXTERNAL <= not(t7 and out_exe); 
out_exe <= ir_run when (opr = opr_out) else '0';

-- decide if internal or external ROM is used
with ir_roms select ir_introm <= 
	not(ir_bank(2) or ir_bank(1) or ir_bank(0))	when "00", -- LOW, internal for bank0, external for others 
	'0' 														when "01", -- SYNC, always external
	'1' 														when "10", -- /SYNC, not implemented test mode, assume "internal"
	'1' 														when others; -- HI, always internal
	
-- determine A, D state when SYNC is low
readexternal <= (mr_a_multiplexed or (not ir_introm)) when ((t1 or t3) = '1') else '0';	

-- D is either floating, or driven from internal dout
readdata <= (not mr_d_driven) when ((t5 or t7) = '1') else '0';
D <= "ZZZZZZZZ" when ((readexternal or readdata) = '1') else dout;
 
-- internal dout is RAM & A when execution OUT instruction, or output latch otherwise
dout <= (ram & mr_a) when (out_exe = '1') else ir_dout;

-- A is either program address of output latch
A <= (ir_bank & pc) when (readexternal = '1') else ir_slave;

-- constant values set by EUR
eur <= eur_lookup(to_integer(unsigned(ir_eur)));

-- 1 second timer logic
sos_clr <= (ir_run and ir_sec and t7) when (opr = opr_sos) else '0';

on_i_clk: process(nPOR, i_clk, sos_clr)
begin
	if ((nPOR = '0') or (sos_clr = '1')) then
		ir_sec <= '0';
		if (nPOR = '0') then
			ir_cnt <= (others => '0');
		end if;
	else
		if (rising_edge(i_clk)) then
			if (ir_cnt = eur_limit) then	-- if 50 or 60 reached
				ir_cnt <= (others => '0');	-- reset counter
				ir_sec <= '1';					-- set 1 second flag
			else
				ir_cnt <= std_logic_vector(unsigned(ir_cnt) + 1);
			end if;
		end if;
	end if;
end process;

-- prepare mask for PSL/PSH
psx <= psx_mask(to_integer(unsigned(mr_bl)));

-- mask for STM (upper nibble) and RSM (lower nibble) 
with ir_current(1 downto 0) select mask8 <=
	"00011110" when "00",
	"00101101" when "01",
	"01001011" when "10",
	"10000111" when others;

-- when skip flag is set, force a NOP to be loaded into instruction register
skp_mask <= X"00" when (ir_skp = '1') else X"FF";

-- prepare output data for DISN and DISB
disn_out <= eur_invert xor (mr_cy & sevseg(to_integer(unsigned(mr_a)))(6 downto 0));	-- combine carry with lower 7 bits of 7seg lookup
disb_out <= eur_invert xor (ram & mr_a);																-- combine RAM and A

with ir_sp select sp_incdec <=
	"0111" when "00",
	"1000" when "01",
	"1101" when "10",
	"0010" when others;

-- and a few xors
bu_xor <= mr_bu xor (ir_current(1 downto 0) xor "11");

-- instruction decode (256 op-codes split into 4*64 blocks)
with ir_current(7 downto 6) select pla <=
	pla_00(to_integer(unsigned(ir_current(5 downto 0)))) when "00", -- NOP to LAM
	pla_01(to_integer(unsigned(ir_current(5 downto 0)))) when "01", -- LBZ to LAI
	skp_0 & alu_nop & opr_jms when "10",	-- JMS
	skp_0 & alu_nop & opr_jmp when others;	-- JMP

-- RAM is pointed by BU and BL
ram_addr <= mr_bu & mr_bl;
ram <= mr_ram(to_integer(unsigned(ram_addr)));

-- PC is pointed by the stack pointer
pc <= ir_stack(to_integer(unsigned(ir_sp)));

-- terribly non-optimal 6-bit wide ALU (carry-in + 4 bits + carry-out)
with alu select y_alu <=
		mr_cy & (mr_a xor X"F") & '0' 	when alu_cma,
		mr_cy & (mr_a and ram) & '0' 		when alu_and,
		mr_cy & (mr_a xor ram) & '0' 		when alu_xor,
		std_logic_vector(unsigned('0' & mr_a & mr_cy) + unsigned('0' & ram & mr_cy)) 		when alu_adcs,
		std_logic_vector(unsigned('0' & mr_a & '0') + unsigned('0' & ir_current(3 downto 0) & '0')) 	when alu_adis,
		mr_cy & std_logic_vector(unsigned(mr_a & '0') + unsigned(ram & '0')) 							when alu_add,
		not(ir_current(0)) & mr_a & '0'	when alu_cry,	-- passthrough to set carry flag
		mr_cy & mr_a & '0' 					when others;

-- select source for updated skip flag (16 to 1 mux)
with skp select y_skp <=
--		'0' 	when skp_0,	-- never skip next instruction
		'1' 	when skp_1,	-- always skip next instruction
		ir_sec  when skp_sec,
		bl_equals_e when skp_ble,
		(not mr_cy) when skp_cy0,
		(not y_alu(5)) when skp_cout,
		a_equals_m when skp_am,
		(not bit_is_1) when skp_bit,	
		bl_is_15 when skp_blf,
		bl_is_0 when skp_bl0, 
		not(ik(3) or ik(2) or ik(1) or ik(0)) when skp_ik,	-- at least 1 zero detected in I or K after masking	
		ir_skp when skp_skp,	-- do not change skip flag, pass it to next instruction
		mr_f1 when skp_f1,
		mr_f2 when skp_f2,
		'0' when others;		-- no skip by default

-- conditions for skips
bl_equals_e <= '1' when (mr_bl = mr_e) else '0';
a_equals_m <= '1' when (mr_a = ram) else '0';

-- SZM
with ir_current(1 downto 0) select bit_is_1 <=
	ram(0) when "00",
	ram(1) when "01",
	ram(2) when "10",
	ram(3) when others;

-- SZK and SZI 
with ir_current(0) select ik <= 
	(ir_k and ir_mask) when '0', 		-- SZK 0x28
	(ir_i and ir_mask) when others; 	-- SZI 0x29
	
-- most action happens on clock falling edge
on_clk_down: process(CLK, nPOR)
begin
	if (nPOR = '0') then
		-- one hot ring counter will start at T1
		t <= "0001";
		-- initialize some regs
		ir_roms <= "00";	-- assume internal ROM
		ir_lai <= '1';		-- this is why first instruction should not be LAI
		ir_lbx <= '1'; 	-- this is why first instruction should not be LBE, LBEP, LBF, LBZ
		ir_eur <= "01";	-- 60Hz, normal polarity
		mr_master <= (others => '0');	-- static operation, float D lines
		ir_current <= nop;	-- prevent stray instruction
		ir_skp <= '0';			-- prevent stray skip
		-- start at bank 0, page 0, location 0
		ir_pp <= "00";						-- no pages set
		ir_bank <= "000";					-- start at bank 0 (usually internal firmware)
		ir_sp <= "00";						-- stack pointer
		ir_stack(0) <= (others => '0');
	else
		if (falling_edge(CLK)) then
			t <= t(2 downto 0) & t(3); -- one hot ring counter
			if (t1 = '1') then
				-- capture in the middle of SYNC low
				ir_roms(1) <= ROMS;
				-- no other stuff happening in T1
			end if;
			-- capture in the middle of SYNC high
			ir_roms(0) <= (ROMS and t5) or (ir_roms(0) and (not t5));
			-- run FF was set at rising edge turing T3 so we have it for T3, T5, T7
			if (ir_run = '1') then
				if (t3 = '1') then
				-- T3: regardless of skip, load instruction register
					if (ir_introm = '1') then
						-- fetch from bank0 which is inside the chip
						ir_current <= skp_mask and introm;
					else
						-- fetch from any bank, outside of the chip
						ir_current <= skp_mask and D;
					end if;
				end if;
				if (t5 = '1') then
				-- T5: increment PC (page and location at current stack level)
					ir_stack(to_integer(unsigned(ir_sp))) <= std_logic_vector(unsigned(pc) + 1);
				-- update skip flag based on the currectly executed instruction
					ir_skp <= y_skp; 
				-- T5: execution of most instructions happens here (if not skipped)
					case opr is
						when opr_lai =>
							ir_lbx <= '0';
							if (ir_lai = '0') then	-- only execute if previous was not LAI
								mr_a <= ir_current(3 downto 0);
								ir_mask <= ir_current(3 downto 0);
								ir_lai <= '1';
							end if;
						when opr_lbf =>	-- LBF
							ir_lai <= '0';
							if (ir_lbx = '0') then	-- only execute if previous was not 
								mr_bl <= X"F";
								mr_bu <= ir_current(1 downto 0);
								ir_lbx <= '1';
							end if;
						when opr_lbe =>	-- LBE
							ir_lai <= '0';
							if (ir_lbx = '0') then	-- only execute if previous was not 
								mr_bl <= mr_e;
								mr_bu <= ir_current(1 downto 0);
								ir_lbx <= '1';
							end if;
						when opr_lbz =>	-- LBZ
							ir_lai <= '0';
							if (ir_lbx = '0') then	-- only execute if previous was not 
								mr_bl <= X"0";
								mr_bu <= ir_current(1 downto 0);
								ir_lbx <= '1';
							end if;
						when opr_lbp =>	-- LBEP
							ir_lai <= '0';
							if (ir_lbx = '0') then	-- only execute if previous was not 
								mr_bl <= std_logic_vector(unsigned(mr_e) + 1);
								mr_bu <= ir_current(1 downto 0);
								ir_lbx <= '1';
							end if;
						when others =>
							-- reset LAI and LBX flags for all other instructions
							ir_lai <= '0';
							ir_lbx <= '0';
							case opr is
								when opr_nop =>	-- NOP
									null;
								when opr_brk =>	-- BRK
									null; -- TODO: implement breakpoint!
								when opr_ret =>	-- RT, RTS
									null; -- Stack decrement happens at T7
								when opr_sos =>	-- SOS
									null; -- implemented through "sos_clr" signal;
								when opr_psx =>	-- PSH, PSL
									if (ir_current(0) = '0') then
										mr_master <= mr_master or psx_ormask; -- PSH
									else
										mr_master <= mr_master and psx_andmask; -- PSL
									end if;
								when opr_alu =>	-- ADD, ADCS, ADIS, AND, XOR, CMA, STC, RSC 
									-- ADIS must generate carry out for skip, but should not store it!
									if (ir_current(7 downto 4) = "0101") then
										mr_cy <= mr_cy;
									else 
										mr_cy <= y_alu(5); 
									end if;
									mr_a <= y_alu(4 downto 1);
								when opr_xae =>	-- XAE
									mr_e <= mr_a;	
									mr_a <= mr_e;
								when opr_lae =>	-- LAE
									mr_a <= mr_e;
								when opr_lab =>	-- LAB
									mr_a <= mr_bl;
								when opr_inp =>	-- INP
									mr_ram(to_integer(unsigned(ram_addr))) <= D(7 downto 4);
									mr_a <= D(3 downto 0);
								when opr_eur =>	-- EUR
									ir_eur <= mr_a(3) & mr_a(0); -- middle 2 bits are ignored
								when opr_dsb =>	-- DISB
									ir_dout <= disb_out;	-- update output latch
								when opr_dsn =>	-- DISN
									ir_dout <= disn_out;	-- update output latch
								when opr_out =>	-- OUT
									null;				-- no register changes, D is just driven from RAM & A during T5, T7
								when opr_xab =>	-- XAB
									mr_bl <= mr_a;	
									mr_a <= mr_bl;
								when opr_jms =>	-- JMS
									ir_sp <= sp_inc; -- prepare for new stack level
								when opr_jmp =>	-- JMP
									null;				-- handled during T7
								when opr_sfx =>	-- SF1, RF1, SF2, RF2
									if (ir_current(1) = '1') then
										mr_f1 <= ir_current(0);
									else
										mr_f2 <= ir_current(0);
									end if;
								when opr_xc0 =>	-- XC
									mr_ram(to_integer(unsigned(ram_addr))) <= mr_a;
									mr_a <= ram;
									mr_bu <= bu_xor;
								when opr_xci =>	-- XCI
									mr_ram(to_integer(unsigned(ram_addr))) <= mr_a;
									mr_a <= ram;
									mr_bu <= bu_xor;
									mr_bl <= bl_inc;
								when opr_xcd =>	-- XCD
									mr_ram(to_integer(unsigned(ram_addr))) <= mr_a;
									mr_a <= ram;
									mr_bu <= bu_xor;
									mr_bl <= bl_dec;
								when opr_lam =>	-- LAM
									mr_a <= ram;
									mr_bu <= bu_xor;
								when opr_xbu =>	-- XABU
									mr_bu <= mr_a(1 downto 0);
									mr_a(1 downto 0) <= mr_bu;
								when opr_mvs =>	-- MVS
									ir_slave <= mr_master(12 downto 0);
								when opr_stm =>	-- STM
									mr_ram(to_integer(unsigned(ram_addr))) <= ram or mask8(7 downto 4);
								when opr_rsm =>	-- RSM
									mr_ram(to_integer(unsigned(ram_addr))) <= ram and mask8(3 downto 0);
								when opr_spp =>	-- PP
									case ir_pp is
										when "00" =>
											ir_newpage <= ir_current(3 downto 0) xor X"F";
											ir_pp <= "01";
										when "01" =>
											ir_newbank <= ir_current(3 downto 0) xor X"F";
											ir_pp <= "10";
										when others =>
											-- subsequent PP instructions just change the bank
											ir_newbank <= ir_current(3 downto 0) xor X"F";						
									end case;
								when others =>
									null; -- TODO: possibly HCF? (Halt and catch fire)
							end case;
						end case;
				end if;
				if (t7 = '1') then
				-- T7: only JMP, JMS and RT/RTS are handled
					case opr is
						when opr_jmp =>
							case ir_pp is
								when "00" =>	
									-- no PP, jump to somewhere on same page
									ir_stack(to_integer(unsigned(ir_sp))) <= page & ir_target; 
								when "01" =>
									-- single PP, jump to any page
									ir_stack(to_integer(unsigned(ir_sp))) <= ir_newpage & ir_target; 
								when others =>
									-- two PPs, jump to any bank/page/location
									ir_stack(to_integer(unsigned(ir_sp))) <= ir_newpage & ir_target; 
									ir_bank <= ir_newbank(2 downto 0);
							end case;
							-- indicate that PPs were used
							ir_pp <= "00";
						when opr_jms =>
							case ir_pp is
								when "00" =>	
									-- no PP, call to somewhere on page 15
									ir_stack(to_integer(unsigned(ir_sp))) <= "1111" & ir_target; 
								when "01" =>
									-- single PP, call to any page
									ir_stack(to_integer(unsigned(ir_sp))) <= ir_newpage & ir_target; 
								when others =>
									-- two PPs, call to any bank/page/location
									ir_stack(to_integer(unsigned(ir_sp))) <= ir_newpage & ir_target; 
									ir_bank <= ir_newbank(2 downto 0);
							end case;
							-- indicate that PPs were used
							ir_pp <= "00";
						when opr_ret =>
							-- previous stack level
							ir_sp <= sp_dec;
						when others =>
							null;
					end case;
				end if;
			end if;
		end if;
	end if;
end process;

-- some data is sampled on clock rising edge
on_clk_up: process(CLK, nPOR)
begin
	if (nPOR = '0') then
	else
		if (rising_edge(CLK)) then
			if (t3 = '1') then
				ir_run <= RUN;
			end if;
			if (t5 = '1') then
				ir_k <= K;
			end if;
			if (t7 = '1') then
				ir_i <= I;
			end if;
		end if;
	end if;
end process;

-- select debug outputs (RAM)
dbg_mem <= mr_ram(to_integer(unsigned(dbg_sel)));

-- select debug outputs (other internal regs)
----------------------------
-- 	3		2		1		0
----------------------------
--	0	-		- 		0		T		-- ring counter clock
-- 1	- 		- 		0		R		-- ROMS mode
-- 2	- 		-		A		A		-- A output buffer
-- 3	- 		-		A		A		-- A output buffer
-- 4	- 		-	 	D		D		--	D output buffer
--	5	-  	-		RUN	SKP	-- RUN and SKIP flags
-- 6	- 		-		F2		F1		-- F2 and F1 flags
-- 7	- 		-		CY		SEC	-- Carry flag / 1 sec flag
-- 8	- 		-		0		E		-- E register
-- 9	- 		-	 	0		A		-- Accumulator
--	A	- 		-		PSX	PSX	-- Upper byte for PSH/PSL
-- B	- 		-		BU		BL		-- RAM column / row
-- C	- 		-		0		M		-- currently selected RAM
-- D	-		-		0		sp		-- stack pointer
-- E	- 		-		ir		ir		-- instruction register
-- F	bank	page	loc	loc	-- PC
----------------------------

with dbg_sel(5 downto 4) select dbg_reg <=
	'0' & ir_bank 	when "00",	-- PC: bank as octal
	pc(9 downto 6) when "01",	-- PC: page as hex
	dbg_hi 			when "10",	
	dbg_lo 			when others;
	
with dbg_sel(3 downto 0) select dbg_lo <=
	'0' & pc(2 downto 0) 	when X"F",	-- PC: location as octal
	ir_current(3 downto 0) 	when X"E",
	"00" & ir_sp	 			when X"D",
	ram							when X"C",
	mr_bl 						when X"B",
	mr_master(3 downto 0) 	when X"A",
	mr_a 							when X"9",
	mr_e 							when X"8",
	"000" & ir_sec 			when X"7",
	"000" & mr_f1 				when X"6",
	"000" & ir_skp 			when X"5",
	ir_dout(3 downto 0) 		when X"4",
	ir_slave(3 downto 0) 	when X"3",
	ir_slave(11 downto 8) 	when X"2",
	"00" & ir_roms 			when X"1",
	t								when others;
	
with dbg_sel(3 downto 0) select dbg_hi <=
	'0' & pc(5 downto 3) 	when X"F",	-- PC: location as octal
	ir_current(7 downto 4) 	when X"E",
--	X"0"				 			when X"D",
--	X"0"							when X"C",
	"00" & mr_bu				when X"B",
	mr_master(7 downto 4)	when X"A",
--	X"0" 							when X"9",
--	X"0" 							when X"8",
	"000" & mr_cy		 		when X"7",
	"000" & mr_f2 				when X"6",
	"000" & ir_run 			when X"5",
	ir_dout(7 downto 4) 		when X"4",
	ir_slave(7 downto 4) 	when X"3",
	"000" & ir_slave(12) 	when X"2",
	X"0"							when others;

end Behavioral;

