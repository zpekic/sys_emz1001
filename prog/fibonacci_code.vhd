--------------------------------------------------------
-- mcc V1.2.1023 - Custom microcode compiler (c)2020-... 
--    https://github.com/zpekic/MicroCodeCompiler
--------------------------------------------------------
-- Auto-generated file, do not modify. To customize, create 'code_template.vhd' file in mcc.exe folder
-- Supported placeholders:  [NAME], [FIELDS], [SIZES], [TYPE], [SIGNAL], [INSTANCE], [MEMORY].
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.numeric_std.all;

package fibonacci_code is

-- memory block size
constant CODE_DATA_WIDTH: 	positive := 8;
constant CODE_ADDRESS_WIDTH: 	positive := 10;
constant CODE_ADDRESS_LAST: 	positive := 1023;


type emz_code_memory is array(0 to 1023) of std_logic_vector(7 downto 0);

signal emz_uinstruction: std_logic_vector(7 downto 0);

--emz_uinstruction <= emz_microcode(to_integer(unsigned(TODO))); -- copy to file containing the control unit. TODO is typically replace with 'ui_address' control unit output

--
-- L0009.f76: .valfield 2 values * default 0;
--
alias emz_f76: 	std_logic_vector(1 downto 0) is emz_uinstruction(7 downto 6);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f76 <= emz_f76;
---- End boilerplate code

--
-- L0010.f54: .valfield 2 values * default 0;
--
alias emz_f54: 	std_logic_vector(1 downto 0) is emz_uinstruction(5 downto 4);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f54 <= emz_f54;
---- End boilerplate code

--
-- L0011.f32: .valfield 2 values * default 0;
--
alias emz_f32: 	std_logic_vector(1 downto 0) is emz_uinstruction(3 downto 2);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f32 <= emz_f32;
---- End boilerplate code

--
-- L0012.f10: .valfield 2 values * default 0;
--
alias emz_f10: 	std_logic_vector(1 downto 0) is emz_uinstruction(1 downto 0);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f10 <= emz_f10;
---- End boilerplate code

--
-- L0017.opr8: .valfield f76 .. f10 values * default 0;
--
alias emz_opr8: 	std_logic_vector(7 downto 0) is emz_uinstruction(7 downto 0);
-- Values from X"00" to X"FF" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr8 <= emz_opr8;
---- End boilerplate code

--
-- L0019.opr6: .valfield f76 .. f32 values * default 0;
--
alias emz_opr6: 	std_logic_vector(5 downto 0) is emz_uinstruction(7 downto 2);
-- Values from "000000" to "111111" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr6 <= emz_opr6;
---- End boilerplate code

--
-- L0020.val2: .valfield f10 .. f10 values * default 0;
--
alias emz_val2: 	std_logic_vector(1 downto 0) is emz_uinstruction(1 downto 0);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  val2 <= emz_val2;
---- End boilerplate code

--
-- L0022.opr4: .valfield f76 .. f54 values * default 0;
--
alias emz_opr4: 	std_logic_vector(3 downto 0) is emz_uinstruction(7 downto 4);
-- Values from X"0" to X"F" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr4 <= emz_opr4;
---- End boilerplate code

--
-- L0023.val4: .valfield f32 .. f10 values * default 0;
--
alias emz_val4: 	std_logic_vector(3 downto 0) is emz_uinstruction(3 downto 0);
-- Values from X"0" to X"F" allowed
---- Start boilerplate code (use with utmost caution!)
--  val4 <= emz_val4;
---- End boilerplate code

--
-- L0025.opr2: .valfield f76 .. f76 values * default 0;
--
alias emz_opr2: 	std_logic_vector(1 downto 0) is emz_uinstruction(7 downto 6);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr2 <= emz_opr2;
---- End boilerplate code

--
-- L0026.val6: .valfield f54 .. f10 values * default 0;
--
alias emz_val6: 	std_logic_vector(5 downto 0) is emz_uinstruction(5 downto 0);
-- Values from "000000" to "111111" allowed
---- Start boilerplate code (use with utmost caution!)
--  val6 <= emz_val6;
---- End boilerplate code



