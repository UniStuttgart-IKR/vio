--
-- VHDL Architecture riscvio_lib.riscvio_tb.struct
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY riscvio_lib;

ARCHITECTURE struct OF riscvio_tb IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL clk   : std_logic;
   SIGNAL res_n : std_logic;


   -- Component Declarations
   COMPONENT clk_res_gen_var
   GENERIC (
      ONTIME    : time := 10 ns;
      OFFTIME   : time := 10 ns;
      RESETTIME : time := 35 ns
   );
   PORT (
      clk   : OUT    std_logic;
      res_n : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT riscvio
   PORT (
      clk   : IN     std_logic ;
      res_n : IN     std_logic 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : clk_res_gen_var USE ENTITY riscvio_lib.clk_res_gen_var;
   FOR ALL : riscvio USE ENTITY riscvio_lib.riscvio;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   clk_i : clk_res_gen_var
      GENERIC MAP (
         ONTIME    => 10 ns,
         OFFTIME   => 10 ns,
         RESETTIME => 35 ns
      )
      PORT MAP (
         clk   => clk,
         res_n => res_n
      );
   riscvio_i : riscvio
      PORT MAP (
         clk   => clk,
         res_n => res_n
      );

END struct;
