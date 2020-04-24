library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Port Declaration for MEMSTAGE-RAM (MM)
entity MM is
	port (
			Clk : in std_logic;
			ByteOp : in std_logic;
			MEM_WrEn : in std_logic;
			ALU_MEM_Addr : in std_logic_vector(31 downto 0);
			MEM_DataIn : in std_logic_vector(31 downto 0);
			MEM_DataOut : out std_logic_vector(31 downto 0)
	);
end MM;

architecture behavior of MM is

-- Component Declarations for MEMSTAGE-RAM (MM)

	-- Port Declaration for Memory Stage Component (MEMSTAGE)
	component MEMSTAGE IS
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

	-- Port Declaration for RAM Instance Component (RAM)
	component RAM is
		port (
				-- Unused Ports
				inst_addr : in std_logic_vector(10 downto 0); 
				inst_dout : out std_logic_vector(31 downto 0); 
				-- Used Ports
				clk : in std_logic;
				data_we : in std_logic;
				data_addr : in std_logic_vector(10 downto 0); 
				data_din : in std_logic_vector(31 downto 0); 
				data_dout : out std_logic_vector(31 downto 0)
		);
	end component;
	
	-- Temporary Signal Declaration to assist in Behavioral Process of MEMSTAGE-RAM (MM)
	signal tmp0 : std_logic; 
	signal tmp1 : std_logic_vector(10 downto 0);
	signal tmp2, tmp3 : std_logic_vector(31 downto 0);

-- Behavioral Process for MEMSTAGE-RAM (MM)
begin

	-- Internal (MM) Structure for Memory Stage Component (MEMSTAGE)
	u0:	MEMSTAGE port map (
				ByteOp => ByteOp,
				MEM_WrEn => MEM_WrEn,
				ALU_MEM_Addr => ALU_MEM_Addr,
				MEM_DataIn => MEM_DataIn,
				MEM_DataOut => MEM_DataOut,
				MM_WrEn => tmp0,
				MM_Addr => tmp1,
				MM_WrData => tmp2,
				MM_RdData => tmp3
			);	
	
	-- Internal (MM) Structure for RAM Instance Component (RAM)
	u1:	RAM port map (
				inst_addr => (others => '0'),
				inst_dout => open,
				clk => Clk,
				data_we => tmp0,
				data_addr => tmp1,
				data_din => tmp2,
				data_dout => tmp3
			);	

end behavior;
