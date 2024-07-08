LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY at_reg IS
   PORT( 
      clk           : IN     std_logic;
      ctrl_me       : IN     ctrl_sig_T;
      exc_me        : IN     exc_cause_T;
      imm_me        : IN     word_T;
      pc_me         : IN     pc_T;
      raux_me       : IN     raux_T;
      rdat_me       : IN     rdat_T;
      rdst_ix_me    : IN     reg_nbr_T;
      res_at_u      : IN     reg_mem_T;
      res_n         : IN     std_logic;
      rptr_me       : IN     rptr_T;
      stall         : IN     boolean;
      allocating_wb : OUT    boolean;
      exc_wb        : OUT    exc_cause_T;
      pc_wb         : OUT    pc_T;
      pipe_flush    : OUT    boolean;
      rd_wb         : OUT    reg_wb_T;
      rdst_ix_at    : OUT    reg_nbr_T;
      res_at        : OUT    reg_mem_T
   );

-- Declarations

END at_reg ;
