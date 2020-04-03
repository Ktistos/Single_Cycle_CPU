
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Register32bit is
    Port ( Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0);
           Clk : in STD_LOGIC;
           WE : in STD_LOGIC;
           RST : in std_logic);
end Register32bit;

architecture Behavioral of Register32bit is
signal t_out: std_logic_vector(31 downto 0);

begin

process
begin
	wait until Clk'EVENT AND Clk='1';
	
	if RST='1' then 
	   t_out<=x"00000000";
	elsif WE='1' then 
	   t_out<=Datain;
	else --keeps prev output
	   t_out<=t_out;
	end if;	
	
end process;
Dataout<=t_out after 10ns;
end Behavioral;
