----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2020 05:12:33 PM
-- Design Name: 
-- Module Name: ImmExtender - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ImmExtender is
 Port (
        ImmIn : in std_logic_vector(15 downto 0);
        ExtOp : in std_logic_vector(1 downto 0);
        ImmOut : out std_logic_vector(31 downto 0)
  );
  
end ImmExtender;

architecture Behavioral of ImmExtender is

signal t_immOut : std_logic_vector(31 downto 0 );
signal signExt : std_logic_vector(31 downto 0);

begin

signExt<= ImmIn(15)& ImmIn(15)& ImmIn(15)& ImmIn(15)& ImmIn(15)& ImmIn(15)& ImmIn(15)& ImmIn(15)& ImmIn(15)& ImmIn(15)& ImmIn(15)&
          ImmIn(15)&ImmIn(15)&ImmIn(15)&ImmIn(15)&ImmIn(15)& ImmIn;
          
---00 is for zero filling
---01 is for sign extension
---10 is for sign extension plus shifting left by 2
---do nothing==all zeros
t_immOut<=(x"0000" & ImmIn) when ExtOp="00" else
          signExt when ExtOp="01" else
          std_logic_vector(shift_left(unsigned(signExt),2)) when ExtOp="10" else
          std_logic_vector(shift_left(unsigned(signExt),16)) when ExtOp="11" else
          x"00000000";
          
           
           
          
ImmOut<=t_immOut after 10ns;
end Behavioral;
