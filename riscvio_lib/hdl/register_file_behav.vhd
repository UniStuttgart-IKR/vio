-- VHDL Architecture riscvio_lib.register_file.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 15:43:49 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF register_file IS
  type register_file_T is array(reg_ix_T'high downto reg_ix_T'low) of reg_mem_T;
  signal registers: register_file_T;


BEGIN
    
    rdat.ix   <= rdat_ix;
    rdat.ali  <= ali_T'val(rdat_ix);
    rdat.val  <= registers(rdat_ix).data;

    rptr.ix   <= rptr_ix;
    rptr.ali  <= ali_T'val(rptr_ix);
    rptr.val  <= registers(rptr_ix).data;
    rptr.pi   <= registers(rptr_ix).pi;
    rptr.dt   <= registers(rptr_ix).delta;

    raux.ix   <= rptr_ix;
    raux.ali  <= ali_T'val(rptr_ix);
    raux.val  <= registers(rptr_ix).data;
    raux.tag  <= registers(rptr_ix).tag;
    
    write: process(clk, res_n) is
    begin
      if res_n = '0' then
        for i in register_file_T'range(1) loop
          registers(i) <= (tag => DATA, data => (others => '0'), pi => (others => '0'), delta => (others => '0'));
        end loop;
      else
        if clk'event and clk = '1' then
          if rd_wb.index /= 0 then
            registers(rd_wb.index) <= rd_wb.mem;
          end if;
        end if;
      end if;
      
    end process write;
END ARCHITECTURE behav;

