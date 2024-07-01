LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY pc_reg IS
   PORT( 
      cjt_valid     : IN     boolean;
      clk           : IN     std_logic;
      current_pc_d  : IN     pc_T;
      dbt_valid     : IN     boolean;
      insert_nop    : IN     boolean;
      pipe_flush    : IN     boolean;
      res_n         : IN     std_logic;
      sbt_valid     : IN     boolean;
      stall         : IN     std_logic;
      current_pc_uq : OUT    pc_T;
      pc_current_pc : OUT    pc_T
   );

-- Declarations

END pc_reg ;
