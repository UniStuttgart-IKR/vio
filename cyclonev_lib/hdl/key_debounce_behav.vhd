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
                if key_in = '1' then
                    ignore_ctr <= 1;
                elsif ignore_ctr /= RELAXTIME and ignore_ctr /= 0 then
                    ignore_ctr <= ignore_ctr + 1;
                elsif key_in = '0' then
                    ignore_ctr <= 0;
                end if;
            end if;
        end if;
    end process;

    key_out <= ignore_ctr = RELAXTIME - 1;

END ARCHITECTURE behav;

