library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Rst : in STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is
	
	signal reg2 : std_logic_vector(4 downto 0);
	signal wrReg : std_logic_vector(31 downto 0);
	
	component RF is
		port (
			Ard1, Ard2, Awr : in std_logic_vector (4 downto 0);
			Din : in std_logic_vector (31 downto 0);
			Clk, Rst, WrEn : in std_logic;
			Dout1, Dout2 : out std_logic_vector (31 downto 0)
		);
	end component;
	
	component MUX52x1 is
		Port ( 
			InA : in  STD_LOGIC_VECTOR (4 downto 0);
			InB : in  STD_LOGIC_VECTOR (4 downto 0);
			SEL : in  STD_LOGIC;
         Output : out  STD_LOGIC_VECTOR (4 downto 0)
		);
	end component;
	
	component MUX322x1 is
		Port ( 
			InA : in  STD_LOGIC_VECTOR (31 downto 0);
			InB : in  STD_LOGIC_VECTOR (31 downto 0);
			SEL : in  STD_LOGIC;
         Output : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component Extender is
		Port ( 
			InstrImmed : in  STD_LOGIC_VECTOR (15 downto 0);
         ImmedExt : in  STD_LOGIC_VECTOR (1 downto 0);
         Immed : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
begin

	mux5: MUX52x1
		port map (
			InA => Instr(20 downto 16),
			InB => Instr(15 downto 11),
			SEL => RF_B_sel,
			Output => reg2
		);
		
	mux32: MUX322x1
		port map (
			InA => ALU_out,
			InB => MEM_out,
			SEL => RF_WrData_sel,
			Output => wrReg
		);

	regFile: RF 
		port map(
			Ard1 => Instr(25 downto 21),
			Ard2 => reg2,
			Awr => Instr(20 downto 16),
			Din => wrReg,
			Clk => Clk,
			Rst => Rst,
			WrEn => RF_WrEn,
			Dout1 => RF_A,
			Dout2 => RF_B
		);
		
	immExtend: Extender
		port map(
			InstrImmed => Instr(15 downto 0),
			ImmedExt => ImmExt,
			Immed => Immed
		);
end Behavioral;

