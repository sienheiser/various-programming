library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pkg.all;

entity testbench is 
end entity testbench;

architecture behave of testbench is
    signal clk_tb: std_logic;
    signal inp_tb: enc_array_t(1 downto 0);
    signal outp_tb: std_logic_vector(3 downto 0);

    signal inp_tb2: std_logic_vector(3 downto 0);
    signal outp_tb2: enc_array_t(1 downto 0);

    component ent is 
    port(
        clk : in std_logic;
        inp : in enc_array_t(1 downto 0);
        outp: out std_logic_vector(3 downto 0)
    );
    end component ent;

    component ent2 is
        port(
            clk : in std_logic;
            inp : in std_logic_vector(3 downto 0);
            outp: out enc_array_t(1 downto 0)
        );
    end component ent2;

begin
    ent_INST: ent 
    port map(
        clk => clk_tb,
        inp => inp_tb,
        outp => outp_tb
    );

    ent2_INST: ent2
    port map(
        clk => clk_tb,
        inp => inp_tb2,
        outp => outp_tb2
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

    stimulus1:process
    begin
        inp_tb(0) <= Bye;
        inp_tb(1) <= Bye;
        wait for 2 ns;
        assert inp_tb(0) = Bye report "Test case 1" severity error;
        assert inp_tb(1) = Bye report "Test case 2" severity error;

        wait for 2.1 ns;
        assert outp_tb = "0101" report "Test case 3" severity error;
        wait;
    end process stimulus1;

    stimulus2:process
    begin
        inp_tb2 <= "0101";
        wait for 2 ns;
        wait for 2.1 ns;
        assert outp_tb2(0) = Bye report "ent2 test case 1" severity error;
        assert outp_tb2(1) = Bye report "ent2 test case 2" severity error;
        wait;
    end process stimulus2;
end architecture behave;
