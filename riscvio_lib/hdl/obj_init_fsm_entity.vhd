LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;

ENTITY obj_init_fsm IS
   PORT( 
      alc_lim_csr        : IN     word_T;
      clk                : IN     std_logic;
      dc_stall           : IN     boolean;
      end_addr           : IN     word_T;
      frame_lim_csr      : IN     word_T;
      pgu_mode_dc_uq     : IN     pgu_mode_T;
      pgu_mode_ex        : IN     pgu_mode_T;
      rdst_ix_ex         : IN     reg_ix_T;
      res_ex             : IN     reg_mem_T;
      res_ex_uq          : IN     reg_mem_T;
      res_n              : IN     std_logic;
      heap_overflow_ex   : OUT    boolean;
      next_obj_init_addr : OUT    word_T;
      obj_init_addr      : OUT    word_T;
      obj_init_data      : OUT    dword_T;
      obj_init_stall     : OUT    boolean;
      obj_init_wr        : OUT    boolean;
      stack_overflow_ex  : OUT    boolean
   );

-- Declarations

END obj_init_fsm ;
