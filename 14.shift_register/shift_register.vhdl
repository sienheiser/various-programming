library ieee;
use ieee.std_logic_1164.all;

entity shift_register is 
    port(
        clk: in std_logic;
        d0: in std_logic;
        q_f: out std_logic
    );
end entity shift_register;

architecture structure of shift_register is
    signal q0, q1, q2: std_logic;
    component d_ff is
        port(
            clk: in std_logic;
            d: in std_logic;
            q: out std_logic
        );
    end component d_ff;
begin
    s0: d_ff 
        port map(
            clk => clk,
            d => d0,
            q => q0
        );
    s1: d_ff 
        port map(
            clk => clk,
            d => q0,
            q => q1
        );
    s2: d_ff 
        port map(
            clk => clk,
            d => q1,
            q => q2
        );
    s3: d_ff 
        port map(
            clk => clk,
            d => q2,
            q => q_f
        );
end architecture structure;
