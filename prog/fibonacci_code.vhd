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

-- L0020@0000.  opr8 = 0x00;
--  opr8 = 00000000;
0 => X"00",

-- L0027@0001.  opr4 = 0b0111, val4 = 0b1000;
--  opr4 = 0111, val4 = 1000;
1 => X"7" & X"8",

-- L0028@0002.  opr8 = 0x0F;
--  opr8 = 00001111;
2 => X"0F",

-- L0030@0003.  opr6 = 0b010000, val2 = 0;
--  opr6 = 010000, val2 = 00;
3 => O"20" & "00",

-- L0031@0004.  opr2 = 0b10, val6 = 0b00111111 & @  CLEAR;
--  opr2 = 10, val6 = 000000;
4 => "10" & O"00",

-- L0033@0005.  opr6 = 0b010000, val2 = 1;
--  opr6 = 010000, val2 = 01;
5 => O"20" & "01",

-- L0034@0006.  opr2 = 0b10, val6 = 0b00111111 & @  CLEAR;
--  opr2 = 10, val6 = 000000;
6 => "10" & O"00",

-- L0036@0007.  opr6 = 0b010000, val2 = 1;
--  opr6 = 010000, val2 = 01;
7 => O"20" & "01",

-- L0037@0008.  opr6 = 0b001000, val2 = 0;
--  opr6 = 001000, val2 = 00;
8 => O"10" & "00",

-- L0039@0009.ADDLOOP:  opr2 = 0b10, val6 = 0b00111111 & @  BCDADD;
--  opr2 = 10, val6 = 100010;
9 => "10" & O"42",

-- L0040@000A.  opr4 = 0b0110, val4 = 0xF & ! 14;
--  opr4 = 0110, val4 = 0001;
10 => X"6" & X"1",

-- L0041@000B.  opr2 = 0b10, val6 = 0b00111111 & @  DISP_TTY;
--  opr2 = 10, val6 = 000000;
11 => "10" & O"00",

-- L0043@000C.DISPLOOP:  opr8 = 0x00;
--  opr8 = 00000000;
12 => X"00",

-- L0044@000D.  opr8 = 0x07;
--  opr8 = 00000111;
13 => X"07",

-- L0045@000E.  opr2 = 0b11, val6 = 0b00111111 & @ DISPLOOP;
--  opr2 = 11, val6 = 001100;
14 => "11" & O"14",

-- L0047@000F.  opr2 = 0b10, val6 = 0b00111111 & @  SHIFT0;
--  opr2 = 10, val6 = 000100;
15 => "10" & O"04",

-- L0049@0010.  opr2 = 0b10, val6 = 0b00111111 & @  SHIFT1;
--  opr2 = 10, val6 = 001001;
16 => "10" & O"11",

-- L0051@0011.  opr2 = 0b11, val6 = 0b00111111 & @ ADDLOOP;
--  opr2 = 11, val6 = 001001;
17 => "11" & O"11",

-- L0056@0380.DISP_TTY:  opr6 = 0b010001, val2 = 0b10;
--  opr6 = 010001, val2 = 10;
896 => O"21" & "10",

-- L0057@0381.  opr8 = 0x05;
--  opr8 = 00000101;
897 => X"05",

-- L0058@0382.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
898 => O"15" & "11",

-- L0059@0383.  opr8 = 0x04;
--  opr8 = 00000100;
899 => X"04",

-- L0060@0384.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
900 => O"15" & "11",

-- L0061@0385.  opr8 = 0x05;
--  opr8 = 00000101;
901 => X"05",

-- L0062@0386.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
902 => O"15" & "11",

-- L0063@0387.TTYLOOP:  opr4 = 0b0111, val4 = 3;
--  opr4 = 0111, val4 = 0011;
903 => X"7" & X"3",

-- L0064@0388.  opr6 = 0b001110, val2 = 3 & ! 0;
--  opr6 = 001110, val2 = 11;
904 => O"16" & "11",

-- L0065@0389.  opr8 = 0x1A;
--  opr8 = 00011010;
905 => X"1A",

-- L0066@038A.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
906 => O"15" & "11",

-- L0067@038B.  opr2 = 0b11, val6 = 0b00111111 & @ TTYLOOP;
--  opr2 = 11, val6 = 000111;
907 => "11" & O"07",

-- L0068@038C.  opr6 = 0b001001, val2 = 3;
--  opr6 = 001001, val2 = 11;
908 => O"11" & "11",

