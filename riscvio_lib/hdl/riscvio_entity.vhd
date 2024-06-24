LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY riscvio_lib;
USE riscvio_lib.caches.all;

ENTITY riscvio IS
   PORT( 
      ac_rack  : IN     boolean;
      ac_rdata : IN     buzz_word_T;
      clk      : IN     std_logic;
      dc_rack  : IN     boolean;
      dc_rdata : IN     buzz_word_T;
      dc_wack  : IN     boolean;
      ic_rack  : IN     boolean;
      ic_rdata : IN     std_logic_vector (BUS_WIDTH - 1 DOWNTO 0);
      res_n    : IN     std_logic;
      ac_raddr : OUT    std_logic_vector (31 DOWNTO 0);
      ac_rreq  : OUT    boolean;
      dc_raddr : OUT    std_logic_vector (31 DOWNTO 0);
      dc_rreq  : OUT    boolean;
      dc_waddr : OUT    std_logic_vector (31 DOWNTO 0);
      dc_wdata : OUT    buzz_word_T;
      dc_wreq  : OUT    boolean;
      ic_raddr : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      ic_rreq  : OUT    boolean
   );

-- Declarations

END riscvio ;

