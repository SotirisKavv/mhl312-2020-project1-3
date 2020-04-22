library ieee;
use ieee.std_logic_1164.all;

-- Port Declaration for PC Register (reg)
entity reg is
	port (	
			datain : in std_logic_vector (31 downto 0);
			clk, rst, we : in std_logic;
			dataout : out std_logic_vector (31 downto 0)
	);
end reg;

architecture behavior of reg is

-- Behavioral Process for PC Register (reg)
begin
	
	process(clk, rst)
	begin
		if rising_edge(clk) and rst = '1' then
			dataout <= (others => '0') after 10ns;
		elsif rising_edge(clk) and rst = '0' then
			if we = '1' then 
				dataout <= datain after 10ns;
			end if;
		end if;
	end process;
	
end behavior;
