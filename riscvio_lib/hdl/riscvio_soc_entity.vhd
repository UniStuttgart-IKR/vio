LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY riscvio_soc IS
   PORT( 
      clk   : IN     std_logic;
      res_n : IN     std_logic;
      rx    : IN     std_logic;
      tx    : OUT    std_logic
   );

-- Declarations

END riscvio_soc ;
