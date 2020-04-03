
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE is
  Port (
        PC_immed: in std_logic_vector(31 downto 0);
        PC_sel: in std_logic;
        PC_LdEn: in std_logic;
        Reset: in std_logic;
        Clk: in std_logic;
        
--IMPORTANT

        PC_out: out std_logic_vector(31 downto 0));
        
        
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component Register32bit is
    Port ( Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0);
           Clk : in STD_LOGIC;
           WE : in STD_LOGIC;
           RST : in std_logic);
end component;

 
 component MUX2To1 is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           sel: in std_logic;
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
 end component;


component Adder is
  Port ( 
        A : in std_logic_vector(31 downto 0);
        B : in std_logic_vector(31 downto 0);
        Sum : out std_logic_vector(31 downto 0)
  );
end component;

signal t_pc_out : std_logic_vector(31 downto 0);
signal t_mux_out: std_logic_vector(31 downto 0);
signal t_adder : std_logic_vector(31 downto 0);
signal t_adder_imm : std_logic_vector(31 downto 0);


begin

--Adder to increment PC by 4
adderBy4: Adder
port map(
       A=>t_pc_out,
       B=>x"00000004",
       Sum=>t_adder

);
--Adder to increment pc by 4 + signExt(immed) for branches
adderImm: Adder
port map(
        A=>t_adder,
        B=>PC_Immed,
        Sum=>t_adder_imm
);

mux:MUX2To1
port map(
        A=>t_adder,
        B=>t_adder_imm,
        mux_out=>t_mux_out,
        sel=>PC_sel
);

--Programm counter, points to the address of the instruction that is going to be fetched
ProgramCounter: Register32bit
port map (
         Datain=>t_mux_out,
         RST=>Reset,
         WE=>PC_LdEn,
         Clk=>Clk,
         Dataout=>t_pc_out
    
);

PC_out<=t_pc_out;


end Behavioral;
