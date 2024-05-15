--
-- VHDL Package Body riscvio_lib.isa
--
-- Created:
--          by - leylknci.meyer (pc038)
--          at - 19:13:32 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
PACKAGE BODY isa IS


    pure function decodeOpc(instruction: std_logic_vector(31 downto 0)) return ctrl_sig_T is
        variable res: ctrl_sig_T;
    begin
        res.imm_mode := none;
        case instruction(OPC_RANGE) is
            when OPC_ALU_R => 
                res.imm_mode := none;
                res.me_mode  := holiday;
                res.at_mode  := holiday;
                case instruction(FUNCT3_RANGE) is
                    when F3_ADD_SUB =>
                        case instruction(FUNCT7_RANGE) is 
                            when F7_ADD_SRL =>
                                res.mnemonic := add_r;
                                res.alu_mode := alu_add;
                            when F7_SUB_SRA =>
                                res.mnemonic := sub_r;
                                res.alu_mode := alu_sub;
                            when others =>
                                res.mnemonic := illegal;
                                res.alu_mode := alu_illegal;
                        end case;
                    when F3_SRL_SRA =>
                        case instruction(FUNCT7_RANGE) is 
                            when F7_ADD_SRL =>
                                res.mnemonic := srl_r;
                                res.alu_mode := alu_srl;
                            when F7_SUB_SRA =>
                                res.mnemonic := sra_r;
                                res.alu_mode := alu_sra;
                            when others =>
                                res.mnemonic := illegal;
                                res.alu_mode := alu_illegal;
                        end case;
                    when F3_SLL =>
                        res.mnemonic := sll_r;
                        res.alu_mode := alu_sll;
                    when F3_SLT =>
                        res.mnemonic := slt_r;
                        res.alu_mode := alu_slt;
                    when F3_SLTU =>
                        res.mnemonic := sltu_r;
                        res.alu_mode := alu_sltu;
                    when F3_XOR =>
                        res.mnemonic := xor_r;
                        res.alu_mode := alu_xor;
                    when F3_OR =>
                        res.mnemonic := or_r;
                        res.alu_mode := alu_or;
                    when F3_AND =>
                        res.mnemonic := and_r;
                        res.alu_mode := alu_and;
                    when F3_ANDN_MAXU =>
                        res.mnemonic := andn_r when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else maxu;
                        res.alu_mode := alu_andn when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else alu_maxu;
                    when F3_ORN_MAX =>
                        res.mnemonic := orn_r when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else max;
                        res.alu_mode := alu_orn when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else alu_max;
                    when F3_XNOR_MIN_ZEXT =>
                        res.mnemonic := xnor_r when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else zext_h when instruction(RS2_RANGE) = F5_CLZ_ZEXT else min;
                        res.alu_mode := alu_xnor when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else alu_zexth when instruction(RS2_RANGE) = F5_CLZ_ZEXT else alu_min;
                    when F3_MINU_ROR =>
                        res.mnemonic := minu when instruction(FUNCT7_RANGE) = F7_MAX_MAXU_MIN_MINU else ror_r;
                        res.alu_mode := alu_minu when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else alu_ror;
                    when F3_ROL_CTZ_CPOP_SEXT =>
                        res.mnemonic := rol_r;
                        res.alu_mode := alu_rol;
                    when others =>
                        res.mnemonic := illegal;
                        res.alu_mode := alu_illegal;
                end case;

            when OPC_ALU_I => 
                res.imm_mode := i_type;
                res.me_mode  := holiday;
                res.at_mode  := holiday;
                case instruction(FUNCT3_RANGE) is
                    when F3_ADD_SUB =>
                        res.mnemonic := nop when instruction = NOP_INSTR else add_i;
                        res.alu_mode := alu_add;
                    when F3_SRL_SRA =>
                        case instruction(FUNCT7_RANGE) is 
                            when F7_ADD_SRL =>
                                res.mnemonic := srl_i;
                                res.alu_mode := alu_srl;
                            when F7_SUB_SRA =>
                                res.mnemonic := sra_i;
                                res.alu_mode := alu_sra;
                            when others =>
                                res.mnemonic := illegal;
                                res.alu_mode := alu_illegal;
                        end case;
                    when F3_SLL =>
                        res.mnemonic := sll_i;
                        res.alu_mode := alu_sll;
                    when F3_SLT =>
                        res.mnemonic := slt_i;
                        res.alu_mode := alu_slt;
                    when F3_SLTU =>
                        res.mnemonic := sltu_i;
                        res.alu_mode := alu_sltu;
                    when F3_XOR =>
                        res.mnemonic := xor_i;
                        res.alu_mode := alu_xor;
                    when F3_OR =>
                        res.mnemonic := or_i;
                        res.alu_mode := alu_or;
                    when F3_AND =>
                        res.mnemonic := and_i;
                        res.alu_mode := alu_and;
                    when F3_ROL_CTZ_CPOP_SEXT =>
                        if instruction(FUNCT7_RANGE) = F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR then
                            case instruction(RS2_RANGE) is
                                when F5_CLZ_ZEXT => res.mnemonic := clz;
                                                    res.alu_mode := alu_clz;
                                when F5_CTZ =>      res.mnemonic := ctz;
                                                    res.alu_mode := alu_ctz;
                                when F5_CPOP =>     res.mnemonic := cpop;
                                                    res.alu_mode := alu_cpop;
                                when F5_SEXTB =>    res.mnemonic := sext_b;
                                                    res.alu_mode := alu_sextb;
                                when F5_SEXTH =>    res.mnemonic := sext_h;
                                                    res.alu_mode := alu_sexth;
                            end case;
                        elsif instruction(FUNCT7_RANGE) = F7_ORC and instruction(RS2_RANGE) = F5_ORC then
                            res.mnemonic := orcv_b;
                            res.alu_mode := alu_orscb;
                        elsif instruction(FUNCT7_RANGE) = F7_REV8 and instruction(RS2_RANGE) = F5_REV8 then
                            res.mnemonic := rev8;
                            res.alu_mode := alu_rev8;
                        end if;
                    when others =>
                        res.mnemonic := illegal;
                        res.alu_mode := alu_illegal;
                end case;
            when OPC_JAL =>
                res.mnemonic := jal;
                res.alu_mode := alu_illegal;
                res.imm_mode := j_type;
                res.me_mode  := holiday;
                res.at_mode  := holiday;
            when OPC_BRANCH =>
                case instruction(FUNCT3_RANGE) is
                    when F3_BEQ  => res.mnemonic := beq;
                    when F3_BNE  => res.mnemonic := bne;
                    when F3_BLT  => res.mnemonic := blt;
                    when F3_BGE  => res.mnemonic := bge;
                    when F3_BLTU => res.mnemonic := bltu;
                    when F3_BGEU => res.mnemonic := bgeu;
                end case;
                res.alu_mode := alu_add;
                res.imm_mode := b_type;
                res.me_mode  := holiday;
                res.at_mode  := holiday;
            when OPC_LOAD =>
                case instruction(FUNCT3_RANGE) is
                    when F3_BYTE  => res.mnemonic := lb_i;
                    when F3_HALF  => res.mnemonic := lh_i;
                    when F3_WORD  => res.mnemonic := lw_i;
                    when F3_BYTEU => res.mnemonic := lbu_i;
                    when F3_HALFU => res.mnemonic := lhu_i;
                    when F3_REG   => res.mnemonic := illegal;
                end case;
                res.alu_mode := alu_add;
                res.imm_mode := i_type;
                res.me_mode  := load;
                res.at_mode  := holiday;
            when OPC_STORE =>
                case instruction(FUNCT3_RANGE) is
                    when F3_BYTE  => res.mnemonic := sb_i;
                    when F3_HALF  => res.mnemonic := sh_i;
                    when F3_WORD  => res.mnemonic := sw_i;
                    when F3_REG   => res.mnemonic := illegal;
                end case;
                res.alu_mode := alu_add;
                res.imm_mode := s_type;
                res.me_mode  := store;
                res.at_mode  := holiday;
            when others =>
                res.mnemonic := illegal;
                res.alu_mode := alu_illegal;
                res.imm_mode := none;
                res.me_mode  := holiday;
                res.at_mode  := holiday;
        end case;
        return res;
    end function decodeOpc;

    pure function extractJTypeImm(inst: word_T) return word_T is
        variable res: word_T;
    begin
        res := (0 => '0', others => inst(31));
        res(19 downto 12) := inst(19 downto 12);
        res(11) := inst(20);
        res(10 downto 1) := inst(30 downto 21);
        return res;
    end function extractJTypeImm;


    pure function extractBTypeImm(inst: word_T) return word_T is
        variable res: word_T;
    begin
        res := (0 => '0', others => inst(31));
        res(10 downto 5) := inst(30 downto 25);
        res(11) := inst(7);
        res(4 downto 1) := inst(11 downto 8);
        return res;
    end function extractBTypeImm;

    pure function extractSTypeImm(inst: word_T) return word_T is
        variable res: word_T;
    begin
        res := (others => inst(31));
        res(10 downto 5) := inst(30 downto 25);
        res(4 downto 0) := inst(11 downto 7);
        return res;
    end function extractSTypeImm;

END isa;
