library ieee;
use ieee.std_logic_1164.all;

package pkg is
    type typ is record
        field1 : std_logic_vector(6 downto 0);
        field2 : std_logic;
    end record typ;

    procedure map_8_to_typ(signal inp: in std_logic_vector(7 downto 0); signal typ1: out typ);
end package pkg;

package body pkg is
    procedure map_8_to_typ(signal inp: in std_logic_vector(7 downto 0); signal typ1: out typ) is
    begin
        typ1.field1 <= inp(6 downto 0);
        typ1.field2 <= inp(7);
    end procedure map_8_to_typ;
end package body pkg;
