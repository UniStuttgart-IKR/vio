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
BEGIN
    res_ex_u <= dbu_out_ex_u when branch_mode_dc = jal or branch_mode_dc = jalr or branch_mode_dc = jlib else
                (val => alu_out_ex_u, tag => DATA, ix => (others => '0'), pi => (others => '0'), dt => (others => '0')) when alu_mode_dc /= alu_illegal and raux_dc.tag = DATA else
                (val => rptr_dc.val, tag => POINTER, ix => alu_out_ex_u, pi => rptr_dc.pi, dt => rptr_dc.dt) when alu_mode_dc /= alu_illegal and raux_dc.tag = POINTER else
                pgu_ptr_ex_u;

    pointer_arith_exc <= INDEX_SIZE = 0 and alu_mode_dc /= alu_illegal and raux_dc.tag = POINTER;
END ARCHITECTURE behav;
