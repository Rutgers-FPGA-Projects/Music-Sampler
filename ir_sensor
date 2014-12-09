

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ir_sensor IS
PORT( GPIO : inout STD_LOGIC_VECTOR(7 DOWNTO 0);
		CLOCK_50 : in STD_LOGIC;
		LEDR : out std_LOGIC_VECTOR(7 downto 0);    
		GPIO_OUT : out STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0'));    
END ir_sensor;

ARCHITECTURE behavioral OF ir_sensor IS
	--SIGNAL KEYBOARD : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	SIGNAL tempclock : STD_LOGIC;
	SIGNAL count : INTEGER RANGE 0 TO 249999 := 0; --for creating lower freq clock
	SIGNAL count2 : INTEGER RANGE 0 TO 1 := 0; --for cycling which keys are being tested, and alte
	signal tempsig : std_LOGIC_vector(7 downto 0);
BEGIN
	
	PROCESS(CLOCK_50)
	BEGIN
		IF rising_edge(CLOCK_50) THEN
			IF (count = 25000) THEN
				tempclock <= NOT tempclock;
				count <= 0;
			ELSE
				count <= count + 1;
			END IF;
		END IF;
	END PROCESS;
tempsig <= gpio;
	



PROCESS(tempsig(7 downto 0), tempclock)   -- new process for state machine 
	BEGIN
		IF rising_edge(tempclock) THEN
			CASE count2 IS
				WHEN 0 =>
							IF (tempsig(0) = '1') THEN GPIO_OUT(0) <= '1'; LEDR(0) <= '1'; 
							ELSE GPIO_OUT(0) <= '0'; LEDR(0) <= '0';
							END IF; 
							IF (tempsig(1) = '1') THEN GPIO_OUT(1) <= '1'; LEDR(1) <= '1'; 
							ELSE GPIO_OUT(1) <= '0'; LEDR(1) <= '0';
							END IF; 
							IF (tempsig(2) = '1') THEN GPIO_OUT(2) <= '1'; LEDR(2) <= '1'; 
							ELSE GPIO_OUT(2) <= '0'; LEDR(2) <= '0';
							END IF; 
							IF (tempsig(3) = '1') THEN GPIO_OUT(3) <= '1'; LEDR(3) <= '1'; 
							ELSE GPIO_OUT(3) <= '0'; LEDR(3) <= '0';
							END IF; 
							IF (tempsig(4) = '1') THEN GPIO_OUT(4) <= '1'; LEDR(4) <= '1'; 
							ELSE GPIO_OUT(4) <= '0'; LEDR(4) <= '0';
							END IF; 
							IF (tempsig(5) = '1') THEN GPIO_OUT(5) <= '1'; LEDR(5) <= '1'; 
							ELSE GPIO_OUT(5) <= '0'; LEDR(5) <= '0';
							END IF; 
							IF (tempsig(6) = '1') THEN GPIO_OUT(6) <= '1'; LEDR(6) <= '1'; 
							ELSE GPIO_OUT(6) <= '0'; LEDR(6) <= '0';
							END IF; 
							IF (tempsig(6) = '1') THEN GPIO_OUT(6) <= '1'; LEDR(6) <= '1'; 
							ELSE GPIO_OUT(6) <= '0'; LEDR(6) <= '0';
							END IF; 
							IF (tempsig(7) = '1') THEN GPIO_OUT(7) <= '1'; LEDR(7) <= '1'; 
							ELSE GPIO_OUT(7) <= '0'; LEDR(7) <= '0';
							END IF; 
				WHEN 1 =>
							IF (tempsig(0) = '1') THEN GPIO_OUT(0) <= '1'; LEDR(0) <= '1'; 
							ELSE GPIO_OUT(0) <= '0'; LEDR(0) <= '0';
							END IF; 
							IF (tempsig(1) = '1') THEN GPIO_OUT(1) <= '1'; LEDR(1) <= '1'; 
							ELSE GPIO_OUT(1) <= '0'; LEDR(1) <= '0';
							END IF; 
							IF (tempsig(2) = '1') THEN GPIO_OUT(2) <= '1'; LEDR(2) <= '1'; 
							ELSE GPIO_OUT(2) <= '0'; LEDR(2) <= '0';
							END IF; 
							IF (tempsig(3) = '1') THEN GPIO_OUT(3) <= '1'; LEDR(3) <= '1'; 
							ELSE GPIO_OUT(3) <= '0'; LEDR(3) <= '0';
							END IF; 
							IF (tempsig(4) = '1') THEN GPIO_OUT(4) <= '1'; LEDR(4) <= '1'; 
							ELSE GPIO_OUT(4) <= '0'; LEDR(4) <= '0';
							END IF; 
							IF (tempsig(5) = '1') THEN GPIO_OUT(5) <= '1'; LEDR(5) <= '1'; 
							ELSE GPIO_OUT(5) <= '0'; LEDR(5) <= '0';
							END IF; 
							IF (tempsig(6) = '1') THEN GPIO_OUT(6) <= '1'; LEDR(6) <= '1'; 
							ELSE GPIO_OUT(6) <= '0'; LEDR(6) <= '0';
							END IF; 
							IF (tempsig(6) = '1') THEN GPIO_OUT(6) <= '1'; LEDR(6) <= '1'; 
							ELSE GPIO_OUT(6) <= '0'; LEDR(6) <= '0';
							END IF; 
							IF (tempsig(7) = '1') THEN GPIO_OUT(7) <= '1'; LEDR(7) <= '1'; 
							ELSE GPIO_OUT(7) <= '0'; LEDR(7) <= '0';
							END IF; 

							
			IF (count2 = 1) THEN
				count2 <= 0;
			ELSE
				count2 <= count2 + 1;
			END IF;
			
				END CASE; 
		END IF; 
				
END PROCESS;	



END behavioral;




