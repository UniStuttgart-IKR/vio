LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;

ENTITY ex_res_mux IS
   PORT( 
      alu_out_ex_u   : IN     word_T;
      branch_mode_dc : IN     branch_mode_T;
      dbu_out_ex_u   : IN     reg_mem_T;
      pgu_mode_dc    : IN     pgu_mode_T;
      pgu_ptr_ex_u   : IN     reg_mem_T;
      raux_dc        : IN     raux_T;
      res_ex_u       : OUT    reg_mem_T
   );

-- Declarations

END ex_res_mux ;

