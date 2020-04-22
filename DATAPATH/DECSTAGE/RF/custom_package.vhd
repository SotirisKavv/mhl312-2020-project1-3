library ieee;
use ieee.std_logic_1164.ALL;

package custom_package is
	
	type custom_type1 is array (0 to 31) of std_logic_vector (31 downto 0);
	type custom_type2 is array (0 to 1) of std_logic_vector (31 downto 0);
	 
end custom_package;
