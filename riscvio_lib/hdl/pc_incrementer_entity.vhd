--
-- VHDL Entity riscvio_lib.pc_incrementer.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 16:03:16 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
library riscvio_lib;
use riscvio_lib.isa.all;

ENTITY pc_incrementer IS
  port(
    pc: in word_T;
    next_pc: out word_T
  );
END ENTITY pc_incrementer;

