--
-- VHDL Architecture rv64i_lib.int_ram.mixed
--
-- Created:
--          by - ckoehler.wima (pc115)
--          at - 10:42:56 04/13/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;

ENTITY int_ram is
  PORT(
    clk, res_n       : IN std_logic;

    dc_rreq            : IN boolean := false;
    dc_rack            : OUT boolean;
    dc_raddr           : IN std_logic_vector(ADDR_WIDTH - 1 downto 0) := (others => '0');
    dc_rdata           : OUT std_logic_vector(BUS_WIDTH - 1 downto 0);

    ac_rreq            : IN boolean := false;
    ac_rack            : OUT boolean;
    ac_raddr           : IN std_logic_vector(ADDR_WIDTH - 1 downto 0) := (others => '0');
    ac_rdata           : OUT std_logic_vector(BUS_WIDTH - 1 downto 0);

    ic_rreq            : IN boolean := false;
    ic_rack            : OUT boolean;
    ic_raddr           : IN std_logic_vector(ADDR_WIDTH - 1 downto 0) := (others => '0');
    ic_rdata           : OUT std_logic_vector(BUS_WIDTH - 1 downto 0);


    dc_wreq            : IN boolean := false;
    dc_wack            : OUT boolean;
    dc_waddr           : IN std_logic_vector(ADDR_WIDTH - 1 downto 0) := (others => '0');
    dc_wdata           : IN std_logic_vector(BUS_WIDTH - 1 downto 0) := (others => '0');
    dc_wbyte_ena       : IN std_logic_vector(BUS_WIDTH/8 - 1 downto 0);

    ac_wreq            : IN boolean := false;
    ac_wack            : OUT boolean;
    ac_waddr           : IN std_logic_vector(ADDR_WIDTH - 1 downto 0) := (others => '0');
    ac_wdata           : IN std_logic_vector(BUS_WIDTH - 1 downto 0) := (others => '0');
    ac_wbyte_ena       : IN std_logic_vector(BUS_WIDTH/8 - 1 downto 0)
  );
END ENTITY int_ram;