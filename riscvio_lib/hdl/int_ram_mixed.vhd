--
-- VHDL Architecture rv64i_lib.int_ram.mixed
--
-- Created:
--          by - ckoehler.wima (pc115)
--          at - 10:42:56 04/13/23
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--  
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY ieee;
USE ieee.numeric_std.all;
use IEEE.math_real.all;
LIBRARY riscvio_lib;
USE riscvio_lib.helper.revWords;
USE riscvio_lib.helper.revNibbles;
LIBRARY riscvio_lib;
USE riscvio_lib.all;

ARCHITECTURE mixed OF int_ram IS
  
  -- 64k internal ram 
  -- 2k addresses with 256 Bit width
  constant BYTE_ADDR_WIDTH : positive := 12;
  constant ADDR_WIDTH: positive := BYTE_ADDR_WIDTH - integer(ceil(log2(real(BUS_WIDTH/8))));
  
  type requeststateT is (IDLE, HANDLINGICREQ, HANDLINGDCWREQ, HANDLINGDCRREQ, HANDLINGACRREQ, HANDLINGACWREQ);

  signal request_current_state: requeststateT;
  signal request_next_state: requeststateT;

  
  pure function conv_addr (addr: in  word_T) return std_logic_vector is
    variable result: std_logic_vector(ADDR_WIDTH - 1 downto 0) := (others => '0');
  begin
    result := addr(BYTE_ADDR_WIDTH - 1 downto BYTE_ADDR_WIDTH - ADDR_WIDTH);
    return result;
  end function conv_addr;
  

  subtype BUS_WORD_IX_IN_ADDR is natural range BYTE_ADDR_WIDTH - 1 downto BYTE_ADDR_WIDTH - ADDR_WIDTH;


  component simple_dual_port_ram
    generic (
      ADDR_WIDTH: positive;
      DATA_WIDTH: positive
    );
    port (
      clk  : in std_logic;
      raddr: in std_logic_vector(ADDR_WIDTH - 1 downto 0);
      waddr: in std_logic_vector(ADDR_WIDTH - 1 downto 0);
      we   : in std_logic;
      wdata: in std_logic_vector(DATA_WIDTH - 1 downto 0);
      rdata: out std_logic_vector(DATA_WIDTH - 1 downto 0) 
    );
  end component simple_dual_port_ram;
  
  -- internal ram signals
  signal addr: std_logic_vector(ADDR_WIDTH - 1 downto 0);
  signal we: std_logic;
  signal byte_ena: std_logic_vector(BUS_WIDTH/8 - 1 downto 0);
  signal wdata, rdata: std_logic_vector(BUS_WIDTH - 1 downto 0);
  signal ic_rack_int, dc_rack_int, ac_rack_int, dc_wack_int, ac_wack_int: boolean;
  signal wack_reg: boolean;
