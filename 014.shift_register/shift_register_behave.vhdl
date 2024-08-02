library ieee;
use ieee.std_logic_1164.all;

entity sr is 
    port(
        i_clk: in std_logic;
        i_d: in std_logic;
        o_q: out std_logic
    );
end entity sr;

architecture behave of sr is 
    signal shift: std_logic_vector(3 downto 0);
begin
    process(i_clk) is
    begin
        if rising_edge(i_clk) then
            shift(3 downto 1) <= shift(2 downto 0);
            shift(0) <= i_d;
        end if;
    end process;
    o_q <= shift(3);
end architecture behave;
