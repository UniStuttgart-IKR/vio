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
    signal ld: std_logic_vector(63 downto 0);
BEGIN
    pi <= ld(31 downto 0) when ld_attr else (others => '0');
    dt <= ld(63 downto 32) when ld_attr else (others => '0');
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
            addr      => addr.data,
            next_addr => next_addr.data,
            rd        => ld_attr,

            ld        => ld,

            rreq      => rreq,
            rack      => rack,
            raddr     => raddr,
            rdata     => rdata
        );
END ARCHITECTURE mixed;

