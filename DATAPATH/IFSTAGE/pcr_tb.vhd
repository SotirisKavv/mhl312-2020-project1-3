library ieee;
use ieee.std_logic_1164.all;

entity pcr_tb is
end pcr_tb;
 
architecture behavior of pcr_tb is 
 
	-- Component Declaration for the Unit Under Test (UUT)
   component pcr
   port(
			input : in std_logic_vector(31 downto 0);
			clk, rst, en : in std_logic;
			output : out std_logic_vector(31 downto 0)
	);
   end component;
	
   --Inputs
   signal input : std_logic_vector(31 downto 0) := (others => '0');
   signal clk, rst, en : std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut:	pcr port map (
				input => input,
				clk => clk,
				rst => rst,
				en => en,
				output => output
			);

   -- Clock process definitions
   clk_process: process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
		
		input <= "00000000000000000000000001100100";
		en <= '0';
		rst <= '0';
		wait for 100 ns;
		
		input <= "00000000000000000000000001100100";
		en <= '1';
		rst <= '0';
		wait for 100 ns;
		
		input <= "00000000000000000000000001100100";
		en <= '0';
		rst <= '1';
		wait for 100 ns;
		
		input <= "00000000000000000000000001100100";
		en <= '1';
		rst <= '0';
		wait for 100 ns;
		
		input <= "00000000000000000000000011001000";
		en <= '1';
		rst <= '0';
		wait for 100 ns;
		
		input <= "00000000000000000000000001100100";
		en <= '1';
		rst <= '1';
		wait for 100 ns;
		
      wait;
   end process;

end;
