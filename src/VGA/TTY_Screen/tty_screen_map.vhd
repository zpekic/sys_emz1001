--------------------------------------------------------
-- mcc V1.2.1107 - Custom microcode compiler (c)2020-... 
--    https://github.com/zpekic/MicroCodeCompiler
--------------------------------------------------------
-- Auto-generated file, do not modify. To customize, create 'mapper_template.vhd' file in mcc.exe folder
-- Supported placeholders:  [SIZES], [NAME], [TYPE], [INSTANCE], [SIGNAL], [MEMORY].
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.numeric_std.all;

package tty_screen_map is

-- memory block size
constant MAPPER_DATA_WIDTH: 	positive := 6;
constant MAPPER_ADDRESS_WIDTH: 	positive := 7;
constant MAPPER_ADDRESS_LAST: 	positive := 127;


type tty_mapper_memory is array(0 to 127) of std_logic_vector(5 downto 0);

signal tty_instructionstart: std_logic_vector(5 downto 0);

--tty_instructionstart <= tty_mapper(to_integer(unsigned(TODO))); -- copy to file containing the control unit. TODO is typically the 'instruction_register'



constant tty_mapper: tty_mapper_memory := (

-- L0132@000A. .map 0b00?_????;
0 => O"12",

-- L0136@000B. .map 0b000_0001;
1 => O"13",

-- L0151@0012. .map 0b000_0010;
2 => O"22",

3 => O"12",

4 => O"12",

5 => O"12",

6 => O"12",

7 => O"12",

8 => O"12",

9 => O"12",

-- L0155@0013. .map 0b000_1010;
10 => O"23",

11 => O"12",

12 => O"12",

-- L0189@0021. .map 0b000_1101;
13 => O"41",

14 => O"12",

15 => O"12",

16 => O"12",

17 => O"12",

18 => O"12",

19 => O"12",

20 => O"12",

21 => O"12",

22 => O"12",

23 => O"12",

24 => O"12",

25 => O"12",

26 => O"12",

27 => O"12",

28 => O"12",

29 => O"12",

30 => O"12",

31 => O"12",

32 => O"06",

33 => O"06",

34 => O"06",

35 => O"06",

36 => O"06",

37 => O"06",

38 => O"06",

39 => O"06",

40 => O"06",

41 => O"06",

42 => O"06",

43 => O"06",

44 => O"06",

45 => O"06",

46 => O"06",

47 => O"06",

48 => O"06",

49 => O"06",

50 => O"06",

51 => O"06",

52 => O"06",

53 => O"06",

54 => O"06",

55 => O"06",

56 => O"06",

57 => O"06",

58 => O"06",

59 => O"06",

60 => O"06",

61 => O"06",

62 => O"06",

63 => O"06",

64 => O"06",

65 => O"06",

66 => O"06",

67 => O"06",

68 => O"06",

69 => O"06",

70 => O"06",

71 => O"06",

72 => O"06",

73 => O"06",

74 => O"06",

75 => O"06",

76 => O"06",

77 => O"06",

78 => O"06",

79 => O"06",

80 => O"06",

81 => O"06",

82 => O"06",

83 => O"06",

84 => O"06",

85 => O"06",

86 => O"06",

87 => O"06",

88 => O"06",

89 => O"06",

90 => O"06",

91 => O"06",

92 => O"06",

93 => O"06",

94 => O"06",

95 => O"06",

96 => O"06",

97 => O"06",

98 => O"06",

99 => O"06",

100 => O"06",

101 => O"06",

102 => O"06",

103 => O"06",

104 => O"06",

105 => O"06",

106 => O"06",

107 => O"06",

108 => O"06",

109 => O"06",

110 => O"06",

111 => O"06",

112 => O"06",

113 => O"06",

114 => O"06",

115 => O"06",

116 => O"06",

117 => O"06",

118 => O"06",

119 => O"06",

120 => O"06",

121 => O"06",

122 => O"06",

123 => O"06",

124 => O"06",

125 => O"06",

126 => O"06",

127 => O"06");

end tty_screen_map;

