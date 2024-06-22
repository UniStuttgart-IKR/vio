--
-- VHDL Entity riscvio_lib.ral_nop_unit.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 23:41:29 21.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;


ENTITY ral_nop_unit IS
    PORT(
        ctrl_if         : IN     ctrl_sig_T;
        ctrl_dc         : IN     ctrl_sig_T;
        ctrl_ex         : IN     ctrl_sig_T;
        
        rdat_ix         : IN     reg_ix_T;
        raux_ix         : IN     reg_ix_T;
        rptr_ix         : IN     reg_ix_T;

        rdst_dc         : IN     reg_ix_T;
        rdst_ex         : IN     reg_ix_T;

        dbt_valid       : IN     boolean;
        insert_nop      : OUT    boolean
    );
END ENTITY ral_nop_unit;

