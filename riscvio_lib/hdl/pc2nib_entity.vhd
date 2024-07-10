LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;

ENTITY pc2nib IS
   PORT( 
      pc_if : IN     pc_T;
      nib0  : OUT    std_logic_vector (3 DOWNTO 0);
      nib1  : OUT    std_logic_vector (3 DOWNTO 0);
      nib2  : OUT    std_logic_vector (3 DOWNTO 0);
      nib3  : OUT    std_logic_vector (3 DOWNTO 0)
   );

-- Declarations

END pc2nib ;
