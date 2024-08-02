library ieee;
use ieee.std_logic_1164.all;

library work;
use work.pkg.all;


entity testbench is 
end entity testbench;

architecture behavior of testbench is
    signal clk_tb: std_logic;
    signal rst_tb: std_logic;
    signal inp_tb: char;
    signal outp_tb: std_logic;
begin
    ent_inst: entity work.reg(behavior) 
        port map (
            clk => clk_tb,
            rst => rst_tb,
            inp => inp_tb,
            outp => outp_tb
        );
    
    proc_clock: process
    begin
        clk_tb <= '0';
        wait for 2 ns;
        clk_tb <= '1';
        wait for 2 ns;
    end process proc_clock;

    test: process
    begin
        inp_tb <= a;
        wait for 4.1 ns;
        assert outp_tb = '1' report "Test case 1" severity error;

        inp_tb <= b;
        wait for 4.1 ns;
        assert outp_tb = '0' report "Test case 2" severity error;

        inp_tb <= c;
        wait for 4.1 ns;
        assert outp_tb = '0' report "Test case 3" severity error;

        inp_tb <= d;
        wait for 4.1 ns;
        assert outp_tb = '0' report "Test case 4" severity error;

        wait;
    end process test;
end architecture behavior;
