
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY mux_tb IS
END mux_tb;
 
ARCHITECTURE behavior OF mux_tb IS 
 
 
    COMPONENT MUX32to5
    PORT(
         Dout0 : IN  std_logic_vector(31 downto 0);
         Dout1 : IN  std_logic_vector(31 downto 0);
         Dout2 : IN  std_logic_vector(31 downto 0);
         Dout3 : IN  std_logic_vector(31 downto 0);
         Dout4 : IN  std_logic_vector(31 downto 0);
         Dout5 : IN  std_logic_vector(31 downto 0);
         Dout6 : IN  std_logic_vector(31 downto 0);
         Dout7 : IN  std_logic_vector(31 downto 0);
         Dout8 : IN  std_logic_vector(31 downto 0);
         Dout9 : IN  std_logic_vector(31 downto 0);
         Dout10 : IN  std_logic_vector(31 downto 0);
         Dout11 : IN  std_logic_vector(31 downto 0);
         Dout12 : IN  std_logic_vector(31 downto 0);
         Dout13 : IN  std_logic_vector(31 downto 0);
         Dout14 : IN  std_logic_vector(31 downto 0);
         Dout15 : IN  std_logic_vector(31 downto 0);
         Dout16 : IN  std_logic_vector(31 downto 0);
         Dout17 : IN  std_logic_vector(31 downto 0);
         Dout18 : IN  std_logic_vector(31 downto 0);
         Dout19 : IN  std_logic_vector(31 downto 0);
         Dout20 : IN  std_logic_vector(31 downto 0);
         Dout21 : IN  std_logic_vector(31 downto 0);
         Dout22 : IN  std_logic_vector(31 downto 0);
         Dout23 : IN  std_logic_vector(31 downto 0);
         Dout24 : IN  std_logic_vector(31 downto 0);
         Dout25 : IN  std_logic_vector(31 downto 0);
         Dout26 : IN  std_logic_vector(31 downto 0);
         Dout27 : IN  std_logic_vector(31 downto 0);
         Dout28 : IN  std_logic_vector(31 downto 0);
         Dout29 : IN  std_logic_vector(31 downto 0);
         Dout30 : IN  std_logic_vector(31 downto 0);
         Dout31 : IN  std_logic_vector(31 downto 0);
         Ard : IN  std_logic_vector(4 downto 0);
         DataOUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Dout0 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout2 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout3 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout4 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout5 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout6 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout7 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout8 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout9 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout10 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout11 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout12 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout13 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout14 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout15 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout16 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout17 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout18 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout19 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout20 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout21 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout22 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout23 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout24 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout25 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout26 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout27 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout28 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout29 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout30 : std_logic_vector(31 downto 0) := (others => '0');
   signal Dout31 : std_logic_vector(31 downto 0) := (others => '0');
   signal Ard : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal DataOUT : std_logic_vector(31 downto 0);  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX32to5 PORT MAP (
          Dout0 => Dout0,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Dout3 => Dout3,
          Dout4 => Dout4,
          Dout5 => Dout5,
          Dout6 => Dout6,
          Dout7 => Dout7,
          Dout8 => Dout8,
          Dout9 => Dout9,
          Dout10 => Dout10,
          Dout11 => Dout11,
          Dout12 => Dout12,
          Dout13 => Dout13,
          Dout14 => Dout14,
          Dout15 => Dout15,
          Dout16 => Dout16,
          Dout17 => Dout17,
          Dout18 => Dout18,
          Dout19 => Dout19,
          Dout20 => Dout20,
          Dout21 => Dout21,
          Dout22 => Dout22,
          Dout23 => Dout23,
          Dout24 => Dout24,
          Dout25 => Dout25,
          Dout26 => Dout26,
          Dout27 => Dout27,
          Dout28 => Dout28,
          Dout29 => Dout29,
          Dout30 => Dout30,
          Dout31 => Dout31,
          Ard => Ard,
          DataOUT => DataOUT
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
--checking whether the multiplexer can provide all the possible outputs based on the Ard input
        Dout0<="00000000000000000000000000000000";
	Dout1<="00000000000000000000000000000001";
	Dout2<="00000000000000000000000000000010";
	Dout3<="00000000000000000000000000000011";
	Dout4<="00000000000000000000000000000100";
	Dout5<="00000000000000000000000000000101";
	Dout6<="00000000000000000000000000000110";
	Dout7<="00000000000000000000000000000111";
	Dout8<="00000000000000000000000000001000";
	Dout9<="00000000000000000000000000001001";
	Dout10<="00000000000000000000000000001010";
	Dout11<="00000000000000000000000000001011";
	Dout12<="00000000000000000000000000001100";
	Dout13<="00000000000000000000000000001101";
	Dout14<="00000000000000000000000000001110";
	Dout15<="00000000000000000000000000001111";
	Dout16<="00000000000000000000000000010000";
	Dout17<="00000000000000000000000000010001";
	Dout18<="00000000000000000000000000010010";
	Dout19<="00000000000000000000000000010011";
	Dout20<="00000000000000000000000000010100";
	Dout21<="00000000000000000000000000010101";
	Dout22<="00000000000000000000000000010110";
	Dout23<="00000000000000000000000000010111";
	Dout24<="00000000000000000000000000011000";
	Dout25<="00000000000000000000000000011001";
	Dout26<="00000000000000000000000000011010";
	Dout27<="00000000000000000000000000011011";
	Dout28<="00000000000000000000000000011100";
	Dout29<="00000000000000000000000000011101";
	Dout30<="00000000000000000000000000011110";
	Dout31<="00000000000000000000000000011111";

	wait for 25ns;

	Ard<="00000";

	wait for 25ns;

	Ard<="00001";

	wait for 25ns;

	Ard<="00010";

	wait for 25ns;

	Ard<="00011";

	wait for 25ns;

	Ard<="00100";

	wait for 25ns;

	Ard<="00101";

	wait for 25ns;

	Ard<="00110";

	wait for 25ns;

	Ard<="00111";

	wait for 25ns;

	Ard<="01000";

	wait for 25ns;

	Ard<="01001";

	wait for 25ns;

	Ard<="01010";

	wait for 25ns;

	Ard<="01011";

	wait for 25ns;

	Ard<="01100";

	wait for 25ns;

	Ard<="01101";

	wait for 25ns;

	Ard<="01110";

	wait for 25ns;

	Ard<="01111";

	wait for 25ns;

	Ard<="10000";

	wait for 25ns;

	Ard<="10001";

	wait for 25ns;

	Ard<="10010";

	wait for 25ns;

	Ard<="10011";

	wait for 25ns;

	Ard<="10100";

	wait for 25ns;

	Ard<="10101";

	wait for 25ns;

	Ard<="10110";

	wait for 25ns;

	Ard<="10111";

	wait for 25ns;

	Ard<="11000";

	wait for 25ns;

	Ard<="11001";

	wait for 25ns;

	Ard<="11010";

	wait for 25ns;

	Ard<="11011";

	wait for 25ns;

	Ard<="11100";

	wait for 25ns;

	Ard<="11101";

	wait for 25ns;

	Ard<="11110";

	wait for 25ns;

	Ard<="11111";


      wait;
   end process;

END;
