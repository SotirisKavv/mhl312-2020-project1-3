library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Port Declaration for 5-to-32-bit Decoder (dec)
entity dec is
	port (
			input : in  std_logic_vector (4 downto 0);
			output : out std_logic_vector (31 downto 0)
	);
end dec;

architecture behavior of dec is

	-- Temporary Signal Declaration to assist in Behavioral Process of 5-to-32-bit Decoder (dec)
	signal tmp : std_logic_vector (31 downto 0);

begin
	
	-- Behavioral Process of 5-to-32-bit Decoder (dec)
	u:	for i in 0 to 31 generate 
			tmp(i) <= '1' when to_integer(unsigned(input)) = i else '0';
			output(i) <= tmp(i) after 10ns;
		end generate;
	
end behavior;
