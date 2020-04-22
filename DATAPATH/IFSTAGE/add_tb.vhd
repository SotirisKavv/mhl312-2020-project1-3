library ieee;
use ieee.std_logic_1164.all;

entity add_tb is
end add_tb;
 
architecture behavior of add_tb is
 
   -- Component Declaration for the Unit Under Test (UUT)
   component add
   port (
         input1, input2 : in std_logic_vector(31 downto 0);
         output : out std_logic_vector(31 downto 0)
   );
   end component; 

   --Inputs
   signal input1, input2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);

begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut: 	add port map (
				input1 => input1,
				input2 => input2,
				output => output
			);

   -- Stimulus process
   stim_proc: process
   begin		
      
		input1 <= "00000000000000000000000000000000";
		input2 <= "00000000000000000000000000000000";
		wait for 250 ns;
		
		input1 <= "00000000000000000000000000000001";
		input2 <= "00000000000000000000000000000001";
		wait for 250 ns;
		
		input1 <= "11111111111111111111111111111111";
		input2 <= "00000000000000000000000000000001";
		wait for 250 ns;
		
		input1 <= "11111111111111111111111111111111";
		input2 <= "11111111111111111111111111111111";
		wait for 250 ns;
		
      wait;
   end process;

end;
