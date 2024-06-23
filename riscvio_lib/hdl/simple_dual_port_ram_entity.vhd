--
-- VHDL Entity rv64i_lib.simple_dual_port_ram.arch_name
--
-- Created:
--          by - ckoehler.wima (pc115)
--          at - 11:27:28 04/05/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY simple_dual_port_ram IS
  generic (
    ADDR_WIDTH: positive;
    DATA_WIDTH: positive
  );
  port (
    clk: in std_logic;
    raddr: in  std_logic_vector(ADDR_WIDTH - 1 downto 0);
    waddr: in  std_logic_vector(ADDR_WIDTH - 1 downto 0);
    wdata: in  std_logic_vector(DATA_WIDTH - 1 downto 0);
    we:    in  std_logic;
    rdata: out std_logic_vector(DATA_WIDTH - 1 downto 0)
  );
END ENTITY simple_dual_port_ram;

