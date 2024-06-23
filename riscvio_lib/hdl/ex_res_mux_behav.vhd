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
    res_ex_u <= pgu_ptr_ex_u when pgu_mode_dc /= pgu_nop else
                dbu_out_ex_u when branch_mode_dc = jal or branch_mode_dc = jalr or branch_mode_dc = jlib else
                (data => alu_out_ex_u, tag => raux_dc.tag, pi => (others => '0'), delta => (others => '0'));
END ARCHITECTURE behav;
