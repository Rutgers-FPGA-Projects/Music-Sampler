-- Import logic primitives
LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY ir_sensor_and_sound IS
port ( GPIO											 : 	INOUT std_LOGIC_VECTOR(7 DOWNTO 0);
		 CLOCK_50, TD_CLK27					    : 	IN std_logic;
		 AUD_ADCDAT 								 : 	IN std_logic;
		 AUD_ADCLRCK, AUD_BCLK					 :		OUT std_logic;
		 AUD_DACLRCK								 :		INOUT std_logic;
		 AUD_DACDAT, AUD_XCK 					 : 	OUT std_logic;
		 SW											 : 	IN std_logic_vector(17 DOWNTO 0);
		 KEY											 :		IN std_logic_vector(3 downto 0);
		 LEDR											 : 	OUT std_logic_vector(7 downto 0);
		 
		 EEP_I2C_SCLK 							    : OUT std_logic;
		 EEP_I2C_SDAT 								 : inout std_logic;

		 I2C_SCLK 									 : out std_logic;
		 I2C_SDAT 								    : inout std_logic);
end ir_sensor_and_sound;

ARCHITECTURE Structure of ir_sensor_and_sound is
	--declare all components to be used
	COMPONENT  adio_codec IS
		PORT(oAUD_DATA, oAUD_LRCK 	: out std_logic;
			  oAUD_BCK					:out std_logic;
			  key1_on, key2_on,
			  key3_on, key4_on						: in std_logic;
			  iSrc_Select						: in std_logic_vector(1 DOWNTO 0);				

			  iCLK_18_4, iRST_N				: in std_logic;
			  
			  sound1, sound2,
			  sound3, sound4					:in std_logic_vector(15 DOWNTO 0);

		     instru								:in std_logic);
	END COMPONENT;
	

	
	COMPONENT I2C_AV_Config IS
		PORT(iCLK : in std_logic;
			  iRST_N : in std_logic;
			  o_I2C_END, I2C_SCLK : out std_logic;
			  I2C_SDAT : inout std_logic);
	END COMPONENT;
	
	
	COMPONENT VGA_Audio_PLL IS
		PORT(areset, inclk0 : in std_logic;
			  c0, c1, c2     : out std_logic);
	END COMPONENT;
	
	COMPONENT FREQ_LOOKUP_TABLE IS
		PORT( sel : IN STD_LOGIC_VECTOR(7 downto 0);
				HI : IN STD_LOGIC_VECTOR(3 downto 0);    -- changed 1 downto 0
				F : out STD_LOGIC_VECTOR(15 downto 0));
	END COMPONENT;
	
	
	COMPONENT ir_sensor IS
		PORT( GPIO : inout STD_LOGIC_VECTOR(7 DOWNTO 0);
				CLOCK_50 : in STD_LOGIC;
				LEDR : out std_LOGIC_VECTOR(7 downto 0);
				GPIO_OUT : out STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0'));  --which keys are being pressed on the keyboard
	END COMPONENT;
	

	SIGNAL sound1 : std_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL AUD_CTRL_CLK : std_logic;
	SIGNAL I2C_END : std_logic;
	signal GPIO_OUT : std_logic_vector(7 downto 0);
	SIGNAL HI : STD_LOGIC_VECTOR(3 downto 0);     -- changed 1 downto 0
	


	
BEGIN
	HI(3 downto 0) <= SW(3 downto 0); 					
	--I2C

	CONF1 : I2C_AV_Config PORT MAP(
			iCLK	=> CLOCK_50,
			iRST_N	=>  KEY(0) ,
			o_I2C_END => I2C_END ,
			I2C_SCLK => I2C_SCLK ,
			I2C_SDAT	=> I2C_SDAT );


   --AUDIO SOUND

	AUD_ADCLRCK	<=	AUD_DACLRCK;
	AUD_XCK	   <=	AUD_CTRL_CLK;			

   --AUDIO PLL

	PLL1 : VGA_Audio_PLL PORT MAP(
			areset =>( NOT I2C_END) ,
			inclk0 => TD_CLK27 ,
			c1	=> AUD_CTRL_CLK);				
						
	SY1 : adio_codec PORT MAP(	
	
		oAUD_DATA => AUD_DACDAT,
	   oAUD_LRCK => AUD_DACLRCK,			
		oAUD_BCK => AUD_BCLK,
		iCLK_18_4 => AUD_CTRL_CLK,
		iRST_N	 => KEY(0),							
		iSrc_Select => "00",		
		key1_on => '1',	
		key2_on => '0',
		key3_on => '0',
		key4_on => '0',
		sound1 => sound1,					
		sound2 => (others => '0'),					
		sound3 => (others => '0'),					
		sound4 => (others => '0'),												
		instru => SW(17));


KB1 : ir_sensor PORT MAP(
		GPIO => GPIO,
		CLOCK_50 => CLOCK_50,
		ledr => ledr,
		GPIO_OUT => GPIO_OUT);
		
FLT1 : FREQ_LOOKUP_TABLE 
	PORT MAP(GPIO_OUT, HI, sound1);

		
--	LEDR <= KEYBOARD(17 downto 0);
END STRUCTURE;
--------------------------------------------------------

--------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use ieee.std_logic_arith.all;

ENTITY FREQ_LOOKUP_TABLE IS
		PORT( sel : IN STD_LOGIC_VECTOR(7 downto 0);
				HI : IN STD_LOGIC_VECTOR(3 downto 0);
				F : out STD_LOGIC_VECTOR(15 downto 0));
END FREQ_LOOKUP_TABLE;

ARCHITECTURE Structure OF FREQ_LOOKUP_TABLE IS
		SIGNAL note : integer := 0;

BEGIN
	PROCESS(sel, HI)
	BEGIN

	IF (HI = "0000") THEN     -- C Major SCALE 
	CASE sel IS
		when "00000001"=> note <= 262; --C4
		when "00000010"=> note <= 294; --D4
		when "00000100"=> note <= 330; --E4
		when "00001000"=> note <= 349; --F4
		when "00010000"=> note <= 392; --G4
		when "00100000"=> note <= 440; --A4
		when "01000000"=> note <= 494; --B4
		when "10000000"=> note <= 523; --C6
		when others => note <= 0;
		END CASE;
	ELSIF(HI = "0001") THEN      -- G Major Scale 
	CASE sel IS
		when "00000001"=> note <= 392; --G4
		when "00000010"=> note <= 440; --A4
		when "00000100"=> note <= 494; --B4
		when "00001000"=> note <= 523; --C5
		when "00010000"=> note <= 587; --D5
		when "00100000"=> note <= 659; --E5
		when "01000000"=> note <= 740; --F5#
		when "10000000"=> note <= 784; --G5
		when others => note <= 0;
		END CASE;
	ELSIF(HI = "0010") THEN   	--D  MAJOR 
	CASE sel IS
		when "00000001"=> note <= 294; --D4
		when "00000010"=> note <= 330; --E4
		when "00000100"=> note <= 370; --F4#
		when "00001000"=> note <= 392; --G4
		when "00010000"=> note <= 440; --A4
		when "00100000"=> note <= 494; --B4
		when "01000000"=> note <= 554; --C5#
		when "10000000"=> note <= 587; --D5
		when others => note <= 0;
		END CASE;
	ELSIF(HI = "0011") THEN 					-- A Major      
	CASE sel IS
		when "00000001"=> note <= 220; --A3
		when "00000010"=> note <= 247; --B3
		when "00000100"=> note <= 277; --C4#
		when "00001000"=> note <= 294; --D4
		when "00010000"=> note <= 330; --E4
		when "00100000"=> note <= 370; --F4#
		when "01000000"=> note <= 415; --G4#
		when "10000000"=> note <= 440; --A4
		when others => note <= 0;
		END CASE;
	ELSIF(HI = "0100") THEN 					-- E Major      
	CASE sel IS
		when "00000001"=> note <= 330; --E4
		when "00000010"=> note <= 370; --F4#
		when "00000100"=> note <= 415; --G4#
		when "00001000"=> note <= 440; --A4
		when "00010000"=> note <= 494; --B4
		when "00100000"=> note <= 554; --C5#
		when "01000000"=> note <= 622; --D5#
		when "10000000"=> note <= 659; --E5
		when others => note <= 0;
		END CASE;
	ELSIF(HI = "0101") THEN 					-- B Major      
	CASE sel IS
		when "00000001"=> note <= 247; --B3
		when "00000010"=> note <= 277; --C4#
		when "00000100"=> note <= 311; --D4#
		when "00001000"=> note <= 330; --E4
		when "00010000"=> note <= 370; --F4#
		when "00100000"=> note <= 415; --G4#
		when "01000000"=> note <= 466; --A4#
		when "10000000"=> note <= 494; --B4
		when others => note <= 0;
		END CASE;
	ELSIF(HI = "0110") THEN 					-- F# Major      
	CASE sel IS
		when "00000001"=> note <= 185; --F3#
		when "00000010"=> note <= 208; --G3#
		when "00000100"=> note <= 233; --A3#
		when "00001000"=> note <= 247; --B3
		when "00010000"=> note <= 277; --C4#
		when "00100000"=> note <= 311; --D4#
		when "01000000"=> note <= 349; --F4
		when "10000000"=> note <= 370; --F4#
		when others => note <= 0;
		END CASE;
ELSIF(HI = "0111") THEN 					-- Db Major      
	CASE sel IS
		when "00000001"=> note <= 277; --C4#  Db
		when "00000010"=> note <= 311; --D4#  Eb
		when "00000100"=> note <= 349; --F4   F
		when "00001000"=> note <= 370; --F4#  Gb
		when "00010000"=> note <= 415; --G4#  Ab
		when "00100000"=> note <= 466; --A4#  Bb
		when "01000000"=> note <= 523; --C5   C
		when "10000000"=> note <= 554; --C5#  Db
		when others => note <= 0;
		END CASE;
ELSIF(HI = "1000") THEN 					-- Ab Major      
	CASE sel IS
		when "00000001"=> note <= 208; --G3# Ab
		when "00000010"=> note <= 233; --A3# Bb
		when "00000100"=> note <= 262; --C4  C
		when "00001000"=> note <= 277; --C4# Db
		when "00010000"=> note <= 311; --D4# Eb
		when "00100000"=> note <= 349; --F4  F
		when "01000000"=> note <= 392; --G4  G
		when "10000000"=> note <= 415; --G4# Ab
		when others => note <= 0;
		END CASE;
ELSIF(HI = "1001") THEN 					-- Eb Major      
	CASE sel IS
		when "00000001"=> note <= 311; --D4# Eb
		when "00000010"=> note <= 349; --F4  F
		when "00000100"=> note <= 392; --G4  G
		when "00001000"=> note <= 415; --G4# Ab
		when "00010000"=> note <= 466; --A4# Bb
		when "00100000"=> note <= 523; --C5  C
		when "01000000"=> note <= 587; --D5  D 
		when "10000000"=> note <= 622; --D5# Eb
		when others => note <= 0;
		END CASE;
ELSIF(HI = "1010") THEN 					-- Bb Major      
	CASE sel IS
		when "00000001"=> note <= 233; --A3# Bb
		when "00000010"=> note <= 262; --C4  C
		when "00000100"=> note <= 294; --D4  D
		when "00001000"=> note <= 311; --D4# Eb
		when "00010000"=> note <= 349; --F4  F
		when "00100000"=> note <= 392; --G4  G
		when "01000000"=> note <= 440; --A4  A
		when "10000000"=> note <= 466; --A4# Bb
		when others => note <= 0;
		END CASE;
ELSIF(HI = "1011") THEN 					-- F Major      
	CASE sel IS
		when "00000001"=> note <= 174; --    F3
		when "00000010"=> note <= 196; --    G3
		when "00000100"=> note <= 220; --    A3
		when "00001000"=> note <= 233; --A3# Bb
		when "00010000"=> note <= 262; --    C4
		when "00100000"=> note <= 294; --    D4
		when "01000000"=> note <= 330; --    E4
		when "10000000"=> note <= 349; --    F4
		when others => note <= 0;
		END CASE;
ELSIF(HI = "1100") THEN 					-- A MINOR       
	CASE sel IS
		when "00000001"=> note <= 220; --A3
		when "00000010"=> note <= 247; --B3
		when "00000100"=> note <= 262; --C4
		when "00001000"=> note <= 294; --D4
		when "00010000"=> note <= 330; --E4
		when "00100000"=> note <= 349; --F4
		when "01000000"=> note <= 392; --G4
		when "10000000"=> note <= 440; --A4
		when others => note <= 0;
		END CASE;
ELSIF(HI = "1101") THEN 					-- E MINOR       
	CASE sel IS
		when "00000001"=> note <= 330; --E4
		when "00000010"=> note <= 370; --F4#
		when "00000100"=> note <= 392; --G4
		when "00001000"=> note <= 440; --A4
		when "00010000"=> note <= 494; --B4
		when "00100000"=> note <= 523; --C5
		when "01000000"=> note <= 587; --D5
		when "10000000"=> note <= 659; --E5
		when others => note <= 0;
		END CASE;
ELSIF(HI = "1110") THEN 					-- B MINOR       
	CASE sel IS
		when "00000001"=> note <= 247; --B3
		when "00000010"=> note <= 277; --C4#
		when "00000100"=> note <= 294; --D4
		when "00001000"=> note <= 330; --E4
		when "00010000"=> note <= 370; --F4#
		when "00100000"=> note <= 392; --G4
		when "01000000"=> note <= 440; --A4
		when "10000000"=> note <= 494; --B4
		when others => note <= 0;
		END CASE;
ELSE 					-- C egyption scale      
	CASE sel IS
		when "00000001"=> note <= 262; --C4
		when "00000010"=> note <= 294; --D4
		when "00000100"=> note <= 349; --F4
		when "00001000"=> note <= 392; --G4
		when "00010000"=> note <= 466; --A4#
		when "00100000"=> note <= 523; --C5
		when "01000000"=> note <= 587; --D5
		when "10000000"=> note <= 698; --F5
		when others => note <= 0;
		END CASE;
END IF;


		F <= conv_std_logic_vector(note, 16);
	END PROCESS;
END STRUCTURE;	

















