--
-- VHDL Architecture riscvio_lib.nop_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 23:55:13 21.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--

ARCHITECTURE behav OF nop_gen IS
BEGIN
    rdst_ix_dc_u <= ali_T'pos(zero) when insert_nop else rdst_ix_dec;
    imm_dc_u <= imm_dec;
    ctrl_dc_u <= CTRL_NULL when insert_nop else ctrl_dc_dec;
END ARCHITECTURE behav;

