--
-- VHDL Package Header riscvio_lib.isa
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 16:28:31 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
PACKAGE isa IS
    constant WORD_SIZE: natural := 64;
    constant INSTRUCTION_SIZE: positive := 4;

    subtype wordT is std_logic_vector(WORD_SIZE - 1 downto 0);
END isa;
