--
-- VHDL Architecture cyclonev_lib.uart_loop.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 11:30:39 14.07.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
ARCHITECTURE behav OF uart_loop IS
  signal delay: std_logic_vector(99 downto 0);
BEGIN
  process(clk, res_n) is
  begin
    if res_n = '0' then
      delay <= (others => '1');
    else
      if clk'event and clk = '1' then
        rx <= delay(delay'low);
        delay <= tx & delay(delay'high downto delay'low + 1);
      end if;
    end if;
  end process;
END ARCHITECTURE behav;

