--
-- VHDL Package Header riscvio_lib.isa
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 16:28:31 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
PACKAGE isa IS
    constant DWORD_SIZE: natural := 64;
    constant WORD_SIZE: natural := 32; 
    constant HALF_WORD_SIZE: natural := 16;
    constant BYTE_SIZE: natural := 8;
    constant INSTRUCTION_SIZE: positive := 4;

    subtype word_T is std_logic_vector(WORD_SIZE - 1 downto 0);
    subtype dword_T is std_logic_vector(DWORD_SIZE - 1 downto 0);
    subtype half_word_T is std_logic_vector(HALF_WORD_SIZE - 1 downto 0);
    subtype byte_T is std_logic_vector(BYTE_SIZE - 1 downto 0);


    subtype HWORD0_RANGE is natural range 15 downto 0;
    subtype HWORD1_RANGE is natural range 31 downto 16; 

    subtype BYTE0_RANGE is natural range 7 downto 0;
    subtype BYTE1_RANGE is natural range 15 downto 8;
    subtype BYTE2_RANGE is natural range 23 downto 16;
    subtype BYTE3_RANGE is natural range 31 downto 24;

    constant NOP_INSTR: word_T := X"00000013";

    type reg_tag_T is (DATA, POINTER);
    type reg_mem_T is record
      tag: reg_tag_T;
      data: word_T;
      pi: word_T;
      delta: word_T;
    end record reg_mem_T;
    constant REG_MEM_NULL: reg_mem_T := (tag => DATA, data => (others => '0'), pi => (others => '0'), delta => (others => '0'));
    

    type pc_T is record
       ptr: word_T;
       ix: word_T;
       pi: word_T;
       dt: word_T;
    end record pc_T;
    constant PC_NULL: pc_T := (ptr => (others => '0'), ix => (others => '0'), pi => (others => '0'), dt => (others => '0'));


    type ali_T is (zero, rix, frame, rcd, ctxt, t0, t1, t2, s0, s1, a0, a1, a2, a3, a4, a5, a6, a7, s2, s3, s4, s5, s6, s7, s8, s9, bm, cnst, t3, t4, t5, t6, imm, alc_lim, alc_addr, frame_lim, core, root, no_csr);
    subtype csr_ix_T is natural range ali_T'pos(alc_lim) to ali_T'pos(no_csr);
    subtype reg_ix_T is natural range 0 to ali_T'pos(root);
    type reg_T is record
        ali: ali_T;
        index: reg_ix_T;
        mem: reg_mem_T;
    end record reg_T;


    type reg_wb_T is record
        ali: ali_T;
        rf_index: reg_ix_T;
        csr_index: csr_ix_T;
        mem: reg_mem_T;
    end record reg_wb_T;
    constant REG_WB_NULL: reg_wb_T := (ali => zero, rf_index => 0, csr_index => ali_T'pos(no_csr), mem => REG_MEM_NULL);

    type rdat_T is record
        ali: ali_T;
        ix: reg_ix_T;
        val: word_T;
    end record rdat_T;
    CONSTANT RDAT_NULL: rdat_T := (ali => zero, ix => 0, val => (others => '0'));
    type rptr_T is record
        ali: ali_T;
        ix: reg_ix_T;
        val: word_T;
        pi: word_T;
        dt: word_T;
    end record rptr_T;
    CONSTANT RPTR_NULL: rptr_T := (ali => zero, ix => 0, val => (others => '0'), pi => (others => '0'), dt => (others => '0'));
    type raux_T is record
        ali: ali_T;
        ix: reg_ix_T;
        tag: reg_tag_T;
        val: word_T;
    end record raux_T;
    CONSTANT RAUX_NULL: raux_T := (ali => zero, ix => 0, val => (others => '0'), tag => DATA);

    constant REG_NULL: reg_T := (ali => zero, index => 0, mem => REG_MEM_NULL);

    type mnemonic_T is (nop, add_i, add_r, sub_r, sll_i, sll_r, slt_r, slt_i, sltu_i, sltu_r, xor_i, xor_r, srl_i, srl_r, sra_i, sra_r, or_i, or_r, and_i, and_r,
                        jal, beq, bne, blt, bge, bltu, bgeu,
                        lb_i, lh_i, lw_i, lbu_i, lhu_i, sb_i, sh_i, sw_i, lb_r, lh_r, lw_r, lbu_r, lhu_r, sb_r, sh_r, sw_r,
                        andn_r, orn_r, xnor_r, clz, ctz, cpop, max, maxu, min, minu, sext_b, sext_h, zext_h, rol_r, ror_r, ror_i, orcv_b, rev8,
                        sp_r, lp_r, sv, rst, qdtb, qdth, qdtw, qdtd, qpi, gcp, pop, rtlib, cpfc, check, sp_i, lp_i, jlib, alc, alci_p, alci_d, alci, pushg, pusht, push, 
                        lui, ebreak, auipc,
                        illegal);
    type imm_T is (none, i_type, s_type, b_type, u_type, j_type, shamt_type);


    subtype OPC_RANGE is natural range 6 downto 0;
    subtype FUNCT3_RANGE is natural range 14 downto 12;
    subtype FUNCT5_RANGE is natural range 24 downto 20;
    subtype FUNCT7_RANGE is natural range 31 downto 25;

    subtype IMM12_RANGE is natural range 31 downto 20;
    subtype IMM20_RANGE is natural range 31 downto 12;

    subtype RS1_RANGE is natural range 19 downto 15;
    subtype RS2_RANGE is natural range 24 downto 20;
    subtype RD_RANGE is natural range 11 downto 7;

    subtype imm_20bit_T is std_logic_vector(IMM20_RANGE'high - 1 downto 0);

    constant OPC_ALU_I:     std_logic_vector(OPC_RANGE) := "0010011";
    constant OPC_ALU_R:     std_logic_vector(OPC_RANGE) := "0110011";
    constant OPC_LUI:       std_logic_vector(OPC_RANGE) := "0110111";
    constant OPC_JAL:       std_logic_vector(OPC_RANGE) := "1101111";
    constant OPC_JALR:      std_logic_vector(OPC_RANGE) := "1100111";
    constant OPC_AUIPC:     std_logic_vector(OPC_RANGE) := "0010111";
    constant OPC_BRANCH:    std_logic_vector(OPC_RANGE) := "1100011";
    constant OPC_LOAD:      std_logic_vector(OPC_RANGE) := "0000011";
    constant OPC_STORE:     std_logic_vector(OPC_RANGE) := "0100011";
    constant OPC_OR:        std_logic_vector(OPC_RANGE) := "0001011";
    constant OPC_SYSTEM:    std_logic_vector(OPC_RANGE) := "1110011";

    -- RV32I
    constant F3_ADD_SUB:   std_logic_vector(FUNCT3_RANGE) := "000";
    constant F3_SLL:       std_logic_vector(FUNCT3_RANGE) := "001";
    constant F3_SLT:       std_logic_vector(FUNCT3_RANGE) := "010";
    constant F3_SLTU:      std_logic_vector(FUNCT3_RANGE) := "011";
    constant F3_XOR:       std_logic_vector(FUNCT3_RANGE) := "100";
    constant F3_SRL_SRA:   std_logic_vector(FUNCT3_RANGE) := "101";
    constant F3_OR:        std_logic_vector(FUNCT3_RANGE) := "110";
    constant F3_AND:       std_logic_vector(FUNCT3_RANGE) := "111";

    constant F3_BEQ:       std_logic_vector(FUNCT3_RANGE) := "000";
    constant F3_BNE:       std_logic_vector(FUNCT3_RANGE) := "001";
    constant F3_BLT:       std_logic_vector(FUNCT3_RANGE) := "100";
    constant F3_BGE:       std_logic_vector(FUNCT3_RANGE) := "101";
    constant F3_BLTU:      std_logic_vector(FUNCT3_RANGE) := "110";
    constant F3_BGEU:      std_logic_vector(FUNCT3_RANGE) := "111";

    constant F3_BYTE:      std_logic_vector(FUNCT3_RANGE) := "000";
    constant F3_HALF:      std_logic_vector(FUNCT3_RANGE) := "001";
    constant F3_WORD:      std_logic_vector(FUNCT3_RANGE) := "010";
    constant F3_BYTEU:     std_logic_vector(FUNCT3_RANGE) := "100";
    constant F3_HALFU:     std_logic_vector(FUNCT3_RANGE) := "101";
    constant F3_REG:       std_logic_vector(FUNCT3_RANGE) := "111";

    constant F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU:   std_logic_vector(FUNCT7_RANGE) := "0000000";
    constant F7_SUB_SRA:   std_logic_vector(FUNCT7_RANGE) := "0100000";

    -- ZBB extension
    constant F3_ANDN_MAXU:              std_logic_vector(FUNCT3_RANGE) := "111";
    constant F3_ORN_MAX:                std_logic_vector(FUNCT3_RANGE) := "110";
    constant F3_XNOR_MIN_ZEXT:          std_logic_vector(FUNCT3_RANGE) := "100";
    constant F3_MINU_ROR_RORI_ORC_REV:  std_logic_vector(FUNCT3_RANGE) := "101";
    constant F3_ROL_CTZ_CPOP_SEXT:      std_logic_vector(FUNCT3_RANGE) := "001";
    
    constant F7_ANDN_ORN_XNOR:              std_logic_vector(FUNCT7_RANGE) := "0100000";
    constant F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR:  std_logic_vector(FUNCT7_RANGE) := "0110000";
    constant F7_MAX_MAXU_MIN_MINU:          std_logic_vector(FUNCT7_RANGE) := "0000101";
    constant F7_ZEXT:                       std_logic_vector(FUNCT7_RANGE) := "0000100";
    constant F7_ORC:                        std_logic_vector(FUNCT7_RANGE) := "0010100";
    constant F7_REV8:                       std_logic_vector(FUNCT7_RANGE) := "0110100";

    constant F5_CLZ_ZEXT:             std_logic_vector(FUNCT5_RANGE) := "00000";
    constant F5_CTZ:                  std_logic_vector(FUNCT5_RANGE) := "00001";
    constant F5_CPOP:                 std_logic_vector(FUNCT5_RANGE) := "00010";
    constant F5_SEXTB:                std_logic_vector(FUNCT5_RANGE) := "00100";
    constant F5_SEXTH:                std_logic_vector(FUNCT5_RANGE) := "00101";
    constant F5_ORC:                  std_logic_vector(FUNCT5_RANGE) := "00111";
    constant F5_REV8:                 std_logic_vector(FUNCT5_RANGE) := "11000";


    --ZOR extension
    constant F3_ZEROS:      std_logic_vector(FUNCT3_RANGE) := "000";
    constant F3_SP:         std_logic_vector(FUNCT3_RANGE) := "001";
    constant F3_LP:         std_logic_vector(FUNCT3_RANGE) := "010";
    constant F3_JLIB:       std_logic_vector(FUNCT3_RANGE) := "011";
    constant F3_ALC:        std_logic_vector(FUNCT3_RANGE) := "100";
    constant F3_ALCIP:      std_logic_vector(FUNCT3_RANGE) := "101";
    constant F3_ALCID:      std_logic_vector(FUNCT3_RANGE) := "110";
    constant F3_ALCI_PUSH:  std_logic_vector(FUNCT3_RANGE) := "111";

    constant F5_ALCI:       std_logic_vector(FUNCT5_RANGE) := "00000";
    constant F5_PUSHG:      std_logic_vector(FUNCT5_RANGE) := "00010";
    constant F5_PUSH:       std_logic_vector(FUNCT5_RANGE) := "00011";

    constant F7_SPR:        std_logic_vector(FUNCT7_RANGE) := "0000000";
    constant F7_LPR:        std_logic_vector(FUNCT7_RANGE) := "0000001";
    constant F7_SV:         std_logic_vector(FUNCT7_RANGE) := "0000010";
    constant F7_RST:        std_logic_vector(FUNCT7_RANGE) := "0000011";
    constant F7_QDTB:       std_logic_vector(FUNCT7_RANGE) := "0000100";
    constant F7_QDTH:       std_logic_vector(FUNCT7_RANGE) := "0000101";
    constant F7_QDTW:       std_logic_vector(FUNCT7_RANGE) := "0000110";
    constant F7_QDTD:       std_logic_vector(FUNCT7_RANGE) := "0000111";
    constant F7_QPI:        std_logic_vector(FUNCT7_RANGE) := "0001000";
    constant F7_GCP:        std_logic_vector(FUNCT7_RANGE) := "0001001";
    constant F7_POP:        std_logic_vector(FUNCT7_RANGE) := "0001100";
    constant F7_RTLIB:      std_logic_vector(FUNCT7_RANGE) := "0010001";
    constant F7_CPFC:       std_logic_vector(FUNCT7_RANGE) := "0010010";
    constant F7_CHECK:      std_logic_vector(FUNCT7_RANGE) := "0010011";

    --ZRI extension
    constant F7_BYTE:                       std_logic_vector(FUNCT7_RANGE) := "0000000";
    constant F7_HALF:                       std_logic_vector(FUNCT7_RANGE) := "0000001";
    constant F7_WORD:                       std_logic_vector(FUNCT7_RANGE) := "0000010";
    constant F7_BYTEU:                      std_logic_vector(FUNCT7_RANGE) := "1000000";
    constant F7_HALFU:                      std_logic_vector(FUNCT7_RANGE) := "1000001";


    type alu_mode_T is (alu_add, alu_sub, alu_sll, alu_slt, alu_sltu, alu_xor, alu_srl, alu_sra, alu_or, alu_and, 
                        alu_andn, alu_orn, alu_xnor, alu_clz, alu_ctz, alu_cpop, alu_max, alu_maxu, alu_min, alu_minu, alu_sextb, alu_sexth, alu_zexth, alu_rol, alu_ror, alu_orcb, alu_rev8,
                        alu_illegal);
    type alu_in_sel_T is (DAT, PTRVAL, PTRPI, PTRDT, AUX, IMM, PGU, PC);
    type pgu_mode_T is (pgu_alc, pgu_alcp, pgu_alcd, pgu_alci, pgu_push, pgu_pusht, pgu_pushg, pgu_dat_i, pgu_dat_r, pgu_ptr_i, pgu_ptr_r, pgu_nop);
    type mem_mode_T is (lb, lbu, lh, lhu, lw, sb, sh, sw, lp, sp, store, store_rix, store_rcd, store_attr, load_rix, load_rcd, holiday);
    type at_mode_T is (yes, no);
    type branch_mode_T is (jal, jalr, beq, bne, blt, bge, bltu, bgeu, no_branch);

    type ctrl_sig_T is record 
        alu_mode:       alu_mode_T;
        alu_a_sel:      alu_in_sel_T;
        alu_b_sel:      alu_in_sel_T;
        mnemonic:       mnemonic_T;
        pgu_mode:       pgu_mode_T;
        me_mode:        mem_mode_T;
        at_mode:        at_mode_T;
        branch_mode:    branch_mode_T;
    end record ctrl_sig_T;
    constant CTRL_NULL: ctrl_sig_T := (alu_mode => alu_illegal, branch_mode => no_branch, alu_a_sel => DAT, alu_b_sel => DAT, mnemonic => nop, me_mode => holiday, at_mode => no, pgu_mode => pgu_nop);
    
    type decode_T is record 
        mnemonic:       mnemonic_T;
        alu_mode:       alu_mode_T;
        alu_a_sel:      alu_in_sel_T;
        alu_b_sel:      alu_in_sel_T;
        pgu_mode:       pgu_mode_T;
        me_mode:        mem_mode_T;
        at_mode:        at_mode_T;
        rdst:           reg_ix_T;
        rdat:           reg_ix_T;
        rptr:           reg_ix_T;
        raux:           reg_ix_T;
        imm_mode:       imm_T;
        branch_mode:    branch_mode_T;
    end record decode_T;
    
    type alu_flags_T is record
      eq: boolean;
      altb: boolean;
      altbu: boolean;
    end record alu_flags_T;

    pure function decodeOpc(instruction: std_logic_vector(31 downto 0)) return decode_T;
    pure function extractJTypeImm(inst: word_T) return word_T;
    pure function extractSTypeImm(inst: word_T) return word_T;
    pure function extractBTypeImm(inst: word_T) return word_T;
    
END isa;
