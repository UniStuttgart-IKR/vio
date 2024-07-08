LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY ex_res_mux IS
   PORT( 
      alu_mode_dc  : IN     alu_mode_T;
      alu_out_ex_u : IN     word_T;
      dbu_out_ex_u : IN     reg_mem_T;
      pgu_ptr_ex_u : IN     reg_mem_T;
      raux_dc      : IN     raux_T;
      rdat_dc      : IN     rdat_T;
      res_mux_sel  : IN     ex_res_mux_sel_T;
      rptr_dc      : IN     rptr_T;
      mux_exc      : OUT    exc_cause_T;
      res_ex_u     : OUT    reg_mem_T
   );

-- Declarations

END ex_res_mux ;
