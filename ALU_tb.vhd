LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         ALU_Out : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Overflow : OUT  std_logic;
         Cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_Out : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Overflow : std_logic;
   signal Cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
    --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          ALU_Out => ALU_Out,
          Zero => Zero,
          Cout => Cout,
          Overflow => Overflow
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
		--<clock> <= '0';
		--wait for <clock>_period/2;
		--<clock> <= '1';
		--wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;
		-- add
		
		A <= (others=>'0'); 	B <= (others=>'0');	Op <= "0000";	wait for 100 ns;
		A <= (others=>'1');	B <= (others=>'1');	wait for 100 ns;
		A <= "00000000000000000000111110100101";	B <= "00000000000000000000100101010010";	wait for 100 ns;
		A <= "10000000000000000000111110100101";	B <= "00000000000000000000100101010010";	wait for 100 ns;
		A <= "10000000000000000000111110100101";	B <= "10000000000000000000100101010010";	wait for 100 ns;
		A <= "01000000000000000000111110100101";	B <= "01000000000000000000100101010010";	wait for 100 ns;
		
		-- sub
		A <= (others=>'0');	B <= (others=>'0');	Op <= "0001";	wait for 100 ns;	
		A <= (others=>'1');	B <= (others=>'1');	wait for 100 ns;
		A <= "00000000000000000000111110100101";	B <= "00000000000000000000100101010010";	wait for 100 ns;
		A <= "00000000000000000000111110100101";	B <= "00000000000000010000100101010010";	wait for 100 ns;
		A <= "10000000000000000000111110100101";	B <= "10000000000000000000100101010010";	wait for 100 ns;
		A <= "10000000000000000000111110100101";	B <= "01000000000000000000100101010010";	wait for 100 ns;
		A <= "01000000000000000000111110100101";	B <= "10000000000000000000100101010010";	wait for 100 ns;
		
		-- bitwise AND
		A <= (others=>'0');	B <= (others=>'0');	Op <= "0010";	wait for 100 ns;	
		A <= (others=>'1');	B <= (others=>'1');	wait for 100 ns;
		A <= x"1A3F4C55";		B <= x"2F3B467D";		wait for 100 ns;
	
		-- bitwise OR
		A <= (others=>'0');	B <= (others=>'0');	Op <= "0011";	wait for 100 ns;	
		A <= (others=>'1');	B <= (others=>'1');	wait for 100 ns;
		A <= x"1A3F4C55";		B <= x"2F3B467D";		wait for 100 ns;
      
		-- bitwise NOT
		A <= (others=>'0');	Op <= "0100";	      wait for 100 ns;	
		A <= (others=>'1');	wait for 100 ns;
		A <= x"1A3F4C55";		wait for 100 ns;
		
		-- bitwise NAND
		A <= (others=>'0');	B <= (others=>'0');	Op <= "0101";	wait for 100 ns;	
		A <= (others=>'1');	B <= (others=>'1');	wait for 100 ns;
		A <= x"1A3F4C55";		B <= x"2F3B467D";		wait for 100 ns;
		
		-- bitwise NOR
		A <= (others=>'0');	B <= (others=>'0');	Op <= "0110";	wait for 100 ns;	
		A <= (others=>'1');	B <= (others=>'1');	wait for 100 ns;
		A <= x"1A3F4C55";		B <= x"2F3B467D";		wait for 100 ns;
		
		-- SHIFT RIGHT Signed
		A <= (others=>'0');	Op <= "1000";	      wait for 100 ns;	
		A <= (others=>'1');	wait for 100 ns;
		A <= x"1A3F4C55";		wait for 100 ns;
		A <= x"AA3F4C55";		wait for 100 ns;
		
		-- SHIFT RIGHT Unsigned
		A <= (others=>'0');	Op <= "1001";	      wait for 100 ns;	
		A <= (others=>'1');	wait for 100 ns;
		A <= x"1A3F4C55";		wait for 100 ns;
		A <= x"AA3F4C55";		wait for 100 ns;
		
		-- SHIFT LEFT Unsigned
		A <= (others=>'0');	Op <= "1010";	      wait for 100 ns;	
		A <= (others=>'1');	wait for 100 ns;
		A <= x"1A3F4C55";		wait for 100 ns;
		A <= x"AA3F4C55";		wait for 100 ns;
		
		-- ROTATE LEFT
		A <= (others=>'0');	Op <= "1100";	      wait for 100 ns;	
		A <= (others=>'1');	wait for 100 ns;
		A <= x"1A3F4C55";		wait for 100 ns;
		A <= x"AA3F4C55";		wait for 100 ns;
		
		-- ROTATE RIGHT
		A <= (others=>'0');	Op <= "1101";	      wait for 100 ns;	
		A <= (others=>'1');	wait for 100 ns;
		A <= x"1A3F4C55";		wait for 100 ns;
		A <= x"AA3F4C55";		wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
