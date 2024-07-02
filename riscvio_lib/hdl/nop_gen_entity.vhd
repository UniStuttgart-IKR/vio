LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY nop_gen IS
   PORT( 
      ctrl_dc_dec  : IN     ctrl_sig_t;
      ctrl_dc_u    : OUT    ctrl_sig_T;
      imm_dc_u     : OUT    word_T;
      imm_dec      : IN     word_T;
      exc_dc_dec   : IN     exc_cause_T;
      exc_dc_u     : OUT    exc_cause_T;
      insert_nop   : IN     boolean;
      rdst_ix_dc_u : OUT    reg_nbr_T;
      rdst_ix_dec  : IN     reg_nbr_T
   );

END nop_gen ;
