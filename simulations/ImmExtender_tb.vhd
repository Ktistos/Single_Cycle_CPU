--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:43:32 03/18/2020
-- Design Name:   
-- Module Name:   /home/dbanelas/Documents/14.7/ISE_DS/CPU_wannabe/ImmExtender_tb.vhd
-- Project Name:  CPU_wannabe
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ImmExtender
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
 
ENTITY ImmExtender_tb IS
END ImmExtender_tb;
 
ARCHITECTURE behavior OF ImmExtender_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ImmExtender
    PORT(
         ImmIn : IN  std_logic_vector(15 downto 0);
         ExtOp : IN  std_logic_vector(1 downto 0);
         ImmOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ImmIn : std_logic_vector(15 downto 0) := (others => '0');
   signal ExtOp : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal ImmOut : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ImmExtender PORT MAP (
          ImmIn => ImmIn,
          ExtOp => ExtOp,
          ImmOut => ImmOut
        );

   -- Clock process definitions
   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      --checking zero filling for a negative number
      ImmIn<=x"f000";
      ExtOp<="00";
      --checking zero filling for a positive number
      wait for 100ns;
      ImmIn<=x"0001";
      --checking sign extention for a negative number
      wait for 100ns;
      ImmIn<=x"f000";
      ExtOp<="01";
      --checking sign extension for a positive number
      wait for 100ns;
      ImmIn<=x"000a";
      --sign extension and left shifting 
      wait for 100ns;
      ExtOp<="10";
      ImmIn<=x"ffff";
      --shifting left by 16 bits(for lui)
      wait for 100ns;
      ExtOp<="11";
      ImmIn<=x"aaaa";
      

      -- insert stimulus here 

      wait;
   end process;

END;
