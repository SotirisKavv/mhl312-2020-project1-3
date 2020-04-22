library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Generic_MUX2x1 is
	generic(n : integer);
    Port ( In_A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           In_B : in  STD_LOGIC_VECTOR (n-1 downto 0);
           SEL_out : in  STD_LOGIC;
           Output_data : out  STD_LOGIC_VECTOR (n-1 downto 0));
end Generic_MUX2x1;

architecture Behavioral of Generic_MUX2x1 is

begin
	with SEL_out select
		Output_data <= In_A when '0',
							In_B when '1';
							
end Behavioral;