-- L0069@038D.  opr6 = 0b001001, val2 = 2;
--  opr6 = 001001, val2 = 10;
909 => O"11" & "10",

-- L0070@038E.  opr6 = 0b001001, val2 = 1;
--  opr6 = 001001, val2 = 01;
910 => O"11" & "01",

-- L0071@038F.  opr6 = 0b001001, val2 = 0;
--  opr6 = 001001, val2 = 00;
911 => O"11" & "00",

-- L0072@0390.  opr4 = 0b0111, val4 = 0xD;
--  opr4 = 0111, val4 = 1101;
912 => X"7" & X"D",

-- L0073@0391.  opr8 = 0x1A;
--  opr8 = 00011010;
913 => X"1A",

-- L0074@0392.  opr4 = 0b0111, val4 = 0xA;
--  opr4 = 0111, val4 = 1010;
914 => X"7" & X"A",

-- L0075@0393.  opr8 = 0x1A;
--  opr8 = 00011010;
915 => X"1A",

-- L0076@0394.  opr8 = 0x02;
--  opr8 = 00000010;
916 => X"02",

-- L0081@03C0.CLEAR:  opr4 = 0b0111, val4 = 0;
--  opr4 = 0111, val4 = 0000;
960 => X"7" & X"0",

-- L0082@03C1.  opr6 = 0b001100, val2 = 3 & ! 0;
--  opr6 = 001100, val2 = 11;
961 => O"14" & "11",

-- L0083@03C2.  opr2 = 0b11, val6 = 0b00111111 & @ CLEAR;
--  opr2 = 11, val6 = 000000;
962 => "11" & O"00",

-- L0084@03C3.  opr8 = 0x02;
--  opr8 = 00000010;
963 => X"02",

-- L0086@03C4.SHIFT0:  opr6 = 0b010000, val2 = 0b01;
--  opr6 = 010000, val2 = 01;
964 => O"20" & "01",

-- L0087@03C5.SHIFT0LOOP:  opr6 = 0b001111, val2 = 3 & ! 0b01;
--  opr6 = 001111, val2 = 10;
965 => O"17" & "10",

-- L0088@03C6.  opr6 = 0b001100, val2 = 3 & ! 0b01;
--  opr6 = 001100, val2 = 10;
966 => O"14" & "10",

-- L0089@03C7.  opr2 = 0b11, val6 = 0b00111111 & @ SHIFT0LOOP;
--  opr2 = 11, val6 = 000101;
967 => "11" & O"05",

-- L0090@03C8.  opr8 = 0x02;
--  opr8 = 00000010;
968 => X"02",

-- L0092@03C9.SHIFT1:  opr6 = 0b010000, val2 = 0b10;
--  opr6 = 010000, val2 = 10;
969 => O"20" & "10",

-- L0093@03CA.SHIFT1LOOP:  opr6 = 0b001111, val2 = 3 & ! 0b11;
--  opr6 = 001111, val2 = 00;
970 => O"17" & "00",

-- L0094@03CB.  opr6 = 0b001100, val2 = 3 & ! 0b11;
--  opr6 = 001100, val2 = 00;
971 => O"14" & "00",

-- L0095@03CC.  opr2 = 0b11, val6 = 0b00111111 & @ SHIFT1LOOP;
--  opr2 = 11, val6 = 001010;
972 => "11" & O"12",

-- L0096@03CD.  opr8 = 0x02;
--  opr8 = 00000010;
973 => X"02",

-- L0098@03CE.DISP_LED:  opr6 = 0b010001, val2 = 0b10;
--  opr6 = 010001, val2 = 10;
974 => O"21" & "10",

-- L0099@03CF.  opr8 = 0x05;
--  opr8 = 00000101;
975 => X"05",

-- L0100@03D0.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
976 => O"15" & "11",

-- L0101@03D1.  opr8 = 0x04;
--  opr8 = 00000100;
977 => X"04",

-- L0102@03D2.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
978 => O"15" & "11",

-- L0103@03D3.  opr8 = 0x05;
--  opr8 = 00000101;
979 => X"05",

-- L0104@03D4.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
980 => O"15" & "11",

-- L0105@03D5.  opr8 = 0x0B;
--  opr8 = 00001011;
981 => X"0B",

-- L0106@03D6.LEDLOOP:  opr6 = 0b001111, val2 = 3 & ! 0b00;
--  opr6 = 001111, val2 = 11;
982 => O"17" & "11",

-- L0107@03D7.  opr8 = 0x04;
--  opr8 = 00000100;
983 => X"04",

