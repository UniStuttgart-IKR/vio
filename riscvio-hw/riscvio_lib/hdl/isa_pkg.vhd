
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
PACKAGE isa IS
    constant DWORD_SIZE: natural := 64;
    constant WORD_SIZE: natural := 32; 
    constant HALF_WORD_SIZE: natural := 16;
    constant BYTE_SIZE: natural := 8;
    constant INSTRUCTION_SIZE: positive := 4;
    constant INDEX_SIZE: natural := 0;
    constant IGNORE_EXC: boolean := false;

    subtype word_T is std_logic_vector(WORD_SIZE - 1 downto 0);
    subtype dword_T is std_logic_vector(DWORD_SIZE - 1 downto 0);
    subtype half_word_T is std_logic_vector(HALF_WORD_SIZE - 1 downto 0);
    subtype byte_T is std_logic_vector(BYTE_SIZE - 1 downto 0);

    subtype WORD0_RANGE is natural range 31 downto 0;
    subtype WORD1_RANGE is natural range 63 downto 32;

    subtype HWORD0_RANGE is natural range 15 downto 0;
    subtype HWORD1_RANGE is natural range 31 downto 16; 
    subtype HWORD2_RANGE is natural range 47 downto 32; 
    subtype HWORD3_RANGE is natural range 63 downto 48; 

    subtype BYTE0_RANGE is natural range 7 downto 0;
    subtype BYTE1_RANGE is natural range 15 downto 8;
    subtype BYTE2_RANGE is natural range 23 downto 16;
    subtype BYTE3_RANGE is natural range 31 downto 24;
    subtype BYTE4_RANGE is natural range 39 downto 32;
    subtype BYTE5_RANGE is natural range 47 downto 40;
    subtype BYTE6_RANGE is natural range 55 downto 48;
    subtype BYTE7_RANGE is natural range 63 downto 56;

    constant NOP_INSTR: word_T := X"00000013";

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

    constant CSR_MEPC_IX:       std_logic_vector(11 downto 0) := X"341";
    constant CSR_MISA_IX:       std_logic_vector(11 downto 0) := X"301";
    constant CSR_MSTATUS_IX:    std_logic_vector(11 downto 0) := X"300";
    constant CSR_MCAUSE_IX:     std_logic_vector(11 downto 0) := X"342";
    constant CSR_MTVAL_IX:      std_logic_vector(11 downto 0) := X"343";
    constant CSR_MTVEC_IX:      std_logic_vector(11 downto 0) := X"305";
    constant CSR_MVENDORID_IX:  std_logic_vector(11 downto 0) := X"F11";
    constant CSR_MARCHID_IX:    std_logic_vector(11 downto 0) := X"F12";
    constant CSR_MIMPID_IX:     std_logic_vector(11 downto 0) := X"F13";


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

    -- SYSTEM
    constant F3_ENV:        std_logic_vector(FUNCT3_RANGE) := "000";
    constant F3_CSRRW:      std_logic_vector(FUNCT3_RANGE) := "001";
    constant F3_CSRRS:      std_logic_vector(FUNCT3_RANGE) := "010";
    constant F3_CSRRC:      std_logic_vector(FUNCT3_RANGE) := "011";

    constant F7_CIOP:       std_logic_vector(FUNCT7_RANGE) := "1111111";
    constant F7_ENV:        std_logic_vector(FUNCT7_RANGE) := "0000000";
    constant F7_MRET:       std_logic_vector(FUNCT7_RANGE) := "0011000";
    constant F5_ECALL:      std_logic_vector(FUNCT5_RANGE) := "00000";
    constant F5_EBREAK:     std_logic_vector(FUNCT5_RANGE) := "00001";

    constant F7_OR:         std_logic_vector(FUNCT7_RANGE) := "1111110";
    constant F7_OR_CIOP:    std_logic_vector(FUNCT7_RANGE) := "1111111";
    constant F5_ALCB:       std_logic_vector(FUNCT5_RANGE) := "00000";
    constant F5_CCP:        std_logic_vector(FUNCT5_RANGE) := "10000";
    constant F5_RPR:        std_logic_vector(FUNCT5_RANGE) := "10001";
    constant F5_QPIR:       std_logic_vector(FUNCT5_RANGE) := "10100";
    constant F5_QDTR:       std_logic_vector(FUNCT5_RANGE) := "10101";
    constant F5_QPTR:       std_logic_vector(FUNCT5_RANGE) := "10110";
    constant F5_SUS:        std_logic_vector(FUNCT5_RANGE) := "00000";

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

    constant F5_ALCI:       std_logic_vector(FUNCT5_RANGE) := "00000";
    constant F5_PUSHG:      std_logic_vector(FUNCT5_RANGE) := "00010";
    constant F5_PUSH:       std_logic_vector(FUNCT5_RANGE) := "00011";

    --ZRI extension
    constant F7_BYTE:                       std_logic_vector(FUNCT7_RANGE) := "0000000";
    constant F7_HALF:                       std_logic_vector(FUNCT7_RANGE) := "0000001";
    constant F7_WORD:                       std_logic_vector(FUNCT7_RANGE) := "0000010";
    constant F7_BYTEU:                      std_logic_vector(FUNCT7_RANGE) := "1000000";
    constant F7_HALFU:                      std_logic_vector(FUNCT7_RANGE) := "1000001";

    type mnemonic_T is (nop, add_i, add_r, sub_r, sll_i, sll_r, slt_r, slt_i, sltu_i, sltu_r, xor_i, xor_r, srl_i, srl_r, sra_i, sra_r, or_i, or_r, and_i, and_r,
                        jal, jalr, beq, bne, blt, bge, bltu, bgeu,
                        lui, auipc,
                        lb_i, lh_i, lw_i, lbu_i, lhu_i, sb_i, sh_i, sw_i, lb_r, lh_r, lw_r, lbu_r, lhu_r, sb_r, sh_r, sw_r,
                        andn_r, orn_r, xnor_r, clz, ctz, cpop, max, maxu, mins, minu, sext_b, sext_h, zext_h, rol_r, ror_r, ror_i, orcv_b, rev8,
                        sp_r, lp_r, sv, rst, qdtb, qdth, qdtw, qdtd, qpi, gcp, pop, rtlib, cpfc, check, sp_i, lp_i, jlib, alc, alci_p, alci_d, alci, pushg, pusht, push, 
                        ebreak, ecall, alcb, ciop, ccp, rpr, qpir, qdtr, qptr, seal, unsl,
                        csrw, csrr, csrs, csrc, mret,
                        illegal);
    type imm_T is (none, i_type, s_type, b_type, u_type, j_type, shamt_type);

    pure function extractJTypeImm(inst: word_T) return word_T;
    pure function extractSTypeImm(inst: word_T) return word_T;
    pure function extractBTypeImm(inst: word_T) return word_T;
    
END isa;
