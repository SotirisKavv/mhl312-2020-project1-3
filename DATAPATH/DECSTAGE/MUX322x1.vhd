library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX322x1 is
    Port ( InA : in  STD_LOGIC_VECTOR (31 downto 0);
           InB : in  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX322x1;

architecture Behavioral of MUX322x1 is
begin
	process(SEL, InA, InB)
	begin
		if SEL='0' then
			Output <= InA;
		elsif SEL='1' then
			Output <= InB;
		end if;
	end process;
end Behavioral;

