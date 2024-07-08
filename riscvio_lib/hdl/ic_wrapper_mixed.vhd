--
-- VHDL Architecture riscvio_lib.ic_wrapper.mixed
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 11:41:26 23.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--

LIBRARY riscvio_lib;
USE riscvio_lib.primitive_cache;
USE riscvio_lib.pipeline.all;
LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE mixed OF ic_wrapper IS
    signal sub_wire0: std_logic_vector(31 downto 0);
    signal instr_addr: std_logic_vector(31 downto 0);
    signal next_instr_addr: std_logic_vector(31 downto 0);
    signal rd_instr: boolean;
    signal instr_int: word_T;
BEGIN
    instr_addr <= std_logic_vector(unsigned(pc.ix) + unsigned(pc.ptr) + to_unsigned(8, instr_addr'length)); 
    next_instr_addr <= std_logic_vector(unsigned(next_pc.ix) + unsigned(next_pc.ptr) + to_unsigned(8, instr_addr'length)); 
    rd_instr <= not(sbranch or dbranch or pipe_flush); --todo: fix core delta and unsigned(pc.ix) <= unsigned(pc.dt);
    instr <= instr_int(BYTE0_RANGE) & instr_int(BYTE1_RANGE) & instr_int(BYTE2_RANGE) & instr_int(BYTE3_RANGE);


    icache: entity primitive_cache
        generic map (
            BUS_WIDTH => BUS_WIDTH,
            WORDS_IN_LINE => IC_LINE_WIDTH,
            LINES => IC_LINES,
            ADDR_WIDTH => 32,
            DATA_WIDTH => 32
        )
        port map (
            clk       => clk,
            res_n     => res_n,
            stall     => stall,
            addr      => instr_addr,
            next_addr => next_instr_addr,
            rd        => rd_instr,

            ld        => instr_int,

            rreq      => ic_rreq,
            rack      => ic_rack,
            raddr     => ic_raddr,
            rdata     => ic_rdata
        );

END ARCHITECTURE mixed;

