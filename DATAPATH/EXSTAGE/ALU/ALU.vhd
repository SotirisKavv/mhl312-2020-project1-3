library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Overflow : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
signal tempOut : std_logic_vector(32 downto 0) := (32 downto 0 => '0');
signal tOvf: std_logic;
signal tC: std_logic;
signal tZ: std_logic;


begin
	------------------ Overflow Flag ------------------
	with Op select
		tOvf <= (not A(31) and not B(31) and tempOut(31)) or (A(31) and 	  B(31) and not tempOut(31)) when "0000", 
				  (not A(31) and B(31) 		and tempOut(31)) or (A(31) and not B(31) and not tempOut(31)) when "0001",
				  '0' when others;
	-------------------- Zero Flag --------------------
	process(tempOut)
		begin
		if (tempOut(31 downto 0) = x"00000000") then tZ <= '1'; 
		else tZ <= '0';
		end if;
	end process;
	------------------- Operations --------------------
	with Op select
	--- ARITHMETIC
		------- ADD
		tempOut <=  std_logic_vector(('0' & unsigned(A)) + ('0' & unsigned(B))) when "0000",			
		------- SUB
						std_logic_vector(('0' & unsigned(A)) - ('0' & unsigned(B))) when "0001",		
	--- LOGIC
		------- AND
						('0' & (A and B))		when "0010",
		------- OR
						('0' & (A or B))		when "0011",			
		------- NOT
						('0' & not A)			when "0100",			
		------- NAND
						('0' & (A nand B))	when "0101",
		------- NOR
						('0' & (A nor B))		when "0110",
	--- SHIFTS
		------- SHRS
						std_logic_vector('0' & shift_right(signed(A), 1))	 when "1000",
		------- SHRU
						std_logic_vector('0' & shift_right(unsigned(A), 1))	 when "1001",
		------- SHLU
						std_logic_vector('0' & shift_left(unsigned(A), 1))	 when "1010",
		------- ROL
						std_logic_vector('0' & rotate_left(signed(A), 1))	 when "1100",
		------- ROR
						std_logic_vector('0' & rotate_right(signed(A), 1))	 when "1101",
	--- OTHERS
						('0' & x"00000000")		when others;
	
	--Finalizing Outputs
	ALU_out <= tempOut(31 downto 0) after 10 ns;
	Cout <= tempOut(32) after 10 ns;
	Zero <= tZ after 10 ns;
	Overflow <= tOvf after 10 ns;
	
end Behavioral;

