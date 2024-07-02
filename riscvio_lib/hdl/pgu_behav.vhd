library ieee;
use ieee.numeric_std.all;
library riscvio_lib;
use riscvio_lib.pipeline.all;

ARCHITECTURE behav OF pgu IS
BEGIN

    frame_error <= isFrameTypeException(rdst_ix, rptr, pgu_mode);
    state_error <= isStateErrorException(rdst_ix, rptr, raux, rdat, PC_NULL, pgu_mode, no_branch);
    index_out_of_bounds <= isIndexOutOfBoundsException(rdst_ix, rptr, raux, rdat, imm, pgu_mode);
    heap_overflow <= isHeapOverflowException(ptr.val, rptr, pgu_mode);
    stack_overflow <= isStackOverflowException(ptr.val, rptr, pgu_mode);




    me_addr.io_access <= rptr.val(TAG_RANGE) = IO_POINTER_TAG;

    me_addr.addr <= std_logic_vector(unsigned(rptr.val) + 8)  when pgu_mode = pgu_rix else
                    std_logic_vector(unsigned(rptr.val) + 8) when pgu_mode = pgu_rcd else 
                    imm                                                                      when pgu_mode = pgu_dat_i and rptr.val(TAG_RANGE) = IO_POINTER_TAG else
                    rdat.val                                                                 when pgu_mode = pgu_dat_r and rptr.val(TAG_RANGE) = IO_POINTER_TAG else
                    calculateMemoryAddress(rptr.pi, rptr.ix, imm,      rptr.val, rptr.dt(31), rptr.dt(30))          when pgu_mode = pgu_dat_i else
                    calculateMemoryAddress(rptr.pi, rptr.ix, imm,      rptr.val, rptr.dt(31), rptr.dt(30), true)    when pgu_mode = pgu_ptr_i else
                    calculateMemoryAddress(rptr.pi, rptr.ix, rdat.val, rptr.val, rptr.dt(31), rptr.dt(30))          when pgu_mode = pgu_dat_r else
                    calculateMemoryAddress(rptr.pi, rptr.ix, rdat.val, rptr.val, rptr.dt(31), rptr.dt(30), true)    when pgu_mode = pgu_ptr_r else 
                    (others => '0');
    



    ptr.tag    <=  POINTER;

    ptr.val    <=  allocateNewObject(rptr.val, ptr.pi, ptr.dt) when pgu_mode = pgu_alc  else
                   allocateNewObject(rptr.val, ptr.pi, ptr.dt) when pgu_mode = pgu_alcp else
                   allocateNewObject(rptr.val, ptr.pi, ptr.dt) when pgu_mode = pgu_alcd  else
                   allocateNewObject(rptr.val, ptr.pi, ptr.dt) when pgu_mode = pgu_alci  else
                   allocateNewObject(raux.val, ptr.pi, ptr.dt) when pgu_mode = pgu_pusht else
                   allocateNewObject(raux.val, ptr.pi, ptr.dt) when pgu_mode = pgu_push  else
                   allocateNewObject(raux.val, ptr.pi, ptr.dt) when pgu_mode = pgu_pushg else
                   allocateNewObject(rptr.val, rptr.pi, rptr.dt, true) when pgu_mode = pgu_pop else
                   rdat.val(11 downto 0) & raux.val(16 downto 0) & IO_POINTER_TAG when pgu_mode = pgu_ciop else
                   word_T(unsigned(raux.val) + unsigned(raux.ix) + 8) when pgu_mode = pgu_ccp else
                   pc.ptr when pgu_mode = pgu_auipc else 
                   (others => '0');

    ptr.ix     <=  word_T(unsigned(pc.ix) + unsigned(imm)) when pgu_mode = pgu_auipc else
                   (others => '0');

    ptr.pi     <=  (28 downto 0 => rdat.val(28 downto 0), others => '0') when pgu_mode = pgu_alc else
                   (28 downto 0 =>      imm(28 downto 0), others => '0') when pgu_mode = pgu_alcp else
                   (28 downto 0 => rdat.val(28 downto 0), others => '0') when pgu_mode = pgu_alcd else
                   ( 4 downto 0 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_alci else
                   ( 4 downto 0 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_push else
                   ( 4 downto 0 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_pusht else
                   ( 4 downto 0 =>      imm( 4 downto 0), others => '0') when pgu_mode = pgu_pushg else
                   (others => '0');

--                  read only
    ptr.dt     <=  (31 => '0', 30 downto 0 => raux.val(30 downto 0))    when pgu_mode = pgu_alc else
                   (31 => '0', 30 downto 0 => rdat.val(30 downto 0))    when pgu_mode = pgu_alcp else
                   (31 => '0', 30 downto 0 => imm(30 downto 0))         when pgu_mode = pgu_alcd else
                   (6 downto 0 => imm(11 downto 5), others => '0')      when pgu_mode = pgu_alci else

--                     rc         ri
                   (31 => '1', 30 => '0', 6 downto 0 => imm(11 downto 5), others => '0') when pgu_mode = pgu_push and rdat.val(31) = '1' else
                   (31 => '0', 30 => '1', 6 downto 0 => imm(11 downto 5), others => '0') when pgu_mode = pgu_push and rdat.val(31) = '0' else
                   (31 => '0', 30 => '0', 6 downto 0 => imm(11 downto 5), others => '0') when pgu_mode = pgu_pusht else
--                 (31 => '1', 30 => '1', 6 downto 0 => imm(11 downto 5), others => '0') when pgu_mode = pgu_pushg else

                   rptr.dt                                                  when pgu_mode = pgu_dat_i  or pgu_mode = pgu_dat_r  else
                   (15 downto 0 => raux.val(16 downto 1), others => '0')    when pgu_mode = pgu_ciop and raux.val(0) = '0' else
                   word_T(unsigned(raux.val(16 downto 1))*4096)             when pgu_mode = pgu_ciop and raux.val(0) = '1' else

                   pc.eoc when pgu_mode = pgu_auipc else
                   (others => '0');


END ARCHITECTURE behav;

