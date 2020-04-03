----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2020 07:41:08 PM
-- Design Name: 
-- Module Name: DECSTAGE - Behavioral
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

entity DECSTAGE is
  Port ( 
        Instr : in std_logic_vector(31 downto 0);
        RF_WrEn : in std_logic;
        ALU_out : in std_logic_vector(31 downto 0);
        MEM_out : in std_logic_vector(31 downto 0);
        RF_WrData_sel : in std_logic;
        RF_B_sel : in std_logic;
        ImmExt : in std_logic_vector(1 downto 0);
        Clk : in std_logic;
        Immed : out std_logic_vector(31 downto 0);
        RST: in std_logic;
        RF_A : out std_logic_vector(31 downto 0);
        RF_B : out std_logic_vector(31 downto 0)
  
  );
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component ImmExtender is
 Port (
        ImmIn : in std_logic_vector(15 downto 0);
        ExtOp : in std_logic_vector(1 downto 0);
        ImmOut : out std_logic_vector(31 downto 0)
  );
  
end component;

component RegisterFIle is
    Port ( Ard1 : in STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in STD_LOGIC_VECTOR (4 downto 0);
           Awr : in STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out STD_LOGIC_VECTOR (31 downto 0);
           Din : in STD_LOGIC_VECTOR (31 downto 0);
           RST: in std_logic;
           WrEn : in STD_LOGIC;
           Clk : in STD_LOGIC);
end component;

component MUX2To1_5 is
 Port ( 
       A : in std_logic_vector(4 downto 0);
       B : in std_logic_vector(4 downto 0);
       MUX_out : out std_logic_vector(4 downto 0);
       Sel : in std_logic
 );
end component;


component MUX2To1 is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           sel: in std_logic;
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal t_WrData : STD_LOGIC_VECTOR (31 downto 0);
signal t_readRegister2 : STD_LOGIC_VECTOR (4 downto 0);

begin

mux32: MUX2To1
port map(
        A=>ALU_out,
        B=>MEM_out,
        sel=>RF_WrData_sel,
        mux_out=>t_wrData
);

mux5: MUX2To1_5
port map(
        A=>Instr(15 downto 11),
        B=>Instr(20 downto 16),
        Sel=>RF_B_sel,
        MUX_out=>t_readRegister2
);

ImmediateExtender: ImmExtender
port map(
        ImmIn=>Instr(15 downto 0),
        ExtOp=>ImmExt,
        ImmOut=>Immed
);

RF:RegisterFile
port map(
        Ard1=>Instr(25 downto 21),
        Ard2=>t_readRegister2,
        Awr=>Instr(20 downto 16),
        Dout1=>RF_A,
        Dout2=>RF_B,
        Din=>t_WrData,
        WrEn=>RF_WrEn,
        Clk=>Clk,
        RST=>RST
             
);

end Behavioral;
