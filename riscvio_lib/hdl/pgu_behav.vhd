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
--TODO: add frame shape and color generation!!
    pure function calcLen(pi: word_T; dt: word_T; offs: natural; alc_addr: word_T) return word_T is
        variable pi_aligned: word_T;
    begin
        pi_aligned := pi(word_T'high-2 downto 0)&"00";
        return std_logic_vector(unsigned(alc_addr) - unsigned(pi_aligned) - unsigned(dt) - to_unsigned(offs, word_T'length) - X"8") and X"FFFFFFF8";
    end function calcLen;

    pure function calcAddr(pi: word_T; offs: word_T; base: word_T; rc: std_logic, ri: std_logic, ptr_access: boolean := false) return word_T is
        variable pi_scaled: word_T;
        variable offset_scaled: word_T;
        variable reserved_space: natural range 8 to 16;
    begin
        pi_scaled := '0' & pi(word_T'high-1 downto 2) & "00";
        offset_scaled := offs(word_T'high-2 downto 0) & "00";
        reserved_space := 16 when (rc = '1' and ri = '1') else 12 when (rc = '1' or ri = '1') else 8;

        if ptr_access then
            return std_logic_vector(unsigned(base) + unsigned(offset_scaled) + reserved_space);
        else
            return std_logic_vector(unsigned(base) + unsigned(pi_scaled) + unsigned(offs) + reserved_space);
        end if;
    end function calcAddr;
BEGIN

    frame_type_exception <= false when pgu_mode = pgu_nop else                                  --default
                            true  when ali_T'val(rdst_ix) = rix and pgu_mode /= pgu_dat_i else  --try loading rix from non stack frame object (should be own exception type)
                            true  when ali_T'val(rdst_ix) = rcd and pgu_mode /= pgu_ptr_i else  --try loading rcd from non stack frame object (should be own exception type)
                            true  when ali_T'val(rdst_ix) = rix and rptr.val(2) /= '1' else     --try loading rix from non stack frame object (should be own exception type)
                            true  when ali_T'val(rdst_ix) = rcd and rptr.val(2) /= '1' else     --try loading rcd from non stack frame object (should be own exception type)
                            true  when ali_T'val(rdst_ix) = rix and rptr.dt(29) /= '1' else     --try loading rix from terminal frame
                            true  when ali_T'val(rdst_ix) = rcd and rptr.dt(30) /= '1' else     --try loading rcd from non gate frame
                            true  when raux.ali = rix           and rptr.dt(29) /= '1' else     --try storing rix to terminal frame
                            true  when raux.ali = rcd           and rptr.dt(30) /= '1' else     --try storing rcd to non gate frame
                            false;

    state_error_exception <= false when pgu_mode = pgu_nop else                                                     --default
                             true  when rptr.ali = frame and (pgu_mode = pgu_dat_r or pgu_mode = pgu_ptr_r) else    --try executing index load/store on stack frame
                             true  when rptr.ali = frame and rdat.ali /= rix else                                   --(should not happen but just to be sure)
                             true  when rptr.val(1 downto 0) = rdat.val(30 downto 29) else                          --shape and color of frame do not match shape and color of rix
                             false;

    index_out_of_bounds_exception <= false when pgu_mode = pgu_nop else
                                     true  when pgu_mode = pgu_dat_i and unsigned(imm) > unsigned(rptr.dt) else
                                     true  when pgu_mode = pgu_dat_r and unsigned(rdat.val) > unsigned(rptr.dt) else
                                     true  when pgu_mode = pgu_ptr_i and unsigned(imm) > unsigned(rptr.pi) else
                                     true  when pgu_mode = pgu_ptr_r and unsigned(rdat.val) > unsigned(rptr.pi) else
                                     false;

    ptr.data   <=  calcLen(rdat.val,                                        raux.val,                                       0, rptr.val) when pgu_mode = pgu_alc  else
                   calcLen(imm,                                             rdat.val,                                       0, rptr.val) when pgu_mode = pgu_alcp else
                   calcLen(rdat.val,                                        imm,                                            0, rptr.val) when pgu_mode = pgu_alcd  else
                   calcLen((4 downto 0 => imm(4 downto 0), others => '0'), (6 downto 0 => imm(11 downto 5), others => '0'), 0, rptr.val) when pgu_mode = pgu_alci  else
                   calcLen((4 downto 0 => imm(4 downto 0), others => '0'), (6 downto 0 => imm(11 downto 5), others => '0'), 0, raux.val) when pgu_mode = pgu_pusht else
                   calcLen((4 downto 0 => imm(4 downto 0), others => '0'), (6 downto 0 => imm(11 downto 5), others => '0'), 4, raux.val) when pgu_mode = pgu_push  else
                   calcLen((4 downto 0 => imm(4 downto 0), others => '0'), (6 downto 0 => imm(11 downto 5), others => '0'), 8, raux.val) when pgu_mode = pgu_pushg else

                   std_logic_vector(unsigned(alc_addr) + 8)  when ali_T'val(rdst_ix) = rix else
                   std_logic_vector(unsigned(alc_addr) + 12) when ali_T'val(rdst_ix) = rcd else

                   calcAddr(rptr.pi, imm,      rptr.val, rptr.dt(30), rptr.dt(29))          when pgu_mode = pgu_dat_i else
                   calcAddr(rptr.pi, imm,      rptr.val, rptr.dt(30), rptr.dt(29), true)    when pgu_mode = pgu_ptr_i else
                   calcAddr(rptr.pi, rdat.val, rptr.val, rptr.dt(30), rptr.dt(29))          when pgu_mode = pgu_dat_r else
                   calcAddr(rptr.pi, rdat.val, rptr.val, rptr.dt(30), rptr.dt(29), true)    when pgu_mode = pgu_ptr_r else 
                   (others => '0');

    ptr.tag <= POINTER;

    ptr.pi     <=  (30 downto 2 => rdat.val(28 downto 0), others => '0') when pgu_mode = pgu_alc else
                   (30 downto 2 =>      imm(28 downto 0), others => '0') when pgu_mode = pgu_alcp else
                   (30 downto 2 => rdat.val(28 downto 0), others => '0') when pgu_mode = pgu_alcd else
                   ( 6 downto 2 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_alci else
                   ( 6 downto 2 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_push else
                   ( 6 downto 2 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_pusht else
                   ( 6 downto 2 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_pushg else
                   (others => '0');

--                  read only
    ptr.delta  <=  (31 => '0', 30 downto 0 => raux.val(30 downto 0))    when pgu_mode = pgu_alc else
                   (31 => '0', 30 downto 0 => rdat.val(30 downto 0))    when pgu_mode = pgu_alcp else
                   (31 => '0', 30 downto 0 => imm(30 downto 0))         when pgu_mode = pgu_alcd else
                   (6 downto 0 => imm(11 downto 5), others => '0')      when pgu_mode = pgu_alci else

--                     lib        rc         ri
                   (31 => '0', 30 => '0', 29 => '1', 6 downto 0 => imm(11 downto 5), others => '0') when pgu_mode = pgu_push else
                   (31 => '0', 30 => '0', 29 => '0', 6 downto 0 => imm(11 downto 5), others => '0') when pgu_mode = pgu_pusht else
                   (31 => '0', 30 => '1', 29 => '1', 6 downto 0 => imm(11 downto 5), others => '0') when pgu_mode = pgu_pushg else
                   (others => '0');

END ARCHITECTURE behav;

