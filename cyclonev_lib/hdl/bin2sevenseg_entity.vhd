--
-- VHDL Architecture riscvio_lib.bin2sevenseg.behav
--
-- Created:
--          by - leylknci.meyer (pc024)
--          at - 13:50:03 07/10/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY nib2sevenseg IS
    PORT(
        nib: in std_logic_vector(3 downto 0);
        seven: out std_logic_vector(6 downto 0)
    );
END ENTITY nib2sevenseg;