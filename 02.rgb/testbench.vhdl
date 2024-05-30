library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench is
end entity test_bench;

architecture behave of test_bench is
    signal inp_tb: std_logic_vector (2 downto 0);
    signal clk : std_logic;
    signal r_tb : std_logic;
    signal g_tb : std_logic;
    signal b_tb : std_logic;

    component rgb is 
        port(
            inp : in std_logic_vector(2 downto 0);
            clk : in std_logic;
            r : out std_logic;
            g : out std_logic;
            b : out std_logic
        );
    end component rgb;
begin
    rgb_INST : rgb
        port map (
            inp => inp_tb,
            clk => clk,
            r => r_tb,
            g => g_tb,
            b => b_tb
        );
    clock_process: process 
    begin
        while true loop
            clk <= '0';
            wait for 1 ns;
            clk <= '1';
            wait for 1 ns;
        end loop;
    end process clock_process;

    stimulus_process: process
    begin
        inp_tb <= "100";
        wait for 2 ns;
        assert r_tb = '1' and g_tb = '0' and b_tb = '0' report "Test failed for case 1" severity error;

        inp_tb <= "010";
        wait for 2 ns;
        assert r_tb = '0' and g_tb = '1' and b_tb = '0' report "Test failed for case 2" severity error;

        inp_tb <= "001";
        wait for 2 ns;
        assert r_tb = '0' and g_tb = '0' and b_tb = '1' report "Test failed for case 3" severity error;

        inp_tb <= "000";
        wait for 2 ns;
        assert r_tb = '0' and g_tb = '0' and b_tb = '0' report "Test failed for case 4" severity error;
        wait;
    end process stimulus_process;
end architecture behave;
