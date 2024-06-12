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
  dram_address_a <= addr(dram_address_a'high downto 0);
  read_p: process (all) is
  begin  
    -- assign default values
    mem_out        <= (others => '0');
    
    if true then
      case mode.mnemonic is
        when lb_i | lb_r =>
          
          case addr(1 downto 0) is
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
          
        when lbu_i | lbu_r =>
          case addr(1 downto 0) is
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
          
        when lh_i | lh_r =>
          case addr(1) is
            when '0' =>
                mem_out               <= (others => dram_q_a(HWORD0_RANGE'high));
                mem_out(HWORD0_RANGE) <= dram_q_a(HWORD0_RANGE);
                            
            when '1' =>
                mem_out               <= (others => dram_q_a(HWORD1_RANGE'high));
                mem_out(HWORD0_RANGE) <= dram_q_a(HWORD1_RANGE);
                                
            when others => 
                null;
            
          end case;
          
        when lhu_i | lhu_r =>
          case addr(1) is
            when '0' =>
                mem_out(HWORD0_RANGE) <= dram_q_a(HWORD0_RANGE);
                            
            when '1' =>
                mem_out(HWORD0_RANGE) <= dram_q_a(HWORD1_RANGE);
                            
            when others => 
                null;
                
          end case;
  
        when lw_i | lw_r =>
            mem_out <= dram_q_a;

        when lp_i | lp_r =>
            mem_out <= dram_q_a;

        when others =>
          null;
      end case;
    end if;
  end process read_p;



    -- write to IO Buffer
  write_p: process (all) is
  begin
    -- assign default values
    dram_byteena_a      <= (others => '1');
    dram_data_a <= (others => '0');
    dram_wren_a  <= '0';
    
    if true then
      case mode_u.mnemonic is
        when sb_i | sb_r =>
            dram_wren_a  <= '1';
            dram_byteena_a(to_integer(unsigned(addr(1 downto 0)))) <= '1';
            dram_data_a(BYTE0_RANGE) <= raux.val(BYTE0_RANGE);
            dram_data_a(BYTE1_RANGE) <= raux.val(BYTE0_RANGE);
            dram_data_a(BYTE2_RANGE) <= raux.val(BYTE0_RANGE);
            dram_data_a(BYTE3_RANGE) <= raux.val(BYTE0_RANGE);

            
        when sh_i | sh_r =>
            dram_wren_a  <= '1';
            dram_byteena_a <= "1100" when addr(1) = '1' else "0011";
            dram_data_a <= raux.val(HWORD0_RANGE) 
                             & raux.val(HWORD0_RANGE);
               
        when sw_i | sw_r =>
            dram_wren_a  <= '1';
            dram_byteena_a <= (others => '1');
            dram_data_a <= raux.val;

        when sp_i | sp_r =>
            dram_wren_a  <= '1';
            dram_byteena_a <= (others => '1');
            dram_data_a <= raux.val;
          
  
        when others =>
          null;
      end case;
    end if;
    
  end process write_p;   
END ARCHITECTURE behav;

