--
-- VHDL Architecture riscvio_lib.next_pc_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 17:06:34 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF next_pc_mux IS
BEGIN
  next_pc <= static_branch_pc when sbta_valid else dynamic_branch_pc when dbta_valid else incremented_pc;
END ARCHITECTURE behav;

