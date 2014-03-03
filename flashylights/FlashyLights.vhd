----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:13:28 02/23/2014 
-- Design Name: 
-- Module Name:    FlashyLights - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.fdff
--library UNISIM;
--use UNISIM.VComponents.all;

entity FlashyLights is
    Port ( clk : in  STD_LOGIC;
           LEDs : out  STD_LOGIC_VECTOR (7 downto 0));
end FlashyLights;

architecture Behavioral of FlashyLights is
	COMPONENT counter30
		PORT (
			clk : IN STD_LOGIC;
			q : OUT STD_LOGIC_VECTOR(29 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT memory
		PORT (
			clka : IN STD_LOGIC;
			addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
			douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	
	signal count : STD_LOGIC_VECTOR(29 downto 0);
begin

addr_counter : counter30
  PORT MAP (
    clk => clk,
    q => count
  );
  
rom_memory : memory
  PORT MAP (
    clka => clk,
    addra => count(29 downto 19),
    douta => LEDs
  );


end Behavioral;

