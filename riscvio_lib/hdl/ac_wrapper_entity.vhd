LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;

ENTITY ac_wrapper IS
   PORT( 
      clk   : IN     std_logic;
      rack  : IN     boolean;
      rdata : IN     buzz_word_T;
      rena  : IN     std_logic;
      res_n : IN     std_logic;
      ld    : OUT    word_T;
      raddr : OUT    std_logic_vector (31 DOWNTO 0);
      rreq  : OUT    boolean;
      stall : OUT    boolean
   );

-- Declarations

END ac_wrapper ;
