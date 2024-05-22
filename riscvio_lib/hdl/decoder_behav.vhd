--
-- VHDL Architecture riscvio_lib.decoder.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 13:36:06 09.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--

LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;

LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF decoder IS
    signal decoded_inst: decode_T;
BEGIN

    decoded_inst <= decodeOpc(instruction);
    ctr_sig.mnemonic <= decoded_inst.mnemonic;
    ctr_sig.alu_mode <= decoded_inst.alu_mode;
    ctr_sig.me_mode  <= decoded_inst.me_mode;
    ctr_sig.at_mode  <= decoded_inst.at_mode;

    extend: process(all) is
    begin
        case decoded_inst.imm_mode is
            when i_type => 
                imm <= (others => instruction(IMM12_RANGE'high));
                imm(11 downto 0) <= instruction(IMM12_RANGE);
            when s_type => 
                imm <= extractSTypeImm(instruction);
            when b_type => 
                imm <= extractBTypeImm(instruction);
            when u_type => 
                imm <= (others => instruction(IMM20_RANGE'high));
                imm(19 downto 0) <= instruction(IMM20_RANGE);
            when j_type =>
                imm <= extractJTypeImm(instruction);
            when none => null;
        end case;
    end process extend;

    sbta_valid <= decoded_inst.mnemonic = jal;
    sbta <= std_logic_vector(to_unsigned(to_integer(unsigned(pc)) + to_integer(signed(extractJTypeImm(instruction))), WORD_SIZE));


    rdst_ix <= decoded_inst.rdst;
    rdat_ix <= decoded_inst.rdat;
    rptr_ix <= decoded_inst.rptr;
    raux_ix <= decoded_inst.raux;

END ARCHITECTURE behav;


