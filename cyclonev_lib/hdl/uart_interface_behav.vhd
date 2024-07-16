LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY ieee;
USE ieee.numeric_std.all;

ARCHITECTURE behav OF uart_interface IS
    signal uart_rx_data: byte_T;
    signal uart_tx_data: byte_T;
    signal uart_rx_data_avail: std_logic;
    signal clear_uart_rx_avail: boolean;
    signal uart_tx_ready: std_logic;
    signal uart_send_data: boolean;
    signal uart_sending: std_logic;
BEGIN
    uart_regs_p: process(clk, res_n) is
    begin
        if res_n = '0' then
            uart_rx_data <= (others => '0');
            uart_tx_data <= (others => '0');
            uart_sending <= '0';
            uart_rx_data_avail <= '0';
            data_stream_in_stb <= '0';
        else
            if clk'event and clk = '1' then

                -- data received via uart
                if data_stream_out_stb then
                    uart_rx_data <= data_stream_out;
                    uart_rx_data_avail <= '1';
                end if;

                if clear_uart_rx_avail and uart_rx_data_avail = '1' then
                    uart_rx_data_avail <= '0';
                end if;

                -- data sent via uart
                if uart_send_data and uart_sending = '0' then
                    uart_tx_data <= uart_wdata(byte_T'range);
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
    
    process(all) is
    begin
        clear_uart_rx_avail <= false;
        uart_rdata <= (others => '0');
        uart_send_data <= false;
        uart_stall <= '0';
        
        if uart_active then
            case uart_mode is
                when sb => 
                    case to_integer(unsigned(uart_ix)) is
                        when 0 => 
                            uart_send_data <= true;
                            uart_stall <= uart_sending;
                        when others => null;
                    end case;
                when lb | lbu =>
                    case to_integer(unsigned(uart_ix)) is
                        when 0 => 
                            clear_uart_rx_avail <= true;
                            if uart_mode = lbu then
                                uart_rdata <= (others => '0');
                            else
                                uart_rdata <= (others => uart_rx_data(byte_T'high));
                            end if;
                            uart_rdata(byte_T'range) <= uart_rx_data;

                            uart_rdata <= (others => '0');
                            uart_rdata(byte_T'range) <= uart_rx_data;

                            uart_stall <= not uart_rx_data_avail;
                        when 1 => 
                            uart_rdata <= (0 => uart_rx_data_avail, 1 => not uart_sending, others => '0');
                        when others => null;
                    end case;
                when lh | lhu | lw =>
                    uart_rdata <= (others => '0');
                    uart_rdata(9 downto 0) <= uart_rx_data_avail & not uart_sending & uart_rx_data;
                when others => null;
                end case;

        end if;
    end process;

END ARCHITECTURE behav;