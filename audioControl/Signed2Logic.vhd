----------------------------------------------------------------------------------
-- Company: Cooper Union
-- Engineer: Nicollete Kupferstein, Elliot Rappaport
-- 
-- Create Date:    09:33:49 04/02/2014 
-- Project Name:	Directive Speaker Array
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Signed2Logic is
	generic ( BitWidth: integer := 8 );
	Port ( 	InSigned			: in  STD_LOGIC_VECTOR (BitWidth-1 downto 0) := (others => '0');
				OutLogic 		: out STD_LOGIC_VECTOR (BitWidth-1 downto 0) := (others => '0')				
			);
end Signed2Logic;

architecture Behavioral of Signed2Logic is

		signal y_logic  : STD_LOGIC_VECTOR (BitWidth downto 0) := (others => '0');
		signal y_signed : signed (BitWidth downto 0) := (others => '0');
		constant offset : signed (BitWidth downto 0) := "010000000";
		
begin
		
		y_signed <= signed('0' & InSigned) + offset;
		y_logic 	<= STD_LOGIC_VECTOR(y_signed);
		OutLogic <= y_logic(BitWidth-1 downto 0);
end Behavioral;
