--
-- VHDL Architecture riscvio_lib.io_mux.behav
--
-- Created:
--          by - surfer.UNKNOWN (SURFER-A0000001)
--          at - 15:52:32 30.06.2024
--
-- using Mentor Graphics HDL Designer(TM) 2021.1 Built on 14 Jan 2021 at 15:11:42
--
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF io_mux IS
    constant UART_DEV: std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(1, 12));
    constant LEDS_DEV: std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(2, 12));
    signal uart_rx_data: byte_T;
    signal uart_tx_data: byte_T;
    signal uart_rx_data_avail: std_logic;
    signal clear_uart_rx_avail: boolean;
    signal uart_tx_ready: std_logic;
    signal uart_send_data: boolean;
    signal uart_sending: std_logic;

    type boolean_vector is array(natural range <>) of boolean;

    signal segments_we: boolean_vector(3 downto 0);
    signal write_led_data: boolean;
BEGIN
    uart_regs_p: process(clk, res_n) is
    begin
        if res_n = '0' then
            uart_rx_data <= (others => '0');
            uart_tx_data <= (others => '0');
            uart_sending <= '0';
        else
            if clk'event and clk = '1' then

                -- data received via uart
                if data_stream_out_stb then
                    uart_rx_data <= data_stream_out;
                    uart_rx_data_avail <= '0';
                end if;

                if clear_uart_rx_avail then
                    uart_rx_data_avail <= '1';
                end if;

                -- data sent via uart
                if uart_send_data and uart_sending = '0' then
                    uart_tx_data <= io_wdata(byte_T'range);
                    data_stream_in_stb <= '1';
                    uart_sending <= '1';
                end if;
                
                if uart_sending = '1' and data_stream_in_ack = '1' then
                    data_stream_in_stb <= '0';
                end if;
                
                if uart_sending = '1' and data_stream_in_done = '1' and data_stream_in_stb = '0' then
                    uart_sending <= '0';
                end if;

            end if;
        end if;
    end process uart_regs_p;


    data_stream_in <= uart_tx_data;


    leds_reg: process(clk, res_n) is 
    begin
        if res_n = '0' then
            leds <= (0 => '1', others => '0');
            seven_seg_0 <= (others => '0');
            seven_seg_1 <= (others => '0');
            seven_seg_2 <= (others => '0');
            seven_seg_3 <= (others => '0');
        else
            if clk'event and clk = '1' then
                if write_led_data then
                    leds <= io_wdata(BYTE0_RANGE);
                end if;

                seven_seg_0 <= std_logic_vector(unsigned(seven_seg_0) + 1);

                
                if segments_we(0) then
                    seven_seg_0 <= io_wdata(BYTE0_RANGE);
                end if;

                if segments_we(1) then
                    seven_seg_1 <= io_wdata(BYTE0_RANGE);
                end if;

                if segments_we(2) then
                    seven_seg_2 <= io_wdata(BYTE0_RANGE);
                end if;

                if segments_we(3) then
                    seven_seg_3 <= io_wdata(BYTE0_RANGE);
                end if;
            end if;
        end if;
    end process;
    
    process(all) is
    begin
        clear_uart_rx_avail <= false;
        io_rdata <= (others => '0');
        uart_send_data <= false;
        write_led_data <= false;
        io_stall <= '0';
        segments_we <= (others => false);

        case io_dev is
            when UART_DEV => 
                case io_mode is
                    when sb => 
                        case to_integer(unsigned(io_ix)) is
                            when 0 => 
                                uart_send_data <= true;
                                io_stall <= uart_sending;
                            when others => null;
                        end case;
                    when lb =>
                        case to_integer(unsigned(io_ix)) is
                            when 0 => 
                                clear_uart_rx_avail <= true;
                                io_rdata <= (others => '0');
                                io_rdata(byte_T'range) <= uart_rx_data;

                                io_rdata <= (others => '0');
                                io_rdata(byte_T'range) <= uart_rx_data;

                                io_stall <= not uart_rx_data_avail;
                            when 1 => 
                                io_rdata <= (8 => uart_rx_data_avail, 9 => not uart_sending, others => '0');
                            when others => null;
                        end case;
                    when others =>
                        null;
                end case;


            when LEDS_DEV => 
                case io_mode is
                    when sb => 
                        case to_integer(unsigned(io_ix)) is
                            when 0 => 
                                write_led_data <= true;
                            when 1 => 
                                segments_we(0) <= true;
                            when 2 => 
                                segments_we(1) <= true;
                            when 3 => 
                                segments_we(2) <= true;
                            when 4 => 
                                segments_we(3) <= true;
                            when others => null;
                        end case;
                        
                    when others => null;
                end case;
            when others => null;
        end case;
    end process;

END ARCHITECTURE behav;

--      Synchronous reset.  
-- data_stream_in
--      Input data bus for bytes to transmit.
-- data_stream_in_stb
--      Input strobe to qualify the input data bus.
-- data_stream_in_ack
--      Output acknowledge to indicate the UART has begun sending the byte
--      provided on the data_stream_in port.
-- data_stream_out
--      Data output port for received bytes.
-- data_stream_out_stb
--      Output strobe to qualify the received byte. Will be valid for one clock
--      cycle only. 