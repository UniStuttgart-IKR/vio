-- VHDL Entity riscvio_lib.ex_res_mux.interface
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY ex_res_mux IS
   PORT( 
      alu_out_ex_u   : IN     word_T;
      branch_mode_dc : IN     branch_mode_T;
      pgu_mode_dc    : IN     pgu_mode_T;
      pgu_ptr_ex_u   : IN     reg_mem_T;
      ra_ex_u        : IN     reg_mem_T;
      res_ex_u       : OUT    reg_mem_T
   );

-- Declarations

END ex_res_mux ;
