--
-- VHDL Architecture riscvio_lib.res_n_sync.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc023)
--          at - 16:26:53 07/09/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF res_n_sync IS
BEGIN
    process(clk, res_n) is
    begin
        if clk'event and clk = '1' then
            res_n <= locked;
        end if;
    end process;
END ARCHITECTURE behav;

