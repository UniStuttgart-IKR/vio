LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;

ENTITY attr_load_unit IS
   PORT( 
      ac_ld        : IN     std_logic_vector (63 DOWNTO 0);
      addr_me      : IN     reg_mem_T;
      addr_me_uq   : IN     reg_mem_T;
      at_mode_me   : IN     at_mode_T;
      ac_rena      : OUT    std_logic;
      addr_at      : OUT    word_T;
      dt_at_u      : OUT    word_T;
      next_addr_at : OUT    word_T;
      pi_at_u      : OUT    word_T
   );

-- Declarations

END attr_load_unit ;

