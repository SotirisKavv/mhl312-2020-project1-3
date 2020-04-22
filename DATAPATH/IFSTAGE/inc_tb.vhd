library ieee;
use ieee.std_logic_1164.all;

entity inc_tb is
end inc_tb;
 
architecture behavior of inc_tb is
 
   -- Component Declaration for the Unit Under Test (UUT)
   component inc
   port (
         input0, input1 : in std_logic_vector(31 downto 0);
         output0, output1 : out std_logic_vector(31 downto 0)
   );
   end component; 

   --Inputs
   signal input0, input1 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal output0, output1 : std_logic_vector(31 downto 0);

begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut: 	inc port map (
				input0 => input0,
				input1 => input1,
				output0 => output0,
				output1 => output1
			);

   -- Stimulus process
   stim_proc: process
   begin		
      
		input0 <= "00000000000000000000000000000000";
		input1 <= "00000000000000000000000000000000";
		wait for 250 ns;
		
		input0 <= "00000000000000000000000000000000";
		input1 <= "00000000000000000000000000000010";
		wait for 250 ns;
		
		input0 <= "11111111111111111111111111111100";
		input1 <= "00000000000000000000000000000000";
		wait for 250 ns;
		
		input0 <= "11111111111111111111111111111100";
		input1 <= "11111111111111111111111111111111";
		wait for 250 ns;
		
      wait;
   end process;

end;
