--
-- VHDL Architecture riscvio_lib.pgu.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 18:01:28 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF pgu IS
    pure function calcLen(pi: word_T; dt: word_T; offs: natural; alc_addr: word_T) return word_T is
    begin
        return std_logic_vector(unsigned(alc_addr) - unsigned(pi(word_T'high-2 downto 0)&"00") - unsigned(dt) - unsigned(offs, word_T'length) - 8) and X"FFFFFFF8";
    end function calcLen;
BEGIN

    alc_len <=  calcLen(rdat.val, raux.val, 0, rptr.val) when pgu_mode = pgu_alc else
                calcLen(imm, rdat.val, 0, rptr.val) when pgu_mode = pgu_alcp else
                calcLen(rdat.val, imm, 0, rptr.val) when pgu_mode = pgu_alcd else
                calcLen(imm(RD_RANGE), imm(FUNCT7_RANGE), 0, rptr.val) when pgu_mode = pgu_alci else
                calcLen(imm(RD_RANGE), imm(FUNCT7_RANGE), 4, rptr.val) when pgu_mode = pgu_push else
                calcLen(imm(RD_RANGE), imm(FUNCT7_RANGE), 0, rptr.val) when pgu_mode = pgu_pusht else
                calcLen(imm(RD_RANGE), imm(FUNCT7_RANGE), 8, rptr.val) when pgu_mode = pgu_pushg else
                (others => '0');

END ARCHITECTURE behav;

