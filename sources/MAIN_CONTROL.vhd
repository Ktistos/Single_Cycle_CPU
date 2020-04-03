----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2020 05:12:13 PM
-- Design Name: 
-- Module Name: MAIN_CONTROL - Behavioral
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

entity MAIN_CONTROL is
  Port (
        ALU_zero : in std_logic;
        OpCode:  in std_logic_vector(5 downto 0);
        ALUop : out std_logic_vector(2 downto 0);
        
        
        --IFSTAGE INterface
        PC_Sel : out std_logic;
        
        
         --DECSTAGE Intefrace
        RF_WrData_sel : out std_logic;
        RF_WrEn : out std_logic;
        RF_B_sel : out std_logic;
        ImmExt : out std_logic_vector(1 downto 0);
        
        --EXSTAGE Interface
        ALU_Bin_sel : out std_logic;
        
        
        --MEMSTAGE interface
        ByteOp : out std_logic;
        Mem_WrEn : out std_logic
            
   );
end MAIN_CONTROL;

architecture Behavioral of MAIN_CONTROL is

begin


PC_Sel<= '1' when ((ALU_zero='1' and OpCode="111111") or (ALU_zero='1' and OpCode="000000") or (ALU_zero='0' and OpCode="000001")) else
        '0';
        
RF_WrEn<='1' when ( OpCode="100000" or  OpCode="111000" or  OpCode="111001" or  OpCode="110000" or  OpCode="110010" or  OpCode="110011" or  OpCode="000011" or  OpCode="001111") else
        '0';
        
RF_B_sel<='0' when (OpCode="100000" or OpCode="111000" or OpCode="111001" or OpCode="110000" or OpCode="110010" or OpCode="110011") else
          '1';
           
ImmExt<="00" when (OpCode="100000" or OpCode="110010" or OpCode="110011") else
        "01" when (OpCode="111000" or OpCode="110000" or OpCode="000011" or OpCode="000111" or OpCode="001111" or OpCode="011111") else
        "10" when (OpCode="111111" or OpCode="000000" or OpCode="000001") else
        "11";

ALU_Bin_sel<='0' when (OpCode="100000" or OpCode="111111" or OpCode="000000" or OpCode="000001") else
            '1';
            
Mem_WrEn<='1' when (OpCode="000111" or OpCode="011111" ) else
           '0';
           
ByteOp<= '1' when (OpCode="000011" or OpCode="000111") else
        '0';
        
RF_WrData_sel<='1' when (OpCode="000011" or OpCode="001111") else
               '0';
        
ALUop<="100" when OpCode="100000" else
       "000" when (OpCode="110000" or OpCode="000011" or OpCode="000111" or OpCode="001111" or OpCode="011111") else
       "001" when (OpCode="000000" or OpCode="111111" or OpCode="000001") else
       "011" when (OpCode="111000" or OpCode="111001" or OpCode="110011") else
       "101" when (OpCode="110010") else
       "000"; 
       
       
       
end Behavioral;
