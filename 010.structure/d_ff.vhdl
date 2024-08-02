library ieee;
use ieee.std_logic_1164.all;

entity d_ff is
    port(
        d, clk: in std_logic;
        q: out std_logic
    );
end entity d_ff;

architecture basic of d_ff is
begin
    process(clk) is
    begin
        if rising_edge(clk) then
            q <= d after 2 ns;
        end if;
    end process;
end architecture basic;
