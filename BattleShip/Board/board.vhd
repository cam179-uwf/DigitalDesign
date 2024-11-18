LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

ENTITY board IS
    PORT (
        E,R,Fire : IN STD_LOGIC;
        X,Y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        HorM,Cleared : OUT STD_LOGIC := '0'
    );
END board;

ARCHITECTURE behaviour OF board IS
    TYPE Matrix_Type IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR(0 TO 15);
    SIGNAL Matrix : Matrix_Type;
BEGIN
    PROCESS(E, R, Fire, X, Y, Matrix)
        VARIABLE Y_Index : INTEGER;
        VARIABLE X_Index : INTEGER;
        VARIABLE InternalClear : STD_LOGIC;
    BEGIN
        Y_Index := TO_INTEGER(UNSIGNED(Y));
        X_Index := TO_INTEGER(UNSIGNED(X));
        InternalClear := '0';

        IF R = '0' THEN

            HorM <= '0';
            InternalClear := '0';
            Matrix <= (
                "1100000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000",
                "0000000000000000"
            );
        ELSE
            IF falling_edge(Fire) AND E = '0' THEN

                IF Matrix(Y_Index)(X_Index) = '1' THEN
                    Matrix(Y_Index)(X_Index) <= '0';

                    HorM <= '1';
                ELSE
                    HorM <= '0';
                END IF;

            END IF;

            IF Matrix = (Matrix'RANGE => "000000000000000") THEN
                InternalClear := '1';
            END IF;
        END IF;

        Cleared <= InternalClear;
    END PROCESS;
END behaviour;