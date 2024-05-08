--
-- VHDL Architecture riscvio_lib.at_reg.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 16:02:17 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF at_reg IS
BEGIN
    process(clk, res_n) is
    begin
        if res_n = '0' then
            reg_rd_wb <= REG_NULL;
        else
            if clk'event and clk = '1' then
                reg_rd_wb <= reg_rd_at;
                reg_rd_wb.mem.data <= alu_out_at;
            end if;
        end if;
    end process;

END ARCHITECTURE behav;

