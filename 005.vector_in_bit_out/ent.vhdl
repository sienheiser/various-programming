library ieee;
use ieee.std_logic_1164.all;

entity ent is
    port(
        clk: in std_logic;
        inp: in std_logic_vector(7 downto 0);
        outp: out std_logic
    );
end entity ent;

architecture behav of ent is
begin
    proc:process(clk) is
    begin
        if rising_edge(clk) then
            outp <= inp(7);
        end if;
    end process proc;
end architecture behav;
