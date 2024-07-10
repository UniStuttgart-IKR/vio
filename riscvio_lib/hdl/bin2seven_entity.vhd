LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;

ENTITY bin2seven IS
   PORT( 
      pc_if       : IN     pc_T;
      seven_seg_0 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_1 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_2 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_3 : OUT    std_logic_vector (6 DOWNTO 0)
   );

-- Declarations

END bin2seven ;
