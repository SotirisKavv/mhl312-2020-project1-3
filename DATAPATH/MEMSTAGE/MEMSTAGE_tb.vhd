library ieee;
use ieee.std_logic_1164.all;
 
entity MEMSTAGE_tb is
end MEMSTAGE_tb;
 
architecture behavior of MEMSTAGE_tb is 
 
	-- Component Declaration for the Unit Under Test (UUT)
	component MEMSTAGE
	port (
			ByteOp : in std_logic;
			MEM_WrEn : in std_logic;
			ALU_MEM_Addr : in std_logic_vector(31 downto 0);
			MEM_DataIn : in std_logic_vector(31 downto 0);
			MEM_DataOut : out std_logic_vector(31 downto 0);
			MM_WrEn : out std_logic;
			MM_Addr : out std_logic_vector(31 downto 0);
			MM_WrData : out std_logic_vector(31 downto 0);
			MM_RdData : in std_logic_vector(31 downto 0)
	);
	end component;

   --Inputs
   signal ByteOp : std_logic := '0';
   signal MEM_WrEn : std_logic := '0';
	signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
	signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrData : std_logic_vector(31 downto 0);
	
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut:	MEMSTAGE port map (
				ByteOp => ByteOp,
				MEM_WrEn => MEM_WrEn,
				ALU_MEM_Addr => ALU_MEM_Addr,
				MEM_DataIn => MEM_DataIn,
				MEM_DataOut => MEM_DataOut,
				MM_WrEn => MM_WrEn,
				MM_Addr => MM_Addr,
				MM_WrData => MM_WrData,
				MM_RdData => MM_RdData
			);

   -- Stimulus process
   stim_proc: process
   begin		
      
		ByteOp <= '0';
		MEM_WrEn <= '0';
		ALU_MEM_Addr <= (others => '0');
		MEM_DataIn <= (others => '0');
		MM_RdData <= (others => '0');
		wait for 200 ns;
		
		ByteOp <= '0';
		MEM_WrEn <= '0';
		ALU_MEM_Addr <= (others => '1');
		MEM_DataIn <= (others => '0');
		MM_RdData <= (others => '0');
		wait for 200 ns;
		
		ByteOp <= '1';
		MEM_WrEn <= '0';
		ALU_MEM_Addr <= (others => '0');
		MEM_DataIn <= (others => '0');
		MM_RdData <= (others => '0');
		wait for 200 ns;
	
		ByteOp <= '0';
		MEM_WrEn <= '0';
		ALU_MEM_Addr <= (others => '0');
		MEM_DataIn <= (others => '1');
		MM_RdData <= (others => '1');
		wait for 200 ns;
		
		ByteOp <= '1';
		MEM_WrEn <= '0';
		ALU_MEM_Addr <= (others => '0');
		MEM_DataIn <= (others => '1');
		MM_RdData <= (others => '1');
		wait for 200 ns;
		
      wait;
   end process;

end;
