----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2020 11:53:59 PM
-- Design Name: 
-- Module Name: RegisterFile_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile_tb is
end RegisterFile_tb;

architecture Behavioral of RegisterFile_tb is

component RegisterFile is
    Port ( Ard1 : in STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in STD_LOGIC_VECTOR (4 downto 0);
           Awr : in STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out STD_LOGIC_VECTOR (31 downto 0);
           Din : in STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in STD_LOGIC;
           RST : in std_logic;
           Clk : in STD_LOGIC);
end component;
--inputs
signal Ard1: std_logic_vector(4 downto 0):=(others=>'0');
signal Ard2: std_logic_vector(4 downto 0):=(others=>'0');
signal Awr: std_logic_vector(4 downto 0):=(others=>'0');
signal Din: std_logic_vector(31 downto 0):=(others=>'0');
signal RST: std_logic:='0';
signal WrEn: std_logic:='0';
signal Clk: std_logic:='0';

--outputs
signal Dout1: std_logic_vector(31 downto 0);
signal Dout2: std_logic_vector(31 downto 0);

-- Clock period definitions
   constant Clk_period : time := 100 ns;

begin
    uut:RegisterFile 
    port map(
             Ard1=>Ard1,
             Ard2=>Ard2,
             Awr=>Awr,
             Din=>Din,
             WrEn=>WrEn,
             Clk=>Clk,
             Dout1=>Dout1,
             Dout2=>Dout2,
             RST=>RST
    
    );
    
    -- Clock process definitions
   Clk_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;


stim_proc: process
   begin
   wait for 30 ns;
   
   --appending value to every register
   WrEn<='1';
   for I in 1 to 31 loop
		Awr<=std_logic_vector(to_unsigned(I,Awr'length));
		Din<=std_logic_vector(to_unsigned(I,Din'length));
		wait for CLK_period;
   end loop;
   
    WrEn<='0';
    wait for CLK_period;
   
   --reading from every register to confirm that the above values were written
   for Z in 0 to 15 loop
        Ard1<=std_logic_vector(to_unsigned(2*Z,Ard1'length));
        Ard2<=std_logic_vector(to_unsigned(2*Z+1,Ard2'length));
        wait for CLK_period;
   end loop;
   
   wait for CLK_period*3;
   
   --trying to write on r0(should not be possible)
   WrEn<='1';
   Awr<="00000";
   Din<=x"00000001";
   wait for Clk_period;
   
   Ard1<="00000";
   Ard2<="00000";
   wait for Clk_period;
   
   --trying to write when it should not be possible(WrEn='0')
   WrEn<='0';
   Awr<="00010";
   Din<=x"aaaaaaaa";
   Ard1<="00010";
   Ard2<="00010";
   wait for Clk_period;
   
   
   --reset='1'
   RST<='1';
   wait for clk_period;
   --checking if every register has been reset
   for Z in 0 to 15 loop
        Ard1<=std_logic_vector(to_unsigned(2*Z,Ard1'length));
        Ard2<=std_logic_vector(to_unsigned(2*Z+1,Ard2'length));
        wait for CLK_period;
   end loop;
   
  
   wait;
   end process;

end Behavioral;
