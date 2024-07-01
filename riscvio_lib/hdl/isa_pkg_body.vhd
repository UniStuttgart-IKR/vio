--
-- VHDL Package Body riscvio_lib.isa
--
-- Created:
--          by - leylknci.meyer (pc038)
--          at - 19:13:32 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
PACKAGE BODY isa IS

    pure function extractJTypeImm(inst: word_T) return word_T is
        variable res: word_T;
    begin
        res := (0 => '0', others => inst(31));
        res(19 downto 12) := inst(19 downto 12);
        res(11) := inst(20);
        res(10 downto 1) := inst(30 downto 21);
        return res;
    end function extractJTypeImm;


    pure function extractBTypeImm(inst: word_T) return word_T is
        variable res: word_T;
    begin
        res := (0 => '0', others => inst(31));
        res(10 downto 5) := inst(30 downto 25);
        res(11) := inst(7);
        res(4 downto 1) := inst(11 downto 8);
        return res;
    end function extractBTypeImm;

    pure function extractSTypeImm(inst: word_T) return word_T is
        variable res: word_T;
    begin
        res := (others => inst(31));
        res(11 downto 5) := inst(31 downto 25);
        res(4 downto 0) := inst(11 downto 7);
        return res;
    end function extractSTypeImm;

END isa;
