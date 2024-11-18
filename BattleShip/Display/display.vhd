LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY display IS
    PORT (
        Toggle,R,Clk : IN STD_LOGIC;
        MsgSelect : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        SSH1,SSH2,SSH3,SSH4,SSH5,SSH6 : OUT STD_LOGIC_VECTOR(1 TO 7);
        Running : OUT STD_LOGIC
    );
END display;

ARCHITECTURE behaviour OF display IS
    CONSTANT NumberOfTicksPerSecond : INTEGER := 50e6;

    SIGNAL Ticks : INTEGER := 0;
    SIGNAL Seconds : INTEGER := 0;
    SIGNAL SecondsTimeStamp : INTEGER := 0;
    SIGNAL Delay : INTEGER := 0;
BEGIN
    Timer : PROCESS(R,Clk)
    BEGIN
        IF R = '0' THEN
            Ticks <= 0;
            Seconds <= 0;
        ELSIF rising_edge(Clk) THEN
            -- Accumulate Ticks
            IF Ticks = NumberOfTicksPerSecond - 1 THEN
                Ticks <= 0;
                Seconds <= Seconds + 1;
            ELSE
                Ticks <= Ticks + 1;
            END IF;
        END IF;
    END PROCESS;

    Main : PROCESS(Toggle,Clk,R,Seconds,SecondsTimeStamp,MsgSelect)
    BEGIN
        IF R = '0' THEN
            Running <= '0';

            SSH1 <= (OTHERS => '1');
            SSH2 <= (OTHERS => '1');
            SSH3 <= (OTHERS => '1');
            SSH4 <= (OTHERS => '1');
            SSH5 <= (OTHERS => '1');
            SSH6 <= (OTHERS => '1');
        ELSIF rising_edge(Clk) THEN

            IF Toggle = '1' THEN
                SecondsTimeStamp <= Seconds;
                Running <= '1';
            ELSIF Seconds - SecondsTimeStamp > Delay THEN
                Running <= '0';
            END IF;

            -- PLAY
            IF MsgSelect = "000" THEN
                SSH1 <= "0011000"; -- P
                SSH2 <= "1110001"; -- L
                SSH3 <= "0001000"; -- A
                SSH4 <= "1011000"; -- Y
                SSH5 <= "1111111";
                SSH6 <= "1111111";
            -- P1
            ELSIF MsgSelect = "001" THEN
                SSH1 <= "0011000"; -- P
                SSH2 <= "1001111"; -- 1
                SSH3 <= "1111111";
                SSH4 <= "1111111";
                SSH5 <= "1111111";
                SSH6 <= "1111111";
            -- P2
            ELSIF MsgSelect = "010" THEN
                SSH1 <= "0011000"; -- P
                SSH2 <= "0010010"; -- 2
                SSH3 <= "1111111";
                SSH4 <= "1111111";
                SSH5 <= "1111111";
                SSH6 <= "1111111";
            -- HIT
            ELSIF MsgSelect = "011" THEN
                SSH1 <= "1111111"; 
                SSH2 <= "1001000"; -- H
                SSH3 <= "0110111"; -- I
                SSH4 <= "0110001"; -- I
                SSH5 <= "0111111"; -- T
                SSH6 <= "0111001"; -- T
            -- MISS
            ELSIF MsgSelect = "100" THEN

                IF Seconds MOD 2 = 0 THEN
                    SSH1 <= "0001001"; -- M
                    SSH2 <= "0001111"; -- M
                    SSH3 <= "0110111"; -- I
                    SSH4 <= "0110001"; -- I
                    SSH5 <= "0100100"; -- S
                    SSH6 <= "0100100"; -- S
                ELSE
                    SSH1 <= (OTHERS => '1');
                    SSH2 <= (OTHERS => '1');
                    SSH3 <= (OTHERS => '1');
                    SSH4 <= (OTHERS => '1');
                    SSH5 <= (OTHERS => '1');
                    SSH6 <= (OTHERS => '1');
                END IF;
            -- P1W
            ELSIF MsgSelect = "101" THEN
                
                IF Seconds MOD 2 = 0 THEN
                    SSH1 <= "0011000"; -- P
                    SSH2 <= "1001111"; -- 1
                    SSH3 <= "1111111"; 
                    SSH4 <= "1111111"; 
                    SSH5 <= "1000001"; -- W
                    SSH6 <= "1000111"; -- W
                ELSE
                    SSH1 <= (OTHERS => '1');
                    SSH2 <= (OTHERS => '1');
                    SSH3 <= (OTHERS => '1');
                    SSH4 <= (OTHERS => '1');
                    SSH5 <= (OTHERS => '1');
                    SSH6 <= (OTHERS => '1');
                END IF;
            -- P2W
            ELSIF MsgSelect = "110" THEN
                
                IF Seconds MOD 2 = 0 THEN
                    SSH1 <= "0011000"; -- P
                    SSH2 <= "0010010"; -- 2
                    SSH3 <= "1111111"; 
                    SSH4 <= "1111111"; 
                    SSH5 <= "1000001"; -- W
                    SSH6 <= "1000111"; -- W
                ELSE
                    SSH1 <= (OTHERS => '1');
                    SSH2 <= (OTHERS => '1');
                    SSH3 <= (OTHERS => '1');
                    SSH4 <= (OTHERS => '1');
                    SSH5 <= (OTHERS => '1');
                    SSH6 <= (OTHERS => '1');
                END IF;
            ELSE
                SSH1 <= (OTHERS => '1');
                SSH2 <= (OTHERS => '1');
                SSH3 <= (OTHERS => '1');
                SSH4 <= (OTHERS => '1');
                SSH5 <= (OTHERS => '1');
                SSH6 <= (OTHERS => '1');
            END IF;
        END IF;
    END PROCESS;

    Delay <=
        4 WHEN MsgSelect = "000" ELSE -- Play
        0 WHEN MsgSelect = "001" ELSE -- P1
        0 WHEN MsgSelect = "010" ELSE -- P2
        4 WHEN MsgSelect = "011" ELSE -- HIT
        4 WHEN MsgSelect = "100" ELSE -- MISS
        4 WHEN MsgSelect = "101" ELSE -- P1W
        4 WHEN MsgSelect = "110" ELSE -- P2W
        0;
END behaviour;