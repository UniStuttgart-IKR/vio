--
-- VHDL Architecture riscvio_lib.block_ram_if.behav
--
-- Created:
--          by - rbnlux.ckoehler (pc038)
--          at - 16:10:55 06/05/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee;
use ieee.numeric_std.all;

ARCHITECTURE behav OF block_ram_if IS

BEGIN
  dram_address_a <= addr.data(dram_address_a'high downto 0);
  next_dram_address_a <= next_addr.data(dram_address_a'high downto 0);
  read_p: process (all) is
  begin  
    -- assign default values
    mem_out        <= (others => '0');
    dram_rena_a           <= '1';
    
    case mode is
      when lb =>
        
        case next_addr.data(1 downto 0) is
          when "00" =>
              mem_out              <= (others => dram_q_a(BYTE0_RANGE'high));
              mem_out(BYTE0_RANGE) <= dram_q_a(BYTE0_RANGE);
                      
          when "01" =>
              mem_out              <= (others => dram_q_a(BYTE1_RANGE'high));
              mem_out(BYTE0_RANGE) <= dram_q_a(BYTE1_RANGE);
                          
          when "10" =>
              mem_out              <= (others => dram_q_a(BYTE2_RANGE'high));
              mem_out(BYTE0_RANGE) <= dram_q_a(BYTE2_RANGE);
                      
          when "11" =>
              mem_out              <= (others => dram_q_a(BYTE3_RANGE'high));
              mem_out(BYTE0_RANGE) <= dram_q_a(BYTE3_RANGE);
          
          when others =>
              null;
              
        end case;
        
      when lbu =>
        case next_addr.data(1 downto 0) is
          when "00" =>
              mem_out(BYTE0_RANGE) <= dram_q_a(BYTE0_RANGE); 
                  
          when "01" =>
              mem_out(BYTE0_RANGE) <= dram_q_a(BYTE1_RANGE);
                          
          when "10" =>
              mem_out(BYTE0_RANGE) <= dram_q_a(BYTE2_RANGE);
                      
          when "11" =>
              mem_out(BYTE0_RANGE) <= dram_q_a(BYTE3_RANGE);
                      
          when others =>
              null;
              
        end case;
        
      when lh =>
        case next_addr.data(1) is
          when '0' =>
              mem_out               <= (others => dram_q_a(HWORD0_RANGE'high));
              mem_out(HWORD0_RANGE) <= dram_q_a(HWORD0_RANGE);
                          
          when '1' =>
              mem_out               <= (others => dram_q_a(HWORD1_RANGE'high));
              mem_out(HWORD0_RANGE) <= dram_q_a(HWORD1_RANGE);
                              
          when others => 
              null;
          
        end case;
        
      when lhu =>
        case next_addr.data(1) is
          when '0' =>
              mem_out(HWORD0_RANGE) <= dram_q_a(HWORD0_RANGE);
                          
          when '1' =>
              mem_out(HWORD0_RANGE) <= dram_q_a(HWORD1_RANGE);
                          
          when others => 
              null;
              
        end case;

      when lw =>
          mem_out <= dram_q_a;

      when lp =>
          mem_out <= dram_q_a;

      when others =>
        dram_rena_a <= '0';
    end case;
  end process read_p;



    -- write to IO Buffer
  write_p: process (all) is
  begin
    -- assign default values
    dram_byteena_a      <= (others => '1');
    dram_data_a <= (others => '0');
    dram_wren_a  <= '0';
    
    case mode_u is
      when sb =>
          dram_wren_a  <= '1';
          dram_byteena_a(to_integer(unsigned(addr.data(1 downto 0)))) <= '1';
          dram_data_a(BYTE0_RANGE) <= raux.val(BYTE0_RANGE);
          dram_data_a(BYTE1_RANGE) <= raux.val(BYTE0_RANGE);
          dram_data_a(BYTE2_RANGE) <= raux.val(BYTE0_RANGE);
          dram_data_a(BYTE3_RANGE) <= raux.val(BYTE0_RANGE);

          
      when sh =>
          dram_wren_a  <= '1';
          dram_byteena_a <= "1100" when next_addr.data(1) = '1' else "0011";
          dram_data_a <= raux.val(HWORD0_RANGE) 
                            & raux.val(HWORD0_RANGE);
              
      when sw =>
          dram_wren_a  <= '1';
          dram_byteena_a <= (others => '1');
          dram_data_a <= raux.val;

      when sp =>
          dram_wren_a  <= '1';
          dram_byteena_a <= (others => '1');
          dram_data_a <= raux.val;
        

      when others =>
        null;
    end case;
    
  end process write_p;   
END ARCHITECTURE behav;

