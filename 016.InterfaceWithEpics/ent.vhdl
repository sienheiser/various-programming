library ieee;
use ieee.std_logic_1164.all;

library work;
use work.pkg.all;

entity reg is
    port(
        clk : in std_logic;
        rst : in std_logic;
        inp : in char;
        outp: out std_logic
    );
end entity reg;


architecture behavior of reg is 
begin
    proc: process(clk)
    begin
        if rising_edge(clk) then
            if inp = a then
                outp <= '1'; 
            else
                outp <= '0';
            end if;
        end if;
    end process proc;
end architecture behavior;

