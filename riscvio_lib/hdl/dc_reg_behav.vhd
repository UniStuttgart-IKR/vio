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
      rdst_ix_dc <= 0;
      rdat_dc <= RDAT_NULL;
      rptr_dc <= RPTR_NULL;
      raux_dc <= RAUX_NULL;
      imm_dc  <= (others => '0');
      ctrl_dc <= CTRL_NULL;
      pc_dc <= PC_NULL;
      branch_mode_dc <= no_branch;
      
    else
      if clk'event and clk = '1' then
        if not obj_init_stall then
          ctrl_dc <= CTRL_NULL when dbt_valid else ctrl_dc_u;
          branch_mode_dc <= no_branch when dbt_valid else ctrl_dc_u.branch_mode;

          rdst_ix_dc <= rdst_ix_dc_u;
          rdat_dc <= rdat_dc_u;
          rptr_dc <= rptr_dc_u;
          raux_dc <= raux_dc_u;
          imm_dc  <= imm_dc_u;
          
          pc_dc <= pc_if;
        end if;
      end if;
    end if;
  end process;

  alu_mode_dc     <= ctrl_dc.alu_mode; 
  alu_a_in_sel_dc <= ctrl_dc.alu_a_sel;
  alu_b_in_sel_dc <= ctrl_dc.alu_b_sel;
  pgu_mode_dc     <= ctrl_dc.pgu_mode;

END ARCHITECTURE behav;