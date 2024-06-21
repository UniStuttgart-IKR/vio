-- VHDL Entity riscvio_lib.csr_rf_mux.interface
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY csr_rf_mux IS
   PORT( 
      csr_val   : IN     word_T;
      raux_rf   : IN     raux_T;
      rdat_ix   : IN     reg_ix_T;
      rdat_rf   : IN     rdat_T;
      rptr_ix   : IN     reg_ix_T;
      rptr_rf   : IN     rptr_T;
      raux_dc_u : OUT    raux_T;
      rdat_dc_u : OUT    rdat_T;
      rptr_dc_u : OUT    rptr_T
   );

-- Declarations

END csr_rf_mux ;
