--
-- VHDL Architecture riscvio_lib.at_reg.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 14:01:21 09.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF at_reg IS
BEGIN
    process(clk, res_n) is
    begin
        if res_n = '0' then
            rd_wb <= REG_WB_NULL;
            res_at <= REG_MEM_NULL;
            rdst_ix_at <= ali_T'pos(zero);
        else
            if clk'event and clk = '1' then
                if not obj_init_stall then
                    rd_wb.rf_index <= rdst_ix_me;
                    rd_wb.csr_index <= ali_T'pos(alc_addr) when (ctrl_me.pgu_mode = pgu_alc 
                                                            or  ctrl_me.pgu_mode = pgu_alcp 
                                                            or  ctrl_me.pgu_mode = pgu_alcd 
                                                            or  ctrl_me.pgu_mode = pgu_alci)
                                                            and rdst_ix_me /= ali_T'pos(frame) else 
                                       ali_T'pos(no_csr);
                                       
                    rd_wb.ali <= ali_T'val(rdst_ix_me);

                    rd_wb.mem.data <= res_at_u.data;
                    rd_wb.mem.pi <= res_at_u.pi;
                    rd_wb.mem.delta <=  res_at_u.delta;
                    rd_wb.mem.tag <= res_at_u.tag;

                    res_at <= res_at_u;
                    rdst_ix_at <= rdst_ix_me;
                end if;
            end if;
        end if;
    end process;

    allocating_wb <= ali_T'val(rd_wb.csr_index) = alc_addr;
END ARCHITECTURE behav;