constant emz_microcode: emz_code_memory := (

-- L0017@0000.  opr8 = 0x00;
--  opr8 = 00000000;
0 => X"00",

-- L0018@0001.  opr4 = 0b0111, val4 = 0b1001;
--  opr4 = 0111, val4 = 1001;
1 => X"7" & X"9",

-- L0019@0002.  opr8 = 0x0F;
--  opr8 = 00001111;
2 => X"0F",

-- L0020@0003.  opr4 = 0b0111, val4 = 13;
--  opr4 = 0111, val4 = 1101;
3 => X"7" & X"D",

-- L0021@0004.  opr8 = 0x13;
--  opr8 = 00010011;
4 => X"13",

-- L0022@0005.  opr8 = 0x04;
--  opr8 = 00000100;
5 => X"04",

-- L0023@0006.  opr4 = 0b0111, val4 = 14;
--  opr4 = 0111, val4 = 1110;
6 => X"7" & X"E",

-- L0024@0007.  opr8 = 0x13;
--  opr8 = 00010011;
7 => X"13",

-- L0025@0008.  opr8 = 0x04;
--  opr8 = 00000100;
8 => X"04",

-- L0026@0009.  opr4 = 0b0111, val4 = 15;
--  opr4 = 0111, val4 = 1111;
9 => X"7" & X"F",

-- L0027@000A.  opr8 = 0x13;
--  opr8 = 00010011;
10 => X"13",

-- L0028@000B.  opr8 = 0x05;
--  opr8 = 00000101;
11 => X"05",

-- L0030@000C.  opr6 = 0b010000, val2 = 0;
--  opr6 = 010000, val2 = 00;
12 => O"20" & "00",

-- L0031@000D.  opr2 = 0b10, val6 = 0b00111111 & @  CLEAR;
--  opr2 = 10, val6 = 000000;
13 => "10" & O"00",

-- L0033@000E.  opr6 = 0b010000, val2 = 1;
--  opr6 = 010000, val2 = 01;
14 => O"20" & "01",

-- L0034@000F.  opr2 = 0b10, val6 = 0b00111111 & @  CLEAR;
--  opr2 = 10, val6 = 000000;
15 => "10" & O"00",

-- L0036@0010.  opr6 = 0b010000, val2 = 1;
--  opr6 = 010000, val2 = 01;
16 => O"20" & "01",

-- L0037@0011.  opr6 = 0b001000, val2 = 0;
--  opr6 = 001000, val2 = 00;
17 => O"10" & "00",

-- L0039@0012.ADDLOOP:  opr2 = 0b10, val6 = 0b00111111 & @  BCDADD;
--  opr2 = 10, val6 = 100000;
18 => "10" & O"40",

-- L0040@0013.  opr2 = 0b10, val6 = 0b00111111 & @  DISP_TTY;
--  opr2 = 10, val6 = 001110;
19 => "10" & O"16",

-- L0042@0014.DISPLOOP:  opr2 = 0b10, val6 = 0b00111111 & @  DISP_LED;
--  opr2 = 10, val6 = 001111;
20 => "10" & O"17",

-- L0043@0015.  opr8 = 0x07;
--  opr8 = 00000111;
21 => X"07",

-- L0044@0016.  opr2 = 0b11, val6 = 0b00111111 & @ DISPLOOP;
--  opr2 = 11, val6 = 010100;
22 => "11" & O"24",

-- L0046@0017.  opr2 = 0b10, val6 = 0b00111111 & @  SHIFT0;
--  opr2 = 10, val6 = 000100;
23 => "10" & O"04",

-- L0048@0018.  opr2 = 0b10, val6 = 0b00111111 & @  SHIFT1;
--  opr2 = 10, val6 = 001001;
24 => "10" & O"11",

-- L0050@0019.  opr2 = 0b11, val6 = 0b00111111 & @ ADDLOOP;
--  opr2 = 11, val6 = 010010;
25 => "11" & O"22",

-- L0055@03C0.CLEAR:  opr4 = 0b0111, val4 = 0;
--  opr4 = 0111, val4 = 0000;
960 => X"7" & X"0",

-- L0056@03C1.  opr6 = 0b001100, val2 = 3 & ! 0;
--  opr6 = 001100, val2 = 11;
961 => O"14" & "11",

-- L0057@03C2.  opr2 = 0b11, val6 = 0b00111111 & @ CLEAR;
--  opr2 = 11, val6 = 000000;
962 => "11" & O"00",

-- L0058@03C3.  opr8 = 0x02;
--  opr8 = 00000010;
963 => X"02",

-- L0060@03C4.SHIFT0:  opr6 = 0b010000, val2 = 0b01;
--  opr6 = 010000, val2 = 01;
964 => O"20" & "01",

-- L0061@03C5.SHIFT0LOOP:  opr6 = 0b001111, val2 = 3 & ! 0b01;
--  opr6 = 001111, val2 = 10;
965 => O"17" & "10",

-- L0062@03C6.  opr6 = 0b001100, val2 = 3 & ! 0b01;
--  opr6 = 001100, val2 = 10;
966 => O"14" & "10",

-- L0063@03C7.  opr2 = 0b11, val6 = 0b00111111 & @ SHIFT0LOOP;
--  opr2 = 11, val6 = 000101;
967 => "11" & O"05",

-- L0064@03C8.  opr8 = 0x02;
--  opr8 = 00000010;
968 => X"02",

-- L0066@03C9.SHIFT1:  opr6 = 0b010000, val2 = 0b10;
--  opr6 = 010000, val2 = 10;
969 => O"20" & "10",

-- L0067@03CA.SHIFT1LOOP:  opr6 = 0b001111, val2 = 3 & ! 0b11;
--  opr6 = 001111, val2 = 00;
970 => O"17" & "00",

-- L0068@03CB.  opr6 = 0b001100, val2 = 3 & ! 0b10;
--  opr6 = 001100, val2 = 01;
971 => O"14" & "01",

-- L0069@03CC.  opr2 = 0b11, val6 = 0b00111111 & @ SHIFT1LOOP;
--  opr2 = 11, val6 = 001010;
972 => "11" & O"12",

-- L0070@03CD.  opr8 = 0x02;
--  opr8 = 00000010;
973 => X"02",

-- L0072@03CE.DISP_TTY:  opr8 = 0x02;
--  opr8 = 00000010;
974 => X"02",

-- L0074@03CF.DISP_LED:  opr6 = 0b010001, val2 = 0b10;
--  opr6 = 010001, val2 = 10;
975 => O"21" & "10",

-- L0075@03D0.  opr8 = 0x05;
--  opr8 = 00000101;
976 => X"05",

-- L0076@03D1.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
977 => O"15" & "11",

-- L0077@03D2.  opr8 = 0x04;
--  opr8 = 00000100;
978 => X"04",

-- L0078@03D3.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
979 => O"15" & "11",

-- L0079@03D4.  opr8 = 0x05;
--  opr8 = 00000101;
980 => X"05",

-- L0080@03D5.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
981 => O"15" & "11",

-- L0081@03D6.  opr8 = 0x0B;
--  opr8 = 00001011;
982 => X"0B",

-- L0082@03D7.  opr4 = 0b0111, val4 = 15;
--  opr4 = 0111, val4 = 1111;
983 => X"7" & X"F",

-- L0083@03D8.  opr8 = 0x0D;
--  opr8 = 00001101;
984 => X"0D",

-- L0084@03D9.LEDLOOP:  opr6 = 0b001111, val2 = 3 & ! 0b00;
--  opr6 = 001111, val2 = 11;
985 => O"17" & "11",

-- L0085@03DA.  opr8 = 0x04;
--  opr8 = 00000100;
986 => X"04",

-- L0086@03DB.  opr8 = 0x19;
--  opr8 = 00011001;
987 => X"19",

-- L0087@03DC.  opr8 = 0x1B;
--  opr8 = 00011011;
988 => X"1B",

-- L0088@03DD.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
989 => O"15" & "11",

-- L0089@03DE.  opr2 = 0b11, val6 = 0b00111111 & @ LEDLOOP;
--  opr2 = 11, val6 = 011001;
990 => "11" & O"31",

-- L0090@03DF.  opr8 = 0x02;
--  opr8 = 00000010;
991 => X"02",

-- L0092@03E0.BCDADD:  opr6 = 0b010000, val2 = 0;
--  opr6 = 010000, val2 = 00;
992 => O"20" & "00",

-- L0093@03E1.  opr8 = 0x0B;
--  opr8 = 00001011;
993 => X"0B",

-- L0094@03E2.ALOOP:  opr6 = 0b001111, val2 = 3 & ! 0b01;
--  opr6 = 001111, val2 = 10;
994 => O"17" & "10",

-- L0095@03E3.  opr8 = 0x14;
--  opr8 = 00010100;
995 => X"14",

-- L0096@03E4.  opr8 = 0x00;
--  opr8 = 00000000;
996 => X"00",

-- L0097@03E5.  opr2 = 0b10, val6 = 0b00111111 & @  DAA;
--  opr2 = 10, val6 = 101101;
997 => "10" & O"55",

-- L0098@03E6.  opr8 = 0x0D;
--  opr8 = 00001101;
998 => X"0D",

-- L0099@03E7.  opr4 = 0b0111, val4 = 2;
--  opr4 = 0111, val4 = 0010;
999 => X"7" & X"2",

-- L0100@03E8.  opr8 = 0x11;
--  opr8 = 00010001;
1000 => X"11",

-- L0101@03E9.  opr8 = 0x0D;
--  opr8 = 00001101;
1001 => X"0D",

-- L0102@03EA.  opr6 = 0b001100, val2 = 3 & ! 0b10;
--  opr6 = 001100, val2 = 01;
1002 => O"14" & "01",

-- L0103@03EB.  opr2 = 0b11, val6 = 0b00111111 & @ ALOOP;
--  opr2 = 11, val6 = 100010;
1003 => "11" & O"42",

-- L0104@03EC.  opr8 = 0x02;
--  opr8 = 00000010;
1004 => X"02",

-- L0106@03ED.DAA:  opr8 = 0x09;
--  opr8 = 00001001;
1005 => X"09",

-- L0107@03EE.  opr2 = 0b11, val6 = 0b00111111 & @ V16_TO_18;
--  opr2 = 11, val6 = 110101;
1006 => "11" & O"65",

-- L0108@03EF.  opr4 = 0b0101, val4 = 6;
--  opr4 = 0101, val4 = 0110;
1007 => X"5" & X"6",

-- L0109@03F0.  opr2 = 0b11, val6 = 0b00111111 & @ V0_TO_9;
--  opr2 = 11, val6 = 110010;
1008 => "11" & O"62",

-- L0110@03F1.  opr2 = 0b11, val6 = 0b00111111 & @ ADJUSTED;
--  opr2 = 11, val6 = 110110;
1009 => "11" & O"66",

-- L0112@03F2.V0_TO_9:  opr4 = 0b0101, val4 = 10;
--  opr4 = 0101, val4 = 1010;
1010 => X"5" & X"A",

-- L0113@03F3.UNADJUSTED:  opr8 = 0x0B;
--  opr8 = 00001011;
1011 => X"0B",

-- L0114@03F4.  opr8 = 0x02;
--  opr8 = 00000010;
1012 => X"02",

-- L0116@03F5.V16_TO_18:  opr4 = 0b0101, val4 = 6;
--  opr4 = 0101, val4 = 0110;
1013 => X"5" & X"6",

-- L0117@03F6.ADJUSTED:  opr8 = 0x0A;
--  opr8 = 00001010;
1014 => X"0A",

-- L0118@03F7.  opr8 = 0x02;
--  opr8 = 00000010;
1015 => X"02",

-- 942 location(s) in following ranges will be filled with default value
-- 001A .. 03BF
-- 03F8 .. 03FF

others => "00" & "00" & "00" & "00"
);

end fibonacci_code;

