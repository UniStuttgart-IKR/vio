-- VHDL Entity riscvio_lib.nop_gen.generatedInstance
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY nop_gen IS
   PORT( 
      ctrl_dc_dec  : IN     ctrl_sig_t;
      ctrl_dc_u    : OUT    ctrl_sig_T;
      imm_dc_u     : OUT    word_T;
      imm_dec      : IN     word_T;
      insert_nop   : IN     boolean;
      rdst_ix_dc_u : OUT    reg_ix_T;
      rdst_ix_dec  : IN     reg_ix_T
   );

END nop_gen ;
