--
-- VHDL Architecture riscvio_lib.ex_reg.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 14:00:34 09.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--

ARCHITECTURE behav OF ex_reg IS
    
BEGIN
    process(clk, res_n) is
      variable tmp_ctrl: ctrl_sig_T;
    begin
        if res_n = '0' then
            rdst_ix_ex <= 0;
            rdat_ex <= RDAT_NULL;
            rptr_ex <= RPTR_NULL;
            raux_ex <= RAUX_NULL;
            imm_ex  <= (others => '0');
            ctrl_ex <= CTRL_NULL;
            alu_out_ex <= (others => '0');
        else
            if clk'event and clk = '1' then
                if clr_pgu_mode_me then
                    tmp_ctrl := ctrl_dc;
                    tmp_ctrl.pgu_mode := pgu_nop;
                    ctrl_ex <= tmp_ctrl;

                elsif not clr_stall then
                    ctrl_ex <= ctrl_dc;

                    rdst_ix_ex <= rdst_ix_dc;
                    rdat_ex <= rdat_dc;
                    rptr_ex <= rptr_dc;
                    raux_ex <= raux_dc;
                    imm_ex  <= imm_dc;
                    alu_out_ex <= alu_out_ex_u when ctrl_dc.pgu_mode = pgu_nop else alc_addr_ex_u;
                end if;
            end if;
        end if;
    end process;

END ARCHITECTURE behav;

