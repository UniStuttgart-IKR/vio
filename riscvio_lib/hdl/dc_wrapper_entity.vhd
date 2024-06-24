LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;

ENTITY dc_wrapper IS
   PORT( 
      addr      : IN     std_logic_vector (31 DOWNTO 0);
      bena      : IN     std_logic_vector (3 DOWNTO 0);
      clk       : IN     std_logic;
      next_addr : IN     std_logic_vector (31 DOWNTO 0);
      rack      : IN     boolean;
      rdata     : IN     buzz_word_T;
      rena      : IN     std_logic;
      res_n     : IN     std_logic;
      sd        : IN     word_T;
      wack      : IN     boolean;
      wena      : IN     std_logic;
      ld        : OUT    word_T;
      raddr     : OUT    std_logic_vector (31 DOWNTO 0);
      rreq      : OUT    boolean;
      stall     : OUT    boolean;
      waddr     : OUT    std_logic_vector (31 DOWNTO 0);
      wdata     : OUT    buzz_word_T;
      wreq      : OUT    boolean
   );

-- Declarations

END dc_wrapper ;

