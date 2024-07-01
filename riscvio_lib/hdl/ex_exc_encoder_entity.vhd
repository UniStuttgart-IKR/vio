LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY ex_exc_encoder IS
   PORT( 
      prev_exc       : IN  exc_cause_T;
      exc            : OUT exc_cause_T;

      frame_type_exc : IN  boolean;
      state_err_a_exc  : IN  boolean;
      pointer_arith_exc  : IN  boolean;
      ixoob_exc      : IN  boolean;
      state_err_b_exc  : IN  boolean
   );


END ex_exc_encoder ;