-- L0108@03D8.  opr8 = 0x19;
--  opr8 = 00011001;
984 => X"19",

-- L0109@03D9.  opr8 = 0x1B;
--  opr8 = 00011011;
985 => X"1B",

-- L0110@03DA.  opr8 = 0x00;
--  opr8 = 00000000;
986 => X"00",

-- L0111@03DB.  opr8 = 0x00;
--  opr8 = 00000000;
987 => X"00",

-- L0112@03DC.  opr8 = 0x00;
--  opr8 = 00000000;
988 => X"00",

-- L0113@03DD.  opr8 = 0x05;
--  opr8 = 00000101;
989 => X"05",

-- L0114@03DE.  opr8 = 0x19;
--  opr8 = 00011001;
990 => X"19",

-- L0115@03DF.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
991 => O"15" & "11",

-- L0116@03E0.  opr2 = 0b11, val6 = 0b00111111 & @ LEDLOOP;
--  opr2 = 11, val6 = 010110;
992 => "11" & O"26",

-- L0117@03E1.  opr8 = 0x02;
--  opr8 = 00000010;
993 => X"02",

-- L0119@03E2.BCDADD:  opr6 = 0b010000, val2 = 0;
--  opr6 = 010000, val2 = 00;
994 => O"20" & "00",

-- L0120@03E3.  opr8 = 0x0B;
--  opr8 = 00001011;
995 => X"0B",

-- L0121@03E4.ALOOP:  opr6 = 0b001111, val2 = 3 & ! 0b01;
--  opr6 = 001111, val2 = 10;
996 => O"17" & "10",

-- L0122@03E5.  opr8 = 0x14;
--  opr8 = 00010100;
997 => X"14",

-- L0123@03E6.  opr2 = 0b10, val6 = 0b00111111 & @ V16_TO_18;
--  opr2 = 10, val6 = 110101;
998 => "10" & O"65",

-- L0124@03E7.  opr2 = 0b10, val6 = 0b00111111 & @ V0_TO_15;
--  opr2 = 10, val6 = 101111;
999 => "10" & O"57",

-- L0125@03E8.  opr8 = 0x0D;
--  opr8 = 00001101;
1000 => X"0D",

-- L0126@03E9.  opr4 = 0b0111, val4 = 2;
--  opr4 = 0111, val4 = 0010;
1001 => X"7" & X"2",

-- L0127@03EA.  opr8 = 0x11;
--  opr8 = 00010001;
1002 => X"11",

-- L0128@03EB.  opr8 = 0x0D;
--  opr8 = 00001101;
1003 => X"0D",

-- L0129@03EC.  opr6 = 0b001100, val2 = 3 & ! 0b10;
--  opr6 = 001100, val2 = 01;
1004 => O"14" & "01",

-- L0130@03ED.  opr2 = 0b11, val6 = 0b00111111 & @ ALOOP;
--  opr2 = 11, val6 = 100100;
1005 => "11" & O"44",

-- L0131@03EE.  opr8 = 0x02;
--  opr8 = 00000010;
1006 => X"02",

-- L0133@03EF.V0_TO_15:  opr8 = 0x0D;
--  opr8 = 00001101;
1007 => X"0D",

-- L0134@03F0.  opr8 = 0x0C;
--  opr8 = 00001100;
1008 => X"0C",

-- L0135@03F1.  opr4 = 0b0101, val4 = 6;
--  opr4 = 0101, val4 = 0110;
1009 => X"5" & X"6",

-- L0136@03F2.  opr8 = 0x02;
--  opr8 = 00000010;
1010 => X"02",

-- L0137@03F3.  opr8 = 0x0D;
--  opr8 = 00001101;
1011 => X"0D",

-- L0138@03F4.  opr8 = 0x02;
--  opr8 = 00000010;
1012 => X"02",

-- L0140@03F5.V16_TO_18:  opr4 = 0b0101, val4 = 5;
--  opr4 = 0101, val4 = 0101;
1013 => X"5" & X"5",

-- L0141@03F6.  opr8 = 0x0A;
--  opr8 = 00001010;
1014 => X"0A",

-- L0142@03F7.  opr8 = 0x03;
--  opr8 = 00000011;
1015 => X"03",

-- 929 location(s) in following ranges will be filled with default value
-- 0012 .. 037F
-- 0395 .. 03BF
-- 03F8 .. 03FF

others => "00" & "00" & "00" & "00"
);

end fibonacci_code;

