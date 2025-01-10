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
    rptr_dc_u <= (val => csr_reg.val, ix => csr_reg.ix, ali => ali_T'val(csr_nbr), pi => csr_reg.pi, dt => csr_reg.dt, nbr => csr_nbr) when csr_mux_sel = PTR else rptr_rf;
    rdat_dc_u <= (val => csr_reg.val, ali => ali_T'val(csr_nbr), nbr => csr_nbr) when csr_mux_sel = DAT else rdat_rf;
    raux_dc_u <= (val => csr_reg.val, ix => csr_reg.ix, tag => csr_reg.tag, ali => ali_T'val(csr_nbr), nbr => csr_nbr) when csr_mux_sel = AUX else raux_rf;
END ARCHITECTURE behav;