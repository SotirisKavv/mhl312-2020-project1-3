library ieee;
use ieee.std_logic_1164.all;

entity IFSTAGE_tb is
end IFSTAGE_tb;
 
architecture behavior of IFSTAGE_tb is
 
    -- Component Declaration for the Unit Under Test (UUT)
	component IFSTAGE
   port (
         PC_Immed : in std_logic_vector(31 downto 0);
			PC_Sel : in std_logic_vector(0 downto 0);
			PC_LdEn, Clk, Reset : in std_logic;
			PC : out std_logic_vector(31 downto 0)
	);
   end component;

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic_vector(0 downto 0) := (others => '0');
   signal PC_LdEn, Clk, Reset : std_logic := '0';

 	--Outputs
   signal PC : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut:	IFSTAGE port map (
				PC_Immed => PC_Immed,
				PC_sel => PC_sel,
				PC_LdEn => PC_LdEn,
				Clk => Clk,
				Reset => Reset,
				PC => PC
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

		Reset <= '1';
		wait for 100 ns;
		
		PC_Immed <= "00000000000000000000000000000000";
		PC_sel <= "1";
		PC_LdEn <= '1';
		Reset <= '0';
		wait for 200 ns;
		
		PC_Immed <= "00000000000000000000000000001010";
		PC_sel <= "1";
		wait for 200 ns;
		
		PC_sel <= "0";
		wait for 200 ns;
		
		PC_LdEn <= '0';
		wait for 100 ns;
		
		PC_LdEn <= '1';
		wait for 100 ns;
		
		Reset <= '1';
		wait for 100 ns;
		
      wait;
   end process;

end;
