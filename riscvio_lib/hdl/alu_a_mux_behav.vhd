--
-- VHDL Architecture riscvio_lib.alu_a_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 21:58:53 23.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF alu_a_mux IS
BEGIN
    b <= rdat_dc.val when alu_a_in_sel = DAT else
         rptr_dc.val when alu_a_in_sel = PTRVAL else
         rptr_dc.pi  when alu_a_in_sel = PTRPI else
         rptr_dc.dt  when alu_a_in_sel = PTRDT else
         raux_dc.val;
END ARCHITECTURE behav;


