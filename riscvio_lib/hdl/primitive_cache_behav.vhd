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
LIBRARY ieee;
use IEEE.math_real.all;
use ieee.numeric_std.all;


ARCHITECTURE behav OF primitive_cache IS
    constant BYTE_WIDTH: positive := 8;
    constant LINES_LOG: natural := integer(ceil(log2(real(LINES))));
    constant WORDS_IN_LINE_LOG: natural := integer(ceil(log2(real(WORDS_IN_LINE))));
    constant ADDR_WIDTH_WORD: natural := integer(ceil(log2(real(DATA_WIDTH/BYTE_WIDTH))));
    constant TAG_WIDTH: natural := ADDR_WIDTH - LINES_LOG - WORDS_IN_LINE_LOG - ADDR_WIDTH_WORD;
    constant N: natural := WORDS_IN_LINE * DATA_WIDTH / BUS_WIDTH;
    constant BUS_PER_WORD: positive := BUS_WIDTH / DATA_WIDTH;
    constant BUS_PER_WORD_LOG: natural := integer(ceil(log2(real(BUS_PER_WORD))));

    constant zero_byte_addr: std_logic_vector(ADDR_WIDTH_WORD - 1 downto 0) := (others => '0');
    constant zero_bus_addr: std_logic_vector(BUS_PER_WORD_LOG - 1 downto 0)  := (others => '0');

    subtype word_T is std_logic_vector(DATA_WIDTH - 1 downto 0);

    type row_selected_words_T is array(WORDS_IN_LINE - 1 downto 0) of word_T;
    signal row_selected_words: row_selected_words_T;
    signal words_to_write: row_selected_words_T;


    type fill_state_T is (IDLE, PREPARING, LOADING, ALMOST_DONE, WAITING, WAIT_FOR_RELEASE);
    signal fill_state: fill_state_T;
    signal line_fill_ctr: natural range 0 to N + 1;
    signal last_line_fill_ctr: natural range 0 to N + 1;
    signal words_we_fill: std_logic_vector(WORDS_IN_LINE - 1 downto 0);
    signal set_line_tag: std_logic;
    signal words_to_write_fill: row_selected_words_T;

    type writeback_state_T is (IDLE, WAITING_FILL, WAITING_WR);
    signal writeback_state: writeback_state_T;
    signal words_we_write: std_logic_vector(WORDS_IN_LINE - 1 downto 0);
    signal words_to_write_write: row_selected_words_T;

    type invalidatiion_state_T is (RESET, IDLE, WAITS, INVALIDATING);
    signal invalidation_state: invalidatiion_state_T;
    signal invalidation_line_ix: std_logic_vector(LINES_LOG - 1 downto 0);
    signal line_valid_bit_write: std_logic;

    subtype TAG_IN_ADDR is natural range ADDR_WIDTH - 1 downto WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD + LINES_LOG;
    subtype LINE_IN_ADDR is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD + LINES_LOG - 1 downto WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD;
    subtype WORD_IN_ADDR is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD - 1 downto ADDR_WIDTH_WORD;
    subtype BUS_WORD_IN_ADDR is natural range WORDS_IN_LINE_LOG + ADDR_WIDTH_WORD - 1 downto ADDR_WIDTH_WORD + BUS_PER_WORD_LOG;

    signal line_ix: std_logic_vector(LINES_LOG - 1 downto 0);
    signal rd_word_ix: std_logic_vector(WORDS_IN_LINE_LOG - 1 downto 0);
    signal line_valid: std_logic_vector(0 downto 0);
    
    signal line_tag_selected: std_logic_vector(TAG_WIDTH - 1 downto 0);
    signal words_we: std_logic_vector(WORDS_IN_LINE - 1 downto 0);


    
    signal word_to_write: word_T;
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

    words_we <= words_we_fill when fill_state /= IDLE else words_we_write;
    words_to_write <= words_to_write_fill when fill_state /= IDLE else words_to_write_write;

    ld <= row_selected_words(to_integer(unsigned(addr(WORD_IN_ADDR))));
    line_hit <= line_tag_selected = addr(TAG_IN_ADDR) and line_valid = (0 => '1');

    stall <= (not line_hit and (rd or we)) or invalidation_state /= IDLE or writeback_state /= IDLE;
    
    word_to_write_fill_p: process(all) is
    begin

        words_to_write_fill <= (others => (others => '0'));

        if fill_state /= IDLE then
            for i in BUS_PER_WORD - 1 downto 0 loop
                words_to_write_fill((last_line_fill_ctr) * BUS_PER_WORD + i) <= rdata((i + 1)*DATA_WIDTH - 1 downto i*DATA_WIDTH);
            end loop;
        else

        end if;
    end process;



    fill_unit_state_p: process(clk, res_n) is
    begin
        if res_n = '0' then
            fill_state <= IDLE;
            line_fill_ctr <= 0;
            last_line_fill_ctr <= 0;
        else
            if clk'event and clk = '1' then
                last_line_fill_ctr <= line_fill_ctr;

                case fill_state is
                    when IDLE => 
                        if not line_hit and (rd or we) and invalidation_state = IDLE then
                            fill_state <= PREPARING;
                            line_fill_ctr <= 0;
                        end if;
                    when PREPARING => 
                        fill_state <= LOADING;
                    when LOADING =>
                        if not rack then
                            fill_state <= WAITING;
                            if line_fill_ctr /= 0 then
                                line_fill_ctr <= line_fill_ctr - 1;
                            end if;
                        elsif line_fill_ctr = N - 1 then
                            fill_state <= ALMOST_DONE;
                        else
                            line_fill_ctr <= line_fill_ctr + 1;
                        end if;
                    when ALMOST_DONE =>
                        if rack then
                            fill_state <= IDLE;
                            line_fill_ctr <= 0;
                        else
                            fill_state <= WAITING;
                        end if;
                    when WAITING => 
                        if rack and line_fill_ctr = N - 1 then
                            fill_state <= IDLE;
                            line_fill_ctr <= 0;
                        elsif rack then
                            fill_state <= PREPARING;
                            line_fill_ctr <= line_fill_ctr + 1;
                        end if;
                    when WAIT_FOR_RELEASE =>
                        if not (rd or we) then
                            fill_state <= IDLE;
                        end if;
                end case;
            end if;
        end if;
    end process;


    fill_unit_output_p: process(all) is
    begin
        rreq <= false;
        raddr <= (others => '0');
        set_line_tag <= '0';
        words_we_fill <= (others => '0');

        case fill_state is
            when IDLE =>
                null;
            when PREPARING =>
                rreq <= true;
                raddr <= addr(TAG_IN_ADDR) & addr(LINE_IN_ADDR) & std_logic_vector(to_unsigned(line_fill_ctr, WORDS_IN_LINE_LOG - BUS_PER_WORD_LOG)) & zero_byte_addr & zero_bus_addr;
            when LOADING | WAITING =>
                rreq <= true;
                raddr <= addr(TAG_IN_ADDR) & addr(LINE_IN_ADDR) & std_logic_vector(to_unsigned(line_fill_ctr, WORDS_IN_LINE_LOG - BUS_PER_WORD_LOG)) & zero_byte_addr & zero_bus_addr;
                
                set_line_tag <= '1' when line_fill_ctr = N - 1 and rack else '0';

                for i in BUS_PER_WORD - 1 downto 0 loop
                    words_we_fill((last_line_fill_ctr) * BUS_PER_WORD + i) <= '1' when rack else '0';
                end loop;

            when ALMOST_DONE => 
                set_line_tag <= '1';

                rreq <= true;
                raddr <= addr(TAG_IN_ADDR) & addr(LINE_IN_ADDR) & std_logic_vector(to_unsigned(line_fill_ctr, WORDS_IN_LINE_LOG - BUS_PER_WORD_LOG)) & zero_byte_addr & zero_bus_addr;

                for i in BUS_PER_WORD - 1 downto 0 loop
                    words_we_fill((last_line_fill_ctr) * BUS_PER_WORD + i) <= '1' when rack and line_fill_ctr /= 0 else '0';
                end loop;
            when WAIT_FOR_RELEASE =>
                    null;

        end case;
    end process;

    
    writeback_unit_state_p: process(clk, res_n) is
    begin
        if res_n = '0' then
            writeback_state <= IDLE;
        else
            if clk'event and clk = '1' then
                case writeback_state is
                    when IDLE => 
                        if we and not line_hit then
                            writeback_state <= WAITING_FILL;
                        elsif we then
                            writeback_state <= WAITING_WR;
                        end if;
                    when WAITING_FILL =>
                        if line_hit then
                            writeback_state <= WAITING_WR;
                        end if;
                    when WAITING_WR =>
                        if wack then
                            writeback_state <= IDLE;
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
        words_to_write_write <= (others => (others => '0'));
        words_we_write <= (others => '0');

        case writeback_state is
            when IDLE => 
                --if line_hit and we then
                --    word_to_write <= row_selected_words(to_integer(unsigned(addr(WORD_IN_ADDR))));
                --    for i in byte_ena'range loop
                --        if byte_ena(i) = '1' then
                --            word_to_write((i+1) * BYTE_WIDTH - 1 downto BYTE_WIDTH*i) <= sd((i+1) * BYTE_WIDTH - 1 downto BYTE_WIDTH*i);
                --        end if;
                --    end loop;
                --    words_to_write_write <= row_selected_words;
                --    words_to_write_write(to_integer(unsigned(addr(WORD_IN_ADDR)))) <= word_to_write;
