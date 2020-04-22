library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Port Declaration for (+4) Incrementor (inc)
entity inc is
	port (	
			input : in std_logic_vector(31 downto 0);
			output : out std_logic_vector(31 downto 0)
	);
end inc;

architecture behavior of inc is

-- Behavioral Process for (+4) Incrementor (inc)
begin
	
	output <= std_logic_vector(unsigned(input) + 4);
	
end behavior;
