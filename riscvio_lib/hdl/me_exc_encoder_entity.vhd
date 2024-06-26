LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;

ENTITY me_exc_encoder IS
   PORT( 
      prev_exc       : IN  exc_reason_T;
      exc            : OUT exc_reason_T;

      heap_overflow : IN  boolean;
      stack_overflow  : IN  boolean
   );


END me_exc_encoder ;