BEGIN
  
  -- internal ram controller
  

  
  -- request handling fsm state memory
  request_fsm_state: process(clk, res_n) is
  begin
    if res_n = '0' then
      request_current_state <= IDLE;
    else
      if clk'event and clk = '1' then
        request_current_state <= request_next_state;
      end if;
    end if; 
  end process request_fsm_state;

  -- request handling transition decision
  request_fsm_transitions: process(all) is
  begin
    request_next_state <= request_current_state;


    case request_current_state is
      when IDLE => 
        if ic_rreq then
          request_next_state <= HANDLINGICREQ;
        elsif dc_rreq then
          request_next_state <= HANDLINGDCRREQ;
        elsif dc_wreq then
          request_next_state <= HANDLINGDCWREQ;
        elsif ac_rreq then
          request_next_state <= HANDLINGACRREQ;
        elsif ac_wreq then
          request_next_state <= HANDLINGACWREQ;
        end if;

      when HANDLINGICREQ => 
        if not ic_rreq then
          request_next_state <= IDLE;
        end if;

      when HANDLINGDCRREQ => 
        if not dc_rreq then
          request_next_state <= IDLE;
        end if;
      
      when HANDLINGDCWREQ => 
        if not dc_wreq then
          request_next_state <= IDLE;
        end if;
      
      when HANDLINGACRREQ => 
        if not ac_rreq then
          request_next_state <= IDLE;
        end if;

      when HANDLINGACWREQ => 
        if not ac_wreq then
          request_next_state <= IDLE;
        end if;
    end case;
  end process  request_fsm_transitions;
  
  
  ic_rdata <= revWords(rdata);
  dc_rdata <= revWords(rdata);
  ac_rdata <= revWords(rdata);
  we       <= '1' when wack_reg else '0';
  byte_ena <= ac_wbyte_ena when request_current_state = HANDLINGACWREQ else 
              dc_wbyte_ena when request_current_state = HANDLINGDCWREQ else
              (others => '0');
                
  wdata    <= dc_wdata when request_current_state = HANDLINGDCWREQ else 
              ac_wdata;

  -- request handling acknoledge and address signal control
  request_fsm_outputs: process(request_current_state, ic_rreq, dc_rreq, dc_wreq, ac_rreq, ic_raddr, dc_raddr, dc_waddr, ac_raddr, ac_wreq, ac_waddr) is
  begin
    ic_rack_int     <= false;
    dc_rack_int     <= false;
    ac_rack_int     <= false;
    dc_wack_int     <= false;
    ac_wack_int     <= false;
    addr <= (others => '0');

    case request_current_state is
      when IDLE => 
        if ic_rreq then
          addr       <= ic_raddr(BUS_WORD_IX_IN_ADDR);
          ic_rack_int     <= true;
        elsif dc_rreq then
          addr       <= dc_raddr(BUS_WORD_IX_IN_ADDR);
          dc_rack_int     <= true;
        elsif dc_wreq then
          addr       <= dc_waddr(BUS_WORD_IX_IN_ADDR);
          dc_wack_int     <= true;
        elsif ac_rreq then
          addr       <= ac_raddr(BUS_WORD_IX_IN_ADDR);
          ac_rack_int     <= true;
        elsif ac_wreq then
          addr       <= ac_waddr(BUS_WORD_IX_IN_ADDR);
          ac_wack_int     <= true;
        end if;

      when HANDLINGICREQ => 
        addr       <= ic_raddr(BUS_WORD_IX_IN_ADDR);
        ic_rack_int     <= ic_rreq;
      when HANDLINGDCRREQ => 
        addr       <= dc_raddr(BUS_WORD_IX_IN_ADDR);
        dc_rack_int     <= dc_rreq;
      when HANDLINGDCWREQ => 
        addr       <= dc_waddr(BUS_WORD_IX_IN_ADDR);
        dc_wack_int     <= dc_wreq;
      when HANDLINGACRREQ => 
        addr       <= ac_raddr(BUS_WORD_IX_IN_ADDR);
        ac_rack_int     <= ac_rreq;
      when HANDLINGACWREQ => 
        addr       <= ac_waddr(BUS_WORD_IX_IN_ADDR);
        ac_wack_int     <= ac_wreq;
    end case;
  end process request_fsm_outputs;



  
    
  -- process for 1 clock cycle delay between req and ack to sync with block ram
  process (clk, res_n) is
  begin
    if res_n = '0' then
      ic_rack <= false;
      dc_rack <= false;
      ac_rack <= false;
      dc_wack <= false;
    else
      if clk'event and clk = '1' then
        ic_rack <= ic_rack_int;
        dc_rack <= dc_rack_int;
        ac_rack <= ac_rack_int;
        dc_wack <= dc_wack_int;
        ac_wack <= ac_wack_int;
        wack_reg <= dc_wack_int or ac_wack_int;
      end if;
    end if; 
  end process;
  


	altsyncram_component : altsyncram
    GENERIC MAP (
      clock_enable_input_a => "BYPASS",
      clock_enable_output_a => "BYPASS",
      init_file => "../../boot.mif",
      intended_device_family => "Cyclone V",
      lpm_hint => "ENABLE_RUNTIME_MOD=NO",
      lpm_type => "altsyncram",
      numwords_a => 2**ADDR_WIDTH,
      operation_mode => "SINGLE_PORT",
      outdata_aclr_a => "NONE",
      outdata_reg_a => "UNREGISTERED",
      power_up_uninitialized => "FALSE",
      read_during_write_mode_port_a => "OLD_DATA", -- this is required for sim to work
      widthad_a => ADDR_WIDTH,
      width_a => BUS_WIDTH,
      width_byteena_a => BUS_WIDTH/8
    )
    PORT MAP (
      address_a => addr,
      clock0 => clk,
      data_a => revWords(wdata),
      wren_a => we,
      byteena_a => revNibbles(byte_ena),
      q_a => rdata
    );
	
END ARCHITECTURE mixed;

