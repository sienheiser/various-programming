library ieee;
use ieee.std_logic_1164.all;

entity reg1 is
    port(
        d0,en,clk : in std_logic;
        q0: out std_logic
    );
end entity reg1;


architecture structure of reg1 is
    component d_ff is
        port (
            d,en,clk : in std_logic;
            q : out std_logic
        );
    end component d_ff;
begin
    bit0: d_ff
        port map(
            d => d0,
            en => en,
            clk => clk,
            q => q0
        );
end architecture structure;
