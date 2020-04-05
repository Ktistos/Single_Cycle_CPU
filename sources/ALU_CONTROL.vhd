


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_CONTROL is
  Port ( 
        Func : in std_logic_vector(5 downto 0);
        ALUop : in std_logic_vector(2 downto 0);
        ALU_ctr: out std_logic_vector(3 downto 0)
        
  );
end ALU_CONTROL;

architecture Behavioral of ALU_CONTROL is

signal t_ALU_ctr: std_logic_vector(3 downto 0);

begin
t_ALU_ctr<=Func(3 downto 0) when ALUop="100" else
           '0' & ALUop;       
           
ALU_ctr<=t_ALU_ctr after 10ns;       

end Behavioral;
