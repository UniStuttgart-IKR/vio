--
-- VHDL Architecture riscvio_lib.ral_nop_unit.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 23:41:46 21.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF ral_nop_unit IS
    signal data_ral: boolean;
    signal pointer_ral: boolean;
    signal attr_ral: boolean;
BEGIN
    data_ral <= (ctrl_dc.me_mode = lb or ctrl_dc.me_mode = lbu or ctrl_dc.me_mode = lh or ctrl_dc.me_mode = lhu or ctrl_dc.me_mode = lw or ctrl_dc.me_mode = load_rix) and (rdst_dc = rdat_ix or rdst_dc = raux_ix);
    pointer_ral <= (ctrl_dc.me_mode = lp or ctrl_dc.me_mode = load_rcd) and rdst_dc = rptr_ix;
    attr_ral <= ((ctrl_ex.me_mode = lp or ctrl_dc.me_mode = load_rcd) and (rdst_ex = rptr_ix));

    -- if we will clear the instruction in the dc stage anyway we dont need to insert nops for this instr
    insert_nop <= not dbt_valid and (data_ral or pointer_ral or attr_ral);
END ARCHITECTURE behav;

