----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2020 06:44:44 PM
-- Design Name: 
-- Module Name: Adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
