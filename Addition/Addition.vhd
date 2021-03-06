----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:34:41 02/19/2014 
-- Design Name: 
-- Module Name:    Addition - Behavioral 
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

entity Addition is
    Port ( switches : in  STD_LOGIC_VECTOR (7 downto 0);
           LEDs : out  STD_LOGIC_VECTOR (7 downto 0));
end Addition;

architecture Behavioral of Addition is

signal x		: STD_LOGIC_VECTOR (3 downto 0);
signal y		: STD_LOGIC_VECTOR (3 downto 0);
signal carry: STD_LOGIC_VECTOR (3 downto 0);
signal result: STD_LOGIC_VECTOR (4 downto 0);

begin

LEDs <= "000" & result;

x <= switches(3 downto 0);
y <= switches(7 downto 4);

result(0) <= x(0) XOR y(0);
carry(0) <= x(0) AND y(0);

result(1) <= x(1) XOR y(1) XOR carry(0);
carry(1) <= (x(1) AND y(1)) OR (carry(0) AND X(1)) OR (carry(0) AND Y(1));
result(2) <= x(2) XOR y(2) XOR carry(1);
carry(2) <= (x(2) AND y(2)) OR (carry(1) AND X(2)) OR (carry(1) AND Y(2));
result(3) <= x(3) XOR y(3) XOR carry(2);
carry(3) <= (x(3) AND y(3)) OR (carry(2) AND X(3)) OR (carry(2) AND Y(3));
result(4) <= carry(3);

end Behavioral;

