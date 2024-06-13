library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture behaviour of testbench is
    signal d0_tb,en_tb,clk_tb: std_logic;
    signal q0_tb: std_logic;
    
    component reg1 is
        port(
            d0,en,clk: in std_logic;
            q0: out std_logic
            );
    end component reg1;
begin
    reg1_INST: reg1
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

    stimulus_reg1: process is
    begin
        d0_tb <= '1';
        en_tb <= '1';

        wait for 8 ns;

        assert q0_tb = '1' report "Test case 1" severity error;
        wait;
    end process stimulus_reg1;
    

end architecture behaviour;
