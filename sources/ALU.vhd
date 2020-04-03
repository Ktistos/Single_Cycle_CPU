library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
Port ( 
 A: in std_logic_vector(31 downto 0);
 B: in std_logic_vector(31 downto 0);
 Op: in std_logic_vector(3 downto 0);
 Output: out std_logic_vector(31 downto 0);
 Zero: out std_logic;
 Cout: out std_logic;
 Ovf: out std_logic);
end ALU;

architecture Behavioral of ALU is
signal t_out:std_logic_vector(31 downto 0);
signal a32,b32,out32: signed(32 downto 0);
signal t_zero: std_logic;
 

begin
--33 bit signal in order to use the 32nd bit as the carry out(out32(32) njkkiy is used as the carry out)
a32<= signed(A(31) & A);
b32<= signed(B(31) & B);

out32<=(a32+b32) when Op="0000" else 
        a32-b32 when Op="0001";-- else 
        --'0' & x"00000000";       
--when both number have the same sign, cout=out32(32)
--when they have different signs cout=not out32(32)
Cout<=not out32(32) when (Op="0000" and ((A(31)='1' and B(31)='0') or  (A(31)='0' and B(31)='1')))
        or  (Op="0001" and ((A(31)='1' and B(31)='1') or  (A(31)='0' and B(31)='0'))) else
        out32(32) when Op="0000" or Op="0001"; --else
        --'0';
 --ovf=1 when the addition of  2 numbers with the same sign results in a number with negative sign
 --or B operand is the lower bound in subtraction        
Ovf<='1' when (Op="0000" and (a32(31)=b32(31) and a32(31)/=out32(31))) or 
      (Op="0001" and ((a32(31)/=b32(31) and a32(31)/=out32(31)))) else '0'; 
      
t_out<=std_logic_vector(out32(31 downto 0)) when Op="0000" or Op="0001" else 
        A and B when Op="0010" else
        A or B when Op="0011" else
        not A when Op="0100" else
        A nand B when Op="0101" else
        A nor B when Op="0110" else
        std_logic_vector(shift_right(signed(A),1)) when Op="1000" else
        std_logic_vector(shift_right(unsigned(A),1)) when Op="1001" else
        std_logic_vector(shift_left(unsigned(A),1)) when Op="1010" else
        std_logic_vector(rotate_left(unsigned(A),1)) when Op="1100" else
        std_logic_vector(rotate_right(unsigned(A),1)) when Op="1101";--else
        --x"00000000";
        
              
t_zero<='1' when to_integer(unsigned(t_out))=0 else '0';
Output<=t_out after 10ns;
Zero<=t_zero after 10ns;

end Behavioral;
