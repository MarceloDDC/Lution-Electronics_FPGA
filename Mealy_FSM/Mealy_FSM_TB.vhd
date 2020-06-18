--------------------------------------------------------------------------------
--  Name:	Mealy_FSM_TB.vhd
--  Dependencies: Mealy_FSM.vhd
--  Design Software:	Vivado 2018.3
--  Engineer: Marcelo Delgado
--  Explanation video: https://www.youtube.com/watch?v=wGUggIjnRyo
--
--  Description:
--  Mealy FSM Testbench
--
--  Version History:
--  1.0 - 18/06/2020 Marcelo Delgado
--    Initial Public Release
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Mealy_FSM_TB is
end;

architecture bench of Mealy_FSM_TB is

  component Mealy_FSM
     port (X,CLK : in std_logic ;
           RESET : in std_logic ;
           Z1 ,Z2 : out std_logic );
  end component;

  signal X,RESET,CLK: std_logic;
  signal Z1,Z2: std_logic;
  
  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Mealy_FSM port map ( X       => X,
                            CLK     => CLK,
                            RESET   => RESET,
                            Z1       => Z1,
                            Z2       => Z2 );

  stimulus: process
  begin
  
    RESET <= '0';
 
    X <= '1';
    
    wait for 20ns;
    
    RESET <= '1';

    wait;
  end process;
  
  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
