--
-- VHDL Architecture riscvio_lib.rom_wrapper.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc037)
--          at - 16:39:25 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee;
use ieee.numeric_std.all;


ARCHITECTURE behav OF rom_wrapper IS
BEGIN
    rom_model: process(pc) IS
        type rom_T is array(0 to 63) of wordT;
        constant rom: rom_T := (others => (others => '0'));
    BEGIN
        assert to_integer(unsigned(pc)) < romT'length / 4 report "pc out of range!" severity failure;
        
        instr <= rom(to_integer(unsigned(pc / 4)));
        ic_stall <= '0';
    end process rom_model;
END ARCHITECTURE behav;

