LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY me_reg IS
   PORT( 
      clk           : IN     std_logic;
      ctrl_ex       : IN     ctrl_sig_T;
      exc_ex        : IN     exc_cause_T;
      imm_ex        : IN     word_T;
      pc_ex         : IN     pc_T;
      pipe_flush    : IN     boolean;
      raux_ex       : IN     raux_T;
      rdat_ex       : IN     rdat_T;
      rdst_ix_ex    : IN     reg_nbr_T;
      res_me_u      : IN     reg_mem_T;
      res_n         : IN     std_logic;
      rptr_ex       : IN     rptr_T;
      stall         : IN     boolean;
      addr_me       : OUT    reg_mem_T;
      addr_me_uq    : OUT    reg_mem_T;
      allocating_at : OUT    boolean;
      at_mode       : OUT    at_mode_T;
      ctrl_me       : OUT    ctrl_sig_T;
      exc_me        : OUT    exc_cause_T;
      imm_me        : OUT    word_T;
      pc_me         : OUT    pc_T;
      raux_me       : OUT    raux_T;
      rdat_me       : OUT    rdat_T;
      rdst_ix_me    : OUT    reg_nbr_T;
      res_me        : OUT    reg_mem_T;
      rptr_me       : OUT    rptr_T;
      wdt_me        : OUT    word_T;
      wpi_me        : OUT    word_T
   );

-- Declarations

END me_reg ;
