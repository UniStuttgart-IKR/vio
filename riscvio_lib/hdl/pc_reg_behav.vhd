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
      pc_current_pc <= (ptr => X"FFFFFFF8", ix => X"FFFFFFFD", pi => (others => '0'), dt => (others => '0'));
    else
      if clk'event and clk = '1' then
        pc_current_pc <= current_pc_d;
      end if;
    end if;
  end process;
END ARCHITECTURE behav;

