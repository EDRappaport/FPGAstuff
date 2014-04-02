----------------------------------------------------------------------------------
-- Company: Cooper Union
-- Engineer: Nicollete Kupferstein, Elliot Rappaport
-- 
-- Create Date:    09:41:37 04/02/2014 
-- Project Name:	Directive Speaker Array
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MyDAC is
	generic ( BitWidth: integer := 8 );
	Port ( 	clk 			: in STD_LOGIC;
				data 			: in STD_LOGIC_VECTOR (BitWidth-1 downto 0) := (others => '0');
				PulseStream : out STD_LOGIC
			);
end MyDAC;

architecture Behavioral of MyDAC is
		signal sum : STD_LOGIC_VECTOR (BitWidth downto 0);
begin
		PulseStream <= sum(BitWidth);

		process (clk, sum)
		begin
			if rising_edge(clk) then
				sum <= ("0" & sum(BitWidth-1 downto 0)) + ("0" &data);
			end if;
		end process;
end Behavioral;