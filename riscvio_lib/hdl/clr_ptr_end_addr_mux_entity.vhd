LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY clr_ptr_end_addr_mux IS
   PORT( 
      raux_ex    : IN     raux_T;
      rdst_ix_ex : IN     reg_nbr_T;
      rptr_ex    : IN     rptr_T;
      end_addr   : OUT    word_T
   );

-- Declarations

END clr_ptr_end_addr_mux ;
