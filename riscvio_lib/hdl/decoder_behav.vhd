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
    ctr_sig.mnemonic    <= decoded_inst.mnemonic;
    ctr_sig.alu_mode    <= decoded_inst.alu_mode;
    ctr_sig.me_mode     <= decoded_inst.me_mode;
    ctr_sig.at_mode     <= decoded_inst.at_mode;
    ctr_sig.alu_a_sel   <= decoded_inst.alu_a_sel;
    ctr_sig.alu_b_sel   <= decoded_inst.alu_b_sel;
    ctr_sig.pgu_mode    <= decoded_inst.pgu_mode;
    ctr_sig.branch_mode <= decoded_inst.branch_mode;

    exc <= illeg when ctr_sig.mnemonic = illegal else well_behaved;
    xret <= decoded_inst.xret;

    extend: process(all) is
    begin
        if decoded_inst.mnemonic /= jal then
            case decoded_inst.imm_mode is
                when i_type => 
                    imm <= (others => instruction(IMM12_RANGE'high));
                    imm(11 downto 0) <= instruction(IMM12_RANGE);
                when s_type => 
                    imm <= extractSTypeImm(instruction);
                when b_type => 
                    imm <= extractBTypeImm(instruction);
                when u_type => 
                    imm <= (others => '0');
                    imm(31 downto 12) <= instruction(IMM20_RANGE);
                when j_type =>
                    imm <= extractJTypeImm(instruction);
                when shamt_type => 
                    imm <= (others => '0');
                    imm(4 downto 0) <= instruction(RS2_RANGE);
                when none => imm <= (others => '0');
            end case;
        else
            imm <= X"00000000";
        end if;
    end process extend;

    sbt_valid <= decoded_inst.branch_mode = jal;
    sbt.ix <= std_logic_vector(to_unsigned(to_integer(unsigned(pc.ix)) + to_integer(signed(extractJTypeImm(instruction))), WORD_SIZE));
    sbt.ptr <= pc.ptr;
    sbt.eoc <= pc.eoc;


    rdst_ix <= decoded_inst.rdst;
    rdat_ix <= decoded_inst.rdat;
    rptr_ix <= decoded_inst.rptr;
    raux_ix <= decoded_inst.raux;
    csr_ix <= decoded_inst.rptr when decoded_inst.rptr >= ali_T'pos(alc_addr) else ali_T'pos(alc_addr);
END ARCHITECTURE behav;


