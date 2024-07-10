LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;

ENTITY key_debounce IS
   PORT( 
      clk            : IN     std_logic;
      ebreak_button  : IN     std_logic;
      res_n          : IN     std_logic;
      ebreak_release : OUT    boolean
   );

-- Declarations

END key_debounce ;
