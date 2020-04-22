library ieee;
use ieee.std_logic_1164.all;

-- Custom Package to assist in Port Declaration for Multiplexer Component (mu2x1)
library work;
use work.custom_package.all;

-- Port Declaration for IF Stage (IFSTAGE)
entity IFSTAGE is
	port (
			PC_Immed : in std_logic_vector(31 downto 0);
			PC_Sel : in std_logic_vector(0 downto 0);
			PC_LdEn, Clk, Reset : in std_logic;
			PC : out std_logic_vector(31 downto 0)
	); 
end IFSTAGE;

architecture behavior of IFSTAGE is

-- Component Declarations for IF Stage (IFSTAGE)
	
	-- Port Declaration for Incrementor Component (inc)
	component inc is
		port (	
			input0, input1 : in std_logic_vector(31 downto 0);
         output0, output1 : out std_logic_vector(31 downto 0)
	);
	end component;
	
	-- Port Declaration for Multiplexer Component (mu2x1)
	component mu2x1 is
		port (
				input : in custom_type2;
				sel : in std_logic_vector(0 downto 0);
				output : out std_logic_vector(31 downto 0)
		);
	end component;

	-- Port Declaration for PC Register Component (reg)
	component reg is
		port (
				datain : in std_logic_vector(31 downto 0);
				we, clk, rst : in std_logic;
				dataout : out std_logic_vector(31 downto 0)
		);
	end component;

	-- Temporary Signal Declaration to assist in Behavioral Process of IF Stage (IFSTAGE)
	signal tmp0, tmp1, tmp2, tmp3 : std_logic_vector(31 downto 0);
	
-- Behavioral Process for IF Stage (IFSTAGE)
begin
	
	-- Internal (IFSTAGE) Structure for Incrementor (inc)
	u0:	inc port map (	
				input0 => tmp3,
				input1 => PC_Immed,
				output0 => tmp0,
				output1 => tmp1
			);
	
	-- Internal (IFSTAGE) Structure for Multiplexer (mu2x1)
	u1: 	mu2x1 port map (	
				input(0) => tmp0,
				input(1) => tmp1,
				sel => PC_Sel,
				output => tmp2
			);
			
	-- Internal (IFSTAGE) Structure for PC Register (reg)
	u2: 	reg port map (
				datain => tmp2,
				we => PC_LdEn,
				clk => Clk,
				rst => Reset,
				dataout => tmp3
			);
			
	PC <= tmp3;
			
end behavior;
