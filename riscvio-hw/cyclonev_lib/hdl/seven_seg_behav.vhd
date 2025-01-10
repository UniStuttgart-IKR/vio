--
-- VHDL Architecture cyclonev_lib.seven_seg.behav
--
-- Created:
--          by - leylknci.meyer (pc024)
--          at - 16:33:12 07/11/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF seven_seg IS
    signal nib0_int, nib1_int, nib2_int, nib3_int : std_logic_vector(3 downto 0);
BEGIN
    sev0: entity cyclonev_lib.nib2sevenseg 
      port map (
        nib => nib0_int,
        seven => seven_seg_0
      );
    sev1: entity cyclonev_lib.nib2sevenseg 
      port map (
        nib => nib1_int,
        seven => seven_seg_1
      );
    sev2: entity cyclonev_lib.nib2sevenseg 
      port map (
        nib => nib2_int,
        seven => seven_seg_2
      );
    sev3: entity cyclonev_lib.nib2sevenseg 
      port map (
        nib => nib3_int,
        seven => seven_seg_3
      );

    nib0_int <= pc.ix(3 downto 0) when ebreak else nib0;
    nib1_int <= pc.ix(7 downto 4) when ebreak else nib1;
    nib2_int <= pc.ix(11 downto 8) when ebreak else nib2;
    nib3_int <= pc.ix(15 downto 12) when ebreak else nib3;
END ARCHITECTURE behav;