--
                --    for i in BUS_PER_WORD - 1 downto 0 loop
                --        words_we_write(to_integer(unsigned(addr(WORD_IN_ADDR)))) <= '1';
                --    end loop;
--
                --    waddr <= addr;
                --    wreq <= true;
--
                --    for i in BUS_PER_WORD - 1 downto 0 loop
                --        wdata((i + 1)*DATA_WIDTH - 1 downto i*DATA_WIDTH) <= words_to_write_write((to_integer(unsigned(addr(BUS_WORD_IN_ADDR))) + i) * BUS_PER_WORD - 1);
                --    end loop;
                --end if;
                null;

            when WAITING_FILL =>
                if line_hit then
                    word_to_write <= row_selected_words(to_integer(unsigned(addr(WORD_IN_ADDR))));
                    for i in byte_ena'range loop
                        if byte_ena(i) = '1' then
                            word_to_write((i+1) * BYTE_WIDTH - 1 downto BYTE_WIDTH*i) <= sd((i+1) * BYTE_WIDTH - 1 downto BYTE_WIDTH*i);
                        end if;
                    end loop;
                    words_to_write_write <= row_selected_words;
                    words_to_write_write(to_integer(unsigned(addr(WORD_IN_ADDR)))) <= word_to_write;

                    for i in BUS_PER_WORD - 1 downto 0 loop
                        words_we_write(to_integer(unsigned(addr(WORD_IN_ADDR)))) <= '1';
                    end loop;

                    waddr <= addr(addr'left downto BUS_PER_WORD_LOG + ADDR_WIDTH_WORD) & zero_byte_addr & zero_bus_addr;
                    wreq <= not wack;

                    for i in BUS_PER_WORD - 1 downto 0 loop
                        wdata((i + 1)*DATA_WIDTH - 1 downto i*DATA_WIDTH) <= words_to_write_write((to_integer(unsigned(addr(BUS_WORD_IN_ADDR)))) * BUS_PER_WORD + i);
                    end loop;
                end if;

            when WAITING_WR => 
                word_to_write <= row_selected_words(to_integer(unsigned(addr(WORD_IN_ADDR))));
                for i in byte_ena'range loop
                    if byte_ena(i) = '1' then
                        word_to_write((i+1) * BYTE_WIDTH - 1 downto BYTE_WIDTH*i) <= sd((i+1) * BYTE_WIDTH - 1 downto BYTE_WIDTH*i);
                    end if;
                end loop;
                words_to_write_write <= row_selected_words;
                words_to_write_write(to_integer(unsigned(addr(WORD_IN_ADDR)))) <= word_to_write;


                waddr <= addr(addr'left downto BUS_PER_WORD_LOG + ADDR_WIDTH_WORD) & zero_byte_addr & zero_bus_addr;
                wreq <= not wack;

                for i in BUS_PER_WORD - 1 downto 0 loop
                    wdata((i + 1)*DATA_WIDTH - 1 downto i*DATA_WIDTH) <= words_to_write_write((to_integer(unsigned(addr(BUS_WORD_IN_ADDR)))) * BUS_PER_WORD + i);
                end loop;

                
        end case;
    end process;



    invalidation_unit_state_p: process(clk, res_n) is
    begin
        if res_n = '0' then
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
                line_ix <= next_addr(LINE_IN_ADDR);
                valid_bit_to_write <= (0 => '1');
                line_valid_bit_write <= set_line_tag;

            when INVALIDATING => 
                line_ix <= invalidation_line_ix;
                valid_bit_to_write <= (0 => '0');
                line_valid_bit_write <= '1';
        end case;

    end process;

END ARCHITECTURE behav;

