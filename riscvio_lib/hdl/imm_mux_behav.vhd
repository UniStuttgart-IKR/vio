--
-- VHDL Architecture riscvio_lib.imm_mux.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 17:01:48 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF imm_mux IS
BEGIN
    reg_rs2_dc_u <= imm_as_reg when ctrl_dc_u.sel_imm else reg_rs2;
END ARCHITECTURE behav;

