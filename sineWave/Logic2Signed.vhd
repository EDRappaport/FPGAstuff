----------------------------------------------------------------------------------
-- Company: Cooper Union
-- Engineer: Nicollete Kupferstein, Elliot Rappaport
-- 
-- Create Date:    09:23:23 04/02/2014 
-- Project Name:	Directive Speaker Array
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Logic2Signed is
	generic ( BitWidth: integer := 8 );
	Port ( 	InLogic 			: in  STD_LOGIC_VECTOR (BitWidth-1 downto 0) := (others => '0');
				OutSigned 		: out STD_LOGIC_VECTOR (BitWidth-1 downto 0) := (others => '0')
			);
end Logic2Signed;

architecture Behavioral of Logic2Signed is

		signal x_signed : signed (BitWidth downto 0) := (others => '0');
		signal x_logic  : STD_LOGIC_VECTOR (BitWidth downto 0) := (others => '0');
		constant offset : signed (BitWidth downto 0) := "010000000";
		
begin
		x_signed <= signed('0' & InLogic) - offset;
		x_logic 	<= STD_LOGIC_VECTOR(x_signed);
		OutSigned <= x_logic(BitWidth-1 downto 0);

end Behavioral;

