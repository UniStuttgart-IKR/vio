LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY riscvio_lib;
USE riscvio_lib.pipeline.all;
USE riscvio_lib.ISA.all;


ARCHITECTURE struct OF riscvio_tb IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL ac_rack  : boolean;
   SIGNAL ac_raddr : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
   SIGNAL ac_rdata : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
   SIGNAL ac_rreq  : boolean                                   := false;
   SIGNAL clk      : std_logic;
   SIGNAL dc_rack  : boolean;
   SIGNAL dc_raddr : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
   SIGNAL dc_rdata : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
   SIGNAL dc_rreq  : boolean                                   := false;
   SIGNAL dc_wack  : boolean;
   SIGNAL dc_waddr : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
   SIGNAL dc_wdata : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0)  := (others => '0');
   SIGNAL dc_wreq  : boolean                                   := false;
   SIGNAL ic_rack  : boolean;
   SIGNAL ic_raddr : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
   SIGNAL ic_rdata : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
   SIGNAL ic_rreq  : boolean                                   := false;
   SIGNAL io_dev   : std_logic_vector(11 DOWNTO 0);
   SIGNAL io_mode  : mem_mode_T;
   SIGNAL io_rdata : word_T;
   SIGNAL io_wdata : word_T;
   SIGNAL res_n    : std_logic;
   SIGNAL stall    : std_logic;


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
   COMPONENT int_ram
   PORT (
      ac_raddr : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
      ac_rreq  : IN     boolean                                    := false;
      clk      : IN     std_logic;
      dc_raddr : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
      dc_rreq  : IN     boolean                                    := false;
      dc_waddr : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
      dc_wdata : IN     std_logic_vector (BUS_WIDTH - 1 DOWNTO 0)  := (others => '0');
      dc_wreq  : IN     boolean                                    := false;
      ic_raddr : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
      ic_rreq  : IN     boolean                                    := false;
      res_n    : IN     std_logic;
      ac_rack  : OUT    boolean;
      ac_rdata : OUT    std_logic_vector (BUS_WIDTH - 1 DOWNTO 0);
      dc_rack  : OUT    boolean;
      dc_rdata : OUT    std_logic_vector (BUS_WIDTH - 1 DOWNTO 0);
      dc_wack  : OUT    boolean;
      ic_rack  : OUT    boolean;
      ic_rdata : OUT    std_logic_vector (BUS_WIDTH - 1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT riscvio
   PORT (
      ac_rack  : IN     boolean ;
      ac_rdata : IN     buzz_word_T ;
      clk      : IN     std_logic ;
      dc_rack  : IN     boolean ;
      dc_rdata : IN     buzz_word_T ;
      dc_wack  : IN     boolean ;
      ic_rack  : IN     boolean ;
      ic_rdata : IN     std_logic_vector (BUS_WIDTH - 1 DOWNTO 0);
      io_rdata : IN     word_T ;
      io_stall : IN     std_logic ;
      res_n    : IN     std_logic ;
      ac_raddr : OUT    std_logic_vector (31 DOWNTO 0);
      ac_rreq  : OUT    boolean ;
      dc_raddr : OUT    std_logic_vector (31 DOWNTO 0);
      dc_rreq  : OUT    boolean ;
      dc_waddr : OUT    std_logic_vector (31 DOWNTO 0);
      dc_wdata : OUT    buzz_word_T ;
      dc_wreq  : OUT    boolean ;
      ic_raddr : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      ic_rreq  : OUT    boolean ;
      io_dev   : OUT    std_logic_vector (11 DOWNTO 0);
      io_ix    : OUT    word_T ;
      io_mode  : OUT    mem_mode_T ;
      io_wdata : OUT    word_T 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : clk_res_gen_var USE ENTITY riscvio_lib.clk_res_gen_var;
   FOR ALL : int_ram USE ENTITY riscvio_lib.int_ram;
   FOR ALL : riscvio USE ENTITY riscvio_lib.riscvio;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 io_dummy
   -- io_dummy 1          
   stall <= 'Z';
   io_rdata <= (others => '0');                              


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
   int_ram_i : int_ram
      PORT MAP (
         clk      => clk,
         res_n    => res_n,
         dc_rreq  => dc_rreq,
         dc_rack  => dc_rack,
         dc_raddr => dc_raddr,
         dc_rdata => dc_rdata,
         ac_rreq  => ac_rreq,
         ac_rack  => ac_rack,
         ac_raddr => ac_raddr,
         ac_rdata => ac_rdata,
         ic_rreq  => ic_rreq,
         ic_rack  => ic_rack,
         ic_raddr => ic_raddr,
         ic_rdata => ic_rdata,
         dc_wreq  => dc_wreq,
         dc_wack  => dc_wack,
         dc_waddr => dc_waddr,
         dc_wdata => dc_wdata
      );
   riscvio_i : riscvio
      PORT MAP (
         ac_rack  => ac_rack,
         ac_rdata => ac_rdata,
         clk      => clk,
         dc_rack  => dc_rack,
         dc_rdata => dc_rdata,
         dc_wack  => dc_wack,
         ic_rack  => ic_rack,
         ic_rdata => ic_rdata,
         io_rdata => io_rdata,
         io_stall => stall,
         res_n    => res_n,
         ac_raddr => ac_raddr,
         ac_rreq  => ac_rreq,
         dc_raddr => dc_raddr,
         dc_rreq  => dc_rreq,
         dc_waddr => dc_waddr,
         dc_wdata => dc_wdata,
         dc_wreq  => dc_wreq,
         ic_raddr => ic_raddr,
         ic_rreq  => ic_rreq,
         io_dev   => io_dev,
         io_ix    => OPEN,
         io_mode  => io_mode,
         io_wdata => io_wdata
      );

END struct;
