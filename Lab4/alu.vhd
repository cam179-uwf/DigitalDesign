LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY alu IS
	PORT (
		A,B: 		IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- A and B inputs.
		C: 		IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Control bits.
		R:			OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); -- Result bits.
		V: 		OUT STD_LOGIC := '0'; -- Overflow
		Z: 		OUT STD_LOGIC := '0'; -- Zero
		N: 		OUT STD_LOGIC := '0'; -- Negative
		Cout: 	OUT STD_LOGIC := '0' -- Carry Out
	);
END alu;

ARCHITECTURE behaviour OF alu IS
	FUNCTION FourBitAdder(
		P: STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
		Q: STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0')
		) RETURN STD_LOGIC_VECTOR IS
		VARIABLE result: STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
		VARIABLE Cout2: STD_LOGIC := '0';
	BEGIN
		
		FOR i IN 0 TO 3 LOOP
			result(i) := ((NOT Cout2) AND (P(i) XOR Q(i))) OR (Cout2 AND NOT (P(i) XOR Q(i)));
			Cout2 := ((NOT Cout2) AND (P(i) AND Q(i))) OR (Cout2 AND (P(i) OR Q(i)));
		END LOOP;
		
		result(4) := Cout2;
		
		RETURN result;
	END FUNCTION;
BEGIN

	PROCESS (A, B, C)
		-- stores the result of any calculation we
		-- do using the 4-bit adder
		VARIABLE sum: STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
		
		-- temporary value to store the result in
		-- this allows for reading the result while
		-- R does not since it is an OUT pin.
		VARIABLE temp: STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	BEGIN
		IF C = "000" THEN -- AND
		
			temp := A AND B;
			
			-- set flags
			V <= '0';
			Cout <= '0';
			
		ELSIF C = "001" THEN -- OR
		
			temp := A OR B;
			
			-- set flags
			V <= '0';
			Cout <= '0';
		
		ELSIF C = "010" THEN -- COMPLEMENT
		
			temp := NOT A;
			
			-- set flags
			V <= '0';
			Cout <= '0';
		
		ELSIF C = "011" THEN -- ADD
		
			sum := FourBitAdder(A, B);
			temp(0) := sum(0);
			temp(1) := sum(1);
			temp(2) := sum(2);
			temp(3) := sum(3);
			
			-- set flags
			Cout <= sum(4);
			V <= (A(3) AND B(3) AND NOT temp(3)) OR (NOT A(3) AND NOT B(3) AND temp(3));
		
		ELSIF C = "100" THEN -- INCREMENT
		
			sum := FourBitAdder(A, "0001");
			temp(0) := sum(0);
			temp(1) := sum(1);
			temp(2) := sum(2);
			temp(3) := sum(3);
			
			-- set flags
			Cout <= sum(4);
			V <= (A(3) AND B(3) AND NOT temp(3)) OR (NOT A(3) AND NOT B(3) AND temp(3));
		
		ELSIF C = "101" THEN -- DECREMENT
		
			sum := FourBitAdder(A, "1111");
			temp(0) := sum(0);
			temp(1) := sum(1);
			temp(2) := sum(2);
			temp(3) := sum(3);
			
			-- set flags
			Cout <= NOT sum(4);
			V <= (NOT A(3) AND B(3) AND temp(3)) OR (A(3) AND NOT B(3) AND NOT temp(3));
		
		ELSIF C = "110" THEN -- SUBTRACT
		
			sum := FourBitAdder(A, (NOT B) + '1');
			temp(0) := sum(0);
			temp(1) := sum(1);
			temp(2) := sum(2);
			temp(3) := sum(3);
			
			-- set flags
			Cout <= NOT sum(4);
			V <= (NOT A(3) AND B(3) AND temp(3)) OR (A(3) AND NOT B(3) AND NOT temp(3));
		
		ELSIF C = "111" THEN -- NEGATE
		
			temp := (NOT A) + '1';
			
			-- set flags
			Cout <= '0';

			-- I thought making the negation of "1000" count as an overflow was
			-- important for someone using my ALU. Overflow means that my calculation
			-- is outside the bounds of what is possible to calculate with 4-bits.
			V <= A(3) AND NOT A(2) AND NOT A(1) AND NOT A(0);
		
		END IF;
		
		-- set flags
		Z <= NOT temp(0) AND NOT temp(1) AND NOT temp(2) AND NOT temp(3);
		N <= temp(3);
		
		-- set result
		R <= temp;
		
	END PROCESS;
END behaviour;