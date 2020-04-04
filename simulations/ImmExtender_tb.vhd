
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
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
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ImmExtender PORT MAP (
          ImmIn => ImmIn,
          ExtOp => ExtOp,
          ImmOut => ImmOut
        );


   --Testing all possible extender operations
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
