--
-- VHDL Architecture rv64i_lib.simple_dual_port_ram.behav
--
-- Created:
--          by - ckoehler.wima (pc115)
--          at - 11:27:45 04/05/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF simple_dual_port_ram IS
  type ram_type is array (0 to 2** ADDR_WIDTH - 1) of std_logic_vector(DATA_WIDTH - 1 downto 0);
  signal ram: ram_type := (others => (others => '0'));
  
  attribute rw_addr_collision: string;
  attribute rw_addr_collision of ram: signal is "yes";
  
  signal raddr_reg: std_logic_vector(ADDR_WIDTH - 1 downto 0); 
BEGIN
  ram_read: rdata <= ram(to_integer(unsigned(raddr_reg)));
  
  ram_write_p: process (clk) is
  begin
    if clk'event and clk = '1' then
      if we = '1' then
        ram(to_integer(unsigned(waddr))) <= wdata;  
      end if;
      raddr_reg <= raddr;
    end if;  
  end process ram_write_p;
END ARCHITECTURE behav;

