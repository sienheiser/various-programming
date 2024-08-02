library ieee;
use ieee.std_logic_1164.all;

entity testbench is

end entity testbench;

architecture behave of testbench is 
    constant c_DEPTH: natural := 4;
    constant c_WIDTH: natural := 8;

    signal clk: std_logic;
    signal rst: std_logic;
    signal wr_en: std_logic;
    signal wr_data: std_logic_vector(c_WIDTH-1 downto 0);
    signal full: std_logic;

    component fifo is
        generic (
            g_WIDTH: natural := 8;
            g_DEPTH: natural := 32
        );
        port(
            i_clk: in std_logic;
            i_rst: in std_logic;

            i_wr_en: in std_logic;
            i_wr_data: in std_logic_vector(g_WIDTH-1 downto 0);
            o_full: out std_logic
        );
    end component fifo;
begin
    comp1: fifo
        generic map(
            g_WIDTH => c_WIDTH,
            g_DEPTH => c_DEPTH
        )
        port map(
            i_clk => clk,
            i_rst => rst,
            i_wr_en => wr_en,
            i_wr_data => wr_data,
            o_full => full
        );
    clock_process: process is
    begin
        clk <= '0';
        wait for 1 ns;
        clk <= '1';
        wait for 1 ns;
    end process clock_process;
    test: process is
    begin
        rst <= '1';
        wait for 2 ns;
        rst <= '0';
        wr_en <= '1';
        wait for 2 ns;
        wr_data <= "10101010";
        wait for 2 ns;
        wr_data <= "01010101";
        wait for 2 ns;
        wr_data <= "11011011";
        wait for 2 ns;
        wr_en <= '0';
        wait;
    end process test;
end architecture behave;
