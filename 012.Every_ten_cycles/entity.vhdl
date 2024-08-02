library ieee;
use ieee.std_logic_1164.all;

entity ent is
    port(
        clk: in std_logic;
        outp: out std_logic
    );
end entity ent;

architecture behaviour of ent is 
    signal index: integer := 0;
begin
    counting_process:process(clk) is
    begin
        if rising_edge(clk) then
            if index < 9 then
                index <= index + 1;
            else
                index <= 0;
            end if;
        end if;
    end process counting_process;

    outp <= '1' when index = 9 else '0';
end architecture behaviour;

