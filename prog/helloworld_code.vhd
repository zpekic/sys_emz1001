--------------------------------------------------------
-- mcc V1.2.1107 - Custom microcode compiler (c)2020-... 
--    https://github.com/zpekic/MicroCodeCompiler
--------------------------------------------------------
-- Auto-generated file, do not modify. To customize, create 'code_template.vhd' file in mcc.exe folder
-- Supported placeholders:  [NAME], [FIELDS], [SIZES], [TYPE], [SIGNAL], [INSTANCE], [MEMORY].
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.numeric_std.all;

package helloworld_code is

-- memory block size
constant CODE_DATA_WIDTH: 	positive := 8;
constant CODE_ADDRESS_WIDTH: 	positive := 10;
constant CODE_ADDRESS_LAST: 	positive := 1023;


type hlw_code_memory is array(0 to 1023) of std_logic_vector(7 downto 0);

signal hlw_uinstruction: std_logic_vector(7 downto 0);

--hlw_uinstruction <= hlw_microcode(to_integer(unsigned(TODO))); -- copy to file containing the control unit. TODO is typically replace with 'ui_address' control unit output

--
-- L0009.f76: .valfield 2 values * default 0;
--
alias hlw_f76: 	std_logic_vector(1 downto 0) is hlw_uinstruction(7 downto 6);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f76 <= hlw_f76;
---- End boilerplate code

--
-- L0010.f54: .valfield 2 values * default 0;
--
alias hlw_f54: 	std_logic_vector(1 downto 0) is hlw_uinstruction(5 downto 4);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f54 <= hlw_f54;
---- End boilerplate code

--
-- L0011.f32: .valfield 2 values * default 0;
--
alias hlw_f32: 	std_logic_vector(1 downto 0) is hlw_uinstruction(3 downto 2);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f32 <= hlw_f32;
---- End boilerplate code

--
-- L0012.f10: .valfield 2 values * default 0;
--
alias hlw_f10: 	std_logic_vector(1 downto 0) is hlw_uinstruction(1 downto 0);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f10 <= hlw_f10;
---- End boilerplate code

--
-- L0017.opr8: .valfield f76 .. f10 values * default 0;
--
alias hlw_opr8: 	std_logic_vector(7 downto 0) is hlw_uinstruction(7 downto 0);
-- Values from X"00" to X"FF" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr8 <= hlw_opr8;
---- End boilerplate code

--
-- L0019.opr6: .valfield f76 .. f32 values * default 0;
--
alias hlw_opr6: 	std_logic_vector(5 downto 0) is hlw_uinstruction(7 downto 2);
-- Values from "000000" to "111111" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr6 <= hlw_opr6;
---- End boilerplate code

--
-- L0020.val2: .valfield f10 .. f10 values * default 0;
--
alias hlw_val2: 	std_logic_vector(1 downto 0) is hlw_uinstruction(1 downto 0);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  val2 <= hlw_val2;
---- End boilerplate code

--
-- L0022.opr4: .valfield f76 .. f54 values * default 0;
--
alias hlw_opr4: 	std_logic_vector(3 downto 0) is hlw_uinstruction(7 downto 4);
-- Values from X"0" to X"F" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr4 <= hlw_opr4;
---- End boilerplate code

--
-- L0023.val4: .valfield f32 .. f10 values * default 0;
--
alias hlw_val4: 	std_logic_vector(3 downto 0) is hlw_uinstruction(3 downto 0);
-- Values from X"0" to X"F" allowed
---- Start boilerplate code (use with utmost caution!)
--  val4 <= hlw_val4;
---- End boilerplate code

--
-- L0025.opr2: .valfield f76 .. f76 values * default 0;
--
alias hlw_opr2: 	std_logic_vector(1 downto 0) is hlw_uinstruction(7 downto 6);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr2 <= hlw_opr2;
---- End boilerplate code

--
-- L0026.val6: .valfield f54 .. f10 values * default 0;
--
alias hlw_val6: 	std_logic_vector(5 downto 0) is hlw_uinstruction(5 downto 0);
-- Values from "000000" to "111111" allowed
---- Start boilerplate code (use with utmost caution!)
--  val6 <= hlw_val6;
---- End boilerplate code



