-- VHDL Entity riscvio_lib.csr_unit.interface
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;

ENTITY csr_unit IS
   PORT( 
      clk            : IN     std_logic;
      csr_ix         : IN     csr_ix_T;
      rd_wb          : IN     reg_wb_T;
      res_n          : IN     std_logic;
      csr_val        : OUT    word_T;
      heap_overflow  : OUT    boolean;
      stack_overflow : OUT    boolean
   );

-- Declarations

END csr_unit ;
