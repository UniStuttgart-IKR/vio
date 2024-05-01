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
    process(a, b, alu_mode) is
        constant one: word_T := (0 => '1', others => '0');
        variable highest_bit_of_a_as_word: word_T;
        constant zeros: word_T := (others => '0');
    BEGIN
        for i in highest_bit_of_a_as_word'range loop
            highest_bit_of_a_as_word(i) := b(b'left);
        end loop;
        
        case alu_mode is 
            when alu_add => 
                alu_out <= std_logic_vector(unsigned(a)) + unsigned(b)), alu_out'length);
            when alu_sub => 
                alu_out <= std_logic_vector(unsigned(a)) - unsigned(b)), alu_out'length);
            when alu_sll => 
                alu_out <= a(a'left - to_integer(unsigned(b)) downto a'right) & zeros(to_integer(unsigned(b)) - 1 downto zeros'right) when to_integer(unsigned(b)) /= 0 else a;
            when alu_slt => one when signed(a) < signed(b) else (others => '0');
            when alu_sltu => one when unsigned(a) < unsigned(b) else (others => '0');
            when alu_xor => alu_out <= a xor b;
            when alu_srl => 
                alu_out <= zeros(to_integer(unsigned(b)) - 1 downto zeros'right) & a(a'left downto a'right + to_integer(unsigned(b))) when to_integer(unsigned(b)) /= 0 else a;
            when alu_sra => 
                alu_out <= highest_bit_of_a_as_word(to_integer(unsigned(b)) - 1 downto highest_bit_of_a_as_word'right) & a(a'left downto a'right + to_integer(unsigned(b))) when to_integer(unsigned(b)) /= 0 else a;
            when alu_or => alu_out <= a or b;
            when alu_and => alu_out <= a and b;
            when alu_illegal => alu_out <= (others => '0');
        end case;
    end process;
END ARCHITECTURE behav;

