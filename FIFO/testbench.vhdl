library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is 
end entity testbench;

architecture behave of testbench is
    signal inp_tb: std_logic_vector (31 downto 0);
    signal out_tb: std_logic_vector (31 downto 0);
    signal clk: std_logic;
    signal rst: std_logic;
    signal i_wr_en_tb: std_logic;
    signal i_rd_en_tb: std_logic;

    component channel is
        port(
            i_clk: in std_logic;
            i_rst: in std_logic;
            i_wr_data: in std_logic_vector (31 downto 0);
            i_wr_en: in std_logic;
            i_rd_en: in std_logic;
            o_rd_data: out std_logic_vector(31 downto 0)
        );
    end component channel;
begin
    channel_inst: channel
        port map (
            i_clk => clk,
            i_rst => rst,
            i_wr_data => inp_tb,
            i_wr_en => i_wr_en_tb,
            i_rd_en => i_rd_en_tb,
            o_rd_data => out_tb

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
            inp_tb <= "00000000000000000000000000000001";
            rst <= '0';
            i_wr_en_tb <= '1';
            i_rd_en_tb <= '0';
            wait for 10 ns;

            i_wr_en_tb <= '0';
            wait for 10 ns;

            i_rd_en_tb <= '1';
            wait for 10 ns;

            assert out_tb = "00000000000000000000000000000001" report "Test failed for case 1" severity error;
            wait;
        end process stimulus_process;

end architecture behave;