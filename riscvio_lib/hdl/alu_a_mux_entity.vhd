-- VHDL Entity riscvio_lib.alu_a_mux.symbol
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;

ENTITY alu_a_mux IS
   PORT( 
      alu_a_in_sel : IN     alu_in_sel_T;
      pc           : IN     pc_T;
      raux_dc      : IN     raux_T;
      rdat_dc      : IN     rdat_T;
      rptr_dc      : IN     rptr_T;
      a            : OUT    word_T
   );

-- Declarations

END alu_a_mux ;
