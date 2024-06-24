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

    rdat_fwd <= (ali => rdat_reg.ali, ix => rdat_reg.ix, val => fwd_res_0.pi) when fwd_idx_0 = rdat_reg.ix and fwd_idx_0 = ali_T'pos(ra) else 
                (ali => rdat_reg.ali, ix => rdat_reg.ix, val => fwd_res_0.data) when fwd_idx_0 = rdat_reg.ix else 
                (ali => rdat_reg.ali, ix => rdat_reg.ix, val => fwd_res_1.pi) when fwd_idx_1 = rdat_reg.ix and fwd_idx_1 = ali_T'pos(ra) else 
                (ali => rdat_reg.ali, ix => rdat_reg.ix, val => fwd_res_1.data) when fwd_idx_1 = rdat_reg.ix else 
                (ali => rdat_reg.ali, ix => rdat_reg.ix, val => fwd_res_2.pi) when fwd_idx_2 = rdat_reg.ix and fwd_idx_2 = ali_T'pos(ra) else 
                (ali => rdat_reg.ali, ix => rdat_reg.ix, val => fwd_res_2.data) when fwd_idx_2 = rdat_reg.ix else 
                rdat_reg;

    rptr_fwd <= (ali => rptr_reg.ali, ix => rptr_reg.ix, val => fwd_res_0.data, pi => fwd_res_0.pi, dt => fwd_res_0.delta) when fwd_idx_0 = rptr_reg.ix else 
                (ali => rptr_reg.ali, ix => rptr_reg.ix, val => fwd_res_1.data, pi => fwd_res_1.pi, dt => fwd_res_1.delta) when fwd_idx_1 = rptr_reg.ix else 
                (ali => rptr_reg.ali, ix => rptr_reg.ix, val => fwd_res_2.data, pi => fwd_res_2.pi, dt => fwd_res_2.delta) when fwd_idx_2 = rptr_reg.ix else 
                rptr_reg;

    raux_fwd <= (ali => raux_reg.ali, ix => raux_reg.ix, val => fwd_res_0.data, tag => fwd_res_0.tag) when fwd_idx_0 = raux_reg.ix else 
                (ali => raux_reg.ali, ix => raux_reg.ix, val => fwd_res_1.data, tag => fwd_res_1.tag) when fwd_idx_1 = raux_reg.ix else 
                (ali => raux_reg.ali, ix => raux_reg.ix, val => fwd_res_2.data, tag => fwd_res_2.tag) when fwd_idx_2 = raux_reg.ix else 
                raux_reg;

    imm_fwd <= imm_reg;
END ARCHITECTURE behav;

