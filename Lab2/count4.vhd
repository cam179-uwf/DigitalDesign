LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY count4 IS
	PORT 
	(
	clk,ld_en,cnt_en,clear: IN STD_LOGIC;
	parallel_in: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	seg_seven: OUT STD_LOGIC_VECTOR(1 TO 7);
	g1,g2,g3,g4: OUT STD_LOGIC
	);
END count4;

ARCHITECTURE behavior OF count4 IS
	COMPONENT seven_seg_hex IS
	PORT 
	(
	bin: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	leds: OUT STD_LOGIC_VECTOR(1 TO 7)
	);
	END COMPONENT;

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
	g1 <= temp_count(0);
	g2 <= temp_count(1);
	g3 <= temp_count(2);
	g4 <= temp_count(3);
	SSD: seven_seg_hex PORT MAP(temp_count, seg_seven);
END behavior;