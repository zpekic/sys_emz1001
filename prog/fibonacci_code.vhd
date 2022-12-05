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

package fibonacci_code is

-- memory block size
constant CODE_DATA_WIDTH: 	positive := 8;
constant CODE_ADDRESS_WIDTH: 	positive := 10;
constant CODE_ADDRESS_LAST: 	positive := 1023;


type fib_code_memory is array(0 to 1023) of std_logic_vector(7 downto 0);

signal fib_uinstruction: std_logic_vector(7 downto 0);

--fib_uinstruction <= fib_microcode(to_integer(unsigned(TODO))); -- copy to file containing the control unit. TODO is typically replace with 'ui_address' control unit output

--
-- L0009.f76: .valfield 2 values * default 0;
--
alias fib_f76: 	std_logic_vector(1 downto 0) is fib_uinstruction(7 downto 6);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f76 <= fib_f76;
---- End boilerplate code

--
-- L0010.f54: .valfield 2 values * default 0;
--
alias fib_f54: 	std_logic_vector(1 downto 0) is fib_uinstruction(5 downto 4);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f54 <= fib_f54;
---- End boilerplate code

--
-- L0011.f32: .valfield 2 values * default 0;
--
alias fib_f32: 	std_logic_vector(1 downto 0) is fib_uinstruction(3 downto 2);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f32 <= fib_f32;
---- End boilerplate code

--
-- L0012.f10: .valfield 2 values * default 0;
--
alias fib_f10: 	std_logic_vector(1 downto 0) is fib_uinstruction(1 downto 0);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f10 <= fib_f10;
---- End boilerplate code

--
-- L0017.opr8: .valfield f76 .. f10 values * default 0;
--
alias fib_opr8: 	std_logic_vector(7 downto 0) is fib_uinstruction(7 downto 0);
-- Values from X"00" to X"FF" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr8 <= fib_opr8;
---- End boilerplate code

--
-- L0019.opr6: .valfield f76 .. f32 values * default 0;
--
alias fib_opr6: 	std_logic_vector(5 downto 0) is fib_uinstruction(7 downto 2);
-- Values from "000000" to "111111" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr6 <= fib_opr6;
---- End boilerplate code

--
-- L0020.val2: .valfield f10 .. f10 values * default 0;
--
alias fib_val2: 	std_logic_vector(1 downto 0) is fib_uinstruction(1 downto 0);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  val2 <= fib_val2;
---- End boilerplate code

--
-- L0022.opr4: .valfield f76 .. f54 values * default 0;
--
alias fib_opr4: 	std_logic_vector(3 downto 0) is fib_uinstruction(7 downto 4);
-- Values from X"0" to X"F" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr4 <= fib_opr4;
---- End boilerplate code

--
-- L0023.val4: .valfield f32 .. f10 values * default 0;
--
alias fib_val4: 	std_logic_vector(3 downto 0) is fib_uinstruction(3 downto 0);
-- Values from X"0" to X"F" allowed
---- Start boilerplate code (use with utmost caution!)
--  val4 <= fib_val4;
---- End boilerplate code

--
-- L0025.opr2: .valfield f76 .. f76 values * default 0;
--
alias fib_opr2: 	std_logic_vector(1 downto 0) is fib_uinstruction(7 downto 6);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr2 <= fib_opr2;
---- End boilerplate code

--
-- L0026.val6: .valfield f54 .. f10 values * default 0;
--
alias fib_val6: 	std_logic_vector(5 downto 0) is fib_uinstruction(5 downto 0);
-- Values from "000000" to "111111" allowed
---- Start boilerplate code (use with utmost caution!)
--  val6 <= fib_val6;
---- End boilerplate code



