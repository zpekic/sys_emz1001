----------------------------------------------------------------------------------
-- Company:  		https://hackaday.io/projects/hacker/233652
-- Engineer: 		zpekic@hotmail.com
-- 
-- Create Date:    12:27:39 11/25/2022 
-- Design Name:    Iskra 
-- Module Name:    EMZ1001A - Behavioral 
-- Project Name:   https://github.com/zpekic/sys_emz1001
-- Target Devices: Any standard FPGA
-- Tool versions:  Xilinx ISE 14.7 (last free)
-- Description:    EMZ1001 series was the only microcontroller designed and produced in 
--						 ex-Yugoslavia. It was a co-production with AMI (known as S2000)
-- Dependencies: 	 Standard VHDL libraries only
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

constant bank0: mem1k8 := firmware;

-- used for PSH (OR, non-inverted) and PSL (AND, inverted)
constant psx_mask: mem16x16 := (
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
	"1111111111111111"	-- set (or clear) all bits
);

-- PLA constants
constant skp_0, alu_nop: std_logic_vector(3 downto 0) := X"0";
constant skp_1, alu_inv: std_logic_vector(3 downto 0) := X"1";
constant skp_sec, alu_and: std_logic_vector(3 downto 0) := X"2";
constant skp_ble, alu_xor: std_logic_vector(3 downto 0) := X"3";
constant skp_cy0, alu_bu: std_logic_vector(3 downto 0) := X"4";
constant skp_cout, alu_adcs: std_logic_vector(3 downto 0) := X"5";
constant skp_am, alu_adis: std_logic_vector(3 downto 0) := X"6";
constant skp_bit, alu_add: std_logic_vector(3 downto 0) := X"7";
constant skp_blf, alu_bl: std_logic_vector(3 downto 0) := X"8";
constant skp_bl0, alu_m: std_logic_vector(3 downto 0) := X"9";
constant skp_lbx, alu_nopa: std_logic_vector(3 downto 0) := X"a";
constant skp_lai, alu_nopb: std_logic_vector(3 downto 0) := X"b";
constant skp_ik, alu_nopc: std_logic_vector(3 downto 0) := X"c";
constant skp_skp, alu_d: std_logic_vector(3 downto 0) := X"d";
constant skp_f1, alu_e: std_logic_vector(3 downto 0) := X"e";
constant skp_f2, alu_nopf: std_logic_vector(3 downto 0) := X"f";

constant opr_nop: std_logic_vector(4 downto 0) := '0' & X"0";
constant opr_brk: std_logic_vector(4 downto 0) := '0' & X"1";
constant opr_ret: std_logic_vector(4 downto 0) := '0' & X"2";
constant opr_sos: std_logic_vector(4 downto 0) := '0' & X"3";
constant opr_psx: std_logic_vector(4 downto 0) := '0' & X"4";
constant opr_cry: std_logic_vector(4 downto 0) := '0' & X"5";
constant opr_acc: std_logic_vector(4 downto 0) := '0' & X"6";
constant opr_xae: std_logic_vector(4 downto 0) := '0' & X"7";
constant opr_inp: std_logic_vector(4 downto 0) := '0' & X"8";
constant opr_eur: std_logic_vector(4 downto 0) := '0' & X"9";
constant opr_dsb: std_logic_vector(4 downto 0) := '0' & X"a";
constant opr_dsn: std_logic_vector(4 downto 0) := '0' & X"b";
constant opr_out: std_logic_vector(4 downto 0) := '0' & X"c";
constant opr_xab: std_logic_vector(4 downto 0) := '0' & X"d";
constant opr_jms: std_logic_vector(4 downto 0) := '0' & X"e";
constant opr_jmp: std_logic_vector(4 downto 0) := '0' & X"f";
constant opr_sf1: std_logic_vector(4 downto 0) := '1' & X"0";
constant opr_sf2: std_logic_vector(4 downto 0) := '1' & X"1";
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

