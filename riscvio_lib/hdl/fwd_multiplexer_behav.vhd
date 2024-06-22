--
-- VHDL Architecture riscvio_lib.fwd_multiplexer.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 21:51:20 17.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF fwd_unit IS
BEGIN
    rdst_fwd <= rdst_reg;

    rdat_fwd <= (ali => rdat_reg.ali, ix => rdat_reg.ix, val => fwd_res_0.pi) when ali_t'val(fwd_idx_0) = ra and rdat_reg.ali = rix else 
                (ali => rdat_reg.ali, ix => rdat_reg.ix, val => fwd_res_0.data) when rdat_reg.ali /= zero and fwd_idx_0 = rdat_reg.ix else 
                (ali => rdat_reg.ali, ix => rdat_reg.ix, val => fwd_res_1.data) when rdat_reg.ali /= zero and fwd_idx_1 = rdat_reg.ix else 
                (ali => rdat_reg.ali, ix => rdat_reg.ix, val => fwd_res_2.data) when rdat_reg.ali /= zero and fwd_idx_2 = rdat_reg.ix else 
                rdat_reg;

    rptr_fwd <= (ali => rptr_reg.ali, ix => rptr_reg.ix, val => fwd_res_0.data, pi => fwd_res_0.pi,   dt => fwd_res_0.delta) when rptr_reg.ali /= zero and (fwd_idx_0 = rptr_reg.ix or (fwd_0 and ali_t'val(rptr_reg.ix) = alc_addr)) else 
                (ali => rptr_reg.ali, ix => rptr_reg.ix, val => fwd_res_1.data, pi => fwd_res_1.pi,   dt => fwd_res_1.delta) when rptr_reg.ali /= zero and (fwd_idx_1 = rptr_reg.ix or (fwd_1 and ali_t'val(rptr_reg.ix) = alc_addr)) else
                (ali => rptr_reg.ali, ix => rptr_reg.ix, val => fwd_res_2.data, pi => fwd_res_2.pi,   dt => fwd_res_2.delta) when rptr_reg.ali /= zero and (fwd_idx_2 = rptr_reg.ix or (fwd_2 and ali_t'val(rptr_reg.ix) = alc_addr)) else
                (ali => rptr_reg.ali, ix => rptr_reg.ix, val => rptr_reg.val,   pi => fwd_res_0.data, dt => rptr_reg.dt)     when rptr_reg.ali = ra and ali_t'val(fwd_idx_0) = rix else 
                (ali => rptr_reg.ali, ix => rptr_reg.ix, val => rptr_reg.val,   pi => fwd_res_1.data, dt => rptr_reg.dt)     when rptr_reg.ali = ra and ali_t'val(fwd_idx_1) = rix else 
                (ali => rptr_reg.ali, ix => rptr_reg.ix, val => rptr_reg.val,   pi => fwd_res_2.data, dt => rptr_reg.dt)     when rptr_reg.ali = ra and ali_t'val(fwd_idx_2) = rix else 
                (ali => rptr_reg.ali, ix => rptr_reg.ix, val => fwd_res_0.data, pi => rptr_reg.pi,    dt => rptr_reg.dt)     when rptr_reg.ali = ra and ali_t'val(fwd_idx_0) = rcd else 
                (ali => rptr_reg.ali, ix => rptr_reg.ix, val => fwd_res_1.data, pi => rptr_reg.pi,    dt => rptr_reg.dt)     when rptr_reg.ali = ra and ali_t'val(fwd_idx_1) = rcd else 
                (ali => rptr_reg.ali, ix => rptr_reg.ix, val => fwd_res_2.data, pi => rptr_reg.pi,    dt => rptr_reg.dt)     when rptr_reg.ali = ra and ali_t'val(fwd_idx_2) = rcd else 
                rptr_reg;

    raux_fwd <= (ali => raux_reg.ali, ix => raux_reg.ix, val => fwd_res_0.data, tag => fwd_res_0.tag) when ali_t'val(fwd_idx_0) = ra and raux_reg.ali = rcd else 
                (ali => raux_reg.ali, ix => raux_reg.ix, val => fwd_res_0.data, tag => fwd_res_0.tag) when raux_reg.ali /= zero and fwd_idx_0 = raux_reg.ix else 
                (ali => raux_reg.ali, ix => raux_reg.ix, val => fwd_res_1.data, tag => fwd_res_1.tag) when raux_reg.ali /= zero and fwd_idx_1 = raux_reg.ix else 
                (ali => raux_reg.ali, ix => raux_reg.ix, val => fwd_res_2.data, tag => fwd_res_2.tag) when raux_reg.ali /= zero and fwd_idx_2 = raux_reg.ix else 
                raux_reg;

    imm_fwd <= imm_reg;
END ARCHITECTURE behav;

