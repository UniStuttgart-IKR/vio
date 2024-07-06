--
-- VHDL Architecture riscvio_lib.dc_wrapper.mixed
--
-- Created:
--          by - leylknci.meyer (pc024)
--          at - 14:23:46 06/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
LIBRARY ieee;
USE ieee.numeric_std.all;
use ieee.math_real.all;


ARCHITECTURE mixed OF dc_wrapper IS
    signal caddr: word_T;
    signal cnext_addr: word_T;
    signal sd: buzz_word_T;
    signal sd_pipeline: buzz_word_T;
    signal ld_cache: buzz_word_T;
    signal wena: boolean;
    signal rena: boolean;
    signal bena_pipeline: std_logic_vector(BUS_WIDTH/8-1 downto 0);
    signal bena: std_logic_vector(BUS_WIDTH/8-1 downto 0);
    signal dc_stall: boolean;
    constant TOP: natural := integer(ceil(log2(real(BUS_WIDTH/8))))-1;
BEGIN
  dcache: entity riscvio_lib.primitive_cache
    generic map (
        BUS_WIDTH => BUS_WIDTH,
        WORDS_IN_LINE => DC_LINE_WIDTH,
        LINES => DC_LINES,
        ADDR_WIDTH => 32,
        DATA_WIDTH => BUS_WIDTH,
        LEVERAGE_BURSTS => true
    )
    port map (
        clk       => clk,
        res_n     => res_n,
        stall     => dc_stall,
        addr      => caddr,
        next_addr => cnext_addr,
        rd        => rena and not addr.io_access,
        we        => (wena or obj_init_wr) and not addr.io_access,
        byte_ena  => bena,
        ld        => ld_cache,
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

    stall_bool <= dc_stall;
    stall <= '1' when dc_stall else 'Z';
    sd <= obj_init_data when obj_init_wr else sd_pipeline;
    caddr <= obj_init_addr when obj_init_wr else addr.addr;
    cnext_addr <= next_obj_init_addr when obj_init_wr else next_addr.addr;
    bena <= obj_init_byte_ena when obj_init_wr else bena_pipeline;

    rw_p: process (all) is
        variable IX: natural range BUS_WIDTH/8-1 downto 0;
        variable WIX: natural range BUS_WIDTH/word_T'length-1 downto 0;
        variable BIX: natural range 3 downto 0;
    begin  
        ld            <= (others => '0');
        sd_pipeline   <= (others => '0');
        bena_pipeline <= (others => '0');
        rena <= mode = lb or mode = lbu or mode = lh or mode = lhu or mode = lw or mode = lp or mode = load_rpc;
        wena <= mode = sb or mode = sh or mode = sw or mode = sp or mode = store_rpc;
        
        case mode is
        when lbu =>
            IX := to_integer(unsigned(addr.addr(TOP downto 0)));
            ld(BYTE0_RANGE) <= ld_cache(IX*8+7 downto IX*8);
        when lb =>
            IX := to_integer(unsigned(addr.addr(TOP downto 0)));
            ld <= (others => ld_cache(IX*8+7));
            ld(BYTE0_RANGE) <= ld_cache(IX*8+7 downto IX*8);
        when sb =>
            IX := to_integer(unsigned(addr.addr(TOP downto 0)));
            sd_pipeline((IX+1)*8-1 downto IX*8) <= sd_raux.val(BYTE0_RANGE);
            bena_pipeline(IX) <= '1';
        when lhu =>
            IX := to_integer(unsigned(addr.addr(TOP downto 1)&'0'));
            ld(HWORD0_RANGE) <= ld_cache(IX*8+7 downto IX*8) & ld_cache(IX*8+15 downto IX*8+8);
        when lh =>
            IX := to_integer(unsigned(addr.addr(TOP downto 1)&'0'));
            ld <= (others => ld_cache(IX*8+7));
            ld(HWORD0_RANGE) <= ld_cache(IX*8+7 downto IX*8) & ld_cache(IX*8+15 downto IX*8+8);
        when sh =>
            IX := to_integer(unsigned(addr.addr(TOP downto 1)&'0'));
            sd_pipeline((IX+2)*8-1 downto IX*8) <= sd_raux.val(BYTE0_RANGE) & sd_raux.val(BYTE1_RANGE);
            bena_pipeline(IX+1 downto IX) <= (others => '1');
        when lw | lp =>
            IX := to_integer(unsigned(addr.addr(TOP downto 2)&"00"));
            ld(WORD0_RANGE) <= ld_cache(IX*8+7 downto IX*8) & ld_cache(IX*8+15 downto IX*8+8) & ld_cache(IX*8+23 downto IX*8+16) & ld_cache(IX*8+31 downto IX*8+24);
        when sw | sp =>
            IX := to_integer(unsigned(addr.addr(TOP downto 2)&"00"));
            sd_pipeline((IX+4)*8-1 downto IX*8) <= sd_raux.val(BYTE0_RANGE) & sd_raux.val(BYTE1_RANGE) & sd_raux.val(BYTE2_RANGE) & sd_raux.val(BYTE3_RANGE);
            bena_pipeline(IX+3 downto IX) <= (others => '1');
        when load_rpc =>
            IX := to_integer(unsigned(addr.addr(TOP downto 3)&"000"));
            ld(63 downto 0) <= ld_cache(IX*8+7 downto IX*8)     & ld_cache(IX*8+15 downto IX*8+8)  & ld_cache(IX*8+23 downto IX*8+16) & ld_cache(IX*8+31 downto IX*8+24)
                             & ld_cache(IX*8+39 downto IX*8+32) & ld_cache(IX*8+47 downto IX*8+40) & ld_cache(IX*8+55 downto IX*8+48) & ld_cache(IX*8+63 downto IX*8+56);
        when store_rpc =>
            IX := to_integer(unsigned(addr.addr(TOP downto 3)&"000"));
            sd_pipeline((IX+8)*8-1 downto IX*8) <= sd_raux.val(BYTE0_RANGE) & sd_raux.val(BYTE1_RANGE) & sd_raux.val(BYTE2_RANGE) & sd_raux.val(BYTE3_RANGE)
                                                 & sd_raux.ix(BYTE0_RANGE)  & sd_raux.ix(BYTE1_RANGE)  & sd_raux.ix(BYTE2_RANGE)  & sd_raux.ix(BYTE3_RANGE);
            bena_pipeline(IX+8-1 downto IX) <= (others => '1');
        when others =>
            IX  := 0;
        end case;
    end process rw_p;

END ARCHITECTURE mixed;

