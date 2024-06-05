--
-- VHDL Architecture riscvio_lib.csr_unit.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 16:38:34 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF csr_unit IS
    type csrs_T is array(csr_ix_T'low to csr_ix_T'high) of word_T;
    signal csrs: csrs_T;
BEGIN
    reg: process(clk, res_n) is
    begin
        if res_n = '0' then
            csrs <= (others => (others => '0'));
            csrs(ali_T'pos(alc_lim)) <= X"00000100";
            csrs(ali_T'pos(alc_addr)) <= X"00000200";
            csrs(ali_T'pos(frame_lim)) <= X"000000300";
            csrs(ali_T'pos(core)) <= X"FFFFFFF8";
            csrs(ali_T'pos(root)) <= X"0";
        else
            if clk'event and clk = '1' then
                if rd_wb.csr_index /= ali_T'pos(no_csr) then
                    csrs(rd_wb.csr_index) <= rd_wb.mem.data;
                end if;
            end if;
        end if;
    end process;


    csr_val <= csrs(csr_ix);
END ARCHITECTURE behav;

