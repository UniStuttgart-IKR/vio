LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY obj_init_fsm IS
   PORT( 
      clk                : IN     std_logic;
      dc_stall           : IN     boolean;
      end_addr           : IN     word_T;
      pgu_mode_dc_uq     : IN     pgu_mode_T;
      pgu_mode_ex        : IN     pgu_mode_T;
      rdst_ix_ex         : IN     reg_nbr_T;
      res_ex             : IN     reg_mem_T;
      res_ex_uq          : IN     reg_mem_T;
      res_n              : IN     std_logic;
      next_obj_init_addr : OUT    word_T;
      obj_init_addr      : OUT    word_T;
      obj_init_data      : OUT    dword_T;
      obj_init_wr        : OUT    boolean;
      stall              : OUT    std_logic
   );

-- Declarations

END obj_init_fsm ;
