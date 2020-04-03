

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFIle is
    Port ( Ard1 : in STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in STD_LOGIC_VECTOR (4 downto 0);
           Awr : in STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out STD_LOGIC_VECTOR (31 downto 0);
           Din : in STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in STD_LOGIC;
           RST : in std_logic;
           Clk : in STD_LOGIC);
end RegisterFIle;

architecture Behavioral of RegisterFIle is

component MUX32to5 is
    Port ( Dout0 : in STD_LOGIC_VECTOR (31 downto 0);
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
           
end component;
---------------------------------------------------------------------

component Decoder5to32 is
    Port ( Awr : in STD_LOGIC_VECTOR (4 downto 0);
            Decoder_Output: out STD_LOGIC_VECTOR (31 downto 0));
end component;

-----------------------------------------------------------------------

component Register32bit is
    Port ( Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0);
           Clk : in STD_LOGIC;
           RST : in std_logic;
           WE : in STD_LOGIC);
end component;


---------------------------------------------------------------
--This is a custon made vector of 32bit vectors, to be used to port map each register output in the for generate format
--to these temp_array signals, in order to port map then into the muxes
type myArray is array(natural range <>) of std_logic_vector(31 downto 0);
signal temp_decOUT: STD_LOGIC_VECTOR (31 downto 0);
signal temp_wren: std_logic_vector( 31 downto 0);
signal temp_out_and:std_logic_vector( 31 downto 0);
signal temp_Array: myArray(31 downto 0);

begin

--in order to recieve the and operation of wren and every output of the decoder we create a vector with writes enables
temp_wren<=WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn &
            WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn & WrEn;
            
--the end operation between the above vector and the output of the decoder          
temp_out_and<=temp_wren and temp_decOUT after 2 ns;


--instatiating decoder
Dec:Decoder5to32
port map(
          Awr=>Awr,
          Decoder_Output=>temp_DecOUT
);

--register generation using for-generate 
--Dataout of each register, is ported maped into the temp array
register_generation: for i in 1 to 31 generate
        reg:Register32bit
       
        port map(
                 Clk=>Clk,
                 WE=>temp_out_and(i),
                 Datain=>Din,
                 Dataout=>temp_Array(i),
                 RST=>RST
        
        );
        end generate register_generation;

--Special case of reg0
--needs to hardwired to 0
--cannot be overwritten
Reg0:Register32bit
port map(
        Clk=>Clk,
        WE=>'1',
        Datain=>x"00000000",
        Dataout=>temp_Array(0),
        RST=>RST
        
);

--instantiating mux1
MUX1:MUX32to5
    port map(
                Dout0=>temp_Array(0),
                Dout1=>temp_Array(1),
                Dout2=>temp_Array(2),
                Dout3=>temp_Array(3),
                Dout4=>temp_Array(4),
                Dout5=>temp_Array(5),
                Dout6=>temp_Array(6),
                Dout7=>temp_Array(7),
                Dout8=>temp_Array(8),
                Dout9=>temp_Array(9),
                Dout10=>temp_Array(10),
                Dout11=>temp_Array(11),
                Dout12=>temp_Array(12),
                Dout13=>temp_Array(13),
                Dout14=>temp_Array(14),
                Dout15=>temp_Array(15),
                Dout16=>temp_Array(16),
                Dout17=>temp_Array(17),
                Dout18=>temp_Array(18),
                Dout19=>temp_Array(19),
                Dout20=>temp_Array(20),
                Dout21=>temp_Array(21),
                Dout22=>temp_Array(22),
                Dout23=>temp_Array(23),
                Dout24=>temp_Array(24),
                Dout25=>temp_Array(25),
                Dout26=>temp_Array(26),
                Dout27=>temp_Array(27),
                Dout28=>temp_Array(28),
                Dout29=>temp_Array(29),
                Dout30=>temp_Array(30),
                Dout31=>temp_Array(31),
                Ard=>Ard1,
                Data_Output=>Dout1
               
    
   );
   --instantiating mux2
   MUX2:MUX32to5
    port map(
                Dout0=>temp_Array(0),
                Dout1=>temp_Array(1),
                Dout2=>temp_Array(2),
                Dout3=>temp_Array(3),
                Dout4=>temp_Array(4),
                Dout5=>temp_Array(5),
                Dout6=>temp_Array(6),
                Dout7=>temp_Array(7),
                Dout8=>temp_Array(8),
                Dout9=>temp_Array(9),
                Dout10=>temp_Array(10),
                Dout11=>temp_Array(11),
                Dout12=>temp_Array(12),
                Dout13=>temp_Array(13),
                Dout14=>temp_Array(14),
                Dout15=>temp_Array(15),
                Dout16=>temp_Array(16),
                Dout17=>temp_Array(17),
                Dout18=>temp_Array(18),
                Dout19=>temp_Array(19),
                Dout20=>temp_Array(20),
                Dout21=>temp_Array(21),
                Dout22=>temp_Array(22),
                Dout23=>temp_Array(23),
                Dout24=>temp_Array(24),
                Dout25=>temp_Array(25),
                Dout26=>temp_Array(26),
                Dout27=>temp_Array(27),
                Dout28=>temp_Array(28),
                Dout29=>temp_Array(29),
                Dout30=>temp_Array(30),
                Dout31=>temp_Array(31),
                Ard=>Ard2,
                Data_Output=>Dout2
               
    
   );

end Behavioral;
