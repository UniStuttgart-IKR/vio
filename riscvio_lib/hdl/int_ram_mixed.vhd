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
ARCHITECTURE mixed OF int_ram IS
  
  -- 64k internal ram 
  -- 2k addresses with 256 Bit width
  constant BYTE_ADDR_WIDTH : positive := 12;
  constant ADDR_WIDTH: positive := 9;
  
  type requeststateT is (IDLE, HANDLINGICREQ, HANDLINGDCWREQ, HANDLINGDCRREQ, HANDLINGACREQ);

  signal request_current_state: requeststateT;
  signal request_next_state: requeststateT;

  
  pure function conv_addr (addr: in  word_T) return std_logic_vector is
    variable result: std_logic_vector(ADDR_WIDTH - 1 downto 0) := (others => '0');
  begin
    result := addr(BYTE_ADDR_WIDTH - 1 downto 3);
    return result;
  end function conv_addr;
  
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
  signal wdata, rdata: std_logic_vector(63 downto 0);
  signal ic_rack_int, dc_rack_int, ac_rack_int, dc_wack_int: boolean;
  
BEGIN
  
  -- internal ram controller
  
  -- concurrent signal assignments
  ic_rdata <= rdata(31 downto 0) & rdata(63 downto 32);
  dc_rdata <= rdata(31 downto 0) & rdata(63 downto 32);
  ac_rdata <= rdata(31 downto 0) & rdata(63 downto 32);
  
  we       <= '1' when dc_wack else '0';
  wdata    <= dc_wdata;
  
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
          request_next_state <= HANDLINGACREQ;
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
      
      when HANDLINGACREQ => 
        if not ac_rreq then
          request_next_state <= IDLE;
        end if;
    end case;
  end process  request_fsm_transitions;

  -- request handling acknoledge and address signal control
  request_fsm_outputs: process(request_current_state, ic_rreq, dc_rreq, dc_wreq, ac_rreq, ic_raddr, dc_raddr, dc_waddr, ac_raddr) is
  begin
    ic_rack_int     <= false;
    dc_rack_int     <= false;
    ac_rack_int     <= false;
    dc_wack_int     <= false;
    addr <= (others => '0');

    case request_current_state is
      when IDLE => 
        if ic_rreq then
          addr       <= conv_addr(ic_raddr);
          ic_rack_int     <= true;
        elsif dc_rreq then
          addr       <= conv_addr(dc_raddr);
          dc_rack_int     <= true;
        elsif dc_wreq then
          addr       <= conv_addr(dc_waddr);
          dc_wack_int     <= true;
        elsif ac_rreq then
          addr       <= conv_addr(ac_raddr);
          ac_rack_int     <= true;
        end if;

      when HANDLINGICREQ => 
        addr       <= conv_addr(ic_raddr);
        ic_rack_int     <= true;
      when HANDLINGDCRREQ => 
        addr       <= conv_addr(dc_raddr);
        dc_rack_int     <= true;
      when HANDLINGDCWREQ => 
        addr       <= conv_addr(dc_waddr);
        dc_wack_int     <= true;
      when HANDLINGACREQ => 
        addr       <= conv_addr(ac_raddr);
        ac_rack_int     <= true;
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
      numwords_a => 512,
      operation_mode => "SINGLE_PORT",
      outdata_aclr_a => "NONE",
      outdata_reg_a => "UNREGISTERED",
      power_up_uninitialized => "FALSE",
      read_during_write_mode_port_a => "NEW_DATA_NO_NBE_READ",
      widthad_a => 9,
      width_a => 64,
      width_byteena_a => 1
    )
    PORT MAP (
      address_a => addr,
      clock0 => clk,
      data_a => wdata(31 downto 0) & wdata(63 downto 32),
      wren_a => we,
      q_a => rdata
    );

END ARCHITECTURE mixed;

