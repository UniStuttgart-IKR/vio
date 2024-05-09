--
-- VHDL Architecture riscvio_lib.imm_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 13:36:37 09.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF imm_mux IS
BEGIN
  reg_rs2_dc_u <= imm_as_reg when ctrl_dc_u.sel_imm else reg_rs2;
END ARCHITECTURE behav;

