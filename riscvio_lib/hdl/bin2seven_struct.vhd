LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;


ARCHITECTURE struct OF bin2seven IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL nib0 : std_logic_vector(3 DOWNTO 0);
   SIGNAL nib1 : std_logic_vector(3 DOWNTO 0);
   SIGNAL nib2 : std_logic_vector(3 DOWNTO 0);
   SIGNAL nib3 : std_logic_vector(3 DOWNTO 0);


   -- Component Declarations
   COMPONENT nib2sevenseg
   PORT (
      nib   : IN     std_logic_vector (3 DOWNTO 0);
      seven : OUT    std_logic_vector (6 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT pc2nib
   PORT (
      pc_if : IN     pc_T ;
      nib0  : OUT    std_logic_vector (3 DOWNTO 0);
      nib1  : OUT    std_logic_vector (3 DOWNTO 0);
      nib2  : OUT    std_logic_vector (3 DOWNTO 0);
      nib3  : OUT    std_logic_vector (3 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : nib2sevenseg USE ENTITY riscvio_lib.nib2sevenseg;
   FOR ALL : pc2nib USE ENTITY riscvio_lib.pc2nib;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   U_0 : nib2sevenseg
      PORT MAP (
         nib   => nib0,
         seven => seven_seg_0
      );
   U_1 : nib2sevenseg
      PORT MAP (
         nib   => nib1,
         seven => seven_seg_1
      );
   U_2 : nib2sevenseg
      PORT MAP (
         nib   => nib2,
         seven => seven_seg_2
      );
   U_3 : nib2sevenseg
      PORT MAP (
         nib   => nib3,
         seven => seven_seg_3
      );
   U_4 : pc2nib
      PORT MAP (
         pc_if => pc_if,
         nib0  => nib0,
         nib1  => nib1,
         nib2  => nib2,
         nib3  => nib3
      );

END struct;
