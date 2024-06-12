--
-- VHDL Architecture riscvio_lib.pgu.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 18:01:28 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee;
use ieee.numeric_std.all;
ARCHITECTURE behav OF pgu IS
    pure function calcLen(pi: word_T; dt: word_T; offs: natural; alc_addr: word_T) return word_T is
        variable pi_aligned: word_T;
    begin
        pi_aligned := pi(word_T'high-2 downto 0)&"00";
        return std_logic_vector(unsigned(alc_addr) - unsigned(pi_aligned) - unsigned(dt) - to_unsigned(offs, word_T'length) - X"8") and X"FFFFFFF8";
    end function calcLen;

    pure function calcAddr(pi: word_T; offs: word_T; base: word_T; ptr_access: boolean := false) return word_T is
        variable pi_scaled: word_T;
        variable offset_scaled: word_T;
    begin
        pi_scaled := pi(word_T'high-2 downto 0) & "00";
        offset_scaled := offs(word_T'high-2 downto 0) & "00";

        if ptr_access then
            return std_logic_vector(unsigned(base) + unsigned(offset_scaled) + 8);
        else
            return std_logic_vector(unsigned(base) + unsigned(pi_scaled) + unsigned(offs) + 8);
        end if;
    end function calcAddr;
BEGIN

    addr    <=  calcLen(rdat.val, raux.val, 0, rptr.val) when pgu_mode = pgu_alc else
                   calcLen(imm, rdat.val, 0, rptr.val) when pgu_mode = pgu_alcp else
                   calcLen(rdat.val, imm, 0, rptr.val) when pgu_mode = pgu_alcd else

                   calcLen((4 downto 0 => imm(4 downto 0), others => '0'), (6 downto 0 => imm(11 downto 5), others => '0') , 0, rptr.val) when pgu_mode = pgu_alci else
                   calcLen((4 downto 0 => imm(4 downto 0), others => '0'), (6 downto 0 => imm(11 downto 5), others => '0'), 4, raux.val) when pgu_mode = pgu_push else
                   calcLen((4 downto 0 => imm(4 downto 0), others => '0'), (6 downto 0 => imm(11 downto 5), others => '0'), 0, raux.val) when pgu_mode = pgu_pusht else
                   calcLen((4 downto 0 => imm(4 downto 0), others => '0'), (6 downto 0 => imm(11 downto 5), others => '0'), 8, raux.val) when pgu_mode = pgu_pushg else

                   calcAddr(rptr.pi, imm, rptr.val) when pgu_mode = pgu_dat_i else
                   calcAddr(rptr.pi, imm, rptr.val, true) when pgu_mode = pgu_ptr_i else
                   calcAddr(rptr.pi, rdat.val, rptr.val) when pgu_mode = pgu_dat_r else
                   calcAddr(rptr.pi, rdat.val, rptr.val, true) when pgu_mode = pgu_ptr_r else 
                   (others => '0');

END ARCHITECTURE behav;

