LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY cyclonev_lib;
USE cyclonev_lib.all;

ENTITY key_debounce IS
   PORT( 
      clk     : IN     std_logic;
      key_in  : IN     std_logic;
      res_n   : IN     std_logic;
      key_out : OUT    boolean
   );

-- Declarations

END key_debounce ;
