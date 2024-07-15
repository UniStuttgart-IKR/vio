--
-- VHDL Architecture riscvio_lib.ex_res_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 16:56:44 16.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF ex_res_mux IS
    signal new_pointer: word_T;
BEGIN

    res_ex_u <= dbu_out_ex_u when res_mux_sel = DBU else
                pgu_ptr_ex_u when res_mux_sel = PGU else
                (val => alu_out_ex_u,    tag => DATA,        ix => (others => '0'), pi => (others => '0'), dt => (others => '0')) when res_mux_sel = ALU and raux_dc.tag = DATA else
                (val => rptr_dc.val,     tag => POINTER,     ix => alu_out_ex_u,    pi => rptr_dc.pi,      dt => rptr_dc.dt)      when res_mux_sel = ALU and raux_dc.tag = POINTER else
                (val => rdat_dc.val,     tag => DATA,        ix => (others => '0'), pi => (others => '0'), dt => (others => '0')) when res_mux_sel = DAT else
                (val => raux_dc.val,     tag => raux_dc.tag, ix => raux_dc.ix,      pi => (others => '0'), dt => (others => '0')) when res_mux_sel = AUX else
                (val => rptr_dc.val,     tag => POINTER,     ix => rptr_dc.ix,      pi => rptr_dc.pi,      dt => rptr_dc.dt)      when res_mux_sel = PTR else
                (val => (others => '0'), tag => DATA,        ix => (others => '0'), pi => (others => '0'), dt => (others => '0'));

    mux_exc <= ptari when isPointerArithException(alu_mode_dc, raux_dc) else well_behaved;
END ARCHITECTURE behav;
