--
-- VHDL Entity riscvio_lib.next_pc_mux.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 16:10:31 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

library riscvio_lib;
use riscvio_lib.isa.all;

ENTITY next_pc_mux IS
  port(
    incremented_pc: in dword_T;
    static_branch_pc: in dword_T;
    dynamic_branch_pc: in dword_T;
    dbta_valid: in boolean;
    sbta_valid: in boolean;
    
    
    next_pc: out dword_T
  );
END ENTITY next_pc_mux;

