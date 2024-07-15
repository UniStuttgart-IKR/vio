--
-- VHDL Architecture riscvio_lib.bin2sevenseg.behav
--
-- Created:
--          by - leylknci.meyer (pc024)
--          at - 13:50:03 07/10/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF nib2sevenseg IS
BEGIN

process(nib)
begin
 
    case nib is
        when "0000" =>
        seven <= "0000001"; ---0
        when "0001" =>
        seven <= "1111001"; ---1
        when "0010" =>
        seven <= "0100100"; ---2
        when "0011" =>
        seven <= "0110000"; ---3
        when "0100" =>
        seven <= "0011001"; ---4
        when "0101" =>
        seven <= "0010010"; ---5
        when "0110" =>
        seven <= "0000010"; ---6
        when "0111" =>
        seven <= "1111000"; ---7
        when "1000" =>
        seven <= "0000000"; ---8
        when "1001" =>
        seven <= "0001000"; ---9
        when "1010" =>
        seven <= "0000100"; ---A
        when "1011" =>
        seven <= "1111100"; ---B
        when "1100" =>
        seven <= "1000110"; ---C
        when "1101" =>
        seven <= "0100001"; ---D
        when "1110" =>
        seven <= "0000110"; ---E
        when "1111" =>
        seven <= "0001110"; ---F
        when others =>
        seven <= "1111111"; ---null
    end case;
 
end process;
END ARCHITECTURE behav;

