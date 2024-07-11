--
-- VHDL Architecture riscvio_lib.primitive_cache.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 16:09:23 22.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY riscvio_lib;
USE riscvio_lib.simple_dual_port_ram;
USE riscvio_lib.helper.isAllStd;
USE riscvio_lib.helper.maxOf2;
LIBRARY ieee;
use IEEE.math_real.all;
use ieee.numeric_std.all;

--'TODO: remove addr input port, not required anymore
ARCHITECTURE behav OF primitive_cache IS
    constant BYTE_WIDTH: positive := 8;
    subtype byte_T is std_logic_vector(BYTE_WIDTH - 1 downto 0);
    constant BYTES_PER_WORD: natural := DATA_WIDTH / BYTE_WIDTH;
    constant BYTES_PER_WORD_LOG: natural := integer(ceil(log2(real(BYTES_PER_WORD))));
    constant LINES_LOG: natural := integer(ceil(log2(real(LINES))));
    constant WORDS_IN_LINE_LOG: natural := integer(ceil(log2(real(WORDS_IN_LINE))));
    constant BYTES_IN_LINE: natural := BYTES_PER_WORD * WORDS_IN_LINE;
    constant ADDR_WIDTH_WORD: natural := integer(ceil(log2(real(DATA_WIDTH/BYTE_WIDTH))));
    constant TAG_WIDTH: natural := ADDR_WIDTH - LINES_LOG - WORDS_IN_LINE_LOG - ADDR_WIDTH_WORD;
    constant BUS_WORDS_PER_LINE: natural := (WORDS_IN_LINE * DATA_WIDTH) / BUS_WIDTH; -- if this is zero, BUS_WIDTH > LINE_WIDTH*DATA_WIDTH (in bits)
    constant Q_LOG: integer := maxOf2(integer(ceil(log2(real(BUS_WIDTH) / real(WORDS_IN_LINE * DATA_WIDTH)))), 0);  
    constant WORDS_PER_BUS: positive := BUS_WIDTH / DATA_WIDTH;
    constant WORDS_PER_BUS_LOG: natural := integer(ceil(log2(real(WORDS_PER_BUS))));
    

    constant zero_byte_addr: std_logic_vector(ADDR_WIDTH_WORD - 1 downto 0) := (others => '0');
    constant zero_bus_addr: std_logic_vector(WORDS_PER_BUS_LOG - 1 downto 0)  := (others => '0');

    subtype word_T is std_logic_vector(DATA_WIDTH - 1 downto 0);
    type bus_word_T is array(WORDS_PER_BUS - 1 downto 0) of word_T;

    -- cache line memory in/out signals
    type row_selected_bytes_T is array(BYTES_IN_LINE - 1 downto 0) of byte_T;
    signal bytes_to_write: row_selected_bytes_T;
    signal line_ix: std_logic_vector(LINES_LOG - 1 downto 0);
    signal line_valid: std_logic_vector(0 downto 0);
    signal valid_bit_to_write: std_logic_vector(0 downto 0);
    signal line_valid_bit_we: std_logic;

    -- the tag of the currently selected cache line
    signal line_tag_selected: std_logic_vector(TAG_WIDTH - 1 downto 0);
    -- what words in the current cache line we want to write
    signal bytes_we: std_logic_vector(BYTES_IN_LINE - 1 downto 0);


    type fill_state_T is (IDLE, PREPARING, LOADING, ALMOST_DONE, WAITING);
    signal fill_state: fill_state_T;
    -- which bus word we are currently filling into the selected line
    signal line_fill_ctr: natural range 0 to BUS_WORDS_PER_LINE + 1;
    signal last_line_fill_ctr: natural range 0 to BUS_WORDS_PER_LINE + 1;
    signal set_line_tag: std_logic;
    -- output of an entire line
    signal row_selected_bytes: row_selected_bytes_T;
    -- input for an entire line
    signal bytes_to_write_fill: row_selected_bytes_T;
    -- from fill
    signal bytes_we_fill: std_logic_vector(BYTES_IN_LINE - 1 downto 0);

    signal used_line_ctr: natural range 0 to BUS_WORDS_PER_LINE + 1;
    signal used_addr: std_logic_vector(addr'range);
    signal last_used_line_ctr: natural range 0 to BUS_WORDS_PER_LINE + 1; 
    signal last_rd_addr: std_logic_vector(addr'range);
    signal eff_rdata: std_logic_vector(rdata'range);
    signal raddr_int: std_logic_vector(raddr'range);


    type writeback_state_T is (IDLE, WAITING_WR, COLLECT_DATA);
    -- basic mode
    signal writeback_state: writeback_state_T;
    -- addr&sd we wrote last
    signal last_wr_addr: std_logic_vector(addr'range);
    signal last_sd: std_logic_vector(sd'range);
    signal write_stall: boolean;
    -- input for an entire line
    signal bytes_to_write_pipe: row_selected_bytes_T;

    -- burst mode
    signal accumulated_byteena: std_logic_vector(BUS_WIDTH/8 - 1 downto 0);
    signal accumulated_bus_word: std_logic_vector(BUS_WIDTH - 1 downto 0);
    signal accumulated_byteena_d: std_logic_vector(BUS_WIDTH/8 - 1 downto 0);
    signal accumulated_bus_word_d: std_logic_vector(BUS_WIDTH - 1 downto 0);
    -- the address when the burst started (used to detect when we leave the range of words covered by a single bus line)
    signal burst_addr: std_logic_vector(addr'range);
    -- from pipeline
    signal bytes_we_pipe: std_logic_vector(BYTES_IN_LINE - 1 downto 0);
    


    type invalidatiion_state_T is (RESET, IDLE, WAITS, INVALIDATING);
    signal invalidation_state: invalidatiion_state_T;
    signal invalidation_line_ix: std_logic_vector(LINES_LOG - 1 downto 0);


    -- bits in address which make up the tag
    subtype TAG_RANGE is natural range ADDR_WIDTH - 1 downto WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD + LINES_LOG;
    -- bits in address which make up which line the data should be located in
    subtype LINE_RANGE is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD + LINES_LOG - 1 downto WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD;
    -- bits in address which determine which data word in the cache line gets selected
    subtype WORD_RANGE is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD - 1 downto ADDR_WIDTH_WORD;
    -- bits in address which remain from the address when we access the memory to select the right bus word
    subtype BUS_WORD_RANGE is natural range ADDR_WIDTH - 1 downto ADDR_WIDTH_WORD + WORDS_PER_BUS_LOG ;
    -- bits in address which tell us which word in the current bus word we want to access
    subtype WORD_IN_BUS_WORD is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD + WORDS_PER_BUS_LOG - 1downto WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD;
    -- bits in address which tell us which byte in the current bus word we want to access
    subtype BYTE_IN_BUS_WORD is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD - 1 downto 0;


    -- #TODO: purge unnecessesary internal signals

    signal line_hit: boolean;
    signal stall_int: boolean;
    signal last_next_addr: std_logic_vector(next_addr'range);
    
BEGIN
    valid_memory: entity simple_dual_port_ram 
      generic map (
        ADDR_WIDTH => LINES_LOG,
        DATA_WIDTH => 1
      )
      port map (
        clk   => clk,
        raddr => line_ix,
        waddr => line_ix,
        wdata => valid_bit_to_write,
        we    => line_valid_bit_we,
        rdata => line_valid
      );
    
    tag_memory: entity simple_dual_port_ram 
      generic map (
        ADDR_WIDTH => LINES_LOG,
        DATA_WIDTH => TAG_WIDTH
      )
      port map (
        clk   => clk,
        raddr => line_ix,
        waddr => line_ix,
        wdata => addr(TAG_RANGE),
        we    => set_line_tag,
        rdata => line_tag_selected
      );

    

    cache_rows: for w in WORDS_IN_LINE - 1 downto 0 generate
    begin
        words: for b in BYTES_PER_WORD - 1 downto 0 generate
        begin
            byte_mem_i: entity simple_dual_port_ram
            generic map (
                ADDR_WIDTH => LINES_LOG,
                DATA_WIDTH => 8
            )
            port map(
                clk   => clk,
                raddr => line_ix,
                waddr => line_ix,
                wdata => bytes_to_write(w * BYTES_PER_WORD + b),
                we    => bytes_we(w * BYTES_PER_WORD + b),
                rdata => row_selected_bytes(w * BYTES_PER_WORD + b)
            );
        end generate;
    end generate;

    addr_p: process(clk, res_n) is
    begin
        if res_n = '0' then
        else
            if clk'event and clk = '1' then
                last_next_addr <= next_addr;
            end if;
        end if;
    end process;
    
    line_hit <= line_tag_selected = last_next_addr(TAG_RANGE) and line_valid = (0 => '1');
    bytes_we <= bytes_we_fill or bytes_we_pipe;
    bytes_to_write <= bytes_to_write_fill when fill_state /= IDLE or (not line_hit and rd) else bytes_to_write_pipe;

    stall_int <= ((not line_hit or fill_state /= IDLE) and rd) or invalidation_state /= IDLE or write_stall;
    stall <= stall_int;
    
    
    fill_unit_state_p: process(clk, res_n) is
    begin
        if res_n /= '1' then
            fill_state <= IDLE;
            line_fill_ctr <= 0;
            last_line_fill_ctr <= 0;
            last_used_line_ctr <= 0;
            last_rd_addr <= (others => '0'); 
        else
            if clk'event and clk = '1' then
                last_line_fill_ctr <= line_fill_ctr;
                last_used_line_ctr <= used_line_ctr;
                last_rd_addr <= last_next_addr;
                
                case fill_state is
                    when IDLE => 
                        if not line_hit and rd and invalidation_state = IDLE and fill_state = IDLE then
                            fill_state <= LOADING;
                            line_fill_ctr <= 1;
                        end if;
                    when PREPARING => 
                        fill_state <= LOADING;
                        --line_fill_ctr <= line_fill_ctr + 1;
                    when LOADING =>
                        if not rack then
                            fill_state <= WAITING;
                            if line_fill_ctr /= 0 then
                                line_fill_ctr <= line_fill_ctr - 1;
                            end if;
                        elsif line_fill_ctr = BUS_WORDS_PER_LINE - 1 then
                            fill_state <= ALMOST_DONE;
                        else
                            if BUS_WORDS_PER_LINE /= 0 then
                                line_fill_ctr <= line_fill_ctr + 1;
                            else
                                fill_state <= IDLE;
                            end if;
                        end if;
                    when ALMOST_DONE =>
                        if rack then
                            fill_state <= IDLE;
                            line_fill_ctr <= 0;
                        end if;
                    when WAITING => 
                        if rack and line_fill_ctr = BUS_WORDS_PER_LINE - 1 then
                            fill_state <= IDLE;
                            line_fill_ctr <= 0;
                        elsif rack then
                            if BUS_WORDS_PER_LINE /= 0 then
                                fill_state <= PREPARING;
                                line_fill_ctr <= line_fill_ctr + 1;
                            else
                                fill_state <= IDLE;
                            end if;
                        end if;
                end case;
            end if;
        end if;
    end process fill_unit_state_p;


    load_data_p: process(all) is
        variable tmp: byte_T;
    begin
        for b in BYTES_PER_WORD - 1 downto 0 loop
            tmp := row_selected_bytes(to_integer(unsigned(last_next_addr(WORD_RANGE))) * BYTES_PER_WORD + b);
            for bit_i in BYTE_WIDTH - 1 downto 0 loop
                ld(b * BYTE_WIDTH + bit_i) <= tmp(bit_i);
            end loop;
        end loop;
    end process load_data_p;


    fwd_write_to_rdata_p: process(all) is
    begin
        eff_rdata <= rdata;

        -- we need to insert data to be written into rdata to make sure it gets filled into a cache line when it hasnt been written to ram yet  

        -- does the bus  word address we have in the write buffer match the one we are reading?
        if burst_addr(burst_addr'left downto LINE_RANGE'right + Q_LOG) = raddr_int(raddr_int'left downto LINE_RANGE'right + Q_LOG) then
            for w in WORDS_PER_BUS - 1 downto 0 loop
                for b in BYTES_PER_WORD - 1 downto 0 loop
                        -- is there valid data we can forward?
                        if accumulated_byteena(to_integer(unsigned(used_addr(WORD_IN_BUS_WORD))) * BYTES_PER_WORD + b) = '1' then

                            for bit_i in BYTE_WIDTH - 1 downto 0 loop
                                eff_rdata((w * BYTES_PER_WORD + b) *BYTE_WIDTH + bit_i) <= accumulated_bus_word((w * BYTES_PER_WORD + b) *BYTE_WIDTH + bit_i);
                            end loop;
                        end if;
                end loop;
            end loop;
        end if;
    end process fwd_write_to_rdata_p;

    used_line_ctr <= last_line_fill_ctr when (fill_state = LOADING or fill_state = PREPARING) and not rack else line_fill_ctr;
    used_addr <= next_addr;
    raddr <= raddr_int;
    
    fill_unit_output_p: process(all) is
    begin
        rreq <= false;
        raddr_int <= (others => '0');
        set_line_tag <= '0';
        bytes_we_fill <= (others => '0');

        if BUS_WORDS_PER_LINE > 1 then
            raddr_int <= used_addr(TAG_RANGE) & used_addr(LINE_RANGE) & std_logic_vector(to_unsigned(used_line_ctr, WORDS_IN_LINE_LOG - WORDS_PER_BUS_LOG)) & zero_byte_addr & zero_bus_addr;
        else
            raddr_int <= used_addr(last_next_addr'left downto LINE_RANGE'right + Q_LOG) & zero_byte_addr & zero_bus_addr;
        end if;
        
        if fill_state /= IDLE or (not line_hit and rd and invalidation_state = IDLE) then
            
            rreq <= true;
        end if;

        case fill_state is
            when IDLE | PREPARING =>
                if not line_hit and rd and invalidation_state = IDLE and fill_state = IDLE  then
                    rreq <= true;
                end if;

            when LOADING | WAITING | ALMOST_DONE =>
                if (line_fill_ctr = BUS_WORDS_PER_LINE - 1 or BUS_WORDS_PER_LINE = 0) and rack then set_line_tag <= '1'; else set_line_tag <= '0'; end if;
                
                if rack then
                    if BUS_WORDS_PER_LINE /= 0 then
                        for i in WORDS_PER_BUS - 1 downto 0 loop
                            for b in BYTES_PER_WORD - 1 downto 0 loop
                                bytes_we_fill(((last_used_line_ctr) * WORDS_PER_BUS + i) * BYTES_PER_WORD + b) <= '1';
                            end loop;
                        end loop;
                    else
                        for b in BYTES_PER_WORD - 1 downto 0 loop
                            bytes_we_fill(b) <= '1';
                        end loop;
                    end if;
                end if;
        end case;

        bytes_to_write_fill <= (others => (others => '0'));

        if BUS_WORDS_PER_LINE /= 0 then
            for i in WORDS_PER_BUS - 1 downto 0 loop
                for b in BYTES_PER_WORD - 1 downto 0 loop
                    for bit_i in BYTE_WIDTH - 1 downto 0 loop
                        bytes_to_write_fill(((last_used_line_ctr) * WORDS_PER_BUS + i) * BYTES_PER_WORD + b)(bit_i) <= eff_rdata((i*BYTES_PER_WORD + b) * BYTE_WIDTH + bit_i);
                    end loop;
                end loop;
            end loop;
        else
            for b in BYTES_PER_WORD - 1 downto 0 loop
                
                bytes_to_write_fill(b) <= eff_rdata(((to_integer(unsigned(last_next_addr(WORD_IN_BUS_WORD)))*BYTES_PER_WORD + b + 1))*BYTE_WIDTH - 1 downto (to_integer(unsigned(last_next_addr(WORD_IN_BUS_WORD)))*BYTES_PER_WORD + b) * BYTE_WIDTH);
            end loop;
        end if;
    end process fill_unit_output_p;

    
    writeback_unit_state_p: process(clk, res_n) is
    begin
        if res_n /= '1' then
            writeback_state <= IDLE;
            last_sd <= (others => '0');
            last_wr_addr <= (others => '0');
            burst_addr <= (others => '0');
            accumulated_byteena <= (others => '0');
            accumulated_bus_word <= (others => '0');
        else
            if clk'event and clk = '1' then
                case writeback_state is
                    when IDLE => 
                        if we and (last_next_addr /= last_wr_addr or sd /= last_sd) and invalidation_state = IDLE then
                            last_sd <= sd;
                            last_wr_addr <= last_next_addr;

                            burst_addr <= last_next_addr;


                            -- for remembering values byteena/sd when we got the we / for accumulating sd/byteena over multiple writes in a single burst 
                            accumulated_byteena <= accumulated_byteena_d;
                            accumulated_bus_word <= accumulated_bus_word_d;

                                
                            if not LEVERAGE_BURSTS then
                                -- we immediately write the data
                                writeback_state <= WAITING_WR;
                            else
                                writeback_state <= COLLECT_DATA;       
                            end if;
                        end if;
                    
                    when COLLECT_DATA => 
                        if we then
                            if not wreq then
                                last_sd <= sd;
                                last_wr_addr <= last_next_addr;
                            end if;

                            accumulated_byteena <= accumulated_byteena_d;
                            accumulated_bus_word <= accumulated_bus_word_d;
                        end if;
                        -- when we leave the region of a single bus word or we need to invalidate we need to start writing back
                        if last_next_addr(BUS_WORD_RANGE) /= burst_addr(BUS_WORD_RANGE) or invalidate or not we then
                            -- we need to commit now
                            writeback_state <= WAITING_WR;
                        end if; 
                        
                    when WAITING_WR =>
                        if wack then
                            writeback_state <= IDLE;
                            accumulated_byteena <= (others => '0');
                            accumulated_bus_word <= (others => '0');
                        end if;
                end case;
            end if;
        end if;
    end process writeback_unit_state_p;

    writeback_unit_output_p: process(all) is
        variable accumulated_byteena_d_int: std_logic_vector(accumulated_byteena'range);
        variable accumulated_bus_word_d_int: std_logic_vector(accumulated_bus_word'range);
    begin
        waddr <= (others => '0');
        wreq <= false;
        wdata <= (others => '0');
        write_stall <= false;
        wbyte_ena <= (others => '0');
        bytes_we_pipe <= (others => '0');
        bytes_to_write_pipe <= (others => (others => '0'));
        accumulated_byteena_d_int := accumulated_byteena;
        accumulated_bus_word_d_int := accumulated_bus_word;



        -- always apply sd to all words
        for w in WORDS_IN_LINE - 1 downto 0 loop
            for b in BYTES_PER_WORD - 1 downto 0 loop
                bytes_to_write_pipe(w) <= sd((b+1) * BYTE_WIDTH - 1 downto b * BYTE_WIDTH);
            end loop;
        end loop;

        -- handle writes to cache lines in case of hit
        if we and line_hit and invalidation_state = IDLE then
            if BYTES_IN_LINE /= 1 then
                for b in BYTES_PER_WORD - 1 downto 0 loop
                    -- only write the bytes we really want to write
                    bytes_we_pipe(to_integer(unsigned(last_next_addr(WORD_RANGE))) * BYTES_PER_WORD + b) <= byte_ena(b);
                end loop;
            else
                bytes_we_pipe(0) <= '1';
            end if;
        end if;

        -- handle updates of accumulated data, byteenable
        if we and invalidation_state = IDLE then
            for i in BYTES_PER_WORD - 1 downto 0 loop
                if byte_ena(i) = '1' then
                    -- we only update the bytes where the byteena was enabled, we leave the rest as is
                    accumulated_byteena_d_int((WORDS_PER_BUS - to_integer(unsigned(last_next_addr(WORD_IN_BUS_WORD))) - 1) * BYTES_PER_WORD + i) := '1';
                    for bit_i in BYTE_WIDTH - 1 downto 0 loop
                        accumulated_bus_word_d_int(((WORDS_PER_BUS - to_integer(unsigned(last_next_addr(WORD_IN_BUS_WORD))) - 1) * BYTES_PER_WORD + i) * BYTE_WIDTH + bit_i) := sd(i* BYTE_WIDTH + bit_i); 
                    end loop;
                end if;
            end loop;
        end if;
        accumulated_byteena_d <= accumulated_byteena_d_int;
        accumulated_bus_word_d <= accumulated_bus_word_d_int;

        if LEVERAGE_BURSTS then 
            case writeback_state is
                when IDLE => null; -- we just wait for data...
                when COLLECT_DATA => 
                    wreq <= last_next_addr(BUS_WORD_RANGE) /= burst_addr(BUS_WORD_RANGE) or not we;
                    wdata <= accumulated_bus_word;
                    waddr <= burst_addr(BUS_WORD_RANGE) & zero_byte_addr & zero_bus_addr;
                    wbyte_ena <= accumulated_byteena;
                    write_stall <= last_next_addr(BUS_WORD_RANGE) /= burst_addr(BUS_WORD_RANGE) and we;
    
                when WAITING_WR => 
                    -- we only stall when we want to wrire although the last write didnt finish
                    write_stall <= we;
                    wreq <= not wack;
                    waddr <= burst_addr(BUS_WORD_RANGE) & zero_byte_addr & zero_bus_addr;
                    wdata <= accumulated_bus_word;
                    wbyte_ena <= accumulated_byteena;
            end case;  
        else
            case writeback_state is
                when IDLE => 
                    if we and invalidation_state = IDLE and (last_next_addr /= last_wr_addr or sd /= last_sd) then
                        wreq <= true;
                        waddr <= last_next_addr(BUS_WORD_RANGE) & zero_byte_addr & zero_bus_addr;
                        
                        -- we apply the sd everywhere
                        for w in WORDS_PER_BUS - 1 downto 0 loop
                            wdata((w+1) * DATA_WIDTH - 1 downto w * DATA_WIDTH) <= sd;
                        end loop;
                    end if;

                    if BUS_WORDS_PER_LINE = 1 then
                         -- (we have one word per bus, no need to demux anything)
                        wbyte_ena <= byte_ena;
                    else
                        -- but we only byteenable the part we really want to write
                        for b in BYTES_PER_WORD - 1 downto 0 loop
                            -- only write the bytes we really want to write
                            wbyte_ena((WORDS_PER_BUS - to_integer(unsigned(last_next_addr(WORD_IN_BUS_WORD))) - 1) * BYTES_PER_WORD + b) <= byte_ena(b);
                        end loop;
                    end if;
    
                when COLLECT_DATA => null; -- we will never get here
    
                when WAITING_WR => 
                    -- we only stall when we want to wrire although the last write didnt finish
                    write_stall <= we;
                    wreq <= not wack;
                    waddr <= burst_addr(BUS_WORD_RANGE) & zero_byte_addr & zero_bus_addr;
                    -- we dont actually accumulate anything here - we just remember the data when we got the we in accumulated_bus_word
                    wdata <= accumulated_bus_word;
                    wbyte_ena <= accumulated_byteena;
            end case;   
        end if;
                  
    end process writeback_unit_output_p;



    invalidation_unit_state_p: process(clk, res_n) is
    begin
        if res_n /= '1' then
            invalidation_state <= RESET;
            invalidation_line_ix <= (others => '0');
        else
            if clk'event and clk = '1' then
                case invalidation_state is
                    when RESET => 
                        if unsigned(invalidation_line_ix) = LINES - 1 then
                            invalidation_state <= WAITS;
                        else
                            invalidation_line_ix <= std_logic_vector(unsigned(invalidation_line_ix) + 1);
                        end if;
                    when WAITS => 
                        invalidation_state <= IDLE;

                    when IDLE => 
                        if invalidate then
                            invalidation_state <= INVALIDATING;
                        end if;
                    when INVALIDATING => 
                        if unsigned(invalidation_line_ix) = LINES - 1 then
                            invalidation_state <= IDLE;
                        else
                            invalidation_line_ix <= std_logic_vector(unsigned(invalidation_line_ix) + 1);
                        end if;
                end case;
            end if;
        end if;
    end process invalidation_unit_state_p;

    invalidation_unit_output_p: process(all) is
    begin
        line_ix <= (others => '0');
        valid_bit_to_write <= (0 => '0');
        line_valid_bit_we <= '0';
        invalidation_active <= true;

        case invalidation_state is
            when RESET => 
                line_ix <= invalidation_line_ix;
                valid_bit_to_write <= (0 => '0');
                line_valid_bit_we <= '1';
            
            when WAITS => null; -- make sure our invalidation went through before we resume regular pipeline operation

            when IDLE => 
                -- for writing we use last_next_addr, for reading we use next_addr(we need to compensate one latency cycle)
                if line_hit and not isAllStd(bytes_we, '0') then line_ix <= last_next_addr(LINE_RANGE);  else  line_ix <= next_addr(LINE_RANGE); end if;
                valid_bit_to_write <= (0 => '1');
                line_valid_bit_we <= set_line_tag;
                invalidation_active <= false;

            when INVALIDATING => 
                line_ix <= invalidation_line_ix;
                valid_bit_to_write <= (0 => '0');
                line_valid_bit_we <= '1';
        end case;

    end process invalidation_unit_output_p;




    -- synthesis off
    if_check: process(clk, res_n, stall_int) is
        variable last_stall: boolean := false; 
        variable stall_we: boolean;
        variable stall_rd: boolean;
        variable stall_byteena: std_logic_vector(byte_ena'range);
        variable stall_sd: std_logic_vector(sd'range);
        variable stall_addr: std_logic_vector(last_next_addr'range);
        variable stall_next_addr: std_logic_vector(next_addr'range);
    begin
        if res_n = '0' then
            last_stall := false;
        else
            if (clk'event and clk = '0') then  
                if not (last_stall and stall)  or not stall_int then
                    stall_we := we;
                    stall_rd := rd;
                    stall_byteena := byte_ena;
                    stall_sd := sd;
                    stall_addr := last_next_addr;
                    stall_next_addr := next_addr;
                end if;

                assert  not stall_int or stall_we = we report "WE CHANGED DURING STALL!" severity failure;
                assert  not stall_int or stall_rd = rd report "RD CHANGED DURING STALL!" severity failure;
                assert  not stall_int or stall_sd = sd report "SD CHANGED DURING STALL!" severity failure;
                assert  not stall_int or stall_byteena = byte_ena  report "BYTE ENA CHANGED DURING STALL!" severity failure;
                --assert  not stall_int or stall_addr = addr  report "ADDR CHANGED DURING STALL!" severity failure;
                last_stall := stall;
            end if;
        end if;
    end process;
    -- synthesis on
END ARCHITECTURE behav;

