--
-- VHDL Architecture riscvio_lib.io_interface.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 21:32:44 29.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF io_interface IS
BEGIN
    stall <= '1' when io_stall = '1' else 'Z';
END ARCHITECTURE behav;

