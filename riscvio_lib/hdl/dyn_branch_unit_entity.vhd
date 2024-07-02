--
-- VHDL Entity riscvio_lib.dyn_branch_unit.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 12:53:45 09.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY dyn_branch_unit IS
  PORT(
    rdat           : IN rdat_T;
    raux           : IN raux_T;
    rptr           : IN rptr_T;
    imm            : IN word_T;
    rdst_ix        : IN reg_nbr_T;
    alu_flags      : IN alu_flags_T;
    branch_mode    : IN branch_mode_T;
    pc             : IN pc_T;

    state_error    : OUT boolean;
    target_error   : OUT boolean;
    ra_out         : OUT reg_mem_T;
    dbt_valid      : OUT boolean;
    dbt            : OUT pc_T
  ); 
END ENTITY dyn_branch_unit;

