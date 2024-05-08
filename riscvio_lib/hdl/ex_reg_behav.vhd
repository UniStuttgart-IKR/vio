--
-- VHDL Architecture riscvio_lib.ex_reg.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 15:59:29 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF ex_reg IS
BEGIN
    process(clk, res_n) is
    begin
        if res_n = '0' then
        reg_rd_me <= REG_NULL;
        reg_rs1_me <= REG_NULL;
        reg_rs2_me <= REG_NULL;
        ctrl_me <= CTRL_NULL;
        alu_out_me <= (others => '0');
        else
            if clk'event and clk = '1' then
                ctrl_me <= ctrl_ex;

                reg_rs1_me <= reg_rs1_ex;
                reg_rs2_me <= reg_rs2_ex;
                reg_rd_me <= reg_rd_ex;

                alu_out_me <= alu_out_ex_u;
            end if;
        end if;
    end process;

END ARCHITECTURE behav;

