library ieee;
use ieee.std_logic_1164.all;

entity test_reg1 is
end entity test_reg1;

architecture behave of test_reg1 is 
    component reg1 is
        port(
            d0,en,clk: in std_logic;
            q0: out std_logic
        );
    end component reg1;
    signal d0_tb, en_tb, clk_tb: std_logic := '0';
    signal q0_tb: std_logic;
begin
    reg: reg1
        port map(
            d0 => d0_tb,
            en => en_tb,
            clk => clk_tb,
            q0 => q0_tb
        );
    clock: process is
    begin
        while true loop
            clk_tb <= '0';
            wait for 1 ns;
            clk_tb <= '1';
            wait for 1 ns;
        end loop;
    end process clock;
    stimulus: process is
    begin
        d0_tb <= '0';
        en_tb <= '0';
        wait for 4 ns;

        en_tb <= '1';
        wait;
    end process stimulus;
end architecture behave;
