library ieee;
use ieee.std_logic_1164.all;

entity IFM_tb is
end IFM_tb;
 
architecture behavior of IFM_tb is
 
	-- Component Declaration for the Unit Under Test (UUT)
	component IFM
	port (
			PC_Immed : in std_logic_vector(31 downto 0);
			PC_Sel : in std_logic_vector(0 downto 0);
			PC_LdEn, Clk, Reset : in std_logic;
			Instr : out std_logic_vector(31 downto 0)
	);
	end component;
   
   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_Sel : std_logic_vector(0 downto 0) := (others => '0');
   signal PC_LdEn, Clk, Reset : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut:	IFM port map (
				PC_Immed => PC_Immed,
				PC_Sel => PC_Sel,
				PC_LdEn => PC_LdEn,
				Clk => Clk,
				Reset => Reset,
				Instr => Instr
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

		PC_Immed <= "00000000000000000000000000000000";
		PC_sel <= "0";
		PC_LdEn <= '0'; 
		Reset <= '1';
		wait for 100 ns;
		
		PC_Immed <= "00000000000000000000000000000100";
		PC_sel <= "0";
		PC_LdEn <= '1';
		Reset <= '0';
		wait for 100 ns;
		
		PC_Immed <= "00000000000000000000000000000000";
		PC_sel <= "0";
		PC_LdEn <= '1';
		Reset <= '0';
		wait for 100 ns;
		
		PC_Immed <= "00000000000000000000000000010000";
		PC_sel <= "1";
		PC_LdEn <= '1';
		Reset <= '0';
		wait for 100 ns;
		
		PC_Immed <= "00000000000000000000000000000000";
		PC_sel <= "0";
		PC_LdEn <= '1';
		Reset <= '0';
		wait for 100 ns;
		
		PC_Immed <= "00000000000000000000000000000100";
		PC_sel <= "0";
		PC_LdEn <= '1';
		Reset <= '0';
		wait for 100 ns;

		PC_Immed <= "00000000000000000000000000000011";
		PC_sel <= "1";
		PC_LdEn <= '1';
		Reset <= '0';
		wait for 100 ns;
		
		PC_Immed <= "00000000000000000000000000000000";
		PC_sel <= "0";
		PC_LdEn <= '1';
		Reset <= '0';
		wait for 100 ns;
		
      wait;
   end process;

end;
