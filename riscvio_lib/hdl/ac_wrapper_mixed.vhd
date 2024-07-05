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
USE riscvio_lib.pipeline.all;
LIBRARY ieee;
USE ieee.numeric_std.all;


ARCHITECTURE mixed OF ac_wrapper IS
    signal ld: std_logic_vector(63 downto 0);
    signal stall_int: boolean;
    signal rena: boolean;
BEGIN
    lpi <= ld(7 downto 0) & ld(15 downto 8) & ld(23 downto 16) & ld(31 downto 24) when at_mode = load_maybe else (others => '0');
    ldt <= ld(39 downto 32) & ld(47 downto 40) & ld(55 downto 48) & ld(63 downto 56) when at_mode = load_maybe or at_mode = load_delta_only else (others => '0');
    rena <= at_mode = load_maybe or at_mode = load_delta_only;
    --#TODO: hellooo
    acache: entity riscvio_lib.primitive_cache
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
            stall     => stall_int,
            addr      => addr.val,
            next_addr => next_addr.val,
            rd        => rena,

            ld        => ld,

            rreq      => rreq,
            rack      => rack,
            raddr     => raddr,
            rdata     => rdata
        );

    stall <= '1' when stall_int else 'Z';
END ARCHITECTURE mixed;

