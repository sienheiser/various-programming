library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity channel is
  port(
    i_clk: in std_logic;
    i_rst: in std_logic;

    i_wr_en: in std_logic;
    i_wr_data: in std_logic_vector(31 downto 0);

    i_rd_en: in std_logic;
    o_rd_data: out std_logic_vector(31 downto 0)
  );
end entity channel;

architecture behave of channel is
  signal data : std_logic_vector(31 downto 0) := (others => '0');
  signal rdy: std_logic := '0';
  signal ack: std_logic := '0';
begin
  cpy_data : process(i_clk)
  begin
    if rising_edge(i_clk) then
      if i_rst = '1' then
        data <= (others => '0');
        rdy  <= '0';
      elsif (rdy = ack) and (i_wr_en = '1') and (i_rd_en = '0') then
        data <= i_wr_data;
        rdy  <= not rdy;
      end if;
    end if;
  end process cpy_data;

  output_data : process(i_clk)
  begin
    if rising_edge(i_clk) then
      if i_rst = '1' then
        ack       <= '0';
        o_rd_data <= (others => '0');
      elsif (rdy /= ack) and (i_rd_en = '1') and (i_wr_en = '0') then
        o_rd_data <= data;
        ack       <= not ack;
      end if;
    end if;
  end process output_data;
end architecture behave;