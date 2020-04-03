--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:18:33 03/17/2020
-- Design Name:   
-- Module Name:   /home/dbanelas/Documents/14.7/ISE_DS/CPU_wannabe/RAM_tb.vhd
-- Project Name:  CPU_wannabe
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RAM
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
USE ieee.numeric_std.ALL;
 
ENTITY RAM_tb IS
END RAM_tb;
 
ARCHITECTURE behavior OF RAM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM
    PORT(
         clk : IN  std_logic;
         inst_addr : IN  std_logic_vector(10 downto 0);
         inst_dout : OUT  std_logic_vector(31 downto 0);
         data_we : IN  std_logic;
         data_addr : IN  std_logic_vector(10 downto 0);
         data_din : IN  std_logic_vector(31 downto 0);
         data_dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal inst_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_we : std_logic := '0';
   signal data_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_din : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal inst_dout : std_logic_vector(31 downto 0);
   signal data_dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM PORT MAP (
          clk => clk,
          inst_addr => inst_addr,
          inst_dout => inst_dout,
          data_we => data_we,
          data_addr => data_addr,
          data_din => data_din,
          data_dout => data_dout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
   
      wait for 100ns;

      --reading the first 31/2047 fields
      for I in 0 to 31 loop
            inst_addr<=std_logic_vector(to_unsigned(I,inst_addr'length));
            wait for clk_period;
      end loop;

      data_we<='1';
      wait for clk_period;
      --writing in the fields 1024-1030
      for Z in 1024 to 1030 loop
            data_addr<=std_logic_vector(to_unsigned(Z,data_addr'length));
            data_din<=std_logic_vector(to_unsigned(Z,data_din'length));
           wait for clk_period;
      end loop;
      
      for Z in 1498 to 1502 loop
            data_addr<=std_logic_vector(to_unsigned(Z,data_addr'length));
            data_din<=std_logic_vector(to_unsigned(Z,data_din'length));
           wait for clk_period;
      end loop;
      
      for Z in 2044 to 2047 loop
            data_addr<=std_logic_vector(to_unsigned(Z,data_addr'length));
            data_din<=std_logic_vector(to_unsigned(Z,data_din'length));
           wait for clk_period;
      end loop;
      
      data_we<='0';
      
      --trying to write with data_we='0' and then reading the address to confirm that nothing was written
      data_addr<="00000000001";
      data_din<=x"ffffffff";
      wait for clk_period;
      
      
      
      
      
      data_addr<=std_logic_vector(to_unsigned(1024,data_addr'length));
      wait for clk_period;
      
      
      data_addr<=std_logic_vector(to_unsigned(1500,data_addr'length));
      wait for clk_period;
      
      data_addr<=std_logic_vector(to_unsigned(2047,data_addr'length));
      wait for clk_period;
      
            

      -- insert stimulus here 

      wait;
   end process;

END;
