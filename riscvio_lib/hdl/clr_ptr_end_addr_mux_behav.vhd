--
-- VHDL Architecture riscvio_lib.clr_ptr_end_addr_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 21:01:50 08.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF clr_ptr_end_addr_mux IS
BEGIN
    end_addr <= rptr_ex.val when rdst_ix_ex /= ali_T'pos(frame) else raux_ex.val;
END ARCHITECTURE behav;