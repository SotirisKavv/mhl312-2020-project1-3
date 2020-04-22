library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC;
			  ALU_ovf : out  STD_LOGIC;
			  ALU_cout : out  STD_LOGIC);
end EXSTAGE;

architecture Behavioral of EXSTAGE is
	
	signal sig2: std_logic_vector(31 downto 0);
	
	component MUX322x1 is
		Port ( 
			InA : in  STD_LOGIC_VECTOR (31 downto 0);
         InB : in  STD_LOGIC_VECTOR (31 downto 0);
         SEL : in  STD_LOGIC;
         Output : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component ALU is
		Port ( 
			A : in  STD_LOGIC_VECTOR (31 downto 0);
			B : in  STD_LOGIC_VECTOR (31 downto 0);
			Op : in  STD_LOGIC_VECTOR (3 downto 0);
			ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			Zero : out  STD_LOGIC;
			Overflow : out  STD_LOGIC;
			Cout : out  STD_LOGIC
		);
	end component;
		
begin
	
	mux32: MUX322x1
		port map (
			InA => RF_B,
			InB => Immed,
			Sel => ALU_Bin_sel,
			Output => sig2
		);
		
	alunit: ALU
		port map (
			A => RF_A,
			B => sig2,
			Op => ALU_func,
			ALU_out => ALU_out,
			Zero => ALU_zero,
			Overflow => ALU_ovf,
			Cout => ALU_cout
		);

end Behavioral;

