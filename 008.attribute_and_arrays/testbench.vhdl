library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity testbench is 
end entity testbench;

architecture behave of testbench is
    signal clk_tb: std_logic;
    signal inpa_tb: enc_t;
    signal inpb_tb: enc_t;
    signal outp_tb: enc_array_t(1 downto 0);

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
        clk => clk_tb,
        inpa => inpa_tb,
        inpb => inpb_tb,
        outp => outp_tb
    );
    
    clock:process
    begin
        while true loop
            clk_tb <= '1';
            wait for 1 ns;
            clk_tb <= '0';
            wait for 1 ns;
        end loop;
    end process clock;

    stimulus:process
    begin
        inpa_tb <= Bye;
        inpb_tb <= Bye;
        wait for 2 ns;
        assert inpa_tb = Bye report "Test case 1" severity error;
        assert inpb_tb = Bye report "Test case 2" severity error;

        wait for 2.1 ns;
        assert outp_tb(0) = Bye report "Test case 3" severity error;
        assert outp_tb(1) = Bye report "Test case 4" severity error;


        wait;
    end process stimulus;
end architecture behave;
