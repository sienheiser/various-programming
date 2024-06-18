library ieee;
use ieee.std_logic_1164.all;

entity testbench is 
end entity testbench;

architecture behaviour of testbench is 
    signal clk_tb: std_logic := '0';
    signal outp_tb: std_logic;
    component ent is 
        port(
            clk: in std_logic;
            outp: out std_logic
        );
    end component ent;
begin
    ent_instance: ent
        port map(
            clk => clk_tb,
            outp => outp_tb
        );
    
    clock_proc: process is
    begin
        clk_tb <= '0';
        wait for 1 ns;
        clk_tb <= '1';
        wait for 1 ns;
    end process clock_proc;
end architecture behaviour;
