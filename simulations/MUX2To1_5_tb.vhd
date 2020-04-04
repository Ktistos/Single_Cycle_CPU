
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX2To1_5_tb IS
END MUX2To1_5_tb;
 
ARCHITECTURE behavior OF MUX2To1_5_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX2To1_5
    PORT(
         A : IN  std_logic_vector(4 downto 0);
         B : IN  std_logic_vector(4 downto 0);
         MUX_out : OUT  std_logic_vector(4 downto 0);
         Sel : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(4 downto 0) := (others => '0');
   signal B : std_logic_vector(4 downto 0) := (others => '0');
   signal Sel : std_logic := '0';

 	--Outputs
   signal MUX_out : std_logic_vector(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX2To1_5 PORT MAP (
          A => A,
          B => B,
          MUX_out => MUX_out,
          Sel => Sel
        );

   -- Clock process definitions
   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
     --checking if A will show up in the output
      wait for 100 ns;	
       A<="11111";
       B<="00001";
       Sel<='0';
       --checking if B will show up in the output
       wait for 100ns;
       Sel<='1';

      -- insert stimulus here 

      wait;
   end process;

END;