-- PLA for instruction decode
constant pla_00: mem64x13 := (
skp_0 & alu_nop & opr_nop,	-- NOP
skp_0 & alu_nop & opr_brk,	-- BRK
skp_0 & alu_nop & opr_ret,	--	RT
skp_1 & alu_nop & opr_ret,	-- RTS
skp_0 & alu_nop & opr_psx,	-- PSH
skp_0 & alu_nop & opr_psx,	-- PSL
skp_0 & alu_and & opr_acc,	-- AND
skp_sec & alu_nop & opr_sos,	-- SOS
skp_ble & alu_nop & opr_nop,	-- SBE
skp_cy0 & alu_nop & opr_nop,	-- SZC
skp_0 & alu_nop & opr_cry,	-- STC
skp_0 & alu_nop & opr_cry,	-- RSC
skp_0 & alu_e & opr_acc,	-- LAE
skp_0 & alu_e & opr_xae,	-- XAE
skp_0 & alu_d & opr_inp,	-- INP
skp_0 & alu_nop & opr_eur,	-- EUR
skp_0 & alu_inv & opr_acc,	-- CMA
skp_0 & alu_bu & opr_xbu,	-- XABU
skp_0 & alu_bl & opr_acc,	-- LAB
skp_0 & alu_bl & opr_xab,	-- XAB
skp_cout & alu_adcs & opr_acc,	-- ADCS 
skp_0 & alu_xor & opr_acc,	-- XOR
skp_0 & alu_add & opr_acc,	-- ADD
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
skp_0 & alu_nop & opr_sf1,	-- RF1
skp_0 & alu_nop & opr_sf1,	-- SF1
skp_0 & alu_nop & opr_sf2,	-- RF2
skp_0 & alu_nop & opr_sf2,	-- SF2
skp_f1 & alu_nop & opr_nop,	-- TF1
skp_f2 & alu_nop & opr_nop,	-- TF2
skp_blf & alu_m & opr_xci,	-- XCI
skp_blf & alu_m & opr_xci,	-- XCI
skp_blf & alu_m & opr_xci,	-- XCI
skp_blf & alu_m & opr_xci,	-- XCI
skp_bl0 & alu_m & opr_xcd,	-- XCD
skp_bl0 & alu_m & opr_xcd,	-- XCD
skp_bl0 & alu_m & opr_xcd,	-- XCD
skp_bl0 & alu_m & opr_xcd,	-- XCD
skp_0 & alu_m & opr_xc0,	-- XC
skp_0 & alu_m & opr_xc0,	-- XC
skp_0 & alu_m & opr_xc0,	-- XC
skp_0 & alu_m & opr_xc0,	-- XC
skp_0 & alu_m & opr_lam,	-- LAM
skp_0 & alu_m & opr_lam,	-- LAM
skp_0 & alu_m & opr_lam,	-- LAM
skp_0 & alu_m & opr_lam 	-- LAM
);

