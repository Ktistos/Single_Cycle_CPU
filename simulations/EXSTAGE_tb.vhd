
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity EXSTAGE_tb is
--  Port ( );
end EXSTAGE_tb;

architecture Behavioral of EXSTAGE_tb is

component EXSTAGE is
 Port (
       RF_A : in std_logic_vector(31 downto 0);
       RF_B : in std_logic_vector(31 downto 0);
       Immed : in std_logic_vector(31 downto 0);
       ALU_Bin_sel : in std_logic;
       ALU_func : in std_logic_vector(3 downto 0);
       ALU_out : out std_logic_vector(31 downto 0);
       ALU_zero : out std_logic
       
  );
end component;

signal RF_A :  std_logic_vector(31 downto 0):=(others=>'0');
signal RF_B :  std_logic_vector(31 downto 0):=(others=>'0');
signal Immed :  std_logic_vector(31 downto 0):=(others=>'0');
signal ALU_Bin_sel :  std_logic:='0';
signal ALU_func :  std_logic_vector(3 downto 0):=(others=>'0');


signal ALU_out :  std_logic_vector(31 downto 0):=(others=>'0');
signal ALU_zero :  std_logic:='0';


begin

uut: EXSTAGE
port map(
        RF_A=>RF_A,
        RF_B=>RF_B,
        Immed=>Immed,
        ALU_Bin_sel=>ALU_Bin_sel,
        ALU_func=>ALU_func,
        ALU_out=>ALU_out,
        ALU_zero=>ALU_zero
       
);

stim_proc: process
   begin

   --Since the ALU has been already tested seperatly we only need to check whether the connection between the multiplexer and the alu is valid 
   wait for 100ns;
   --addition between RF_A and RF_B
   ALU_func<="0000";
   ALU_Bin_sel<='0';
   Immed<=x"000000a0";
   RF_A<=x"0000000a";
   RF_B<=x"00000005";
   --Addition between RF_A and Immed
   wait for 100ns;
   ALU_Bin_sel<='1';
   
   
   wait;
   end process;



end Behavioral;
