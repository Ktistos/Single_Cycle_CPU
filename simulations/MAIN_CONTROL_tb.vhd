library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity MAIN_CONTROL_tb is
end;

architecture bench of MAIN_CONTROL_tb is

  component MAIN_CONTROL
    Port (
          ALU_zero : in std_logic;
          OpCode:  in std_logic_vector(5 downto 0);
          ALUop : out std_logic_vector(2 downto 0);
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

  signal ALU_zero: std_logic:='0';
  signal OpCode: std_logic_vector(5 downto 0):=(others=>'0');
  signal ALUop: std_logic_vector(2 downto 0);
  signal PC_Sel: std_logic:='0';
  signal RF_WrData_sel: std_logic:='0';
  signal RF_WrEn: std_logic:='0';
  signal RF_B_sel: std_logic:='0';
  signal ImmExt: std_logic_vector(1 downto 0):=(others=>'0');
  signal ALU_Bin_sel: std_logic:='0';
  signal ByteOp: std_logic:='0';
  signal Mem_WrEn: std_logic :='0';

begin

  uut: MAIN_CONTROL port map ( ALU_zero      => ALU_zero,
                               OpCode        => OpCode,
                               ALUop         => ALUop,
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
  --Checking all the opcodes provided by the ISA to ensure that the correct control signals are produced
    wait for 100ns;
    --testing r-type instructions
    OpCode<="100000";
    wait for 100ns;
    --li instruction
    OpCode<="111000";
    wait for 100ns;
    --lui instruction
    OpCode<="111001";
    wait for 100ns;
    --addi instruction
    OpCode<="110000";
    wait for 100ns;
    --nandi instrucion
    OpCode<="110010";
    wait for 100ns;
    --ori instruction
    OpCode<="110011";
    wait for 100ns;
    --testing b instruction//PC_Sel must be 1
    OpCode<="111111";
    ALU_zero<='1';
    wait for 100ns;
    --testing b instruction//PC_Sel must be 0
    OpCode<="111111";
    ALU_zero<='0';
    wait for 100ns;
    --testing beq instruction//PC_Sel must be 1
    OpCode<="000000";
    ALU_zero<='1';
    wait for 100ns;
    --testing beq instruction//PC_Sel must be 0
    OpCode<="000000";
    ALU_zero<='0';
    wait for 100ns;
    --testing bne instruction//PC_Sel must be 0
    OpCode<="000001";
    ALU_zero<='1';
    wait for 100ns;
    --testing bne instruction//PC_Sel must be 1
    OpCode<="000001";
    ALU_zero<='0';
    wait for 100ns;
    
    --lb instruction
    OpCode<="000011";
    ALU_zero<='0';
    wait for 100ns;
    
    --sb instruction
    OpCode<="000111";
    ALU_zero<='0';
    wait for 100ns;
    
    --lw instruction
    OpCode<="001111";
    ALU_zero<='0';
    wait for 100ns;
    
    --sw instruction
    OpCode<="011111";
    ALU_zero<='0';
    wait for 100ns;
    
    --invalid opcode
    OpCode<="100001";
   
    wait;
  end process;


end;
