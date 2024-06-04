library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture behav of testbench is
    signal clk_tb : std_logic;
    signal inp_tb : std_logic_vector(7 downto 0);
    signal outp_tb : std_logic;


    component ent is 
        port(
            clk: in std_logic;
            inp: in std_logic_vector(7 downto 0) ;
            outp: out std_logic
        );
    end component ent;
begin
    ent_inst: ent 
        port map(
            clk => clk_tb,
            inp => inp_tb,
            outp => outp_tb
        );

    clock_process: process is
    begin
        while true loop
            clk_tb <= '0';
            wait for 1 ns;
            clk_tb <= '1';
            wait for 1 ns;
        end loop;
    end process clock_process;

    stimulate: process is
    begin
        inp_tb <= "10000000";
        wait for 2 ns;
        assert outp_tb = '1' report "Test case 0 failed" severity error;
        wait;
    end process stimulate;
end architecture behav;
