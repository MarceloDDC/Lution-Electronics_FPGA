library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GP_register is
  port(SI : in std_logic;
       B : in std_logic_vector(3 downto 0);
       n_load, n_clear : in std_logic;
       clk : in std_logic;
       Q : out std_logic_vector(3 downto 0);
       SO : out std_logic );
end GP_register;

architecture Behavioral of GP_register is

signal Q_s : std_logic_vector(3 downto 0);

begin

   reg: process(clk,n_clear)
	begin
	   if (n_clear='0') then
	      Q_s <= "0000";
	   elsif (rising_edge(CLK)) then
	      if (n_load='0') then
	         Q_s <= B;
	      else
	         Q_s <= SI & Q_s(3 downto 1);
	      end if;
	   end if;
	end process;
	
	Q <= Q_s;
	SO <= Q_s(0);

end Behavioral;
