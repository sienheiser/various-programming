library ieee;
use ieee.std_logic_1164.all;

package pkg is
    type char is (a,b,c,d);
    attribute ENUM_ENCODING : string;
    attribute ENUM_ENCODING of char: type is "00 01 10 11";
end package pkg;

