LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MUX323x1_tb IS
END MUX323x1_tb;
 
ARCHITECTURE behavior OF MUX323x1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX322x1
    PORT(
         InA : IN  std_logic_vector(31 downto 0);
         InB : IN  std_logic_vector(31 downto 0);
         SEL : IN  std_logic;
         Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal InA : std_logic_vector(31 downto 0) := (others => '0');
   signal InB : std_logic_vector(31 downto 0) := (others => '0');
   signal SEL : std_logic := '0';

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX322x1 PORT MAP (
          InA => InA,
          InB => InB,
          SEL => SEL,
          Output => Output
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		

      -- insert stimulus here 

      wait;
   end process;

END;
