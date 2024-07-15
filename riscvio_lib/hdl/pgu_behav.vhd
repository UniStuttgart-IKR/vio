library ieee;
use ieee.numeric_std.all;
library riscvio_lib;
use riscvio_lib.pipeline.all;

ARCHITECTURE behav OF pgu IS
    signal ptr_int: reg_mem_T;
BEGIN

    pgu_exc <= frtyp when isFrameTypeException(rdst_ix, rptr, pgu_mode) else
               sterr when isStateErrorException(rdst_ix, rptr, raux, rdat, PC_NULL, pgu_mode, no_branch) else
               ixoob when isIndexOutOfBoundsException(rdst_ix, rptr, raux, rdat, imm, pgu_mode) else
               hpovf when isHeapOverflowException(ptr_int.val, rptr, pgu_mode) else
               stovf when isStackOverflowException(ptr_int.val, rptr, pgu_mode) else
               well_behaved;




    me_addr.io_access <= rptr.val(TAG_RANGE) = IO_POINTER_TAG;

    me_addr.addr <= word_T(unsigned(rptr.val(word_T'high downto 3) & "000")+to_unsigned(8, word_T'length))  when pgu_mode = pgu_rix else
                    word_T(unsigned(rptr.val(word_T'high downto 3) & "000")+to_unsigned(8, word_T'length)) when pgu_mode = pgu_rcd else 
                    imm                                                                      when pgu_mode = pgu_dat_i and rptr.val(TAG_RANGE) = IO_POINTER_TAG else
                    rdat.val                                                                 when pgu_mode = pgu_dat_r and rptr.val(TAG_RANGE) = IO_POINTER_TAG else
                    calculateMemoryAddress(rptr.pi, rptr.ix, imm,      rptr.val, rptr.dt(31))                       when pgu_mode = pgu_dat_i else
                    calculateMemoryAddress(rptr.pi, rptr.ix, imm,      rptr.val, rptr.dt(31), true)                 when pgu_mode = pgu_ptr_i else
                    calculateMemoryAddress(rptr.pi, rptr.ix, rdat.val, rptr.val, rptr.dt(31))                       when pgu_mode = pgu_dat_r else
                    calculateMemoryAddress(rptr.pi, rptr.ix, rdat.val, rptr.val, rptr.dt(31), true)                 when pgu_mode = pgu_ptr_r else
                    allocateNewObject(rptr.val, ptr_int.pi, ptr_int.dt)                                             when pgu_mode = pgu_alc  else
                    allocateNewObject(rptr.val, ptr_int.pi, ptr_int.dt)                                             when pgu_mode = pgu_alcp else
                    allocateNewObject(rptr.val, ptr_int.pi, ptr_int.dt)                                             when pgu_mode = pgu_alcd  else
                    allocateNewObject(rptr.val, ptr_int.pi, ptr_int.dt)                                             when pgu_mode = pgu_alci  else
                    allocateNewObject(raux.val, ptr_int.pi, ptr_int.dt)                                             when pgu_mode = pgu_pusht else
                    allocateNewObject(raux.val, ptr_int.pi, ptr_int.dt)                                             when pgu_mode = pgu_push  else
                    allocateNewObject(raux.val, ptr_int.pi, ptr_int.dt)                                             when pgu_mode = pgu_pushg else
                    (others => '0');
    
    init_end_addr <= raux.val when pgu_mode = pgu_pusht or pgu_mode = pgu_push or pgu_mode = pgu_pushg else
                     rptr.val when pgu_mode = pgu_alc or pgu_mode = pgu_alcp or pgu_mode = pgu_alcd or pgu_mode = pgu_alci else
                     (others => '0');

    process(all) is
    begin
        ptr_int.pi <= (others => '0');
        if    pgu_mode = pgu_alc   then ptr_int.pi(28 downto 0) <= rdat.val(28 downto 0);
        elsif pgu_mode = pgu_alcp  then ptr_int.pi(28 downto 0) <=      imm(28 downto 0);
        elsif pgu_mode = pgu_alcd  then ptr_int.pi(28 downto 0) <= rdat.val(28 downto 0);
        elsif pgu_mode = pgu_alci  then ptr_int.pi( 4 downto 0) <=      imm( 4 downto 0);
        elsif pgu_mode = pgu_push  then ptr_int.pi( 4 downto 0) <=      imm( 4 downto 0);
        elsif pgu_mode = pgu_pusht then ptr_int.pi( 4 downto 0) <=      imm( 4 downto 0);
        elsif pgu_mode = pgu_pushg then ptr_int.pi( 4 downto 0) <=      imm( 4 downto 0);
        end if;


        ptr_int.dt <= (others => '0');
        if pgu_mode = pgu_alc then ptr_int.dt(30 downto 0) <= raux.val(30 downto 0); elsif
           pgu_mode = pgu_alcp then ptr_int.dt(30 downto 0) <= rdat.val(30 downto 0); elsif
           pgu_mode = pgu_alcd then ptr_int.dt(30 downto 0) <= imm(30 downto 0); elsif
           pgu_mode = pgu_alci then ptr_int.dt(6 downto 0) <= imm(11 downto 5); elsif
           pgu_mode = pgu_push and rdat.val(31) = '1' then ptr_int.dt(6 downto 0) <= imm(11 downto 5); elsif
           pgu_mode = pgu_push and rdat.val(31) = '0' then ptr_int.dt(6 downto 0) <= imm(11 downto 5); elsif
           pgu_mode = pgu_pusht then ptr_int.dt(6 downto 0) <= imm(11 downto 5); elsif
           pgu_mode = pgu_dat_i or pgu_mode = pgu_dat_r then ptr_int.dt <= rptr.dt; elsif
           pgu_mode = pgu_ciop and raux.val(0) = '0' then ptr_int.dt(15 downto 0) <= raux.val(16 downto 1); elsif
           pgu_mode = pgu_ciop and raux.val(0) = '1' then ptr_int.dt <= word_T(unsigned(raux.val(16 downto 1))*4096); elsif
           pgu_mode = pgu_auipc then ptr_int.dt <= pc.eoc;
        end if;
    end process;

    ptr_int.tag    <=  POINTER;

    ptr_int.val    <=  allocateNewObject(rptr.val, ptr_int.pi, ptr_int.dt) when pgu_mode = pgu_alc  else
                allocateNewObject(rptr.val, ptr_int.pi, ptr_int.dt) when pgu_mode = pgu_alcp else
                allocateNewObject(rptr.val, ptr_int.pi, ptr_int.dt) when pgu_mode = pgu_alcd  else
                allocateNewObject(rptr.val, ptr_int.pi, ptr_int.dt) when pgu_mode = pgu_alci  else
                allocateNewObject(raux.val, ptr_int.pi, ptr_int.dt) when pgu_mode = pgu_pusht else
                allocateNewObject(raux.val, ptr_int.pi, ptr_int.dt) when pgu_mode = pgu_push  else
                allocateNewObject(raux.val, ptr_int.pi, ptr_int.dt) when pgu_mode = pgu_pushg else
                allocateNewObject(rptr.val, rptr.pi, rptr.dt, true) when pgu_mode = pgu_pop else
                rdat.val(11 downto 0) & raux.val(16 downto 0) & IO_POINTER_TAG when pgu_mode = pgu_ciop else
                word_T(unsigned(raux.val(word_T'high downto 3)&"110") + unsigned(raux.ix) + 8)  when pgu_mode = pgu_ccp and raux.tag = POINTER else
                raux.val                                            when pgu_mode = pgu_ccp and raux.tag = DATA else
                pc.ptr(word_T'high downto 3) & "111" when pgu_mode = pgu_auipc else 
                (others => '0');

    ptr_int.ix     <=  word_T(unsigned(pc.ix) + unsigned(imm)) when pgu_mode = pgu_auipc else
                (others => '0');

    ptr <= ptr_int;

END ARCHITECTURE behav;

