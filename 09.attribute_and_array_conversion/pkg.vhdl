library ieee;
use ieee.std_logic_1164.all;

package pkg is
    constant ENC_T_LEN: Natural := 2;
    attribute enum_enc: string;
    type enc_t is (Hello, Bye, Unknown);
    attribute enum_enc of enc_t: type is ("00 01 10");
    type enc_array_t is array(integer range <>) of enc_t;

    -- function from_vec_to_enc_t(vec : std_logic_vector) return enc_t;
    -- function from_enc_t_to_vec(sig: enc_t) return std_logic_vector;
    -- function from_vec_to_enc_array_t(vec: std_logic_vector) return enc_array_t;
    -- function from_enc_array_t_to_vec(arr: enc_array_t) return std_logic_vector;
end package pkg;

-- package body pkg is
--     function from_vec_to_enc_t(vec:std_logic_vector) return enc_t is
--         variable ret: enc_t;
--         variable tmp: std_logic_vector(ENC_T_LEN-1 downto 0);
--     begin
--         tmp := vec;
--         case tmp is
--             when "00" => ret := Hello;
--             when "01" => ret := Bye;
--             when "10" => ret := Unknown;
--             when others => ret := Unknown;
--         end case;
--         return ret;
--     end function from_vec_to_enc_t;

--     function from_enc_t_to_vec(sig: enc_t) return std_logic_vector is
--         variable vec: std_logic_vector(ENC_T_LEN-1 downto 0);
--     begin
--         case sig is
--             when Hello => vec := "00";
--             when Bye => vec := "01";
--             when others => vec := "10";
--         end case;
--         return vec;
--     end function from_enc_t_to_vec;

--     function from_vec_to_enc_array_t(vec: std_logic_vector) return enc_array_t is
--         constant VEC_LEN: natural := vec'length;
--         constant ARR_LEN: natural := VEC_LEN/ENC_T_LEN;
--         variable arr: enc_array_t(ARR_LEN-1 downto 0);
--     begin
--         arr := (others => Hello);
--         for i in 0 to ARR_LEN -1 loop
--             arr(i) := from_vec_to_enc_t(vec((i+1)*ENC_T_LEN-1 downto (i*ENC_T_LEN))); 
--         end loop;
--         return arr;
--     end function from_vec_to_enc_array_t;

--     function from_enc_array_t_to_vec(arr: enc_array_t) return std_logic_vector is
--         constant ARR_LEN: natural := arr'length;
--         constant VEC_LEN: natural := ARR_LEN*2;
--         variable tmp: std_logic_vector(VEC_LEN-1 downto 0);
--     begin
--         tmp := (others => '0');
--         for i in 0 to ARR_LEN-1 loop
--             tmp((i+1)*ENC_T_LEN-1 downto i*ENC_T_LEN) := from_enc_t_to_vec(arr(i));
--         end loop;
--         return tmp;
--     end function from_enc_array_t_to_vec;
-- end package body pkg;
