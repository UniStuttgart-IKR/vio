LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;

ENTITY stall_logic IS
   PORT( 
      ac_stall       : IN     boolean;
      dc_stall       : IN     boolean;
      ic_stall       : IN     boolean;
      obj_init_stall : IN     boolean;
      stall          : OUT    boolean
   );

-- Declarations

END stall_logic ;

