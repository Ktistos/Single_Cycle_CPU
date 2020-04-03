----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2020 11:21:13 PM
-- Design Name: 
-- Module Name: EXSTAGE - Behavioral
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

entity EXSTAGE is
 Port (
       RF_A : in std_logic_vector(31 downto 0);
       RF_B : in std_logic_vector(31 downto 0);
       Immed : in std_logic_vector(31 downto 0);
       ALU_Bin_sel : in std_logic;
       ALU_func : in std_logic_vector(3 downto 0);
       ALU_out : out std_logic_vector(31 downto 0);
       ALU_zero : out std_logic
       
  );
end EXSTAGE;

architecture Behavioral of EXSTAGE is

component ALU is
Port ( 
 A: in std_logic_vector(31 downto 0);
 B: in std_logic_vector(31 downto 0);
 Op: in std_logic_vector(3 downto 0);
 Output: out std_logic_vector(31 downto 0);
 Zero: out std_logic;
 Cout: out std_logic;
 Ovf: out std_logic);
end component;

component MUX2To1 is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           sel: in std_logic;
           mux_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;


signal t_mux : STD_LOGIC_VECTOR (31 downto 0);


begin

ALUModule: ALU
port map(
        A=>RF_A,
        B=>t_mux,
        Op=>ALU_func,
        Output=>ALU_out,
        Zero=>ALU_zero,
        Cout=>open,
        Ovf=>open
);

MUX32: MUX2To1
port map(
        A=>RF_B,
        B=>Immed,
        sel=>ALU_Bin_sel,
        mux_out=>t_mux
);

end Behavioral;
