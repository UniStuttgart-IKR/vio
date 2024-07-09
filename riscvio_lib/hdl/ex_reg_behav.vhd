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
            rdst_ix_ex_reg <= 0;
            rdat_ex_reg <= RDAT_NULL;
            rptr_ex_reg <= RPTR_NULL;
            raux_ex_reg <= RAUX_NULL;
            imm_ex_reg  <= (others => '0');
            ctrl_ex <= CTRL_NULL;
            res_ex <= REG_MEM_NULL;
            me_addr <= MEM_ADDR_NULL;
            pc_ex <= PC_NULL;
            start_addr <= (others => '0');
            end_addr <= (others => '0');
            exc_ex <= well_behaved;
        else
            if clk'event and clk = '1' then
                if pipe_flush then
                    rdst_ix_ex_reg <= 0;
                    rdat_ex_reg <= RDAT_NULL;
                    rptr_ex_reg <= RPTR_NULL;
                    raux_ex_reg <= RAUX_NULL;
                    imm_ex_reg  <= (others => '0');
                    ctrl_ex <= CTRL_NULL;
                    res_ex <= REG_MEM_NULL;
                    me_addr <= MEM_ADDR_NULL;
                    pc_ex <= PC_NULL;
                    start_addr <= (others => '0');
                    exc_ex <= well_behaved;
                    end_addr <= (others => '0');
                elsif not stall then
                    ctrl_ex <= ctrl_dc;
                    
                    rdst_ix_ex_reg <= rdst_ix_dc;
                    rdat_ex_reg <= rdat_dc;
                    rptr_ex_reg <= rptr_dc;
                    raux_ex_reg <= raux_dc;
                    imm_ex_reg  <= imm_dc;

                    res_ex <= res_ex_u;
                    me_addr <= me_addr_u;
                    start_addr <= me_addr_u.addr;
                    end_addr <= init_end_addr_u;
                    
                    pc_ex <= pc_dc;
                    exc_ex <= exc_ex_u;
                end if;
            end if;
        end if;
    end process;

    me_mode_ex <= ctrl_ex.me_mode;
    me_mode_ex_uq <= ctrl_dc.me_mode;
    start_addr_uq <= me_addr_u.addr;
    end_addr_uq <= init_end_addr_u;
    pgu_mode_ex <= ctrl_ex.pgu_mode;
    pgu_mode_dc_uq <= ctrl_dc.pgu_mode;
    fwd_allowed_ex  <= ctrl_ex.fwd_allowed;


    me_addr_uq <= me_addr_u when not stall else me_addr;
    --raux_dc_uq <= raux_ex_reg;
    --rptr_dc_uq <= rptr_ex_reg;
    --rdat_dc_uq <= rdat_ex_reg;
    allocating_me <= ali_T'val(rptr_ex_reg.nbr) = alc_addr;
END ARCHITECTURE behav;

