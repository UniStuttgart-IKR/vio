LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY alu_b_mux IS
   PORT( 
      alu_b_in_sel : IN     alu_in_sel_T;
      imm_dc       : IN     word_T;
      raux_dc      : IN     raux_T;
      rdat_dc      : IN     rdat_T;
      rptr_dc      : IN     rptr_T;
      b            : OUT    word_T
   );

-- Declarations

END alu_b_mux ;
