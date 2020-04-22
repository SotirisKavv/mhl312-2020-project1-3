library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Custom Package to assist in Port Declaration for 32(32)-to-1(32)-bit Multiplexer (mu32x1)
library work;
use work.custom_package.all;

-- Port Declaration for 32(32)-to-1(32)-bit Multiplexer (mu32x1)
entity mu32x1 is
	port (
			input : in custom_type1;
			sel : in std_logic_vector (4 downto 0);
			output : out std_logic_vector (31 downto 0)
	);
end mu32x1;

architecture behavior of mu32x1 is

-- Behavioral Process for 32(32)-to-1(32)-bit Multiplexer (mu32x1)
begin

	output <= input(to_integer(unsigned(sel))) after 10ns;

end behavior;
