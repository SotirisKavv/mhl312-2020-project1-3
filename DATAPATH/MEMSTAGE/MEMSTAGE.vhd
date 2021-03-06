library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Port Declaration for Memory Stage (MEMSTAGE)
entity MEMSTAGE is
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
end MEMSTAGE;

architecture behavior of MEMSTAGE is

-- Behavioral Process for Memory Stage (MEMSTAGE)
begin
	
	MM_WrEn <= MEM_WrEn;
	MM_Addr <= ALU_MEM_Addr(12 downto 2) + 1024;
	
	process(ByteOp, MEM_DataIn, MM_RdData)
	begin
		if ByteOp = '0' then
			MM_WrData <= MEM_DataIn;
			MEM_DataOut <= MM_RdData;
		elsif ByteOp = '1' then	
			case ALU_MEM_Addr(1 downto 0) is
				when "00" =>
					MM_WrData <= MM_RdData(31 downto 8) & MEM_DataIn(7 downto 0);
					MEM_DataOut <= (23 downto 0 => MM_RdData(7)) & MM_RdData(7 downto 0);
				when "01" =>
					MM_WrData <= MM_RdData(31 downto 16) & MEM_DataIn(7 downto 0) & MM_RdData(7 downto 0);
					MEM_DataOut <= (23 downto 0 => MM_RdData(7)) & MM_RdData(7 downto 0);
				when "10" =>
					MM_WrData <= MM_RdData(31 downto 24) & MEM_DataIn(7 downto 0) & MM_RdData(15 downto 0);
					MEM_DataOut <= (23 downto 0 => MM_RdData(7)) & MM_RdData(7 downto 0);
				when "11" =>
					MM_WrData <= MEM_DataIn(7 downto 0) & MM_RdData(23 downto 0);
					MEM_DataOut <= (23 downto 0 => MM_RdData(7)) & MM_RdData(7 downto 0);
				when others =>
					MM_WrData <= x"00000000";
					MEM_DataOut <= x"00000000";
			end case;
		end if;
	end process;	

end behavior;
