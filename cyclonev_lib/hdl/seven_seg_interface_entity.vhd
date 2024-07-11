LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;

ENTITY seven_seg_interface IS
   PORT( 
      clk          : IN     std_logic;
      res_n        : IN     std_logic;
      seven_active : IN     boolean;
      seven_ix     : IN     word_T;
      seven_mode   : IN     mem_mode_T;
      seven_wdata  : IN     word_T;
      nib0         : OUT    std_logic_vector (3 DOWNTO 0);
      nib1         : OUT    std_logic_vector (3 DOWNTO 0);
      nib2         : OUT    std_logic_vector (3 DOWNTO 0);
      nib3         : OUT    std_logic_vector (3 DOWNTO 0);
      seven_rdata  : OUT    word_T;
      seven_stall  : OUT    std_logic
   );

-- Declarations

END seven_seg_interface ;
