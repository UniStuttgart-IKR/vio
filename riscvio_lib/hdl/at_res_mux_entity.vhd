-- VHDL Entity riscvio_lib.at_res_mux.interface
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY at_res_mux IS
   PORT( 
      ctrl_me  : IN     ctrl_sig_T;
      dt_at_u  : IN     word_T;
      pi_at_u  : IN     word_T;
      res_me   : IN     reg_mem_T;
      res_at_u : OUT    reg_mem_T
   );

-- Declarations

END at_res_mux ;
