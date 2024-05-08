--
-- VHDL Architecture riscvio_lib.decoder_tester.behav
--
-- Created:
--          by - leylknci.meyer (pc038)
--          at - 18:45:16 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF decoder_tester IS
BEGIN
    
    process is
    begin
        instruction <= X"00000000";
        wait on res_n until res_n = '1';
        wait on clk until clk = '1';
        instruction <= X"4d230293";
        wait on clk until clk = '1';
        instruction <= X"4d232293";
        wait;
    end process;
    

END ARCHITECTURE behav;

