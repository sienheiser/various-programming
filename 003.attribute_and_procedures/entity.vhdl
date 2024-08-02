library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;

entity ent is
    port(
        clk : in std_logic;
        inp : in std_logic_vector(2 downto 0);
        enc : out opl_enc_t
    );
end entity ent;

architecture behav of ent is
begin
    process(clk) is
    begin
        if rising_edge(clk) then
            case inp is
                when "001" =>
                    enc <= S_OK;
                when "010" =>
                    enc <= S_BI;
                when "100" =>
                    enc <= S_RBI;
                when "111" =>
                    enc <= S_EBI;
                when others =>
                    enc <= S_EBI;
            end case;
        end if;
    end process;
end architecture behav;
