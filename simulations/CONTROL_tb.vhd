library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity CONTROL_tb is
end;

architecture bench of CONTROL_tb is

  component CONTROL
    Port (
          Instr : in std_logic_vector(31 downto 0);
          ALU_zero : in std_logic;
          ALU_Func: out std_logic_vector(3 downto 0);
          PC_Sel : out std_logic;
          RF_WrData_sel : out std_logic;
          RF_WrEn : out std_logic;
          RF_B_sel : out std_logic;
          ImmExt : out std_logic_vector(1 downto 0);
          ALU_Bin_sel : out std_logic;
          ByteOp : out std_logic;
          Mem_WrEn : out std_logic       
     );
  end component;

  signal Instr: std_logic_vector(31 downto 0):=(others=>'0');
  signal ALU_zero: std_logic:='0';
  signal ALU_Func: std_logic_vector(3 downto 0):=(others=>'0');
  signal PC_Sel: std_logic:='0';
  signal RF_WrData_sel: std_logic;
  signal RF_WrEn: std_logic:='0';
  signal RF_B_sel: std_logic:='0';
  signal ImmExt: std_logic_vector(1 downto 0):=(others=>'0');
  signal ALU_Bin_sel: std_logic:='0';
  signal ByteOp: std_logic:='0';
  signal Mem_WrEn: std_logic:='0';

begin

  uut: CONTROL port map ( Instr         => Instr,
                          ALU_zero      => ALU_zero,
                          ALU_Func      => ALU_Func,
                          PC_Sel        => PC_Sel,
                          RF_WrData_sel => RF_WrData_sel,
                          RF_WrEn       => RF_WrEn,
                          RF_B_sel      => RF_B_sel,
                          ImmExt        => ImmExt,
                          ALU_Bin_sel   => ALU_Bin_sel,
                          ByteOp        => ByteOp,
                          Mem_WrEn      => Mem_WrEn );

  stimulus: process
  begin
  
   wait for 100ns;
   --add
   Instr<="10000000000000000000000000110000";
   wait for 100ns;
   --sub
   Instr<="10000000000000000000000000110001";
   wait for 100ns;
   --and
   Instr<="10000000000000000000000000110010";
   wait for 100ns;
   --or
   Instr<="10000000000000000000000000110011";
   wait for 100ns;
   --not
   Instr<="10000000000000000000000000110100";
   wait for 100ns;
   --nand
   Instr<="10000000000000000000000000110101";
   wait for 100ns;
   --nor
   Instr<="10000000000000000000000000110110";
   wait for 100ns;
   --sra
   Instr<="10000000000000000000000000111000";
   wait for 100ns;
   --srl
   Instr<="10000000000000000000000000111001";
   wait for 100ns;
   --sll
   Instr<="10000000000000000000000000111010";
   wait for 100ns;
   --rol
   Instr<="10000000000000000000000000111100";
   wait for 100ns;
   --ror
   Instr<="10000000000000000000000000111101";
   wait for 100ns;
   
    
    --li instruction
    Instr<="11100000000000000000000000000000";
    wait for 100ns;
    
    --lui instruction
    Instr<="11100100000000000000000000000000";
    wait for 100ns;
    --addi instruction
    Instr<="11000000000000000000000000000000";
    wait for 100ns;
    --nandi instrucion
    Instr<="11001000000000000000000000000000";
    wait for 100ns;
    --ori instruction
    Instr<="11001100000000000000000000000000";
    wait for 100ns;
    
    --testing b instruction//PC_Sel must be 1
    Instr<="11111100000000000000000000000000";
    ALU_zero<='1';
    wait for 100ns;
    --testing b instruction//PC_Sel must be 0
    Instr<="11111100000000000000000000000000";
    ALU_zero<='0';
    wait for 100ns;
    
    --testing beq instruction//PC_Sel must be 1
    Instr<="00000000000000000000000000000000";
    ALU_zero<='1';
    wait for 100ns;
    --testing beq instruction//PC_Sel must be 0
    Instr<="00000000000000000000000000000000";
    ALU_zero<='0';
    wait for 100ns;
    
    
    --testing bne instruction//PC_Sel must be 0
    Instr<="00000100000000000000000000000000";
    ALU_zero<='1';
    wait for 100ns;
    --testing bne instruction//PC_Sel must be 1
    Instr<="00000100000000000000000000000000";
    ALU_zero<='0';
    wait for 100ns;
    
    --lb instruction
    Instr<="00001100000000000000000000000000";
    ALU_zero<='0';
    wait for 100ns;
    
    --sb instruction
    Instr<="00011100000000000000000000000000";
    ALU_zero<='0';
    wait for 100ns;
    
    --lw instruction
    Instr<="00111100000000000000000000000000";
    ALU_zero<='0';
    wait for 100ns;
    
    --sw instruction
    Instr<="01111100000000000000000000000000";
    ALU_zero<='0';
    wait for 100ns;
    
    --nandi OpCode----checking if func field will affect the alu_func result
    Instr<="11001000000000000000000000111111";
    wait for 100ns;
    
    --invalid opcode
    Instr<="10000100000000000000000000000000";
    
   
   


    -- Put test bench stimulus code here

    wait;
  end process;


end;