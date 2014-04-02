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
	switch : in std_logic;
	audioOut : out std_logic_vector (11 downto 0)
);
end main;

architecture Behavioral of main is

constant M : integer := 8; -- M <=12

-- memory block where audio is currently stored
-- may eventually come from actual audio source
COMPONENT musicStorage --There are 65,536 samples
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

-- the FIR filter component
component FIR
	port (
		clk: in std_logic;
		filter_sel: in std_logic_vector(3 downto 0);
		rfd: out std_logic;
		rdy: out std_logic;
		din: in std_logic_vector(7 downto 0);
		dout: out std_logic_vector(24 downto 0)
	);
end component;

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
	
	signal rfd				: std_logic_vector(11 downto 0); --signal for FIR
	signal rdy				: std_logic_vector(11 downto 0); --signal for FIR
	signal rawMusic		: std_logic_vector(M-1 downto 0) := (others => '0'); --x unsigned
	signal signedMusic	: std_logic_vector(M-1 downto 0) := (others => '0'); --x1 signed music signal
	signal selectedData	: std_logic_vector(M-1 downto 0) := (others => '0'); --x0 data to be filtered
	
	signal filteredOutput0: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput1: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput2: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput3: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput4: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput5: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput6: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput7: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput8: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput9: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput10: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	signal filteredOutput11: std_logic_vector(24 downto 0) := (others => '0'); --y0 returned from filter
	
	signal selectedOutput0: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput1: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput2: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput3: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput4: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput5: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput6: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput7: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput8: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput9: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput10: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	signal selectedOutput11: std_logic_vector(M-1 downto 0) := (others => '0'); --y1 depends on switch
	
	signal musicOutput0	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput1	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput2	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput3	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput4	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput5	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput6	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput7	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput8	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput9	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput10	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	signal musicOutput11	: std_logic_vector(M-1 downto 0) := (others => '0'); --y final output
	
	signal count      	: std_logic_vector(15 downto 0) := (others => '0');

begin

--map into music file
Zelda : musicStorage Port map(clk,count,rawMusic);
L2S : Logic2Signed
	Generic map(M)
	Port map(rawMusic, signedMusic);

-- 12 Speakers, bank of 12 Filters:
filter0 : FIR port map(clk, std_logic_vector(to_unsigned(0, 4)), rfd(0), rdy(0), selectedData, filteredOutput0);
filter1 : FIR port map(clk, std_logic_vector(to_unsigned(1, 4)), rfd(1), rdy(1), selectedData, filteredOutput1);
filter2 : FIR port map(clk, std_logic_vector(to_unsigned(2, 4)), rfd(2), rdy(2), selectedData, filteredOutput2);
filter3 : FIR port map(clk, std_logic_vector(to_unsigned(3, 4)), rfd(3), rdy(3), selectedData, filteredOutput3);
filter4 : FIR port map(clk, std_logic_vector(to_unsigned(4, 4)), rfd(4), rdy(4), selectedData, filteredOutput4);
filter5 : FIR port map(clk, std_logic_vector(to_unsigned(5, 4)), rfd(5), rdy(5), selectedData, filteredOutput5);
filter6 : FIR port map(clk, std_logic_vector(to_unsigned(6, 4)), rfd(6), rdy(6), selectedData, filteredOutput6);
filter7 : FIR port map(clk, std_logic_vector(to_unsigned(7, 4)), rfd(7), rdy(7), selectedData, filteredOutput7);
filter8 : FIR port map(clk, std_logic_vector(to_unsigned(8, 4)), rfd(8), rdy(8), selectedData, filteredOutput8);
filter9 : FIR port map(clk, std_logic_vector(to_unsigned(9, 4)), rfd(9), rdy(9), selectedData, filteredOutput9);
filter10 : FIR port map(clk, std_logic_vector(to_unsigned(10, 4)), rfd(10), rdy(10), selectedData, filteredOutput10);
filter11 : FIR port map(clk, std_logic_vector(to_unsigned(11, 4)), rfd(11), rdy(11), selectedData, filteredOutput11);

-- 12 Signed2Logic
converter0 : Signed2Logic
	Generic map(M)
	port map(selectedOutput0, musicOutput0);
