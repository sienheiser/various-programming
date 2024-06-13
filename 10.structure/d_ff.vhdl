library ieee;
use ieee.std_logic_1164.all;

entity d_ff is
    port(d,en,clk : in std_logic;
         q : out std_logic);
end entity d_ff;

architecture behaviour of d_ff is
begin
    proc: process(clk) is
    begin
        if rising_edge(clk) then
            q <= d;
        end if;
    end process;
end architecture behaviour;

