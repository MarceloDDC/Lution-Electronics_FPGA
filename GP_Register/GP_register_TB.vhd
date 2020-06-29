--------------------------------------------------------------------------------
--  Name: GP_register_TB.vhd
--  Dependencies: GP_register.vhd
--  Design Software: Vivado 2018.3
--  Engineer: Marcelo Delgado
--  Explanation video: https://www.youtube.com/watch?v=wGUggIjnRyo
--
--  Description:
--  Testbench file for general purpose register
--
--  Version History:
--  1.0 - 28/06/2020 Marcelo Delgado
--    Initial Public Release
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity GP_register_TB is
end;

architecture bench of GP_register_TB is

  component GP_register
    port(SI : in std_logic;
         B : in std_logic_vector(3 downto 0);
         n_load, n_clear : in std_logic;
         clk : in std_logic;
         Q : out std_logic_vector(3 downto 0);
         SO : out std_logic );
  end component;

  signal SI: std_logic;
  signal B: std_logic_vector(3 downto 0);
  signal n_load, n_clear: std_logic;
  signal clk: std_logic;
  signal Q: std_logic_vector(3 downto 0);
  signal SO: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean := FALSE;

begin

  uut: GP_register port map ( SI      => SI,
                              B       => B,
                              n_load  => n_load,
                              n_clear => n_clear,
                              clk     => clk,
                              Q       => Q,
                              SO      => SO );

  stimulus: process
  begin
  
    -- Initial values
    B <= "0000";
    n_load <= '1';
    n_clear <= '0';
    SI <= '1';
    
    wait for 20ns;
    
    -- Disable clear
    n_clear <= '1';
    
    wait for 50ns;
    
    -- Load 1010
    B <= "1010";
    n_load <= '0';
    wait for 20ns;
    n_load <= '1';
    
    wait;
    
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
