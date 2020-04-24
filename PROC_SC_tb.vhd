LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PROC_SC_tb IS
END PROC_SC_tb;
 
ARCHITECTURE behavior OF PROC_SC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROC_SC
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         DP_ALU_ovf : OUT  std_logic;
         DP_ALU_cout : OUT  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal DP_ALU_ovf : std_logic;
   signal DP_ALU_cout : std_logic;
   signal Instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROC_SC PORT MAP (
          CLK => CLK,
          RST => RST,
          DP_ALU_ovf => DP_ALU_ovf,
          DP_ALU_cout => DP_ALU_cout,
          Instr => Instr
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		RST <= '1';	wait for 100 ns;
		RST <= '0';	wait;
		
		
   end process;

END;
