--
-- VHDL Architecture riscvio_lib.pc_reg.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 17:02:34 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF pc_reg IS
BEGIN
  process(clk, res_n) is
  begin
    if res_n = '0' then
      pc_current_pc <= PC_NULL;
    else
      if clk'event and clk = '1' then
        if not (stall or insert_nop) or sbt_valid or dbt_valid or cjt_valid then
          pc_current_pc <= current_pc_d;
        end if;
      end if;
    end if;
  end process;

  current_pc_uq <= pc_current_pc when insert_nop else current_pc_d;
END ARCHITECTURE behav;

