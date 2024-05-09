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
            reg_rd_wb <= REG_NULL;
        else
            if clk'event and clk = '1' then
                reg_rd_wb <= reg_rd_at;
                reg_rd_wb.mem.data <= alu_out_at;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;

