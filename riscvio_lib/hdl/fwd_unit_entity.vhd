-- VHDL Entity riscvio_lib.fwd_unit.symbol
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;

ENTITY fwd_unit IS
   PORT( 
      fwd_0     : IN     boolean;
      fwd_1     : IN     boolean;
      fwd_2     : IN     boolean;
      fwd_idx_0 : IN     reg_ix_T   := 0;
      fwd_idx_1 : IN     reg_ix_T   := 0;
      fwd_idx_2 : IN     reg_ix_T   := 0;
      fwd_res_0 : IN     reg_mem_T  := REG_MEM_NULL;
      fwd_res_1 : IN     reg_mem_T  := REG_MEM_NULL;
      fwd_res_2 : IN     reg_mem_T  := REG_MEM_NULL;
      imm_reg   : IN     word_T;
      raux_reg  : IN     raux_T;
      rdat_reg  : IN     rdat_T;
      rdst_reg  : IN     reg_ix_T;
      rptr_reg  : IN     rptr_T;
      imm_fwd   : OUT    word_T;
      raux_fwd  : OUT    raux_T;
      rdat_fwd  : OUT    rdat_T;
      rdst_fwd  : OUT    reg_ix_T;
      rptr_fwd  : OUT    rptr_T
   );

-- Declarations

END fwd_unit ;
