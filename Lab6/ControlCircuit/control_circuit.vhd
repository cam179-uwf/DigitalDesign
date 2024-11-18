LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_circuit is
	port (
		Func : in std_logic_vector(4 downto 0);
		Rin : out std_logic_vector(3 downto 0);
		S : out std_logic_vector(2 downto 0)
	);
end control_circuit;

architecture behaviour of control_circuit is
begin
	Rin <= "0001" when (Func(3) = '0' and Func(2) = '0') else
			 "0010" when (Func(3) = '0' and Func(2) = '1') else
			 "0100" when (Func(3) = '1' and Func(2) = '0') else
			 "1000" when (Func(3) = '1' and Func(2) = '1') else
			 "0000";
			 
	S <= Func(4) & Func(1) & Func(0);
end behaviour;