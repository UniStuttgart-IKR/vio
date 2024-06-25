LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY block_ram_if IS
   PORT( 
      addr           : IN     word_T;
      dram_q_a       : IN     STD_LOGIC_VECTOR (31 DOWNTO 0);
      mode           : IN     mem_mode_T;
      mode_u         : IN     mem_mode_T;
      raux           : IN     raux_T;
      rdat           : IN     rdat_T;
      rptr           : IN     rptr_T;
      dram_address_a : OUT    word_T;
      dram_byteena_a : OUT    STD_LOGIC_VECTOR (3 DOWNTO 0);
      dram_data_a    : OUT    STD_LOGIC_VECTOR (31 DOWNTO 0);
      dram_wren_a    : OUT    STD_LOGIC;
      mem_out        : OUT    word_T
   );

-- Declarations

END block_ram_if ;
