library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ent is
    port (clk: in std_logic;
          rst: in std_logic;
          inpa: in std_logic_vector(2 downto 0);
          inpb: in std_logic_vector(2 downto 0);
          outp: out unsigned(2 downto 0));
end entity ent;

architecture behave of ent is
    signal us1 : unsigned(2 downto 0) := (others => '0');
begin
    outp <= us1;
    proc: process(clk,rst)
    begin
        if rst = '0' then
            us1 <= (others => '0');
        elsif rising_edge(clk) then
            us1 <= unsigned(inpa)+unsigned(inpb);
        end if;
    end process proc;
end architecture behave;
