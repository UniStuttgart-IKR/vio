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
            rd_wb.csr_nbr <= ali_T'pos(no_csr);
            res_at <= REG_MEM_NULL;
            rdst_ix_at <= ali_T'pos(zero);
            pc_wb <= PC_NULL;
            exc_wb <= well_behaved;
        else
            if clk'event and clk = '1' then
                if not stall then
                    rd_wb.rf_nbr <= rdst_ix_me;
                    if (ctrl_me.pgu_mode = pgu_alc or  ctrl_me.pgu_mode = pgu_alcp or  ctrl_me.pgu_mode = pgu_alcd or  ctrl_me.pgu_mode = pgu_alci) and rdst_ix_me /= ali_T'pos(frame) then
                        rd_wb.csr_nbr <= ali_T'pos(alc_addr);
                    elsif rdst_ix_me > ali_T'pos(imm) then
                        rd_wb.csr_nbr <= rdst_ix_me;
                    else
                        rd_wb.csr_nbr <= ali_T'pos(no_csr);
                    end if;
                                       
                    rd_wb.ali <= ali_T'val(rdst_ix_me);

                    rd_wb.mem.val <= res_at_u.val;
                    rd_wb.mem.ix <= res_at_u.ix;
                    rd_wb.mem.pi <= res_at_u.pi;
                    rd_wb.mem.dt <=  res_at_u.dt;
                    rd_wb.mem.tag <= res_at_u.tag;

                    res_at <= res_at_u;
                    rdst_ix_at <= rdst_ix_me;
                    
                    pc_wb <= pc_me;
                    exc_wb <= exc_me;
                    assert ctrl_me.mnemonic /= ebreak report "EBREAK" severity failure;
                end if;
            end if;
        end if;
    end process;

    allocating_wb <= ali_T'val(rd_wb.csr_nbr) = alc_addr;
    pipe_flush <= exc_wb /= well_behaved and not IGNORE_EXC;
END ARCHITECTURE behav;

