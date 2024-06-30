--
-- VHDL Architecture riscvio_lib.csr_unit.behav
--

LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF csr_unit IS
    type csrs_T is array(mtvec to root) of word_T;
    signal csrs: csrs_T;
    signal mepc_reg: pc_T;
    signal core_reg: reg_mem_T;
BEGIN
    reg: process(clk, res_n) is
    begin
        if res_n = '0' then
            csrs <= (others => (others => '0'));
            csrs(alc_lim) <= X"00000500";
            csrs(alc_addr) <= X"00000700";
            csrs(frame_lim) <= X"00000700";
            csrs(root) <= X"00000000";
            csrs(mtvec) <= X"00000078";
            csrs(misa) <= X"00000000";
            csrs(mstatus) <= X"00000000";
            csrs(mcause) <= X"00000000";
            csrs(mtval) <= X"00000000";
            mepc_reg <= (ptr => X"00000000", pi => X"00000000", dt => X"00000000", ix => X"00000000");
            core_reg <= (data => X"00000000", pi => X"00000000", delta => X"FFFFFFFF", tag => POINTER);
            csrs(mvendorid) <= X"4C654C75";
            csrs(marchid) <= X"5256694F";
            csrs(mimpid) <= X"00000000";
        else
            if clk'event and clk = '1' then
                if rd_wb.ali = core then
                    core_reg <= rd_wb.mem;
                elsif rd_wb.ali = mtvec then
                    csrs(mtvec) <= rd_wb.mem.pi;
                elsif rd_wb.csr_index /= ali_T'pos(no_csr) then
                    csrs(ali_T'val(rd_wb.csr_index)) <= rd_wb.mem.data;
                end if;
                
                if exc_wb /= well_behaved then
                    -- todo: we are required to store the instruction which triggered the exception into mtval
                    mepc_reg <= pc_wb;
                    csrs(mcause) <= word_T(to_unsigned(exc_cause_T'pos(exc_wb), word_T'length));
                end if;

            end if;
        end if;
    end process;

    csr_reg <=  (data => csrs(ali_T'val(csr_ix)), pi => csrs(alc_lim), delta => csrs(frame_lim), tag => POINTER)    when ali_T'val(csr_ix) = alc_addr else
                -- todo: convert all pointers to include an index to fix this 
                (data => mepc_reg.ptr, pi => mepc_reg.pi, delta => mepc_reg.dt, tag => POINTER) when ali_T'val(csr_ix) = mepc else
                (data => csrs(ali_T'val(csr_ix)), pi => X"00000000", delta => X"00000000", tag => DATA);

    cjt <= (ptr => core_reg.data, ix => csrs(mtvec), pi => core_reg.pi, dt => core_reg.delta) when exc_wb /= well_behaved else 
            mepc_reg when xret = mret else
            PC_NULL;

    cjt_valid <= (exc_wb /= well_behaved and not IGNORE_EXC) or xret = mret;
END ARCHITECTURE behav;

