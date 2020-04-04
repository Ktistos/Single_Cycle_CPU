
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register_tb IS
END register_tb;
 
ARCHITECTURE behavior OF register_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Register32bit
    PORT(
         Datain : IN  std_logic_vector(31 downto 0);
         Dataout : OUT  std_logic_vector(31 downto 0);
         Clk : IN  std_logic;
         WE : IN  std_logic;
         RST : IN std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Datain : std_logic_vector(31 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal WE : std_logic := '0';
   signal RST : std_logic := '0';
  

 	--Outputs
   signal Dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Register32bit PORT MAP (
          Datain => Datain,
          Dataout => Dataout,
          Clk => Clk,
          WE => WE,
          RST=>RST
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- testing the functionality of a 32 bit register
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      
      RST<='1';
      wait for Clk_period;
     
      --storing a random number in the register
      RST<='0';
      WE<='1';
      Datain<=x"11111111";
      
      wait for Clk_period;
      --storing another random number and then make it hold its value for 3cycles
      
      
      WE<='1';
      Datain<=x"11110001";
      wait for Clk_period;
      --storing another random number and then make it hold its value for 3cycles
      WE<='0';
      wait for Clk_period*3;
      --trying to write to register without WE 
      Datain<=x"10000001";
      wait for Clk_period;
    
      
      -- insert stimulus here 

      wait;
   end process;

END;