constant hlw_microcode: hlw_code_memory := (

-- L0021@0000.  opr8 = 0x00;
--  opr8 = 00000000;
0 => X"00",

-- L0023@0001.  opr4 = 0b0111, val4 = 0b1000;
--  opr4 = 0111, val4 = 1000;
1 => X"7" & X"8",

-- L0024@0002.  opr8 = 0x0F;
--  opr8 = 00001111;
2 => X"0F",

-- L0026@0003.DEADLOOP:  opr6 = 0b010000, val2 = 0;
--  opr6 = 010000, val2 = 00;
3 => O"20" & "00",

-- L0027@0004.  opr2 = 0b10, val6 = 0b00111111 & @  CLEAR;
--  opr2 = 10, val6 = 000000;
4 => "10" & O"00",

-- L0029@0005.  opr6 = 0b010000, val2 = 1;
--  opr6 = 010000, val2 = 01;
5 => O"20" & "01",

-- L0030@0006.  opr2 = 0b10, val6 = 0b00111111 & @  CLEAR;
--  opr2 = 10, val6 = 000000;
6 => "10" & O"00",

-- L0032@0007.  opr6 = 0b010001, val2 = 0b10;
--  opr6 = 010001, val2 = 10;
7 => O"21" & "10",

-- L0033@0008.  opr8 = 0x04;
--  opr8 = 00000100;
8 => X"04",

-- L0034@0009.  opr8 = 0x19;
--  opr8 = 00011001;
9 => X"19",

-- L0035@000A.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
10 => O"15" & "11",

-- L0036@000B.  opr8 = 0x04;
--  opr8 = 00000100;
11 => X"04",

-- L0037@000C.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
12 => O"15" & "11",

-- L0038@000D.  opr8 = 0x05;
--  opr8 = 00000101;
13 => X"05",

-- L0040@000E.DISPLOOP:  opr2 = 0b10, val6 = 0b00111111 & @ GREETINGS;
--  opr2 = 10, val6 = 000100;
14 => "10" & O"04",

-- L0042@000F.WAIT1S:  opr8 = 0x07;
--  opr8 = 00000111;
15 => X"07",

-- L0043@0010.  opr2 = 0b11, val6 = 0b00111111 & @ WAIT1S;
--  opr2 = 11, val6 = 001111;
16 => "11" & O"17",

-- L0044@0011.  opr2 = 0b11, val6 = 0b00111111 & @ DISPLOOP;
--  opr2 = 11, val6 = 001110;
17 => "11" & O"16",

-- L0050@03C0.CLEAR:  opr4 = 0b0111, val4 = 0;
--  opr4 = 0111, val4 = 0000;
960 => X"7" & X"0",

-- L0051@03C1.  opr6 = 0b001100, val2 = 3 & ! 0;
--  opr6 = 001100, val2 = 11;
961 => O"14" & "11",

-- L0052@03C2.  opr2 = 0b11, val6 = 0b00111111 & @ CLEAR;
--  opr2 = 11, val6 = 000000;
962 => "11" & O"00",

-- L0053@03C3.  opr8 = 0x02;
--  opr8 = 00000010;
963 => X"02",

-- L0055@03C4.GREETINGS:  opr6 = 0b010000, val2 = 0b11;
--  opr6 = 010000, val2 = 11;
964 => O"20" & "11",

-- L0056@03C5.  opr2 = 0b10, val6 = 0b00111111 & @ CRLF;
--  opr2 = 10, val6 = 010010;
965 => "10" & O"22",

-- L0057@03C6.  opr2 = 0b10, val6 = 0b00111111 & @ H;
--  opr2 = 10, val6 = 011011;
966 => "10" & O"33",

-- L0058@03C7.  opr2 = 0b10, val6 = 0b00111111 & @ E;
--  opr2 = 10, val6 = 011101;
967 => "10" & O"35",

-- L0059@03C8.  opr2 = 0b10, val6 = 0b00111111 & @ L;
--  opr2 = 10, val6 = 011111;
968 => "10" & O"37",

-- L0060@03C9.  opr2 = 0b10, val6 = 0b00111111 & @ L;
--  opr2 = 10, val6 = 011111;
969 => "10" & O"37",

-- L0061@03CA.  opr2 = 0b10, val6 = 0b00111111 & @ O;
--  opr2 = 10, val6 = 100001;
970 => "10" & O"41",

-- L0062@03CB.  opr2 = 0b10, val6 = 0b00111111 & @ SPACE;
--  opr2 = 10, val6 = 100011;
971 => "10" & O"43",

-- L0063@03CC.  opr2 = 0b10, val6 = 0b00111111 & @ W;
--  opr2 = 10, val6 = 100101;
972 => "10" & O"45",

-- L0064@03CD.  opr2 = 0b10, val6 = 0b00111111 & @ O;
--  opr2 = 10, val6 = 100001;
973 => "10" & O"41",

-- L0065@03CE.  opr2 = 0b10, val6 = 0b00111111 & @ R;
--  opr2 = 10, val6 = 100111;
974 => "10" & O"47",

-- L0066@03CF.  opr2 = 0b10, val6 = 0b00111111 & @ L;
--  opr2 = 10, val6 = 011111;
975 => "10" & O"37",

-- L0067@03D0.  opr2 = 0b10, val6 = 0b00111111 & @ D;
--  opr2 = 10, val6 = 101001;
976 => "10" & O"51",

-- L0068@03D1.  opr2 = 0b10, val6 = 0b00111111 & @ EXCPOINT;
--  opr2 = 10, val6 = 101011;
977 => "10" & O"53",

-- L0069@03D2.CRLF:  opr4 = 0b0111, val4 = 0xD;
--  opr4 = 0111, val4 = 1101;
978 => X"7" & X"D",

-- L0070@03D3.  opr2 = 0b10, val6 = 0b00111111 & @ OUT_0;
--  opr2 = 10, val6 = 010101;
979 => "10" & O"25",

-- L0071@03D4.  opr4 = 0b0111, val4 = 0xA;
--  opr4 = 0111, val4 = 1010;
980 => X"7" & X"A",

-- L0072@03D5.OUT_0:  opr6 = 0b001001, val2 = 3;
--  opr6 = 001001, val2 = 11;
981 => O"11" & "11",

-- L0073@03D6.  opr6 = 0b001001, val2 = 2;
--  opr6 = 001001, val2 = 10;
982 => O"11" & "10",

-- L0074@03D7.  opr6 = 0b001001, val2 = 1;
--  opr6 = 001001, val2 = 01;
983 => O"11" & "01",

-- L0075@03D8.  opr6 = 0b001001, val2 = 0;
--  opr6 = 001001, val2 = 00;
984 => O"11" & "00",

-- L0076@03D9.  opr8 = 0x1A;
--  opr8 = 00011010;
985 => X"1A",

-- L0077@03DA.  opr8 = 0x02;
--  opr8 = 00000010;
986 => X"02",

-- L0079@03DB.H:  opr4 = 0b0111, val4 = 0x0F & 'H';
--  opr4 = 0111, val4 = 1000;
987 => X"7" & X"8",

-- L0080@03DC.  opr2 = 0b11, val6 = 0b00111111 & @ OUT_4;
--  opr2 = 11, val6 = 110010;
988 => "11" & O"62",

-- L0081@03DD.E:  opr4 = 0b0111, val4 = 0x0F & 'E';
--  opr4 = 0111, val4 = 0101;
989 => X"7" & X"5",

-- L0082@03DE.  opr2 = 0b11, val6 = 0b00111111 & @ OUT_4;
--  opr2 = 11, val6 = 110010;
990 => "11" & O"62",

-- L0083@03DF.L:  opr4 = 0b0111, val4 = 0x0F & 'L';
--  opr4 = 0111, val4 = 1100;
991 => X"7" & X"C",

-- L0084@03E0.  opr2 = 0b11, val6 = 0b00111111 & @ OUT_4;
--  opr2 = 11, val6 = 110010;
992 => "11" & O"62",

-- L0085@03E1.O:  opr4 = 0b0111, val4 = 0x0F & 'O';
--  opr4 = 0111, val4 = 1111;
993 => X"7" & X"F",

-- L0086@03E2.  opr2 = 0b11, val6 = 0b00111111 & @ OUT_4;
--  opr2 = 11, val6 = 110010;
994 => "11" & O"62",

-- L0087@03E3.SPACE:  opr4 = 0b0111, val4 = 0x0F & ' ';
--  opr4 = 0111, val4 = 0000;
995 => X"7" & X"0",

-- L0088@03E4.  opr2 = 0b11, val6 = 0b00111111 & @ OUT_2;
--  opr2 = 11, val6 = 101100;
996 => "11" & O"54",

-- L0089@03E5.W:  opr4 = 0b0111, val4 = 0x0F & 'W';
--  opr4 = 0111, val4 = 0111;
997 => X"7" & X"7",

-- L0090@03E6.  opr2 = 0b11, val6 = 0b00111111 & @ OUT_5;
--  opr2 = 11, val6 = 111000;
998 => "11" & O"70",

-- L0091@03E7.R:  opr4 = 0b0111, val4 = 0x0F & 'R';
--  opr4 = 0111, val4 = 0010;
999 => X"7" & X"2",

-- L0092@03E8.  opr2 = 0b11, val6 = 0b00111111 & @ OUT_5;
--  opr2 = 11, val6 = 111000;
1000 => "11" & O"70",

-- L0093@03E9.D:  opr4 = 0b0111, val4 = 0x0F & 'D';
--  opr4 = 0111, val4 = 0100;
1001 => X"7" & X"4",

-- L0094@03EA.  opr2 = 0b11, val6 = 0b00111111 & @ OUT_4;
--  opr2 = 11, val6 = 110010;
1002 => "11" & O"62",

-- L0095@03EB.EXCPOINT:  opr4 = 0b0111, val4 = 0x0F & '!';
--  opr4 = 0111, val4 = 0001;
1003 => X"7" & X"1",

-- L0096@03EC.OUT_2:  opr6 = 0b001001, val2 = 3;
--  opr6 = 001001, val2 = 11;
1004 => O"11" & "11",

-- L0097@03ED.  opr6 = 0b001001, val2 = 2;
--  opr6 = 001001, val2 = 10;
1005 => O"11" & "10",

-- L0098@03EE.  opr6 = 0b001000, val2 = 1;
--  opr6 = 001000, val2 = 01;
1006 => O"10" & "01",

-- L0099@03EF.  opr6 = 0b001001, val2 = 0;
--  opr6 = 001001, val2 = 00;
1007 => O"11" & "00",

-- L0100@03F0.  opr8 = 0x1A;
--  opr8 = 00011010;
1008 => X"1A",

-- L0101@03F1.  opr8 = 0x02;
--  opr8 = 00000010;
1009 => X"02",

-- L0103@03F2.OUT_4:  opr6 = 0b001001, val2 = 3;
--  opr6 = 001001, val2 = 11;
1010 => O"11" & "11",

-- L0104@03F3.  opr6 = 0b001000, val2 = 2;
--  opr6 = 001000, val2 = 10;
1011 => O"10" & "10",

-- L0105@03F4.  opr6 = 0b001001, val2 = 1;
--  opr6 = 001001, val2 = 01;
1012 => O"11" & "01",

-- L0106@03F5.  opr6 = 0b001001, val2 = 0;
--  opr6 = 001001, val2 = 00;
1013 => O"11" & "00",

-- L0107@03F6.  opr8 = 0x1A;
--  opr8 = 00011010;
1014 => X"1A",

-- L0108@03F7.  opr8 = 0x02;
--  opr8 = 00000010;
1015 => X"02",

-- L0110@03F8.OUT_5:  opr6 = 0b001001, val2 = 3;
--  opr6 = 001001, val2 = 11;
1016 => O"11" & "11",

-- L0111@03F9.  opr6 = 0b001000, val2 = 2;
--  opr6 = 001000, val2 = 10;
1017 => O"10" & "10",

-- L0112@03FA.  opr6 = 0b001001, val2 = 1;
--  opr6 = 001001, val2 = 01;
1018 => O"11" & "01",

-- L0113@03FB.  opr6 = 0b001000, val2 = 0;
--  opr6 = 001000, val2 = 00;
1019 => O"10" & "00",

-- L0114@03FC.  opr8 = 0x1A;
--  opr8 = 00011010;
1020 => X"1A",

-- L0115@03FD.  opr8 = 0x02;
--  opr8 = 00000010;
1021 => X"02",

-- 944 location(s) in following ranges will be filled with default value
-- 0012 .. 03BF
-- 03FE .. 03FF

others => "00" & "00" & "00" & "00"
);

end helloworld_code;

