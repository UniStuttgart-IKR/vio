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
    signal ctrl_sig_int: ctrl_sig_T;
BEGIN

    ctrl_sig_int <= decodeOpc(instruction);
    ctr_sig <= ctrl_sig_int;

    extend: process(all) is
    begin
        case ctrl_sig_int.imm_mode is
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

    sbta_valid <= ctr_sig.mnemonic = jal;
    sbta <= std_logic_vector(to_unsigned(to_integer(unsigned(pc)) + to_integer(signed(extractJTypeImm(instruction))), WORD_SIZE));


    rdst_ix <= to_integer(unsigned(instruction(RD_RANGE)));
    rdat_ix <= to_integer(unsigned(instruction(RS1_RANGE)));
    rptr_ix <= to_integer(unsigned(instruction(RS2_RANGE)));
    raux_ix <= to_integer(unsigned(instruction(RS2_RANGE)));

END ARCHITECTURE behav;


