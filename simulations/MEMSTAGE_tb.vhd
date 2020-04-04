
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity MEMSTAGE_tb is
--  Port ( );
end MEMSTAGE_tb;

architecture Behavioral of MEMSTAGE_tb is

component MEMSTAGE is
 Port ( 
       ByteOp : in std_logic;
       Mem_WrEn : in std_logic;
       MM_WrEn : out std_logic;
       ALU_MEM_Addr : in std_logic_vector(31 downto 0);
       MEM_DataIn : in std_logic_vector(31 downto 0);
       MEM_DataOut : out std_logic_vector(31 downto 0);
       MM_Addr : out std_logic_vector(31 downto 0);
       MM_WrData : out std_logic_vector(31 downto 0);
       MM_RdData : in std_logic_vector(31 downto 0)
 
 );
end component;
--Data segment of RAM doesnt have any data stored, initialized at 0
component RAM is
port (
    clk : in std_logic;
    inst_addr : in std_logic_vector(10 downto 0);
    inst_dout : out std_logic_vector(31 downto 0);
    data_we : in std_logic;
    data_addr : in std_logic_vector(10 downto 0);
    data_din : in std_logic_vector(31 downto 0);
    data_dout : out std_logic_vector(31 downto 0));
 end component; 
 
 
 --temporary signals 
 signal t_MM_WrEn : std_logic:='0';
 signal t_MM_Addr : std_logic_vector(31 downto 0):=(others=>'0');
 signal t_MM_WrData : std_logic_vector(31 downto 0) :=(others=>'0');
 signal t_MM_RdData : std_logic_vector(31 downto 0) :=(others=>'0');
 signal clk: std_logic:='0';
 
 
    constant Clk_period : time := 100 ns;


 
 
 signal ByteOp: std_logic:='0';
  signal Mem_WrEn: std_logic:='0';
  signal MM_WrEn: std_logic:='0';
  signal ALU_MEM_Addr: std_logic_vector(31 downto 0) :=(others=>'0');
  signal MEM_DataIn: std_logic_vector(31 downto 0):=(others=>'0');
  signal MEM_DataOut: std_logic_vector(31 downto 0):=(others=>'0');
  signal MM_Addr: std_logic_vector(31 downto 0):=(others=>'0');
  signal MM_WrData: std_logic_vector(31 downto 0):=(others=>'0');
  signal MM_RdData: std_logic_vector(31 downto 0) :=(others=>'0');

begin

  uut: MEMSTAGE 
  port map (       
                           ByteOp       => ByteOp,
                           Mem_WrEn     => Mem_WrEn,
                           MM_WrEn      => t_MM_WrEn,
                           ALU_MEM_Addr => ALU_MEM_Addr,
                           MEM_DataIn   => MEM_DataIn,
                           MEM_DataOut  => MEM_DataOut,
                           MM_Addr      => t_MM_Addr,
                           MM_WrData    => t_MM_WrData,
                           MM_RdData    => t_MM_RdData 
                        );
                        
                        
                        
 RandomAccesMemory: RAM
 port map(
            clk=>clk,
            inst_addr=>"00000000000",
            inst_dout=>open,
            data_we=>t_MM_WrEn,
            data_addr=>t_MM_Addr(12 downto  2),
            data_din=>t_MM_WrData,
            data_dout=>t_MM_RdData
 );
 
 
 Clk_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
                     
                         
  stimulus: process
  begin
  
    wait for 100ns;
    
    ByteOp<='0';
    Mem_WrEn<='1';
    wait for clk_period;
    
    --storing 5 words in data segment of RAM and keeping track each stored word with MM_RdData
    ALU_MEM_Addr<=x"00000000";
    MEM_DataIn<=x"ffbbddaa";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000004";
    MEM_DataIn<=x"00112233";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000008";
    MEM_DataIn<=x"44556677";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"0000000c";
    MEM_DataIn<=x"8899aabb";
    wait for clk_period;
     
    ALU_MEM_Addr<=x"00000010";
    MEM_DataIn<=x"ccddeeff";
    wait for clk_period;
    
    
    Mem_WrEn<='0';
    wait for clk_period;
    --reading every byte from the word in address 0x400
    ByteOp<='1';
    ALU_MEM_Addr<=x"00000000"; 
    wait for clk_period; 
    
    ALU_MEM_Addr<=x"00000001"; 
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000002"; 
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000003"; 
    wait for clk_period;
    
    --reading 1 byte from 4 different words
    
    ALU_MEM_Addr<=x"00000007";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"0000000a";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"0000000d";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000010";
    wait for clk_period;
    
    
    --storing byte from dataIn in word in address 0x400
    Mem_WrEn<='1';
    MEM_DataIn<=x"00000088";
    ALU_MEM_Addr<=x"00000000";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000001";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000002";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000003";
    wait for clk_period;
    
    --reading the modified word
    Mem_WrEn<='0';    
    ByteOp<='0';    
    ALU_MEM_Addr<=x"00000000";
    wait for clk_period;
    
    
    --storing a byte from datain in different words
    ByteOp<='1';
    Mem_WrEn<='1';
    MEM_DataIn<=x"000000bb";
    ALU_MEM_Addr<=x"00000004";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000009";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"0000000e";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000013";
    wait for clk_period;
    
    --reading the words with changed bytes
    ByteOp<='0';
    Mem_WrEn<='0';
    ALU_MEM_Addr<=x"00000004";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000008";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"0000000c";
    wait for clk_period;
    
    ALU_MEM_Addr<=x"00000010";
    wait for clk_period;

    wait;
  end process;


end;
