--
-- VHDL Architecture riscvio_lib.csr_unit.behav
--

LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF csr_unit IS
    type csrs_T is array(ali_T'pos(mtvec) to ali_T'pos(root)) of word_T;
    signal csrs: csrs_T;
    signal mepc_reg: pc_T;
    signal core_reg: reg_mem_T;
BEGIN
    reg: process(clk, res_n) is
    begin
        if res_n = '0' then
            csrs <= (others => (others => '0'));
            csrs(ali_T'pos(alc_lim)) <= X"00000500";
            csrs(ali_T'pos(alc_addr)) <= X"00000700";
            csrs(ali_T'pos(frame_lim)) <= X"00000700";
            csrs(ali_T'pos(root)) <= X"00000000";
            csrs(ali_T'pos(mtvec)) <= X"00000078";
            csrs(ali_T'pos(misa)) <= X"00000000";
            csrs(ali_T'pos(mstatus)) <= X"00000000";
            csrs(ali_T'pos(mcause)) <= X"00000000";
            csrs(ali_T'pos(mtval)) <= X"00000000";
            mepc_reg <= (ptr => X"00000000", ix => X"00000000", eoc => X"00000000");
            core_reg <= (val => X"00000000", ix => X"00000000", pi => X"00000000", dt => X"FFFFFFFF", tag => POINTER);
            csrs(ali_T'pos(mvendorid)) <= X"4C654C75";
            csrs(ali_T'pos(marchid)) <= X"5256694F";
            csrs(ali_T'pos(mimpid)) <= X"00000000";
        else
            if clk'event and clk = '1' then
                if rd_wb.ali = core then
                    core_reg <= rd_wb.mem;
                elsif rd_wb.ali = mtvec then
                    csrs(ali_T'pos(mtvec)) <= rd_wb.mem.ix;
                elsif rd_wb.csr_nbr /= ali_T'pos(no_csr) then
                    csrs(rd_wb.csr_nbr) <= rd_wb.mem.val;
                end if;
                
                if exc_wb /= well_behaved then
                    -- todo: we are required to store the instruction which triggered the exception into mtval
                    mepc_reg <= pc_wb;
                    csrs(ali_T'pos(mcause)) <= word_T(to_unsigned(exc_cause_T'pos(exc_wb), word_T'length));
                end if;

            end if;
        end if;
    end process;

    csr_nbr <=  csr_ix;
    csr_reg <=  (val => csrs(ali_T'pos(alc_addr)), pi => csrs(ali_T'pos(alc_lim)), dt => csrs(ali_T'pos(frame_lim)), ix => X"00000000", tag => POINTER) when ali_T'val(csr_ix) = alc_addr or ali_T'val(csr_ix) = alc_lim or ali_T'val(csr_ix) = frame_lim else
                (val => mepc_reg.ptr, ix => mepc_reg.ix, pi => X"00000000", dt => mepc_reg.eoc, tag => POINTER) when ali_T'val(csr_ix) = mepc else
                (val => core_reg.val, ix => csrs(ali_T'pos(mtvec)), pi => core_reg.pi, dt => core_reg.dt, tag => POINTER) when ali_T'val(csr_ix) = mtvec else
                (val => csrs(csr_ix), ix => X"00000000", pi => X"00000000", dt => X"00000000", tag => DATA) when csr_ix /= ali_T'pos(no_csr) else
                (val => X"00000000", ix => X"00000000", pi => X"00000000", dt => X"00000000", tag => DATA);

    cjt <= (ptr => core_reg.val, ix => csrs(ali_T'pos(mtvec)), eoc => core_reg.dt) when exc_wb /= well_behaved else 
            mepc_reg when xret = mret else
            PC_NULL;

    cjt_valid <= (exc_wb /= well_behaved and not IGNORE_EXC) or xret = mret;
END ARCHITECTURE behav;

