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

    constant NOP_INSTR: word_T := X"00000013";

    type reg_tag_T is (DATA, POINTER);
    type reg_mem_T is record
      tag: reg_tag_T;
      data: word_T;
      pi: word_T;
      delta: word_T;
    end record reg_mem_T;
    constant REG_MEM_NULL: reg_mem_T := (tag => DATA, data => (others => '0'), pi => (others => '0'), delta => (others => '0'));
    
    subtype reg_ix_T is natural range 0 to 31;
    type reg_alias_T is (zero, rix, frame, rcd, ctxt, cnst, t0, t1, t2, t3, t4, t5, t6, a0, a1, a2, a3, a4, a5, a6, a7, s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, imm);
    type reg_T is record
        reg_alias: reg_alias_T;
        reg_index: reg_ix_T;
        mem: reg_mem_T;
    end record reg_T;
    constant REG_NULL: reg_T := (reg_alias => zero, reg_index => 0, mem => REG_MEM_NULL);

    type mnemonic_T is (nop, add_i, add_r, sub_r, sll_i, sll_r, slt_r, slt_i, sltu_i, sltu_r, xor_i, xor_r, srl_i, srl_r, sra_i, sra_r, or_i, or_r, and_i, and_r, jal, beq, bne, blt, bge, bltu, bgeu, illegal);
    type imm_T is (none, i_type, s_type, b_type, u_type, j_type);

    subtype OPC_RANGE is natural range 6 downto 0;
    subtype FUNCT3_RANGE is natural range 14 downto 12;
    subtype FUNCT7_RANGE is natural range 31 downto 25;

    subtype IMM12_RANGE is natural range 31 downto 20;
    subtype IMM20_RANGE is natural range 31 downto 12;

    subtype RS1_RANGE is natural range 19 downto 15;
    subtype RS2_RANGE is natural range 24 downto 20;
    subtype RD_RANGE is natural range 11 downto 7;

    subtype imm_20bit_T is std_logic_vector(IMM20_RANGE'high - 1 downto 0);

    constant OPC_ALU_I: std_logic_vector(OPC_RANGE) := "0010011";
    constant OPC_ALU_R: std_logic_vector(OPC_RANGE) := "0110011";
    constant OPC_JAL:   std_logic_vector(OPC_RANGE) := "1101111";

    constant F3_ADD_SUB:   std_logic_vector(FUNCT3_RANGE) := "000";
    constant F3_SLL:       std_logic_vector(FUNCT3_RANGE) := "001";
    constant F3_SLT:       std_logic_vector(FUNCT3_RANGE) := "010";
    constant F3_SLTU:      std_logic_vector(FUNCT3_RANGE) := "011";
    constant F3_XOR:       std_logic_vector(FUNCT3_RANGE) := "100";
    constant F3_SRL_SRA:   std_logic_vector(FUNCT3_RANGE) := "101";
    constant F3_OR:        std_logic_vector(FUNCT3_RANGE) := "110";
    constant F3_AND:       std_logic_vector(FUNCT3_RANGE) := "111";

    constant F7_ADD_SRL:       std_logic_vector(FUNCT7_RANGE) := "0000000";
    constant F7_SUB_SRA:       std_logic_vector(FUNCT7_RANGE) := "0100000";

    type alu_mode_T is (alu_add, alu_sub, alu_sll, alu_slt, alu_sltu, alu_xor, alu_srl, alu_sra, alu_or, alu_and, alu_andn, alu_orn, alu_xnor, alu_clz, alu_ctz, alu_cpop, alu_max, alu_maxu, alu_min, alu_minu, alu_sextb, alu_sexth, alu_zexth, alu_rol, alu_ror, alu_orscb, alu_rev8, alu_illegal);
    type ctrl_sig_T is record 
        alu_mode:       alu_mode_T;
        mnemonic:       mnemonic_T;
        imm_mode:       imm_T;
    end record ctrl_sig_T;
    constant CTRL_NULL: ctrl_sig_T := (alu_mode => alu_illegal, mnemonic => illegal, imm_mode => none);
    
    
    type alu_flags_T is record
      eq: boolean;
      altb: boolean;
      altbu: boolean;
    end record alu_flags_T;

    pure function decodeOpc(instruction: std_logic_vector(31 downto 0)) return ctrl_sig_T;
    pure function extractJTypeImm(inst: word_T) return word_T;
    pure function extractSTypeImm(inst: word_T) return word_T;
    pure function extractBTypeImm(inst: word_T) return word_T;
    
END isa;
