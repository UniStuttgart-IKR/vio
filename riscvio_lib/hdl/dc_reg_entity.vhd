LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY dc_reg IS
   PORT( 
      clk             : IN     std_logic;
      ctrl_dc_u       : IN     ctrl_sig_T;
      dbt_valid       : IN     boolean;
      ebreak_release  : IN     boolean;
      exc_dc_u        : IN     exc_cause_T;
      imm_dc_u        : IN     word_T;
      pc_if           : IN     pc_T;
      pipe_flush      : IN     boolean;
      raux_dc_u       : IN     raux_T;
      rdat_dc_u       : IN     rdat_T;
      rdst_ix_dc_u    : IN     reg_nbr_T;
      res_n           : IN     std_logic;
      rptr_dc_u       : IN     rptr_T;
      stall           : IN     boolean;
      alu_a_in_sel_dc : OUT    alu_in_sel_T;
      alu_b_in_sel_dc : OUT    alu_in_sel_T;
      alu_mode_dc     : OUT    alu_mode_T;
      branch_mode_dc  : OUT    branch_mode_T;
      ctrl_dc         : OUT    ctrl_sig_T;
      ebreak_stall    : OUT    boolean;
      exc_dc          : OUT    exc_cause_T;
      fwd_allowed_dc  : OUT    boolean;
      imm_dc_reg      : OUT    word_T;
      pc_dc           : OUT    pc_T;
      pgu_mode_dc     : OUT    pgu_mode_T;
      raux_dc_reg     : OUT    raux_T;
      rdat_dc_reg     : OUT    rdat_T;
      rdst_ix_dc_reg  : OUT    reg_nbr_T;
      res_mux_sel     : OUT    ex_res_mux_sel_T;
      rptr_dc_reg     : OUT    rptr_T
   );

-- Declarations

END dc_reg ;
