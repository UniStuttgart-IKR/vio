--
-- VHDL Architecture riscvio_lib.alu.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 17:00:44 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee;
use ieee.numeric_std.all;
library riscvio_lib;
use riscvio_lib.isa.all;

ARCHITECTURE behav OF alu IS
BEGIN
    process(a, b, mode) is
        constant one: word_T := (0 => '1', others => '0');
        constant zeros: word_T := (others => '0');
        variable tmp: natural;
        variable tmp_b: byte_T;
        constant bytes_in_a: natural := a'length / BYTE_SIZE;
    BEGIN
        
        alu_out <= (others => '0');
        case mode is 
            when alu_add => 
                alu_out <= word_T(unsigned(a) + unsigned(b));
            when alu_sub => 
                alu_out <= word_T(unsigned(a) - unsigned(b));
            when alu_sll => 
                alu_out <= word_T(shift_left(unsigned(a), to_integer(unsigned(b))));
            when alu_slt => if signed(a) < signed(b) then alu_out <= one; else alu_out <= (others => '0'); end if;
            when alu_sltu => if unsigned(a) < unsigned(b) then alu_out <= one; else alu_out <= (others => '0'); end if;
            when alu_xor => alu_out <= a xor b;
            when alu_srl => 
                alu_out <= word_T(shift_right(unsigned(a), to_integer(unsigned(b))));
            when alu_sra => 
                alu_out <= word_T(shift_right(signed(a), to_integer(unsigned(b))));
            when alu_or => alu_out <= a or b;
            when alu_and => alu_out <= a and b;
            when alu_andn => alu_out <= a and not b;
            when alu_orn => alu_out <= a or not b;
            when alu_xnor => alu_out <= a xnor b;
            when alu_clz => 
                for i in a'high to a'low loop
                    if a(i) /= '0' then
                        alu_out <= word_T(to_unsigned(i, word_T'length));
                        exit;
                    end if;
                end loop;
            when alu_ctz => 
                for i in a'low to a'high loop
                    if a(i) /= '0' then
                        alu_out <= word_T(to_unsigned(i, word_T'length));
                        exit;
                    end if;
                end loop;
            when alu_cpop => 
                tmp := 0;
                for i in a'high to a'low loop
                    if a(i) = '1' then
                        tmp := tmp + 1;
                    end if;
                end loop;
                alu_out <= word_T(to_unsigned(tmp, word_T'length));
            when alu_max => if signed(a) > signed(b) then alu_out <= a; else alu_out <= b; end if;
            when alu_maxu => if unsigned(a) > unsigned(b) then alu_out <= a; else alu_out <= b; end if;
            when alu_min => if signed(a) < signed(b) then alu_out <= a; else alu_out <= b; end if;
            when alu_minu => if unsigned(a) < unsigned(b) then alu_out <= a; else alu_out <= b; end if;
            when alu_sextb => 
                alu_out <= (others => a(byte_T'high));
                alu_out(byte_T'high - 1 downto 0) <= a(byte_T'high - 1 downto 0);
            when alu_sexth => 
                alu_out <= (others => a(half_word_T'high));
                alu_out(half_word_T'high - 1 downto 0) <= a(half_word_T'high - 1 downto 0);
            when alu_zexth => 
                alu_out <= (others => '0');
                alu_out(half_word_T'range) <=  a(half_word_T'range);
            when alu_rol => alu_out <= word_T(rotate_left(unsigned(a), to_integer(unsigned(b))));
            when alu_ror => alu_out <= word_T(rotate_right(unsigned(a), to_integer(unsigned(b))));
            when alu_orcb =>
                for i in bytes_in_a - 1 downto 0 loop
                    if a((i+1)*BYTE_SIZE - 1 downto i*BYTE_SIZE) = "00000000" then alu_out((i+1)*BYTE_SIZE - 1 downto i*BYTE_SIZE) <= "00000000"; else alu_out((i+1)*BYTE_SIZE - 1 downto i*BYTE_SIZE) <= "11111111"; end if;
                end loop;
            when alu_rev8 => 
                for i in bytes_in_a - 1 downto 0 loop
                    alu_out((i+1)*BYTE_SIZE - 1 downto i*BYTE_SIZE) <= a((bytes_in_a - i)*BYTE_SIZE - 1 downto (bytes_in_a - i - 1)*BYTE_SIZE);
                end loop;
            when alu_illegal => alu_out <= (others => '0');
        end case;
        
        
        flags.eq <= a = b;
        flags.altb <= signed(a) < signed(b);
        flags.altbu <= unsigned(a) < unsigned(b);
    end process;
END ARCHITECTURE behav;

