library ieee;
use ieee.std_logic_1164.all;

-- Custom Package to assist in Port Declaration for Multiplexer Component (mu32x1)
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

	-- Port Declaration for Decoder Component (dec5x32)
	component dec5x32 is
		port (
				input : in  std_logic_vector (4 downto 0);
				output : out std_logic_vector (31 downto 0)
		);
	end component;
	
	-- Port Declaration for Register Component (reg)
	component reg is
		port (
				datain : in std_logic_vector (31 downto 0);
				clk, rst, we : in std_logic;
				dataout : out std_logic_vector (31 downto 0)
		);
	end component;

	-- Port Declaration for Multiplexer Component (mu32x1)
	component mu32x1 is
		port (
				input : in custom_type1;
				sel : in std_logic_vector (4 downto 0);
				output : out std_logic_vector (31 downto 0)
		);
	end component;

	-- Temporary Signal Declaration to assist in Behavioral Process of Register File (RF)
	signal tmp0, tmp1, tmp2 : std_logic_vector(31 downto 0);
	signal tmp3 : custom_type1;

-- Behavioral Process for Register File (RF)
begin
	
	-- Internal (RF) Structure for Decoder (dec5x32)
	u0: 	dec5x32 port map (
				input => Awr,
				output => tmp0
			);
	
	-- Internal (RF) Structure for AND Gates
	u1:	for i in 0 to 31 generate
				tmp1(i) <= WrEn and tmp0(i);
			end generate;
			tmp2 <= tmp1 after 2ns;
	
	-- Internal (RF) Structure for Register 0 (reg)
	u2: 	reg port map (
				datain => (others => '0'),
				clk => Clk,
				rst => Rst,
				we => '0',
				dataout => tmp3(0)
			);
	
	-- Internal (RF) Structure for Registers 1 to 31 (reg)
	u3: 	for i in 1 to 31 generate
				u4: 	reg port map (
							datain => Din,
							clk => Clk,
							rst => Rst,
							we => tmp2(i),
							dataout => tmp3(i)
						);
			end generate;
	
	-- Internal (RF) Structure for Multiplexer 0 (mu32x1)
	u5:	mu32x1 port map (	
				input => tmp3,
				sel => Ard1,
				output => Dout1
			);
	
	-- Internal (RF) Structure for Multiplexer 1 (mu32x1)
	u6: 	mu32x1 port map (	
				input => tmp3,
				sel => Ard2,
				output => Dout2
			);

end behavior;
