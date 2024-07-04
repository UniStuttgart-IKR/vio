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


ARCHITECTURE behav OF primitive_cache IS
    constant BYTE_WIDTH: positive := 8;
    constant LINES_LOG: natural := integer(ceil(log2(real(LINES))));
    constant WORDS_IN_LINE_LOG: natural := integer(ceil(log2(real(WORDS_IN_LINE))));
    constant ADDR_WIDTH_WORD: natural := integer(ceil(log2(real(DATA_WIDTH/BYTE_WIDTH))));
    constant TAG_WIDTH: natural := ADDR_WIDTH - LINES_LOG - WORDS_IN_LINE_LOG - ADDR_WIDTH_WORD;
    constant N: natural := (WORDS_IN_LINE * DATA_WIDTH) / BUS_WIDTH; -- if this is zero, BUS_WIDTH > LINE_WIDTH*DATA_WIDTH (in bits)
    constant Q_LOG: integer := maxOf2(integer(ceil(log2(real(BUS_WIDTH) / real(WORDS_IN_LINE * DATA_WIDTH)))), 0);  
    constant WORDS_PER_BUS: positive := BUS_WIDTH / DATA_WIDTH;
    constant WORDS_PER_BUS_LOG: natural := integer(ceil(log2(real(WORDS_PER_BUS))));
    constant BYTES_PER_WORD: natural := DATA_WIDTH / BYTE_WIDTH;

    constant zero_byte_addr: std_logic_vector(ADDR_WIDTH_WORD - 1 downto 0) := (others => '0');
    constant zero_bus_addr: std_logic_vector(WORDS_PER_BUS_LOG - 1 downto 0)  := (others => '0');

    subtype word_T is std_logic_vector(DATA_WIDTH - 1 downto 0);
    type bus_word_T is array(WORDS_PER_BUS - 1 downto 0) of word_T;

    type row_selected_words_T is array(WORDS_IN_LINE - 1 downto 0) of word_T;
    signal row_selected_words: row_selected_words_T;
    signal words_to_write: row_selected_words_T;


    type fill_state_T is (IDLE, PREPARING, LOADING, ALMOST_DONE, WAITING);
    signal fill_state: fill_state_T;
    signal line_fill_ctr: natural range 0 to N + 1;
    signal last_line_fill_ctr: natural range 0 to N + 1;
    signal set_line_tag: std_logic;


    type writeback_state_T is (IDLE, WAITING_WR, COLLECT_DATA);
    signal writeback_state: writeback_state_T;
    signal bus_word_to_write: std_logic_vector(BUS_WIDTH - 1 downto 0);
    signal last_words_to_write_write: row_selected_words_T;
    signal last_wr_addr: std_logic_vector(addr'range);
    signal burst_addr: std_logic_vector(addr'range);
    signal last_sd: std_logic_vector(sd'range);
    signal write_stall: boolean;
    signal bytes_to_write: std_logic_vector(BUS_WIDTH/8 - 1 downto 0);

    type invalidatiion_state_T is (RESET, IDLE, WAITS, INVALIDATING);
    signal invalidation_state: invalidatiion_state_T;
    signal invalidation_line_ix: std_logic_vector(LINES_LOG - 1 downto 0);
    signal line_valid_bit_write: std_logic;

    subtype TAG_IN_ADDR is natural range ADDR_WIDTH - 1 downto WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD + LINES_LOG;
    subtype LINE_IN_ADDR is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD + LINES_LOG - 1 downto WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD;
    subtype WORD_IN_ADDR is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD - 1 downto ADDR_WIDTH_WORD;
    subtype BUS_WORD_IN_LINE is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD - 1 downto ADDR_WIDTH_WORD + WORDS_PER_BUS_LOG;
    subtype BUS_WORD_IX_IN_ADDR is natural range ADDR_WIDTH - 1 downto ADDR_WIDTH_WORD + WORDS_PER_BUS_LOG ;
    subtype WORD_IN_BUS_WORD is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD + WORDS_PER_BUS_LOG - 1downto WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD;
    subtype BYTE_IN_BUS_WORD is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD - 1 downto 0;

    signal line_ix: std_logic_vector(LINES_LOG - 1 downto 0);
    signal line_valid: std_logic_vector(0 downto 0);
    
    signal line_tag_selected: std_logic_vector(TAG_WIDTH - 1 downto 0);
    signal words_we: std_logic_vector(WORDS_IN_LINE - 1 downto 0);

    signal line_hit: boolean;
    signal valid_bit_to_write: std_logic_vector(0 downto 0);
    
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
        we    => line_valid_bit_write,
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
        wdata => addr(TAG_IN_ADDR),
        we    => set_line_tag,
        rdata => line_tag_selected
      );

    

    cache_rows: for r in WORDS_IN_LINE - 1 downto 0 generate
    begin
        row_mem_i: entity simple_dual_port_ram
          generic map (
            ADDR_WIDTH => LINES_LOG,
            DATA_WIDTH => DATA_WIDTH
          )
          port map(
            clk   => clk,
            raddr => line_ix,
            waddr => line_ix,
            wdata => words_to_write(r),
            we    => words_we(r),
            rdata => row_selected_words(r)
          );
    end generate;


    ld <= row_selected_words(to_integer(unsigned(addr(WORD_IN_ADDR))));
    line_hit <= line_tag_selected = addr(TAG_IN_ADDR) and line_valid = (0 => '1');

    stall <= ((not line_hit or fill_state /= IDLE) and rd) or invalidation_state /= IDLE or write_stall;
    
    fill_unit_state_p: process(clk, res_n) is
    begin
        if res_n /= '1' then
            fill_state <= IDLE;
            line_fill_ctr <= 0;
            last_line_fill_ctr <= 0;
        else
            if clk'event and clk = '1' then
                last_line_fill_ctr <= line_fill_ctr;

                case fill_state is
                    when IDLE => 
                        if not line_hit and (rd or we) and invalidation_state = IDLE and fill_state = IDLE then
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
                        elsif line_fill_ctr = N - 1 then
                            fill_state <= ALMOST_DONE;
                        else
                            if N /= 0 then
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
                        if rack and line_fill_ctr = N - 1 then
                            fill_state <= IDLE;
                            line_fill_ctr <= 0;
                        elsif rack then
                            if N /= 0 then
                                fill_state <= PREPARING;
                                line_fill_ctr <= line_fill_ctr + 1;
                            else
                                fill_state <= IDLE;
                            end if;
                        end if;
                end case;
            end if;
        end if;
    end process;


    fill_unit_output_p: process(all) is
        variable used_line_ctr: natural range 0 to N + 1;
        variable used_addr: std_logic_vector(addr'range);
    begin
        rreq <= false;
        raddr <= (others => '0');
        set_line_tag <= '0';
        words_we <= (others => '0');
        if (fill_state = LOADING or fill_state = PREPARING) and not rack then used_line_ctr := last_line_fill_ctr; else used_line_ctr := line_fill_ctr; end if;
        if (fill_state = LOADING or fill_state = PREPARING) and not rack then used_addr := last_wr_addr; else used_addr := addr; end if;

        
        if fill_state /= IDLE or (not line_hit and rd and invalidation_state = IDLE) then
            if N /= 0 then
                raddr <= used_addr(TAG_IN_ADDR) & addr(LINE_IN_ADDR) & std_logic_vector(to_unsigned(used_line_ctr, WORDS_IN_LINE_LOG - WORDS_PER_BUS_LOG)) & zero_byte_addr & zero_bus_addr;
            else
                raddr <= addr(addr'left downto LINE_IN_ADDR'right + Q_LOG) & zero_byte_addr & zero_bus_addr;
            end if;
            rreq <= true;
        end if;

        case fill_state is
            when IDLE | PREPARING =>
                if not line_hit and rd and invalidation_state = IDLE and fill_state = IDLE  then
                    rreq <= true;
                end if;

            when LOADING | WAITING | ALMOST_DONE =>
                if (line_fill_ctr = N - 1 or N = 0) and rack then set_line_tag <= '1'; else set_line_tag <= '0'; end if;
                
                if rack then
                    if N /= 0 then
                        for i in WORDS_PER_BUS - 1 downto 0 loop
                            words_we((last_line_fill_ctr) * WORDS_PER_BUS + i) <= '1';
                        end loop;
                    else
                        words_we(0) <= '1';
                    end if;
                end if;
        end case;

        words_to_write <= (others => (others => '0'));

        if fill_state /= IDLE then
            if N /= 0 then
                for i in WORDS_PER_BUS - 1 downto 0 loop
                    words_to_write((last_line_fill_ctr) * WORDS_PER_BUS + i) <= rdata((i + 1)*DATA_WIDTH - 1 downto i*DATA_WIDTH);
                end loop;
            else
                words_to_write(0) <= rdata((to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + 1)*DATA_WIDTH - 1 downto to_integer(unsigned(addr(WORD_IN_BUS_WORD)))*DATA_WIDTH);
            end if;
        end if;
    end process;

    
    writeback_unit_state_p: process(clk, res_n) is
    begin
        if res_n /= '1' then
            writeback_state <= IDLE;
            last_sd <= (others => '0');
            last_wr_addr <= (others => '0');
            burst_addr <= (others => '0');
            bytes_to_write <= (others => '0');
            bus_word_to_write <= (others => '0');
        else
            if clk'event and clk = '1' then
                case writeback_state is
                    when IDLE => 
                        if we and (addr /= last_wr_addr or sd /= last_sd) then
                            last_sd <= sd;
                            last_wr_addr <= addr;
                            
                            for i in BYTES_PER_WORD - 1 downto 0 loop
                                bytes_to_write(to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i) <= bytes_to_write(to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i) or byte_ena(i);
                            end loop;

                            for i in BYTES_PER_WORD - 1 downto 0 loop
                                if byte_ena(i) = '1' then
                                    bytes_to_write(to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i) <= '1';
                                    bus_word_to_write((to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i + 1) * BYTE_WIDTH - 1 downto (to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i) * 8) <= sd((i + 1) * BYTE_WIDTH - 1 downto i * BYTE_WIDTH); 
                                end if;
                            end loop;

                            writeback_state <= COLLECT_DATA;
                            burst_addr <= addr;
                        end if;
                    
                    when COLLECT_DATA => 
                        if we then
                            last_sd <= sd;
                            last_wr_addr <= addr;

                            for i in BYTES_PER_WORD - 1 downto 0 loop
                                bytes_to_write(to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i) <= bytes_to_write(to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i) or byte_ena(i);
                            end loop;

                            for i in BYTES_PER_WORD - 1 downto 0 loop
                                if byte_ena(i) = '1' then
                                    bytes_to_write(to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i) <= bytes_to_write(to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i) or byte_ena(i);
                                    bus_word_to_write((to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i + 1) * BYTE_WIDTH - 1 downto (to_integer(unsigned(addr(WORD_IN_BUS_WORD))) + i) * 8) <= sd((i + 1) * BYTE_WIDTH - 1 downto i * BYTE_WIDTH); 
                                end if;
                            end loop;
                        end if;

                        if addr(BUS_WORD_IX_IN_ADDR) /= burst_addr(BUS_WORD_IX_IN_ADDR) then
                            writeback_state <= WAITING_WR;
                        end if; 
                        
                    when WAITING_WR =>
                        if wack then
                            writeback_state <= IDLE;
                            bytes_to_write <= (others => '0');
                            burst_addr <= (others => '0');
                            bus_word_to_write <= (others => '0');
                        end if;
                end case;
            end if;
        end if;
    end process;

    writeback_unit_output_p: process(all) is
    begin
        waddr <= (others => '0');
        wreq <= false;
        wdata <= (others => '0');
        write_stall <= false;
        wbyte_ena <= (others => '0');


        case writeback_state is
            when IDLE => 
            when COLLECT_DATA => 
                wreq <= addr(BUS_WORD_IX_IN_ADDR) /= burst_addr(BUS_WORD_IX_IN_ADDR);
                wdata <= bus_word_to_write;
                waddr <= burst_addr(BUS_WORD_IX_IN_ADDR) & zero_byte_addr & zero_bus_addr;
                wbyte_ena <= bytes_to_write;
            when WAITING_WR => 
                write_stall <= not wack;
                wreq <= not wack;
                wdata <= bus_word_to_write;
                waddr <= burst_addr(BUS_WORD_IX_IN_ADDR) & zero_byte_addr & zero_bus_addr;
                wbyte_ena <= bytes_to_write;
        end case;             
    end process;



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
    end process;

    invalidation_unit_output_p: process(all) is
    begin
        line_ix <= (others => '0');
        valid_bit_to_write <= (0 => '0');
        line_valid_bit_write <= '0';

        case invalidation_state is
            when RESET => 
                line_ix <= invalidation_line_ix;
                valid_bit_to_write <= (0 => '0');
                line_valid_bit_write <= '1';
            
            when WAITS => null;

            when IDLE => 
                if line_hit and not isAllStd(words_we, '0') then line_ix <= addr(LINE_IN_ADDR);  else  line_ix <= next_addr(LINE_IN_ADDR); end if;
                valid_bit_to_write <= (0 => '1');
                line_valid_bit_write <= set_line_tag;

            when INVALIDATING => 
                line_ix <= invalidation_line_ix;
                valid_bit_to_write <= (0 => '0');
                line_valid_bit_write <= '1';
        end case;

    end process;

END ARCHITECTURE behav;

