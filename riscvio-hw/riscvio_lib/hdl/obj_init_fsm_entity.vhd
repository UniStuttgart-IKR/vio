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
      end_addr_uq        : IN     word_T;
      pgu_mode_dc_uq     : IN     pgu_mode_T;
      pgu_mode_ex        : IN     pgu_mode_T;
      res_n              : IN     std_logic;
      start_addr         : IN     word_T;
      start_addr_uq      : IN     word_T;
      obj_init_byte_ena  : OUT    std_logic_vector (BUS_WIDTH/8 - 1 DOWNTO 0);
      obj_init_data      : OUT    buzz_word_T;
      obj_init_stall     : OUT    boolean;
      obj_init_wr        : OUT    boolean;
      next_obj_init_addr : INOUT  word_T;
      obj_init_addr      : INOUT  word_T
   );

-- Declarations

END obj_init_fsm ;
