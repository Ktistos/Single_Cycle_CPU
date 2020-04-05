
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DATAPATH is
  Port ( 
        Clk : in std_logic;
        ----INPUTS
        
        --IFSTAGE INterface
        PC_Sel : in std_logic;
        Reset : in std_logic;
        PC_LdEn : in std_logic;
        
        
         --DECSTAGE Intefrace
        Instr : in std_logic_vector(31 downto 0);
        RF_WrData_sel : in std_logic;
        RF_WrEn : in std_logic;
        RF_B_sel : in std_logic;
        ImmExt : in std_logic_vector(1 downto 0);
        
        --EXSTAGE Interface
        ALU_Bin_sel : in std_logic;
        ALU_func : in std_logic_vector(3 downto 0);
        
        --MEMSTAGE interface
        ByteOp : in std_logic;
        Mem_WrEn : in std_logic;
        MM_RdData : in std_logic_vector(31 downto 0);
        
        ----OUTPUTS
        PC_out: out std_logic_vector(31 downto 0);
        MM_WrEn : out std_logic;
        MM_WrData : out std_logic_vector(31 downto 0);
        MM_Addr : out std_logic_vector(31 downto 0);
        ALU_zero : out std_logic
  );
end DATAPATH;

architecture Behavioral of DATAPATH is

component IFSTAGE is
  Port (
        PC_immed: in std_logic_vector(31 downto 0);
        PC_sel: in std_logic;
        PC_LdEn: in std_logic;
        Reset: in std_logic;
        Clk: in std_logic;
        PC_out: out std_logic_vector(31 downto 0));
        
end component;

component DECSTAGE is
  Port ( 
        Instr : in std_logic_vector(31 downto 0);
        RF_WrEn : in std_logic;
        ALU_out : in std_logic_vector(31 downto 0);
        MEM_out : in std_logic_vector(31 downto 0);
        RF_WrData_sel : in std_logic;
        RF_B_sel : in std_logic;
        ImmExt : in std_logic_vector(1 downto 0);
        Clk : in std_logic;
        RST: in std_logic;
        Immed : out std_logic_vector(31 downto 0);
        RF_A : out std_logic_vector(31 downto 0);
        RF_B : out std_logic_vector(31 downto 0)
  
  );
end component;

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

signal t_immed: std_logic_vector(31 downto 0);
signal t_RF_A : std_logic_vector(31 downto 0);
signal t_RF_B : std_logic_vector(31 downto 0);
signal t_ALU_out :  std_logic_vector(31 downto 0);
signal t_MEM_out :  std_logic_vector(31 downto 0);




begin

InstructionFetching: IFSTAGE
port map(
        PC_immed=>t_immed,
        PC_sel=>PC_Sel,
        PC_LdEn=>PC_LdEn,
        Reset=>Reset,
        Clk=>Clk,
        PC_out=>PC_out 
);

InstructionDecoding: DECSTAGE
port map(
        Instr=>Instr,
        RF_WrEn=>RF_WrEn,
        ALU_out=>t_ALU_out,
        MEM_out=>t_MEM_out,
        RF_WrData_sel=>RF_WrData_sel,
        RF_B_sel=>RF_B_sel,
        ImmExt=>ImmExt,
        Clk=>Clk,
        Immed=>t_immed,
        RST=>Reset,
        RF_A=>t_RF_A,
        RF_B=>t_RF_B
);

InstructionExecution: EXSTAGE
port map(
        RF_A=>t_RF_A,
        RF_B=>t_RF_B,
        Immed=>t_immed,
        ALU_Bin_sel=>ALU_Bin_sel,
        ALU_func=>ALU_func,
        ALU_out=>t_ALU_out,
        ALU_zero=>ALU_zero
);

MemoryAccess: MEMSTAGE
port map(
        ByteOp=>ByteOp,
        Mem_WrEn=>Mem_WrEn,
        MM_WrEn=>MM_WrEn,
        ALU_MEM_Addr=>t_ALU_out,
        MEM_DataIn=>t_RF_B,
        MEM_DataOut=>t_MEM_out,
        MM_Addr=>MM_Addr,
        MM_WrData=>MM_WrData,
        MM_RdData=>MM_RdData 
);

end Behavioral;
