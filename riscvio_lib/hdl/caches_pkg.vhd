--
-- VHDL Package Header riscvio_lib.caches
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 10:04:36 23.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;


PACKAGE caches IS
    constant BUS_WIDTH: natural := 64;

    constant IC_LINES:      natural := 4;
    constant IC_LINE_WIDTH: natural := 32;
    constant ADDR_WIDTH:    natural := 32;

    type cache_rrq_T is record
        rreq           : boolean;
        rack           : boolean;
        raddr          : std_logic_vector(ADDR_WIDTH - 1 downto 0);
        rdata          : std_logic_vector(BUS_WIDTH - 1 downto 0);
    end record cache_rrq_T;

    type cache_wrq_T is record
        wreq           : boolean;
        wack           : boolean;
        waddr          : std_logic_vector(ADDR_WIDTH - 1 downto 0);
        wdata          : std_logic_vector(BUS_WIDTH - 1 downto 0);     
    end record cache_wrq_T;

END caches;
