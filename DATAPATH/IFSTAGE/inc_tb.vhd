library ieee;
use ieee.std_logic_1164.all;

entity inc_tb is
end inc_tb;
 
architecture behavior of inc_tb is
 
   -- Component Declaration for the Unit Under Test (UUT)
   component inc
   port (
         input : in std_logic_vector(31 downto 0);
         output : out std_logic_vector(31 downto 0)
   );
   end component; 

   --Inputs
   signal input : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);

begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut: 	inc port map (
				input => input,
				output => output
			);

   -- Stimulus process
   stim_proc: process
   begin		
      
		input <= "00000000000000000000000000000000";
		wait for 300 ns;
		
		input <= "00000000000000000000000001100100";
		wait for 300 ns;
		
		input <= "11111111111111111111111111111111";
		wait for 300 ns;
		
      wait;
   end process;

end;
