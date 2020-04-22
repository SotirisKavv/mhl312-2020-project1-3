LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY MUX52x1_tb IS
END MUX52x1_tb;
 
ARCHITECTURE behavior OF MUX52x1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX52x1
    PORT(
         InA : IN  std_logic_vector(4 downto 0);
         InB : IN  std_logic_vector(4 downto 0);
         SEL : IN  std_logic;
         Output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal InA : std_logic_vector(4 downto 0) := (others => '0');
   signal InB : std_logic_vector(4 downto 0) := (others => '0');
   signal SEL : std_logic := '0';

 	--Outputs
   signal Output : std_logic_vector(4 downto 0);
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX52x1 PORT MAP (
          InA => InA,
          InB => InB,
          SEL => SEL,
          Output => Output
        );

   -- Stimulus process
   stim_proc: process
   begin		
     
	  InA <= "10101"; InB <= "01010"; SEL <='0'; wait for 100 ns;
	  InA <= "10101"; InB <= "01010"; SEL <='1'; wait for 100 ns;

      wait;
   end process;

END;
