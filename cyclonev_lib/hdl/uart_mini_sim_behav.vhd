--
-- VHDL Architecture cyclonev_lib.uart_mini_sim.behav
--
-- Created:
--          by - leylknci.meyer (pc024)
--          at - 11:42:18 07/16/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF uart_mini_sim IS
    constant test_string : string := "4";
BEGIN

process is
begin

    wait until uart_sim_out = X"3A" and uart_sim_out_stb = '1';

    for i in 1 to test_string'high loop
		uart_sim_in <= std_logic_vector(to_unsigned(character'pos(test_string(i)), 8));
        uart_sim_in_stb <= '1';
        wait until uart_sim_in_ack = '1';
        uart_sim_in_stb <= '0';
        wait until uart_sim_in_done = '1';
	end loop ;
    uart_sim_in <= X"0D";
    uart_sim_in_stb <= '1';
    wait until uart_sim_in_ack = '1';
    uart_sim_in_stb <= '0';
    wait until uart_sim_in_done = '1';
    wait;

end process;

END ARCHITECTURE behav;

