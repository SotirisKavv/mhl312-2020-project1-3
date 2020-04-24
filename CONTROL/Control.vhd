library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
    Port ( Instr : STD_LOGIC_VECTOR (31 downto 0);
			  Rst : in  STD_LOGIC;
			  Zero : in STD_LOGIC;
           RegDst : out  STD_LOGIC;
           RegWr : out  STD_LOGIC;
           nPC_sel : out  STD_LOGIC;
			  LoadEn : out STD_LOGIC;
           ALUctr : out  STD_LOGIC_VECTOR (3 downto 0);
           ExtOp : out  STD_LOGIC_VECTOR (1 downto 0);
           ALUsrc : out  STD_LOGIC;
           MemWr : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
			  ByteOp : out STD_LOGIC
			  );
           
end Control;

architecture Behavioral of Control is

signal Opcode : std_logic_vector(5 downto 0);
signal func : std_logic_vector(3 downto 0);

begin

Opcode <= Instr(31 downto 26);
func <= Instr(3 downto 0);

process (Rst, Instr, Opcode, func, Zero)
begin	
	if Rst = '1' then
		RegDst <= '0';	RegWr <= '0';	nPC_sel <= '0';	ALUctr <= "0000";
		ExtOp <= "00";	ALUsrc <= '0';	MemWr <= '0';	MemtoReg <= '0';	ByteOp <= '0';
	else
		if Instr = x"00000000" then
			LoadEn <= '0';
		else
			case Opcode is
				when "100000" =>
					RegDst <= '1';	RegWr <= '1';	nPC_sel <= '0';	ALUctr <= func;
					ALUsrc <= '0';	MemWr <= '0';	MemtoReg <= '0';	ExtOp <= "00";
				when "111000" =>
					RegDst <= '0';	RegWr <= '1';	nPC_sel <= '0';	ExtOp <= "10";
				when "111001" =>
					RegDst <= '0';	RegWr <= '1';	nPC_sel <= '0';	ExtOp <= "01";
				when "110000" =>
					RegDst <= '0';	RegWr <= '1';	nPC_sel <= '0';	ALUctr <= "0000";
					ExtOp <= "10";	ALUsrc <= '1';	MemWr <= '0';	MemtoReg <= '0';
				when "110010" =>
					RegDst <= '0';	RegWr <= '1';	nPC_sel <= '0';	ALUctr <= "0101";
					ExtOp <= "00";	ALUsrc <= '1';	MemWr <= '0';	MemtoReg <= '0';
				when "110011" =>
					RegDst <= '0';	RegWr <= '1';	nPC_sel <= '0';	ALUctr <= "0011";
					ExtOp <= "00";	ALUsrc <= '1';	MemWr <= '0';	MemtoReg <= '0';
				when "111111" =>
					nPC_sel <= '1';	ExtOp <= "11";
				when "000000" =>
					RegWr <= '0';	nPC_sel <= Zero;	ALUctr <= "0001";	ALUsrc <= '0'; 
					ExtOp <= "11";	MemWr <= '0';
				when "000001" =>
					RegWr <= '0';	nPC_sel <= not Zero;	ALUctr <= "0001";	ALUsrc <= '0'; 
					ExtOp <= "11";	MemWr <= '0';
				when "000011" =>
					RegDst <= '0';	RegWr <= '1';	nPC_sel <= '0';	ALUctr <= "0000";
					ExtOp <= "10";	ALUsrc <= '1';	MemWr <= '0';	MemtoReg <= '1';	ByteOp <= '1';
				when "000111" =>
					RegWr <= '0';	nPC_sel <= '0';	ALUctr <= "0000";
					ExtOp <= "10";	ALUsrc <= '1';	MemWr <= '1';	ByteOp <= '1';
				when "001111" =>
					RegDst <= '0';	RegWr <= '1';	nPC_sel <= '0';	ALUctr <= "0000";
					ExtOp <= "10";	ALUsrc <= '1';	MemWr <= '0';	MemtoReg <= '1';	ByteOp <= '0';
				when "011111" =>
					RegWr <= '0';	nPC_sel <= '0';	ALUctr <= "0000";
					ExtOp <= "10";	ALUsrc <= '1';	MemWr <= '1';	ByteOp <= '0';
				when others =>
					RegDst <= '0';	RegWr <= '0';	nPC_sel <= '0';	ALUctr <= "0000";
					ExtOp <= "00";	ALUsrc <= '0';	MemWr <= '0';	MemtoReg <= '0';
			end case;
			
			LoadEn <= '1';
		end if;
	end if;
end process;

end Behavioral;

