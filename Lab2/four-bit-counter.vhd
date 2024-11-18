LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY count4 IS
	PORT 
	(
	clk,ld_en,cnt_en,clear: IN STD_LOGIC;
	parallel_in: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	cnt_out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	g1,g2,g3,g4: OUT STD_LOGIC
	);
END count4;

ARCHITECTURE behavior OF count4 IS
	SIGNAL temp_count: STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	PROCESS(clk,clear) IS
	BEGIN
		IF (clear = '0') THEN
			temp_count <= (OTHERS => '0');
		ELSIF (RISING_EDGE(clk)) THEN
			IF (cnt_en = '1') THEN
				IF (temp_count = "1111") THEN
					temp_count <= (OTHERS => '0');
				ELSE
					temp_count <= temp_count + 1;
				END IF;
			ELSIF (ld_en = '1') THEN
				temp_count <= parallel_in;
			ELSE
				temp_count <= temp_count;
			END IF;
		END IF;
	END PROCESS;
	cnt_out <= temp_count;
	g1 <= temp_count(0);
	g2 <= temp_count(1);
	g3 <= temp_count(2);
	g4 <= temp_count(3);
END behavior;

ENTITY seven_seg_hex IS
PORT (bin: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
leds: OUT STD_LOGIC_VECTOR(1 TO 7));
END seven_seg_hex;
ARCHITECTURE Behavior OF seven_seg_hex IS
BEGIN
leds <= "0000001" WHEN bin="0000" ELSE
"1001111" WHEN bin="0001" ELSE
"0010010" WHEN bin="0010" ELSE
"0000110" WHEN bin="0011" ELSE
"1001100" WHEN bin="0100" ELSE
"0100100" WHEN bin="0101" ELSE
"0100000" WHEN bin="0110" ELSE
"0001111" WHEN bin="0111" ELSE
"0000000" WHEN bin="1000" ELSE
"0001100" WHEN bin="1001" ELSE
"0001000" WHEN bin="1010" ELSE
"1100000" WHEN bin="1011" ELSE
"0110001" WHEN bin="1100" ELSE
"1000010" WHEN bin="1101" ELSE
"0110000" WHEN bin="1110" ELSE
"0111000" WHEN bin="1111" ELSE
"-------";
END Behavior;