--
-- VHDL Architecture riscvio_lib.if_reg.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 11:50:54 05.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF if_reg IS
BEGIN
  process(clk, res_n) is
  begin
    if res_n = '0' then
      if_instr <= (others => '0');
    else
      if clk'event and clk = '1' then
        if_instr <= if_instr_d;
      end if;
    end if;
  end process;
END ARCHITECTURE behav;