converter1 : Signed2Logic
	Generic map(M)
	port map(selectedOutput1, musicOutput1);
converter2 : Signed2Logic
	Generic map(M)
	port map(selectedOutput2, musicOutput2);
converter3 : Signed2Logic
	Generic map(M)
	port map(selectedOutput3, musicOutput3);
converter4 : Signed2Logic
	Generic map(M)
	port map(selectedOutput4, musicOutput4);
converter5 : Signed2Logic
	Generic map(M)
	port map(selectedOutput5, musicOutput5);
converter6 : Signed2Logic
	Generic map(M)
	port map(selectedOutput6, musicOutput6);
converter7 : Signed2Logic
	Generic map(M)
	port map(selectedOutput7, musicOutput7);
converter8 : Signed2Logic
	Generic map(M)
	port map(selectedOutput8, musicOutput8);
converter9 : Signed2Logic
	Generic map(M)
	port map(selectedOutput9, musicOutput9);
converter10 : Signed2Logic
	Generic map(M)
	port map(selectedOutput10, musicOutput10);
converter11 : Signed2Logic
	Generic map(M)
	port map(selectedOutput11, musicOutput11);

-- 12 D to A Converters
DAC0 : MyDac
	Generic map(M)
	port map(clk, musicOutput0, audioOut(0));
DAC1 : MyDac
	Generic map(M)
	port map(clk, musicOutput1, audioOut(1));
DAC2 : MyDac
	Generic map(M)
	port map(clk, musicOutput2, audioOut(2));
DAC3 : MyDac
	Generic map(M)
	port map(clk, musicOutput3, audioOut(3));
DAC4 : MyDac
	Generic map(M)
	port map(clk, musicOutput4, audioOut(4));
DAC5 : MyDac
	Generic map(M)
	port map(clk, musicOutput5, audioOut(5));
DAC6 : MyDac
	Generic map(M)
	port map(clk, musicOutput6, audioOut(6));
DAC7 : MyDac
	Generic map(M)
	port map(clk, musicOutput7, audioOut(7));
DAC8 : MyDac
	Generic map(M)
	port map(clk, musicOutput8, audioOut(8));
DAC9 : MyDac
	Generic map(M)
	port map(clk, musicOutput9, audioOut(9));
DAC10 : MyDac
	Generic map(M)
	port map(clk, musicOutput10, audioOut(10));
DAC11 : MyDac
	Generic map(M)
	port map(clk, musicOutput11, audioOut(11));


selectedData <= signedMusic;

-- decide between output from filter and untouched input
selectedOutput0 <= filteredOutput0(7 downto 0) when switch = '1' else selectedData;
selectedOutput1 <= filteredOutput1(7 downto 0) when switch = '1' else selectedData;
selectedOutput2 <= filteredOutput2(7 downto 0) when switch = '1' else selectedData;
selectedOutput3 <= filteredOutput3(7 downto 0) when switch = '1' else selectedData;
selectedOutput4 <= filteredOutput4(7 downto 0) when switch = '1' else selectedData;
selectedOutput5 <= filteredOutput5(7 downto 0) when switch = '1' else selectedData;
selectedOutput6 <= filteredOutput6(7 downto 0) when switch = '1' else selectedData;
selectedOutput7 <= filteredOutput7(7 downto 0) when switch = '1' else selectedData;
selectedOutput8 <= filteredOutput8(7 downto 0) when switch = '1' else selectedData;
selectedOutput9 <= filteredOutput9(7 downto 0) when switch = '1' else selectedData;
selectedOutput10 <= filteredOutput10(7 downto 0) when switch = '1' else selectedData;
selectedOutput11 <= filteredOutput11(7 downto 0) when switch = '1' else selectedData;


process(rfd)
begin
	--if ((rfd(0) & rfd(1) & rfd(2) & rfd(3) & rfd(4) & rfd(5) & rfd(6) & rfd(7) & rfd(8) & rfd(9) & rfd(10) & rfd(11)) == '1') then
	if (rfd = "111111111111") then
		count <= count+1;
	end if;
end process;

end Behavioral;

