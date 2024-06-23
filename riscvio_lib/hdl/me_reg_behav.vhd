--
-- VHDL Architecture riscvio_lib.me_reg.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 13:59:56 09.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF me_reg IS
BEGIN
  process(clk, res_n) is
    begin
        if res_n = '0' then
            rdst_ix_me <= 0;
            rdat_me <= RDAT_NULL;
            rptr_me <= RPTR_NULL;
            raux_me <= RAUX_NULL;
            imm_me  <= (others => '0');
            ctrl_me <= CTRL_NULL;
            res_me <= REG_MEM_NULL;
        else
            if clk'event and clk = '1' then
                if not stall then
                    ctrl_me <= ctrl_ex;
                    at_mode_me <= ctrl_ex.at_mode;

                    rdst_ix_me <= rdst_ix_ex;
                    rdat_me <= rdat_ex;
                    rptr_me <= rptr_ex;
                    raux_me <= raux_ex;
                    imm_me  <= imm_ex;
                    res_me <= res_me_u;
                end if;
            end if;
        end if;
    end process;

    
    addr_me_uq <= res_me_u when not stall else res_me;
    allocating_at <= ali_T'val(rptr_me.ix) = alc_addr;
END ARCHITECTURE behav;

