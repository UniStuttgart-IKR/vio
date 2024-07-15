LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY cyclonev_lib;
USE cyclonev_lib.soc.all;

ENTITY seven_seg IS
   PORT( 
      clk         : IN     std_logic;
      ebreak      : IN     boolean;
      nib0        : IN     std_logic_vector (3 DOWNTO 0);
      nib1        : IN     std_logic_vector (3 DOWNTO 0);
      nib2        : IN     std_logic_vector (3 DOWNTO 0);
      nib3        : IN     std_logic_vector (3 DOWNTO 0);
      pc          : IN     pc_T;
      res_n       : IN     std_logic;
      seven_seg_0 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_1 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_2 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_3 : OUT    std_logic_vector (6 DOWNTO 0)
   );

-- Declarations

END seven_seg ;
