library ieee;
use ieee.std_logic_1164.all;

-- Custom Package to assist in Port Declaration for Multiplexer Component (mux)
library work;
use work.custom_package.all;

-- Port Declaration for Register File (RF)
entity RF is
	port (
			Ard1, Ard2, Awr : in std_logic_vector (4 downto 0);
			Din : in std_logic_vector (31 downto 0);
			Clk, Rst, WrEn : in std_logic;
			Dout1, Dout2 : out std_logic_vector (31 downto 0)
	);
end RF;

architecture behavior of RF is

-- Component Declarations for Register File (RF)

-- Port Declaration for Register Component (reg)
component reg is
	port (
			datain : in std_logic_vector (31 downto 0);
			clk, rst, we : in std_logic;
			dataout : out std_logic_vector (31 downto 0)
	);
end component;

-- Port Declaration for Decoder Component (dec)
component dec is
	port (
			input : in  std_logic_vector (4 downto 0);
			output : out std_logic_vector (31 downto 0)
	);
end component;

-- Port Declaration for Multiplexer Component (mux)
component mux is
	port (
			input : in custom_type1;
			sel : in std_logic_vector (4 downto 0);
			output : out std_logic_vector (31 downto 0)
	);
end component;

	-- Temporary Signal Declaration to assist in Behavioral Process of Register File (RF)
	signal tmp1, tmp2, tmp3 : std_logic_vector(31 downto 0);
	signal tmp4 : custom_type1;
	
begin
	
	-- Behavioral Process for Register File (RF)
	
	-- Internal (RF) Structure for Decoder (dec)
	u1: 	dec port map (
				input => Awr,
				output => tmp1
			);
	
	-- Internal (RF) Structure for AND Gates
	u2:	for i in 0 to 31 generate
				tmp2(i) <= WrEn and tmp1(i);
			end generate;
			tmp3 <= tmp2 after 2ns;
	
	-- Internal (RF) Structure for Register 0 (reg)
	u3: 	reg port map (
				datain => (others => '0'),
				clk => Clk,
				rst => Rst,
				we => '0',
				dataout => tmp4(0)
			);
	
	-- Internal (RF) Structure for Registers 1 to 31 (reg)
	u4: 	for i in 1 to 31 generate
				u5: 	reg port map (
							datain => Din,
							clk => Clk,
							rst => Rst,
							we => tmp3(i),
							dataout => tmp4(i)
						);
			end generate;
	
	-- Internal (RF) Structure for Multiplexer 1 (mux)
	u6: 	mux port map (	
				input => tmp4,
				sel => Ard1,
				output => Dout1
			);
	
	-- Internal (RF) Structure for Multiplexer 2 (mux)
	u7: 	mux port map (	
				input => tmp4,
				sel => Ard2,
				output => Dout2
			);

end behavior;
