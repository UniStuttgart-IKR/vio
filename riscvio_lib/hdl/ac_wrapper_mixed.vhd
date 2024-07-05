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
USE riscvio_lib.helper.revBytes;

LIBRARY ieee;
USE ieee.numeric_std.all;


ARCHITECTURE mixed OF ac_wrapper IS
    signal ld: std_logic_vector(63 downto 0);
    signal sd: std_logic_vector(63 downto 0);
    signal stall_int: boolean;
    signal rena: boolean;
    signal wena: boolean;
BEGIN
    lpi <= revBytes(ld(31 downto 0)) when at_mode = load_maybe else (others => '0');
    ldt <= revBytes(ld(63 downto 32) srl 32) when at_mode = load_maybe or at_mode = load_delta_only else (others => '0');
    sd <=  revBytes(wdt) & revBytes(wpi);

    rena <= at_mode = load_maybe or at_mode = load_delta_only;
    wena <= at_mode = store;

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
            we        => wena,

            ld        => ld,
            sd        => sd,

            rreq      => rreq,
            rack      => rack,
            raddr     => raddr,
            rdata     => rdata,

            wreq      => wreq,
            wack      => wack,
            waddr     => waddr,
            wdata     => wdata,
            wbyte_ena => wbyte_ena
        );

    stall <= '1' when stall_int else 'Z';
END ARCHITECTURE mixed;

