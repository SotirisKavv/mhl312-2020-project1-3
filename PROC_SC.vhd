library ieee;
use ieee.std_logic_1164.all;

-- Port Declaration for Top Level Module (PROC_SC)
entity PROC_SC is
	port (
			CLK : in std_logic;
			RST : in std_logic;
			DP_ALU_ovf : out std_logic;
			DP_ALU_cout : out std_logic;
			Instr : out std_logic_vector(31 downto 0)
	);
end PROC_SC;

architecture behavior of PROC_SC is

-- Component Declarations for Top Level Module (PROC_SC)

	-- Port Declaration for Data Path Component (DATAPATH)
	component DATAPATH is
		port (
				-- Inputs from CONTROL
				CTRL_PC_Sel : in std_logic;
				CTRL_PC_LdEn : in std_logic;
				CTRL_RF_WrEn : in std_logic;
				CTRL_RF_WrData_Sel : in std_logic;
				CTRL_RF_B_Sel : in std_logic;
				CTRL_ImmExt : in std_logic_vector(1 downto 0);
				CTRL_ALU_Bin_Sel : in std_logic;
				CTRL_ALU_Func : in std_logic_vector(3 downto 0);
				CTRL_ByteOp : in std_logic;
				CTRL_MEM_WrEn : in std_logic;
				-- Outputs to CONTROL
				CTRL_ALU_zero : out std_logic;
				CTRL_Instr : out std_logic_vector(31 downto 0);
				-- Inputs from RAM (to DEC)
				RAM_Instr : in std_logic_vector(31 downto 0);
				-- Inputs from RAM (to MEM)
				RAM_MM_RdData : in std_logic_vector(31 downto 0);
				-- Outputs to RAM (from IF)
				RAM_PC : out std_logic_vector(31 downto 0);
				-- Outputs to RAM (from MEM)
				RAM_MM_WrEn : out std_logic;
				RAM_MM_Addr :out std_logic_vector(10 downto 0);
				RAM_MM_WrData : out std_logic_vector(31 downto 0);
				-- Inputs from PROC_SC
				CLK : in std_logic;
				RST : in std_logic;
				-- Outputs to PROC_SC
				DP_ALU_ovf : out std_logic;
				DP_ALU_cout : out std_logic
		);
	end component;
	
	-- Port Declaration for RAM Instance Component (RAM)
	component RAM is
		port (
				clk : in std_logic;
				-- (IF)
				inst_addr : in std_logic_vector(10 downto 0); 
				inst_dout : out std_logic_vector(31 downto 0); 
				-- (MEM)
				data_we : in std_logic;
				data_addr : in std_logic_vector(10 downto 0); 
				data_din : in std_logic_vector(31 downto 0); 
				data_dout : out std_logic_vector(31 downto 0)
		);
	end component;
	
	-- Port Declaration for Control Component (CONTROL)
	component Control is
		Port ( 
				-- Inputs from DATAPATH
				Instr : STD_LOGIC_VECTOR (31 downto 0);
				Zero : in STD_LOGIC;
				-- Input from PROC_SC
				Rst : in  STD_LOGIC;
				-- Signals to DEC
				RegDst : out  STD_LOGIC;
				RegWr : out  STD_LOGIC;
				MemtoReg : out  STD_LOGIC;
				ExtOp : out  STD_LOGIC_VECTOR (1 downto 0);
				-- Signal to IF
				nPC_sel : out  STD_LOGIC;
				LoadEn : out STD_LOGIC;
				-- Signals to EX
				ALUctr : out  STD_LOGIC_VECTOR (3 downto 0);
				ALUsrc : out  STD_LOGIC;
				-- Signal to MEM
				MemWr : out  STD_LOGIC;
				ByteOp : out STD_LOGIC
		); 
	end component;

	
	-- Temporary Signal Declaration to assist in Behavioral Process of Top Level Module (PROC_SC)
		signal tmp0, tmp1, tmp2, tmp3, tmp4, tmp6, tmp8, tmp9, tmp14, tmp17 : std_logic;
		signal tmp5 : std_logic_vector(1 downto 0);
		signal tmp7 : std_logic_vector(3 downto 0);
		signal tmp15: std_logic_vector(10 downto 0);
		signal tmp10, tmp11, tmp12, tmp13, tmp16 : std_logic_vector(31 downto 0);
		
begin
	
	-- Internal (PROC_SC) Structure for Control Component (CONTROL)
	u0:	Control port map (
				Instr => tmp12,
				Zero => tmp17,
				Rst => RST,
				RegDst => tmp4,
				RegWr => tmp2,
				MemtoReg => tmp3,
				ExtOp => tmp5,
				nPC_sel => tmp0,
				LoadEn => tmp1,
				ALUctr => tmp7,
				ALUsrc => tmp6,
				MemWr => tmp9,
				ByteOp => tmp8
			);

	
	-- Internal (PROC_SC) Structure for Data Path Component (DATAPATH)
	u1:	DATAPATH port map (	
				CLK => CLK,
				RST => RST,
				CTRL_PC_Sel => tmp0,
				CTRL_PC_LdEn => tmp1,
				CTRL_RF_WrEn => tmp2,
				CTRL_RF_WrData_Sel => tmp3,
				CTRL_RF_B_Sel => tmp4,
				CTRL_ImmExt => tmp5,
				CTRL_ALU_Bin_Sel => tmp6,
				CTRL_ALU_Func => tmp7,
				CTRL_ByteOp => tmp8,
				CTRL_MEM_WrEn => tmp9,
				RAM_Instr => tmp10,
				RAM_MM_RdData => tmp11,
				CTRL_Instr => tmp12,
				CTRL_ALU_zero => tmp17,
				DP_ALU_ovf => DP_ALU_ovf,
				DP_ALU_cout => DP_ALU_cout, 
				RAM_PC => tmp13,
				RAM_MM_WrEn => tmp14,
				RAM_MM_Addr => tmp15,
				RAM_MM_WrData => tmp16
			);
	
	-- Internal (PROC_SC) Structure for RAM Instance Component (RAM)
	u2:	RAM port map (	
				clk => CLK,
				inst_addr => tmp13(12 downto 2),
				inst_dout => tmp10,
				data_we => tmp14,
				data_addr => tmp15,
				data_din => tmp16,
				data_dout => tmp11
			);
	
	Instr <= tmp12;
	
end behavior;

