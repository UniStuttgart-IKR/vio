LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.pipeline.all;

ENTITY ac_wrapper IS
   PORT( 
      addr      : IN     reg_mem_T;
      at_mode   : IN     at_mode_T;
      clk       : IN     std_logic;
      next_addr : IN     reg_mem_T;
      rack      : IN     boolean;
      rdata     : IN     buzz_word_T;
      res_n     : IN     std_logic;
      wdt       : IN     word_T;
      wpi       : IN     word_T;
      ldt       : OUT    word_T;
      lpi       : OUT    word_T;
      raddr     : OUT    std_logic_vector (31 DOWNTO 0);
      rreq      : OUT    boolean;
      stall     : OUT    std_logic
   );

-- Declarations

END ac_wrapper ;
