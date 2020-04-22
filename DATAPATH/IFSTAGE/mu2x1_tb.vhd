library ieee;
use ieee.std_logic_1164.all;

library work;
use work.custom_package.all;

entity mu2x1_tb is
end mu2x1_tb;
 
architecture behavior of mu2x1_tb is
 
   -- Component Declaration for the Unit Under Test (UUT)
   component mu2x1
   port (
         input : in custom_type2;
         sel : in std_logic_vector(0 downto 0);
         output : out std_logic_vector(31 downto 0)
   );
   end component;

   --Inputs
   signal input : custom_type2 := (others => (others => '0'));
   signal sel : std_logic_vector(0 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut:	mu2x1 port map (
				input => input,
				sel => sel,
				output => output
			);
 
   -- Stimulus process
   stim_proc: process
   begin		
      
		input(0) <= "00000000000000000000000001100100";
		input(1) <= "00000000000000000000000011001000";
		sel <= "0";
		wait for 500 ns;
		
		input(0) <= "00000000000000000000000001100100";
		input(1) <= "00000000000000000000000011001000";
		sel <= "1";
		wait for 500 ns;

      wait;
   end process;

end;
