----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2020 07:02:10 PM
-- Design Name: 
-- Module Name: MUX32to5 - Behavioral
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


entity MUX32to5 is
    Port ( 
           Dout0 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout1 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout3 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout4 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout5 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout6 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout7 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout8 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout9 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout10 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout11 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout12 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout13 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout14 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout15 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout16 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout17 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout18 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout19 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout20 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout21 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout22 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout23 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout24 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout25 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout26 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout27 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout28 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout29 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout30 : in STD_LOGIC_VECTOR (31 downto 0);
           Dout31 : in STD_LOGIC_VECTOR (31 downto 0);
           Ard    : in STD_LOGIC_VECTOR (4 downto 0);
           Data_Output : out STD_LOGIC_VECTOR (31 downto 0));
           
end MUX32to5;

architecture Behavioral of MUX32to5 is
signal DataOUT: STD_LOGIC_VECTOR (31 downto 0);
begin

DataOUT<=Dout0 when Ard="00000" else
         Dout1 when Ard="00001" else
         Dout2 when Ard="00010" else
         Dout3 when Ard="00011" else
         Dout4 when Ard="00100" else
         Dout5 when Ard="00101" else
   
         Dout6 when Ard="00110" else
         Dout7 when Ard="00111" else
         Dout8 when Ard="01000" else
         Dout9 when Ard="01001" else
         Dout10 when Ard="01010" else
         Dout11 when Ard="01011" else
         Dout12 when Ard="01100" else
         Dout13 when Ard="01101" else
         
         Dout14 when Ard="01110" else
         Dout15 when Ard="01111" else
         Dout16 when Ard="10000" else
         Dout17 when Ard="10001" else
         Dout18 when Ard="10010" else
         Dout19 when Ard="10011" else
         Dout20 when Ard="10100" else
         Dout21 when Ard="10101" else
         Dout22 when Ard="10110" else
         Dout23 when Ard="10111" else
         
         Dout24 when Ard="11000" else
         Dout25 when Ard="11001" else
         Dout26 when Ard="11010" else
         Dout27 when Ard="11011" else
         Dout28 when Ard="11100" else
         Dout29 when Ard="11101" else
         Dout30 when Ard="11110" else
         Dout31 when Ard="11111" else
         x"00000000";
         

Data_Output<=DataOUT after 10ns;


end Behavioral;
