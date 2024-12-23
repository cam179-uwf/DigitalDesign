LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mult8bit IS
	PORT (
		A,B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Product : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END mult8bit;

ARCHITECTURE behaviour OF mult8bit IS
	COMPONENT prom IS
		PORT (
			A,B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Product : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT add8bits IS
		PORT (
			A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			Cin : IN STD_LOGIC;
			Sum : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			Cout : OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT add12bits IS
		PORT (
			A : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			Cin : IN STD_LOGIC;
			Sum : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
			Cout : OUT STD_LOGIC
		);
	END COMPONENT;
	
	SIGNAL ProductProm1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ProductProm2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ProductProm3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ProductProm4 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL Sum8 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL Carry8 : STD_LOGIC;
	SIGNAL Sum12 : STD_LOGIC_VECTOR(11 DOWNTO 0);
BEGIN
	PR1:prom port map(A(7 DOWNTO 4), B(7 DOWNTO 4), ProductProm1);
	PR2:prom port map(A(7 DOWNTO 4), B(3 DOWNTO 0), ProductProm2);
	PR3:prom port map(A(3 DOWNTO 0), B(7 DOWNTO 4), ProductProm3);
	PR4:prom port map(A(3 DOWNTO 0), B(3 DOWNTO 0), ProductProm4);
	A8B:add8bits port map(ProductProm2, ProductProm3, '0', Sum8, Carry8);
	A12B:add12bits port map(ProductProm1 & ProductProm4(7 DOWNTO 4), "000" & Carry8 & Sum8, '0', Sum12, OPEN);
	Product <= Sum12 & ProductProm4(3 DOWNTO 0);
END behaviour;