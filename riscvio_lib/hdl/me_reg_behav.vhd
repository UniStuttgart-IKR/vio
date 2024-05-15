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
            rd_at <= REG_NULL;
            rs1_at <= REG_NULL;
            rs2_at <= REG_NULL;
            ctrl_at <= CTRL_NULL;
            alu_out_at <= (others => '0');
        else
            if clk'event and clk = '1' then
                ctrl_at <= ctrl_me;

                rs1_at <= rs1_me;
                rs2_at <= rs2_me;
                rd_at <= rd_me;

                alu_out_at <= alu_out_me;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;

