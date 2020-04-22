library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Extender is
    Port ( InstrImmed : in  STD_LOGIC_VECTOR (15 downto 0);
           ImmedExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end Extender;

architecture Behavioral of Extender is

begin
	process (ImmedExt, InstrImmed)
	begin
		case ImmedExt is
			when "00" =>
				Immed <= x"0000" & InstrImmed;	--	Zero Fill
			when "01" =>
				Immed <=	std_logic_vector(shift_left(unsigned(x"0000" & InstrImmed), 16));	-- Zero Fill and left shift by 16
			when "10" =>
				Immed <=	(15 downto 0 => InstrImmed(15)) & InstrImmed;	-- Sign Extend
			when "11" =>
				Immed <=	std_logic_vector(shift_left(unsigned((15 downto 0 => InstrImmed(15)) & InstrImmed), 2)); -- Sign Extend and shift by 2
			when others =>
				Immed <= x"00000000";
		end case;
	end process;
end Behavioral;

