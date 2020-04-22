LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY MM_tb IS
END MM_tb;
 
ARCHITECTURE behavior OF MM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MM
    PORT(
         Clk : IN  std_logic;
         ByteOp : IN  std_logic;
         MEM_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal MEM_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 200 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MM PORT MAP (
          Clk => Clk,
          ByteOp => ByteOp,
          MEM_WrEn => MEM_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		
		ByteOp <= '1';
		MEM_WrEn <= '1';
		ALU_MEM_Addr <= "00000000000000000000000000000100";
		MEM_DataIn <= "00000000000000000000000000000100";
		wait for 200 ns;
		
		ByteOp <= '0';
		MEM_WrEn <= '1';
		ALU_MEM_Addr <= "00000000000000000000000000000100";
		MEM_DataIn <= "00000000000000000000000000001000";
		wait for 200 ns;
		
		ByteOp <= '1';
		MEM_WrEn <= '1';
		ALU_MEM_Addr <= "00000000000000000000000000010000";
		MEM_DataIn <= "00000000000000000000000000010000";
		wait for 200 ns;
		
		ByteOp <= '0';
		MEM_WrEn <= '0';
		ALU_MEM_Addr <= "00000000000000000000000000100000";
		MEM_DataIn <= "00000000000000000000000000100000";
		wait for 200 ns;
		
		wait;
   end process;
		
END;
