LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;

ENTITY io_mux IS
   PORT( 
      clk                 : IN     std_logic;
      data_stream_in_ack  : IN     std_logic;
      data_stream_in_done : IN     std_logic;
      data_stream_out     : IN     std_logic_vector (7 DOWNTO 0);
      data_stream_out_stb : IN     std_logic;
      io_dev              : IN     std_logic_vector (11 DOWNTO 0);
      io_ix               : IN     word_T;
      io_mode             : IN     mem_mode_T;
      io_wdata            : IN     word_T;
      res_n               : IN     std_logic;
      data_stream_in      : OUT    std_logic_vector (7 DOWNTO 0);
      data_stream_in_stb  : OUT    std_logic;
      io_rdata            : OUT    word_T;
      io_stall            : OUT    std_logic;
      leds                : OUT    std_logic_vector (7 DOWNTO 0);
      seven_seg_0         : OUT    std_logic_vector (7 DOWNTO 0);
      seven_seg_1         : OUT    std_logic_vector (7 DOWNTO 0);
      seven_seg_2         : OUT    std_logic_vector (7 DOWNTO 0);
      seven_seg_3         : OUT    std_logic_vector (7 DOWNTO 0)
   );

-- Declarations

END io_mux ;

