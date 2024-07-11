LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;

ENTITY io IS
   PORT( 
      clk            : IN     std_logic;
      ebreak         : IN     boolean;
      ebreak_button  : IN     std_logic;
      io_dev         : IN     std_logic_vector (11 DOWNTO 0);
      io_dev_u       : IN     std_logic_vector (11 DOWNTO 0);
      io_ix          : IN     word_T;
      io_ix_u        : IN     word_T;
      io_mode        : IN     mem_mode_T;
      io_mode_u      : IN     mem_mode_T;
      io_wdata       : IN     word_T;
      pc             : IN     pc_T;
      res_n          : IN     std_logic;
      rx             : IN     std_logic;
      ebreak_release : OUT    boolean;
      io_rdata       : OUT    word_T;
      io_stall       : OUT    std_logic;
      seven_seg_0    : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_1    : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_2    : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_3    : OUT    std_logic_vector (6 DOWNTO 0);
      tx             : OUT    std_logic
   );

-- Declarations

END io ;
