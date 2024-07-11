ARCHITECTURE behav OF res_n_sync IS
    signal res_n_int : std_logic := '0';
BEGIN
    process(clk, locked) is
    begin
        if clk'event and clk = '1' then
            res_n_int <= locked;
        end if;
    end process;

    res_n <= res_n_int;
END ARCHITECTURE behav;

