--
-- VHDL Architecture riscvio_lib.stall_logic.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 19:56:41 23.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF stall_logic IS
BEGIN
  stall <= ic_stall or dc_stall or ac_stall or obj_init_stall;
END ARCHITECTURE behav;

