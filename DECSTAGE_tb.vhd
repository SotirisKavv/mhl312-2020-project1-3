LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
ENTITY DECSTAGE_tb IS
END DECSTAGE_tb;
 
ARCHITECTURE behavior OF DECSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '1';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          Clk => Clk,
          Rst => Rst,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
      Rst <= '1'; wait for 100 ns;	--Hold Rst for 100 ns to initialize
		Rst <= '0';
		------------------------------------ Testing Units -------------------------------------
		-- Initialize some Regs
		Instr <= "00000000000000010000000000000000"; ALU_out <= x"00000008"; wait for 100 ns;
		Instr <= "00000000000000110000000000000000"; ALU_out <= x"0000ABCD"; wait for 100 ns;
		Instr <= "00000000000001010000000000000000"; ALU_out <= x"ABCD0000"; wait for 100 ns;
		Instr <= "00000000000010000000000000000000"; ALU_out <= x"00ABCD00"; wait for 100 ns;
		---------------- Instruction Output
		Instr <= "10000000000000110001100000110000"; RF_B_sel <= '1'; ALU_out <= x"00000008"; wait for 100 ns; 
		Instr <= "10000000000000110000000000110000"; RF_B_sel <= '0'; wait for 100 ns;
		Instr <= "10000001000000000010100000110000"; RF_B_sel <= '1'; wait for 100 ns;
		Instr <= "10000001000001100000000000110000"; RF_B_sel <= '0'; ALU_out <= x"0000ABCD"; MEM_out <= x"ABCD0000";
		RF_WrData_sel <= '1'; wait for 100 ns;
		Instr <= "10000000000001100000000000110000"; RF_B_sel <= '0'; wait for 100 ns;
		---------------- Immed Test
		Instr <= x"00007654"; ImmExt <= "00"; wait for 100 ns;
									 ImmExt <= "01"; wait for 100 ns;
									 ImmExt <= "10"; wait for 100 ns;
									 ImmExt <= "11"; wait for 100 ns;
		Instr <= x"0000ABCD"; ImmExt <= "00"; wait for 100 ns;
									 ImmExt <= "01"; wait for 100 ns;
									 ImmExt <= "10"; wait for 100 ns;
									 ImmExt <= "11"; wait for 100 ns;
		
		
		------------------------------------- Instructions -------------------------------------
		--- addi r5, r0, 8
      Instr <= "11000000000001010000000000001000"; ImmExt <= "10";
		ALU_out <= x"00000008"; MEM_out <= x"00000000"; RF_WrData_sel <= '0'; RF_B_sel <= '0';
		wait for Clk_period;
		
		--- ori r3, r0, 0xABCD
		Instr <= "11001100000000111010101111001101"; ImmExt <= "00";
		ALU_out <= x"FFFFABCD"; MEM_out <= x"00000000"; RF_WrData_sel <= '0'; RF_B_sel <= '0';
		wait for Clk_period;
		
		--- sw r3, 4(r0)
		Instr <= "01111100000000110000000000000100"; ImmExt <= "10";
		ALU_out <= x"FFFFABCD"; MEM_out <= x"00000000"; RF_WrData_sel <= '0'; RF_B_sel <= '0';
		wait for Clk_period;
		
		--- lw r10, -4(r5)
		Instr <= "00111100101010101111111111111100"; ImmExt <= "10";
		ALU_out <= x"00000008"; MEM_out <= x"FFFFABCD"; RF_WrData_sel <= '1'; RF_B_sel <= '0';
		wait for Clk_period;
		
		--- lb r16, 4(r0)
		Instr <= "00001100000100000000000000000100"; ImmExt <= "10";
		ALU_out <= x"00000008"; MEM_out <= x"FFFFFFCD"; RF_WrData_sel <= '0'; RF_B_sel <= '0';
		wait for Clk_period;
		
		--- nand r5, r10, r16
		Instr <= "10000001010001001000000000110101"; ImmExt <= "10";
		ALU_out <= x"FFFFABCD" nand x"FFFFFFCD"; MEM_out <= x"00000000"; RF_WrData_sel <= '0'; RF_B_sel <= '1';
		wait for Clk_period;

      wait;
   end process;

END;
