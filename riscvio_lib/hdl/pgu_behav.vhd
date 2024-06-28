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
    pure function calcLen(pi: word_T; dt: word_T; alc_addr: word_T; pop: boolean := false) return std_logic_vector is
        variable pi_aligned, dt_aligned: word_T;
        variable reserved_space: natural range 8 to 16;
        variable addr: word_T;
    begin
        pi_aligned := pi(word_T'high-2 downto 0) & "00";
        dt_aligned := "00" & dt(word_T'high-2 downto 0);
        reserved_space := 16 when (dt(31) = '1' and dt(30) = '1') else 12 when (dt(31) = '1' or dt(30) = '1') else 8;
        addr := std_logic_vector(unsigned(alc_addr) + unsigned(pi_aligned) + unsigned(dt_aligned) + to_unsigned(reserved_space, word_T'length)) when pop else
                std_logic_vector(unsigned(alc_addr) - unsigned(pi_aligned) - unsigned(dt_aligned) - to_unsigned(reserved_space, word_T'length));
        return addr(word_T'high downto 3);
    end function calcLen;

    pure function calcAddr(pi: word_T; offs: word_T; base: word_T; rc: std_logic; ri: std_logic; ptr_access: boolean := false) return word_T is
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

    signal tag: std_logic_vector(2 downto 0);
    signal pc_ix_int: word_T;
BEGIN

    frame_type_exception <= false when pgu_mode = pgu_nop else                                  --default
                            true  when ali_T'val(rdst_ix) = ra and pgu_mode /= pgu_dat_i and pgu_mode /= pgu_ptr_i else  --try loading rix from non stack frame object (should be own exception type)
  --try loading rcd from non stack frame object (should be own exception type)
                            true  when ali_T'val(rdst_ix) = ra and rptr.val(2) /= '1' else     --try loading rix from non stack frame object (should be own exception type)
     --try loading rcd from non stack frame object (should be own exception type)
                            true  when ali_T'val(rdst_ix) = ra and pgu_mode = pgu_rix and rptr.dt(30) /= '1' else     --try loading rix from terminal frame
                            true  when ali_T'val(rdst_ix) = ra and pgu_mode = pgu_rcd and rptr.dt(31) /= '1' else     --try loading rcd from non gate frame
                            true  when pgu_mode = pgu_rix      and rptr.dt(30) /= '1' else     --try storing rix to terminal frame
                            true  when pgu_mode = pgu_rcd      and rptr.dt(31) /= '1' else     --try storing rcd to non gate frame
                            false;

    state_error_exception <= false when pgu_mode = pgu_nop or (pgu_mode /= pgu_dat_i and pgu_mode /= pgu_dat_r and pgu_mode /= pgu_ptr_i and pgu_mode /= pgu_ptr_r) else                                                     --default
                             true  when rptr.ali = frame and (pgu_mode = pgu_dat_r or pgu_mode = pgu_ptr_r) else    --try executing index load/store on stack frame
                             true  when raux.ali = frame and rdat.ali /= ra else                                    --(should not happen but just to be sure)
                             true  when raux.ali = frame and raux.val(0) /= rdat.val(0) else                        --color of frame does not match color of rix
                             false;

    index_out_of_bounds_exception <= false when pgu_mode = pgu_nop else
                                     false when ali_T'val(rdst_ix) = ra else
                                     false when raux.ali = ra else
                                     true  when pgu_mode = pgu_dat_i and unsigned(imm(28 downto 0)) > unsigned(rptr.dt) and rptr.ali = frame else
                                     true  when pgu_mode = pgu_dat_i and unsigned(imm(30 downto 0)) > unsigned(rptr.dt) else
                                     true  when pgu_mode = pgu_dat_r and unsigned(rdat.val(28 downto 0)) > unsigned(rptr.dt) and rptr.ali = frame else
                                     true  when pgu_mode = pgu_dat_r and unsigned(rdat.val(30 downto 0)) > unsigned(rptr.dt) else
                                     true  when pgu_mode = pgu_ptr_i and unsigned(imm(30 downto 2)) > unsigned(rptr.pi) else
                                     true  when pgu_mode = pgu_ptr_r and unsigned(rdat.val(30 downto 2)) > unsigned(rptr.pi) else
                                     false;

    pc_ix_int <= word_T(unsigned(pc.ix) + unsigned(imm)) when pgu_mode = pgu_auipc else
                 word_T(unsigned(rptr.pi) + unsigned(imm)) when pgu_mode = pgu_addi else
                 (others => '0');
    
    tag <=  "000" when pgu_mode = pgu_alc or pgu_mode = pgu_alcp or pgu_mode = pgu_alcd or pgu_mode = pgu_alci else
            "101" when (pgu_mode = pgu_pusht or pgu_mode = pgu_push or pgu_mode = pgu_pushg) and raux.val(0) = '0' else
            "100" when (pgu_mode = pgu_pusht or pgu_mode = pgu_push or pgu_mode = pgu_pushg) and raux.val(0) = '1' else
            "101" when pgu_mode = pgu_pop and rptr.val(0) = '0' else
            "100" when pgu_mode = pgu_pop and rptr.val(0) = '1' else
            "000";

    ptr.data   <=  calcLen(ptr.pi, ptr.delta, rptr.val) & tag when pgu_mode = pgu_alc  else
                   calcLen(ptr.pi, ptr.delta, rptr.val) & tag when pgu_mode = pgu_alcp else
                   calcLen(ptr.pi, ptr.delta, rptr.val) & tag when pgu_mode = pgu_alcd  else
                   calcLen(ptr.pi, ptr.delta, rptr.val) & tag when pgu_mode = pgu_alci  else
                   calcLen(ptr.pi, ptr.delta, raux.val) & tag when pgu_mode = pgu_pusht else
                   calcLen(ptr.pi, ptr.delta, raux.val) & tag when pgu_mode = pgu_push  else
                   calcLen(ptr.pi, ptr.delta, raux.val) & tag when pgu_mode = pgu_pushg else
                   calcLen(rptr.pi, rptr.dt, rptr.val(word_T'high downto 3) & "000", true) & tag when pgu_mode = pgu_pop else
                   word_T(unsigned(pc.ptr) + unsigned(pc_ix_int) + 8) when (pgu_mode = pgu_auipc or pgu_mode = pgu_addi) and unsigned(pc_ix_int) > unsigned(pc.dt) else 
                   word_T(unsigned(pc.ptr) + unsigned(imm)) when pgu_mode = pgu_auipc else
                   word_T(unsigned(rptr.val) + unsigned(imm)) when pgu_mode = pgu_addi else
                   (others => '0');

    me_addr <=     std_logic_vector(unsigned(rptr.val) + 8)  when pgu_mode = pgu_rix else
                   std_logic_vector(unsigned(rptr.val) + 8) when pgu_mode = pgu_rcd else

                   calcAddr(rptr.pi, imm,      rptr.val, rptr.dt(31), rptr.dt(30))          when pgu_mode = pgu_dat_i else
                   calcAddr(rptr.pi, imm,      rptr.val, rptr.dt(31), rptr.dt(30), true)    when pgu_mode = pgu_ptr_i else
                   calcAddr(rptr.pi, rdat.val, rptr.val, rptr.dt(31), rptr.dt(30))          when pgu_mode = pgu_dat_r else
                   calcAddr(rptr.pi, rdat.val, rptr.val, rptr.dt(31), rptr.dt(30), true)    when pgu_mode = pgu_ptr_r else 
                   (others => '0');

    ptr.tag <= POINTER;

    ptr.pi     <=  (28 downto 0 => rdat.val(28 downto 0), others => '0') when pgu_mode = pgu_alc else
                   (28 downto 0 =>      imm(28 downto 0), others => '0') when pgu_mode = pgu_alcp else
                   (28 downto 0 => rdat.val(28 downto 0), others => '0') when pgu_mode = pgu_alcd else
                   ( 4 downto 0 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_alci else
                   ( 4 downto 0 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_push else
                   ( 4 downto 0 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_pusht else
                   ( 4 downto 0 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_pushg else
                   pc.ix when pgu_mode = pgu_auipc and unsigned(pc_ix_int(word_T'range)) <= unsigned(pc.dt) else 
                   pc_ix_int when pgu_mode = pgu_auipc else 
                   pc_ix_int when pgu_mode = pgu_addi and unsigned(pc_ix_int(word_T'range)) <= unsigned(pc.dt) else 
                   (others => '0');

--                  read only
    ptr.delta  <=  (31 => '0', 30 downto 0 => raux.val(30 downto 0))    when pgu_mode = pgu_alc else
                   (31 => '0', 30 downto 0 => rdat.val(30 downto 0))    when pgu_mode = pgu_alcp else
                   (31 => '0', 30 downto 0 => imm(30 downto 0))         when pgu_mode = pgu_alcd else
                   (6 downto 0 => imm(11 downto 5), others => '0')      when pgu_mode = pgu_alci else

--                     rc         ri
                   (31 => '0', 30 => '1', 6 downto 0 => imm(11 downto 5), others => '0') when pgu_mode = pgu_push else
                   (31 => '0', 30 => '0', 6 downto 0 => imm(11 downto 5), others => '0') when pgu_mode = pgu_pusht else
                   (31 => '1', 30 => '1', 6 downto 0 => imm(11 downto 5), others => '0') when pgu_mode = pgu_pushg else

                   pc.dt when pgu_mode = pgu_auipc and unsigned(pc_ix_int(word_T'range)) <= unsigned(pc.dt) else 
                   rptr.dt when pgu_mode = pgu_addi and unsigned(pc_ix_int(word_T'range)) <= unsigned(pc.dt) else 
                   (others => '0');

END ARCHITECTURE behav;

