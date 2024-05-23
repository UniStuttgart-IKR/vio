--
-- VHDL Architecture riscvio_lib.pc_incrementer.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 16:04:11 01.05.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF pc_incrementer IS
BEGIN
  next_pc.ix <= std_logic_vector(to_unsigned(to_integer(unsigned(pc.ix)) + 4, next_pc.ix'length)); 
  next_pc.ptr <= pc.ptr;
  next_pc.pi <= pc.pi;
  next_pc.dt <= pc.dt;

END ARCHITECTURE behav;

