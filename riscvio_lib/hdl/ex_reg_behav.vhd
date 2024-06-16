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
    begin
        if res_n = '0' then
            rdst_ix_ex <= 0;
            rdat_ex <= RDAT_NULL;
            rptr_ex <= RPTR_NULL;
            raux_ex <= RAUX_NULL;
            imm_ex  <= (others => '0');
            ctrl_ex <= CTRL_NULL;
            res_ex <= REG_MEM_NULL;
        else
            if clk'event and clk = '1' then

                if not obj_init_stall then
                    ctrl_ex <= ctrl_dc;
                    
                    rdst_ix_ex <= rdst_ix_dc;
                    rdat_ex <= rdat_dc;
                    rptr_ex <= rptr_dc;
                    raux_ex <= raux_dc;
                    imm_ex  <= imm_dc;

                    res_ex <= res_ex_u;
                end if;
            end if;
        end if;
    end process;

    me_mode_ex <= ctrl_ex.me_mode;
    me_mode_dc_uq <= ctrl_dc.me_mode;
    pgu_mode_ex <= ctrl_ex.pgu_mode;


    res_ex_uq <= res_ex_u;
    raux_dc_uq <= raux_dc;
    rptr_dc_uq <= rptr_dc;
END ARCHITECTURE behav;

