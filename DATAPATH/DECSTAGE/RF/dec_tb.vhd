library ieee;
use ieee.std_logic_1164.all;
 
entity dec_tb is
end dec_tb;
 
architecture behavior of dec_tb is

	-- Component Declaration for the Unit Under Test (UUT)
	component dec
   port (
			input : in std_logic_vector(4 downto 0);
			output : out std_logic_vector(31 downto 0)
   );
   end component; 

   --Inputs
   signal input : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
  
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut:	dec port map (
				input => input,
				output => output
			);

   -- Stimulus process
   stim_proc: process
   begin		
      
		input <= "00000";
		wait for 250 ns;
		
		input <= "00001";
		wait for 250 ns;
		
		input <= "00010";
		wait for 250 ns;
		
		input <= "01010";
		wait for 250 ns;
		
		wait;
		
   end process;

end;
