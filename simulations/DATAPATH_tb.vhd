----------------------------------------------------------------------------------
--The purpose of this testbench is to check the functionality of instructions that 
--use different datapath components.
--It consists of instructions that test all of the components in the datapath and
--ensure that the datapath submodules are properly connected.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DATAPATH_tb is

end DATAPATH_tb;

architecture Behavioral of DATAPATH_tb is

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

--CONTROL SIGNALS
signal RF_B_sel : std_logic:='0';
signal ImmExt : std_logic_vector(1 downto 0):=(others=>'0');
signal ALU_Bin_sel: std_logic:='0';
signal ALU_func: std_logic_vector(3 downto 0):=(others=>'0');
signal RF_WrData_sel: std_logic:='0';
signal Mem_WrEn: std_logic:='0';
signal PC_Sel: std_logic:='0';
signal RF_WrEn: std_logic:='0';
signal Reset: std_logic:='0';
signal PC_LdEn: std_logic:='0';
signal ByteOp: std_logic:='0';


--SPECIAL ZERO SIGNAL 
signal ALU_zero : std_logic:='0';

--CLK
signal clk :std_logic:='0';


--PORT MAP SIGNALS
--DATAPATH
signal t_PC_out : std_logic_vector(31 downto 0):=(others=>'0');
signal t_MM_WrEn : std_logic:='0';
signal t_MM_WrData : std_logic_vector(31 downto 0):=(others=>'0');
signal t_MM_Addr : std_logic_vector(31 downto 0):=(others=>'0');

--MEMORY
signal t_Instr : std_logic_vector(31 downto 0):=(others=>'0');
signal t_MM_RdData : std_logic_vector(31 downto 0):=(others=>'0'); 


constant Clk_period : time := 100 ns;


begin 

DatapathModule: DATAPATH
port map(
        Clk=>clk,
        PC_Sel=>PC_Sel,
        Reset=>Reset,
        PC_LdEn=>PC_LdEn,
        Instr=>t_Instr,
        RF_WrData_sel=>RF_WrData_sel,
        RF_WrEn=>RF_WrEn,
        RF_B_sel=>RF_B_sel,
        ImmExt=>ImmExt,
        ALU_Bin_sel=>ALU_Bin_sel,
        ALU_func=>ALU_func,
        ByteOp=>ByteOp,
        Mem_WrEn=>Mem_WrEn,
        MM_RdData=>t_MM_RdData,
        PC_out=>t_PC_out,
        MM_WrEn =>t_MM_WrEn,
        MM_WrData=>t_MM_WrData,
        MM_Addr =>t_MM_Addr,
        ALU_zero=>ALU_zero
);
RandomAccessMemory: RAM
port map(
        clk =>clk,
        inst_addr =>t_PC_out(12 downto 2),
        inst_dout =>t_Instr,
        data_we =>t_MM_WrEn,
        data_addr =>t_MM_Addr(12 downto 2),
        data_din =>t_MM_WrData,
        data_dout =>t_MM_RdData
);


