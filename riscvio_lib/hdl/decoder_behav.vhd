--
-- VHDL Architecture riscvio_lib.decoder.behav
--
-- Created:
--          by - leylknci.meyer (pc038)
--          at - 16:38:14 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--

LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;

LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF decoder IS
    signal imm_is_12_bit: boolean;
    signal extended_imm: word_T;
BEGIN

    ctr_sig <= decodeOpc(instruction);
    imm_is_12_bit <= true;

    extend: process(all) is
        variable high_bit_extended: word_T;
    begin
        if imm_is_12_bit then
            extended_imm <= (others => instruction(IMM12_RANGE'high));
            extended_imm(11 downto 0) <= instruction(IMM12_RANGE);
        else
            extended_imm <= (others => instruction(IMM20_RANGE'high));
            extended_imm(19 downto 0) <= instruction(IMM20_RANGE);
        end if;

    end process extend;

    sbta_valid <= ctr_sig.mnemonic = jal;
    sbta <= std_logic_vector(to_unsigned(to_integer(unsigned(pc)) + to_integer(signed(extractJalImm(instruction))), WORD_SIZE));

    imm_as_reg.mem.data <= extended_imm;
    imm_as_reg.mem.tag <= DATA;

    rd_ix <= to_integer(unsigned(instruction(RD_RANGE)));
    rs1_ix <= to_integer(unsigned(instruction(RS1_RANGE)));
    rs2_ix <= to_integer(unsigned(instruction(RS2_RANGE)));

END ARCHITECTURE behav;

