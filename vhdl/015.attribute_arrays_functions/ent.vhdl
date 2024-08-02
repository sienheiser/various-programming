library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity ent is 
    generic(
        array_length: positive := 3
    );
    port(
        clk: in std_logic;
        outp: out enc_array_t(array_length - 1 downto 0)
    );
end entity ent;

architecture behaviour of ent is 
begin
    proc: process(clk)
    begin
        if rising_edge(clk) then
            outp <= gen_array(array_length);
        end if;
    end process proc;
end architecture behaviour;
