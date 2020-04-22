library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Port Declaration for (PC + PC_Immed) Adder (add)
entity add is
	port (	
			input1, input2 : in std_logic_vector(31 downto 0);
			output : out std_logic_vector(31 downto 0)
	);
end add;

architecture behavior of add is

-- Behavioral Process for (PC + PC_Immed) Adder (add)
begin
	
	output <= input1 + input2;
	
end behavior;
