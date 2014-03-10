----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:43:33 03/09/2014 
-- Design Name: 
-- Module Name:    DFF - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity DFF is
	port(	clk : in std_logic;
			Q : out signed(15 downto 0);
			D : in signed(15 downto 0)			
	);
end DFF;


architecture Behavioral of DFF is

signal qt : signed(15 downto 0) := (others => '0');

begin
Q <= qt;

process(clk)
begin
	if (rising_edge(clk)) then
		qt <= D;
	end if;
end process;
end Behavioral;
