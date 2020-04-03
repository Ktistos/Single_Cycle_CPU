----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2020 08:24:44 PM
-- Design Name: 
-- Module Name: Decoder5to32 - Behavioral
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

entity Decoder5to32 is
    Port ( Awr : in STD_LOGIC_VECTOR (4 downto 0);
            Decoder_Output: out STD_LOGIC_VECTOR (31 downto 0));
end Decoder5to32;



architecture Behavioral of Decoder5to32 is

signal decoderOUT: STD_LOGIC_VECTOR (31 downto 0);

begin

decoderOUT(0)<=(not Awr(4)) and (not Awr(3)) and (not Awr(2)) and (not Awr(1)) and (not Awr(0));
decoderOUT(1)<=(not Awr(4)) and (not Awr(3)) and (not Awr(2)) and (not Awr(1)) and ( Awr(0));
decoderOUT(2)<=(not Awr(4)) and (not Awr(3)) and (not Awr(2)) and ( Awr(1)) and (not Awr(0));
decoderOUT(3)<=(not Awr(4)) and (not Awr(3)) and (not Awr(2)) and ( Awr(1)) and ( Awr(0));
decoderOUT(4)<=(not Awr(4)) and (not Awr(3)) and ( Awr(2)) and (not Awr(1)) and (not Awr(0));
decoderOUT(5)<=(not Awr(4)) and (not Awr(3)) and ( Awr(2)) and (not Awr(1)) and ( Awr(0));

decoderOUT(6)<=(not Awr(4)) and (not Awr(3)) and ( Awr(2)) and ( Awr(1)) and (not Awr(0));
decoderOUT(7)<=(not Awr(4)) and (not Awr(3)) and ( Awr(2)) and ( Awr(1)) and ( Awr(0));
decoderOUT(8)<=(not Awr(4)) and ( Awr(3)) and (not Awr(2)) and (not Awr(1)) and (not Awr(0));
decoderOUT(9)<=(not Awr(4)) and ( Awr(3)) and (not Awr(2)) and (not Awr(1)) and ( Awr(0));
decoderOUT(10)<=(not Awr(4)) and ( Awr(3)) and (not Awr(2)) and ( Awr(1)) and (not Awr(0));

decoderOUT(11)<=(not Awr(4)) and ( Awr(3)) and (not Awr(2)) and ( Awr(1)) and ( Awr(0));
decoderOUT(12)<=(not Awr(4)) and ( Awr(3)) and ( Awr(2)) and (not Awr(1)) and (not Awr(0));
decoderOUT(13)<=(not Awr(4)) and ( Awr(3)) and ( Awr(2)) and (not Awr(1)) and ( Awr(0));
decoderOUT(14)<=(not Awr(4)) and ( Awr(3)) and ( Awr(2)) and ( Awr(1)) and (not Awr(0));
decoderOUT(15)<=(not Awr(4)) and ( Awr(3)) and ( Awr(2)) and ( Awr(1)) and ( Awr(0));

decoderOUT(16)<=( Awr(4)) and (not Awr(3)) and (not Awr(2)) and (not Awr(1)) and (not Awr(0));
decoderOUT(17)<=( Awr(4)) and (not Awr(3)) and (not Awr(2)) and (not Awr(1)) and ( Awr(0));
decoderOUT(18)<=( Awr(4)) and (not Awr(3)) and (not Awr(2)) and ( Awr(1)) and (not Awr(0));
decoderOUT(19)<=( Awr(4)) and (not Awr(3)) and (not Awr(2)) and ( Awr(1)) and ( Awr(0));
decoderOUT(20)<=( Awr(4)) and (not Awr(3)) and ( Awr(2)) and (not Awr(1)) and (not Awr(0));

decoderOUT(21)<=( Awr(4)) and (not Awr(3)) and ( Awr(2)) and (not Awr(1)) and ( Awr(0));
decoderOUT(22)<=(Awr(4)) and (not Awr(3)) and ( Awr(2)) and ( Awr(1)) and (not Awr(0));
decoderOUT(23)<=( Awr(4)) and (not Awr(3)) and ( Awr(2)) and ( Awr(1)) and ( Awr(0));
decoderOUT(24)<=( Awr(4)) and ( Awr(3)) and (not Awr(2)) and (not Awr(1)) and (not Awr(0));
decoderOUT(25)<=( Awr(4)) and (Awr(3)) and (not Awr(2)) and (not Awr(1)) and ( Awr(0));

decoderOUT(26)<=( Awr(4)) and ( Awr(3)) and (not Awr(2)) and ( Awr(1)) and (not Awr(0));
decoderOUT(27)<=( Awr(4)) and ( Awr(3)) and (not Awr(2)) and ( Awr(1)) and (Awr(0));
decoderOUT(28)<=( Awr(4)) and ( Awr(3)) and ( Awr(2)) and (not Awr(1)) and (not Awr(0));
decoderOUT(29)<=( Awr(4)) and ( Awr(3)) and ( Awr(2)) and (not Awr(1)) and ( Awr(0));
decoderOUT(30)<=( Awr(4)) and ( Awr(3)) and ( Awr(2)) and ( Awr(1)) and (not Awr(0));

decoderOUT(31)<=( Awr(4)) and ( Awr(3)) and ( Awr(2)) and ( Awr(1)) and ( Awr(0));

Decoder_Output<=decoderOUT after 10ns;

end Behavioral;
