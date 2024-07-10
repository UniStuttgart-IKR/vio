--
-- VHDL Architecture riscvio_lib.stall_logic.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 17:13:56 07.07.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF stall_logic IS
BEGIN
  stall <= ic_stall or dc_stall or ac_stall or obj_init_stall or io_stall_int or ebreak_stall;
END ARCHITECTURE behav;

