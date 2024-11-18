LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY prom IS
	PORT (
		A,B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Product : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END prom;

ARCHITECTURE behaviour OF prom IS
	SIGNAL Address : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	Address <= A & B;
	Product <= X"00" WHEN (A = X"0" OR B = X"0") ELSE -- one of the operands is 0
		X"0" & A WHEN B = X"1" ELSE -- one of the operands is 1
		X"0" & B WHEN A = X"1" ELSE -- one of the operands is 1
		"000" & A & '0' WHEN B = X"2" ELSE -- one of the operands is 2
		"000" & B & '0' WHEN A = X"2" ELSE -- one of the operands is 2
		'0' & A & "000" WHEN B = X"8" ELSE -- one of the operands is 8
		'0' & B & "000" WHEN A = X"8" ELSE -- one of the operands is 8
		
		X"09" WHEN Address = X"33" ELSE -- 3 * 3
		X"10" WHEN Address = X"44" ELSE -- 4 * 4
		X"19" WHEN Address = X"55" ELSE -- 5 * 5
		X"24" WHEN Address = X"66" ELSE -- 6 * 6
		X"31" WHEN Address = X"77" ELSE -- 7 * 7
		X"51" WHEN Address = X"99" ELSE -- 9 * 9
		X"64" WHEN Address = X"AA" ELSE -- 10 * 10
		X"79" WHEN Address = X"BB" ELSE -- 11 * 11
		X"90" WHEN Address = X"CC" ELSE -- 12 * 12
		X"A9" WHEN Address = X"DD" ELSE -- 13 * 13
		X"C4" WHEN Address = X"EE" ELSE -- 14 * 14
		X"E1" WHEN Address = X"FF" ELSE -- 15 * 15
		
		X"0C" WHEN (Address = X"34" OR Address = X"34") ELSE -- 3 * 4
		X"0F" WHEN (Address = X"35" OR Address = X"35") ELSE -- 3 * 5
		X"12" WHEN (Address = X"36" OR Address = X"36") ELSE -- 3 * 6
		X"15" WHEN (Address = X"37" OR Address = X"37") ELSE -- 3 * 7
		X"1B" WHEN (Address = X"39" OR Address = X"39") ELSE -- 3 * 9
		X"1E" WHEN (Address = X"3A" OR Address = X"3A") ELSE -- 3 * A
		X"21" WHEN (Address = X"3B" OR Address = X"3B") ELSE -- 3 * B
		X"24" WHEN (Address = X"3C" OR Address = X"3C") ELSE -- 3 * C
		X"27" WHEN (Address = X"3D" OR Address = X"3D") ELSE -- 3 * D
		X"2A" WHEN (Address = X"3E" OR Address = X"3E") ELSE -- 3 * E
		X"2D" WHEN (Address = X"3F" OR Address = X"3F") ELSE -- 3 * F
		X"0C" WHEN (Address = X"43" OR Address = X"43") ELSE -- 4 * 3
		X"14" WHEN (Address = X"45" OR Address = X"45") ELSE -- 4 * 5
		X"18" WHEN (Address = X"46" OR Address = X"46") ELSE -- 4 * 6
		X"1C" WHEN (Address = X"47" OR Address = X"47") ELSE -- 4 * 7
		X"24" WHEN (Address = X"49" OR Address = X"49") ELSE -- 4 * 9
		X"28" WHEN (Address = X"4A" OR Address = X"4A") ELSE -- 4 * A
		X"2C" WHEN (Address = X"4B" OR Address = X"4B") ELSE -- 4 * B
		X"30" WHEN (Address = X"4C" OR Address = X"4C") ELSE -- 4 * C
		X"34" WHEN (Address = X"4D" OR Address = X"4D") ELSE -- 4 * D
		X"38" WHEN (Address = X"4E" OR Address = X"4E") ELSE -- 4 * E
		X"3C" WHEN (Address = X"4F" OR Address = X"4F") ELSE -- 4 * F
		X"0F" WHEN (Address = X"53" OR Address = X"53") ELSE -- 5 * 3
		X"14" WHEN (Address = X"54" OR Address = X"54") ELSE -- 5 * 4
		X"1E" WHEN (Address = X"56" OR Address = X"56") ELSE -- 5 * 6
		X"23" WHEN (Address = X"57" OR Address = X"57") ELSE -- 5 * 7
		X"2D" WHEN (Address = X"59" OR Address = X"59") ELSE -- 5 * 9
		X"32" WHEN (Address = X"5A" OR Address = X"5A") ELSE -- 5 * A
		X"37" WHEN (Address = X"5B" OR Address = X"5B") ELSE -- 5 * B
		X"3C" WHEN (Address = X"5C" OR Address = X"5C") ELSE -- 5 * C
		X"41" WHEN (Address = X"5D" OR Address = X"5D") ELSE -- 5 * D
		X"46" WHEN (Address = X"5E" OR Address = X"5E") ELSE -- 5 * E
		X"4B" WHEN (Address = X"5F" OR Address = X"5F") ELSE -- 5 * F
		X"12" WHEN (Address = X"63" OR Address = X"63") ELSE -- 6 * 3
		X"18" WHEN (Address = X"64" OR Address = X"64") ELSE -- 6 * 4
		X"1E" WHEN (Address = X"65" OR Address = X"65") ELSE -- 6 * 5
		X"2A" WHEN (Address = X"67" OR Address = X"67") ELSE -- 6 * 7
		X"36" WHEN (Address = X"69" OR Address = X"69") ELSE -- 6 * 9
		X"3C" WHEN (Address = X"6A" OR Address = X"6A") ELSE -- 6 * A
		X"42" WHEN (Address = X"6B" OR Address = X"6B") ELSE -- 6 * B
		X"48" WHEN (Address = X"6C" OR Address = X"6C") ELSE -- 6 * C
		X"4E" WHEN (Address = X"6D" OR Address = X"6D") ELSE -- 6 * D
		X"54" WHEN (Address = X"6E" OR Address = X"6E") ELSE -- 6 * E
		X"5A" WHEN (Address = X"6F" OR Address = X"6F") ELSE -- 6 * F
		X"15" WHEN (Address = X"73" OR Address = X"73") ELSE -- 7 * 3
		X"1C" WHEN (Address = X"74" OR Address = X"74") ELSE -- 7 * 4
		X"23" WHEN (Address = X"75" OR Address = X"75") ELSE -- 7 * 5
		X"2A" WHEN (Address = X"76" OR Address = X"76") ELSE -- 7 * 6
		X"3F" WHEN (Address = X"79" OR Address = X"79") ELSE -- 7 * 9
		X"46" WHEN (Address = X"7A" OR Address = X"7A") ELSE -- 7 * A
		X"4D" WHEN (Address = X"7B" OR Address = X"7B") ELSE -- 7 * B
		X"54" WHEN (Address = X"7C" OR Address = X"7C") ELSE -- 7 * C
		X"5B" WHEN (Address = X"7D" OR Address = X"7D") ELSE -- 7 * D
		X"62" WHEN (Address = X"7E" OR Address = X"7E") ELSE -- 7 * E
		X"69" WHEN (Address = X"7F" OR Address = X"7F") ELSE -- 7 * F
		X"1B" WHEN (Address = X"93" OR Address = X"93") ELSE -- 9 * 3
		X"24" WHEN (Address = X"94" OR Address = X"94") ELSE -- 9 * 4
		X"2B" WHEN (Address = X"95" OR Address = X"95") ELSE -- 9 * 5
		X"36" WHEN (Address = X"96" OR Address = X"96") ELSE -- 9 * 6
		X"3F" WHEN (Address = X"97" OR Address = X"97") ELSE -- 9 * 7
		X"5A" WHEN (Address = X"9A" OR Address = X"9A") ELSE -- 9 * A
		X"63" WHEN (Address = X"9B" OR Address = X"9B") ELSE -- 9 * B
		X"6C" WHEN (Address = X"9C" OR Address = X"9C") ELSE -- 9 * C
		X"75" WHEN (Address = X"9D" OR Address = X"9D") ELSE -- 9 * D
		X"7E" WHEN (Address = X"9E" OR Address = X"9E") ELSE -- 9 * E
		X"87" WHEN (Address = X"9F" OR Address = X"9F") ELSE -- 9 * F
		X"1E" WHEN (Address = X"A3" OR Address = X"A3") ELSE -- A * 3
		X"28" WHEN (Address = X"A4" OR Address = X"A4") ELSE -- A * 4
		X"32" WHEN (Address = X"A5" OR Address = X"A5") ELSE -- A * 5
		X"3C" WHEN (Address = X"A6" OR Address = X"A6") ELSE -- A * 6
		X"46" WHEN (Address = X"A7" OR Address = X"A7") ELSE -- A * 7
		X"5A" WHEN (Address = X"A9" OR Address = X"A9") ELSE -- A * 9
		X"6E" WHEN (Address = X"AB" OR Address = X"AB") ELSE -- A * B
		X"78" WHEN (Address = X"AC" OR Address = X"AC") ELSE -- A * C
		X"82" WHEN (Address = X"AD" OR Address = X"AD") ELSE -- A * D
		X"8C" WHEN (Address = X"AE" OR Address = X"AE") ELSE -- A * E
		X"96" WHEN (Address = X"AF" OR Address = X"AF") ELSE -- A * F
		X"21" WHEN (Address = X"B3" OR Address = X"B3") ELSE -- B * 3
		X"2C" WHEN (Address = X"B4" OR Address = X"B4") ELSE -- B * 4
		X"37" WHEN (Address = X"B5" OR Address = X"B5") ELSE -- B * 5
		X"42" WHEN (Address = X"B6" OR Address = X"B6") ELSE -- B * 6
		X"4D" WHEN (Address = X"B7" OR Address = X"B7") ELSE -- B * 7
		X"63" WHEN (Address = X"B9" OR Address = X"B9") ELSE -- B * 9
		X"6E" WHEN (Address = X"BA" OR Address = X"BA") ELSE -- B * A
		X"84" WHEN (Address = X"BC" OR Address = X"BC") ELSE -- B * C
		X"8F" WHEN (Address = X"BD" OR Address = X"BD") ELSE -- B * D
		X"9A" WHEN (Address = X"BE" OR Address = X"BE") ELSE -- B * E
		X"A5" WHEN (Address = X"BF" OR Address = X"BF") ELSE -- B * F
		X"24" WHEN (Address = X"C3" OR Address = X"C3") ELSE -- C * 3
		X"30" WHEN (Address = X"C4" OR Address = X"C4") ELSE -- C * 4
		X"3C" WHEN (Address = X"C5" OR Address = X"C5") ELSE -- C * 5
		X"48" WHEN (Address = X"C6" OR Address = X"C6") ELSE -- C * 6
		X"54" WHEN (Address = X"C7" OR Address = X"C7") ELSE -- C * 7
		X"6C" WHEN (Address = X"C9" OR Address = X"C9") ELSE -- C * 9
		X"78" WHEN (Address = X"CA" OR Address = X"CA") ELSE -- C * A
		X"84" WHEN (Address = X"CB" OR Address = X"CB") ELSE -- C * B
		X"9C" WHEN (Address = X"CD" OR Address = X"CD") ELSE -- C * D
		X"A8" WHEN (Address = X"CE" OR Address = X"CE") ELSE -- C * E
		X"B4" WHEN (Address = X"CF" OR Address = X"CF") ELSE -- C * F
		X"27" WHEN (Address = X"D3" OR Address = X"D3") ELSE -- D * 3
		X"34" WHEN (Address = X"D4" OR Address = X"D4") ELSE -- D * 4
		X"41" WHEN (Address = X"D5" OR Address = X"D5") ELSE -- D * 5
		X"4E" WHEN (Address = X"D6" OR Address = X"D6") ELSE -- D * 6
		X"5B" WHEN (Address = X"D7" OR Address = X"D7") ELSE -- D * 7
		X"75" WHEN (Address = X"D9" OR Address = X"D9") ELSE -- D * 9
		X"82" WHEN (Address = X"DA" OR Address = X"DA") ELSE -- D * A
		X"8F" WHEN (Address = X"DB" OR Address = X"DB") ELSE -- D * B
		X"9C" WHEN (Address = X"DC" OR Address = X"DC") ELSE -- D * C
		X"B6" WHEN (Address = X"DE" OR Address = X"DE") ELSE -- D * E
		X"C3" WHEN (Address = X"DF" OR Address = X"DF") ELSE -- D * F
		X"2A" WHEN (Address = X"E3" OR Address = X"E3") ELSE -- E * 3
		X"38" WHEN (Address = X"E4" OR Address = X"E4") ELSE -- E * 4
		X"46" WHEN (Address = X"E5" OR Address = X"E5") ELSE -- E * 5
		X"54" WHEN (Address = X"E6" OR Address = X"E6") ELSE -- E * 6
		X"62" WHEN (Address = X"E7" OR Address = X"E7") ELSE -- E * 7
		X"7E" WHEN (Address = X"E9" OR Address = X"E9") ELSE -- E * 9
		X"8C" WHEN (Address = X"EA" OR Address = X"EA") ELSE -- E * A
		X"9A" WHEN (Address = X"EB" OR Address = X"EB") ELSE -- E * B
		X"A8" WHEN (Address = X"EC" OR Address = X"EC") ELSE -- E * C
		X"B6" WHEN (Address = X"ED" OR Address = X"ED") ELSE -- E * D
		X"D2" WHEN (Address = X"EF" OR Address = X"EF") ELSE -- E * F
		X"2D" WHEN (Address = X"F3" OR Address = X"F3") ELSE -- F * 3
		X"3C" WHEN (Address = X"F4" OR Address = X"F4") ELSE -- F * 4
		X"4B" WHEN (Address = X"F5" OR Address = X"F5") ELSE -- F * 5
		X"5A" WHEN (Address = X"F6" OR Address = X"F6") ELSE -- F * 6
		X"69" WHEN (Address = X"F7" OR Address = X"F7") ELSE -- F * 7
		X"87" WHEN (Address = X"F9" OR Address = X"F9") ELSE -- F * 9
		X"96" WHEN (Address = X"FA" OR Address = X"FA") ELSE -- F * A
		X"A5" WHEN (Address = X"FB" OR Address = X"FB") ELSE -- F * B
		X"B4" WHEN (Address = X"FC" OR Address = X"FC") ELSE -- F * C
		X"C3" WHEN (Address = X"FD" OR Address = X"FD") ELSE -- F * D
		X"D2" WHEN (Address = X"FE" OR Address = X"FE") ELSE -- F * E
		X"00";
END behaviour;