ARCHITECTURE behav OF seven_seg_interface IS
BEGIN    

    leds_reg: process(clk, res_n) is 
    begin
        if res_n = '0' then
            --leds <= (others => '0');
            nib0 <= (others => '0');
            nib1 <= (others => '0');
            nib2 <= (others => '0');
            nib3 <= (others => '0');
        else
            if clk'event and clk = '1' then
                -- if write_led_data then
                --     leds <= io_wdata(BYTE0_RANGE);
                -- end if;
                case seven_mode is
                    when sb => 
                        case to_integer(unsigned(seven_ix)) is
                            when 0 => 
                                nib0 <= seven_wdata(3 downto 0);
                                nib1 <= seven_wdata(7 downto 4);
                            when 1 => 
                                nib0 <= seven_wdata(3 downto 0);
                                nib1 <= seven_wdata(7 downto 4);
                            when others => null;
                        end case;
                    when sh =>
                            nib0 <= seven_wdata(3 downto 0);
                            nib1 <= seven_wdata(7 downto 4);
                            nib2 <= seven_wdata(11 downto 8);
                            nib3 <= seven_wdata(15 downto 12);

                    when others => null;
                end case;
            end if;
        end if;
    end process;

    seven_stall <= '0';
    seven_rdata <= (others => '0');


END ARCHITECTURE behav;

