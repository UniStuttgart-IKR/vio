--
-- VHDL Architecture riscvio_lib.pc2nib.behav
--
-- Created:
--          by - leylknci.meyer (pc024)
--          at - 13:59:54 07/10/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF pc2nib IS
BEGIN

    nib0 <= pc_if.ix(3 downto 0);
    nib1 <= pc_if.ix(7 downto 4);
    nib2 <= pc_if.ix(11 downto 8);
    nib3 <= pc_if.ix(15 downto 12);

END ARCHITECTURE behav;

