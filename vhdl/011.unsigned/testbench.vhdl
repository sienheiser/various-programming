library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture behave of testbench is
    signal inpa_tb: std_logic_vector(2 downto 0) := (others => '0');
    signal inpb_tb: std_logic_vector(2 downto 0) := (others => '0');
    signal clk_tb: std_logic := '0';
    signal rst_tb: std_logic := '0';
    signal us1_tb: unsigned(2 downto 0) := (others => '0');

    component ent is
        port(
            clk: in std_logic;
            rst: in std_logic;
            inpa: in std_logic_vector(2 downto 0);
            inpb: in std_logic_vector(2 downto 0);
            outp: out unsigned(2 downto 0)
        );
    end component ent;
begin
    ent_INST: ent 
        port map(
            clk => clk_tb,
            rst => rst_tb,
            inpa => inpa_tb,
            inpb => inpb_tb,
            outp => us1_tb
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
    stimulus_process: process is
    begin
        rst_tb <= '0';
        wait for 4 ns;
        rst_tb <= '1';
        inpa_tb <= "000";
        inpb_tb <= "001";
        wait for 2.1 ns;
        assert us1_tb = "001" report "Test case 1 failed" severity error;
        wait;
    end process stimulus_process;
end architecture behave;
