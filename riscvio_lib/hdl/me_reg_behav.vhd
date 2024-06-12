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
            alu_out_me <= (others => '0');
            mem_out_me <= (others => '0');
        else
            if clk'event and clk = '1' then
                if not clr_stall then
                    ctrl_me <= ctrl_ex;
                    at_mode_me <= ctrl_ex.at_mode;

                    rdst_ix_me <= rdst_ix_ex;
                    rdat_me <= rdat_ex;
                    rptr_me <= rptr_ex;
                    raux_me <= raux_ex;
                    imm_me  <= imm_ex;
                    mem_out_me <= mem_out_me_u;
                    alu_out_me <= alu_out_ex;
                end if;
            end if;
        end if;
    end process;

    
    mem_out_me_uq <= mem_out_me_u;
END ARCHITECTURE behav;

