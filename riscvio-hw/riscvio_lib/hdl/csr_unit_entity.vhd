LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY csr_unit IS
   PORT( 
      clk       : IN     std_logic;
      csr_ix    : IN     reg_nbr_T;
      exc_wb    : IN     exc_cause_T;
      pc_wb     : IN     pc_T;
      rd_wb     : IN     reg_wb_T;
      res_n     : IN     std_logic;
      xret      : IN     xret_T;
      cjt       : OUT    pc_T;
      cjt_valid : OUT    boolean;
      csr_nbr   : OUT    reg_nbr_T;
      csr_reg   : OUT    reg_mem_T
   );

-- Declarations

END csr_unit ;
