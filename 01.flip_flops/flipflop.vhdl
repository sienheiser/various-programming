library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflop is
    port(
        clk : in std_logic;
        D : in std_logic;
        Q : out std_logic
    );
end entity flipflop;

architecture Behavioral of flipflop is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            Q <= D;
        end if;
    end process;
end architecture Behavioral;
