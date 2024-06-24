--
-- VHDL Architecture riscvio_lib.csr_unit.behav
--

LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF csr_unit IS
    type csrs_T is array(alc_lim to root) of word_T;
    signal csrs: csrs_T;
BEGIN
    reg: process(clk, res_n) is
    begin
        if res_n = '0' then
            csrs <= (others => (others => '0'));
            csrs(alc_lim) <= X"00000500";
            csrs(alc_addr) <= X"00000700";
            csrs(frame_lim) <= X"00000700";
            csrs(root) <= X"00000000";
            stack_overflow <= false;
        else
            if clk'event and clk = '1' then
                if rd_wb.csr_index /= ali_T'pos(no_csr) then
                    csrs(ali_T'val(rd_wb.csr_index)) <= rd_wb.mem.data;
                end if;
                if rd_wb.rf_index = ali_T'pos(frame) then
                    stack_overflow <= unsigned(rd_wb.mem.data) < unsigned(csrs(frame_lim));
                end if;
            end if;
        end if;
    end process;


    csr_val <= csrs(ali_T'val(csr_ix));
    heap_overflow <= unsigned(csrs(alc_addr)) < unsigned(csrs(alc_lim));
END ARCHITECTURE behav;

