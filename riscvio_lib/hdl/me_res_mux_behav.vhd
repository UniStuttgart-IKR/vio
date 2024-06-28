--
-- VHDL Architecture riscvio_lib.me_res_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 17:00:37 16.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF me_res_mux IS
BEGIN
    res_me_u <= (data => mem_out_me_u(WORD0_RANGE), tag => DATA, pi => (others => '0'), delta => (others => '0')) when ctrl_ex.me_mode /= holiday and ctrl_ex.me_mode /= lp and ctrl_ex.me_mode /= load_ix and ctrl_ex.me_mode /= load_rpc else
                (data => mem_out_me_u(WORD0_RANGE), tag => POINTER, pi => (others => '0'), delta => (others => '0')) when ctrl_ex.me_mode = lp else
                (data => mem_out_me_u(WORD1_RANGE), tag => POINTER, pi => mem_out_me_u(WORD0_RANGE), delta => (others => '0')) when ctrl_ex.me_mode = load_rpc else
                (data => raux_ex.val, tag => POINTER, pi => mem_out_me_u(WORD0_RANGE), delta => (others => '0')) when ctrl_ex.me_mode = load_ix else
                res_ex;
END ARCHITECTURE behav;

