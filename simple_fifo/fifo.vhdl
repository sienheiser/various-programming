library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo is
    generic (
        g_WIDTH : natural := 32;
        g_DEPTH : natural := 8
    );
    port (
        i_clk   : in  std_logic;
        i_rst   : in  std_logic;
        i_store : in  std_logic;
        i_data  : in  std_logic_vector(g_WIDTH-1 downto 0);
        i_read  : in  std_logic;

        o_data  : out std_logic_vector(g_WIDTH-1 downto 0);
        o_full  : out std_logic;
        o_empty : out std_logic
    );
end entity;

architecture rtl of fifo is

    type t_mem is array (0 to g_DEPTH-1)
        of std_logic_vector(g_WIDTH-1 downto 0);

    signal mem: t_mem := (others => (others => '0'));

    signal wr_ptr: integer range 0 to g_DEPTH-1 := 0;
    signal rd_ptr: integer range 0 to g_DEPTH-1 := 0;

    signal count: integer range 0 to g_DEPTH := 0;

    signal data_out: std_logic_vector(g_WIDTH-1 downto 0);

    signal mem_dbg0: std_logic_vector(g_WIDTH-1 downto 0) := (others => '0');
    signal mem_dbg1: std_logic_vector(g_WIDTH-1 downto 0) := (others => '0');
    signal mem_dbg2: std_logic_vector(g_WIDTH-1 downto 0) := (others => '0');


begin

    process(i_clk)
    begin
        if rising_edge(i_clk) then

            -- write
            if i_rst = '1' then
                wr_ptr <= 0;
                rd_ptr <= 0;
                count <= 0;
            else
                if (i_store = '1') and (i_read = '0') and (count < g_DEPTH) then
                    mem(wr_ptr) <= i_data;

                    if wr_ptr = g_DEPTH-1 then
                        wr_ptr <= 0;
                    else
                        wr_ptr <= wr_ptr + 1;
                    end if;
                end if;

                -- read
                if (i_store = '0') and (i_read = '1') and (count > 0) then
                    data_out <= mem(rd_ptr);

                    if rd_ptr = g_DEPTH-1 then
                        rd_ptr <= 0;
                    else
                        rd_ptr <= rd_ptr + 1;
                    end if;
                end if;

                if (i_store = '1') and (i_read = '0') then
                    if count < g_DEPTH then
                        count <= count + 1;
                    end if;
                elsif (i_store = '0') and (i_read = '1') then
                    if count > 0 then
                        count <= count - 1;
                    end if;
                else
                    null;
                end if;
            end if;
        end if;
    end process;

    o_data  <= data_out;

    o_empty <= '1' when count = 0 else '0';
    o_full  <= '1' when count = g_DEPTH else '0';

    mem_dbg0 <= mem(0);
    mem_dbg1 <= mem(1);
    mem_dbg2 <= mem(2);

end architecture;