-- VHDL Architecture riscvio_lib.if_reg.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 11:50:54 05.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF dc_reg IS
BEGIN
  process(clk, res_n) is
  begin
    if res_n = '0' then
      rdst_ix_dc_reg <= 0;
      rdat_dc_reg <= RDAT_NULL;
      rptr_dc_reg <= RPTR_NULL;
      raux_dc_reg <= RAUX_NULL;
      imm_dc_reg  <= (others => '0');
      ctrl_dc <= CTRL_NULL;
      pc_dc <= PC_NULL;
      branch_mode_dc <= no_branch;
      exc_dc <= well_behaved;
    else
      if clk'event and clk = '1' then
        if pipe_flush then
          rdst_ix_dc_reg <= 0;
          rdat_dc_reg <= RDAT_NULL;
          rptr_dc_reg <= RPTR_NULL;
          raux_dc_reg <= RAUX_NULL;
          imm_dc_reg  <= (others => '0');
          ctrl_dc <= CTRL_NULL;
          pc_dc <= PC_NULL;
          branch_mode_dc <= no_branch;
          exc_dc <= well_behaved;
        elsif not (stall = '1') then
          ctrl_dc <= CTRL_NULL when dbt_valid else ctrl_dc_u;
          branch_mode_dc <= no_branch when dbt_valid else ctrl_dc_u.branch_mode;

          rdst_ix_dc_reg <= 0 when dbt_valid else rdst_ix_dc_u;
          rdat_dc_reg <= RDAT_NULL when dbt_valid else rdat_dc_u;
          rptr_dc_reg <= RPTR_NULL when dbt_valid else rptr_dc_u;
          raux_dc_reg <= RAUX_NULL when dbt_valid else raux_dc_u;
          imm_dc_reg  <= (others => '0') when dbt_valid else imm_dc_u;
          
          pc_dc <= pc_if;
          exc_dc <= exc_dc_u;
        end if;
      end if;
    end if;
  end process;

  alu_mode_dc     <= ctrl_dc.alu_mode; 
  alu_a_in_sel_dc <= ctrl_dc.alu_a_sel;
  alu_b_in_sel_dc <= ctrl_dc.alu_b_sel;
  pgu_mode_dc     <= ctrl_dc.pgu_mode;

END ARCHITECTURE behav;