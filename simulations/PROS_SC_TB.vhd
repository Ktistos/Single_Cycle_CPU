library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PROC_SC_tb is
end;

architecture bench of PROC_SC_tb is

  component PROC_SC
   Port (
         Reset : in std_logic;
         clk: in std_logic
    );
  end component;


signal Reset: std_logic;
signal clk: std_logic ;

constant Clk_period : time := 100 ns;


begin

  uut: PROC_SC port map ( Reset => Reset,
                          clk   => clk );
                          
                          
                          -- Clock process definitions
   Clk_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

  stimulus: process
  begin
  
    wait for 100ns;
  
    Reset<='1';
    wait for clk_period*5;
    
    Reset<='0';

    wait;
  end process;


end;
