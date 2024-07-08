LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

PACKAGE pipeline IS

--------------------------------------------------------------------------------------
--                       CSR, REGISTER FILE & PIPELINE                              --
--------------------------------------------------------------------------------------

    --subtype index_T is std_logic_vector(INDEX_SIZE - 1 downto 0);
    type reg_tag_T is (DATA, POINTER);
    type reg_mem_T is record
      tag: reg_tag_T;
      val: word_T;
      ix: word_T;
      pi: word_T;
      dt: word_T;
    end record reg_mem_T;
    constant REG_MEM_NULL: reg_mem_T := (tag => DATA, val => (others => '0'), ix => (others => '0'), pi => (others => '0'), dt => (others => '0'));
    
    type pc_T is record
       ptr: word_T;
       ix: word_T;
       eoc: word_T;
    end record pc_T;
    -- core object size is as large as possible at startup to make sure ic cache will load the instructions
    constant PC_NULL: pc_T := (ptr => (others => '0'), ix => (others => '0'), eoc => (others => '0'));

    type ali_T is (zero, ra, frame, core, ctxt, t0, t1, t2, s0, s1, a0, a1, a2, a3, a4, a5, a6, a7, s2, s3, s4, s5, s6, s7, s8, s9, bm, cnst, t3, t4, t5, t6, imm, mtvec, misa, mstatus, mcause, mtval, mepc, mvendorid, marchid, mimpid,  alc_lim, alc_addr, frame_lim, root, no_csr);
    subtype csr_nbr_T is natural range ali_T'pos(mtvec) to ali_T'pos(no_csr);
    subtype reg_nbr_T is natural range 0 to ali_T'pos(root);
    type reg_T is record
        ali: ali_T;
        nbr: reg_nbr_T;
        mem: reg_mem_T;
    end record reg_T;
    constant REG_NULL: reg_T := (ali => zero, nbr => 0, mem => REG_MEM_NULL);

    type reg_wb_T is record
        ali: ali_T;
        rf_nbr: reg_nbr_T;
        csr_nbr: csr_nbr_T;
        mem: reg_mem_T;
    end record reg_wb_T;
    constant REG_WB_NULL: reg_wb_T := (ali => zero, rf_nbr => 0, csr_nbr => ali_T'pos(no_csr), mem => REG_MEM_NULL);

    type rdat_T is record
        ali: ali_T;
        nbr: reg_nbr_T;
        val: word_T;
    end record rdat_T;
    CONSTANT RDAT_NULL: rdat_T := (ali => zero, nbr => 0, val => (others => '0'));

    type rptr_T is record
        ali: ali_T;
        nbr: reg_nbr_T;
        val: word_T;
        ix: word_T;
        pi: word_T;
        dt: word_T;
    end record rptr_T;
    CONSTANT RPTR_NULL: rptr_T := (ali => zero, nbr => 0, val => (others => '0'), ix => (others => '0'), pi => (others => '0'), dt => (others => '0'));

    type raux_T is record
        ali: ali_T;
        nbr: reg_nbr_T;
        tag: reg_tag_T;
        val: word_T;
        ix: word_T;
    end record raux_T;
    CONSTANT RAUX_NULL: raux_T := (ali => zero, nbr => 0, val => (others => '0'), ix => (others => '0'), tag => DATA);

--------------------------------------------------------------------------------------
--                                  DECODER                                         --
--------------------------------------------------------------------------------------

    type alu_mode_T is (alu_add, alu_sub, alu_sll, alu_slt, alu_sltu, alu_xor, alu_srl, alu_sra, alu_or, alu_and, 
                        alu_andn, alu_orn, alu_xnor, alu_clz, alu_ctz, alu_cpop, alu_max, alu_maxu, alu_min, alu_minu, alu_sextb, alu_sexth, alu_zexth, alu_rol, alu_ror, alu_orcb, alu_rev8,
                        alu_illegal);
    type alu_in_sel_T is (DAT, PTRVAL, PTRPIR, PTRPI, PTRDTR, PTRDTB, PTRDTH, PTRDTW, PTRDTD, AUX, IMM, PGU, PC_IX);
    type pgu_mode_T is (pgu_alc, pgu_alcp, pgu_alcd, pgu_alci, pgu_push, pgu_pusht, pgu_pushg, pgu_pop, pgu_dat_i, pgu_dat_r, pgu_ptr_i, pgu_ptr_r, pgu_auipc, pgu_rix, pgu_rcd, pgu_ccp, pgu_ciop, pgu_nop);
    type mem_mode_T is (lb, lbu, lh, lhu, lw, sb, sh, sw, lp, sp, store_rpc, load_rpc, load_ix, store_ix, holiday);
    type at_mode_T is (load_maybe, no, load_delta_only, store);
    type branch_mode_T is (jlib, rtlib, jal, jalr, beq, bne, blt, bge, bltu, bgeu, no_branch);
    type ex_res_mux_sel_T is (NONE, AUX, PTR, DAT, PGU, ALU, DBU);
    subtype csr_mux_sel_T is ex_res_mux_sel_T range NONE to DAT;

    type ctrl_sig_T is record 
        mnemonic:       mnemonic_T;
        alu_mode:       alu_mode_T;
        alu_a_sel:      alu_in_sel_T;
        alu_b_sel:      alu_in_sel_T;
        ex_res_mux_sel: ex_res_mux_sel_T;
        pgu_mode:       pgu_mode_T;
        me_mode:        mem_mode_T;
        at_mode:        at_mode_T;
        branch_mode:    branch_mode_T;
        fwd_allowed:    boolean;
    end record ctrl_sig_T;
    constant CTRL_NULL: ctrl_sig_T := (alu_mode => alu_illegal, branch_mode => no_branch, alu_a_sel => DAT, alu_b_sel => DAT, mnemonic => nop, me_mode => holiday, at_mode => no, pgu_mode => pgu_nop, fwd_allowed => false, ex_res_mux_sel => AUX);
    
    type xret_T is (none, mret);

    type decode_T is record 
        mnemonic:       mnemonic_T;
        alu_mode:       alu_mode_T;
        alu_a_sel:      alu_in_sel_T;
        alu_b_sel:      alu_in_sel_T;
        ex_res_mux_sel: ex_res_mux_sel_T;
        csr_mux_sel:    csr_mux_sel_T;
        pgu_mode:       pgu_mode_T;
        me_mode:        mem_mode_T;
        at_mode:        at_mode_T;
        rdst:           reg_nbr_T;
        rdat:           reg_nbr_T;
        rptr:           reg_nbr_T;
        raux:           reg_nbr_T;
        imm_mode:       imm_T;
        branch_mode:    branch_mode_T;
        xret:           xret_T;
        fwd_allowed:    boolean;
    end record decode_T;
    
    type alu_flags_T is record
      eq: boolean;
      altb: boolean;
      altbu: boolean;
    end record alu_flags_T;

    pure function decodeOpc(instruction: std_logic_vector(31 downto 0)) return decode_T;


--------------------------------------------------------------------------------------
--                          POINTER GENERATION UNIT                                 --
--------------------------------------------------------------------------------------

    subtype TAG_RANGE is natural range 2 downto 0;
    constant IO_POINTER_TAG: std_logic_vector(TAG_RANGE) := "011";

    type mem_addr_T is record
      io_access: boolean;
      addr: word_T;
    end record mem_addr_T;
    constant MEM_ADDR_NULL: mem_addr_T := (io_access => false, addr => (others => '0'));

    pure function allocateNewObject(current_alc_addr: word_T; pi: word_T; dt: word_T; dalc: boolean := false) return word_T;
    pure function calculateMemoryAddress(pi: word_T; ix: word_T; offs: word_T; base: word_T; rc: std_logic; ri: std_logic; ptr_access: boolean := false) return word_T;


--------------------------------------------------------------------------------------
--                                 EXCEPTIONS                                       --
--------------------------------------------------------------------------------------

    type exc_cause_T is (panic, illeg, sverr, sterr, privv, tcoil, tciob, endoc, rixeq, rdcnu, rcdnc, drfnu, drfcd, wrptv, sealv, ixoob, frtyp, aperr, hpovf, stovf, ptari, well_behaved);
    pure function isFrameTypeException(rdst_nbr: reg_nbr_T; frame: rptr_T; pgu_mode: pgu_mode_T) return boolean;
    pure function isIndexOutOfBoundsException(rdst_nbr: reg_nbr_T; rptr: rptr_T; raux: raux_T; rdat: rdat_T; imm: word_T; pgu_mode: pgu_mode_T) return boolean;
    pure function isStateErrorException(rdst_nbr: reg_nbr_T; rptr: rptr_T; raux: raux_T; rdat: rdat_T; pc: pc_T; pgu_mode: pgu_mode_T; branch_mode: branch_mode_T) return boolean;
    pure function isPointerArithException(alu_mode: alu_mode_T; raux: raux_T) return boolean;
    pure function isTargetCodeIndexOutOfBounds(target_ix: word_T; target_public: word_T; target_private: word_T; branch_mode: branch_mode_T; inter: boolean) return boolean;
    pure function isHeapOverflowException(allocated_address: word_T; alc_params: rptr_T; pgu_mode: pgu_mode_T) return boolean;
    pure function isStackOverflowException(allocated_address: word_T; alc_params: rptr_T; pgu_mode: pgu_mode_T) return boolean;

--------------------------------------------------------------------------------------
--                                  CHACHES                                         --
--------------------------------------------------------------------------------------

    constant BUS_WIDTH: natural := 256;
    constant IC_LINES:      natural := 4;
    constant IC_LINE_WIDTH: natural := 16;
    constant DC_LINES:      natural := 4;
    constant DC_LINE_WIDTH: natural := 2; -- 2 256 bit words
    constant AC_LINES:      natural := 8;
    constant AC_LINE_WIDTH: natural := 1;
    constant ADDR_WIDTH:    natural := 32;

    subtype buzz_word_T is std_logic_vector(BUS_WIDTH - 1 downto 0);
    type cache_rrq_T is record
        rreq           : boolean;
        rack           : boolean;
        raddr          : std_logic_vector(ADDR_WIDTH - 1 downto 0);
        rdata          : std_logic_vector(BUS_WIDTH - 1 downto 0);
    end record cache_rrq_T;
    type cache_wrq_T is record
        wreq           : boolean;
        wack           : boolean;
        waddr          : std_logic_vector(ADDR_WIDTH - 1 downto 0);
        wdata          : std_logic_vector(BUS_WIDTH - 1 downto 0);     
    end record cache_wrq_T;

END pipeline;
