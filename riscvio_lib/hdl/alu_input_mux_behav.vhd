--
-- VHDL Architecture riscvio_lib.b_operator_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 19:50:38 28.04.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF alu_input_mux IS
BEGIN
  mux_and_extend: process(all) is
    variable high_bit_extended: std_logic_vector(dword_T'length - imm_12_bit_T'length - 1 downto 0);
  begin
    for i in high_bit_extended'range loop
      high_bit_extended(i) := dc_alu_imm(imm_12_bit_T'left);
    end loop;
    
    b <= high_bit_extended & imm when use_imm else reg_data;
  end process mux_and_extend;
END ARCHITECTURE behav;

