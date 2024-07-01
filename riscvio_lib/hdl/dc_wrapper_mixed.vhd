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
USE riscvio_lib.pipeline.all;
LIBRARY ieee;
USE ieee.numeric_std.all;


ARCHITECTURE mixed OF dc_wrapper IS
    signal caddr: word_T;
    signal cnext_addr: word_T;
    signal sd: dword_T;
    signal sd_pipeline: dword_T;
    signal ld_word: dword_T;
    signal wena: boolean;
    signal rena: boolean;
    signal bena_pipeline: std_logic_vector(7 downto 0);
    signal bena: std_logic_vector(7 downto 0);
    signal stall_int: boolean;
BEGIN
  dcache: entity riscvio_lib.primitive_cache
    generic map (
        BUS_WIDTH => BUS_WIDTH,
        WORDS_IN_LINE => DC_LINE_WIDTH,
        LINES => DC_LINES,
        ADDR_WIDTH => 32,
        DATA_WIDTH => 64,
        LEVERAGE_BURSTS => false
    )
    port map (
        clk       => clk,
        res_n     => res_n,
        stall     => stall_int,
        addr      => caddr,
        next_addr => cnext_addr,
        rd        => rena and not addr.io_access,
        we        => (wena or obj_init_wr) and not addr.io_access,
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

    stall_bool <= stall_int;
    stall <= '1' when stall_int else 'Z';
    sd <= obj_init_data when obj_init_wr else sd_pipeline;
    caddr <= obj_init_addr when obj_init_wr else addr.addr;
    cnext_addr <= next_obj_init_addr when obj_init_wr else next_addr.addr;
    bena <= (others => '1') when obj_init_wr else bena_pipeline;

    read_p: process (all) is
    begin  
        ld        <= (others => '0');
        rena           <= true;
        
        case mode is
        when lb =>
            case addr.addr(2 downto 0) is
            when "000" =>
                ld              <= (others => ld_word(BYTE0_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE0_RANGE);             
            when "001" =>
                ld              <= (others => ld_word(BYTE1_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE1_RANGE);     
            when "010" =>
                ld              <= (others => ld_word(BYTE2_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE2_RANGE);       
            when "011" =>
                ld              <= (others => ld_word(BYTE3_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE3_RANGE);
            when "100" =>
                ld              <= (others => ld_word(BYTE4_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE4_RANGE);             
            when "101" =>
                ld              <= (others => ld_word(BYTE5_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE5_RANGE);     
            when "110" =>
                ld              <= (others => ld_word(BYTE6_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE6_RANGE);       
            when "111" =>
                ld              <= (others => ld_word(BYTE7_RANGE'high));
                ld(BYTE0_RANGE) <= ld_word(BYTE7_RANGE);
            when others =>
                null;
            end case;

        when lbu =>
            case addr.addr(2 downto 0) is
            when "000" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE0_RANGE); 
            when "001" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE1_RANGE);            
            when "010" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE2_RANGE);   
            when "011" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE3_RANGE);
            when "100" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE4_RANGE); 
            when "101" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE5_RANGE);            
            when "110" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE6_RANGE);   
            when "111" =>
                ld(BYTE0_RANGE) <= ld_word(BYTE7_RANGE);
            when others =>
                null;
            end case;
            
        when lh =>
            case addr.addr(2 downto 1) is
            when "00" =>
                ld               <= (others => ld_word(HWORD0_RANGE'high));
                ld(HWORD0_RANGE) <= ld_word(HWORD0_RANGE);             
            when "01" =>
                ld               <= (others => ld_word(HWORD1_RANGE'high));
                ld(HWORD0_RANGE) <= ld_word(HWORD1_RANGE);     
            when "10" =>
                ld               <= (others => ld_word(HWORD2_RANGE'high));
                ld(HWORD0_RANGE) <= ld_word(HWORD2_RANGE);       
            when "11" =>
                ld               <= (others => ld_word(HWORD3_RANGE'high));
                ld(HWORD0_RANGE) <= ld_word(HWORD3_RANGE);
            when others => 
                null;
            end case;
            
        when lhu =>
            case addr.addr(2 downto 1) is
            when "00" =>
                ld(HWORD0_RANGE) <= ld_word(HWORD0_RANGE);             
            when "01" =>
                ld(HWORD0_RANGE) <= ld_word(HWORD1_RANGE);     
            when "10" =>
                ld(HWORD0_RANGE) <= ld_word(HWORD2_RANGE);       
            when "11" =>
                ld(HWORD0_RANGE) <= ld_word(HWORD3_RANGE);
            when others => 
                null;
            end case;

        when lw | lp =>
            case addr.addr(2) is
            when '0' =>
                ld(WORD0_RANGE) <= ld_word(WORD0_RANGE);
            when '1' =>
                ld(WORD0_RANGE) <= ld_word(WORD1_RANGE);
            when others => 
                null;
            end case;

        when load_rpc =>
            ld <= ld_word;

        when others =>
            rena <= false;
        end case;
    end process read_p;


    write_p: process (all) is
    begin
        bena_pipeline   <= (others => '1');
        sd_pipeline     <= (others => '0');
        wena            <= true;
        
        case mode is
        when sb =>
            bena_pipeline(to_integer(unsigned(addr.addr(2 downto 0)))) <= '1';
            sd_pipeline(BYTE0_RANGE) <= sd_raux.val(BYTE0_RANGE);
            sd_pipeline(BYTE1_RANGE) <= sd_raux.val(BYTE0_RANGE);
            sd_pipeline(BYTE2_RANGE) <= sd_raux.val(BYTE0_RANGE);
            sd_pipeline(BYTE3_RANGE) <= sd_raux.val(BYTE0_RANGE);
            sd_pipeline(BYTE4_RANGE) <= sd_raux.val(BYTE0_RANGE);
            sd_pipeline(BYTE5_RANGE) <= sd_raux.val(BYTE0_RANGE);
            sd_pipeline(BYTE6_RANGE) <= sd_raux.val(BYTE0_RANGE);
            sd_pipeline(BYTE7_RANGE) <= sd_raux.val(BYTE0_RANGE);

            
        when sh =>
            bena_pipeline(to_integer(unsigned(addr.addr(2 downto 1) & '0'))) <= '1';
            bena_pipeline(to_integer(unsigned(addr.addr(2 downto 1) & '1'))) <= '1';
            sd_pipeline <=  sd_raux.val(HWORD0_RANGE) 
                          & sd_raux.val(HWORD0_RANGE)
                          & sd_raux.val(HWORD0_RANGE)
                          & sd_raux.val(HWORD0_RANGE);
                
        when sw | sp =>
            bena_pipeline <= X"F0" when addr.addr(2) = '1' else X"0F";
            sd_pipeline <=  sd_raux.val
                          & sd_raux.val;

        when store_rpc =>
            bena_pipeline <= (others => '1');
            sd_pipeline <=  sd_raux.val
                          & sd_rdat.val;
            
        when others =>
            wena <= false;
        end case;
        
    end process write_p;   
END ARCHITECTURE mixed;

