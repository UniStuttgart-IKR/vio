LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;

ENTITY nib2sevenseg IS
   PORT( 
      nib   : IN     std_logic_vector (3 DOWNTO 0);
      seven : OUT    std_logic_vector (6 DOWNTO 0)
   );

-- Declarations

END nib2sevenseg ;
