----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/30/2020 03:43:30 PM
-- Design Name: 
-- Module Name: DATAPATH_tb - Behavioral
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

entity DATAPATH_tb is
--  Port ( );
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
   
   --for r type instructions we check alu_out/mem_out mux for the critical path
   
   
   ----Epeidh kathe for meta apo ena wait statement, otan pername times sta control shmata ekeines pernane sto falling edge
   ----gia na mhn ephreastei o xronos ekteleshs twn entolwn
   ----Kathe fora pou xreiazetai na allaksoyme ta control shmata ths epomenhs entolhs
   ----prepei na kleisoume to PC_LdEn ston kyklo ths trexoysas entolhs etsi wste o PC na mhn ananewthei
   ----kai ston epomeno kyklo na diathrhsei thn trexousa timh.Ston epomeno kyklo kanoyme tis aparaithtes allagew sta shmata control
   ----kai anoigoume to PC_LdEn etsi wste ston epomeno kyklo na fortwthei h epomenh entolh   
   
   --PROBLEM:
   --After every wait statement the signal values are assigned in the falling edge of the clock.
   
   
   
   stim_proc: process
   begin
   --testing every single instruction
   --every value is stored in registers 1 through 5
   --the instructions are taken from rom.data file
   --data segment of ram is empty-nothing is stored
   wait for 100ns;
   
   PC_LdEn<='0';
   Reset<='1';
   wait for clk_period*2;
   
   PC_LdEn<='1';
   wait for clk_period;
   
   --li r1,5
   --we must see 5 in register r1
   Reset<='0';
   RF_B_sel<='0';
   ALU_Bin_sel<='1';
   ALU_func<="0011";
   RF_WrData_sel<='0';
   RF_WrEn<='1';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='0';
   Mem_WrEn<='0';
   wait for clk_period;
   
   --li r2,10
   --we must see 10 in register r2

   PC_LdEn<='0'; --instruction with diff control signals incoming
   wait for clk_period;
   
   --add r3,r2,r1
   --we sust see 15 in r3
   RF_B_sel<='0';
   ALU_Bin_sel<='0';
   ALU_func<="0000";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="00";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   PC_LdEn<='1';--new instruction 
   wait for clk_period;
   
   PC_LdEn<='0'; --instruction with diff control signals incoming
   RF_WrEn<='1';
   wait for clk_period;
   
   --not r4,r3
   --we must see ...1110000 in r4
   RF_B_sel<='0';
   ALU_Bin_sel<='0';
   ALU_func<="0100";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="00";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   PC_LdEn<='1';--new instruction 
   wait for clk_period;
   
   PC_LdEn<='0'; --instruction with diff control signals incoming
   RF_WrEn<='1';
   wait for clk_period;
   
   --beq r2,r3,x0002
   RF_B_sel<='1';
   ALU_Bin_sel<='0';
   ALU_func<="0001";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="10";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   PC_LdEn<='1';--new instruction 
   wait for clk_period;
   
   PC_LdEn<='0'; --instruction with diff control signals incoming
   RF_WrEn<='0';
   wait for clk_period;
   
   
   
   --addi r2,r2,5
   RF_B_sel<='1';
   ALU_Bin_sel<='1';
   ALU_func<="0000";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   PC_LdEn<='1';--new instruction 
   wait for clk_period;
   
   PC_LdEn<='0'; --instruction with diff control signals incoming
   RF_WrEn<='1';
   wait for clk_period;
   
   
   
   --b -3
   RF_B_sel<='1';
   ALU_Bin_sel<='0';
   ALU_func<="0001";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="10";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   PC_LdEn<='1';--new instruction 
   wait for clk_period;
   
   PC_Sel<='1';
   wait for clk_period;
   
   
   
   --beq instruction that failed, succeeds now
   
   PC_LdEn<='1';--new instruction 
   ---------------------------------
   wait for clk_period;
   
   PC_LdEn<='0';
   wait for clk_period;
   
   RF_B_sel<='1';
   ALU_Bin_sel<='1';
   ALU_func<="0000";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='0';
   Mem_WrEn<='1';
   
   PC_LdEn<='1';
   
   wait for clk_period;
   
   Mem_WrEn<='0';
   PC_LdEn<='0';
   wait for clk_period;
   
   RF_B_sel<='1';
   ALU_Bin_sel<='1';
   ALU_func<="0000";
   RF_WrData_sel<='1';
   RF_WrEn<='1';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='0';
   Mem_WrEn<='0';
   
   PC_LdEn<='1';
   wait for clk_period;
   
   RF_WrEn<='0';
   PC_LdEn<='0';
   wait for clk_period;
   
   --sb
   RF_B_sel<='1';
   ALU_Bin_sel<='1';
   ALU_func<="0000";
   RF_WrData_sel<='0';
   RF_WrEn<='0';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='1';
   Mem_WrEn<='1';
   
   PC_LdEn<='1';
   wait for clk_period;
   
   Mem_WrEn<='0';
   PC_LdEn<='0';
   wait for clk_period;
   
   --lb
   
   RF_B_sel<='1';
   ALU_Bin_sel<='1';
   ALU_func<="0000";
   RF_WrData_sel<='1';
   RF_WrEn<='1';
   PC_Sel<='0';
   ImmExt<="01";
   ByteOp<='1';
   Mem_WrEn<='0';
   
   PC_LdEn<='1';
   wait for clk_period;
   
   
   RF_WrEn<='0';
   PC_LdEn<='0';
   wait for clk_period;
   
   
   
   wait;
   end process;
   
   
   
   
   

end Behavioral;
