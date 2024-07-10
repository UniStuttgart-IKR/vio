LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;

ENTITY res_n_sync IS
   PORT( 
      clk       : IN     std_logic;
      locked    : IN     STD_LOGIC;
      res_n_raw : IN     std_logic;
      res_n     : OUT    std_logic
   );

-- Declarations

END res_n_sync ;
