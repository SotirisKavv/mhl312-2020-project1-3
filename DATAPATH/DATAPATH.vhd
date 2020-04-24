library ieee;
use ieee.std_logic_1164.all;

-- Port Declaration for Data Path (DATAPATH)
entity DATAPATH is
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
			-- Inputs to RAM (to DEC)
			RAM_Instr : in std_logic_vector(31 downto 0);
			-- Inputs to RAM (to MEM)
			RAM_MM_RdData : in std_logic_vector(31 downto 0);
			-- Outputs from RAM (from IF)
			RAM_PC : out std_logic_vector(31 downto 0);
			-- Outputs from RAM (from MEM)
			RAM_MM_WrEn : out std_logic;
			RAM_MM_Addr : out std_logic_vector(10 downto 0);
			RAM_MM_WrData : out std_logic_vector(31 downto 0);
			-- Inputs to PROC_SC
			CLK : in std_logic;
			RST : in std_logic;
			-- Outputs from PROC_SC
			DP_ALU_ovf : out std_logic;
			DP_ALU_cout : out std_logic
	);
end DATAPATH;

architecture behavior of DATAPATH is

-- Component Declarations for Data Path (DATAPATH)

	-- Port Declaration for IF Component (IFSTAGE)
	component IFSTAGE is
		port (
				PC_Immed : in std_logic_vector(31 downto 0);
				PC_Sel : in std_logic;
				PC_LdEn, Clk, Reset : in std_logic;
				PC : out std_logic_vector(31 downto 0)
		);
	end component;
	
	-- Port Declaration for DEC Component (DECSTAGE)
	component DECSTAGE is
		port (
				Instr, ALU_out, MEM_out : in std_logic_vector(31 downto 0);
				RF_WrEn, RF_WrData_sel, RF_B_sel : in std_logic;
				ImmExt : in std_logic_vector(1 downto 0);
				Clk, Rst: in std_logic;
				Immed, RF_A, RF_B : out std_logic_vector(31 downto 0)
		);
	end component;
	
	-- Port Declaration for EX Component (EXSTAGE)
	component EXSTAGE is
		port (
				Immed, RF_A, RF_B : in std_logic_vector(31 downto 0);
				ALU_Bin_sel : in std_logic;
				ALU_func : in std_logic_vector(3 downto 0);
				ALU_out : out std_logic_vector(31 downto 0);
				ALU_zero, ALU_ovf, ALU_cout : out std_logic
		);
	end component;
	
	-- Port Declaration for MEM Component (MEMSTAGE)
	component MEMSTAGE is
		port (
				ByteOp : in std_logic;
				MEM_WrEn : in std_logic;
				ALU_MEM_Addr : in std_logic_vector(31 downto 0);
				MEM_DataIn : in std_logic_vector(31 downto 0);
				MEM_DataOut : out std_logic_vector(31 downto 0);
				MM_WrEn : out std_logic;
				MM_Addr : out std_logic_vector(10 downto 0);
				MM_WrData : out std_logic_vector(31 downto 0);
				MM_RdData : in std_logic_vector(31 downto 0)
		);
	end component;
	
	-- Temporary Signal Declaration to assist in Behavioral Process of Data Path (DATAPATH)
		signal tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7 : std_logic_vector(31 downto 0);
		signal tmp : std_logic_vector(1 downto 0);

-- Behavioral Process for Data Path (DATAPATH)
begin

	-- Internal (DATAPATH) Structure for IF Component (IFSTAGE)
	u0:	IFSTAGE port map (	
				Clk => CLK,
				Reset => RST,
				PC_Immed => tmp0,
				PC_Sel => CTRL_PC_Sel,
				PC_LdEn => CTRL_PC_LdEn,
				PC => RAM_PC
			);
	
	CTRL_Instr <= RAM_Instr;
	
	-- Internal (DATAPATH) Structure for DEC Component (DECSTAGE)
	u1:	DECSTAGE port map (	
				Clk => CLK,
				Rst => RST,
				Instr => RAM_Instr, 
				RF_WrEn => CTRL_RF_WrEn,
				ALU_out => tmp1,
				MEM_out => tmp2,
				RF_WrData_sel => CTRL_RF_WrData_Sel,
				RF_B_sel => CTRL_RF_B_Sel,
				ImmExt => CTRL_ImmExt,
				Immed => tmp0,
				RF_A => tmp3,
				RF_B => tmp4
			);
			
	-- Internal (DATAPATH) Structure for EX Component (EXSTAGE)
	u2:	EXSTAGE port map (	
				Immed => tmp0,
				RF_A => tmp3,
				RF_B => tmp4,
				ALU_Bin_sel => CTRL_ALU_Bin_Sel,
				ALU_func => CTRL_ALU_Func,
				ALU_out => tmp1,
				ALU_zero => CTRL_ALU_zero,
				ALU_ovf => DP_ALU_ovf,
				ALU_cout => DP_ALU_cout
			);
	
	-- Internal (DATAPATH) Structure for MEM Component (MEMSTAGE)
	u3:	MEMSTAGE port map (	
				ByteOp => CTRL_ByteOp,
				MEM_WrEn => CTRL_MEM_WrEn,
				ALU_MEM_Addr => tmp1,
				MEM_DataIn => tmp4,
				MEM_DataOut => tmp2,
				MM_WrEn => RAM_MM_WrEn,
				MM_Addr => RAM_MM_Addr,
				MM_WrData => RAM_MM_WrData,
				MM_RdData => RAM_MM_RdData
			);
	
end behavior;
