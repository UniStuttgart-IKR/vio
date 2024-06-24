LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;

ENTITY dcbr_wraccess_mux IS
   PORT( 
      dram_address_a      : IN     word_T;
      dram_byteena_a      : IN     STD_LOGIC_VECTOR (3 DOWNTO 0);
      dram_data_a         : IN     STD_LOGIC_VECTOR (31 DOWNTO 0);
      dram_wren_a         : IN     STD_LOGIC;
      next_dram_address_a : IN     word_T;
      next_obj_init_addr  : IN     word_T;
      obj_init_addr       : IN     word_T;
      obj_init_data       : IN     word_T;
      obj_init_wr         : IN     boolean;
      next_ram_addr_me    : OUT    word_T;
      ram_addr_me         : OUT    word_T;
      ram_byteena_me      : OUT    STD_LOGIC_VECTOR (3 DOWNTO 0);
      ram_wdata_me        : OUT    STD_LOGIC_VECTOR (31 DOWNTO 0);
      ram_wren_me         : OUT    STD_LOGIC
   );

-- Declarations

END dcbr_wraccess_mux ;

