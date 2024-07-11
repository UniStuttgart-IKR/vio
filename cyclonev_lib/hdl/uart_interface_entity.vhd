LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;

ENTITY uart_interface IS
   PORT( 
      clk                 : IN     std_logic;
      data_stream_in_ack  : IN     std_logic;
      data_stream_in_done : IN     std_logic;
      data_stream_out     : IN     std_logic_vector (7 DOWNTO 0);
      data_stream_out_stb : IN     std_logic;
      res_n               : IN     std_logic;
      uart_active         : IN     boolean;
      uart_ix             : IN     word_T;
      uart_mode           : IN     mem_mode_T;
      uart_wdata          : IN     word_T;
      data_stream_in      : OUT    std_logic_vector (7 DOWNTO 0);
      data_stream_in_stb  : OUT    std_logic;
      uart_rdata          : OUT    word_T;
      uart_stall          : OUT    std_logic
   );

-- Declarations

END uart_interface ;
