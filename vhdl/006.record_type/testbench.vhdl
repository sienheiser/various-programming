library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity testbench is
end entity testbench;

architecture behave of testbench is
    signal clk_tb: std_logic;
    signal inp_tb: std_logic_vector(7 downto 0);
    signal outp_tb: typ;

    component ent is
        port (
            clk: in std_logic;
            inp: in std_logic_vector(7 downto 0);
            outp: out typ
        ) ;
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

    stimulate_process: process is
    begin
        inp_tb <= "00000000";
        wait for 2 ns;
        assert outp_tb.field1 = "0000000" report "Test case 1 failed" severity error;
        assert outp_tb.field2 = '0' report "Test case 2 failed" severity error;

        inp_tb <= "10000000";
        wait for 2 ns;
        assert outp_tb.field1 = "0000000" report "Test case 3 failed" severity error;
        assert outp_tb.field2 = '1' report "Test 4 failed" severity error;

        wait;
    end process stimulate_process;
end architecture behave;
