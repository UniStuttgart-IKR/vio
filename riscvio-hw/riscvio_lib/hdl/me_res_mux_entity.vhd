LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY me_res_mux IS
   PORT( 
      ctrl_ex      : IN     ctrl_sig_T;
      io_out_me_u  : IN     word_T;
      mem_out_me_u : IN     dword_T;
      raux_ex      : IN     raux_T;
      res_ex       : IN     reg_mem_T;
      rptr_ex      : IN     rptr_T;
      res_me_u     : OUT    reg_mem_T
   );

-- Declarations

END me_res_mux ;
