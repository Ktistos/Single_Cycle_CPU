--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:54:54 02/27/2020
-- Design Name:   
-- Module Name:   /home/dbanelas/Documents/14.7/ISE_DS/CPU_wannabe/decoder5to32_tb.vhd
-- Project Name:  CPU_wannabe
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder5to32
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
 
ENTITY decoder5to32_tb IS
END decoder5to32_tb;
 
ARCHITECTURE behavior OF decoder5to32_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder5to32
    PORT(
         Awr : IN  std_logic_vector(4 downto 0);
         Decoder_Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Decoder_Output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder5to32 PORT MAP (
          Awr => Awr,
          Decoder_Output => Decoder_Output
        );

   -- Clock process definitions
   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for 25ns;

Awr<="00000";

wait for 25ns;

Awr<="00001";

wait for 25ns;

Awr<="00010";

wait for 25ns;

Awr<="00011";

wait for 25ns;

Awr<="00100";

wait for 25ns;

Awr<="00101";

wait for 25ns;

Awr<="00110";

wait for 25ns;

Awr<="00111";

wait for 25ns;

Awr<="01000";

wait for 25ns;

Awr<="01001";

wait for 25ns;

Awr<="01010";

wait for 25ns;

Awr<="01011";

wait for 25ns;

Awr<="01100";

wait for 25ns;

Awr<="01101";

wait for 25ns;

Awr<="01110";

wait for 25ns;

Awr<="01111";

wait for 25ns;

Awr<="10000";

wait for 25ns;

Awr<="10001";

wait for 25ns;

Awr<="10010";

wait for 25ns;

Awr<="10011";

wait for 25ns;

Awr<="10100";

wait for 25ns;

Awr<="10101";

wait for 25ns;

Awr<="10110";

wait for 25ns;

Awr<="10111";

wait for 25ns;

Awr<="11000";

wait for 25ns;

Awr<="11001";

wait for 25ns;

Awr<="11010";

wait for 25ns;

Awr<="11011";

wait for 25ns;

Awr<="11100";

wait for 25ns;

Awr<="11101";

wait for 25ns;

Awr<="11110";

wait for 25ns;

Awr<="11111";
      -- insert stimulus here 

      wait;
   end process;

END;
