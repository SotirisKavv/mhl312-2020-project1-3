library ieee;
use ieee.std_logic_1164.all;

library work;
use work.custom_package.all;

entity mu32x1_tb is
end mu32x1_tb;
 
architecture behavior of mu32x1_tb is

	-- Component Declaration for the Unit Under Test (UUT)
   component mu32x1
   port(
        input : in custom_type1;
        sel : in std_logic_vector(4 downto 0);
        output : out std_logic_vector(31 downto 0)
	);
   end component;
    
   --Inputs
   signal input : custom_type1 := (others => (others => '0'));
   signal sel : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);

begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut: 	mu32x1 port map (
				input => input,
				sel => sel,
				output => output
			);
		  
   -- Stimulus process
   stim_proc: process
   begin		
		
		input <= (others => (others => '0'));
		input(0) <= "00000000000000000000000000000001";
		sel <= "00000";
		wait for 250 ns;
		
		input(1) <= "00000000000000000000000000000010";
		sel <= "00001";
		wait for 250 ns;
		
		input(10) <= "00000000000000000000000000000101";
		sel <= "01010";
		wait for 250 ns;
		
		input(31) <= "00000000000000000000000000001010";
		sel <= "11111";
		wait for 250 ns;
		
	   wait; 
   end process;

end;
