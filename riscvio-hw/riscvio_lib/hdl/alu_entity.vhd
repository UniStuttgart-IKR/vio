--
-- VHDL Entity riscvio_lib.alu.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 15:08:10 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library riscvio_lib;
use riscvio_lib.pipeline.all;
use riscvio_lib.isa.all;

ENTITY alu IS
   PORT( 
      a       : IN     word_T;
      b       : IN     word_T;
      mode    : IN     alu_mode_T;
      alu_out : OUT    word_T;
      flags   : OUT    alu_flags_T
   );

-- Declarations

END alu ;

