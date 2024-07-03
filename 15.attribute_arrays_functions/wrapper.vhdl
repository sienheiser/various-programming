library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity wrapper is 
    port(
        clk_wr: in std_logic;
        out1_wr: out enc_t;
        out2_wr: out enc_t
    );
end entity wrapper;

architecture behaviour of wrapper is
    constant arr_length_wr: positive := 3;

    signal outp_wr: enc_array_t(arr_length_wr-1 downto 0);
    component ent is 
        generic(
            array_length: positive := 3
        );
        port(
            clk: in std_logic;
            outp: out enc_array_t(array_length - 1 downto 0)
        );
    end component ent;
begin
    ent_INST: ent 
        generic map(
            array_length => arr_length_wr
        )
        port map (
            clk => clk_wr,
            outp => outp_wr
        );
    proc: process(clk_wr) is 
    begin
        if rising_edge(clk_wr) then 
            out1_wr <= outp_wr(0);
            out2_wr <= outp_wr(1);
        end if;
    end process proc;
end architecture behaviour;
