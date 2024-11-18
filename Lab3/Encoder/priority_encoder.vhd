LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY priority_encoder IS
	PORT (
			D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			A : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			R : OUT STD_LOGIC
		);
END priority_encoder;

ARCHITECTURE behaviour OF priority_encoder IS
BEGIN
	A(1) <= D(2) OR D(3);
	A(0) <= D(3) OR (NOT D(2) AND D(1));
	R <= D(3) OR D(2) OR D(1) OR D(0);
END behaviour;