--
-- VHDL Architecture riscvio_lib.me_reg.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 13:59:56 09.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF me_reg IS
BEGIN
  process(clk, res_n) is
    begin
        if res_n = '0' then
            reg_rd_at <= REG_NULL;
            reg_rs1_at <= REG_NULL;
            reg_rs2_at <= REG_NULL;
            ctrl_at <= CTRL_NULL;
            alu_out_at <= (others => '0');
        else
            if clk'event and clk = '1' then
                ctrl_at <= ctrl_me;

                reg_rs1_at <= reg_rs1_me;
                reg_rs2_at <= reg_rs2_me;
                reg_rd_at <= reg_rd_me;

                alu_out_at <= alu_out_me;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;

