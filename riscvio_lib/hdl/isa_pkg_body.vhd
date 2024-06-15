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


    pure function decodeOpc(instruction: std_logic_vector(31 downto 0)) return decode_T is
        variable res: decode_T;
    begin
        res.imm_mode := none;
        res.pgu_mode := pgu_nop;
        case instruction(OPC_RANGE) is
            when OPC_ALU_R => 
                res.imm_mode := none;
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                res.rdat     := to_integer(unsigned(instruction(RS1_RANGE)));
                res.rptr     := 0;
                res.raux     := to_integer(unsigned(instruction(RS2_RANGE)));
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= AUX;
                res.pgu_mode := pgu_nop;
                case instruction(FUNCT3_RANGE) is
                    when F3_ADD_SUB =>
                        case instruction(FUNCT7_RANGE) is 
                            when F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU =>
                                res.mnemonic := add_r;
                                res.alu_mode := alu_add;
                            when F7_SUB_SRA =>
                                res.mnemonic := sub_r;
                                res.alu_mode := alu_sub;
                            when others =>
                                res.mnemonic := illegal;
                                res.alu_mode := alu_illegal;
                        end case;
                    when (F3_SRL_SRA or F3_MINU_ROR_RORI_ORC_REV) =>
                        res.mnemonic := srl_r when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else 
                                        sra_i when instruction(FUNCT7_RANGE) = F7_SUB_SRA else 
                                        minu when instruction(FUNCT7_RANGE) = F7_MAX_MAXU_MIN_MINU else 
                                        ror_r when instruction(FUNCT7_RANGE) = F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR else
                                        illegal;
                        res.alu_mode := alu_srl when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else 
                                        alu_sra when instruction(FUNCT7_RANGE) = F7_SUB_SRA else 
                                        alu_minu when instruction(FUNCT7_RANGE) = F7_MAX_MAXU_MIN_MINU else 
                                        alu_ror when instruction(FUNCT7_RANGE) = F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR else
                                        alu_illegal;
                    when (F3_SLL or F3_ROL_CTZ_CPOP_SEXT) =>
                        res.mnemonic := rol_r when instruction(FUNCT7_RANGE) = F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR else sll_r;
                        res.alu_mode := alu_rol when instruction(FUNCT7_RANGE) = F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR else alu_sll;
                    when F3_SLT =>
                        res.mnemonic := slt_r;
                        res.alu_mode := alu_slt;
                    when F3_SLTU =>
                        res.mnemonic := sltu_r;
                        res.alu_mode := alu_sltu;
                    when (F3_XOR or F3_XNOR_MIN_ZEXT) =>
                        res.mnemonic := xor_r when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else 
                                        xnor_r when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else 
                                        min when instruction(FUNCT7_RANGE) = F7_MAX_MAXU_MIN_MINU else
                                        zext_h when (instruction(FUNCT7_RANGE) = F7_ZEXT and instruction(RS2_RANGE) = F5_CLZ_ZEXT) else 
                                        illegal;
                        res.alu_mode := alu_xor when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else 
                                        alu_xnor when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else 
                                        alu_min when instruction(FUNCT7_RANGE) = F7_MAX_MAXU_MIN_MINU else
                                        alu_zexth when (instruction(FUNCT7_RANGE) = F7_ZEXT and instruction(RS2_RANGE) = F5_CLZ_ZEXT) else 
                                        alu_illegal;
                    when (F3_OR or F3_ORN_MAX) =>
                        res.mnemonic := or_r when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else 
                                        orn_r when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else 
                                        max when instruction(FUNCT7_RANGE) = F7_MAX_MAXU_MIN_MINU else
                                        illegal;
                        res.alu_mode := alu_or when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else 
                                        alu_orn when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else 
                                        alu_max when instruction(FUNCT7_RANGE) = F7_MAX_MAXU_MIN_MINU else
                                        alu_illegal;
                    when F3_AND =>
                        res.mnemonic := and_r when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else
                                        andn_r when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else 
                                        maxu when instruction(FUNCT7_RANGE) = F7_MAX_MAXU_MIN_MINU else
                                        illegal;
                        res.alu_mode := alu_and when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else
                                        alu_andn when instruction(FUNCT7_RANGE) = F7_ANDN_ORN_XNOR else 
                                        alu_maxu when instruction(FUNCT7_RANGE) = F7_MAX_MAXU_MIN_MINU else
                                        alu_illegal;
                    when others =>
                        res.mnemonic := illegal;
                        res.alu_mode := alu_illegal;
                end case;

            when OPC_ALU_I => 
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                res.rdat     := to_integer(unsigned(instruction(RS1_RANGE)));
                res.rptr     := 0;
                res.raux     := 0;
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= IMM;
                res.pgu_mode := pgu_nop;
                case instruction(FUNCT3_RANGE) is
                    when F3_ADD_SUB =>
                        res.mnemonic := nop when instruction = NOP_INSTR else add_i;
                        res.alu_mode := alu_add;
                        res.imm_mode := i_type;
                    when (F3_SRL_SRA or F3_MINU_ROR_RORI_ORC_REV) =>
                        res.mnemonic := srl_i when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else
                                        sra_i when instruction(FUNCT7_RANGE) = F7_SUB_SRA else
                                        ror_i when instruction(FUNCT7_RANGE) = F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR else
                                        orcv_b when instruction(FUNCT7_RANGE) = F7_ORC and instruction(RS2_RANGE) = F5_ORC else 
                                        rev8 when instruction(FUNCT7_RANGE) = F7_REV8 and instruction(RS2_RANGE) = F5_REV8 else 
                                        illegal;
                        res.alu_mode := alu_srl when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else
                                        alu_sra when instruction(FUNCT7_RANGE) = F7_SUB_SRA else
                                        alu_ror when instruction(FUNCT7_RANGE) = F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR else
                                        alu_orcb when instruction(FUNCT7_RANGE) = F7_ORC and instruction(RS2_RANGE) = F5_ORC else 
                                        alu_rev8 when instruction(FUNCT7_RANGE) = F7_REV8 and instruction(RS2_RANGE) = F5_REV8 else 
                                        alu_illegal;
                        res.imm_mode := shamt_type when instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU else
                                        shamt_type when instruction(FUNCT7_RANGE) = F7_SUB_SRA else
                                        shamt_type when instruction(FUNCT7_RANGE) = F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR else
                                        i_type when instruction(FUNCT7_RANGE) = F7_ORC and instruction(RS2_RANGE) = F5_ORC else 
                                        i_type when instruction(FUNCT7_RANGE) = F7_REV8 and instruction(RS2_RANGE) = F5_REV8 else 
                                        none;
                    when F3_SLT =>
                        res.mnemonic := slt_i;
                        res.alu_mode := alu_slt;
                        res.imm_mode := i_type;
                    when F3_SLTU =>
                        res.mnemonic := sltu_i;
                        res.alu_mode := alu_sltu;
                        res.imm_mode := i_type;
                    when F3_XOR =>
                        res.mnemonic := xor_i;
                        res.alu_mode := alu_xor;
                        res.imm_mode := i_type;
                    when F3_OR =>
                        res.mnemonic := or_i;
                        res.alu_mode := alu_or;
                        res.imm_mode := i_type;
                    when F3_AND =>
                        res.mnemonic := and_i;
                        res.alu_mode := alu_and;
                        res.imm_mode := i_type;
                    when (F3_SLL or F3_ROL_CTZ_CPOP_SEXT) =>
                        if instruction(FUNCT7_RANGE) = F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU then
                            res.mnemonic := sll_i;
                            res.alu_mode := alu_sll;
                            res.imm_mode := shamt_type;
                        elsif instruction(FUNCT7_RANGE) = F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR then
                            res.imm_mode := i_type;
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
                                when others =>      res.mnemonic := illegal;
                                                    res.alu_mode := alu_illegal;
                            end case;
                        end if;
                    when others =>
                        res.mnemonic := illegal;
                        res.alu_mode := alu_illegal;
                        res.imm_mode := none;
                end case;
            when OPC_JAL =>
                res.mnemonic := jal;
                res.alu_mode := alu_illegal;
                res.imm_mode := j_type;
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := 1 when to_integer(unsigned(instruction(RD_RANGE))) = 1 else 0; --only rix or zero are allowed!
                res.rdat     := 0; 
                res.rptr     := 2; --frame
                res.raux     := 0;
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= IMM;
                res.pgu_mode := pgu_nop;
            when OPC_BRANCH =>
                res.alu_mode := alu_add;
                res.imm_mode := b_type;
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := 0;
                res.rdat     := to_integer(unsigned(instruction(RS1_RANGE)));
                res.rptr     := 0;
                res.raux     := to_integer(unsigned(instruction(RS2_RANGE)));
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= AUX;
                res.pgu_mode := pgu_nop;
                case instruction(FUNCT3_RANGE) is
                    when F3_BEQ  => res.mnemonic := beq;
                    when F3_BNE  => res.mnemonic := bne;
                    when F3_BLT  => res.mnemonic := blt;
                    when F3_BGE  => res.mnemonic := bge;
                    when F3_BLTU => res.mnemonic := bltu;
                    when F3_BGEU => res.mnemonic := bgeu;
                    when others =>  res.mnemonic := illegal;
                end case;
            when OPC_LOAD =>
                res.alu_mode := alu_add;
                res.imm_mode := i_type when instruction(FUNCT3_RANGE) /= "111" else none;
                res.at_mode  := no;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                res.rdat     := to_integer(unsigned(instruction(RS2_RANGE))) when instruction(FUNCT3_RANGE) = "111" else 0;
                res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                res.raux     := 0;
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= AUX when instruction(FUNCT3_RANGE) = "111" else IMM;
                res.pgu_mode := pgu_dat_r when instruction(FUNCT3_RANGE) = "111" else pgu_dat_i;
                case instruction(FUNCT3_RANGE) is
                    when F3_BYTE  => res.mnemonic := lb_i;
                                     res.me_mode  := lb;
                    when F3_HALF  => res.mnemonic := lh_i;
                                     res.me_mode  := lh;
                    when F3_WORD  => res.mnemonic := lw_i;
                                     res.me_mode  := lw;
                    when F3_BYTEU => res.mnemonic := lbu_i;
                                     res.me_mode  := lbu;
                    when F3_HALFU => res.mnemonic := lhu_i;
                                     res.me_mode  := lhu;
                    when F3_REG   => res.mnemonic := lb_r when instruction(FUNCT7_RANGE) = F7_BYTE else
                                                     lh_r when instruction(FUNCT7_RANGE) = F7_HALF else
                                                     lw_r when instruction(FUNCT7_RANGE) = F7_WORD else
                                                     lbu_r when instruction(FUNCT7_RANGE) = F7_BYTEU else
                                                     lhu_r when instruction(FUNCT7_RANGE) = F7_HALFU else
                                                     illegal;
                                     res.me_mode :=  lb when instruction(FUNCT7_RANGE) = F7_BYTE else
                                                     lh when instruction(FUNCT7_RANGE) = F7_HALF else
                                                     lw when instruction(FUNCT7_RANGE) = F7_WORD else
                                                     lbu when instruction(FUNCT7_RANGE) = F7_BYTEU else
                                                     lhu when instruction(FUNCT7_RANGE) = F7_HALFU else
                                                     holiday;
                    when others =>  res.mnemonic := illegal;
                                    res.me_mode  := holiday;
                end case;
            when OPC_STORE =>
                res.alu_mode := alu_add;
                res.imm_mode := s_type when instruction(FUNCT3_RANGE) /= "111" else none;
                res.at_mode  := no;
                res.rdst     := 0;
                res.raux     := to_integer(unsigned(instruction(RD_RANGE))) when instruction(FUNCT3_RANGE) = "111" else 0;
                res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                res.rdat     := to_integer(unsigned(instruction(RS2_RANGE)));
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= AUX when instruction(FUNCT3_RANGE) = "111" else IMM;
                res.pgu_mode := pgu_dat_r when instruction(FUNCT3_RANGE) = "111" else pgu_dat_i;
                case instruction(FUNCT3_RANGE) is
                    when F3_BYTE  => res.mnemonic := sb_i;
                                     res.me_mode  := sb;
                    when F3_HALF  => res.mnemonic := sh_i;
                                     res.me_mode  := sh;
                    when F3_WORD  => res.mnemonic := sw_i;
                                     res.me_mode  := sw;
                    when F3_REG   => res.mnemonic := sb_r when instruction(FUNCT7_RANGE) = F7_BYTE else
                                                     sh_r when instruction(FUNCT7_RANGE) = F7_HALF else
                                                     sw_r when instruction(FUNCT7_RANGE) = F7_WORD else
                                                     illegal;
                                     res.me_mode :=  sb when instruction(FUNCT7_RANGE) = F7_BYTE else
                                                     sh when instruction(FUNCT7_RANGE) = F7_HALF else
                                                     sw when instruction(FUNCT7_RANGE) = F7_WORD else
                                                     holiday;
                    when others =>  res.mnemonic := illegal;
                                    res.me_mode  := holiday;
                end case;
            when OPC_OR =>
                res.alu_mode := alu_add;
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                res.rdat     := to_integer(unsigned(instruction(RS1_RANGE))) when instruction(FUNCT3_RANGE) = F3_ALCI_PUSH or instruction(FUNCT3_RANGE) = F3_ALC or instruction(FUNCT3_RANGE) = F3_ALCID or instruction(FUNCT3_RANGE) = F3_ALCIP else 
                                ali_T'pos(rix);
                res.rptr     := ali_T'pos(frame) when res.rdst = ali_T'pos(frame) else ali_T'pos(alc_addr);
                res.raux     := to_integer(unsigned(instruction(RS2_RANGE))) when instruction(FUNCT3_RANGE) = F3_ALC else 
                                to_integer(unsigned(instruction(RS1_RANGE))) when instruction(FUNCT3_RANGE) = F3_ALCI_PUSH else   
                                0;
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= AUX when instruction(FUNCT3_RANGE) = "111" else IMM;
                case instruction(FUNCT3_RANGE) is
                    when F3_ALC  =>         res.mnemonic := alc;
                                            res.pgu_mode := pgu_alc;
                                            res.imm_mode := none;
                    when F3_ALCIP  =>       res.mnemonic := alci_p;
                                            res.pgu_mode := pgu_alcp;
                                            res.imm_mode := i_type;
                    when F3_ALCID  =>       res.mnemonic := alci_d;
                                            res.pgu_mode := pgu_alcd;
                                            res.imm_mode := i_type;
                    when F3_ALCI_PUSH =>    res.mnemonic := alci when instruction(RS2_RANGE) = F5_ALCI else
                                                            pushg when instruction(RS2_RANGE) = F5_PUSHG else
                                                            pusht when instruction(RS2_RANGE) = F5_PUSHT else
                                                            illegal;
                                            res.pgu_mode := pgu_alci when instruction(RS2_RANGE) = F5_ALCI else
                                                            pgu_pushg when instruction(RS2_RANGE) = F5_PUSHG else
                                                            pgu_pusht when instruction(RS2_RANGE) = F5_PUSHT else
                                                            pgu_nop;
                                            res.imm_mode := s_type;
                                            res.rdst     := to_integer(unsigned(instruction(RS1_RANGE)));
                    when F3_SP =>           res.mnemonic := sp_i;
                                            res.imm_mode := s_type;
                                            res.me_mode  := sp;
                                            res.at_mode  := no;
                                            res.rdst     := 0;
                                            res.raux     := to_integer(unsigned(instruction(RS2_RANGE)));
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            --res.rdat     := to_integer(unsigned(instruction(RS2_RANGE)));
                                            res.pgu_mode := pgu_ptr_i;
                    when F3_LP =>           res.mnemonic := lp_i;
                                            res.imm_mode := i_type;
                                            res.me_mode  := lp;
                                            res.at_mode  := yes;
                                            res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                            res.raux     := 0;
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            --res.rdat     := to_integer(unsigned(instruction(RS2_RANGE)));
                                            res.pgu_mode := pgu_ptr_i;
                    when F3_ZEROS =>
                        case instruction(FUNCT7_RANGE) is
                            when F7_SPR =>  res.mnemonic := sp_r;
                                            res.imm_mode := none;
                                            res.me_mode  := sp;
                                            res.at_mode  := no;
                                            res.rdst     := 0;
                                            res.raux     := to_integer(unsigned(instruction(RD_RANGE)));
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.rdat     := to_integer(unsigned(instruction(RS2_RANGE)));
                                            res.pgu_mode := pgu_ptr_r;
                            when F7_LPR =>  res.mnemonic := lp_r;
                                            res.imm_mode := none;
                                            res.me_mode  := lp;
                                            res.at_mode  := yes;
                                            res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                            res.raux     := 0;
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.rdat     := to_integer(unsigned(instruction(RS2_RANGE)));
                                            res.pgu_mode := pgu_ptr_r;
                            when others =>  res.mnemonic := illegal;
                                            res.pgu_mode := pgu_nop;
                                            res.imm_mode := none;
                        end case;
                    when others =>          res.mnemonic := illegal;
                                            res.pgu_mode := pgu_nop;
                                            res.imm_mode := none;
                end case;
            when OPC_SYSTEM => 
                report "test done" severity failure;


            when OPC_LUI => 
                res.mnemonic := lui;
                res.alu_mode := alu_add;
                res.imm_mode := u_type;
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                res.rdat     := 0;
                res.rptr     := 0;
                res.raux     := 0;
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= IMM;
                res.pgu_mode := pgu_nop;

            when others =>
                res.mnemonic := illegal;
                res.alu_mode := alu_illegal;
                res.imm_mode := none;
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := 0;
                res.rdat     := 0;
                res.rptr     := 0;
                res.raux     := 0;
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= AUX;
                res.pgu_mode := pgu_nop;
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
