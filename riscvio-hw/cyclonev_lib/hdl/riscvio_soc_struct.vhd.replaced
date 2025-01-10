LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.all;

LIBRARY cyclonev_lib;

ARCHITECTURE struct OF riscvio_soc IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL ac_rack        : boolean;
   SIGNAL ac_raddr       : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
   SIGNAL ac_rdata       : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
   SIGNAL ac_rreq        : boolean                                   := false;
   SIGNAL ac_wack        : boolean;
   SIGNAL ac_waddr       : word_T;
   SIGNAL ac_wbyte_ena   : std_logic_vector(BUS_WIDTH/8 - 1 DOWNTO 0);
   SIGNAL ac_wdata       : buzz_word_T;
   SIGNAL ac_wreq        : boolean;
   SIGNAL clk            : std_logic;
   SIGNAL dc_rack        : boolean;
   SIGNAL dc_raddr       : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
   SIGNAL dc_rdata       : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
   SIGNAL dc_rreq        : boolean                                   := false;
   SIGNAL dc_wack        : boolean;
   SIGNAL dc_waddr       : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
   SIGNAL dc_wbyte_ena   : std_logic_vector(BUS_WIDTH/8 - 1 DOWNTO 0);
   SIGNAL dc_wdata       : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0)  := (others => '0');
   SIGNAL dc_wreq        : boolean                                   := false;
   SIGNAL ebreak         : boolean;
   SIGNAL ebreak_release : boolean;
   SIGNAL ic_rack        : boolean;
   SIGNAL ic_raddr       : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
   SIGNAL ic_rdata       : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
   SIGNAL ic_rreq        : boolean                                   := false;
   SIGNAL io_dev         : std_logic_vector(11 DOWNTO 0);
   SIGNAL io_dev_u       : std_logic_vector(11 DOWNTO 0);
   SIGNAL io_ix          : word_T;
   SIGNAL io_ix_u        : word_T;
   SIGNAL io_mode        : mem_mode_T;
   SIGNAL io_mode_u      : mem_mode_T;
   SIGNAL io_rdata       : word_T;
   SIGNAL io_stall       : std_logic;
   SIGNAL io_wdata       : word_T;
   SIGNAL locked         : STD_LOGIC;
   SIGNAL pc             : pc_T;
   SIGNAL res_n          : std_logic;
   SIGNAL res_raw        : std_logic;


   -- Component Declarations
   COMPONENT io
   PORT (
      clk            : IN     std_logic ;
      ebreak         : IN     boolean ;
      ebreak_button  : IN     std_logic ;
      io_dev         : IN     std_logic_vector (11 DOWNTO 0);
      io_dev_u       : IN     std_logic_vector (11 DOWNTO 0);
      io_ix          : IN     word_T ;
      io_ix_u        : IN     word_T ;
      io_mode        : IN     mem_mode_T ;
      io_mode_u      : IN     mem_mode_T ;
      io_wdata       : IN     word_T ;
      pc             : IN     pc_T ;
      res_n          : IN     std_logic ;
      rx             : IN     std_logic ;
      ebreak_release : OUT    boolean ;
      io_rdata       : OUT    word_T ;
      io_stall       : OUT    std_logic ;
      seven_seg_0    : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_1    : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_2    : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_3    : OUT    std_logic_vector (6 DOWNTO 0);
      tx             : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT res_n_sync
   PORT (
      clk       : IN     std_logic ;
      locked    : IN     STD_LOGIC ;
      res_n_raw : IN     std_logic ;
      res_n     : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT int_ram
   PORT (
      ac_raddr     : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
      ac_rreq      : IN     boolean                                    := false;
      ac_waddr     : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
      ac_wbyte_ena : IN     std_logic_vector (BUS_WIDTH/8 - 1 DOWNTO 0);
      ac_wdata     : IN     std_logic_vector (BUS_WIDTH - 1 DOWNTO 0)  := (others => '0');
      ac_wreq      : IN     boolean                                    := false;
      clk          : IN     std_logic;
      dc_raddr     : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
      dc_rreq      : IN     boolean                                    := false;
      dc_waddr     : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
      dc_wbyte_ena : IN     std_logic_vector (BUS_WIDTH/8 - 1 DOWNTO 0);
      dc_wdata     : IN     std_logic_vector (BUS_WIDTH - 1 DOWNTO 0)  := (others => '0');
      dc_wreq      : IN     boolean                                    := false;
      ic_raddr     : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
      ic_rreq      : IN     boolean                                    := false;
      res_n        : IN     std_logic;
      ac_rack      : OUT    boolean;
      ac_rdata     : OUT    std_logic_vector (BUS_WIDTH - 1 DOWNTO 0);
      ac_wack      : OUT    boolean;
      dc_rack      : OUT    boolean;
      dc_rdata     : OUT    std_logic_vector (BUS_WIDTH - 1 DOWNTO 0);
      dc_wack      : OUT    boolean;
      ic_rack      : OUT    boolean;
      ic_rdata     : OUT    std_logic_vector (BUS_WIDTH - 1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT riscvio
   PORT (
      ac_rack        : IN     boolean ;
      ac_rdata       : IN     buzz_word_T ;
      ac_wack        : IN     boolean ;
      clk            : IN     std_logic ;
      dc_rack        : IN     boolean ;
      dc_rdata       : IN     buzz_word_T ;
      dc_wack        : IN     boolean ;
      ebreak_release : IN     boolean ;
      ic_rack        : IN     boolean ;
      ic_rdata       : IN     std_logic_vector (BUS_WIDTH - 1 DOWNTO 0);
      io_rdata       : IN     word_T ;
      io_stall       : IN     std_logic ;
      res_n          : IN     std_logic ;
      ac_raddr       : OUT    std_logic_vector (31 DOWNTO 0);
      ac_rreq        : OUT    boolean ;
      ac_waddr       : OUT    word_T ;
      ac_wbyte_ena   : OUT    std_logic_vector (BUS_WIDTH/8 - 1 DOWNTO 0);
      ac_wdata       : OUT    buzz_word_T ;
      ac_wreq        : OUT    boolean ;
      dc_raddr       : OUT    std_logic_vector (31 DOWNTO 0);
      dc_rreq        : OUT    boolean ;
      dc_waddr       : OUT    std_logic_vector (31 DOWNTO 0);
      dc_wbyte_ena   : OUT    std_logic_vector (BUS_WIDTH/8 - 1 DOWNTO 0);
      dc_wdata       : OUT    buzz_word_T ;
      dc_wreq        : OUT    boolean ;
      ebreak_stall   : OUT    boolean ;
      ic_raddr       : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      ic_rreq        : OUT    boolean ;
      io_dev         : OUT    std_logic_vector (11 DOWNTO 0);
      io_dev_u       : OUT    std_logic_vector (11 DOWNTO 0);
      io_ix          : OUT    word_T ;
      io_ix_u        : OUT    word_T ;
      io_mode        : OUT    mem_mode_T ;
      io_mode_u      : OUT    mem_mode_T ;
      io_wdata       : OUT    word_T ;
      pc_if          : OUT    pc_T 
   );
   END COMPONENT;
   COMPONENT soc_pll
   PORT (
      refclk   : IN     STD_LOGIC;
      rst      : IN     STD_LOGIC;
      locked   : OUT    STD_LOGIC;
      outclk_0 : OUT    STD_LOGIC
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : int_ram USE ENTITY riscvio_lib.int_ram;
   FOR ALL : io USE ENTITY cyclonev_lib.io;
   FOR ALL : res_n_sync USE ENTITY cyclonev_lib.res_n_sync;
   FOR ALL : riscvio USE ENTITY riscvio_lib.riscvio;
   FOR ALL : soc_pll USE ENTITY riscvio_lib.soc_pll;
   -- pragma synthesis_on


BEGIN

   -- ModuleWare code(v1.12) for instance 'res_raw_inv_i' of 'inv'
   res_raw <= NOT(res_n_raw);

   -- Instance port mappings.
   iio : io
      PORT MAP (
         clk            => clk,
         ebreak         => ebreak,
         ebreak_button  => ebreak_button,
         io_dev         => io_dev,
         io_dev_u       => io_dev_u,
         io_ix          => io_ix,
         io_ix_u        => io_ix_u,
         io_mode        => io_mode,
         io_mode_u      => io_mode_u,
         io_wdata       => io_wdata,
         pc             => pc,
         res_n          => res_n,
         rx             => rx,
         ebreak_release => ebreak_release,
         io_rdata       => io_rdata,
         io_stall       => io_stall,
         seven_seg_0    => seven_seg_0,
         seven_seg_1    => seven_seg_1,
         seven_seg_2    => seven_seg_2,
         seven_seg_3    => seven_seg_3,
         tx             => tx
      );
   res_n_sync_i : res_n_sync
      PORT MAP (
         clk       => clk,
         locked    => locked,
         res_n_raw => res_n_raw,
         res_n     => res_n
      );
   int_ram_i : int_ram
      PORT MAP (
         clk          => clk,
         res_n        => res_n,
         dc_rreq      => dc_rreq,
         dc_rack      => dc_rack,
         dc_raddr     => dc_raddr,
         dc_rdata     => dc_rdata,
         ac_rreq      => ac_rreq,
         ac_rack      => ac_rack,
         ac_raddr     => ac_raddr,
         ac_rdata     => ac_rdata,
         ic_rreq      => ic_rreq,
         ic_rack      => ic_rack,
         ic_raddr     => ic_raddr,
         ic_rdata     => ic_rdata,
         dc_wreq      => dc_wreq,
         dc_wack      => dc_wack,
         dc_waddr     => dc_waddr,
         dc_wdata     => dc_wdata,
         dc_wbyte_ena => dc_wbyte_ena,
         ac_wreq      => ac_wreq,
         ac_wack      => ac_wack,
         ac_waddr     => ac_waddr,
         ac_wdata     => ac_wdata,
         ac_wbyte_ena => ac_wbyte_ena
      );
   riscvio_i : riscvio
      PORT MAP (
         ac_rack        => ac_rack,
         ac_rdata       => ac_rdata,
         ac_wack        => ac_wack,
         clk            => clk,
         dc_rack        => dc_rack,
         dc_rdata       => dc_rdata,
         dc_wack        => dc_wack,
         ebreak_release => ebreak_release,
         ic_rack        => ic_rack,
         ic_rdata       => ic_rdata,
         io_rdata       => io_rdata,
         io_stall       => io_stall,
         res_n          => res_n,
         ac_raddr       => ac_raddr,
         ac_rreq        => ac_rreq,
         ac_waddr       => ac_waddr,
         ac_wbyte_ena   => ac_wbyte_ena,
         ac_wdata       => ac_wdata,
         ac_wreq        => ac_wreq,
         dc_raddr       => dc_raddr,
         dc_rreq        => dc_rreq,
         dc_waddr       => dc_waddr,
         dc_wbyte_ena   => dc_wbyte_ena,
         dc_wdata       => dc_wdata,
         dc_wreq        => dc_wreq,
         ebreak_stall   => ebreak,
         ic_raddr       => ic_raddr,
         ic_rreq        => ic_rreq,
         io_dev         => io_dev,
         io_dev_u       => io_dev_u,
         io_ix          => io_ix,
         io_ix_u        => io_ix_u,
         io_mode        => io_mode,
         io_mode_u      => io_mode_u,
         io_wdata       => io_wdata,
         pc_if          => pc
      );
   soc_pll_i : soc_pll
      PORT MAP (
         locked   => locked,
         outclk_0 => clk,
         refclk   => clk_raw,
         rst      => res_raw
      );

END struct;
