--
-- VHDL Architecture riscvio_lib.ac_wrapper.mixed
--
-- Created:
--          by - leylknci.meyer (pc024)
--          at - 14:24:53 06/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--

LIBRARY riscvio_lib;
USE riscvio_lib.primitive_cache;
USE riscvio_lib.caches.all;
LIBRARY ieee;
USE ieee.numeric_std.all;


ARCHITECTURE mixed OF ac_wrapper IS
BEGIN
    acache: entity primitive_cache
        generic map (
            BUS_WIDTH => BUS_WIDTH,
            WORDS_IN_LINE => AC_LINE_WIDTH,
            LINES => AC_LINES,
            ADDR_WIDTH => 32,
            DATA_WIDTH => 64
        )
        port map (
            clk       => clk,
            res_n     => res_n,
            stall     => stall,
            addr      => addr,
            next_addr => next_addr,
            rd        => rena = '1',

            ld        => ld,

            rreq      => rreq,
            rack      => rack,
            raddr     => raddr,
            rdata     => rdata(31 downto 0) & rdata(63 downto 32)
        );
END ARCHITECTURE mixed;

