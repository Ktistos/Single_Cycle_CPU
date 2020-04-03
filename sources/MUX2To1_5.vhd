----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2020 06:56:44 PM
-- Design Name: 
-- Module Name: MUX2To1_5 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX2To1_5 is
 Port ( 
       A : in std_logic_vector(4 downto 0);
       B : in std_logic_vector(4 downto 0);
       MUX_out : out std_logic_vector(4 downto 0);
       Sel : in std_logic
 );
end MUX2To1_5;

architecture Behavioral of MUX2To1_5 is

signal t_MUX_out : std_logic_vector(4 downto 0);

begin

t_MUX_out<= A when Sel='0' else
            B when Sel='1' else
            "00000";
            
            
MUX_out<= t_MUX_out after 10ns;


end Behavioral;
