--
-- VHDL Architecture audiotest_lib.clk_res_gen_var.behav
--
-- Created:
--          by - st167825.st167825 (pc023)
--          at - 10:20:40 02/06/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF clk_res_gen_var IS
BEGIN
  osc: process is
  begin
    clk <= '0';
    wait for OFFTIME;
    clk <= '1';
    wait for ONTIME;
  end process osc;
  reset: process is
  begin
    res_n <= '0';
    wait for RESETTIME;
    res_n <= '1';
    wait;
  end process reset;
END ARCHITECTURE behav;

