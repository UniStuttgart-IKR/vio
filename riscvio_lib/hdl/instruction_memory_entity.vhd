--
-- VHDL Entity riscvio_lib.instruction_memory.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 11:33:32 05.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;

ENTITY instruction_memory IS
  PORT(
    clk: in std_logic;
    addr: in dword_T;
    instr: out word_T;
    stall: out boolean
  );
END ENTITY instruction_memory;

