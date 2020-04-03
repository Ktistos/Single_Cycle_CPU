
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PROC_SC is
 Port (
       Reset : in std_logic;
       clk: in std_logic
       
  );
end PROC_SC;

architecture Behavioral of PROC_SC is

component DATAPATH is
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
  
  end component;
  
  component CONTROL is
  Port (
        Instr : in std_logic_vector(31 downto 0);
        ALU_zero : in std_logic;
        ALU_Func: out std_logic_vector(3 downto 0);
        
        
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
end component;

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
  

signal t_instr: std_logic_vector(31 downto 0);
signal t_ALU_zero: std_logic;
signal t_ALU_Func: std_logic_vector(3 downto 0);
signal t_PC_Sel: std_logic;
signal t_RF_WrData_sel: std_logic;
signal t_RF_WrEn: std_logic;
signal t_RF_B_sel: std_logic;
signal t_ImmExt: std_logic_vector(1 downto 0);
signal t_ALU_Bin_sel: std_logic;
signal t_ByteOp: std_logic;
signal t_Mem_WrEn: std_logic;


signal t_MM_RdData: std_logic_vector(31 downto 0);
signal t_PC_out: std_logic_vector(31 downto 0);
signal t_MM_WrEn: std_logic;
signal t_MM_WrData: std_logic_vector(31 downto 0);
signal t_MM_Addr: std_logic_vector(31 downto 0);



begin


CPUControl: CONTROL
port map(
        Instr=>t_instr,
        ALU_zero=>t_ALU_zero,
        ALU_Func=>t_ALU_Func,
        PC_Sel=>t_PC_Sel,
        RF_WrData_sel=>t_RF_WrData_sel,
        RF_WrEn=>t_RF_WrEn,
        RF_B_sel=>t_RF_B_sel,
        ImmExt=>t_ImmExt,
        ALU_Bin_sel=>t_ALU_Bin_sel,
        ByteOp=>t_ByteOp,
        Mem_WrEn=>t_Mem_WrEn
);



CPUDatapath: DATAPATH
port map(
        Clk=>clk,
        PC_Sel=>t_PC_Sel,
        Reset=>Reset,
        PC_LdEn=>'1',
        Instr=>t_instr,
        RF_WrData_sel=>t_RF_WrData_sel,
        RF_WrEn=>t_RF_WrEn,
        RF_B_sel=>t_RF_B_sel,
        ALU_Bin_sel=>t_ALU_Bin_sel,
        ALU_func=>t_ALU_Func,
        ImmExt=>t_ImmExt,
        ByteOp=>t_ByteOp,
        Mem_WrEn=>t_Mem_WrEn,
        ALU_zero=>t_ALU_zero,
        MM_RdData=>t_MM_RdData,
        PC_out=>t_PC_out,
        MM_WrEn=>t_MM_WrEn,
        MM_WrData=>t_MM_WrData,
        MM_Addr=>t_MM_Addr
);

CPURandomAccessMemory: RAM
port map(
        clk=>clk,
        inst_addr=>t_PC_out(12 downto 2),
        inst_dout=>t_instr,
        data_we=>t_Mem_WrEn,
        data_addr=>t_MM_Addr(12 downto 2),
        data_din=>t_MM_WrData,
        data_dout=>t_MM_RdData
);


end Behavioral;
