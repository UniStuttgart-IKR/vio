LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY cyclonev_lib;
USE cyclonev_lib.soc.all;

LIBRARY peripherals;

ARCHITECTURE struct OF io IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL data_stream_in      : std_logic_vector(7 DOWNTO 0);
   SIGNAL data_stream_in_ack  : std_logic;
   SIGNAL data_stream_in_done : std_logic;
   SIGNAL data_stream_in_stb  : std_logic;
   SIGNAL data_stream_out     : std_logic_vector(7 DOWNTO 0);
   SIGNAL data_stream_out_stb : std_logic;
   SIGNAL nib0                : std_logic_vector(3 DOWNTO 0);
   SIGNAL nib1                : std_logic_vector(3 DOWNTO 0);
   SIGNAL nib2                : std_logic_vector(3 DOWNTO 0);
   SIGNAL nib3                : std_logic_vector(3 DOWNTO 0);
   SIGNAL seven_active        : boolean;
   SIGNAL seven_ix            : word_T;
   SIGNAL seven_mode          : mem_mode_T;
   SIGNAL seven_rdata         : word_T;
   SIGNAL seven_stall         : std_logic;
   SIGNAL seven_wdata         : word_T;
   SIGNAL uart_active         : boolean;
   SIGNAL uart_ix             : word_T;
   SIGNAL uart_mode           : mem_mode_T;
   SIGNAL uart_rdata          : word_T;
   SIGNAL uart_stall          : std_logic;
   SIGNAL uart_wdata          : word_T;


   -- Component Declarations
   COMPONENT io_mux
   PORT (
      io_dev       : IN     std_logic_vector (11 DOWNTO 0);
      io_dev_u     : IN     std_logic_vector (11 DOWNTO 0);
      io_ix        : IN     word_T ;
      io_ix_u      : IN     word_T ;
      io_mode      : IN     mem_mode_T ;
      io_mode_u    : IN     mem_mode_T ;
      io_wdata     : IN     word_T ;
      seven_rdata  : IN     word_T ;
      seven_stall  : IN     std_logic ;
      uart_rdata   : IN     word_T ;
      uart_stall   : IN     std_logic ;
      io_rdata     : OUT    word_T ;
      io_stall     : OUT    std_logic ;
      seven_active : OUT    boolean ;
      seven_ix     : OUT    word_T ;
      seven_mode   : OUT    mem_mode_T ;
      seven_wdata  : OUT    word_T ;
      uart_active  : OUT    boolean ;
      uart_ix      : OUT    word_T ;
      uart_mode    : OUT    mem_mode_T ;
      uart_wdata   : OUT    word_T 
   );
   END COMPONENT;
   COMPONENT key_debounce
   PORT (
      clk     : IN     std_logic ;
      key_in  : IN     std_logic ;
      res_n   : IN     std_logic ;
      key_out : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT seven_seg
   PORT (
      clk         : IN     std_logic ;
      ebreak      : IN     boolean ;
      nib0        : IN     std_logic_vector (3 DOWNTO 0);
      nib1        : IN     std_logic_vector (3 DOWNTO 0);
      nib2        : IN     std_logic_vector (3 DOWNTO 0);
      nib3        : IN     std_logic_vector (3 DOWNTO 0);
      pc          : IN     pc_T ;
      res_n       : IN     std_logic ;
      seven_seg_0 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_1 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_2 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_3 : OUT    std_logic_vector (6 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT seven_seg_interface
   PORT (
      clk          : IN     std_logic ;
      res_n        : IN     std_logic ;
      seven_active : IN     boolean ;
      seven_ix     : IN     word_T ;
      seven_mode   : IN     mem_mode_T ;
      seven_wdata  : IN     word_T ;
      nib0         : OUT    std_logic_vector (3 DOWNTO 0);
      nib1         : OUT    std_logic_vector (3 DOWNTO 0);
      nib2         : OUT    std_logic_vector (3 DOWNTO 0);
      nib3         : OUT    std_logic_vector (3 DOWNTO 0);
      seven_rdata  : OUT    word_T ;
      seven_stall  : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT uart_interface
   PORT (
      clk                 : IN     std_logic ;
      data_stream_in_ack  : IN     std_logic ;
      data_stream_in_done : IN     std_logic ;
      data_stream_out     : IN     std_logic_vector (7 DOWNTO 0);
      data_stream_out_stb : IN     std_logic ;
      res_n               : IN     std_logic ;
      uart_active         : IN     boolean ;
      uart_ix             : IN     word_T ;
      uart_mode           : IN     mem_mode_T ;
      uart_wdata          : IN     word_T ;
      data_stream_in      : OUT    std_logic_vector (7 DOWNTO 0);
      data_stream_in_stb  : OUT    std_logic ;
      uart_rdata          : OUT    word_T ;
      uart_stall          : OUT    std_logic 
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

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : io_mux USE ENTITY cyclonev_lib.io_mux;
   FOR ALL : key_debounce USE ENTITY cyclonev_lib.key_debounce;
   FOR ALL : seven_seg USE ENTITY cyclonev_lib.seven_seg;
   FOR ALL : seven_seg_interface USE ENTITY cyclonev_lib.seven_seg_interface;
   FOR ALL : uart_interface USE ENTITY cyclonev_lib.uart_interface;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   iio_mux : io_mux
      PORT MAP (
         io_dev       => io_dev,
         io_dev_u     => io_dev_u,
         io_ix        => io_ix,
         io_ix_u      => io_ix_u,
         io_mode      => io_mode,
         io_mode_u    => io_mode_u,
         io_wdata     => io_wdata,
         seven_rdata  => seven_rdata,
         seven_stall  => seven_stall,
         uart_rdata   => uart_rdata,
         uart_stall   => uart_stall,
         io_rdata     => io_rdata,
         io_stall     => io_stall,
         seven_active => seven_active,
         seven_ix     => seven_ix,
         seven_mode   => seven_mode,
         seven_wdata  => seven_wdata,
         uart_active  => uart_active,
         uart_ix      => uart_ix,
         uart_mode    => uart_mode,
         uart_wdata   => uart_wdata
      );
   iebreak_debounce : key_debounce
      PORT MAP (
         clk     => clk,
         key_in  => ebreak_button,
         res_n   => res_n,
         key_out => ebreak_release
      );
   iseven_seg : seven_seg
      PORT MAP (
         clk         => clk,
         ebreak      => ebreak,
         nib0        => nib0,
         nib1        => nib1,
         nib2        => nib2,
         nib3        => nib3,
         pc          => pc,
         res_n       => res_n,
         seven_seg_0 => seven_seg_0,
         seven_seg_1 => seven_seg_1,
         seven_seg_2 => seven_seg_2,
         seven_seg_3 => seven_seg_3
      );
   iseven_seg_interface : seven_seg_interface
      PORT MAP (
         clk          => clk,
         res_n        => res_n,
         seven_active => seven_active,
         seven_ix     => seven_ix,
         seven_mode   => seven_mode,
         seven_wdata  => seven_wdata,
         nib0         => nib0,
         nib1         => nib1,
         nib2         => nib2,
         nib3         => nib3,
         seven_rdata  => seven_rdata,
         seven_stall  => seven_stall
      );
   iuart_interface : uart_interface
      PORT MAP (
         clk                 => clk,
         data_stream_in_ack  => data_stream_in_ack,
         data_stream_in_done => data_stream_in_done,
         data_stream_out     => data_stream_out,
         data_stream_out_stb => data_stream_out_stb,
         res_n               => res_n,
         uart_active         => uart_active,
         uart_ix             => uart_ix,
         uart_mode           => uart_mode,
         uart_wdata          => uart_wdata,
         data_stream_in      => data_stream_in,
         data_stream_in_stb  => data_stream_in_stb,
         uart_rdata          => uart_rdata,
         uart_stall          => uart_stall
      );

   uart_i: IF UART_SIM GENERATE
   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR iuart_sim : uart USE ENTITY peripherals.uart;
   -- pragma synthesis_on

   BEGIN
      iuart_sim : uart
         GENERIC MAP (
            baud            => UART_BAUD_SIM,
            clock_frequency => SYSCLK
         )
         PORT MAP (
            clock               => clk,
            res_n               => res_n,
            data_stream_in      => data_stream_in,
            data_stream_in_stb  => data_stream_in_stb,
            data_stream_in_ack  => data_stream_in_ack,
            data_stream_in_done => data_stream_in_done,
            data_stream_out     => data_stream_out,
            data_stream_out_stb => data_stream_out_stb,
            tx                  => tx,
            rx                  => rx
         );
   END;
   ELSE GENERATE
   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR iuart : uart USE ENTITY peripherals.uart;
   -- pragma synthesis_on

   BEGIN
      iuart : uart
         GENERIC MAP (
            baud            => UART_BAUD_SYNTH,
            clock_frequency => SYSCLK
         )
         PORT MAP (
            clock               => clk,
            res_n               => res_n,
            data_stream_in      => data_stream_in,
            data_stream_in_stb  => data_stream_in_stb,
            data_stream_in_ack  => data_stream_in_ack,
            data_stream_in_done => data_stream_in_done,
            data_stream_out     => data_stream_out,
            data_stream_out_stb => data_stream_out_stb,
            tx                  => tx,
            rx                  => rx
         );
   END;
   END GENERATE uart_i;

END struct;
