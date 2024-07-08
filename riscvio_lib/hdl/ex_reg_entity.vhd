LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY ex_reg IS
   PORT( 
      clk            : IN     std_logic;
      ctrl_dc        : IN     ctrl_sig_T;
      exc_ex_u       : IN     exc_cause_T;
      imm_dc         : IN     word_T;
      me_addr_u      : IN     mem_addr_T;
      pc_dc          : IN     pc_T;
      pipe_flush     : IN     boolean;
      raux_dc        : IN     raux_T;
      rdat_dc        : IN     rdat_T;
      rdst_ix_dc     : IN     reg_nbr_T;
      res_ex_u       : IN     reg_mem_T;
      res_n          : IN     std_logic;
      rptr_dc        : IN     rptr_T;
      stall          : IN     boolean;
      allocating_me  : OUT    boolean;
      ctrl_ex        : OUT    ctrl_sig_T;
      exc_ex         : OUT    exc_cause_T;
      fwd_allowed_ex : OUT    boolean;
      imm_ex_reg     : OUT    word_T;
      me_addr        : OUT    mem_addr_T;
      me_addr_uq     : OUT    mem_addr_T;
      me_mode_ex     : OUT    mem_mode_T;
      me_mode_ex_uq  : OUT    mem_mode_T;
      pc_ex          : OUT    pc_T;
      pgu_mode_dc_uq : OUT    pgu_mode_T;
      pgu_mode_ex    : OUT    pgu_mode_T;
      raux_ex_reg    : OUT    raux_T;
      rdat_ex_reg    : OUT    rdat_T;
      rdst_ix_ex_reg : OUT    reg_nbr_T;
      res_ex         : OUT    reg_mem_T;
      rptr_ex_reg    : OUT    rptr_T;
      start_addr     : OUT    word_T;
      start_addr_uq  : OUT    word_T
   );

-- Declarations

END ex_reg ;
