library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


---BIG ENDIAN MACHINE

entity MEMSTAGE is
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
end MEMSTAGE;



architecture Behavioral of MEMSTAGE is

component Adder is
  Port ( 
        A : in std_logic_vector(31 downto 0);
        B : in std_logic_vector(31 downto 0);
        Sum : out std_logic_vector(31 downto 0)
  );
end component; 


begin

--adding 0x400 to the adress in order to access the data section of RAM
Adder400: Adder
port map(
        A=>ALU_MEM_Addr,
        B=>x"00001000",
        Sum=>MM_Addr      
);

--hardwiring WrEn
MM_WrEn<=Mem_WrEn;



--when ByteOp='0'(sw) the DataIn is written directly to RAM
--when ByteOp='1'(sb) the byte in DataIn is written in the word from RdData, in the position pointed by the last two bits of the ALU_addr
 MM_WrData<=MEM_DataIn(7 downto 0) & MM_RdData(23 downto 0) when (ByteOp='1' and ALU_MEM_Addr(1 downto 0)="00") else
            MM_RdData(31 downto 24) & MEM_DataIn(7 downto 0) & MM_RdData(15 downto 0) when (ByteOp='1' and ALU_MEM_Addr(1 downto 0)="01") else
            MM_RdData(31 downto 16) & MEM_DataIn(7 downto 0) & MM_RdData(7 downto 0) when (ByteOp='1' and ALU_MEM_Addr(1 downto 0)="10") else
            MM_RdData(31 downto 8) & MEM_DataIn(7 downto 0) when (ByteOp='1' and ALU_MEM_Addr(1 downto 0)="11") else 
            MEM_DataIn;

--when ByteOp='0'(lw) the Rd_Data is the output
--when ByteOp='0'(lb) the byte pointed by the last two bits of the ALU_addr, in the word of RdData is the output
MEM_DataOut<=x"000000" & MM_RdData(31 downto 24) when (ByteOp='1' and ALU_MEM_Addr(1 downto 0)="00") else
             x"000000" & MM_RdData(23 downto 16) when (ByteOp='1' and ALU_MEM_Addr(1 downto 0)="01") else   
             x"000000" & MM_RdData(15 downto 8) when (ByteOp='1' and ALU_MEM_Addr(1 downto 0)="10") else
             x"000000" & MM_RdData(7 downto 0) when (ByteOp='1' and ALU_MEM_Addr(1 downto 0)="11") else
             MM_RdData;
        



end Behavioral;
