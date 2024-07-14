LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY stall_logic IS
   PORT( 
      ac_stall       : IN     boolean;
      clk            : IN     std_logic;
      dc_stall       : IN     boolean;
      ebreak_stall   : IN     boolean;
      ic_stall       : IN     boolean;
      io_stall_int   : IN     boolean;
      obj_init_stall : IN     boolean;
      res_n          : IN     std_logic;
      stall          : OUT    boolean
   );

-- Declarations

END stall_logic ;
