
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder is
  Port ( 
        A : in std_logic_vector(31 downto 0);
        B : in std_logic_vector(31 downto 0);
        Sum : out std_logic_vector(31 downto 0)
  );
end Adder;

architecture Behavioral of Adder is

signal t_sum : signed(31 downto 0);

begin

     t_sum<=signed(A)+signed(B);
     Sum<=std_logic_vector(t_sum) after 10 ns;

end Behavioral;
