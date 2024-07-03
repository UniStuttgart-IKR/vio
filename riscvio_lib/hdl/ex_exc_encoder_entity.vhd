LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY ex_exc_encoder IS
   PORT( 
      prev_exc       : IN  exc_cause_T;
      exc            : OUT exc_cause_T;
      
      mux_exc        : IN  exc_cause_T;
      dbu_exc        : IN  exc_cause_T;
      pgu_exc        : IN  exc_cause_T
   );


END ex_exc_encoder ;

