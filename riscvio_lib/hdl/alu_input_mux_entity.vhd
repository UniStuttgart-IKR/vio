--
-- VHDL Entity riscvio_lib.alu_input_mux.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 15:21:22 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
library riscvio_lib;
use riscvio_lib.isa.all;


ENTITY alu_input_mux IS
  port(
    imm: in imm_12_bit_T;
    reg_data: in dword_T;
    use_imm: in boolean;
    
    b: out dword_T
  );
END ENTITY alu_input_mux;

