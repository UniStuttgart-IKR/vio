LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY uart_loop IS
   PORT( 
      clk   : IN     std_logic;
      res_n : IN     std_logic;
      tx    : IN     std_logic;
      rx    : OUT    std_logic
   );

-- Declarations

END uart_loop ;
