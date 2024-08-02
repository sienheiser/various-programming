library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity ent is
    port(
        clk : in std_logic;
        inp : in enc_array_t(1 downto 0);
        outp: out std_logic_vector(3 downto 0)
    );
end entity ent;

architecture behave of ent is
begin
    proc:process(clk)
    begin
        if rising_edge(clk) then
            outp <= from_enc_array_t_to_vec(inp);
        end if;
    end process proc;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;
entity ent2 is
    port(
        clk : in std_logic;
        inp : in std_logic_vector(3 downto 0);
        outp: out enc_array_t(1 downto 0)
    );
end entity ent2;

architecture behave of ent2 is
begin
    proc:process(clk)
    begin
        if rising_edge(clk) then
            outp <= from_vec_to_enc_array_t(inp);
        end if;
    end process;
end architecture behave;
