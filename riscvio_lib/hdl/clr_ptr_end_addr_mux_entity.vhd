-- VHDL Entity riscvio_lib.clr_ptr_end_addr_mux.interface
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY clr_ptr_end_addr_mux IS
   PORT( 
      raux_ex    : IN     raux_T;
      rdst_ix_ex : IN     reg_ix_T;
      rptr_ex    : IN     rptr_T;
      end_addr   : OUT    word_T
   );

-- Declarations

END clr_ptr_end_addr_mux ;
