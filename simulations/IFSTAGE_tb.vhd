

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE_tb is
--  Port ( );
end IFSTAGE_tb;

architecture Behavioral of IFSTAGE_tb is

component IFSTAGE is
  Port (
        PC_immed: in std_logic_vector(31 downto 0);
        PC_sel: in std_logic;
        PC_LdEn: in std_logic;
        Reset: in std_logic;
        Clk: in std_logic;
        
--IMPORTANT
--PC_out is used as the command and not as the command'a adress
        PC_out: out std_logic_vector(31 downto 0));  
end component;

--rom.data file has consecutive 32 bit numbers in order to test that IFSTAGE is fetching the correct instructions
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


--RAM SIGNALS
signal inst_dout :  std_logic_vector(31 downto 0):=(others=>'0');


--TEMPORARY SIGNALS
signal t_pc_out : std_logic_vector(31 downto 0);


--PC SIGNALS
signal PC_immed : std_logic_vector(31 downto 0):=(others=>'0');
signal PC_sel : std_logic:='0';
signal PC_LdEn : std_logic:='0';
signal Reset : std_logic:='0';
signal Clk : std_logic:='0';


signal PC_out : std_logic_vector(31 downto 0):=(others=>'0');

-- Clock period definitions
   constant Clk_period : time := 100 ns;

begin
    uut: IFSTAGE
    port map(
            PC_immed=>PC_immed,
            PC_sel=>PC_sel,
            PC_LdEn=>PC_LdEn,
            Reset=>Reset,
            Clk=>Clk,
            PC_out=>t_pc_out
    );
    
    
    RandomAccessMemory: RAM
    port map(
            clk=>Clk,
            inst_addr=>t_pc_out(12 downto 2),
            inst_dout=>inst_dout,
            data_we=>'0',
            data_din=>x"00000000",
            data_addr=>"00000000000",
            data_dout=>open
    );
    

-- Clock process definitions
   Clk_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
   
   ---A RAM module is connected to ensure that the ifstage is working properly
   ---Every time an istruction is fetched according to the address that is the output of the pc.
   stim_proc: process
   begin
   --Reset, starting from address 0x000
   --Load enable='1' in order to be able to write in pc
   wait for 50ns;
   PC_LdEn<='1';
   Reset<='1';
   wait for Clk_period;
   
   --Reset='0', start fetching instructions for 5 clock cycles
   --5 consecutive instructions.
   Reset<='0';
   wait for Clk_Period*5;
   
   --Load enable='0' for 2 clock cycles, should see the last instruction fetched
   PC_LdEn<='0';
   --asserting the right signals for a branch
   PC_sel<='1';
   PC_immed<=x"0000000c";
   wait for Clk_Period*2;

   --initiating branch
   PC_LdEn<='1';
   wait for Clk_Period*2;

   
   
    
   wait;
   end process;
   
   
   
end Behavioral;
