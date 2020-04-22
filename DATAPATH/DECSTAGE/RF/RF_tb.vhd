library ieee;
use ieee.std_logic_1164.all;

entity RF_tb is
end RF_tb;
 
architecture behavior of RF_tb is 
 
	-- Component Declaration for the Unit Under Test (UUT)
   component RF
   port (
         Ard1, Ard2, Awr : in std_logic_vector (4 downto 0);
			Din : in std_logic_vector (31 downto 0);
			Clk, Rst, WrEn : in std_logic;
			Dout1, Dout2 : out std_logic_vector (31 downto 0)
   );
   end component;
    
   --Inputs
   signal Ard1, Ard2, Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal Clk, Rst, WrEn : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut:	RF port map (
				Ard1 => Ard1,
				Ard2 => Ard2,
				Awr => Awr,
				Din => Din,
				Clk => Clk,
				Rst => Rst,
				WrEn => WrEn,
				Dout1 => Dout1,
				Dout2 => Dout2
			);

   -- Clock process definitions
   Clk_process: process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
	
		Din <= "00000000000000000000000001100100";
		Awr <= "00001";
      Ard1 <= "00001";
		Ard2 <= "00010";
		WrEn <= '1';
		Rst <= '0';
		wait for 100 ns;
		
		Din <= "00000000000000000000000100101100";
		Awr <= "00001";
		Ard1 <= "00001";
		Ard2 <= "00010";
		WrEn <= '0';
		Rst <= '1';
		wait for 100 ns;
		
		Din <= "00000000000000000000000001100100";
		Awr <= "00010";
		Ard1 <= "00001";
		Ard2 <= "00010";
		WrEn <= '1';
		Rst <= '0';
		wait for 100 ns;
		
		Din <= "00000000000000000000000011001000";
		Awr <= "00001";
		Ard1 <= "00001";
		Ard2 <= "00010";
		WrEn <= '1';		
		Rst <= '0';
		wait for 100 ns;
		
		Din <= "00000000000000000000000100101100";
		Awr <= "00011";
		Ard1 <= "00011";
		Ard2 <= "00010";
		WrEn <= '1';
		Rst <= '0';
		wait for 100 ns;
		
		Din <= "00000000000000000000000001100100";
		Awr <= "00001";
		Ard1 <= "00001";
		Ard2 <= "00010";
		WrEn <= '0';
		Rst <= '0';
		wait for 100 ns;
		
		Din <= "00000000000000000000000100101100";
		Awr <= "00000";
		Ard1 <= "00001";
		Ard2 <= "00000";
		WrEn <= '1';
		Rst <= '0';
		wait for 100 ns;
		
		Din <= "00000000000000000000000001100100";
		Awr <= "00001";
		Ard1 <= "00001";
		Ard2 <= "00010";		
		WrEn <= '1';
		Rst <= '1';
		wait for 100 ns;
		
      wait;
		
   end process;

end;