-- Clock process definitions
   Clk_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;


   --After each wait statement the values of input signals actually get assigned on the falling edge of the clock(50 ns after the rising edge).
   --That is a problem because the clock is set to be 100ns , which means there are only 50 ns left for an instruction to be excecuted.
   --To overcome this problem each instruction is fetched for 2 clock cycles:
   --One clock cycle to set the control signals of the instruction and 
   --another clock cycle to "actually excecute" the instruction.
   --Some signals that enable data to be written in registers or in the memory are actually set on the instruction's excecution 
   --to prevent the cycle which sets the control signals to overwrite data.
   --Since all the duration of all the instructions are over 50 seconds this does not affect the excecution of the instructions.
   
   
   stim_proc: process
   begin
   --every value is stored in registers 1 through 5
   --data segment of ram is empty-nothing is stored
   wait for 100ns;
   -- resetting the Rf registers and the program counter
   
   Reset<='1';
   wait for clk_period;

   --closing the reset signal

   Reset<='0';

  
   wait for clk_period;
   
  -- li control signals
   
   RF_B_sel<='0';
   ALU_Bin_sel<='1';
   ALU_func<="0011";
   RF_WrData_sel<='0';
   --Actually RF_WrEn<='1' but RF_WrEn<='0' to prevent the control signals cycle from overwritting data
   RF_WrEn<='0';

   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0';
   wait for clk_period;
   --instruction excecution
   --li r1,5

   --allows data to be altered during the excution cycle
   RF_WrEn<='1';

   --fetches next instruction
   PC_LdEn<='1';

   wait for clk_period;
   -- li control signals
   RF_B_sel<='0';
   ALU_Bin_sel<='1';
   ALU_func<="0011";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='0';
   Mem_WrEn<='0';

   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0';
   wait for clk_period;
   --instruction excecution
   --li r2,10
   
   --allows data to be altered during the excution cycle
   RF_WrEn<='1';

    --fetches next instruction
   PC_LdEn<='1';
   wait for clk_period;
   
   --add control signals
   RF_B_sel<='0';
   ALU_Bin_sel<='0';
   ALU_func<="0000";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="00";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0'; 
   wait for clk_period;
   --instruction excecution
   --add r3,r2,r1 ,expect to see r3 with value 15
   
   --allows data to be altered during the excution cycle
   RF_WrEn<='1';

   --fetches next instruction
   PC_LdEn<='1'; 
   wait for clk_period;
   
   --not control signals
   
   RF_B_sel<='0';
   ALU_Bin_sel<='0';
   ALU_func<="0100";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="00";
   ByteOp<='0';
   Mem_WrEn<='0';

   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0';
   wait for clk_period;
   
   --instruction excecution
   --not r4,r3
   --we must see ...1110000 in r4

   --allows data to be altered during the excution cycle
   RF_WrEn<='1';

   --fetches next instruction
   PC_LdEn<='1';
   wait for clk_period;
   
   --beq control signals
   RF_B_sel<='1';
   ALU_Bin_sel<='0';
   ALU_func<="0001";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="10";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0';
   wait for clk_period;
   --instruction excecution
   --beq r2,r3,x0002
   --Since r2!=r3 this instruction is destined to fail that's why PC_Sel<='0' b

   --preventing beq instruction from overwriting data
   RF_WrEn<='0';

   --fetches next instruction
   PC_LdEn<='1'; 
   
   wait for clk_period; 
   
   --addi control signals

   RF_B_sel<='1';
   ALU_Bin_sel<='1';
   ALU_func<="0000";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0'; 
   wait for clk_period;
   --instruction excecution
   --addi r2,r2,5
   -- expect to see 15 in r2
   --allows data to be altered during the excution cycle
   RF_WrEn<='1';

   --fetches next instruction
   PC_LdEn<='1'; 
   wait for clk_period;
   
   -- b control signals
   RF_B_sel<='1';
   ALU_Bin_sel<='0';
   ALU_func<="0001";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="10";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0';
   wait for clk_period;
   --instruction excecution 
   --b -3
   --branches to the previous beq command

   -- allows the change of value of PC based on the branch command arguments
   PC_Sel<='1';
   --fetches next instruction
   PC_LdEn<='1';
   wait for clk_period;
   
   --beq control signals
   RF_B_sel<='1';
   ALU_Bin_sel<='0';
   ALU_func<="0001";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="10";
   ByteOp<='0';
   Mem_WrEn<='0';

   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0';
   wait for clk_period;
   --instruction excecution 
   --beq r2,r3,x0002 now succeeds since r2==r3
   --branches to a sw instruction , which is the next instruction after the previous branch command

   -- allows the change of value of PC based on the branch command arguments
   PC_Sel<='1';

   --fetches next instruction
   PC_LdEn<='1';
   wait for clk_period;
   
   --sw control signals
   RF_B_sel<='1';
   ALU_Bin_sel<='1';
   ALU_func<="0000";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='0';
   --Actually Mem_WrEn<='1' but Mem_WrEn<='0' to prevent the control signals cycle from writting garbage data in the memory
   Mem_WrEn<='0';

   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0';
   wait for clk_period;

   --instruction excecution 
   --sw r1,15(r3) expected to store 5 in the address given as an argument

   --allows data to be altered during the excution cycle
   Mem_WrEn<='1';

   --fetches next instruction
   PC_LdEn<='1';
   wait for clk_period;
   
   --sb control signals
   RF_B_sel<='1';
   ALU_Bin_sel<='1';
   ALU_func<="0000";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='1';
   --Actually Mem_WrEn<='1' but Mem_WrEn<='0' to prevent the control signals cycle from writting garbage data in the memory
   Mem_WrEn<='0';
   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0';
   wait for clk_period;
   --instruction excecution 
   --sb r3,-10(r3) expected to store 15 in the address given as an argument

   --allows data to be altered during the excution cycle
   Mem_WrEn<='1';

   --fetches next instruction
   PC_LdEn<='1';
   wait for clk_period;
   
   --lw control signals
   RF_B_sel<='1';
   ALU_Bin_sel<='1';
   ALU_func<="0000";
   RF_WrData_sel<='1';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='0';
   Mem_WrEn<='0';

   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0';
   wait for clk_period;
   --instruction excecution 
   --lw r5,15(r3) loads number 5 in register r5

   --allows data to be altered during the excution cycle
   RF_WrEn<='1';
   --fetches next instruction
   PC_LdEn<='1';
   wait for clk_period;
   
   --lb control signals
   
   RF_B_sel<='1';
   ALU_Bin_sel<='1';
   ALU_func<="0000";
   RF_WrData_sel<='1';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='1';
   Mem_WrEn<='0';

   --hold the instruction for one more clock cycle for its excecution.
   PC_LdEn<='0';
   wait for clk_period;
   --Last instruction excecution 
   --lb r5,-10(r3)
   --loads number 15 in register r5 

   --allows data to be altered during the excution cycle
   RF_WrEn<='1';
   PC_LdEn<='1';
   wait for clk_period;
   
   
   
   wait;
   end process;
   

end Behavioral;
