library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Custom Package to assist in Port Declaration for Multiplexer Component (mux)
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
	
	-- Port Declaration for Addder Component (mux)	
	component add is
		port (	
			input1, input2 : in std_logic_vector(31 downto 0);
			output : out std_logic_vector(31 downto 0)
	);
	end component;
	
	-- Port Declaration for Multiplexer Component (mux)
	component mux is
		port (
				input : in custom_type2;
				sel : in std_logic_vector(0 downto 0);
				output : out std_logic_vector(31 downto 0)
		);
	end component;

	-- Port Declaration for PC Register Component (pcr)
	component pcr is
		port (
				input : in std_logic_vector(31 downto 0);
				en, clk, rst : in std_logic;
				output : out std_logic_vector(31 downto 0)
		);
	end component;
	
	-- Port Declaration for Incrementor Component (inc)
	component inc is
		port (	
			input : in std_logic_vector(31 downto 0);
			output : out std_logic_vector(31 downto 0)
	);
	end component;

	-- Temporary Signal Declaration to assist in Behavioral Process of IF Stage (IFSTAGE)
	signal tmp0, tmp1, tmp2, tmp3 : std_logic_vector(31 downto 0);
	
-- Behavioral Process for IF Stage (IFSTAGE)
begin
	
	-- Internal (IFSTAGE) Structure for Adder (add)
	u0:	add port map (	
				input1 => tmp0,
				input2 => PC_Immed,
				output => tmp1
			);
	
	-- Internal (IFSTAGE) Structure for Multiplexer (mux)
	u1: 	mux port map (	
				input(0) => tmp0,
				input(1) => tmp1,
				sel => PC_Sel,
				output => tmp2
			);
			
	-- Internal (IFSTAGE) Structure for PC Register (pcr)
	u2: 	pcr port map (
				input => tmp2,
				en => PC_LdEn,
				clk => Clk,
				rst => Reset,
				output => tmp3
			);
			
	PC <= tmp3;
	
	-- Internal (IFSTAGE) Structure for Incrementor (inc)
	u3:	inc port map (	
				input => tmp3,
				output => tmp0
			);
			
end behavior;
