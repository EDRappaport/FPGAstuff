----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:39:44 02/18/2014 
-- Design Name: 
-- Module Name:    Switch_LEDSs - Behavioral 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Switch_LEDSs is
    Port ( switch_0 : in  STD_LOGIC;
           switch_1 : in  STD_LOGIC;
           LED_0 : out  STD_LOGIC;
           LED_1 : out  STD_LOGIC);
end Switch_LEDSs;

architecture Behavioral of Switch_LEDSs is
begin
	LED_0 <= switch_0;
	LED_1 <= switch_1;
end Behavioral;

