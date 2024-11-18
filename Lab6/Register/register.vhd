LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg is
	port (
		Clk : in std_logic;
		Load : in std_logic;
		V : in std_logic_vector(7 downto 0); -- Value
		Output : out std_logic_vector(7 downto 0)
	);
end reg;

architecture behaviour of reg is
begin
	process (Clk, Load, V)
	begin
		if Clk'event and Clk = '1' and Load = '1' then
			Output <= V;
		end if;
	end process;
end behaviour;