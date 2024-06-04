-- sample.vhd
library ieee;
use ieee.std_logic_1164.all;

package recordPkg is

    type myRecordT is record
        a : std_logic;
    end record myRecordT;

end package recordPkg;

library ieee;
use ieee.std_logic_1164.all;
use work.recordPkg.all;

entity sample is
    port(
        rec : in myRecordT
    );
end sample;

architecture structure of sample is
begin
end structure;
