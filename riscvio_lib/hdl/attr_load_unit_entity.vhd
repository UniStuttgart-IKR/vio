-- VHDL Entity riscvio_lib.attr_load_unit.interface
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY attr_load_unit IS
   PORT( 
      addr_me_uq   : IN     reg_mem_T;
      at_mode_me   : IN     at_mode_T;
      ram_rdata_at : IN     std_logic_vector (63 DOWNTO 0);
      dt_at_u      : OUT    word_T;
      pi_at_u      : OUT    word_T;
      ram_addr_at  : OUT    std_logic_vector (8 DOWNTO 0)
   );

-- Declarations

END attr_load_unit ;
