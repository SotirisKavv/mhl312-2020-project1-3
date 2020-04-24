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
			LoadEn : OUT std_logic;
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
	signal LoadEn : std_logic;
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
			 LoadEn => LoadEn,
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

		Rst <= '0';
		-- R-Type Arithmetic/Logic Operations
      Instr <= "10000000000000000000000000110000";	Zero <= '0';	wait for 100 ns;
		Instr <= "10000000000000000000000000110001";						wait for 100 ns;
		Instr <= "10000000000000000000000000110010";						wait for 100 ns;
		Instr <= "10000000000000000000000000110011";						wait for 100 ns;
		Instr <= "10000000000000000000000000110100";						wait for 100 ns;
		Instr <= "10000000000000000000000000110101";						wait for 100 ns;
		Instr <= "10000000000000000000000000110110";						wait for 100 ns;
		Instr <= "10000000000000000000000000111000";						wait for 100 ns;
		Instr <= "10000000000000000000000000111001";						wait for 100 ns;
		Instr <= "10000000000000000000000000111010";						wait for 100 ns;
		Instr <= "10000000000000000000000000111100";						wait for 100 ns;
		Instr <= "10000000000000000000000000111101";						wait for 100 ns;
		-- I-Type Operations
		Instr <= "11100000000000000000000000000000";						wait for 100 ns;
		Instr <= "11100100000000000000000000000000";						wait for 100 ns;
		Instr <= "11000000000000000000000000000000";						wait for 100 ns;
		Instr <= "11001000000000000000000000000000";						wait for 100 ns;
		Instr <= "11001100000000000000000000000000";						wait for 100 ns;
		-- Branch Operations
		Instr <= "11111100000000000000000000000000";						wait for 100 ns;
		Instr <= "00000000000000000000000000000000";						wait for 100 ns;
		Instr <= "00000000000000000000000000000000";	Zero <= '1';	wait for 100 ns;
		Instr <= "00000100000000000000000000000000";	Zero <= '0';	wait for 100 ns;
		Instr <= "00000100000000000000000000000000";	Zero <= '1';	wait for 100 ns;
		-- Load/Store Operations
		Instr <= "00001100000000000000000000000000";	Zero <= '0';	wait for 100 ns;
		Instr <= "00011100000000000000000000000000";						wait for 100 ns;
		Instr <= "00111100000000000000000000000000";						wait for 100 ns;
		Instr <= "01111100000000000000000000000000";						wait for 100 ns;
		-- Finish Program
		Instr <= x"00000000";	wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
