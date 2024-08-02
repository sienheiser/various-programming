library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench is
end entity test_bench;

architecture behave of test_bench is
    signal D_tb : std_logic := '0';
    signal clk : std_logic;
    signal Q_tb : std_logic;

    component flipflop is
        port(
            clk : in std_logic;
            D : in std_logic;
            Q : out std_logic
        );
    end component flipflop;

begin
    flipflop_INST : flipflop
        port map (
            D => D_tb,
            clk => clk,
            Q => Q_tb
        );

    clock_process : process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process clock_process;

    stimulus_process : process is
    begin
        -- Initial value
        D_tb <= '0';
        wait for 20 ns;

        D_tb <= '1';
        wait for 20 ns;
        assert Q_tb = '1' report "Test failed: Q_tb shoudl be '1'" severity error;
        wait;
    end process stimulus_process;

end architecture behave;
