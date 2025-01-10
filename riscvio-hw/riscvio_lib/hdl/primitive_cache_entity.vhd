--
-- VHDL Entity riscvio_lib.primitive_cache.arch_name
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 16:09:09 22.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;

ENTITY primitive_cache IS
    GENERIC(
        BUS_WIDTH: positive;
        WORDS_IN_LINE: positive;
        LINES: positive;
        ADDR_WIDTH: positive;
        DATA_WIDTH: positive;
        LEVERAGE_BURSTS: boolean := false
    );
    PORT(
        clk, res_n      : IN std_logic;
        addr            : IN std_logic_vector(ADDR_WIDTH - 1 downto 0);
        next_addr       : IN std_logic_vector(ADDR_WIDTH - 1 downto 0);
        byte_ena        : IN std_logic_vector(DATA_WIDTH/8 - 1 downto 0) := (others => '1');
        we              : IN boolean := false;
        rd              : IN boolean := true;
        invalidate      : IN boolean := false;
        invalidation_active    : OUT boolean;


        sd              : IN std_logic_vector(DATA_WIDTH - 1 downto 0) := (others => '0');
        ld              : OUT std_logic_vector(DATA_WIDTH - 1 downto 0);
        stall           : OUT boolean;
        
        
        rreq            : OUT boolean;
        rack            : IN boolean;
        raddr           : OUT std_logic_vector(ADDR_WIDTH - 1 downto 0);
        rdata           : IN std_logic_vector(BUS_WIDTH - 1 downto 0);


        wreq            : OUT boolean;
        wack            : IN boolean := false;
        waddr           : OUT std_logic_vector(ADDR_WIDTH - 1 downto 0);
        wdata           : OUT std_logic_vector(BUS_WIDTH - 1 downto 0);
        wbyte_ena       : OUT std_logic_vector(BUS_WIDTH/8 - 1 downto 0)
    );
END ENTITY primitive_cache;

