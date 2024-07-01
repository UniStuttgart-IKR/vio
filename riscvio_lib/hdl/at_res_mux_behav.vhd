--
-- VHDL Architecture riscvio_lib.at_res_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 17:05:45 16.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF at_res_mux IS
BEGIN
    res_at_u <= (val => res_me.val, tag => POINTER, ix => res_me.ix, pi => pi_at_u, dt => dt_at_u) when ctrl_me.at_mode = maybe and res_me.tag = POINTER and unsigned(res_me.pi) = 0 and unsigned(res_me.dt) = 0 else
                (val => res_me.val, tag => POINTER, ix => res_me.ix, pi => res_me.pi, dt => dt_at_u) when ctrl_me.at_mode = delta_only else
                res_me;
END ARCHITECTURE behav;

