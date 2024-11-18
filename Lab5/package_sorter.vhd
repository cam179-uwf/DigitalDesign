LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY seven_seg_hex IS
	PORT
	(
	bin: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	leds: OUT STD_LOGIC_VECTOR(1 TO 7)
	);
END seven_seg_hex;

ARCHITECTURE behavior OF seven_seg_hex IS
BEGIN
	leds <= 
		"0000001" WHEN bin = "0000" ELSE
		"1001111" WHEN bin = "0001" ELSE
		"0010010" WHEN bin = "0010" ELSE
		"0000110" WHEN bin = "0011" ELSE
		"1001100" WHEN bin = "0100" ELSE
		"0100100" WHEN bin = "0101" ELSE
		"0100000" WHEN bin = "0110" ELSE
		"0001111" WHEN bin = "0111" ELSE
		"0000000" WHEN bin = "1000" ELSE
		"0001100" WHEN bin = "1001" ELSE
		"0001000" WHEN bin = "1010" ELSE
		"1100000" WHEN bin = "1011" ELSE
		"0110001" WHEN bin = "1100" ELSE
		"1000010" WHEN bin = "1101" ELSE
		"0110000" WHEN bin = "1110" ELSE
		"0111000" WHEN bin = "1111" ELSE
		"-------";
END behavior;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY package_sorter IS
	PORT (
		weight: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		sort,clk,reset: IN STD_LOGIC;
		current_grp: OUT STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
		grp1,grp2,grp3,grp4: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
		ssd1,ssd2,ssd3,ssd4: OUT STD_LOGIC_VECTOR(1 TO 7) := (OTHERS => '0')
	);
END package_sorter;

ARCHITECTURE behaviour OF package_sorter IS
	COMPONENT seven_seg_hex IS
	PORT (
		bin: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		leds: OUT STD_LOGIC_VECTOR(1 TO 7)
	);
	END COMPONENT;
	
	SIGNAL grp1temp: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL grp2temp: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL grp3temp: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL grp4temp: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	TYPE state_type IS (s0, s1, s2, s3, s4, s5, s6, s7);
	SIGNAL y: state_type := s0;
BEGIN
	PROCESS (clk,sort,reset,weight)
	BEGIN
		IF reset = '0' THEN
			
			y <= s0;
			
		ELSIF clk'EVENT AND clk = '1' THEN
			
			CASE y IS
				WHEN s0 =>
					grp1temp <= (OTHERS => '0');
					grp2temp <= (OTHERS => '0');
					grp3temp <= (OTHERS => '0');
					grp4temp <= (OTHERS => '0');
					y <= s1;
					
				WHEN s1 =>
					IF sort = '0' THEN
						IF weight >= 1 AND weight <= 200 THEN
							y <= s2;
						ELSIF weight > 200 AND weight <= 500 THEN
							y <= s3;
						ELSIF weight > 500 AND weight <= 800 THEN
							y <= s4;
						ELSIF weight > 800 THEN
							y <= s5;
						ELSIF weight = "0000000000" THEN
							y <= s6;
						END IF;
					END IF;
					
				WHEN s2 => 
					grp1temp <= grp1temp + 1;
					current_grp <= "001";
					y <= s7;
				
				WHEN s3 => 
					grp2temp <= grp2temp + 1;
					current_grp <= "010";
					y <= s7;
				
				WHEN s4 => 
					grp3temp <= grp3temp + 1;
					current_grp <= "011";
					y <= s7;
				
				WHEN s5 => 
					grp4temp <= grp4temp + 1;
					current_grp <= "100";
					y <= s7;
				
				WHEN s6 => 
					current_grp <= "000";
					y <= s7;
					
				WHEN s7 =>
					IF sort = '1' THEN
						y <= s1;
					END IF;
			END CASE;
			
		END IF;
	END PROCESS;
	
	grp1 <= grp1temp;
	grp2 <= grp2temp;
	grp3 <= grp3temp;
	grp4 <= grp4temp;
	led1: seven_seg_hex PORT MAP(grp1temp, ssd1);
	led2: seven_seg_hex PORT MAP(grp2temp, ssd2);
	led3: seven_seg_hex PORT MAP(grp3temp, ssd3);
	led4: seven_seg_hex PORT MAP(grp4temp, ssd4);
END behaviour;