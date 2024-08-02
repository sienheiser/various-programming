library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity wrapper is 
    port(
        signal clk_wr: std_logic
    );
end entity wrapper;

architecture behaviour of wrapper is
    signal inpa_wr:work.pkg.enc_t;
    signal inpb_wr:work.pkg.enc_t;
    signal outp_wr:work.pkg.enc_array_t(1 downto 0);
    signal out1_wr:work.pkg.enc_t;
    signal out2_wr:work.pkg.enc_t;

    component ent is 
        port(
            clk : in std_logic;
            inpa : in enc_t;
            inpb : in enc_t;
            outp : out enc_array_t(1 downto 0)
        );
    end component ent;
begin
    ent_INST: ent 
    port map(
        clk => clk_wr,
        inpa => inpa_wr,
        inpb => inpb_wr,
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
