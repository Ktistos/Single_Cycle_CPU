
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY mux2to1_tb IS
END mux2to1_tb;
 
ARCHITECTURE behavior OF mux2to1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX2To1
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         mux_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal mux_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX2To1 PORT MAP (
          A => A,
          B => B,
          sel => sel,
          mux_out => mux_out
        );

   

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      --checking if A will show up in the output
      wait for 100 ns;	

       A<=x"11111111";
       B<=x"ffffffff";
       sel<='0';
       --checking if B will show up in the output
       wait for 100ns;
       sel<='1';
       
       

      wait;
   end process;

END;
