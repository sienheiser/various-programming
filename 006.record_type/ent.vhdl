library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity ent is
  port (
    clk: in std_logic;
    inp: in std_logic_vector(7 downto 0);
    outp: out typ
  ) ;
end entity ent;

architecture behave of ent is
begin
    map_8_to_typ_proc:process(clk) is
    begin
        if rising_edge(clk) then 
            map_8_to_typ(inp,outp);
        end if;
    end process map_8_to_typ_proc;
end architecture behave;
