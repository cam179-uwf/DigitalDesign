LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY state_machine IS
	PORT (
		R,Fire,Clk : IN STD_LOGIC;
		X,Y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		CurrentState : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0);
		SSH1,SSH2,SSH3,SSH4,SSH5,SSH6 : OUT STD_LOGIC_VECTOR(1 TO 7);
		DispRunning : BUFFER STD_LOGIC := '0';
		DispToggle : BUFFER STD_LOGIC := '0';
		DispMsgSelect : BUFFER STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0')
	);
END state_machine;

ARCHITECTURE behaviour OF state_machine IS
	
	TYPE State_Type IS (Start, Turn, Hit, Miss, Win);
	SIGNAL State : State_Type := Start;
	
	SIGNAL InternalReset : STD_LOGIC := '0';

	SIGNAL WhichPlayer : STD_LOGIC := '0';
	SIGNAL HorM1 : STD_LOGIC := '0';
	SIGNAL HorM2 : STD_LOGIC := '0';
	SIGNAL Cleared1 : STD_LOGIC := '0';
	SIGNAL Cleared2 : STD_LOGIC := '0';

	-- SIGNAL DispRunning : STD_LOGIC := '0';
	-- SIGNAL DispToggle : STD_LOGIC := '0';
	-- SIGNAL DispMsgSelect : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');

	COMPONENT board IS
		PORT (
			E,R,Fire : IN STD_LOGIC;
			X,Y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			HorM,Cleared : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT display IS
		PORT (
			Toggle,R,Clk : IN STD_LOGIC;
			MsgSelect : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			SSH1,SSH2,SSH3,SSH4,SSH5,SSH6 : OUT STD_LOGIC_VECTOR(1 TO 7);
			Running : OUT STD_LOGIC
		);
	END COMPONENT;

BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL Clk'EVENT AND Clk = '1';

		IF R = '0' THEN
			InternalReset <= '1';
			State <= Start;
		ELSE
			CASE State IS
				WHEN Start =>

					-- RESET EVERYTHING
					InternalReset <= '0';
					WhichPlayer <= '0';

					-- DISPLAY STUFF
					IF DispRunning <= '1' THEN
						DispMsgSelect <= "000";
						DispToggle <= '0';
					ELSIF DispRunning <= '0' AND DispToggle <= '0' THEN
						State <= Turn;
					END IF;

					DispToggle <= '1';
				WHEN Turn =>

					-- IF THE PLAYER HAS FIRED
					IF Fire = '0' THEN
						IF (WhichPlayer = '0' AND HorM2 = '1') OR (WhichPlayer = '1' AND HorM1 = '1') THEN
							State <= Hit;
						ELSE
							State <= Miss;
						END IF;
					END IF;
					
				WHEN Hit =>

					-- dsplay HIT
					IF (WhichPlayer = '0' AND Cleared2 = '1') OR (WhichPlayer = '1' AND Cleared1 = '1') THEN
						State <= Win;
					ELSE
						WhichPlayer <= NOT WhichPlayer;
						State <= Turn;
					END IF;

				WHEN Miss =>
	
					-- display Miss
					WhichPlayer <= NOT WhichPlayer;
					State <= Turn;

				WHEN Win =>
					
					-- display Win
					State <= Start;

			END CASE;
		END IF;
	END PROCESS;

	B1:board PORT MAP(NOT WhichPlayer, InternalReset, Fire, X, Y, HorM1, Cleared1);
	B2:board PORT MAP(WhichPlayer, InternalReset, Fire, X, Y, HorM2, Cleared2);
	DISP:display PORT MAP(DispToggle, InternalReset, Clk, DispMsgSelect, SSH1, SSH2, SSH3, SSH4, SSH5, SSH6, DispRunning);

	CurrentState <= "0000" WHEN State = Start ELSE
		"0001" WHEN State = Turn ELSE
		"0010" WHEN State = Hit ELSE
		"0100" WHEN State = Miss ELSE
		"1000" WHEN State = Win ELSE
		"1111";
END behaviour;