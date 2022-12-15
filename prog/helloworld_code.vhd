--------------------------------------------------------
-- mcc V1.2.1210 - Custom microcode compiler (c)2020-... 
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
-- L0010.f76: .valfield 2 values * default 0;
--
alias hlw_f76: 	std_logic_vector(1 downto 0) is hlw_uinstruction(7 downto 6);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f76 <= hlw_f76;
---- End boilerplate code

--
-- L0011.f54: .valfield 2 values * default 0;
--
alias hlw_f54: 	std_logic_vector(1 downto 0) is hlw_uinstruction(5 downto 4);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f54 <= hlw_f54;
---- End boilerplate code

--
-- L0012.f32: .valfield 2 values * default 0;
--
alias hlw_f32: 	std_logic_vector(1 downto 0) is hlw_uinstruction(3 downto 2);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f32 <= hlw_f32;
---- End boilerplate code

--
-- L0013.f10: .valfield 2 values * default 0;
--
alias hlw_f10: 	std_logic_vector(1 downto 0) is hlw_uinstruction(1 downto 0);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  f10 <= hlw_f10;
---- End boilerplate code

--
-- L0018.opr8: .valfield f76 .. f10 values * default 0;
--
alias hlw_opr8: 	std_logic_vector(7 downto 0) is hlw_uinstruction(7 downto 0);
-- Values from X"00" to X"FF" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr8 <= hlw_opr8;
---- End boilerplate code

--
-- L0020.opr6: .valfield f76 .. f32 values * default 0;
--
alias hlw_opr6: 	std_logic_vector(5 downto 0) is hlw_uinstruction(7 downto 2);
-- Values from "000000" to "111111" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr6 <= hlw_opr6;
---- End boilerplate code

--
-- L0021.val2: .valfield f10 .. f10 values * default 0;
--
alias hlw_val2: 	std_logic_vector(1 downto 0) is hlw_uinstruction(1 downto 0);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  val2 <= hlw_val2;
---- End boilerplate code

--
-- L0023.opr4: .valfield f76 .. f54 values * default 0;
--
alias hlw_opr4: 	std_logic_vector(3 downto 0) is hlw_uinstruction(7 downto 4);
-- Values from X"0" to X"F" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr4 <= hlw_opr4;
---- End boilerplate code

--
-- L0024.val4: .valfield f32 .. f10 values * default 0;
--
alias hlw_val4: 	std_logic_vector(3 downto 0) is hlw_uinstruction(3 downto 0);
-- Values from X"0" to X"F" allowed
---- Start boilerplate code (use with utmost caution!)
--  val4 <= hlw_val4;
---- End boilerplate code

--
-- L0026.opr2: .valfield f76 .. f76 values * default 0;
--
alias hlw_opr2: 	std_logic_vector(1 downto 0) is hlw_uinstruction(7 downto 6);
-- Values from "00" to "11" allowed
---- Start boilerplate code (use with utmost caution!)
--  opr2 <= hlw_opr2;
---- End boilerplate code

--
-- L0027.val6: .valfield f54 .. f10 values * default 0;
--
alias hlw_val6: 	std_logic_vector(5 downto 0) is hlw_uinstruction(5 downto 0);
-- Values from "000000" to "111111" allowed
---- Start boilerplate code (use with utmost caution!)
--  val6 <= hlw_val6;
---- End boilerplate code



