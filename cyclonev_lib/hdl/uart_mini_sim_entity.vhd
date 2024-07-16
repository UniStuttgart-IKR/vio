LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY cyclonev_lib;
USE cyclonev_lib.soc.all;

ENTITY uart_mini_sim IS
   PORT( 
      uart_sim_in_ack  : IN     std_logic;
      uart_sim_in_done : IN     std_logic;
      uart_sim_out     : IN     std_logic_vector (7 DOWNTO 0);
      uart_sim_out_stb : IN     std_logic;
      uart_sim_in      : OUT    std_logic_vector (7 DOWNTO 0);
      uart_sim_in_stb  : OUT    std_logic
   );

-- Declarations

END uart_mini_sim ;
