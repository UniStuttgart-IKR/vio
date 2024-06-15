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
    type csrs_T is array(alc_lim to root) of word_T;
    signal csrs: csrs_T;
BEGIN
    reg: process(clk, res_n) is
    begin
        if res_n = '0' then
            csrs <= (others => (others => '0'));
            csrs(alc_lim) <= X"00000100";
            csrs(alc_addr) <= X"00000200";
            csrs(frame_lim) <= X"00000200";
            csrs(core) <= X"FFFFFFF8";
            csrs(root) <= X"00000000";
        else
            if clk'event and clk = '1' then
                if rd_wb.csr_index /= ali_T'pos(no_csr) then
                    csrs(ali_T'val(rd_wb.csr_index)) <= rd_wb.mem.data;
                end if;
            end if;
        end if;
    end process;


    csr_val <= csrs(ali_T'val(csr_ix));
END ARCHITECTURE behav;

