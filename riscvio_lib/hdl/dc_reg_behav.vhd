-- VHDL Architecture riscvio_lib.if_reg.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 11:50:54 05.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF dc_reg IS
BEGIN
  process(clk, res_n) is
  begin
    if res_n = '0' then
      reg_rd_ex <= REG_NULL;
      reg_rs1_ex <= REG_NULL;
      reg_rs2_ex <= REG_NULL;
      ctrl_ex <= CTRL_NULL;
    else
      if clk'event and clk = '1' then
        ctrl_ex <= ctrl_dc_u;

        reg_rs1_ex <= reg_rs1_dc_u;
        reg_rs2_ex <= reg_rs2_dc_u;
        reg_rd_ex <= reg_rd_dc_u;
      end if;
    end if;
  end process;


  reg_rs1_data <= reg_rs1_ex.mem.data;
  reg_rs2_data <= reg_rs2_ex.mem.data;
  alu_mode_ex <= ctrl_ex.alu_mode; 

END ARCHITECTURE behav;