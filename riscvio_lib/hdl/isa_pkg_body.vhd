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
        case instruction(OPC_RANGE) is
            when OPC_ALU_R => 
                res.sel_imm := false;
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
                    when others =>
                        res.mnemonic := illegal;
                        res.alu_mode := alu_illegal;
                end case;

            when OPC_ALU_I => 
                res.sel_imm := true;
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
                    when others =>
                        res.mnemonic := illegal;
                        res.alu_mode := alu_illegal;
                end case;
            when OPC_JAL =>
                res.mnemonic := jal;
                res.alu_mode := alu_illegal;
                res.sel_imm := false;
            when others =>
                res.mnemonic := illegal;
                res.alu_mode := alu_illegal;
                res.sel_imm := false;
        end case;
        return res;
    end function decodeOpc;

    pure function extractJalImm(inst: word_T) return word_T is
        variable res: word_T;
    begin
        res := (0 => '0', others => inst(31));
        res(19 downto 12) := inst(19 downto 12);
        res(11) := inst(20);
        res(10 downto 1) := inst(30 downto 21);
        return res;
    end function extractJalImm;

END isa;
