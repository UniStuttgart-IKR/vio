LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;

ENTITY if_reg IS
   PORT( 
      clk           : IN     std_logic;
      dbt_valid     : IN     boolean;
      if_instr_d    : IN     word_T;
      insert_nop    : IN     boolean;
      pc_current_pc : IN     pc_T;
      res_n         : IN     std_logic;
      sbt_valid     : IN     boolean;
      stall         : IN     boolean;
      if_instr      : OUT    word_T;
      pc_if         : OUT    pc_T
   );

-- Declarations

END if_reg ;
