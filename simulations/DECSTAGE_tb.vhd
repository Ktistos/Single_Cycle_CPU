----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2020 08:27:59 PM
-- Design Name: 
-- Module Name: DECSTAGE_tb - Behavioral
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

entity DECSTAGE_tb is
--  Port ( );
end DECSTAGE_tb;

architecture Behavioral of DECSTAGE_tb is

component DECSTAGE is
  Port ( 
        Instr : in std_logic_vector(31 downto 0);
        RF_WrEn : in std_logic;
        ALU_out : in std_logic_vector(31 downto 0);
        MEM_out : in std_logic_vector(31 downto 0);
        RF_WrData_sel : in std_logic;
        RF_B_sel : in std_logic;
        RST: in std_logic;
        ImmExt : in std_logic_vector(1 downto 0);
        Clk : in std_logic;
        Immed : out std_logic_vector(31 downto 0);      
        RF_A : out std_logic_vector(31 downto 0);
        RF_B : out std_logic_vector(31 downto 0)
  
  );
end component;

signal Instr : std_logic_vector(31 downto 0):=(others=>'0');
signal RF_WrEn : std_logic:='0';
signal ALU_out :  std_logic_vector(31 downto 0):=(others=>'0');
signal MEM_out :  std_logic_vector(31 downto 0):=(others=>'0');
signal RF_WrData_sel :  std_logic:='0';
signal RF_B_sel :  std_logic:='0';
signal RST :std_logic:='0';
signal ImmExt :  std_logic_vector(1 downto 0):=(others=>'0');
signal Clk : std_logic:='0';


signal Immed :  std_logic_vector(31 downto 0):=(others=>'0');
signal RF_A :  std_logic_vector(31 downto 0):=(others=>'0');
signal RF_B :  std_logic_vector(31 downto 0):=(others=>'0');


-- Clock period definitions
   constant Clk_period : time := 100 ns;
  
begin

uut:DECSTAGE
port map(
        Instr=>Instr,
        RF_WrEn=>RF_WrEn,
        ALU_out=>ALU_out,
        MEM_out=>MEM_out,
        RF_WrData_sel=>RF_WrData_sel,
        RF_B_sel=>RF_B_sel,
        ImmExt=>ImmExt,
        Clk=>Clk,
        Immed=>Immed,
        RF_A=>RF_A,
        RF_B=>RF_B,
        RST=>RST
);

-- Clock process definitions
   Clk_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
   
   stim_proc: process
   begin
   
   wait for 100ns;
   --writing in registers 1 the contents of MEM
   Instr<=x"00010000";
   RF_WrEn<='1';
   MEM_out<=x"11111111";
   ALU_out<=x"ffffffff";
   RF_WrData_sel<='0';
   wait for Clk_period;
   --writing in register 2 the contents of ALU
   Instr<=x"00020000";
   RF_WrData_sel<='1';
   wait for Clk_period;
   --reading from registers 1 and 2 (reg2 address in bits 15-11)
   RF_WrEn<='0';
   RF_B_sel<='0';
   Instr<=x"00201000";
   --reading from registers 1 and 2 but the address of the reg2 is in bits (20 -16)
   wait for Clk_period;
   RF_B_sel<='1';
   Instr<=x"00410000";
   --trying to write in reg0 and zero padding on imm field
   wait for Clk_period;
   ImmExt<="00";
   RF_WrEn<='1';
   Instr<=x"0000ffff";
   --reading from reg0 in order to confirm that nothing was written
   --sign extending imm field
   wait for Clk_period;
   ImmExt<="01";
   


   
   wait;
   

   
   end process;


end Behavioral;
