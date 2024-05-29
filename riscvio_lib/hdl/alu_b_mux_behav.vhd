--
-- VHDL Architecture riscvio_lib.alu_b_mux.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc023)
--          at - 17:26:39 05/22/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF alu_b_mux IS
BEGIN
    b <= rdat_dc.val when alu_b_in_sel = DAT else
         rptr_dc.val when alu_b_in_sel = PTRVAL else
         rptr_dc.pi  when alu_b_in_sel = PTRPI else
         rptr_dc.dt  when alu_b_in_sel = PTRDT else
         raux_dc.val when alu_b_in_sel = AUX else
         imm_dc;
END ARCHITECTURE behav;

