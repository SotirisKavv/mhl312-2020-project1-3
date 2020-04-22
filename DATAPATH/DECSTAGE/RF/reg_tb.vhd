library ieee;
use ieee.std_logic_1164.all;

entity reg_tb is
end reg_tb;
 
architecture behavior of reg_tb is 
 
	-- Component Declaration for the Unit Under Test (UUT)
   component reg
   port(
			datain : in std_logic_vector(31 downto 0);
			clk, rst, we : in std_logic;
			dataout : out std_logic_vector(31 downto 0)
	);
   end component;
	
   --Inputs
   signal datain : std_logic_vector(31 downto 0) := (others => '0');
   signal clk, rst, we : std_logic := '0';

 	--Outputs
   signal dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut:	reg port map (
				datain => datain,
				clk => clk,
				rst => rst,
				we => we,
				dataout => dataout
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
		
		datain <= "00000000000000000000000001100100";
		we <= '0';
		rst <= '0';
		wait for 100 ns;
		
		datain <= "00000000000000000000000001100100";
		we <= '1';
		rst <= '0';
		wait for 100 ns;
		
		datain <= "00000000000000000000000001100100";
		we <= '0';
		rst <= '1';
		wait for 100 ns;
		
		datain <= "00000000000000000000000001100100";
		we <= '1';
		rst <= '0';
		wait for 100 ns;
		
		datain <= "00000000000000000000000011001000";
		we <= '1';
		rst <= '0';
		wait for 100 ns;
		
		datain <= "00000000000000000000000001100100";
		we <= '1';
		rst <= '1';
		wait for 100 ns;
		
      wait;
		
   end process;

end;