constant pla_01: mem64x13 := (
skp_lbx & alu_nop & opr_lbz,	-- LBZ
skp_lbx & alu_nop & opr_lbz,	-- LBZ
skp_lbx & alu_nop & opr_lbz,	-- LBZ
skp_lbx & alu_nop & opr_lbz,	-- LBZ
skp_lbx & alu_nop & opr_lbf,	-- LBF
skp_lbx & alu_nop & opr_lbf,	-- LBF
skp_lbx & alu_nop & opr_lbf,	-- LBF
skp_lbx & alu_nop & opr_lbf,	-- LBF
skp_lbx & alu_nop & opr_lbe,	-- LBE
skp_lbx & alu_nop & opr_lbe,	-- LBE
skp_lbx & alu_nop & opr_lbe,	-- LBE
skp_lbx & alu_nop & opr_lbe,	-- LBE
skp_lbx & alu_nop & opr_lbp,	-- LBEP
skp_lbx & alu_nop & opr_lbp,	-- LBEP
skp_lbx & alu_nop & opr_lbp,	-- LBEP
skp_lbx & alu_nop & opr_lbp,	-- LBEP
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
skp_cout & alu_adis & opr_acc,	-- ADIS
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
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai,	-- LAI
skp_lai & alu_nop & opr_lai	-- LAI
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

signal ir_eur:	std_logic_vector(3 downto 0);		-- middle 2-bits are ignored
alias ir_50Hz: std_logic is ir_eur(3);				-- 0: 60Hz on reset
alias ir_d_noinvert: std_logic is ir_eur(0);		-- 1: non-inverted on reset

signal ir_current, ir_previous: std_logic_vector(7 downto 0);

-- programming model accessible registers
signal mr_mem: mem64x4 := (others => X"0");
signal mr_bl, mr_a, mr_e: std_logic_vector(3 downto 0);
signal mr_bu: std_logic_vector(1 downto 0);
signal mr_cy, mr_f1, mr_f2: std_logic;

signal mr_master: std_logic_vector(14 downto 0); -- 15 bits, 2 are control, 13 may go to ir_slave
alias mr_d_driven: std_logic is mr_master(14);			-- 0: FLOAT mode on reset
alias mr_a_multiplexed: std_logic is mr_master(13);	-- 0: STATIC mode on reset

-- other
signal bl_is_13: std_logic;
signal pc: std_logic_vector(12 downto 0);
signal a_is_address: std_logic;
signal mem: std_logic_vector(3 downto 0);	-- represents currently selected RAM cell
signal mem_addr: std_logic_vector(5 downto 0);
signal y_alu: std_logic_vector(5 downto 0);	-- 6-bit ALU output
signal y_skp: std_logic;
signal bl_is_e, a_is_m, bl_is_0, bl_is_f, bit_is_1: std_logic;
signal ik: std_logic_vector(3 downto 0);
signal sec: std_logic;	-- set when 1 second expires

signal pla: std_logic_vector(12 downto 0);
alias skp: std_logic_vector(3 downto 0) is pla(12 downto 9);
alias alu: std_logic_vector(3 downto 0) is pla(8 downto 5);
alias opr: std_logic_vector(4 downto 0) is pla(4 downto 0);

-- debug
signal dbg_int: std_logic_vector(3 downto 0);

begin

-- SYNC is low at T1 and T3, high at T5 and T7
SYNC <= t5 or t7; 

-- STATUS is a 4 to 1 mux
STATUS <= (t1 and (not mr_d_driven)) or (t3 and bl_is_13) or (t5 and mr_cy) or (t7 and ir_skp);

-- nEXT goes low when executing OUT
nEXTERNAL <= '0' when (t7 = '1') else '1'; -- TODO!

-- D is either floating, or driven from internal dout
D <= ir_dout when (mr_d_driven = '1') else "ZZZZZZZZ";
ir_dout <= bank0(to_integer(unsigned(pc(9 downto 0)))); --  TODO

-- A TODO!!
A <= pc when (a_is_address = '1') else ir_slave;

-- instruction decode (256 op-codes split into 4*64 blocks)
with ir_current(7 downto 6) select pla <=
	pla_00(to_integer(unsigned(ir_current(5 downto 0)))) when "00", -- NOP to LAM
	pla_01(to_integer(unsigned(ir_current(5 downto 0)))) when "01", -- LBZ to LAI
	skp_0 & alu_nop & opr_jms when "10",	-- JMS
	skp_0 & alu_nop & opr_jmp when others;	-- JMP

-- RAM is pointed by BU and BL
mem_addr <= mr_bu & mr_bl;
mem <= mr_mem(to_integer(unsigned(mem_addr)));

-- terribly non-optimal 6-bit wide ALU (carry-in + 4 bits + carry-out)
with alu select y_alu <=
		mr_cy & (mr_a xor X"F") & '0' when alu_inv,
		mr_cy & (mr_a and mem) & '0' when alu_and,
		mr_cy & (mr_a xor mem) & '0' when alu_xor,
		mr_cy & mr_a(3 downto 2) & mr_bu & '0' when alu_bu,
		std_logic_vector(unsigned('0' & mr_a & mr_cy) + unsigned('0' & mem & mr_cy)) when alu_adcs,
		std_logic_vector(unsigned('0' & mr_a & '0') + unsigned('0' & ir_current(3 downto 0) & '0')) when alu_adis,
		std_logic_vector(unsigned('0' & mr_a & '0') + unsigned('0' & mem & '0')) when alu_add,
		mr_cy & mr_bl & '0' when alu_bl,
		mr_cy & mem & '0' when alu_m,
		mr_cy & D(3 downto 0) & '0' when alu_d,
		mr_cy & mr_e & '0' when alu_e,
		mr_cy & mr_a & '0' when others;

-- select source for updated skip flag (16 to 1 mux)
with skp select y_skp <=
		'0' when skp_0,	-- never skip next instruction
		'1' when skp_1,	-- always skip next instruction
		sec when skp_sec,
		bl_is_e when skp_ble,
		(not mr_cy) when skp_cy0,
		(not y_alu(5)) when skp_cout,
		a_is_m when skp_am,
		(not bit_is_1) when skp_bit,	
		bl_is_f when skp_blf,
		bl_is_0 when skp_bl0, 
		ir_lai when skp_lbx,	
		ir_lbx when skp_lai,	
		not(ik(3) and ik(2) and ik(1) and ik(0)) when skp_ik,	-- at least 1 zero detected in I or K after masking	
		ir_skp when skp_skp,	-- do not change skip flag, pass it to next instruction
		mr_f1 when skp_f1,
		mr_f2 when others;

-- conditions for skips
bl_is_e <= '1' when (mr_bl = mr_e) else '0';
bl_is_0 <= '1' when (mr_bl = X"0") else '0';
bl_is_f <= '1' when (mr_bl = X"F") else '0';
bl_is_13 <= '1' when (mr_bl = X"D") else '0';
a_is_m <= '1' when (mr_a = mem) else '0';

with ir_current(1 downto 0) select bit_is_1 <=
	mem(0) when "00",
	mem(1) when "01",
	mem(2) when "10",
	mem(3) when others;

with ir_current(0) select ik <= 
	(ir_k or ir_mask) when '0', 		-- SZK 0x28
	(ir_i or ir_mask) when others; 	-- SZI 0x29
-- most action happens on clock falling edge
on_clk_down: process(CLK, nPOR)
begin
	if (nPOR = '0') then
		t <= "0001";
		--pc <= (others => '0');
		-- initialize some regs
		ir_lai <= '1';		-- this is why first instruction should not be LAI
		ir_lbx <= '1'; 	-- this is why first instruction should not be LBE, LBEP, LBF, LBZ
		ir_eur <= "0001";	-- non 60Hz, normal polarity
		mr_master <= (others => '0');	-- static operation, float D lines
	else
		if (falling_edge(CLK)) then
			t <= t(2 downto 0) & t(3); -- one hot ring counter
			--pc <= std_logic_vector(unsigned(pc) + 1);
			if (t1 = '1') then
			-- stuff happening in T1
			end if;
			-- run FF was set at rising edge turing T3 so we have it for T3, T5, T7
			if (ir_run = '1') then
				if (t3 = '1') then
				-- stuff happening in T3
					if (ir_skp = '0') then
					end if;
				end if;
				if (t5 = '1') then
				-- stuff happening in T5
					if (ir_skp = '0') then
					end if;
				end if;
				if (t7 = '1') then
				-- stuff happening in T7
					if (ir_skp = '0') then
					end if;
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

end Behavioral;

