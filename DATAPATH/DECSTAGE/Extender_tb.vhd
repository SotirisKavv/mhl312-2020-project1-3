LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Extender_tb IS
END Extender_tb;
 
ARCHITECTURE behavior OF Extender_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Extender
    PORT(
         InstrImmed : IN  std_logic_vector(15 downto 0);
         ImmedExt : IN  std_logic_vector(1 downto 0);
         Immed : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal InstrImmed : std_logic_vector(15 downto 0) := (others => '0');
   signal ImmedExt : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
    
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Extender PORT MAP (
          InstrImmed => InstrImmed,
          ImmedExt => ImmedExt,
          Immed => Immed
        );

   -- Stimulus process
   stim_proc: process
   begin		
      
		InstrImmed <= x"AAAA"; ImmedExt <= "00"; wait for 100 ns;
		InstrImmed <= x"AAAA"; ImmedExt <= "01"; wait for 100 ns;
		InstrImmed <= x"AAAA"; ImmedExt <= "10"; wait for 100 ns;
		InstrImmed <= x"AAAA"; ImmedExt <= "11"; wait for 100 ns;
		
		InstrImmed <= x"7F84"; ImmedExt <= "00"; wait for 100 ns;
		InstrImmed <= x"7F84"; ImmedExt <= "01"; wait for 100 ns;
		InstrImmed <= x"7F84"; ImmedExt <= "10"; wait for 100 ns;
		InstrImmed <= x"7F84"; ImmedExt <= "11"; wait for 100 ns;
		
		InstrImmed <= x"64B3"; ImmedExt <= "00"; wait for 100 ns;
		InstrImmed <= x"64B3"; ImmedExt <= "01"; wait for 100 ns;
		InstrImmed <= x"64B3"; ImmedExt <= "10"; wait for 100 ns;
		InstrImmed <= x"64B3"; ImmedExt <= "11"; wait for 100 ns;
		
      wait;
   end process;

END;
