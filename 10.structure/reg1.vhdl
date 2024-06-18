library ieee;
use ieee.std_logic_1164.all;

entity reg1 is
    port(
        d0,en,clk: in std_logic;
        q0: out std_logic
    );
end entity reg1;

architecture structure of reg1 is
    signal int_clk: std_logic;
    component d_ff is
        port(
            d,clk: in std_logic;
            q: out std_logic
        );
    end component d_ff;
    component and2 is
        port(
            a,b: in std_logic;
            y: out std_logic
        );
    end component and2;
begin
    bit0: d_ff
        port map(
            d => d0,
            q => q0,
            clk => int_clk
        );
    gate: and2
        port map(
            a => clk,
            b => en,
            y => int_clk
        );

end architecture structure;