constant hlw_microcode: hlw_code_memory := (

-- L0032@0000.  opr8 = 0x00;
--  opr8 = 00000000;
0 => X"00",

-- L0034@0001.  opr4 = 0b0111, val4 = 0b1000;
--  opr4 = 0111, val4 = 1000;
1 => X"7" & X"8",

-- L0035@0002.  opr8 = 0x0F;
--  opr8 = 00001111;
2 => X"0F",

-- L0037@0003.  opr6 = 0b010001, val2 = 0b10;
--  opr6 = 010001, val2 = 10;
3 => O"21" & "10",

-- L0038@0004.  opr8 = 0x04;
--  opr8 = 00000100;
4 => X"04",

-- L0039@0005.  opr8 = 0x19;
--  opr8 = 00011001;
5 => X"19",

-- L0040@0006.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
6 => O"15" & "11",

-- L0041@0007.  opr8 = 0x04;
--  opr8 = 00000100;
7 => X"04",

-- L0042@0008.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
8 => O"15" & "11",

-- L0043@0009.  opr8 = 0x05;
--  opr8 = 00000101;
9 => X"05",

-- L0045@000A.  opr2 = 0b10, val6 = 0b00111111 & @ INIT_LED1;
--  opr2 = 10, val6 = 001000;
10 => "10" & O"10",

-- L0046@000B.  opr2 = 0b10, val6 = 0b00111111 & @ INIT_LED0;
--  opr2 = 10, val6 = 000110;
11 => "10" & O"06",

-- L0048@000C.GREETINGS:  opr6 = 0b010000, val2 = 0b11;
--  opr6 = 010000, val2 = 11;
12 => O"20" & "11",

-- L0049@000D.  opr2 = 0b10, val6 = 0b00111111 & @ CRLF;
--  opr2 = 10, val6 = 001100;
13 => "10" & O"14",

-- L0050@000E.  opr2 = 0b10, val6 = 0b00111111 & @ H;
--  opr2 = 10, val6 = 011000;
14 => "10" & O"30",

-- L0051@000F.  opr2 = 0b10, val6 = 0b00111111 & @ E;
--  opr2 = 10, val6 = 011001;
15 => "10" & O"31",

-- L0052@0010.  opr2 = 0b10, val6 = 0b00111111 & @ L;
--  opr2 = 10, val6 = 011010;
16 => "10" & O"32",

-- L0053@0011.  opr2 = 0b10, val6 = 0b00111111 & @ L;
--  opr2 = 10, val6 = 011010;
17 => "10" & O"32",

-- L0054@0012.  opr2 = 0b10, val6 = 0b00111111 & @ O;
--  opr2 = 10, val6 = 011011;
18 => "10" & O"33",

-- L0055@0013.  opr2 = 0b10, val6 = 0b00111111 & @ SPACE;
--  opr2 = 10, val6 = 100111;
19 => "10" & O"47",

-- L0056@0014.  opr2 = 0b10, val6 = 0b00111111 & @ W;
--  opr2 = 10, val6 = 100000;
20 => "10" & O"40",

-- L0057@0015.  opr2 = 0b10, val6 = 0b00111111 & @ O;
--  opr2 = 10, val6 = 011011;
21 => "10" & O"33",

-- L0058@0016.  opr2 = 0b10, val6 = 0b00111111 & @ R;
--  opr2 = 10, val6 = 100001;
22 => "10" & O"41",

-- L0059@0017.  opr2 = 0b10, val6 = 0b00111111 & @ L;
--  opr2 = 10, val6 = 011010;
23 => "10" & O"32",

-- L0060@0018.  opr2 = 0b10, val6 = 0b00111111 & @ D;
--  opr2 = 10, val6 = 011100;
24 => "10" & O"34",

-- L0061@0019.  opr2 = 0b10, val6 = 0b00111111 & @ EXCPOINT;
--  opr2 = 10, val6 = 101000;
25 => "10" & O"50",

-- L0062@001A.  opr2 = 0b10, val6 = 0b00111111 & @ CRLF;
--  opr2 = 10, val6 = 001100;
26 => "10" & O"14",

-- L0064@001B.DISPLOOP:  opr2 = 0b10, val6 = 0b00111111 & @ DISP_LED;
--  opr2 = 10, val6 = 001010;
27 => "10" & O"12",

-- L0065@001C.  opr8 = 0x07;
--  opr8 = 00000111;
28 => X"07",

-- L0066@001D.  opr2 = 0b11, val6 = 0b00111111 & @ DISPLOOP;
--  opr2 = 11, val6 = 011011;
29 => "11" & O"33",

-- L0067@001E.  opr6 = 0b010001, val2 = 0b00;
--  opr6 = 010001, val2 = 00;
30 => O"21" & "00",

-- L0068@001F.  opr2 = 0b10, val6 = 0b00111111 & @ ROTATE;
--  opr2 = 10, val6 = 000000;
31 => "10" & O"00",

-- L0069@0020.  opr6 = 0b010001, val2 = 0b01;
--  opr6 = 010001, val2 = 01;
32 => O"21" & "01",

-- L0070@0021.  opr2 = 0b10, val6 = 0b00111111 & @ ROTATE;
--  opr2 = 10, val6 = 000000;
33 => "10" & O"00",

-- L0071@0022.  opr2 = 0b11, val6 = 0b00111111 & @ GREETINGS;
--  opr2 = 11, val6 = 001100;
34 => "11" & O"14",

-- L0077@0340.INITLED1_:  opr6 = 0b010001, val2 = 1;
--  opr6 = 010001, val2 = 01;
832 => O"21" & "01",

-- L0078@0341.  opr2 = 0b10, val6 = 0b00111111 & @ CLEAR4;
--  opr2 = 10, val6 = 101101;
833 => "10" & O"55",

-- L0079@0342.  opr4 = 0b0111, val4 = 0b00110111 / 16;
--  opr4 = 0111, val4 = 0011;
834 => X"7" & X"3",

-- L0080@0343.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
835 => O"15" & "11",

-- L0081@0344.  opr4 = 0b0111, val4 = 0b01001111 / 16;
--  opr4 = 0111, val4 = 0100;
836 => X"7" & X"4",

-- L0082@0345.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
837 => O"15" & "11",

-- L0083@0346.  opr4 = 0b0111, val4 = 0b00001110 / 16;
--  opr4 = 0111, val4 = 0000;
838 => X"7" & X"0",

-- L0084@0347.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
839 => O"15" & "11",

-- L0085@0348.  opr4 = 0b0111, val4 = 0b00001110 / 16;
--  opr4 = 0111, val4 = 0000;
840 => X"7" & X"0",

-- L0086@0349.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
841 => O"15" & "11",

-- L0087@034A.  opr4 = 0b0111, val4 = 0b00011101 / 16;
--  opr4 = 0111, val4 = 0001;
842 => X"7" & X"1",

-- L0088@034B.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
843 => O"15" & "11",

-- L0089@034C.  opr4 = 0b0111, val4 = 0b00000000 / 16;
--  opr4 = 0111, val4 = 0000;
844 => X"7" & X"0",

-- L0090@034D.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
845 => O"15" & "11",

-- L0091@034E.  opr4 = 0b0111, val4 = 0b00111111 / 16;
--  opr4 = 0111, val4 = 0011;
846 => X"7" & X"3",

-- L0092@034F.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
847 => O"15" & "11",

-- L0093@0350.  opr4 = 0b0111, val4 = 0b00011101 / 16;
--  opr4 = 0111, val4 = 0001;
848 => X"7" & X"1",

-- L0094@0351.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
849 => O"15" & "11",

-- L0095@0352.  opr4 = 0b0111, val4 = 0b00000101 / 16;
--  opr4 = 0111, val4 = 0000;
850 => X"7" & X"0",

-- L0096@0353.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
851 => O"15" & "11",

-- L0097@0354.  opr4 = 0b0111, val4 = 0b00001110 / 16;
--  opr4 = 0111, val4 = 0000;
852 => X"7" & X"0",

-- L0098@0355.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
853 => O"15" & "11",

-- L0099@0356.  opr4 = 0b0111, val4 = 0b00111101 / 16;
--  opr4 = 0111, val4 = 0011;
854 => X"7" & X"3",

-- L0100@0357.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
855 => O"15" & "11",

-- L0101@0358.  opr4 = 0b0111, val4 = 0b10110000 / 16;
--  opr4 = 0111, val4 = 1011;
856 => X"7" & X"B",

-- L0102@0359.  opr2 = 0b11, val6 = 0b00111111 & @ INIT_DONE;
--  opr2 = 11, val6 = 110011;
857 => "11" & O"63",

-- L0104@035A.INITLED0_:  opr6 = 0b010001, val2 = 0;
--  opr6 = 010001, val2 = 00;
858 => O"21" & "00",

-- L0105@035B.  opr2 = 0b10, val6 = 0b00111111 & @ CLEAR4;
--  opr2 = 10, val6 = 101101;
859 => "10" & O"55",

-- L0106@035C.  opr4 = 0b0111, val4 = 0xF & 0b00110111;
--  opr4 = 0111, val4 = 0111;
860 => X"7" & X"7",

-- L0107@035D.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
861 => O"15" & "11",

-- L0108@035E.  opr4 = 0b0111, val4 = 0xF & 0b01001111;
--  opr4 = 0111, val4 = 1111;
862 => X"7" & X"F",

-- L0109@035F.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
863 => O"15" & "11",

-- L0110@0360.  opr4 = 0b0111, val4 = 0xF & 0b00001110;
--  opr4 = 0111, val4 = 1110;
864 => X"7" & X"E",

-- L0111@0361.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
865 => O"15" & "11",

-- L0112@0362.  opr4 = 0b0111, val4 = 0xF & 0b00001110;
--  opr4 = 0111, val4 = 1110;
866 => X"7" & X"E",

-- L0113@0363.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
867 => O"15" & "11",

-- L0114@0364.  opr4 = 0b0111, val4 = 0xF & 0b00011101;
--  opr4 = 0111, val4 = 1101;
868 => X"7" & X"D",

-- L0115@0365.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
869 => O"15" & "11",

-- L0116@0366.  opr4 = 0b0111, val4 = 0xF & 0b00000000;
--  opr4 = 0111, val4 = 0000;
870 => X"7" & X"0",

-- L0117@0367.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
871 => O"15" & "11",

-- L0118@0368.  opr4 = 0b0111, val4 = 0xF & 0b00111111;
--  opr4 = 0111, val4 = 1111;
872 => X"7" & X"F",

-- L0119@0369.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
873 => O"15" & "11",

-- L0120@036A.  opr4 = 0b0111, val4 = 0xF & 0b00011101;
--  opr4 = 0111, val4 = 1101;
874 => X"7" & X"D",

-- L0121@036B.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
875 => O"15" & "11",

-- L0122@036C.  opr4 = 0b0111, val4 = 0xF & 0b00000101;
--  opr4 = 0111, val4 = 0101;
876 => X"7" & X"5",

-- L0123@036D.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
877 => O"15" & "11",

-- L0124@036E.  opr4 = 0b0111, val4 = 0xF & 0b00001110;
--  opr4 = 0111, val4 = 1110;
878 => X"7" & X"E",

-- L0125@036F.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
879 => O"15" & "11",

-- L0126@0370.  opr4 = 0b0111, val4 = 0xF & 0b00111101;
--  opr4 = 0111, val4 = 1101;
880 => X"7" & X"D",

-- L0127@0371.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
881 => O"15" & "11",

-- L0128@0372.  opr4 = 0b0111, val4 = 0xF & 0b10110000;
--  opr4 = 0111, val4 = 0000;
882 => X"7" & X"0",

-- L0129@0373.INIT_DONE:  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
883 => O"15" & "11",

-- L0130@0374.  opr8 = 0x02;
--  opr8 = 00000010;
884 => X"02",

-- L0131@0375.  opr8 = 0x02;
--  opr8 = 00000010;
885 => X"02",

-- L0137@0380.DISP_LED_:  opr4 = 0b0111, val4 = 12;
--  opr4 = 0111, val4 = 1100;
896 => X"7" & X"C",

-- L0138@0381.  opr8 = 0x0D;
--  opr8 = 00001101;
897 => X"0D",

-- L0139@0382.  opr6 = 0b010010, val2 = 0b00;
--  opr6 = 010010, val2 = 00;
898 => O"22" & "00",

-- L0140@0383.LEDLOOP:  opr6 = 0b001111, val2 = 3 & ! 0b01;
--  opr6 = 001111, val2 = 10;
899 => O"17" & "10",

-- L0141@0384.  opr8 = 0x18;
--  opr8 = 00011000;
900 => X"18",

-- L0142@0385.  opr8 = 0x05;
--  opr8 = 00000101;
901 => X"05",

-- L0143@0386.  opr8 = 0x19;
--  opr8 = 00011001;
902 => X"19",

-- L0144@0387.  opr8 = 0x00;
--  opr8 = 00000000;
903 => X"00",

-- L0145@0388.  opr8 = 0x00;
--  opr8 = 00000000;
904 => X"00",

-- L0146@0389.  opr8 = 0x04;
--  opr8 = 00000100;
905 => X"04",

-- L0147@038A.  opr8 = 0x19;
--  opr8 = 00011001;
906 => X"19",

-- L0148@038B.  opr6 = 0b001111, val2 = 3 & ! 0b00;
--  opr6 = 001111, val2 = 11;
907 => O"17" & "11",

-- L0149@038C.  opr6 = 0b001101, val2 = 3 & ! 0b01;
--  opr6 = 001101, val2 = 10;
908 => O"15" & "10",

-- L0150@038D.  opr2 = 0b11, val6 = 0b00111111 & @ LEDLOOP;
--  opr2 = 11, val6 = 000011;
909 => "11" & O"03",

-- L0151@038E.  opr8 = 0x02;
--  opr8 = 00000010;
910 => X"02",

-- L0157@03C0.ROTATE:  opr6 = 0b001111, val2 = 3 & ! 0b00;
--  opr6 = 001111, val2 = 11;
960 => O"17" & "11",

-- L0158@03C1.  opr6 = 0b001100, val2 = 3 & ! 0b00;
--  opr6 = 001100, val2 = 11;
961 => O"14" & "11",

-- L0159@03C2.  opr8 = 0x00;
--  opr8 = 00000000;
962 => X"00",

-- L0160@03C3.ROTLOOP:  opr6 = 0b001100, val2 = 3 & ! 0b00;
--  opr6 = 001100, val2 = 11;
963 => O"14" & "11",

-- L0161@03C4.  opr2 = 0b11, val6 = 0b00111111 & @ ROTLOOP;
--  opr2 = 11, val6 = 000011;
964 => "11" & O"03",

-- L0162@03C5.  opr8 = 0x02;
--  opr8 = 00000010;
965 => X"02",

-- L0164@03C6.INIT_LED0:  opr4 = 0b0110, val4 = 0xF & ! 13;
--  opr4 = 0110, val4 = 0010;
966 => X"6" & X"2",

-- L0165@03C7.  opr2 = 0b11, val6 = 0b00111111 & @ INITLED0_;
--  opr2 = 11, val6 = 011010;
967 => "11" & O"32",

-- L0167@03C8.INIT_LED1:  opr4 = 0b0110, val4 = 0xF & ! 13;
--  opr4 = 0110, val4 = 0010;
968 => X"6" & X"2",

-- L0168@03C9.  opr2 = 0b11, val6 = 0b00111111 & @ INITLED1_;
--  opr2 = 11, val6 = 000000;
969 => "11" & O"00",

-- L0170@03CA.DISP_LED:  opr4 = 0b0110, val4 = 0xF & ! 14;
--  opr4 = 0110, val4 = 0001;
970 => X"6" & X"1",

-- L0171@03CB.  opr2 = 0b11, val6 = 0b00111111 & @ DISP_LED_;
--  opr2 = 11, val6 = 000000;
971 => "11" & O"00",

-- L0173@03CC.CRLF:  opr4 = 0b0111, val4 = 0xD;
--  opr4 = 0111, val4 = 1101;
972 => X"7" & X"D",

-- L0174@03CD.  opr2 = 0b10, val6 = 0b00111111 & @ OUT_0;
--  opr2 = 10, val6 = 001111;
973 => "10" & O"17",

-- L0175@03CE.  opr4 = 0b0111, val4 = 0xA;
--  opr4 = 0111, val4 = 1010;
974 => X"7" & X"A",

-- L0176@03CF.OUT_0:  opr6 = 0b001001, val2 = 3;
--  opr6 = 001001, val2 = 11;
975 => O"11" & "11",

-- L0177@03D0.  opr6 = 0b001001, val2 = 2;
--  opr6 = 001001, val2 = 10;
976 => O"11" & "10",

-- L0178@03D1.OUT_xx00:  opr6 = 0b001001, val2 = 1;
--  opr6 = 001001, val2 = 01;
977 => O"11" & "01",

-- L0179@03D2.OUT_xxx0:  opr6 = 0b001001, val2 = 0;
--  opr6 = 001001, val2 = 00;
978 => O"11" & "00",

-- L0180@03D3.UART_OUT:  opr8 = 0x1A;
--  opr8 = 00011010;
979 => X"1A",

-- L0181@03D4.UART_WAIT:  opr4 = 0b0111, val4 = 1;
--  opr4 = 0111, val4 = 0001;
980 => X"7" & X"1",

-- L0182@03D5.  opr8 = 0x29;
--  opr8 = 00101001;
981 => X"29",

-- L0183@03D6.  opr8 = 0x02;
--  opr8 = 00000010;
982 => X"02",

-- L0184@03D7.  opr2 = 0b11, val6 = 0b00111111 & @ UART_WAIT;
--  opr2 = 11, val6 = 010100;
983 => "11" & O"24",

-- L0186@03D8.H:  opr4 = 0b0111, val4 = 0x0F & 'H';
--  opr4 = 0111, val4 = 1000;
984 => X"7" & X"8",

-- L0187@03D9.E:  opr4 = 0b0111, val4 = 0x0F & 'E';
--  opr4 = 0111, val4 = 0101;
985 => X"7" & X"5",

-- L0188@03DA.L:  opr4 = 0b0111, val4 = 0x0F & 'L';
--  opr4 = 0111, val4 = 1100;
986 => X"7" & X"C",

-- L0189@03DB.O:  opr4 = 0b0111, val4 = 0x0F & 'O';
--  opr4 = 0111, val4 = 1111;
987 => X"7" & X"F",

-- L0190@03DC.D:  opr4 = 0b0111, val4 = 0x0F & 'D';
--  opr4 = 0111, val4 = 0100;
988 => X"7" & X"4",

-- L0191@03DD.OUT_4:  opr6 = 0b001001, val2 = 3;
--  opr6 = 001001, val2 = 11;
989 => O"11" & "11",

-- L0192@03DE.  opr6 = 0b001000, val2 = 2;
--  opr6 = 001000, val2 = 10;
990 => O"10" & "10",

-- L0193@03DF.  opr2 = 0b11, val6 = 0b00111111 & @ OUT_xx00;
--  opr2 = 11, val6 = 010001;
991 => "11" & O"21",

-- L0195@03E0.W:  opr4 = 0b0111, val4 = 0x0F & 'W';
--  opr4 = 0111, val4 = 0111;
992 => X"7" & X"7",

-- L0196@03E1.R:  opr4 = 0b0111, val4 = 0x0F & 'R';
--  opr4 = 0111, val4 = 0010;
993 => X"7" & X"2",

-- L0197@03E2.OUT_5:  opr6 = 0b001001, val2 = 3;
--  opr6 = 001001, val2 = 11;
994 => O"11" & "11",

-- L0198@03E3.  opr6 = 0b001000, val2 = 2;
--  opr6 = 001000, val2 = 10;
995 => O"10" & "10",

-- L0199@03E4.  opr6 = 0b001001, val2 = 1;
--  opr6 = 001001, val2 = 01;
996 => O"11" & "01",

-- L0200@03E5.  opr6 = 0b001000, val2 = 0;
--  opr6 = 001000, val2 = 00;
997 => O"10" & "00",

-- L0201@03E6.  opr2 = 0b11, val6 = 0b00111111 & @ UART_OUT;
--  opr2 = 11, val6 = 010011;
998 => "11" & O"23",

-- L0203@03E7.SPACE:  opr4 = 0b0111, val4 = 0x0F & ' ';
--  opr4 = 0111, val4 = 0000;
999 => X"7" & X"0",

-- L0204@03E8.EXCPOINT:  opr4 = 0b0111, val4 = 0x0F & '!';
--  opr4 = 0111, val4 = 0001;
1000 => X"7" & X"1",

-- L0205@03E9.OUT_2:  opr6 = 0b001001, val2 = 3;
--  opr6 = 001001, val2 = 11;
1001 => O"11" & "11",

-- L0206@03EA.  opr6 = 0b001001, val2 = 2;
--  opr6 = 001001, val2 = 10;
1002 => O"11" & "10",

-- L0207@03EB.  opr6 = 0b001000, val2 = 1;
--  opr6 = 001000, val2 = 01;
1003 => O"10" & "01",

-- L0208@03EC.  opr2 = 0b11, val6 = 0b00111111 & @ OUT_xxx0;
--  opr2 = 11, val6 = 010010;
1004 => "11" & O"22",

-- L0210@03ED.CLEAR4:  opr4 = 0b0111, val4 = 0;
--  opr4 = 0111, val4 = 0000;
1005 => X"7" & X"0",

-- L0211@03EE.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
1006 => O"15" & "11",

-- L0212@03EF.  opr8 = 0x00;
--  opr8 = 00000000;
1007 => X"00",

-- L0213@03F0.  opr4 = 0b0111, val4 = 0;
--  opr4 = 0111, val4 = 0000;
1008 => X"7" & X"0",

-- L0214@03F1.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
1009 => O"15" & "11",

-- L0215@03F2.  opr4 = 0b0111, val4 = 0;
--  opr4 = 0111, val4 = 0000;
1010 => X"7" & X"0",

-- L0216@03F3.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
1011 => O"15" & "11",

-- L0217@03F4.  opr4 = 0b0111, val4 = 0;
--  opr4 = 0111, val4 = 0000;
1012 => X"7" & X"0",

-- L0218@03F5.  opr6 = 0b001101, val2 = 3 & ! 0b00;
--  opr6 = 001101, val2 = 11;
1013 => O"15" & "11",

-- L0219@03F6.  opr8 = 0x02;
--  opr8 = 00000010;
1014 => X"02",

-- L0220@03F7.  opr8 = 0x02;
--  opr8 = 00000010;
1015 => X"02",

-- 864 location(s) in following ranges will be filled with default value
-- 0023 .. 033F
-- 0376 .. 037F
-- 038F .. 03BF
-- 03F8 .. 03FF

others => "00" & "00" & "00" & "00"
);

end helloworld_code;