constant fib_microcode: fib_code_memory := (

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

-- L0032@0007.  opr6 = 0b010000, val2 = 1;
--  opr6 = 010000, val2 = 01;
7 => O"20" & "01",

-- L0033@0008.  opr6 = 0b001000, val2 = 0;
--  opr6 = 001000, val2 = 00;
8 => O"10" & "00",

-- L0035@0009.  opr6 = 0b010001, val2 = 0b10;
--  opr6 = 010001, val2 = 10;
9 => O"21" & "10",

-- L0036@000A.  opr8 = 0x04;
--  opr8 = 00000100;
10 => X"04",

-- L0037@000B.  opr8 = 0x19;
--  opr8 = 00011001;
11 => X"19",

-- L0038@000C.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
12 => O"15" & "11",

-- L0039@000D.  opr8 = 0x04;
--  opr8 = 00000100;
13 => X"04",

-- L0040@000E.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
14 => O"15" & "11",

-- L0041@000F.  opr8 = 0x05;
--  opr8 = 00000101;
15 => X"05",

-- L0043@0010.ADDLOOP:  opr2 = 0b10, val6 = 0b00111111 & @  BCDADD;
--  opr2 = 10, val6 = 011111;
16 => "10" & O"37",

-- L0044@0011.  opr8 = 0x09;
--  opr8 = 00001001;
17 => X"09",

-- L0045@0012.  opr2 = 0b11, val6 = 0b00111111 & @ DEADLOOP;
--  opr2 = 11, val6 = 000011;
18 => "11" & O"03",

-- L0046@0013.  opr4 = 0b0110, val4 = 0xF & ! 14;
--  opr4 = 0110, val4 = 0001;
19 => X"6" & X"1",

-- L0047@0014.  opr2 = 0b10, val6 = 0b00111111 & @  DISP_TTY;
--  opr2 = 10, val6 = 000000;
20 => "10" & O"00",

-- L0049@0015.DISPLOOP:  opr2 = 0b10, val6 = 0b00111111 & @  DISP_LED;
--  opr2 = 10, val6 = 001110;
21 => "10" & O"16",

-- L0050@0016.  opr8 = 0x07;
--  opr8 = 00000111;
22 => X"07",

-- L0051@0017.  opr2 = 0b11, val6 = 0b00111111 & @ DISPLOOP;
--  opr2 = 11, val6 = 010101;
23 => "11" & O"25",

-- L0053@0018.  opr2 = 0b10, val6 = 0b00111111 & @  SHIFT0;
--  opr2 = 10, val6 = 000100;
24 => "10" & O"04",

-- L0055@0019.  opr2 = 0b10, val6 = 0b00111111 & @  SHIFT1;
--  opr2 = 10, val6 = 001001;
25 => "10" & O"11",

-- L0057@001A.  opr2 = 0b11, val6 = 0b00111111 & @ ADDLOOP;
--  opr2 = 11, val6 = 010000;
26 => "11" & O"20",

-- L0063@0380.DISP_TTY:  opr4 = 0b0111, val4 = 12;
--  opr4 = 0111, val4 = 1100;
896 => X"7" & X"C",

-- L0064@0381.  opr8 = 0x0D;
--  opr8 = 00001101;
897 => X"0D",

-- L0065@0382.  opr6 = 0b010010, val2 = 0b10;
--  opr6 = 010010, val2 = 10;
898 => O"22" & "10",

-- L0066@0383.TTYLOOP:  opr4 = 0b0111, val4 = 3;
--  opr4 = 0111, val4 = 0011;
899 => X"7" & X"3",

-- L0067@0384.  opr6 = 0b001110, val2 = 3 & ! 0;
--  opr6 = 001110, val2 = 11;
900 => O"16" & "11",

-- L0068@0385.  opr8 = 0x1A;
--  opr8 = 00011010;
901 => X"1A",

-- L0069@0386.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
902 => O"15" & "11",

-- L0070@0387.  opr2 = 0b11, val6 = 0b00111111 & @ TTYLOOP;
--  opr2 = 11, val6 = 000011;
903 => "11" & O"03",

-- L0071@0388.CRLF:  opr6 = 0b001001, val2 = 3;
--  opr6 = 001001, val2 = 11;
904 => O"11" & "11",

-- L0072@0389.  opr6 = 0b001001, val2 = 2;
--  opr6 = 001001, val2 = 10;
905 => O"11" & "10",

-- L0073@038A.  opr6 = 0b001001, val2 = 1;
--  opr6 = 001001, val2 = 01;
906 => O"11" & "01",

-- L0074@038B.  opr6 = 0b001001, val2 = 0;
--  opr6 = 001001, val2 = 00;
907 => O"11" & "00",

-- L0075@038C.  opr4 = 0b0111, val4 = 0xD;
--  opr4 = 0111, val4 = 1101;
908 => X"7" & X"D",

-- L0076@038D.  opr8 = 0x1A;
--  opr8 = 00011010;
909 => X"1A",

-- L0077@038E.  opr4 = 0b0111, val4 = 0xA;
--  opr4 = 0111, val4 = 1010;
910 => X"7" & X"A",

-- L0078@038F.  opr8 = 0x1A;
--  opr8 = 00011010;
911 => X"1A",

-- L0079@0390.  opr8 = 0x02;
--  opr8 = 00000010;
912 => X"02",

-- L0085@03C0.CLEAR:  opr4 = 0b0111, val4 = 0;
--  opr4 = 0111, val4 = 0000;
960 => X"7" & X"0",

-- L0086@03C1.  opr6 = 0b001100, val2 = 3 & ! 0;
--  opr6 = 001100, val2 = 11;
961 => O"14" & "11",

-- L0087@03C2.  opr2 = 0b11, val6 = 0b00111111 & @ CLEAR;
--  opr2 = 11, val6 = 000000;
962 => "11" & O"00",

-- L0088@03C3.  opr8 = 0x02;
--  opr8 = 00000010;
963 => X"02",

-- L0090@03C4.SHIFT0:  opr6 = 0b010000, val2 = 0b01;
--  opr6 = 010000, val2 = 01;
964 => O"20" & "01",

-- L0091@03C5.SHIFT0LOOP:  opr6 = 0b001111, val2 = 3 & ! 0b01;
--  opr6 = 001111, val2 = 10;
965 => O"17" & "10",

-- L0092@03C6.  opr6 = 0b001100, val2 = 3 & ! 0b01;
--  opr6 = 001100, val2 = 10;
966 => O"14" & "10",

-- L0093@03C7.  opr2 = 0b11, val6 = 0b00111111 & @ SHIFT0LOOP;
--  opr2 = 11, val6 = 000101;
967 => "11" & O"05",

-- L0094@03C8.  opr8 = 0x02;
--  opr8 = 00000010;
968 => X"02",

-- L0096@03C9.SHIFT1:  opr6 = 0b010000, val2 = 0b10;
--  opr6 = 010000, val2 = 10;
969 => O"20" & "10",

-- L0097@03CA.SHIFT1LOOP:  opr6 = 0b001111, val2 = 3 & ! 0b11;
--  opr6 = 001111, val2 = 00;
970 => O"17" & "00",

-- L0098@03CB.  opr6 = 0b001100, val2 = 3 & ! 0b11;
--  opr6 = 001100, val2 = 00;
971 => O"14" & "00",

-- L0099@03CC.  opr2 = 0b11, val6 = 0b00111111 & @ SHIFT1LOOP;
--  opr2 = 11, val6 = 001010;
972 => "11" & O"12",

-- L0100@03CD.  opr8 = 0x02;
--  opr8 = 00000010;
973 => X"02",

-- L0102@03CE.DISP_LED:  opr4 = 0b0111, val4 = 12;
--  opr4 = 0111, val4 = 1100;
974 => X"7" & X"C",

-- L0103@03CF.  opr8 = 0x0D;
--  opr8 = 00001101;
975 => X"0D",

-- L0104@03D0.  opr6 = 0b010010, val2 = 0b10;
--  opr6 = 010010, val2 = 10;
976 => O"22" & "10",

-- L0105@03D1.  opr8 = 0x0B;
--  opr8 = 00001011;
977 => X"0B",

-- L0106@03D2.LEDLOOP:  opr6 = 0b001111, val2 = 3 & ! 0b00;
--  opr6 = 001111, val2 = 11;
978 => O"17" & "11",

-- L0107@03D3.  opr8 = 0x1B;
--  opr8 = 00011011;
979 => X"1B",

-- L0108@03D4.  opr8 = 0x05;
--  opr8 = 00000101;
980 => X"05",

-- L0109@03D5.  opr8 = 0x19;
--  opr8 = 00011001;
981 => X"19",

-- L0110@03D6.  opr8 = 0x00;
--  opr8 = 00000000;
982 => X"00",

-- L0111@03D7.  opr8 = 0x00;
--  opr8 = 00000000;
983 => X"00",

-- L0112@03D8.  opr8 = 0x00;
--  opr8 = 00000000;
984 => X"00",

-- L0113@03D9.  opr8 = 0x00;
--  opr8 = 00000000;
985 => X"00",

-- L0114@03DA.  opr8 = 0x04;
--  opr8 = 00000100;
986 => X"04",

-- L0115@03DB.  opr8 = 0x19;
--  opr8 = 00011001;
987 => X"19",

-- L0116@03DC.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
988 => O"15" & "11",

-- L0117@03DD.  opr2 = 0b11, val6 = 0b00111111 & @ LEDLOOP;
--  opr2 = 11, val6 = 010010;
989 => "11" & O"22",

-- L0118@03DE.  opr8 = 0x02;
--  opr8 = 00000010;
990 => X"02",

-- L0120@03DF.BCDADD:  opr6 = 0b010000, val2 = 0;
--  opr6 = 010000, val2 = 00;
991 => O"20" & "00",

-- L0121@03E0.  opr8 = 0x0B;
--  opr8 = 00001011;
992 => X"0B",

-- L0122@03E1.ALOOP:  opr6 = 0b001111, val2 = 3 & ! 0b01;
--  opr6 = 001111, val2 = 10;
993 => O"17" & "10",

-- L0123@03E2.  opr8 = 0x14;
--  opr8 = 00010100;
994 => X"14",

-- L0124@03E3.  opr2 = 0b10, val6 = 0b00111111 & @ V16_TO_18;
--  opr2 = 10, val6 = 110100;
995 => "10" & O"64",

-- L0125@03E4.  opr2 = 0b10, val6 = 0b00111111 & @ V0_TO_15;
--  opr2 = 10, val6 = 101100;
996 => "10" & O"54",

-- L0126@03E5.  opr8 = 0x0D;
--  opr8 = 00001101;
997 => X"0D",

-- L0127@03E6.  opr4 = 0b0111, val4 = 2;
--  opr4 = 0111, val4 = 0010;
998 => X"7" & X"2",

-- L0128@03E7.  opr8 = 0x11;
--  opr8 = 00010001;
999 => X"11",

-- L0129@03E8.  opr8 = 0x0D;
--  opr8 = 00001101;
1000 => X"0D",

-- L0130@03E9.  opr6 = 0b001100, val2 = 3 & ! 0b10;
--  opr6 = 001100, val2 = 01;
1001 => O"14" & "01",

-- L0131@03EA.  opr2 = 0b11, val6 = 0b00111111 & @ ALOOP;
--  opr2 = 11, val6 = 100001;
1002 => "11" & O"41",

-- L0132@03EB.  opr8 = 0x02;
--  opr8 = 00000010;
1003 => X"02",

-- L0134@03EC.V0_TO_15:  opr8 = 0x0D;
--  opr8 = 00001101;
1004 => X"0D",

-- L0135@03ED.  opr8 = 0x0C;
--  opr8 = 00001100;
1005 => X"0C",

-- L0136@03EE.  opr4 = 0b0101, val4 = 6;
--  opr4 = 0101, val4 = 0110;
1006 => X"5" & X"6",

-- L0137@03EF.  opr2 = 0b11, val6 = 0b00111111 & @ BCDCARRY;
--  opr2 = 11, val6 = 110010;
1007 => "11" & O"62",

-- L0138@03F0.  opr8 = 0x0D;
--  opr8 = 00001101;
1008 => X"0D",

-- L0139@03F1.  opr8 = 0x02;
--  opr8 = 00000010;
1009 => X"02",

-- L0140@03F2.BCDCARRY:  opr8 = 0x0A;
--  opr8 = 00001010;
1010 => X"0A",

-- L0141@03F3.  opr8 = 0x02;
--  opr8 = 00000010;
1011 => X"02",

-- L0143@03F4.V16_TO_18:  opr4 = 0b0101, val4 = 6;
--  opr4 = 0101, val4 = 0110;
1012 => X"5" & X"6",

-- L0144@03F5.  opr8 = 0x00;
--  opr8 = 00000000;
1013 => X"00",

-- L0145@03F6.  opr8 = 0x0A;
--  opr8 = 00001010;
1014 => X"0A",

-- L0146@03F7.  opr8 = 0x03;
--  opr8 = 00000011;
1015 => X"03",

-- 924 location(s) in following ranges will be filled with default value
-- 001B .. 037F
-- 0391 .. 03BF
-- 03F8 .. 03FF

others => "00" & "00" & "00" & "00"
);

end fibonacci_code;

