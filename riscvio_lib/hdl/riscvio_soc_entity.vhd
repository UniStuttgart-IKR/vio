LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY riscvio_soc IS
   PORT( 
      clk_raw       : IN     std_logic;
      ebreak_button : IN     std_logic;
      res_n_raw     : IN     std_logic;
      rx            : IN     std_logic;
      leds          : OUT    std_logic_vector (7 DOWNTO 0);
      seven_seg_0   : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_1   : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_2   : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_3   : OUT    std_logic_vector (6 DOWNTO 0);
      tx            : OUT    std_logic
   );

-- Declarations

END riscvio_soc ;
