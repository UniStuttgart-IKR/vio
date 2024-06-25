--
-- VHDL Architecture riscvio_lib.dc_wrapper.mixed
--
-- Created:
--          by - leylknci.meyer (pc024)
--          at - 14:23:46 06/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY riscvio_lib;
USE riscvio_lib.primitive_cache;
USE riscvio_lib.caches.all;
LIBRARY ieee;
USE ieee.numeric_std.all;


ARCHITECTURE mixed OF dc_wrapper IS
    signal caddr: word_T;
    signal cnext_addr: word_T;
    signal sd: word_T;
    signal sd_pipeline: word_T;
    signal ld_word: word_T;
    signal wena: boolean;
    signal rena: boolean;
    signal bena_pipeline: std_logic_vector(3 downto 0);
    signal bena: std_logic_vector(3 downto 0);
BEGIN
    dcache: entity primitive_cache
        generic map (
            BUS_WIDTH => BUS_WIDTH,
            WORDS_IN_LINE => DC_LINE_WIDTH,
            LINES => DC_LINES,
            ADDR_WIDTH => 32,
            DATA_WIDTH => 32
        )
        port map (
            clk       => clk,
            res_n     => res_n,
            stall     => stall,
            addr      => caddr,
            next_addr => cnext_addr,
            rd        => rena,
            we        => wena or obj_init_wr,
            byte_ena  => bena,

            ld        => ld_word,
            sd        => sd,


            rreq      => rreq,
            rack      => rack,
            raddr     => raddr,
            rdata     => rdata,


            wreq      => wreq,
            wack      => wack,
            waddr     => waddr,
            wdata     => wdata
        );


    sd <= obj_init_data when obj_init_wr else sd_pipeline;
    caddr <= obj_init_addr when obj_init_wr else addr;
    cnext_addr <= next_obj_init_addr when obj_init_wr else next_addr;
    bena <= (others => '1') when obj_init_wr else bena_pipeline;
    
    

    read_p: process (all) is
    begin  
        -- assign default values
        ld        <= (others => '0');
        rena           <= true;
        
        case mode is
            when lb =>
            
            case next_addr(1 downto 0) is
            when "00" =>
                ld              <= (others => ld_word(BYTE0_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE0_RANGE);
                        
            when "01" =>
                ld              <= (others => ld_word(BYTE1_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE1_RANGE);
                            
            when "10" =>
                ld              <= (others => ld_word(BYTE2_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE2_RANGE);
                        
            when "11" =>
                ld              <= (others => ld_word(BYTE3_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE3_RANGE);
            
            when others =>
                null;
                
            end case;
            
        when lbu =>
            case next_addr(1 downto 0) is
            when "00" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE0_RANGE); 
                    
            when "01" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE1_RANGE);
                            
            when "10" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE2_RANGE);
                        
            when "11" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE3_RANGE);
                        
            when others =>
                null;
                
            end case;
            
        when lh =>
            case next_addr(1) is
            when '0' =>
                ld               <= (others => ld_word(HWORD0_RANGE'high));
                ld(HWORD0_RANGE) <= ld_word(HWORD0_RANGE);
                            
            when '1' =>
                ld               <= (others => ld_word(HWORD1_RANGE'high));
                ld(HWORD0_RANGE) <= ld_word(HWORD1_RANGE);
                                
            when others => 
                null;
            
            end case;
            
        when lhu =>
            case next_addr(1) is
            when '0' =>
                ld(HWORD0_RANGE) <= ld_word(HWORD0_RANGE);
                            
            when '1' =>
                ld(HWORD0_RANGE) <= ld_word(HWORD1_RANGE);
                            
            when others => 
                null;
                
            end case;

        when lw | lp | load_rcd | load_rix =>
            ld <= ld_word;

        when others =>
            rena <= false;
        end case;
    end process read_p;



        -- write to IO Buffer
    write_p: process (all) is
    begin
        -- assign default values
        bena_pipeline      <= (others => '1');
        sd_pipeline <= (others => '0');
        wena <= true;
        
        case mode is
        when sb =>
            bena_pipeline(to_integer(unsigned(addr(1 downto 0)))) <= '1';
            sd_pipeline(BYTE0_RANGE) <= sd_raux.val(BYTE0_RANGE);
            sd_pipeline(BYTE1_RANGE) <= sd_raux.val(BYTE0_RANGE);
            sd_pipeline(BYTE2_RANGE) <= sd_raux.val(BYTE0_RANGE);
            sd_pipeline(BYTE3_RANGE) <= sd_raux.val(BYTE0_RANGE);

            
        when sh =>
            bena_pipeline <= "1100" when next_addr(1) = '1' else "0011";
            sd_pipeline <= sd_raux.val(HWORD0_RANGE) 
                & sd_raux.val(HWORD0_RANGE);
                
        when sw =>
            bena_pipeline <= (others => '1');
            sd_pipeline <= sd_raux.val;

        when sp | store_rcd =>
            bena_pipeline <= (others => '1');
            sd_pipeline <= sd_raux.val;

        when store_rix =>
            bena_pipeline <= (others => '1');
            sd_pipeline <= sd_rdat.val;
            

        when others =>
            wena <= false;
        end case;
        
    end process write_p;   
END ARCHITECTURE mixed;

