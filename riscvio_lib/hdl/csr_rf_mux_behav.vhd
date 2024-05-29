--
-- VHDL Architecture riscvio_lib.csr_rf_mux.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 16:50:53 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library riscvio_lib;
use riscvio_lib.isa.all;

ARCHITECTURE behav OF csr_rf_mux IS
BEGIN
    rptr_dc_u <= (val => csr_val, ali => ali_T'val(rptr_ix), pi => (others => '0'), dt => (others => '0'),  ix => rptr_ix) when rptr_ix > ali_T'pos(alc_lim) else rptr_rf;
    rdat_dc_u <= (val => csr_val, ali => ali_T'val(rdat_ix), ix => rdat_ix) when rdat_ix > ali_T'pos(alc_lim) else rdat_rf;
    raux_dc_u <= raux_rf;
END ARCHITECTURE behav;