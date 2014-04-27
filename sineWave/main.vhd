----------------------------------------------------------------------------------
-- Company: Cooper Union
-- Engineer: Nicollete Kupferstein, Elliot Rappaport
-- 
-- Create Date:    11:04:39 04/01/2014 
-- Project Name:	Directive Speaker Array
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
Port(
	clk : in std_logic;
	--LED : out std_logic;
	audioOut : out std_logic_vector (9 downto 0)
);
end main;

architecture Behavioral of main is

constant M : integer := 11; -- M <=12

-- memory block where audio is currently stored
-- may eventually come from actual audio source
component dcm
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic;
  CLK_OUT2          : out    std_logic
 );
end component;

COMPONENT musicStorage
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
  );
END COMPONENT;

-- the FIR filter component


--Digital to Analog Converter
component MyDAC is
	generic ( BitWidth: integer );
	Port (
		Clk : in STD_LOGIC;
		Data : in STD_LOGIC_VECTOR (BitWidth-1 downto 0);
		PulseStream : out STD_LOGIC
	);
end component;

-- convert between signed and logic
component Signed2Logic is
	generic ( BitWidth: integer);
	Port (
		InSigned : in  STD_LOGIC_VECTOR (BitWidth-1 downto 0);
		OutLogic : out STD_LOGIC_VECTOR (BitWidth-1 downto 0)
	);
end component;

component Logic2Signed is
	generic ( BitWidth: integer);
	Port (
		InLogic : in  STD_LOGIC_VECTOR (BitWidth-1 downto 0);
		OutSigned : out STD_LOGIC_VECTOR (BitWidth-1 downto 0)
	);
end component;

--
-- FLOW OF DATA:
-- rawMusic -> signedMusic -> selectedData -> filteredOutputx -> ...
-- ... selectedOuputx -> musicOutputx -> audioOut
--
	
	signal clk_32			: std_logic;
	signal clk_441			: std_logic;
	signal clk_55			: std_logic;
	signal counter			: std_logic_vector(8 downto 0) := (others => '0');
	
	signal rawMusic0		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	signal rawMusic1		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	signal rawMusic2		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	signal rawMusic3		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	signal rawMusic4		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	signal rawMusic5		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	signal rawMusic6		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	signal rawMusic7		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	signal rawMusic8		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	signal rawMusic9		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	
	signal signedMusic0	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	signal signedMusic1	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	signal signedMusic2	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	signal signedMusic3	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	signal signedMusic4	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	signal signedMusic5	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	signal signedMusic6	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	signal signedMusic7	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	signal signedMusic8	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	signal signedMusic9	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	
	signal count      	: std_logic_vector(4 downto 0) := (others => '0');
	signal count1      	: std_logic_vector(4 downto 0) := (others => '0');
	signal count2      	: std_logic_vector(4 downto 0) := (others => '0');
	signal count3      	: std_logic_vector(4 downto 0) := (others => '0');
	signal count4     	: std_logic_vector(4 downto 0) := (others => '0');
	signal count5      	: std_logic_vector(4 downto 0) := (others => '0');
	signal count6      	: std_logic_vector(4 downto 0) := (others => '0');
	signal count7      	: std_logic_vector(4 downto 0) := (others => '0');
	signal count8      	: std_logic_vector(4 downto 0) := (others => '0');
	signal count9      	: std_logic_vector(4 downto 0) := (others => '0');
	--signal musicOutput	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output

begin

--map into music file
myDCM : dcm Port map(clk,clk_32,clk_441);

m0 : musicStorage Port map(clk_32,count,rawMusic0);
m1 : musicStorage Port map(clk_32,count1,rawMusic1);
m2 : musicStorage Port map(clk_32,count2,rawMusic2);
m3 : musicStorage Port map(clk_32,count3,rawMusic3);
m4 : musicStorage Port map(clk_32,count4,rawMusic4);
m5 : musicStorage Port map(clk_32,count5,rawMusic5);
m6 : musicStorage Port map(clk_32,count6,rawMusic6);
m7 : musicStorage Port map(clk_32,count7,rawMusic7);
m8 : musicStorage Port map(clk_32,count8,rawMusic8);
m9 : musicStorage Port map(clk_32,count9,rawMusic9);

count1 <= count + 4;
count2 <= count + 8;
count3 <= count + 12;
count4 <= count + 16;
count5 <= count + 20;
count6 <= count + 24;
count7 <= count + 28;
count8 <= count + 32;
count9 <= count + 36;


-- 12 D to A Converters
DAC0 : MyDac
	Generic map(M)
	port map(clk_32, rawMusic0, audioOut(0));
DAC1 : MyDac
	Generic map(M)
	port map(clk_32, rawMusic1, audioOut(1));
DAC2 : MyDac
	Generic map(M)
	port map(clk_32, rawMusic2, audioOut(2));
DAC3 : MyDac
	Generic map(M)
	port map(clk_32, rawMusic3, audioOut(3));
DAC4 : MyDac
	Generic map(M)
	port map(clk_32, rawMusic4, audioOut(4));
DAC5 : MyDac
	Generic map(M)
	port map(clk_32, rawMusic5, audioOut(5));
DAC6 : MyDac
	Generic map(M)
	port map(clk_32, rawMusic6, audioOut(6));
DAC7 : MyDac
	Generic map(M)
	port map(clk_32, rawMusic7, audioOut(7));
DAC8 : MyDac
	Generic map(M)
	port map(clk_32, rawMusic8, audioOut(8));
DAC9 : MyDac
	Generic map(M)
	port map(clk_32, rawMusic9, audioOut(9));

--process(clk_441)
--begin
--	if rising_edge(clk_441) then
--		if counter = "110010000" then
--			clk_55 <= NOT clk_55;
--			counter <= "000000000";
--		else
--			counter <= counter+1;
--		end if;
--	end if;
--		
--end process;

--process(clk_55)
process(clk_441)
begin
	--if rising_edge(clk_55) then
	if rising_edge(clk_441) then
		count <= count+1;
	end if;
	
end process;

end Behavioral;

