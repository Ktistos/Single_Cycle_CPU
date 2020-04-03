--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:14:30 02/27/2020
-- Design Name:   
-- Module Name:   /home/dbanelas/Documents/14.7/ISE_DS/CPU_wannabe/register_tb.vhd
-- Project Name:  CPU_wannabe
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Register32bit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
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
