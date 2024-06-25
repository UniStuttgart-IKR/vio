LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;

ENTITY pc_reg IS
   PORT( 
      clk           : IN     std_logic;
      current_pc_d  : IN     pc_T;
      dbt_valid     : IN     boolean;
      insert_nop    : IN     boolean;
      res_n         : IN     std_logic;
      sbt_valid     : IN     boolean;
      stall         : IN     boolean;
      current_pc_uq : OUT    pc_T;
      pc_current_pc : OUT    pc_T
   );

-- Declarations

END pc_reg ;
