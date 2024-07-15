LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY cyclonev_lib;
USE cyclonev_lib.soc.all;

ENTITY io_mux IS
   PORT( 
      io_dev       : IN     std_logic_vector (11 DOWNTO 0);
      io_dev_u     : IN     std_logic_vector (11 DOWNTO 0);
      io_ix        : IN     word_T;
      io_ix_u      : IN     word_T;
      io_mode      : IN     mem_mode_T;
      io_mode_u    : IN     mem_mode_T;
      io_wdata     : IN     word_T;
      seven_rdata  : IN     word_T;
      seven_stall  : IN     std_logic;
      uart_rdata   : IN     word_T;
      uart_stall   : IN     std_logic;
      io_rdata     : OUT    word_T;
      io_stall     : OUT    std_logic;
      seven_active : OUT    boolean;
      seven_ix     : OUT    word_T;
      seven_mode   : OUT    mem_mode_T;
      seven_wdata  : OUT    word_T;
      uart_active  : OUT    boolean;
      uart_ix      : OUT    word_T;
      uart_mode    : OUT    mem_mode_T;
      uart_wdata   : OUT    word_T
   );

-- Declarations

END io_mux ;
