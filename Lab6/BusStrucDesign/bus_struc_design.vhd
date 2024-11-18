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

entity bus_struc_design is
	port (
		Clk : in std_logic;
		Func : in std_logic_vector(4 downto 0);
		Data : in std_logic_vector(7 downto 0);
		DispSelect : in std_logic_vector(1 downto 0);
		Rselect : buffer std_logic_vector(3 downto 0);
		R0out : buffer std_logic_vector(7 downto 0);
		R1out : buffer std_logic_vector(7 downto 0);
		R2out : buffer std_logic_vector(7 downto 0);
		R3out : buffer std_logic_vector(7 downto 0);
		S : buffer std_logic_vector(2 downto 0);
		B : buffer std_logic_vector(7 downto 0);
		Display0 : out std_logic_vector(1 to 7);
		Display1 : out std_logic_vector(1 to 7);
		Display2 : out std_logic_vector(1 to 7);
		Display3 : out std_logic_vector(1 to 7)
	);
end bus_struc_design;

architecture behaviour of bus_struc_design is
	component reg is
	port (
		Clk : in std_logic;
		Load : in std_logic;
		V : in std_logic_vector(7 downto 0); -- Value
		Output : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component multiplexer is
	port (
		Clk : in std_logic;
		S : in std_logic_vector(2 downto 0);
		Data,R0,R1,R2,R3 : in std_logic_vector(7 downto 0);
		Output : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component control_circuit is
	port (
		Func : in std_logic_vector(4 downto 0);
		Rin : out std_logic_vector(3 downto 0);
		S : out std_logic_vector(2 downto 0)
	);
	end component;
	
	component seven_seg_hex is
	port
	(
		bin: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		leds: OUT STD_LOGIC_VECTOR(1 TO 7)
	);
	end component;
	
	signal reg_to_disp : std_logic_vector(7 downto 0);
begin
	CC : control_circuit port map(Func, Rselect, S);
	MP : multiplexer port map(Clk, S, Data, R0out, R1out, R2out, R3out, B);
	R0 : reg port map(Clk, Rselect(0), B, R0out);
	R1 : reg port map(Clk, Rselect(1), B, R1out);
	R2 : reg port map(Clk, Rselect(2), B, R2out);
	R3 : reg port map(Clk, Rselect(3), B, R3out);
	SS0 : seven_seg_hex port map(reg_to_disp(3) & reg_to_disp(2) & reg_to_disp(1) & reg_to_disp(0), Display0);
	SS1 : seven_seg_hex port map(reg_to_disp(7) & reg_to_disp(6) & reg_to_disp(5) & reg_to_disp(4), Display1);
	SS2 : seven_seg_hex port map(B(3) & B(2) & B(1) & B(0), Display2);
	SS3 : seven_seg_hex port map(B(7) & B(6) & B(5) & B(4), Display3);
	
	with DispSelect select
		reg_to_disp <= 
			R0out when "00",
			R1out when "01",
			R2out when "10",
			R3out when "11",
			"00000000" when others;
end behaviour;