library ieee;
use ieee.std_logic_1164.all;

-- Port Declaration for IFSTAGE-MEM (IFM)
entity IFM is
	port (
			PC_Immed : in std_logic_vector(31 downto 0);
			PC_Sel : in std_logic_vector(0 downto 0);
			PC_LdEn, Clk, Reset : in std_logic;
			Instr : out std_logic_vector(31 downto 0)
	);
	end IFM;

architecture behavior of IFM is

-- Component Declarations for IFSTAGE-MEM (IFM)

	-- Port Declaration for IF Stage Component (IFSTAGE)
	component IFSTAGE IS
		port (  
				PC_Immed : in std_logic_vector(31 downto 0);
				PC_Sel : in std_logic_vector(0 downto 0);
				PC_LdEn, Clk, Reset : in std_logic;
				PC : out std_logic_vector(31 downto 0)
		);
	end component;

	-- Port Declaration for RAM Instance Component (RAM)
	component RAM is
		port (
				-- Used Ports
				clk : in std_logic;
				inst_addr : in std_logic_vector(10 downto 0); 
				inst_dout : out std_logic_vector(31 downto 0); 
				-- Unused Ports
				data_we : in std_logic;
				data_addr : in std_logic_vector(10 downto 0); 
				data_din : in std_logic_vector(31 downto 0); 
				data_dout : out std_logic_vector(31 downto 0)
		);
	end component;
	
	-- Temporary Signal Declaration to assist in Behavioral Process of IFSTAGE-MEM (IFM)
	signal tmp: std_logic_vector(31 downto 0);

-- Behavioral Process for IFSTAGE-MEM (IFM)
begin
	
	-- Internal (IFM) Structure for IF Stage Component (IFSTAGE)
	u0:	IFSTAGE port map (
				PC_Immed => PC_Immed,
				PC_sel => PC_sel,
				PC_LdEn => PC_LdEn,
				Clk => Clk,
				Reset => Reset,
				PC => tmp
			);

	-- Internal (IFM) Structure for RAM Instance Component (RAM)
	u1: 	RAM port map (	
				clk => Clk,
				inst_addr => tmp(12 downto 2),
				inst_dout => Instr,
				data_we => '0',
				data_addr => (others => '0'),
				data_din => (others => '0'),
				data_dout => open
			);
	
end behavior;
