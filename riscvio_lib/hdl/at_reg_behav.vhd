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
        else
            if clk'event and clk = '1' then
                if not clr_stall then
                    rd_wb.rf_index <= rdst_ix_me;
                    rd_wb.csr_index <= ali_T'pos(alc_addr) when ctrl_me.pgu_mode /= pgu_nop and rdst_ix_me /= ali_T'pos(frame) else ali_T'pos(no_csr);
                    rd_wb.mem.data <= alu_out_me;
                    rd_wb.mem.tag <= POINTER when ctrl_me.pgu_mode /= pgu_nop;
                end if;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;

