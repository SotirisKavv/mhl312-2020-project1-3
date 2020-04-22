library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Port Declaration for Incrementor (inc)
entity inc is
	port (	
			input0, input1 : in std_logic_vector(31 downto 0);
			output0, output1 : out std_logic_vector(31 downto 0)
	);
end inc;

architecture behavior of inc is

-- Behavioral Process for Incrementor (inc)
begin
	
	-- (PC + 4)
	output0 <= (input0 + 4);
	-- (PC + 4) + PC_Immed
	output1 <= (input0 + 4) + input1;
	
end behavior;
