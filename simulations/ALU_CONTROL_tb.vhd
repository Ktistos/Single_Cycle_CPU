--The purpose of this testbench is to check if the alu control module is working properly.
  
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ALU_CONTROL_tb is
end;

architecture bench of ALU_CONTROL_tb is

  component ALU_CONTROL
    Port ( 
          Func : in std_logic_vector(5 downto 0);
          ALUop : in std_logic_vector(2 downto 0);
          ALU_ctr: out std_logic_vector(3 downto 0)
    );
  end component;

  signal Func: std_logic_vector(5 downto 0):=(others=>'0');
  signal ALUop: std_logic_vector(2 downto 0):=(others=>'0');
  signal ALU_ctr: std_logic_vector(3 downto 0) :=(others=>'0');

begin

  uut: ALU_CONTROL port map ( Func    => Func,
                              ALUop   => ALUop,
                              ALU_ctr => ALU_ctr );

  stimulus: process
  begin
  --expecting to see that the ALU_ctr corresponds to the right func or ALUop  
    wait for 100ns;
    
    ALUop<="100";
    --testing all alu_ctr signals for all r-type instructions(all the combinations of func that are provided by the isa)
    for i in 48 to 54 loop
        Func<=std_logic_vector(to_unsigned(i,Func'length));
        wait for 100ns;
    end loop;
    for i in 56 to 60 loop
        Func<=std_logic_vector(to_unsigned(i,Func'length));
        wait for 100ns;
    end loop;
    
    --testing alu_ctr for other instructions
    
    ALUop<="000";
    wait for 100ns;
    ALUop<="101";
    wait for 100ns;
    ALUop<="011";
    wait for 100ns;
    ALUop<="100";
    wait for 100ns;
    ALUop<="001";
    wait for 100ns;
    
    ALUop<="111";
    wait for 100ns;
    ALUop<="110";
    wait for 100ns;
    
    
    
    
    wait;
  end process;


end;

