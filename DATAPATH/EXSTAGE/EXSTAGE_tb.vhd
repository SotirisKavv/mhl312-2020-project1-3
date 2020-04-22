LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY EXSTAGE_tb IS
END EXSTAGE_tb;
 
ARCHITECTURE behavior OF EXSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic;
         ALU_ovf : OUT  std_logic;
         ALU_cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   signal ALU_ovf : std_logic;
   signal ALU_cout : std_logic;
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_zero => ALU_zero,
          ALU_ovf => ALU_ovf,
          ALU_cout => ALU_cout
        );

   -- Stimulus process
   stim_proc: process
   begin		
      
		ALU_func <= "0000";
		RF_A <= x"0000ABCD";	RF_B <= x"00001234";	Immed <= x"000012CD";	ALU_Bin_sel <= '0';	wait for 100 ns;
																								ALU_Bin_sel <= '1';	wait for 100 ns;
		RF_A <= x"00000000";	RF_B <= x"00000000";	Immed <= x"FFFFFFFF";	ALU_Bin_sel <= '0';	wait for 100 ns;
																								ALU_Bin_sel <= '1';	wait for 100 ns;
		ALU_func <= "0001";
		RF_A <= x"0000ABCD";	RF_B <= x"00001234";	Immed <= x"0000CD12";	ALU_Bin_sel <= '0';	wait for 100 ns;
																								ALU_Bin_sel <= '1';	wait for 100 ns;
		RF_A <= x"00000000";	RF_B <= x"00000000";	Immed <= x"FFFFFFFF";	ALU_Bin_sel <= '0';	wait for 100 ns;
																								ALU_Bin_sel <= '1';	wait for 100 ns;
		ALU_func <= "0010";
		RF_A <= x"8462ABCD";	RF_B <= x"FDB91234";	Immed <= x"62FD12CD";	ALU_Bin_sel <= '0';	wait for 100 ns;
																								ALU_Bin_sel <= '1';	wait for 100 ns;
		RF_A <= x"00000000";	RF_B <= x"00000000";	Immed <= x"FFFFFFFF";	ALU_Bin_sel <= '0';	wait for 100 ns;
																								ALU_Bin_sel <= '1';	wait for 100 ns;
		ALU_func <= "1010";
		RF_A <= x"A000ABCD";	RF_B <= x"00001234";	Immed <= x"000012CD";	ALU_Bin_sel <= '0';	wait for 100 ns;
																								ALU_Bin_sel <= '1';	wait for 100 ns;
		RF_A <= x"80000000";	RF_B <= x"00000000";	Immed <= x"00000000";	ALU_Bin_sel <= '0';	wait for 100 ns;
																								ALU_Bin_sel <= '1';	wait for 100 ns;

      
      wait;
   end process;

END;
