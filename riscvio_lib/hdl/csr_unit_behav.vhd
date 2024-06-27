--
-- VHDL Architecture riscvio_lib.csr_unit.behav
--

LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF csr_unit IS
    type csrs_T is array(mtvec to root) of word_T;
    signal csrs: csrs_T;
    signal mepc_reg: reg_mem_T;
BEGIN
    reg: process(clk, res_n) is
    begin
        if res_n = '0' then
            csrs <= (others => (others => '0'));
            csrs(alc_lim) <= X"00000500";
            csrs(alc_addr) <= X"00000700";
            csrs(frame_lim) <= X"00000700";
            csrs(root) <= X"00000000";
            csrs(mtvec) <= X"00000000";
            csrs(misa) <= X"00000000";
            csrs(mstatus) <= X"00000000";
            csrs(mcause) <= X"00000000";
            csrs(mtval) <= X"00000000";
            mepc_reg <= (data => X"00000000", pi => X"00000000", delta => X"00000000", tag => POINTER);
            csrs(mvendorid) <= X"00000000";
            csrs(marchid) <= X"00000000";
            csrs(mimpid) <= X"00000000";
        else
            if clk'event and clk = '1' then
                if rd_wb.csr_index = ali_T'pos(mepc) then
                    mepc_reg <= rd_wb.mem;
                elsif rd_wb.csr_index /= ali_T'pos(no_csr) then
                    csrs(ali_T'val(rd_wb.csr_index)) <= rd_wb.mem.data;
                end if;
            end if;
        end if;
    end process;

    csr_reg <=  (data => csrs(ali_T'val(csr_ix)), pi => csrs(alc_lim), delta => csrs(frame_lim), tag => POINTER)    when ali_T'val(csr_ix) = alc_addr else
                mepc_reg                                                                                            when ali_T'val(csr_ix) = mepc else
                (data => csrs(ali_T'val(csr_ix)), pi => X"00000000", delta => X"00000000", tag => DATA);
END ARCHITECTURE behav;

