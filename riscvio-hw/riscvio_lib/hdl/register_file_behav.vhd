-- VHDL Architecture riscvio_lib.register_file.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 15:43:49 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF register_file IS
  type register_file_T is array(ali_T'pos(t6) downto ali_T'pos(zero)) of reg_mem_T;
  signal registers: register_file_T;


BEGIN
    
    rdat.nbr  <= rdat_ix;
    rdat.ali  <= ali_T'val(rdat_ix) when rdat_ix <= ali_T'pos(t6) else zero;
    rdat.val  <= rd_wb.mem.val when rdat_ix = rd_wb.rf_nbr and rdat_ix = ali_T'pos(ra) else
                 rd_wb.mem.val when rdat_ix = rd_wb.rf_nbr and rdat_ix /= 0 else
                 registers(ali_T'pos(ra)).pi when rdat_ix = ali_T'pos(ra) else
                 registers(rdat_ix).val when rdat_ix <= ali_T'pos(t6) else
                 (others => '0');

    rptr.nbr  <= rptr_ix;
    rptr.ali  <= ali_T'val(rptr_ix) when rptr_ix <= ali_T'pos(t6) else zero;
    rptr.val  <= rd_wb.mem.val when rptr_ix = rd_wb.rf_nbr and rptr_ix /= 0 else
                 registers(rptr_ix).val when rptr_ix <= ali_T'pos(t6) else
                 (others => '0');
    rptr.ix   <= rd_wb.mem.ix when rptr_ix = rd_wb.rf_nbr and rptr_ix /= 0 else
                 registers(rptr_ix).ix when rptr_ix <= ali_T'pos(t6) else
                 (others => '0');
    rptr.pi   <= rd_wb.mem.pi when rptr_ix = rd_wb.rf_nbr and rptr_ix /= 0 else
                 registers(rptr_ix).pi when rptr_ix <= ali_T'pos(t6) else
                 (others => '0');
    rptr.dt   <= rd_wb.mem.dt when rptr_ix = rd_wb.rf_nbr and rptr_ix /= 0 else
                 registers(rptr_ix).dt when rptr_ix <= ali_T'pos(t6) else
                 (others => '0');

    raux.nbr  <= raux_ix;
    raux.ali  <= ali_T'val(raux_ix) when raux_ix <= ali_T'pos(t6) else zero;
    raux.val  <= rd_wb.mem.val when raux_ix = rd_wb.rf_nbr and raux_ix /= 0 else
                 registers(raux_ix).val when raux_ix <= ali_T'pos(t6) else 
                 (others => '0');
    raux.ix   <= rd_wb.mem.ix when raux_ix = rd_wb.rf_nbr and raux_ix /= 0 else
                 registers(raux_ix).ix when raux_ix <= ali_T'pos(t6) else 
                 (others => '0');
    raux.tag  <= POINTER when raux_ix = ali_T'pos(frame) or raux_ix = ali_T'pos(ra) else
                 rd_wb.mem.tag when raux_ix = rd_wb.rf_nbr and raux_ix /= 0 else
                 registers(raux_ix).tag when raux_ix <= ali_T'pos(t6) else
                 DATA;
    
    write: process(clk, res_n) is
    begin
      if res_n = '0' then
        for i in register_file_T'range(1) loop
          registers(i) <= (tag => DATA, val => (others => '0'), ix => (others => '0'), pi => (others => '0'), dt => (others => '0'));
        end loop;
        registers(ali_T'pos(core)).val <= X"FFFFFFF8";
        registers(ali_T'pos(core)).tag <= POINTER;
        registers(ali_T'pos(frame)).val <= X"00000001";
        registers(ali_T'pos(frame)).tag <= POINTER;
      else
        if clk'event and clk = '1' then
          if rd_wb.rf_nbr /= 0 and rd_wb.rf_nbr <= ali_T'pos(t6) then
            registers(rd_wb.rf_nbr) <= rd_wb.mem;
            if rd_wb.rf_nbr = ali_T'pos(frame) or rd_wb.rf_nbr = ali_T'pos(ra) then
              registers(rd_wb.rf_nbr).tag <= POINTER;
            end if;
          end if;
        end if;
      end if;
      
    end process write;
END ARCHITECTURE behav;

