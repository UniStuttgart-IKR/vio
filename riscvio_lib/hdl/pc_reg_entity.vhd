-- VHDL Entity riscvio_lib.pc_reg.interface
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY pc_reg IS
   PORT( 
      clk            : IN     std_logic;
      current_pc_d   : IN     pc_T;
      insert_nop     : IN     boolean;
      obj_init_stall : IN     boolean;
      res_n          : IN     std_logic;
      current_pc_uq  : OUT    pc_T;
      pc_current_pc  : OUT    pc_T
   );

-- Declarations

END pc_reg ;
