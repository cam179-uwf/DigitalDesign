LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity multiplexer is
	port (
		Clk : in std_logic;
		S : in std_logic_vector(2 downto 0);
		Data,R0,R1,R2,R3 : in std_logic_vector(7 downto 0);
		Output : out std_logic_vector(7 downto 0)
	);
end multiplexer;

architecture behaviour of multiplexer is
begin
		with S select
			Output <= 
				R0 when "000",
				R1 when "001",
				R2 when "010",
				R3 when "011",
				Data when others;
end behaviour;