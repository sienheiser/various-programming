library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rgb is
    port(
        inp : in std_logic_vector(2 downto 0);
        clk : in std_logic;
        r : out std_logic;
        g : out std_logic;
        b : out std_logic
    );
end entity rgb;

architecture arch of rgb is
begin
    proc: process(clk)
    begin
        if rising_edge(clk) then
            case inp is
                when "100" =>
                    r <= '1';
                    g <= '0';
                    b <= '0';
                when "010" =>
                    r <= '0';
                    g <= '1';
                    b <= '0';
                when "001" =>
                    r <= '0';
                    g <= '0';
                    b <= '1';
                when others =>
                    r <= '0';
                    g <= '0';
                    b <= '0';
            end case;
        end if;
    end process proc;
end architecture arch; -- arch
