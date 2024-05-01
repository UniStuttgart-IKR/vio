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
  type register_file_T is array(31 downto 0) of register_T;
  signal registers: register_file_T;
BEGIN
    
    reg_a <= registers(to_integer(unsigned(reg_a_index)));
    reg_b <= registers(to_integer(unsigned(reg_b_index)));
    reg_c <= registers(to_integer(unsigned(reg_c_index)));
    
    write: process(clk, res_n) is
    begin
      if res_n = '0' then
        for i in register_file_T'range(1) loop
          registers(i) <= (mode => DATA, data => (others => '0'), pi => (others => '0'), delta => (others => '0'));
        end loop;
      else
        if clk'event and clk = '1' then
          if write_reg_en then
            registers(to_integer(unsigned(write_index))) <= write_reg;
          end if;
        end if;
      end if;
      
    end process write;
END ARCHITECTURE behav;

