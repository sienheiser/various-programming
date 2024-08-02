library ieee;
use ieee.std_logic_1164.all;

entity testbench is 
end entity testbench;

architecture behave of testbench is
    signal clk_tb: std_logic := '0';
    signal d_tb: std_logic := '0';
    signal q_tb: std_logic;
    signal q1_tb:std_logic;
    component shift_register is 
        port(
            clk: in std_logic;
            d0: in std_logic;
            q_f: out std_logic
        );
    end component shift_register;
    component sr is 
        port(
            i_clk: in std_logic;
            i_d: in std_logic;
            o_q: out std_logic
        );
    end component sr;
begin
    sr0: shift_register
        port map (
            clk => clk_tb,
            d0 => d_tb,
            q_f => q_tb
        );    
    sr1: sr
        port map(
            i_clk => clk_tb,
            i_d => d_tb,
            o_q => q1_tb
        );
    clock_process:process is 
    begin
        clk_tb <= '1';
        wait for 1 ns;
        clk_tb <= '0';
        wait for 1 ns;
    end process clock_process;
    test:process is 
    begin
        d_tb <= '1';
        wait for 4 ns;
        wait;
    end process test;
end architecture behave;
