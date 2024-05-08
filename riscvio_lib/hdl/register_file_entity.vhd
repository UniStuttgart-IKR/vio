--
-- VHDL Entity riscvio_lib.register_file.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 15:38:55 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
library riscvio_lib;
use riscvio_lib.isa.all;


ENTITY register_file IS
  port(
    clk, res_n: in std_logic;
    
    reg_rd_index: in reg_ix_T;
    reg_rs1_index: in reg_ix_T;
    reg_rs2_index: in reg_ix_T;
    
    reg_rd: out reg_T;
    reg_rs1: out reg_T;
    reg_rs2: out reg_T;
    
    reg_rd_wb: in reg_T
  );
    
END ENTITY register_file;

