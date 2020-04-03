LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Alu_tb IS
END Alu_tb;
 
ARCHITECTURE behavior OF Alu_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Clock process definitions
   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      --Testing was done with 4-bit numbers on paper. 
      --To test extreme conditions like ovf and cout we take the 4bit part of the number and put it in the start of the 32-bit word
     --Regular addition(regular numbers just ot make sure addition works)
     Op<="0000";
     A<=x"00000001";
     B<=x"00000002";
     wait for 50 ns;
     --Out of bounds addition(ovf=1)
     A<=x"7fffffff";
     B<=X"7fffffff";
     wait for 50 ns;
     --different sign addition(cout=1,ovf=0)
     A<=x"C0000000";
     B<=x"60000000";
     wait for 50 ns;
     --diff sign adiition(cout=0,ovf=0)
     A<=x"C0000000";
     B<=x"30000000";
     wait for 50 ns;
     --negative numbers addition(cout=1,ovf=0)
     A<=x"C0000000";
     B<=x"D0000000";
     wait for 50 ns;
     --negative numbers out of bounds additions(ovf=1,cout=1)
     A<=x"F0000000";
     B<=x"80000000";
     
     wait for 80 ns;
     --simple subtraction(Cout=1,ovf=0)
     Op<="0001";
     B<=x"00000001";
     A<=x"00000002";
     
     wait for 50 ns;
     --subtraction (cout=0,ovf=0)
     A<=x"00000001";
     B<=x"00000002";
     wait for 50 ns;
     --different sign subtraction (same sign addition)(ovf=0,cout=0)
     A<=x"20000000";
     B<=x"B0000000";
     wait for 50 ns;
     --same sign subtraction with positive result(cout=1,ovf=0)
     A<=x"50000000";
     B<=x"20000000";
     wait for 50 ns;
     --same sign subtraction with negative result(cout=0,ovf=0)
     A<=x"50000000";
     B<=x"70000000";
     wait for 50 ns;
     --different sign subtraction with negative result(cout=1,ovf=0)
     A<=x"D0000000";
     B<=x"20000000";
     wait for 50 ns;
     --testing upper bound ovf(ovf=1,cout=0)
     A<=x"7fffffff";
     B<=X"80000001";
     wait for 50 ns;
     --testing the lower bound ovf(ovf=1,cout=1)
     A<=x"B0000000";
     B<=x"40000000";
     --subtracting the lower bound from -1 (ovf=0 cout=0)
      wait for 50ns;
      A<=x"ffffffff";
      B<=x"80000000";
     wait for 50 ns;
     --the first 2 halfbytes of each word represent a truth table of 2 variables for and gate
      Op<="0010";
      A<=x"50000000";
      B<=X"30000000";
      wait for 50 ns;
     --the first 2 halfbytes of each word represent a truth table of 2 variables for or gate
      Op<="0011";
      A<=x"50000000";
      B<=X"30000000";
      wait for 50 ns;
     --not gate
      Op<="0100";
      A<=x"00000000";
      wait for 25 ns;
     --the first 2 halfbytes of each word represent a truth table of 2 variables for nand gate
      Op<="0101";
      A<=x"30000000";
      B<=x"50000000";
      wait for 25ns;
      --the first 2 halfbytes of each word represent a truth table of 2 variables for nand gate
      Op<="0110";
      A<=x"30000000";
      B<=x"50000000";
      wait for 25 ns;
      Op<="1000";
      --arithmetic shift on positive number
      A<=x"70000000";
      wait for 25 ns;
      Op<="1000";
      --arithmetic shift on negative number
      A<=x"80000000";
      wait for 25 ns;
      Op<="1001";
      --logical right shift on positive number
      A<=x"70000000";
      wait for 25 ns;
      Op<="1001";
      --logical right shift on negative number
      A<=x"80000000";
      wait for 25 ns;
      Op<="1010";
      --logical left shift on positive number
      A<=x"70000000";
      wait for 25 ns;
      Op<="1010";
      --logical left shift on negative number
      A<=x"80000000";
      
      
      wait for 25 ns;
      Op<="1100";
      --rotate left on positive number
      A<=x"70000000";
      wait for 25 ns;
      Op<="1100";
      --rotate left shift on negative number
      A<=x"80000000";
     
      wait for 25 ns;
      Op<="1101";
      --rotate right on positive number
      A<=x"70000001";
      wait for 25 ns;
      Op<="1101";
      --rotate right shift on negative number
      A<=x"80000000";
      wait for 25 ns;
      Op<="1111";
      wait for 25 ns;
      Op<="1110";
      
      wait;
   end process;

END;