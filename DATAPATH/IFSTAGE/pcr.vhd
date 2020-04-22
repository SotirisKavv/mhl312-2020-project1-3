library ieee;
use ieee.std_logic_1164.all;

-- Port Declaration for 32-bit PC Register (pcr)
entity pcr is
	port (	
			input : in std_logic_vector(31 downto 0);
			clk, rst, en : in std_logic;
			output : out std_logic_vector(31 downto 0)
	);
end pcr;

architecture behavior of pcr is

-- Behavioral Process for 32-bit PC Register (pcr)
begin
	
	process(clk, rst)
	begin
		if rising_edge(clk) and rst = '1' then
			output <= (others => '0');
		elsif rising_edge(clk) and rst = '0' then
			if en = '1' then 
				output <= input;
			end if;
		end if;
	end process;
	
end behavior;
