-- VHDL Entity riscvio_lib.dc_reg.interface
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY dc_reg IS
   PORT( 
      clk             : IN     std_logic;
      ctrl_dc_u       : IN     ctrl_sig_t;
      dbt_valid       : IN     boolean;
      heap_overflow   : IN     boolean;
      imm_dc_u        : IN     word_T;
      obj_init_stall  : IN     boolean;
      pc_if           : IN     pc_T;
      raux_dc_u       : IN     raux_T;
      rdat_dc_u       : IN     rdat_T;
      rdst_ix_dc_u    : IN     reg_ix_T;
      res_n           : IN     std_logic;
      rptr_dc_u       : IN     rptr_T;
      stack_overflow  : IN     boolean;
      alu_a_in_sel_dc : OUT    alu_in_sel_T;
      alu_b_in_sel_dc : OUT    alu_in_sel_T;
      alu_mode_dc     : OUT    alu_mode_T;
      branch_mode_dc  : OUT    branch_mode_T;
      ctrl_dc         : OUT    ctrl_sig_T;
      imm_dc_reg      : OUT    word_T;
      pc_dc           : OUT    pc_T;
      pgu_mode_dc     : OUT    pgu_mode_T;
      raux_dc_reg     : OUT    raux_T;
      rdat_dc_reg     : OUT    rdat_T;
      rdst_ix_dc_reg  : OUT    reg_ix_T;
      rptr_dc_reg     : OUT    rptr_T
   );

-- Declarations

END dc_reg ;
