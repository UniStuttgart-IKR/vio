LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY riscvio_lib;

ARCHITECTURE struct OF riscvio_soc_tb IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL clk         : std_logic;
   SIGNAL leds        : std_logic_vector(7 DOWNTO 0);
   SIGNAL res_n       : std_logic;
   SIGNAL rx          : std_logic;
   SIGNAL seven_seg_0 : std_logic_vector(7 DOWNTO 0);
   SIGNAL seven_seg_1 : std_logic_vector(7 DOWNTO 0);
   SIGNAL seven_seg_2 : std_logic_vector(7 DOWNTO 0);
   SIGNAL seven_seg_3 : std_logic_vector(7 DOWNTO 0);
   SIGNAL tx          : std_logic;


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
   COMPONENT riscvio_soc
   PORT (
      clk         : IN     std_logic ;
      res_n_raw   : IN     std_logic ;
      rx          : IN     std_logic ;
      leds        : OUT    std_logic_vector (7 DOWNTO 0);
      seven_seg_0 : OUT    std_logic_vector (7 DOWNTO 0);
      seven_seg_1 : OUT    std_logic_vector (7 DOWNTO 0);
      seven_seg_2 : OUT    std_logic_vector (7 DOWNTO 0);
      seven_seg_3 : OUT    std_logic_vector (7 DOWNTO 0);
      tx          : OUT    std_logic 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : clk_res_gen_var USE ENTITY riscvio_lib.clk_res_gen_var;
   FOR ALL : riscvio_soc USE ENTITY riscvio_lib.riscvio_soc;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 eb1
   -- eb1 1        
   rx <= '1';                               


   -- Instance port mappings.
   U_1 : clk_res_gen_var
      GENERIC MAP (
         ONTIME    => 10 ns,
         OFFTIME   => 10 ns,
         RESETTIME => 35 ns
      )
      PORT MAP (
         clk   => clk,
         res_n => res_n
      );
   soc_i : riscvio_soc
      PORT MAP (
         clk         => clk,
         res_n_raw   => res_n,
         rx          => rx,
         leds        => leds,
         seven_seg_0 => seven_seg_0,
         seven_seg_1 => seven_seg_1,
         seven_seg_2 => seven_seg_2,
         seven_seg_3 => seven_seg_3,
         tx          => tx
      );

END struct;
