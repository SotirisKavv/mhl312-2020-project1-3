library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
    Port ( Instr : STD_LOGIC_VECTOR (31 downto 0);
			  Rst : in  STD_LOGIC;
			  Zero : in STD_LOGIC;
           RegDst : out  STD_LOGIC;
           RegWr : out  STD_LOGIC;
           nPC_sel : out  STD_LOGIC;
           ALUctr : out  STD_LOGIC_VECTOR (3 downto 0);
           ExtOp : out  STD_LOGIC_VECTOR (1 downto 0);
           ALUsrc : out  STD_LOGIC;
           MemWr : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
			  ByteOp : out STD_LOGIC
			  );
           
end Control;

architecture Behavioral of Control is

begin

process (Rst, Instr, Zero)
begin
	
	if Rst = '0' then
		RegDst <= '0'; RegWr <= '0'; nPC_sel <= '0'; ALUctr <= "0000";
		ExtOp <= "00"; ALUsrc <= '0'; MemWr <= '0'; MemtoReg <= '0';
	else
		case Instr(31 downto 26) is
			when "100000" =>
				RegDst <= '1'; RegWr <= '1'; nPC_sel <= '0'; ALUctr <= Instr(3 downto 0);
				ALUsrc <= '0'; MemWr <= '0'; MemtoReg <= '0';
			when others =>
				RegDst <= '0'; RegWr <= '0'; nPC_sel <= '0'; ALUctr <= "0000";
				ExtOp <= "00"; ALUsrc <= '0'; MemWr <= '0'; MemtoReg <= '0';
		end case;	
	end if;
end process;

end Behavioral;

