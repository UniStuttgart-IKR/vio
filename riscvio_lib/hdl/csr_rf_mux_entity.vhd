LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY csr_rf_mux IS
   PORT( 
      csr_mux_sel : IN     csr_mux_sel_T;
      csr_nbr     : IN     reg_nbr_T;
      csr_reg     : IN     reg_mem_T;
      raux_rf     : IN     raux_T;
      rdat_rf     : IN     rdat_T;
      rptr_rf     : IN     rptr_T;
      raux_dc_u   : OUT    raux_T;
      rdat_dc_u   : OUT    rdat_T;
      rptr_dc_u   : OUT    rptr_T
   );

-- Declarations

END csr_rf_mux ;
