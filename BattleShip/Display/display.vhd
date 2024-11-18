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
    CONSTANT NumberOfTicksPerSecond : INTEGER := 2;

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

            SSH1 <= (OTHERS => '0');
            SSH2 <= (OTHERS => '0');
            SSH3 <= (OTHERS => '0');
            SSH4 <= (OTHERS => '0');
            SSH5 <= (OTHERS => '0');
            SSH6 <= (OTHERS => '0');
        ELSIF rising_edge(Clk) THEN

            IF Toggle = '1' THEN
                SecondsTimeStamp <= Seconds;
                Running <= '1';
            ELSIF Seconds - SecondsTimeStamp > Delay THEN
                Running <= '0';
            END IF;

            -- PLAY
            IF MsgSelect = "000" THEN
                SSH1 <= "1100111"; -- P
                SSH2 <= "0001110"; -- L
                SSH3 <= "1110111"; -- A
                SSH4 <= "0100111"; -- Y
                SSH5 <= "0000000";
                SSH6 <= "0000000";
            -- P1
            ELSIF MsgSelect = "001" THEN
                SSH1 <= "1100111"; -- P
                SSH2 <= "1110000"; -- 1
                SSH3 <= "0000000";
                SSH4 <= "0000000";
                SSH5 <= "0000000";
                SSH6 <= "0000000";
            -- P2
            ELSIF MsgSelect = "010" THEN
                SSH1 <= "1100111"; -- P
                SSH2 <= "1101101"; -- 2
                SSH3 <= "0000000";
                SSH4 <= "0000000";
                SSH5 <= "0000000";
                SSH6 <= "0000000";
            -- HIT
            ELSIF MsgSelect = "011" THEN
                SSH1 <= "0110111"; -- H
                SSH2 <= "1001000"; -- I
                SSH3 <= "1001110"; -- I
                SSH4 <= "1000000"; -- T
                SSH5 <= "1000110"; -- T
                SSH6 <= "0000000";
            -- MISS
            ELSIF MsgSelect = "100" THEN

                IF Seconds MOD 2 = 0 THEN
                    SSH1 <= "1110110"; -- M
                    SSH2 <= "1110000"; -- M
                    SSH3 <= "1001000"; -- I
                    SSH4 <= "1001110"; -- I
                    SSH5 <= "1011011"; -- S
                    SSH6 <= "1011011"; -- S
                ELSE
                    SSH1 <= (OTHERS => '0');
                    SSH2 <= (OTHERS => '0');
                    SSH3 <= (OTHERS => '0');
                    SSH4 <= (OTHERS => '0');
                    SSH5 <= (OTHERS => '0');
                    SSH6 <= (OTHERS => '0');
                END IF;
            -- P1W
            ELSIF MsgSelect = "101" THEN
                SSH1 <= "1100111"; -- P
                SSH2 <= "1110000"; -- 1
                SSH3 <= "0111110"; -- W
                SSH4 <= "0111000"; -- W
                SSH5 <= "0000000";
                SSH6 <= "0000000";
            -- P2W
            ELSIF MsgSelect = "110" THEN
                SSH1 <= "1100111"; -- P
                SSH2 <= "1101101"; -- 2
                SSH3 <= "0111110"; -- W
                SSH4 <= "0111000"; -- W
                SSH5 <= "0000000";
                SSH6 <= "0000000";
            ELSE
                SSH1 <= (OTHERS => '0');
                SSH2 <= (OTHERS => '0');
                SSH3 <= (OTHERS => '0');
                SSH4 <= (OTHERS => '0');
                SSH5 <= (OTHERS => '0');
                SSH6 <= (OTHERS => '0');
            END IF;
        END IF;
    END PROCESS;

    Delay <=
        1 WHEN MsgSelect = "000" ELSE -- Play
        1 WHEN MsgSelect = "001" ELSE -- P1
        1 WHEN MsgSelect = "010" ELSE -- P2
        1 WHEN MsgSelect = "011" ELSE -- HIT
        1 WHEN MsgSelect = "100" ELSE -- MISS
        1 WHEN MsgSelect = "101" ELSE -- P1W
        1 WHEN MsgSelect = "110" ELSE -- P2W
        0;
END behaviour;