-- VHDL Entity riscvio_lib.dcbr_wraccess_mux.interface
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY dcbr_wraccess_mux IS
   PORT( 
      dram_address_a : IN     word_T;
      dram_byteena_a : IN     STD_LOGIC_VECTOR (3 DOWNTO 0);
      dram_data_a    : IN     STD_LOGIC_VECTOR (31 DOWNTO 0);
      dram_wren_a    : IN     STD_LOGIC;
      obj_init_addr  : IN     word_T;
      obj_init_data  : IN     word_T;
      obj_init_wr    : IN     boolean;
      ram_addr_me    : OUT    STD_LOGIC_VECTOR (9 DOWNTO 0);
      ram_byteena_me : OUT    STD_LOGIC_VECTOR (3 DOWNTO 0);
      ram_wdata_me   : OUT    STD_LOGIC_VECTOR (31 DOWNTO 0);
      ram_wren_me    : OUT    STD_LOGIC
   );

-- Declarations

END dcbr_wraccess_mux ;
