--
-- VHDL Entity riscvio_lib.dual_port_ram.arch_name
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 14:55:54 05/15/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dual_port_ram IS
    GENERIC(
        WORD_W: natural;
        ADDR_W: natural;
        SIZE_WORDS: natural;
        INIT_FILE: string
    );
    PORT(
        clk: in std_logic;

        a_we: in std_logic;
        a_addr: in std_logic_vector(ADDR_W - 1 downto 0);
        a_data: in std_logic_vector(WORD_W - 1 downto 0);
        a_q: out std_logic_vector(WORD_W - 1 downto 0);

        b_we: in std_logic;
        b_addr: in std_logic_vector(ADDR_W - 1 downto 0);
        b_data: in std_logic_vector(WORD_W - 1 downto 0);
        b_q: out std_logic_vector(WORD_W - 1 downto 0)
    );
END ENTITY dual_port_ram;

