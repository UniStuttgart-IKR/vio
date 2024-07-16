LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY cyclonev_lib;
USE cyclonev_lib.soc.all;

LIBRARY peripherals;
LIBRARY riscvio_lib;

ARCHITECTURE struct OF riscvio_soc_tb IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL clk              : std_logic;
   SIGNAL ebreak_button    : std_logic;
   SIGNAL leds             : std_logic_vector(7 DOWNTO 0);
   SIGNAL res_n            : std_logic;
   SIGNAL seven_seg_0      : std_logic_vector(6 DOWNTO 0);
   SIGNAL seven_seg_1      : std_logic_vector(6 DOWNTO 0);
   SIGNAL seven_seg_2      : std_logic_vector(6 DOWNTO 0);
   SIGNAL seven_seg_3      : std_logic_vector(6 DOWNTO 0);
   SIGNAL uart_bits_in     : std_logic;
   SIGNAL uart_bits_out    : std_logic;
   SIGNAL uart_sim_in      : std_logic_vector(7 DOWNTO 0);
   SIGNAL uart_sim_in_ack  : std_logic;
   SIGNAL uart_sim_in_done : std_logic;
   SIGNAL uart_sim_in_stb  : std_logic;
   SIGNAL uart_sim_out     : std_logic_vector(7 DOWNTO 0);
   SIGNAL uart_sim_out_stb : std_logic;


   -- Component Declarations
   COMPONENT riscvio_soc
   PORT (
      clk_raw       : IN     std_logic ;
      ebreak_button : IN     std_logic ;
      res_n_raw     : IN     std_logic ;
      rx            : IN     std_logic ;
      leds          : OUT    std_logic_vector (7 DOWNTO 0);
      seven_seg_0   : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_1   : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_2   : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_3   : OUT    std_logic_vector (6 DOWNTO 0);
      tx            : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT uart_mini_sim
   PORT (
      uart_sim_in_ack  : IN     std_logic ;
      uart_sim_in_done : IN     std_logic ;
      uart_sim_out     : IN     std_logic_vector (7 DOWNTO 0);
      uart_sim_out_stb : IN     std_logic ;
      uart_sim_in      : OUT    std_logic_vector (7 DOWNTO 0);
      uart_sim_in_stb  : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT uart
   GENERIC (
      baud            : positive;
      clock_frequency : positive
   );
   PORT (
      clock               : IN     std_logic;
      data_stream_in      : IN     std_logic_vector (7 DOWNTO 0);
      data_stream_in_stb  : IN     std_logic;
      res_n               : IN     std_logic;
      rx                  : IN     std_logic;
      data_stream_in_ack  : OUT    std_logic;
      data_stream_in_done : OUT    std_logic;
      data_stream_out     : OUT    std_logic_vector (7 DOWNTO 0);
      data_stream_out_stb : OUT    std_logic;
      tx                  : OUT    std_logic
   );
   END COMPONENT;
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

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : clk_res_gen_var USE ENTITY riscvio_lib.clk_res_gen_var;
   FOR ALL : riscvio_soc USE ENTITY cyclonev_lib.riscvio_soc;
   FOR ALL : uart USE ENTITY peripherals.uart;
   FOR ALL : uart_mini_sim USE ENTITY cyclonev_lib.uart_mini_sim;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   soc_i : riscvio_soc
      PORT MAP (
         clk_raw       => clk,
         ebreak_button => ebreak_button,
         res_n_raw     => res_n,
         rx            => uart_bits_in,
         leds          => leds,
         seven_seg_0   => seven_seg_0,
         seven_seg_1   => seven_seg_1,
         seven_seg_2   => seven_seg_2,
         seven_seg_3   => seven_seg_3,
         tx            => uart_bits_out
      );
   iuart_mini_sim : uart_mini_sim
      PORT MAP (
         uart_sim_in_ack  => uart_sim_in_ack,
         uart_sim_in_done => uart_sim_in_done,
         uart_sim_out     => uart_sim_out,
         uart_sim_out_stb => uart_sim_out_stb,
         uart_sim_in      => uart_sim_in,
         uart_sim_in_stb  => uart_sim_in_stb
      );
   simulation_uart : uart
      GENERIC MAP (
         baud            => UART_BAUD_SIM,
         clock_frequency => SYSCLK
      )
      PORT MAP (
         clock               => clk,
         res_n               => res_n,
         data_stream_in      => uart_sim_in,
         data_stream_in_stb  => uart_sim_in_stb,
         data_stream_in_ack  => uart_sim_in_ack,
         data_stream_in_done => uart_sim_in_done,
         data_stream_out     => uart_sim_out,
         data_stream_out_stb => uart_sim_out_stb,
         tx                  => uart_bits_in,
         rx                  => uart_bits_out
      );
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

END struct;
