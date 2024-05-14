--
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
    
    reg_rs1.mem <= registers(reg_rs1_index);
    reg_rs2.mem <= registers(reg_rs2_index);
    reg_rd.mem <= registers(reg_rd_index);

    reg_rs1.reg_index <= reg_rs1_index;
    reg_rs2.reg_index <= reg_rs2_index;
    reg_rd.reg_index <= reg_rd_index;
    
    write: process(clk, res_n) is
    begin
      if res_n = '0' then
        for i in register_file_T'range(1) loop
          registers(i) <= (tag => DATA, data => (others => '0'), pi => (others => '0'), delta => (others => '0'));
        end loop;
      else
        if clk'event and clk = '1' then
          if reg_rd_wb.reg_index /= 0 then
            registers(reg_rd_wb.reg_index) <= reg_rd_wb.mem;
          end if;
        end if;
      end if;
      
    end process write;
END ARCHITECTURE behav;

