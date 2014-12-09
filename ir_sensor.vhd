
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ir_sensor IS
PORT( GPIO : inout STD_LOGIC_VECTOR(6 DOWNTO 0);
		CLOCK_50 : in STD_LOGIC;
		LEDR : out std_LOGIC_VECTOR(2 downto 0));
END ir_sensor;

ARCHITECTURE behavioral OF ir_sensor IS
	--SIGNAL KEYBOARD : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	SIGNAL tempclock : STD_LOGIC;
	SIGNAL count : INTEGER RANGE 0 TO 249999 := 0; --for creating lower freq clock
	SIGNAL count2 : INTEGER RANGE 0 TO 15 := 0; --for cycling which keys are being tested, and alte
	signal tempsig : std_LOGIC_vector(6 downto 0);
BEGIN
	
--	PROCESS(CLOCK_50)
--	BEGIN
--		IF rising_edge(CLOCK_50) THEN
--			IF (count = 24999) THEN
--				tempclock <= NOT tempclock;
--				count <= 0;
--			ELSE
--				count <= count + 1;
--			END IF;
--		END IF;
--	END PROCESS;

	tempsig <= gpio;
	
PROCESS(tempsig(6 downto 0))
	BEGIN
		IF (tempsig = "0000001") THEN 
			LEDR(0) <= '1'; 
		ELSE 
			LEDR(0) <= '0'; 
		END IF;
		IF (tempsig = "0000010") THEN 
			LEDR(1) <= '1'; 
		ELSE 
			LEDR(1) <= '0'; 
		END IF;
		IF (tempsig = "0000100") THEN 
			LEDR(2) <= '1'; 
		ELSE 
			LEDR(2) <= '0'; 
		END IF;
		IF (tempsig = "0001000") THEN 
			LEDR(3) <= '1'; 
		ELSE 
			LEDR(4) <= '0'; 
		END IF;
		IF (tempsig = "0010000") THEN 
			LEDR(5) <= '1'; 
		ELSE 
			LEDR(5) <= '0'; 
		END IF;
		IF (tempsig = "0100000") THEN 
			LEDR(6) <= '1'; 
		ELSE 
			LEDR(6) <= '0'; 
		END IF;
		IF (tempsig = "1000000") THEN 
			LEDR(7) <= '1'; 
		ELSE 
			LEDR(7) <= '0'; 
		END IF;
		
END PROCESS;	



END behavioral;

