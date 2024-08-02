library ieee;
use ieee.std_logic_1164.all;

entity and2 is 
    port(
        a,b: in std_logic;
        y: out std_logic
    );
end entity and2;

architecture basic of and2 is
    signal sig: std_logic;
begin
    and2_behaviour: process is
    begin
       sig <= a and b; 
       y <= sig;
       wait on a,b;
    end process and2_behaviour;
end architecture basic;
