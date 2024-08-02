library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pkg is
    attribute opl_encoding : string; --! attribute definition
    attribute ENUM_ENCODING : string; --! attribute defintion for vivado
    type opl_enc_t is (S_OK, S_BI, S_RBI, S_EBI); --! opl signal encoding
    attribute ENUM_ENCODING of opl_enc_t : type is "001 010 100 111"; --! define vivado enumeration values
end package pkg;
