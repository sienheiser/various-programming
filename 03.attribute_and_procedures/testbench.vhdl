library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;

entity test_bench is
end entity test_bench;

architecture behave of test_bench is
    signal clk_tb : std_logic;
    signal inp_tb : std_logic_vector(2 downto 0);
    signal enc_tb : opl_enc_t;
    
    component ent is
        port(clk: in std_logic;
             inp: in std_logic_vector(2 downto 0);
             enc: out opl_enc_t);
    end component ent;
begin
    ent_INST: ent
        port map (
            clk => clk_tb,
            inp => inp_tb,
            enc => enc_tb
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
        inp_tb <= "001";
        assert enc_tb = S_OK report "Test Case 1 failed" severity error;

        wait;
    end process stimulus_process;
end architecture behave;

