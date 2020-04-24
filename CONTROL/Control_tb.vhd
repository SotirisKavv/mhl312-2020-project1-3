LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Control_tb IS
END Control_tb;
 
ARCHITECTURE behavior OF Control_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         Rst : IN  std_logic;
         Zero : IN  std_logic;
         RegDst : OUT  std_logic;
         RegWr : OUT  std_logic;
         nPC_sel : OUT  std_logic;
         ALUctr : OUT  std_logic_vector(3 downto 0);
         ExtOp : OUT  std_logic_vector(1 downto 0);
         ALUsrc : OUT  std_logic;
         MemWr : OUT  std_logic;
         MemtoReg : OUT  std_logic;
         ByteOp : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal Rst : std_logic := '0';
   signal Zero : std_logic := '0';

 	--Outputs
   signal RegDst : std_logic;
   signal RegWr : std_logic;
   signal nPC_sel : std_logic;
   signal ALUctr : std_logic_vector(3 downto 0);
   signal ExtOp : std_logic_vector(1 downto 0);
   signal ALUsrc : std_logic;
   signal MemWr : std_logic;
   signal MemtoReg : std_logic;
   signal ByteOp : std_logic;
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          Instr => Instr,
          Rst => Rst,
          Zero => Zero,
          RegDst => RegDst,
          RegWr => RegWr,
          nPC_sel => nPC_sel,
          ALUctr => ALUctr,
          ExtOp => ExtOp,
          ALUsrc => ALUsrc,
          MemWr => MemWr,
          MemtoReg => MemtoReg,
          ByteOp => ByteOp
        );

   -- Stimulus process
   stim_proc: process
   begin		
		
		Rst <= '1';
      wait for 100 ns;

		Rst <= '0'; Zero <= '0';
      Instr <= "10000000000000000000000000000000";
		wait for 100 ns;
		
		Instr <= "10000000000000000000000000000001";
		wait for 100 ns;
		
		Instr <= "10000000000000000000000000000010";
		wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
