--
-- VHDL Architecture riscvio_lib.dc_reg.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 15:55:39 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF if_reg IS
BEGIN
  process(clk, res_n) is
  begin
    if res_n = '0' then
      if_instr <= X"00000013";
      pc_if <= PC_NULL;
    else
      if clk'event and clk = '1' then
        if not (obj_init_stall or insert_nop) then
          if_instr <= NOP_INSTR when (sbt_valid or dbt_valid) else if_instr_d;
          pc_if <= pc_current_pc;
        end if;
      end if;
    end if;
  end process;
END ARCHITECTURE behav;
