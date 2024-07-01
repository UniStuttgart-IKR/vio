ARCHITECTURE behav OF fwd_unit IS
BEGIN
    rdst_fwd <= rdst_reg;

    rdat_fwd <= (ali => rdat_reg.ali, nbr => rdat_reg.nbr, val => fwd_res_0.val) when fwd_idx_0 = rdat_reg.nbr and fwd_idx_0 /= ali_T'pos(zero) else 
                (ali => rdat_reg.ali, nbr => rdat_reg.nbr, val => fwd_res_1.val) when fwd_idx_1 = rdat_reg.nbr and fwd_idx_1 /= ali_T'pos(zero) else 
                (ali => rdat_reg.ali, nbr => rdat_reg.nbr, val => fwd_res_2.val) when fwd_idx_2 = rdat_reg.nbr and fwd_idx_2 /= ali_T'pos(zero) else 
                rdat_reg;

    rptr_fwd <= (ali => rptr_reg.ali, nbr => rptr_reg.nbr, val => fwd_res_0.val, ix => fwd_res_0.ix, pi => rptr_reg.pi, dt => rptr_reg.dt) when fwd_0 and ali_t'val(rptr_reg.nbr) = alc_addr else 
                (ali => rptr_reg.ali, nbr => rptr_reg.nbr, val => fwd_res_0.val, ix => fwd_res_0.ix, pi => fwd_res_0.pi, dt => fwd_res_0.dt) when fwd_idx_0 = rptr_reg.nbr and fwd_idx_0 /= ali_T'pos(zero) else 
                (ali => rptr_reg.ali, nbr => rptr_reg.nbr, val => fwd_res_1.val, ix => fwd_res_1.ix, pi => rptr_reg.pi, dt => rptr_reg.dt) when fwd_1 and ali_t'val(rptr_reg.nbr) = alc_addr else
                (ali => rptr_reg.ali, nbr => rptr_reg.nbr, val => fwd_res_1.val, ix => fwd_res_1.ix, pi => fwd_res_1.pi, dt => fwd_res_1.dt) when fwd_idx_1 = rptr_reg.nbr and fwd_idx_1 /= ali_T'pos(zero) else
                (ali => rptr_reg.ali, nbr => rptr_reg.nbr, val => fwd_res_2.val, ix => fwd_res_2.ix, pi => rptr_reg.pi, dt => rptr_reg.dt) when fwd_2 and ali_t'val(rptr_reg.nbr) = alc_addr else
                (ali => rptr_reg.ali, nbr => rptr_reg.nbr, val => fwd_res_2.val, ix => fwd_res_2.ix, pi => fwd_res_2.pi, dt => fwd_res_2.dt) when fwd_idx_2 = rptr_reg.nbr and fwd_idx_2 /= ali_T'pos(zero) else
                rptr_reg;

    raux_fwd <= (ali => raux_reg.ali, nbr => raux_reg.nbr, val => fwd_res_0.val, ix => fwd_res_0.ix, tag => fwd_res_0.tag) when fwd_idx_0 = raux_reg.nbr and fwd_idx_0 /= ali_T'pos(zero) else 
                (ali => raux_reg.ali, nbr => raux_reg.nbr, val => fwd_res_1.val, ix => fwd_res_1.ix, tag => fwd_res_1.tag) when fwd_idx_1 = raux_reg.nbr and fwd_idx_1 /= ali_T'pos(zero) else 
                (ali => raux_reg.ali, nbr => raux_reg.nbr, val => fwd_res_2.val, ix => fwd_res_2.ix, tag => fwd_res_2.tag) when fwd_idx_2 = raux_reg.nbr and fwd_idx_2 /= ali_T'pos(zero) else 
                raux_reg;

    imm_fwd <= imm_reg;
END ARCHITECTURE behav;