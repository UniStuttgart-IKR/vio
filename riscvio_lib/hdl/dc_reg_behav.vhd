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
      rd_ex <= REG_NULL;
      rs1_ex <= REG_NULL;
      rs2_ex <= REG_NULL;
      ctrl_ex <= CTRL_NULL;
      pc_ex <= (others => '0');
    else
      if clk'event and clk = '1' then
        ctrl_ex <= CTRL_NULL when dbta_valid else ctrl_dc_u;

        rs1_ex <= rs1_dc_u;
        rs2_ex <= rs2_dc_u;
        rd_ex <= rd_dc_u;
        
        pc_ex <= pc_dc;
      end if;
    end if;
  end process;


  rs1_data <= rs1_ex.mem.data;
  rs2_data <= rs2_ex.mem.data;
  alu_mode_ex <= ctrl_ex.alu_mode; 

END ARCHITECTURE behav;