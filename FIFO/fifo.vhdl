library ieee;
use ieee.std_logic_1164.all;


entity fifo is
    generic (
        g_WIDTH: natural := 32;
        g_DEPTH: natural := 8
    );

    port(
        clk: in std_logic;
        rst: in std_logic;

        i_wr_en: in std_logic;
        i_wr_q_en: in std_logic;
        i_rd_q_en: in std_logic;
        i_rd_en: in std_logic;
        i_wr_data: in std_logic_vector(g_WIDTH - 1 downto 0);

        o_rd_data: out std_logic_vector(g_WIDTH - 1 downto 0);
        o_full: out std_logic;
        o_empty: out std_logic
    );
end entity fifo;

architecture behaviour of fifo is
    type t_data is array(0 to g_DEPTH-1) of std_logic_vector(g_WIDTH-1 downto 0);
    signal fifo_data: t_data := (others => (others => '0'));
    signal full: std_logic := '0';
    signal empty: std_logic := '0';
    signal count_fifo: integer range 0 to g_DEPTH-1 := 0;
    signal wr_index: integer range 0 to g_DEPTH-1 := g_DEPTH - 1;
    signal rd_q_en: std_logic := '1';


    signal interface_data_1: std_logic_vector(g_WIDTH - 1 downto 0) := (others => '0');
    signal interface_data_2: std_logic_vector(g_WIDTH - 1 downto 0) := (others => '0');

    component channel is
        port(
            i_clk: in std_logic;
            i_rst: in std_logic;

            i_wr_en: in std_logic;
            i_wr_data: in std_logic_vector(g_WIDTH - 1 downto 0);

            i_rd_en: in std_logic;
            o_rd_data: out std_logic_vector(g_WIDTH - 1 downto 0)
        );
    end component channel;
begin
    async_interface_1: channel
        port map(
            i_clk => clk,
            i_rst => rst,
            i_wr_en => i_wr_en,
            i_rd_en => i_wr_q_en,
            i_wr_data => i_wr_data,
            o_rd_data => interface_data_1
        );

    async_interface_2: channel
        port map(
            i_clk => clk,
            i_rst => rst,
            i_wr_en => i_rd_q_en,
            i_rd_en => i_rd_en,
            i_wr_data => interface_data_2,
            o_rd_data => o_rd_data
        );

    proc: process(clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                wr_index <= g_DEPTH - 1;
                count_fifo <= 0;
            else
                if (i_wr_en = '0') and (i_wr_q_en = '1') and (full = '0') then
                    fifo_data(wr_index) <= interface_data_1;
                    wr_index <= wr_index - 1;
                    count_fifo <= count_fifo + 1;
                end if;
                if (rd_q_en = '1') and (i_rd_en = '0') and (empty = '0') then
                    wr_index <= wr_index + 1;
                    count_fifo <= count_fifo - 1;
                    interface_data_2 <= fifo_data(wr_index);
                    rd_q_en <= '0';
                end if;
            end if;
        end if;
    end process proc;

    full <= '1' when count_fifo = g_DEPTH-1 else '0';
    o_full <= full;
    
    empty <= '1' when count_fifo = 0 else '0';
    o_empty <= empty;
end architecture behaviour;