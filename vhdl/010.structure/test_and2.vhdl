library ieee;
use ieee.std_logic_1164.all;

entity test_and2 is
end entity test_and2;

architecture behave of test_and2 is
    component and2 is
        port(
            a,b: in std_logic;
            y: out std_logic
        );
    end component and2;

    signal clk_tb,b_tb: std_logic;
    signal y_tb: std_logic;
begin
    gate: and2
        port map(
            a => clk_tb,
            b => b_tb,
            y => y_tb
        );
    clock: process is
    begin
        clk_tb <= '0';
        wait for 1 ns;
        clk_tb <= '1';
        wait for 1 ns;
    end process clock;
    stimulus: process is 
    begin 
        b_tb <= '0';
        wait for 4 ns;
        b_tb <= '1';
        wait for 4 ns;
        wait;
    end process stimulus;
end architecture behave;

