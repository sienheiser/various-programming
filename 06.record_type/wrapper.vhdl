library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity wrapper is
    port(
        inp_wr: in std_logic_vector(7 downto 0);
        clk_wr: in std_logic
    );
end entity wrapper;

architecture behave of wrapper is
    signal outp_wr: typ;
    signal field1: std_logic_vector(6 downto 0);
    signal field2: std_logic;

    component ent is
        port (
            clk: in std_logic;
            inp: in std_logic_vector(7 downto 0);
            outp: out typ
        ) ;
    end component ent;

begin

    ent_inst: ent 
        port map(
            clk => clk_wr,
            inp => inp_wr,
            outp => outp_wr
        );
    
    proc: process(clk_wr)
    begin

        if rising_edge(clk_wr) then
            field1 <= outp_wr.field1;
            field2 <= outp_wr.field2;
        end if;
            inp_wr.field1 <= field1;
    end process proc;


end architecture behave;
