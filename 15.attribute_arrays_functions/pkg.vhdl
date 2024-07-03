library ieee;
use ieee.std_logic_1164.all;

package pkg is 
    constant ENC_LENGTH_T: positive := 2;
    attribute enum_enc: string;
    type enc_t is (Hello, Bye, Unknown);
    attribute enum_enc of enc_t: type is ("00 01 10");
    type enc_array_t  is array(integer range <>) of enc_t;

    function gen_array(array_length: positive) return enc_array_t;
end package pkg;

package body pkg is 
    function gen_array(array_length: positive) return enc_array_t is
        variable v: enc_array_t(array_length-1 downto 0);
    begin
        for i in 0 to array_length - 1 loop
            v(i) := Bye;
        end loop;
        return v;
    end function gen_array;
end package body pkg;
