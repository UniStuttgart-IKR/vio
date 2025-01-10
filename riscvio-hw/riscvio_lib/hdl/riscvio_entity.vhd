LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.isa.all;

ENTITY riscvio IS
   PORT( 
      ac_rack        : IN     boolean;
      ac_rdata       : IN     buzz_word_T;
      ac_wack        : IN     boolean;
      clk            : IN     std_logic;
      dc_rack        : IN     boolean;
      dc_rdata       : IN     buzz_word_T;
      dc_wack        : IN     boolean;
      ebreak_release : IN     boolean;
      ic_rack        : IN     boolean;
      ic_rdata       : IN     std_logic_vector (BUS_WIDTH - 1 DOWNTO 0);
      io_rdata       : IN     word_T;
      io_stall       : IN     std_logic;
      res_n          : IN     std_logic;
      ac_raddr       : OUT    std_logic_vector (31 DOWNTO 0);
      ac_rreq        : OUT    boolean;
      ac_waddr       : OUT    word_T;
      ac_wbyte_ena   : OUT    std_logic_vector (BUS_WIDTH/8 - 1 DOWNTO 0);
      ac_wdata       : OUT    buzz_word_T;
      ac_wreq        : OUT    boolean;
      dc_raddr       : OUT    std_logic_vector (31 DOWNTO 0);
      dc_rreq        : OUT    boolean;
      dc_waddr       : OUT    std_logic_vector (31 DOWNTO 0);
      dc_wbyte_ena   : OUT    std_logic_vector (BUS_WIDTH/8 - 1 DOWNTO 0);
      dc_wdata       : OUT    buzz_word_T;
      dc_wreq        : OUT    boolean;
      ebreak_stall   : OUT    boolean;
      ic_raddr       : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      ic_rreq        : OUT    boolean;
      io_dev         : OUT    std_logic_vector (11 DOWNTO 0);
      io_dev_u       : OUT    std_logic_vector (11 DOWNTO 0);
      io_ix          : OUT    word_T;
      io_ix_u        : OUT    word_T;
      io_mode        : OUT    mem_mode_T;
      io_mode_u      : OUT    mem_mode_T;
      io_wdata       : OUT    word_T;
      pc_if          : OUT    pc_T
   );

-- Declarations

END riscvio ;
