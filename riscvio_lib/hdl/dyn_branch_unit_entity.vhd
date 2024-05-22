--
-- VHDL Entity riscvio_lib.dyn_branch_unit.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 12:53:45 09.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;

ENTITY dyn_branch_unit IS
  PORT(
    imm        : IN word_T;
    alu_flags  : IN alu_flags_T;
    ctrl_sig   : IN ctrl_sig_T;
    pc         : IN word_T;

    dbta_valid : OUT boolean;
    dbta       : OUT word_T
  ); 
END ENTITY dyn_branch_unit;

