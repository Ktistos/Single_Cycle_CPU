----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2020 07:16:01 PM
-- Design Name: 
-- Module Name: MUX2To1 - Behavioral
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

entity MUX2To1 is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           sel: in std_logic;
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
end MUX2To1;

architecture Behavioral of MUX2To1 is

signal t_mux_out : std_logic_vector(31 downto 0);

begin

t_mux_out<=A when sel='0' else
         B when sel='1' else
         x"00000000";
         
mux_out<=t_mux_out after 10ns;

end Behavioral;
