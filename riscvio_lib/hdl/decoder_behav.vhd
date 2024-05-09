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
    signal imm_is_12_bit: boolean;
    signal extended_imm: word_T;
    signal ctrl_sig_int: ctrl_sig_T;
BEGIN

    ctrl_sig_int <= decodeOpc(instruction);
    ctr_sig <= ctrl_sig_int;
    imm_is_12_bit <= true;

    extend: process(all) is
        variable high_bit_extended: word_T;
    begin
        case ctrl_sig_int.imm_mode is
            when i_type => 
                extended_imm <= (others => instruction(IMM12_RANGE'high));
                extended_imm(11 downto 0) <= instruction(IMM12_RANGE);
            when s_type => 
                extended_imm <= extractSTypeImm(instruction);
            when b_type => 
                extended_imm <= extractBTypeImm(instruction);
            when u_type => 
                extended_imm <= (others => instruction(IMM20_RANGE'high));
                extended_imm(19 downto 0) <= instruction(IMM20_RANGE);
            when j_type =>
                extended_imm <= extractJTypeImm(instruction);
            when none => null;
        end case;
    end process extend;

    sbta_valid <= ctr_sig.mnemonic = jal;
    sbta <= std_logic_vector(to_unsigned(to_integer(unsigned(pc)) + to_integer(signed(extractJTypeImm(instruction))), WORD_SIZE));

    imm_as_reg.mem.data <= extended_imm;
    imm_as_reg.mem.tag <= DATA;

    rd_ix <= to_integer(unsigned(instruction(RD_RANGE)));
    rs1_ix <= to_integer(unsigned(instruction(RS1_RANGE)));
    rs2_ix <= to_integer(unsigned(instruction(RS2_RANGE)));

END ARCHITECTURE behav;


