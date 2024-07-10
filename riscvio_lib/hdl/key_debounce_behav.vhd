--
-- VHDL Architecture riscvio_lib.key_debounce.behav
--
-- Created:
--          by - leylknci.meyer (pc024)
--          at - 15:50:17 07/10/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF key_debounce IS
    constant RELAXTIME: natural := 10000;
    signal ignore_ctr: natural range 0 to RELAXTIME;
BEGIN
    process(clk, res_n) is
    begin
        if res_n = '0' then
            ignore_ctr <= 0;
        else
            if clk'event and clk = '1' then
                if ebreak_button = '1' then
                    ignore_ctr <= 1;
                elsif ignore_ctr /= RELAXTIME and ignore_ctr /= 0 then
                    ignore_ctr <= ignore_ctr + 1;
                elsif ebreak_button = '0' then
                    ignore_ctr <= 0;
                end if;
            end if;
        end if;
    end process;

    ebreak_release <= ignore_ctr = RELAXTIME - 1;

END ARCHITECTURE behav;

