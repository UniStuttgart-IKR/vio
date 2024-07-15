PACKAGE BODY pipeline IS

    pure function decodeOpc(instruction: std_logic_vector(31 downto 0)) return decode_T is
        variable res: decode_T;
    begin
        res.imm_mode := none;
        res.pgu_mode := pgu_nop;
        res.branch_mode := no_branch;
        res.xret := none;
        res.fwd_allowed := true;
        res.csr_mux_sel := NONE;
        res.ex_res_mux_sel := AUX;
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
                res.ex_res_mux_sel := ALU;
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
                        case instruction(FUNCT7_RANGE) is
                            when F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU =>
                                res.mnemonic := srl_r;
                                res.alu_mode := alu_srl;
                            when F7_SUB_SRA =>
                                res.mnemonic := sra_i;
                                res.alu_mode := alu_sra;
                            when F7_MAX_MAXU_MIN_MINU =>
                                res.mnemonic := minu;
                                res.alu_mode := alu_minu;
                            when F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR =>
                                res.mnemonic := ror_r;
                                res.alu_mode := alu_ror;
                            when others =>
                                res.mnemonic := illegal;
                                res.alu_mode := alu_illegal;
                        end case;
                    when (F3_SLL or F3_ROL_CTZ_CPOP_SEXT) =>
                        if instruction(FUNCT7_RANGE) = F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR then
                            res.mnemonic := rol_r;
                            res.alu_mode := alu_rol;
                        else
                            res.mnemonic := sll_r;
                            res.alu_mode := alu_sll;
                        end if;
                    when F3_SLT =>
                        res.mnemonic := slt_r;
                        res.alu_mode := alu_slt;
                    when F3_SLTU =>
                        res.mnemonic := sltu_r;
                        res.alu_mode := alu_sltu;
                    when (F3_XOR or F3_XNOR_MIN_ZEXT) =>
                        case instruction(FUNCT7_RANGE) is
                            when F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU =>
                                res.mnemonic := xor_r;
                                res.alu_mode := alu_xor;
                            when F7_ANDN_ORN_XNOR =>
                                res.mnemonic := xnor_r;
                                res.alu_mode := alu_xnor;
                            when F7_MAX_MAXU_MIN_MINU =>
                                res.mnemonic := mins;
                                res.alu_mode := alu_min;
                            when F7_ZEXT =>
                                if instruction(RS2_RANGE) = F5_CLZ_ZEXT then
                                    res.mnemonic := zext_h;
                                    res.alu_mode := alu_zexth;
                                else
                                    res.mnemonic := illegal;
                                    res.alu_mode := alu_illegal;
                                end if;
                            when others =>
                                res.mnemonic := illegal;
                                res.alu_mode := alu_illegal;
                        end case;
                    when (F3_OR or F3_ORN_MAX) =>
                        case instruction(FUNCT7_RANGE) is
                            when F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU =>
                                res.mnemonic := or_r;
                                res.alu_mode := alu_or;
                            when F7_ANDN_ORN_XNOR =>
                                res.mnemonic := orn_r;
                                res.alu_mode := alu_orn;
                            when F7_MAX_MAXU_MIN_MINU =>
                                res.mnemonic := max;
                                res.alu_mode := alu_max;
                            when others =>
                                res.mnemonic := illegal;
                                res.alu_mode := alu_illegal;
                        end case;
                    when F3_AND =>
                        case instruction(FUNCT7_RANGE) is
                            when F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU =>
                                res.mnemonic := and_r;
                                res.alu_mode := alu_and;
                            when F7_ANDN_ORN_XNOR =>
                                res.mnemonic := andn_r;
                                res.alu_mode := alu_andn;
                            when F7_MAX_MAXU_MIN_MINU =>
                                res.mnemonic := maxu;
                                res.alu_mode := alu_maxu;
                            when others =>
                                res.mnemonic := illegal;
                                res.alu_mode := alu_illegal;
                        end case;
                    when others =>
                        res.mnemonic := illegal;
                        res.alu_mode := alu_illegal;
                end case;

            when OPC_ALU_I => 
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                res.rdat     := 0;
                res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                res.raux     := to_integer(unsigned(instruction(RS1_RANGE)));
                res.alu_a_sel:= AUX;
                res.alu_b_sel:= IMM;
                res.pgu_mode := pgu_nop;
                res.ex_res_mux_sel := ALU;
                case instruction(FUNCT3_RANGE) is
                    when F3_ADD_SUB =>
                        res.mnemonic := add_i;
                        res.alu_mode := alu_add;
                        res.imm_mode := i_type;
                        res.at_mode  := load_maybe;
                        if instruction = NOP_INSTR then
                            res.mnemonic := nop;
                            res.at_mode  := no;
                        end if;
                    when (F3_SRL_SRA or F3_MINU_ROR_RORI_ORC_REV) =>
                        case instruction(FUNCT7_RANGE) is
                            when F7_ADD_SRL_SLL_XOR_OR_AND_SLT_SLTU =>
                                res.mnemonic := srl_i;
                                res.alu_mode := alu_srl;
                                res.imm_mode := shamt_type;
                            when F7_SUB_SRA =>
                                res.mnemonic := sra_i;
                                res.alu_mode := alu_sra;
                                res.imm_mode := shamt_type;
                            when F7_CLZ_CTZ_CPOP_SEXT_ROL_ROR =>
                                res.mnemonic := ror_i;
                                res.alu_mode := alu_ror;
                                res.imm_mode := shamt_type;
                            when F7_ORC =>
                                if instruction(RS2_RANGE) = F5_ORC then
                                    res.mnemonic := orcv_b;
                                    res.alu_mode := alu_orcb;
                                    res.imm_mode := i_type;
                                else
                                    res.mnemonic := illegal;
                                    res.alu_mode := alu_illegal;
                                    res.imm_mode := none;
                                end if;
                            when F7_REV8 =>
                                if instruction(RS2_RANGE) = F5_REV8 then
                                    res.mnemonic := rev8;
                                    res.alu_mode := alu_rev8;
                                    res.imm_mode := i_type;
                                else
                                    res.mnemonic := illegal;
                                    res.alu_mode := alu_illegal;
                                    res.imm_mode := none;
                                end if;
                            when others =>
                                res.mnemonic := illegal;
                                res.alu_mode := alu_illegal;
                                res.imm_mode := none;
                        end case;
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
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= IMM;
                res.imm_mode := j_type;
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                res.rptr     := 0; 
                res.rdat     := ali_T'pos(frame);
                res.raux     := ali_T'pos(ra);
                res.pgu_mode := pgu_nop;
                res.branch_mode := jal;
                res.ex_res_mux_sel := DBU;

            when OPC_JALR =>
                res.mnemonic := jalr;
                res.alu_mode := alu_illegal;
                res.imm_mode := i_type;
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                res.rdat     := ali_T'pos(ra);
                res.raux     := ali_T'pos(frame);
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= IMM;
                res.pgu_mode := pgu_nop;
                res.branch_mode := jalr;
                res.ex_res_mux_sel := DBU;

            when OPC_AUIPC => 
                res.mnemonic := auipc;
                res.imm_mode := u_type;
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                res.rdat     := 0; 
                res.rptr     := 0;
                res.raux     := 0;
                res.alu_mode := alu_illegal;
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= IMM;
                res.pgu_mode := pgu_auipc;
                res.ex_res_mux_sel := PGU;
                res.branch_mode := no_branch;

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
                                    res.branch_mode := beq;
                    when F3_BNE  => res.mnemonic := bne;
                                    res.branch_mode := bne;
                    when F3_BLT  => res.mnemonic := blt;
                                    res.branch_mode := blt;
                    when F3_BGE  => res.mnemonic := bge;
                                    res.branch_mode := bge;
                    when F3_BLTU => res.mnemonic := bltu;
                                    res.branch_mode := bltu;
                    when F3_BGEU => res.mnemonic := bgeu;
                                    res.branch_mode := bgeu;
                    when others =>  res.mnemonic := illegal;
                end case;
            when OPC_LOAD =>
                res.alu_mode := alu_add;
                if instruction(FUNCT3_RANGE) /= "111" then res.imm_mode := i_type; else res.imm_mode := none; end if;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                if instruction(FUNCT3_RANGE) = F3_REG then res.rdat := to_integer(unsigned(instruction(RS2_RANGE))); else res.rdat := ali_T'pos(ra); end if;
                res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                res.raux     := ali_T'pos(ra);
                res.alu_a_sel:= DAT;
                res.ex_res_mux_sel := PGU;
                if instruction(FUNCT3_RANGE) = "111" then res.alu_b_sel := AUX; else res.alu_b_sel := IMM; end if;
                if instruction(FUNCT3_RANGE) = "111" then res.pgu_mode := pgu_dat_r; elsif ali_T'val(to_integer(unsigned(instruction(RD_RANGE)))) = ra and ali_T'val(to_integer(unsigned(instruction(RS1_RANGE)))) = frame then res.pgu_mode := pgu_rix; else res.pgu_mode := pgu_dat_i; end if;
                if res.pgu_mode /= pgu_rix then res.at_mode := no; else res.at_mode := load_delta_only; end if;
                case instruction(FUNCT3_RANGE) is
                    when F3_BYTE  => res.mnemonic := lb_i;
                                     res.me_mode  := lb;
                    when F3_HALF  => res.mnemonic := lh_i;
                                     res.me_mode  := lh;
                    when F3_WORD  => res.mnemonic := lw_i;
                                     if ali_T'val(to_integer(unsigned(instruction(RD_RANGE)))) = ra and ali_T'val(to_integer(unsigned(instruction(RS1_RANGE)))) = frame then res.me_mode  := load_ix; else res.me_mode  := lw; end if;
                    when F3_BYTEU => res.mnemonic := lbu_i;
                                     res.me_mode  := lbu;
                    when F3_HALFU => res.mnemonic := lhu_i;
                                     res.me_mode  := lhu;
                    when F3_REG   => case instruction(FUNCT7_RANGE) is
                                     when F7_BYTE =>  res.mnemonic := lb_r;
                                                      res.me_mode  := lb;
                                     when F7_HALF =>  res.mnemonic := lh_r;
                                                      res.me_mode  := lh;
                                     when F7_WORD =>  res.mnemonic := lw_r;
                                                      res.me_mode  := lw;
                                     when F7_BYTEU => res.mnemonic := lbu_r;
                                                      res.me_mode  := lbu;
                                     when F7_HALFU => res.mnemonic := lhu_r;
                                                      res.me_mode  := lhu;
                                     when others =>   res.mnemonic := illegal;
                                                      res.me_mode  := holiday;
                                     end case;
                    when others =>  res.mnemonic := illegal;
                                    res.me_mode  := holiday;
                end case;
            when OPC_STORE =>
                res.alu_mode := alu_add;
                res.imm_mode := s_type;
                res.at_mode  := no;
                res.rdst     := 0;
                res.raux     := to_integer(unsigned(instruction(RS2_RANGE)));
                res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                res.rdat     := ali_T'pos(ra);
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= IMM;
                res.ex_res_mux_sel := PGU;
                if ali_T'val(to_integer(unsigned(instruction(RS2_RANGE)))) = ra and ali_T'val(to_integer(unsigned(instruction(RS1_RANGE)))) = frame then res.pgu_mode := pgu_rix; else res.pgu_mode := pgu_dat_i; end if;
                case instruction(FUNCT3_RANGE) is
                    when F3_BYTE  => res.mnemonic := sb_i;
                                     res.me_mode  := sb;
                    when F3_HALF  => res.mnemonic := sh_i;
                                     res.me_mode  := sh;
                    when F3_WORD  => res.mnemonic := sw_i;
                                     res.me_mode  := store_ix;
                                     if ali_T'val(to_integer(unsigned(instruction(RS2_RANGE)))) /= ra then res.me_mode  := sw; end if;
                    when F3_REG   => res.imm_mode := none;
                                     res.alu_b_sel:= AUX;
                                     res.pgu_mode := pgu_dat_r;
                                     res.rdat     := to_integer(unsigned(instruction(RD_RANGE)));
                                     case instruction(FUNCT7_RANGE) is
                                     when F7_BYTE =>  res.mnemonic := sb_r;
                                                      res.me_mode  := sb;
                                     when F7_HALF =>  res.mnemonic := sh_r;
                                                      res.me_mode  := sh;
                                     when F7_WORD =>  res.mnemonic := sw_r;
                                                      res.me_mode  := sw;
                                     when others =>   res.mnemonic := illegal;
                                                      res.me_mode  := holiday;
                                     end case;
                    when others =>  res.mnemonic := illegal;
                                    res.me_mode  := holiday;
                end case;
            when OPC_OR =>
                res.alu_mode := alu_illegal;
                res.me_mode  := holiday;
                res.at_mode  := no;
                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                res.rdat     := ali_T'pos(ra);
                res.rptr     := ali_T'pos(alc_addr);
                if res.rdst = ali_T'pos(frame) then res.rptr := ali_T'pos(frame); end if;
                res.raux     := 0;
                res.alu_a_sel:= DAT;
                res.alu_b_sel:= IMM;
                case instruction(FUNCT3_RANGE) is
                    when F3_ALC  =>         res.rdat     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.raux     := to_integer(unsigned(instruction(RS2_RANGE)));
                                            res.mnemonic := alc;
                                            res.pgu_mode := pgu_alc;
                                            res.imm_mode := none;
                                            res.csr_mux_sel := PTR;
                                            res.at_mode  := store;
                                            res.ex_res_mux_sel := PGU;
                    when F3_ALCIP  =>       res.rdat     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.mnemonic := alci_p;
                                            res.pgu_mode := pgu_alcp;
                                            res.imm_mode := i_type;
                                            res.at_mode  := store;
                                            res.csr_mux_sel := PTR;
                                            res.ex_res_mux_sel := PGU;
                    when F3_ALCID  =>       res.rdat     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.mnemonic := alci_d;
                                            res.pgu_mode := pgu_alcd;
                                            res.imm_mode := i_type;
                                            res.at_mode  := store;
                                            res.csr_mux_sel := PTR;
                                            res.ex_res_mux_sel := PGU;
                    when F3_ALCI_PUSH =>    res.rdat     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.raux     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.imm_mode := s_type;
                                            res.rdst     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.csr_mux_sel := PTR;
                                            res.ex_res_mux_sel := PGU;
                                            if instruction(RS2_RANGE) = F5_ALCI and ali_T'val(to_integer(unsigned(instruction(RS1_RANGE)))) /= frame then
                                                res.mnemonic := alci;
                                                res.pgu_mode := pgu_alci;
                                                res.at_mode  := store;
                                            elsif instruction(RS2_RANGE) = F5_ALCI and ali_T'val(to_integer(unsigned(instruction(RS1_RANGE)))) = frame then
                                                res.mnemonic := pusht;
                                                res.pgu_mode := pgu_pusht;
                                                res.at_mode  := store;
                                            elsif instruction(RS2_RANGE) = F5_PUSHG then
                                                res.mnemonic := pushg;
                                                res.pgu_mode := pgu_pushg;
                                                res.at_mode  := store;
                                            elsif instruction(RS2_RANGE) = F5_PUSH then
                                                res.mnemonic := push;
                                                res.pgu_mode := pgu_push;
                                                res.at_mode  := store;
                                            else
                                                res.mnemonic := illegal;
                                                res.pgu_mode := pgu_nop;
                                            end if;
                    when F3_SP =>           res.mnemonic := sp_i;
                                            res.imm_mode := s_type;
                                            res.me_mode  := sp;
                                            res.at_mode  := no;
                                            res.rdst     := 0;
                                            res.raux     := to_integer(unsigned(instruction(RS2_RANGE)));
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.pgu_mode := pgu_ptr_i;
                                            if ali_T'val(to_integer(unsigned(instruction(RS2_RANGE)))) = ra and ali_T'val(to_integer(unsigned(instruction(RS1_RANGE)))) = frame then
                                                res.pgu_mode := pgu_rcd;
                                                res.me_mode  := store_rpc;
                                            end if;
                                            res.ex_res_mux_sel := PGU;
                    when F3_LP =>           res.mnemonic := lp_i;
                                            res.imm_mode := i_type;
                                            res.me_mode  := lp;
                                            res.at_mode  := load_delta_only;
                                            res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                            res.raux     := ali_T'pos(ra);
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.pgu_mode := pgu_ptr_i;
                                            if ali_T'val(to_integer(unsigned(instruction(RD_RANGE)))) = ra and ali_T'val(to_integer(unsigned(instruction(RS1_RANGE)))) = frame then
                                                res.pgu_mode := pgu_rcd;
                                                res.me_mode  := load_rpc;
                                                res.at_mode  := load_maybe;
                                            end if;
                                            res.ex_res_mux_sel := PGU;
                    when F3_JLIB =>         res.mnemonic := jlib;
                                            res.alu_mode := alu_illegal;
                                            res.imm_mode := i_type;
                                            res.me_mode  := holiday;
                                            res.at_mode  := no;
                                            res.rdst     := ali_T'pos(ra);
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.rdat     := ali_T'pos(frame);
                                            res.raux     := ali_T'pos(ra);
                                            res.alu_a_sel:= DAT;
                                            res.alu_b_sel:= IMM;
                                            res.pgu_mode := pgu_nop;
                                            res.branch_mode := jlib;
                                            res.ex_res_mux_sel := DBU;
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
                                            res.ex_res_mux_sel := PGU;
                            when F7_LPR =>  res.mnemonic := lp_r;
                                            res.imm_mode := none;
                                            res.me_mode  := lp;
                                            res.at_mode  := load_maybe;
                                            res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                            res.raux     := 0;
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.rdat     := to_integer(unsigned(instruction(RS2_RANGE)));
                                            res.pgu_mode := pgu_ptr_r;
                                            res.ex_res_mux_sel := PGU;
                            when F7_POP =>  res.mnemonic := pop;
                                            res.imm_mode := none;
                                            res.me_mode  := holiday;
                                            res.at_mode  := load_maybe;
                                            res.rdst     := ali_T'pos(frame);
                                            res.raux     := 0;
                                            res.rptr     := ali_T'pos(frame);
                                            res.rdat     := ali_T'pos(ra);
                                            res.pgu_mode := pgu_pop;
                                            res.ex_res_mux_sel := PGU;



                            when F7_QDTB => res.mnemonic := qdtb;
                                            res.ex_res_mux_sel := ALU;
                                            res.alu_mode := alu_add;
                                            res.imm_mode := none;
                                            res.me_mode  := holiday;
                                            res.at_mode  := no;
                                            res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                            res.raux     := 0;
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.rdat     := 0;
                                            res.pgu_mode := pgu_pop;
                                            res.alu_a_sel:= PTRDTB;
                                            res.alu_b_sel:= IMM;

                            when F7_QDTH => res.mnemonic := qdth;
                                            res.ex_res_mux_sel := ALU;
                                            res.alu_mode := alu_add;
                                            res.imm_mode := none;
                                            res.me_mode  := holiday;
                                            res.at_mode  := no;
                                            res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                            res.raux     := 0;
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.rdat     := 0;
                                            res.pgu_mode := pgu_pop;
                                            res.alu_a_sel:= PTRDTH;
                                            res.alu_b_sel:= IMM;
                            
                            when F7_QDTW => res.mnemonic := qdtw;
                                            res.ex_res_mux_sel := ALU;
                                            res.alu_mode := alu_add;
                                            res.imm_mode := none;
                                            res.me_mode  := holiday;
                                            res.at_mode  := no;
                                            res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                            res.raux     := 0;
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.rdat     := 0;
                                            res.pgu_mode := pgu_pop;
                                            res.alu_a_sel:= PTRDTW;
                                            res.alu_b_sel:= IMM;
                            
                            when F7_QDTD => res.mnemonic := qdtd;
                                            res.ex_res_mux_sel := ALU;
                                            res.alu_mode := alu_add;
                                            res.imm_mode := none;
                                            res.me_mode  := holiday;
                                            res.at_mode  := no;
                                            res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                            res.raux     := 0;
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.rdat     := 0;
                                            res.pgu_mode := pgu_pop;
                                            res.alu_a_sel:= PTRDTD;
                                            res.alu_b_sel:= IMM;

                            
                            when F7_QPI =>  res.mnemonic := qpi;
                                            res.ex_res_mux_sel := ALU;
                                            res.alu_mode := alu_add;
                                            res.imm_mode := none;
                                            res.me_mode  := holiday;
                                            res.at_mode  := no;
                                            res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                            res.raux     := 0;
                                            res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                            res.rdat     := 0;
                                            res.pgu_mode := pgu_pop;
                                            res.alu_a_sel:= PTRPI;
                                            res.alu_b_sel:= IMM;

                            when others =>  res.mnemonic := illegal;
                                            res.pgu_mode := pgu_nop;
                                            res.imm_mode := none;
                        end case;
                    when others =>          res.mnemonic := illegal;
                                            res.pgu_mode := pgu_nop;
                                            res.imm_mode := none;
                end case;
            when OPC_SYSTEM => 
                case instruction(FUNCT3_RANGE) is
                    when F3_ENV =>
                        case instruction(FUNCT7_RANGE) is
                            when F7_ENV =>
                                if instruction(FUNCT5_RANGE) = F5_EBREAK then
                                    res.mnemonic := ebreak;
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
                                elsif instruction(FUNCT5_RANGE) = F5_ECALL then
                                elsif instruction(FUNCT5_RANGE) = F5_QPTR then
                                    res.mnemonic := qdtr;
                                    res.ex_res_mux_sel := ALU;
                                    res.alu_mode := alu_add;
                                    res.imm_mode := none;
                                    res.me_mode  := holiday;
                                    res.at_mode  := no;
                                    res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                    res.raux     := 0;
                                    res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                    res.rdat     := 0;
                                    res.pgu_mode := pgu_pop;
                                    res.alu_a_sel:= PTRDTR;
                                    res.alu_b_sel:= IMM;
                                elsif instruction(FUNCT5_RANGE) = F5_QPIR then
                                    res.mnemonic := qpir;
                                    res.ex_res_mux_sel := ALU;
                                    res.alu_mode := alu_add;
                                    res.imm_mode := none;
                                    res.me_mode  := holiday;
                                    res.at_mode  := no;
                                    res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                    res.raux     := 0;
                                    res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                                    res.rdat     := 0;
                                    res.pgu_mode := pgu_pop;
                                    res.alu_a_sel:= PTRPIR;
                                    res.alu_b_sel:= IMM;
                                end if;
                            when F7_MRET => 
                                res.xret := mret;
                                res.mnemonic := mret;
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
                            when F7_CIOP =>
                                res.mnemonic := ciop;
                                res.alu_mode := alu_illegal;
                                res.imm_mode := none;
                                res.me_mode  := holiday;
                                res.at_mode  := no;
                                res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                res.rdat     := to_integer(unsigned(instruction(RS1_RANGE)));
                                res.rptr     := 0;
                                res.raux     := to_integer(unsigned(instruction(RS2_RANGE)));
                                res.alu_a_sel:= DAT;
                                res.alu_b_sel:= AUX;
                                res.pgu_mode := pgu_ciop;
                                res.ex_res_mux_sel := PGU;

                                
                            when F7_OR =>
                                res.mnemonic := illegal;
                                res.pgu_mode := pgu_nop;
                                res.imm_mode := none;
                                res.alu_a_sel:= DAT;
                                res.alu_b_sel:= AUX;
                                res.alu_mode := alu_illegal;
                                res.at_mode  := load_maybe;
                                res.me_mode  := holiday;
                                res.rptr     := 0;
                                res.rdat     := 0;
                                res.raux     := 0;
                                res.rdst     := 0;
                                case instruction(FUNCT5_RANGE) is
                                    when F5_CCP =>  res.mnemonic := ccp;
                                                    res.pgu_mode := pgu_ccp;
                                                    res.alu_mode := alu_illegal;
                                                    res.raux     := to_integer(unsigned(instruction(RS1_RANGE)));
                                                    res.rdst     := to_integer(unsigned(instruction(RD_RANGE)));
                                                    res.ex_res_mux_sel := PGU;
                                    when others =>  null;
                                end case;
    
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

                    when F3_CSRRW => 
                        --#TODO: make system registers readable (required for exception handler to detect which exception occured)
                        res.me_mode  := holiday;
                        res.at_mode  := no;
                        res.imm_mode := none;
                        res.alu_mode := alu_illegal;
                        res.ex_res_mux_sel := AUX;
                        res.rdat     := to_integer(unsigned(instruction(RS1_RANGE)));
                        res.rptr     := to_integer(unsigned(instruction(RS1_RANGE)));
                        res.raux     := to_integer(unsigned(instruction(RS1_RANGE)));
                        res.alu_a_sel:= PTRVAL;
                        res.alu_b_sel:= IMM;
                        res.pgu_mode := pgu_nop;
                        res.mnemonic := csrw;
                        case instruction(IMM12_RANGE) is
                            when CSR_MEPC_IX =>     res.rdst := ali_T'pos(mepc);
                                                    res.ex_res_mux_sel := PTR;
                            when CSR_MISA_IX =>     res.rdst := ali_T'pos(misa);
                            when CSR_MSTATUS_IX =>  res.rdst := ali_T'pos(mstatus);
                            when CSR_MCAUSE_IX =>   res.rdst := ali_T'pos(mcause);
                            when CSR_MTVAL_IX =>    res.rdst := ali_T'pos(mtval);
                            when CSR_MTVEC_IX =>    res.rdst := ali_T'pos(mtvec);
                            when CSR_MVENDORID_IX =>res.rdst := ali_T'pos(mvendorid);
                            when CSR_MARCHID_IX =>  res.rdst := ali_T'pos(marchid);
                            when CSR_MIMPID_IX =>   res.rdst := ali_T'pos(mimpid);
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


            when OPC_LUI => 
                res.mnemonic := lui;
                res.alu_mode := alu_add;
                res.ex_res_mux_sel := ALU;
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

    pure function allocateNewObject(current_alc_addr: word_T; pi: word_T; dt: word_T; dalc: boolean := false) return word_T is
        variable pi_aligned, dt_aligned: word_T;
        variable reserved_space: natural range 8 to 16;
        variable addr: word_T;
        variable new_tag: std_logic_vector(2 downto 0);
    begin
        case current_alc_addr(2 downto 0) is
            when "100" => new_tag := "101";
            when "101" => new_tag := "100";
            when others => new_tag := current_alc_addr(2 downto 0);
        end case;

        pi_aligned := pi(word_T'high-2 downto 0) & "00";
        dt_aligned := "00" & dt(word_T'high-2 downto 0);
        if dt(31) = '1' and dt(30) = '1' then
            reserved_space := 16;
        elsif dt(31) = '1' or dt(30) = '1' then
            reserved_space := 12;
        else
            reserved_space := 8;
        end if;
        if dalc then
            addr := std_logic_vector(unsigned(current_alc_addr) + unsigned(pi_aligned) + unsigned(dt_aligned) + to_unsigned(reserved_space, word_T'length));
        else
            addr := std_logic_vector(unsigned(current_alc_addr) - unsigned(pi_aligned) - unsigned(dt_aligned) - to_unsigned(reserved_space, word_T'length));
        end if;
        return addr(word_T'high downto 3) & new_tag;
    end function allocateNewObject;

    pure function calculateMemoryAddress(pi: word_T; ix: word_T; offs: word_T; base: word_T; inter: std_logic; ptr_access: boolean := false) return word_T is
        variable pi_scaled: word_T;
        variable offset_scaled: word_T;
        variable index_scaled: word_T;
        variable index_space: word_T;
        variable base_aligned: word_T;
        variable reserved_space: natural range 8 to 16;
    begin
        base_aligned := base(word_T'high downto 3) & "000";
        pi_scaled := '0' & pi(word_T'high-1 downto 2) & "00";
        offset_scaled := offs(word_T'high-2 downto 0) & "00";
        index_scaled := ix(word_T'high-2 downto 0) & "00";
        index_space := word_T(to_unsigned(to_integer(unsigned(pi))*INDEX_SIZE+7, word_T'length)) and X"FFFFFFF8";
        if inter = '1' and base(2) = '1' then
            reserved_space := 16;
        elsif base(2) = '1' then
            reserved_space := 12;
        else
            reserved_space := 8;
        end if;

        if ptr_access then
            return std_logic_vector(unsigned(base_aligned) + unsigned(offset_scaled) + unsigned(index_scaled) + reserved_space);
        else
            return std_logic_vector(unsigned(base_aligned) + unsigned(pi_scaled) + unsigned(index_space) + unsigned(offs) + unsigned(ix) + reserved_space);
        end if;
    end function calculateMemoryAddress;

    pure function isFrameTypeException(rdst_nbr: reg_nbr_T; frame: rptr_T; pgu_mode: pgu_mode_T) return boolean is
    begin
        return  (ali_T'val(rdst_nbr) = ra and pgu_mode = pgu_dat_r and pgu_mode = pgu_ptr_r) or                                                                         --try loading/storing ra with index addressing
                (ali_T'val(rdst_nbr) = ra and frame.val(2 downto 0) /= "100" and frame.val(2 downto 0) /= "101" and pgu_mode = pgu_dat_r and pgu_mode = pgu_ptr_r);     --try loading/storing ra from non stack frame object (#TODO: could we allow this?)
    end function isFrameTypeException;

    pure function isIndexOutOfBoundsException(rdst_nbr: reg_nbr_T; rptr: rptr_T; raux: raux_T; rdat: rdat_T; imm: word_T; pgu_mode: pgu_mode_T) return boolean is
    begin
        return  ali_T'val(rdst_nbr) /= ra and raux.ali /= ra and (
                    (pgu_mode = pgu_dat_i and unsigned(imm(28 downto 0)) > unsigned(rptr.dt) and rptr.ali = frame) or
                    (pgu_mode = pgu_dat_i and unsigned(imm(30 downto 0)) > unsigned(rptr.dt)) or
                    (pgu_mode = pgu_dat_r and unsigned(rdat.val(28 downto 0)) > unsigned(rptr.dt) and rptr.ali = frame) or
                    (pgu_mode = pgu_dat_r and unsigned(rdat.val(30 downto 0)) > unsigned(rptr.dt)) or
                    (pgu_mode = pgu_ptr_i and unsigned(imm(30 downto 2)) > unsigned(rptr.pi)) or
                    (pgu_mode = pgu_ptr_r and unsigned(rdat.val(30 downto 2)) > unsigned(rptr.pi))
                );
    end function isIndexOutOfBoundsException;

    pure function isTargetCodeIndexOutOfBounds(target_ix: word_T; target_public: word_T; target_private: word_T; branch_mode: branch_mode_T; inter: boolean) return boolean is
    begin
        return  (branch_mode = jalr and inter and unsigned(target_ix) > unsigned(target_public)) or
                (branch_mode = jalr and not inter and unsigned(target_ix) > unsigned(target_private)) or
                (branch_mode = jal and unsigned(target_ix) > unsigned(target_private)) or
                (branch_mode = jlib and unsigned(target_ix) > unsigned(target_public));
    end function isTargetCodeIndexOutOfBounds;

    pure function isStateErrorException(rdst_nbr: reg_nbr_T; rptr: rptr_T; raux: raux_T; rdat: rdat_T; pc: pc_T; pgu_mode: pgu_mode_T; branch_mode: branch_mode_T) return boolean is
        variable pgu_load_store: boolean;
    begin
        pgu_load_store := pgu_mode = pgu_dat_i or pgu_mode = pgu_dat_r or pgu_mode = pgu_ptr_i or pgu_mode = pgu_ptr_r;
        return  pgu_mode = pgu_nop and branch_mode = no_branch and (                                                     --default
                    ((pgu_mode = pgu_push or pgu_mode = pgu_pusht) and raux.val(0) /= rdat.val(0)) or --try two consecutive pushes
                    (pgu_mode = pgu_pop and raux.val(0) /= rdat.val(0)) or --try two consecutive pops
                    ((pgu_mode = pgu_dat_r or pgu_mode = pgu_ptr_r) and rptr.ali = frame) or                        --try executing index load/store on stack frame
                    (pgu_load_store and raux.ali = frame and rdat.ali /= ra) or                                                        --(should not happen but just to be sure)
                    (pgu_load_store and raux.ali = frame and raux.val(0) /= rdat.val(0)) or                                        --color of frame does not match color of rix
                    
                    (branch_mode = jalr and rptr.ali = ra and rptr.val /= pc.ptr and rptr.ix(31) /= '1') or --try rtlib without inter-rix
                    (branch_mode = jalr and rptr.ali = ra and raux.val(0) /= rdat.val(0)) or --try ret without popping first
                    (branch_mode = jalr and rdst_nbr /= 0 and raux.val(0) = rdat.val(0)) or --try bsr/jlib without pushing first
                    (branch_mode = jlib and rdst_nbr /= 0 and raux.val(0) = rdat.val(0)) or --try bsr/jlib without pushing first
                    (branch_mode = jal  and rdst_nbr /= 0 and raux.val(0) = rdat.val(0)) --try bsr/jlib without pushing first
                );
    end function isStateErrorException;

    pure function isPointerArithException(alu_mode: alu_mode_T; raux: raux_T) return boolean is
    begin
        return INDEX_SIZE = 0 and alu_mode /= alu_illegal and alu_mode /= alu_add and raux.tag = POINTER;
    end function isPointerArithException;

    pure function isHeapOverflowException(allocated_address: word_T; alc_params: rptr_T; pgu_mode: pgu_mode_T) return boolean is
    begin
        return unsigned(allocated_address) <= unsigned(alc_params.pi) and (pgu_mode = pgu_alc or pgu_mode = pgu_alci or pgu_mode = pgu_alcd or pgu_mode = pgu_alcp);
    end function isHeapOverflowException;

    pure function isStackOverflowException(allocated_address: word_T; alc_params: rptr_T; pgu_mode: pgu_mode_T) return boolean is
    begin
        return unsigned(allocated_address) <= unsigned(alc_params.dt) and (pgu_mode = pgu_push or pgu_mode = pgu_pusht);
    end function isStackOverflowException;

END pipeline;
