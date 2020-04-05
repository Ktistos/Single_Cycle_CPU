
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROL is
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
end CONTROL;

architecture Behavioral of CONTROL is

component MAIN_CONTROL is
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
end component;

component ALU_CONTROL is
  Port ( 
        Func : in std_logic_vector(5 downto 0);
        ALUop : in std_logic_vector(2 downto 0);
        ALU_ctr: out std_logic_vector(3 downto 0)
        
  );
end component;


signal t_ALUop : std_logic_vector(2 downto 0):=(others=>'0');

begin

MainControl: MAIN_CONTROL
port map(
        ALU_zero =>ALU_zero,
        OpCode=>Instr(31 downto 26),
        ALUop =>t_ALUop,
        PC_Sel=>PC_Sel,
        RF_WrData_sel =>RF_WrData_sel,
        RF_WrEn =>RF_WrEn,
        RF_B_sel =>RF_B_sel,
        ImmExt =>ImmExt,
        ALU_Bin_sel =>ALU_Bin_sel,
        ByteOp =>ByteOp,
        Mem_WrEn =>Mem_WrEn

);


ALUControl: ALU_CONTROL
port map(
        Func =>Instr(5 downto 0),
        ALUop =>t_ALUop,
        ALU_ctr=> ALU_Func
);

end Behavioral;
