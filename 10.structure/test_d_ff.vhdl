library ieee;
use ieee.std_logic_1164.all;

entity test_d_ff is
end entity test_d_ff;

architecture behave of test_d_ff is
    component d_ff is
        port(
            d,clk: in std_logic;
            q: out std_logic
        );
    end component d_ff;
    signal d_tb, clk_tb, q_tb: std_logic := '0';
begin
    bit0: d_ff
        port map(
            d => d_tb,
            clk => clk_tb,
            q => q_tb
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
        d_tb <= '0';
        wait for 4 ns;
        assert q_tb = '0' report "Test case 1" severity error;
        
        d_tb <= '1';
        wait for 1 ns;
        assert q_tb = '0' report "Test case 2" severity error;

        wait for 2 ns;
        assert q_tb = '1' report "Test case 3" severity error;

        wait;
    end process stimulus;
end architecture behave;
