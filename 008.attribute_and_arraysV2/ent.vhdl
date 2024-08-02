library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity ent is
    port(
        clk : in std_logic;
        inpa : in enc_t;
        inpb : in enc_t;
        outp : out enc_array_t(1 downto 0)
    );
end entity ent;

architecture behave of ent is
    signal arr:enc_array_t(1 downto 0);
begin
    proc:process(clk)
    begin
        if rising_edge(clk) then
            arr(0) <= inpa;
            arr(1) <= inpb;
            outp <= arr;
        end if;
    end process proc;
end architecture;
