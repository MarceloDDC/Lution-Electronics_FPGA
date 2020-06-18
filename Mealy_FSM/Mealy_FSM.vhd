--------------------------------------------------------------------------------
--	Name:	Mealy_FSM.vhd
--	Dependencies: -
--	Design Software:	Vivado 2018.3
--    Engineer: Marcelo Delgado
--
--	Description:
--	Mealy FSM, state diagram in file "FSM_state_diagram.PNG"
--
--	Version History:
--	1.0 - 18/06/2020 Marcelo Delgado
--          Initial Public Release
--------------------------------------------------------------------------------

library IEEE ;
use IEEE.std_logic_1164.all;

entity Mealy_FSM is
port (X,CLK : in std_logic ;
      RESET : in std_logic ;
      Z1 ,Z2 : out std_logic );
end;

architecture Mealy_FSM_arch of Mealy_FSM is
   type state_type is (A,B,C);
   signal PS ,NS : state_type ;

begin

   sync_proc : process (CLK ,NS , RESET )
   begin
   
   if ( RESET = '0') then
      PS <= C;
   elsif ( rising_edge (CLK)) then
      PS <= NS;
   end if;
   
   end process sync_proc ;

   comb_proc : process (PS ,X)
   begin
      Z1 <= '0'; Z2 <= '0'; -- Valores preasignados
   case PS is
      when A =>
         Z1 <= '0'; -- Salida Moore
         if (X='0') then
            NS <= A;
            Z2 <= '1'; -- Salida Mealy
         else 
            NS <= B;
            Z2 <= '0'; -- Salida Mealy
         end if;
      when B =>
         Z1 <= '1'; -- Salida Moore
         if (X='0') then
            NS <= A;
            Z2 <= '0'; -- Salida Mealy
         else
            NS <= C;
            Z2 <= '1'; -- Salida Mealy
         end if;
      when C =>
         Z1 <= '1'; -- Salida Moore
         if (X='0') then 
            NS <= B;
            Z2 <= '1'; -- Salida Mealy
         else
            NS <= A;
            Z2 <= '0'; -- Salida Mealy
         end if;
      when others =>
         Z1 <= '1';
         NS <=A;
         Z2 <= '0';
      end case;
   end process comb_proc ;
  
end;
