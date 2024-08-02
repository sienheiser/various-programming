library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo is
    generic (
        g_WIDTH: natural := 8;
        g_DEPTH: natural := 32
    );
    port(
        i_clk: in std_logic;
        i_rst: in std_logic;

        --writing interface
        i_wr_en: in std_logic;
        i_wr_data: in std_logic_vector(g_WIDTH-1 downto 0);
        o_full: out std_logic

        --reading interface
        i_rd_en: in std_logic; 
        o_rd_data: out std_logic_vector(g_WIDTH-1 downto 0);
        o_empty: out std_logic; 
    );
end entity fifo;

architecture behave of fifo is
    type t_data is array(0 to g_DEPTH-1) of std_logic_vector(g_WIDTH-1 downto 0);
    signal fifo_data: t_data := (others => (others => '0'));
    signal full: std_logic := '0';
    signal count_fifo: integer range 0 to g_DEPTH-1 := 0;
    signal wr_index: integer range 0 to g_DEPTH-1 := 0;
begin
    proc:process(i_clk) is
    begin
        if rising_edge(i_clk) then
            if i_rst = '1' then
                full <= '0';
                count_fifo <= 0;
                wr_index <= 0;
            else
                --keep track of number of words in fifo buffer
                if i_wr_en = '1' then
                    count_fifo <= count_fifo+1;

                    if wr_index = g_DEPTH-1 then
                        wr_index <= 0;
                    else
                        wr_index <= wr_index + 1;
                    end if;
                end if;
                if (i_wr_en = '1' and full = '0') then
                    fifo_data(wr_index) <= i_wr_data;
                end if;
            end if;
        end if;
    end process proc;

    full <= '1' when count_fifo = g_DEPTH-1 else '0';
    o_full <= full;

end architecture behave;




