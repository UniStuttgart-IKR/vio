LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;

ENTITY me_reg IS
   PORT( 
      clk           : IN     std_logic;
      ctrl_ex       : IN     ctrl_sig_T;
      imm_ex        : IN     word_T;
      raux_ex       : IN     raux_T;
      rdat_ex       : IN     rdat_T;
      rdst_ix_ex    : IN     reg_ix_T;
      res_me_u      : IN     reg_mem_T;
      res_n         : IN     std_logic;
      rptr_ex       : IN     rptr_T;
      stall         : IN     boolean;
      addr_me       : OUT    reg_mem_T;
      addr_me_uq    : OUT    reg_mem_T;
      allocating_at : OUT    boolean;
      at_mode_me    : OUT    at_mode_T;
      ctrl_me       : OUT    ctrl_sig_T;
      imm_me        : OUT    word_T;
      raux_me       : OUT    raux_T;
      rdat_me       : OUT    rdat_T;
      rdst_ix_me    : OUT    reg_ix_T;
      res_me        : OUT    reg_mem_T;
      rptr_me       : OUT    rptr_T
   );

-- Declarations

END me_reg ;
