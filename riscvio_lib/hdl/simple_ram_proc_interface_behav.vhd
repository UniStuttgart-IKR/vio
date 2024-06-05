--
-- VHDL Architecture cyclone10gxlib.simple_ram_proc_interface.behav
--
-- Created:
--          by - leylknci.meyer (pc024)
--          at - 14:01:03 05/07/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.math_real.all;

ARCHITECTURE behav OF simple_ram_proc_interface IS

    subtype addr_type is std_logic_vector(positive(ceil(log2(real(SIZE / BYTE_WIDTH))))-1 downto 0);

    pure function inBounds(p_addr: dword; start_address: natural; end_address: natural) return boolean is
        variable result: boolean;
        variable addr: natural;
    begin
        addr := to_integer(unsigned(p_addr(31 downto 0)));
        if addr >= start_address and addr <= end_address then
            result := true;
        else
            result := false;
        end if;
        return result;
    end function inBounds;

    pure function toMemoryAddress(p_addr: dword; start_address: natural) return addr_type is
    begin
        return addr_type(unsigned(p_addr(addr_type'high+3 downto 3)) - start_address);
    end function toMemoryAddress;

    signal raddr_in_bounds: boolean;
    signal waddr_in_bounds: boolean;

BEGIN
  
  -- Processor clock domain 
  waddr_in_bounds <= inBounds(io_addr, BASE_ADDR, BASE_ADDR+SIZE-1) and (io_mode = sb or io_mode = sh or io_mode = sw or io_mode = sd);
  raddr_in_bounds <= inBounds(io_addr_u, BASE_ADDR, BASE_ADDR+SIZE-1) or (inBounds(io_addr, BASE_ADDR, BASE_ADDR+SIZE-1) and (io_mode = lb or io_mode = lbu or io_mode = lh or io_mode = lhu or io_mode = lw or io_mode = lwu or io_mode = ld));

  -- use io_addr in case of store operations, io_addr_u in case of load operation
  address <= toMemoryAddress(io_addr, BASE_ADDR) when waddr_in_bounds else toMemoryAddress(io_addr_u, BASE_ADDR); 
  
  -- write to IO Buffer
  write_p: process (all) is
  begin
    -- assign default values
    byteena      <= (others => '0');
    wdata <= (others => '0');
    wena  <= '0';
    
    if waddr_in_bounds then
      case io_mode is
        when sb =>
            wena  <= '1';
            byteena(to_integer(unsigned(io_addr(2 downto 0)))) <= '1';
            wdata(BYTE0_RANGE) <= io_wdata(BYTE0_RANGE);
            wdata(BYTE1_RANGE) <= io_wdata(BYTE0_RANGE);
            wdata(BYTE2_RANGE) <= io_wdata(BYTE0_RANGE);
            wdata(BYTE3_RANGE) <= io_wdata(BYTE0_RANGE);
            wdata(BYTE4_RANGE) <= io_wdata(BYTE0_RANGE);
            wdata(BYTE5_RANGE) <= io_wdata(BYTE0_RANGE);
            wdata(BYTE6_RANGE) <= io_wdata(BYTE0_RANGE);
            wdata(BYTE7_RANGE) <= io_wdata(BYTE0_RANGE);
            
        when sh =>
            wena  <= '1';
            byteena(to_integer(unsigned(io_addr(2 downto 1) & '0'))) <= '1';
            byteena(to_integer(unsigned(io_addr(2 downto 1) & '1'))) <= '1';
            wdata <= io_wdata(HWORD0_RANGE) 
                    & io_wdata(HWORD0_RANGE) 
                    & io_wdata(HWORD0_RANGE) 
                    & io_wdata(HWORD0_RANGE);
               
        when sw =>
            wena  <= '1';
            byteena <= X"F0" when io_addr(2) = '1' else X"0F";
            wdata <= io_wdata(WORD0_RANGE) & io_wdata(WORD0_RANGE);
            
        when sd =>
          wena  <= '1';
          byteena <= (others => '1');
          wdata <= io_wdata;
  
        when others =>
          null;
      end case;
    end if;
    
  end process write_p;   

  -- read from RX Buffer 
  read_p: process (all) is
  begin  
    -- assign default values
    rdata        <= (others => '0');
    rdata_active    <= false;
    
    if raddr_in_bounds then
      case io_mode is
        when lb =>
          
          case io_addr(2 downto 0) is
          when "000" =>
            rdata              <= (others => q(BYTE0_RANGE'high));
            rdata(BYTE0_RANGE) <= q(BYTE0_RANGE);
            rdata_active          <= true;
                       
          when "001" =>
            rdata              <= (others => q(BYTE1_RANGE'high));
            rdata(BYTE0_RANGE) <= q(BYTE1_RANGE);
            rdata_active          <= true;
                        
          when "010" =>
            rdata              <= (others => q(BYTE2_RANGE'high));
            rdata(BYTE0_RANGE) <= q(BYTE2_RANGE);
            rdata_active          <= true;
                      
          when "011" =>
            rdata              <= (others => q(BYTE3_RANGE'high));
            rdata(BYTE0_RANGE) <= q(BYTE3_RANGE);
            rdata_active          <= true;
                        
          when "100" =>
            rdata              <= (others => q(BYTE4_RANGE'high));
            rdata(BYTE0_RANGE) <= q(BYTE4_RANGE);
            rdata_active          <= true;
                      
          when "101" =>
            rdata              <= (others => q(BYTE5_RANGE'high));
            rdata(BYTE0_RANGE) <= q(BYTE5_RANGE);
            rdata_active          <= true;
                        
          when "110" =>
            rdata              <= (others => q(BYTE6_RANGE'high));
            rdata(BYTE0_RANGE) <= q(BYTE6_RANGE);
            rdata_active          <= true;
                        
          when "111" =>
            rdata              <= (others => q(BYTE7_RANGE'high));
            rdata(BYTE0_RANGE) <= q(BYTE7_RANGE);
            rdata_active          <= true;
                    
          when others =>
            null;
            
          end case;
          
        when lbu =>
          case io_addr(2 downto 0) is
          when "000" =>
            rdata(BYTE0_RANGE) <= q(BYTE0_RANGE);
            rdata_active          <= true;     
                   
          when "001" =>
            rdata(BYTE0_RANGE) <= q(BYTE1_RANGE);
            rdata_active          <= true;
                        
          when "010" =>
            rdata(BYTE0_RANGE) <= q(BYTE2_RANGE);
            rdata_active          <= true;
                      
          when "011" =>
            rdata(BYTE0_RANGE) <= q(BYTE3_RANGE);
            rdata_active          <= true;
                        
          when "100" =>
            rdata(BYTE0_RANGE) <= q(BYTE4_RANGE);
            rdata_active          <= true;
                      
          when "101" =>
            rdata(BYTE0_RANGE) <= q(BYTE5_RANGE);
            rdata_active          <= true;
                        
          when "110" =>
            rdata(BYTE0_RANGE) <= q(BYTE6_RANGE);
            rdata_active          <= true;
                        
          when "111" =>
            rdata(BYTE0_RANGE) <= q(BYTE7_RANGE);
            rdata_active          <= true;
                    
          when others =>
            null;
            
          end case;
          
        when lh =>
          case io_addr(2 downto 1) is
          when "00" =>
            rdata               <= (others => q(HWORD0_RANGE'high));
            rdata(HWORD0_RANGE) <= q(HWORD0_RANGE);
            rdata_active           <= true;
                        
          when "01" =>
            rdata               <= (others => q(HWORD1_RANGE'high));
            rdata(HWORD0_RANGE) <= q(HWORD1_RANGE);
            rdata_active           <= true;
                        
          when "10" =>
            rdata               <= (others => q(HWORD2_RANGE'high));
            rdata(HWORD0_RANGE) <= q(HWORD2_RANGE);
            rdata_active           <= true;
                        
          when "11" =>
            rdata               <= (others => q(HWORD3_RANGE'high));
            rdata(HWORD0_RANGE) <= q(HWORD3_RANGE);
            rdata_active           <= true;
                      
          when others => 
            null;
            
          end case;
          
        when lhu =>
          case io_addr(2 downto 1) is
          when "00" =>
            rdata(HWORD0_RANGE) <= q(HWORD0_RANGE);
            rdata_active           <= true;
                        
          when "01" =>
            rdata(HWORD0_RANGE) <= q(HWORD1_RANGE);
            rdata_active           <= true;
                        
          when "10" =>
            rdata(HWORD0_RANGE) <= q(HWORD2_RANGE);
            rdata_active           <= true;
                        
          when "11" =>
            rdata(HWORD0_RANGE) <= q(HWORD3_RANGE);
            rdata_active           <= true;
                      
          when others => 
            null;
            
          end case;
  
        when lw =>
          case io_addr(2) is
          when '0' =>
            rdata(WORD1_RANGE) <= (others => q(WORD0_RANGE'high));
            rdata(WORD0_RANGE) <= q(WORD0_RANGE);
            rdata_active          <= true;
                        
          when '1' =>
            rdata(WORD1_RANGE) <= (others => q(WORD1_RANGE'high));
            rdata(WORD0_RANGE) <= q(WORD1_RANGE);
            rdata_active          <= true;
                      
          when others => 
            null;
            
          end case;
          
        when lwu =>
          case io_addr(2) is
          when '0' =>
            rdata(WORD0_RANGE) <= q(WORD0_RANGE);
            rdata_active          <= true;
                        
          when '1' =>
            rdata(WORD0_RANGE) <= q(WORD1_RANGE);
            rdata_active          <= true;
                      
          when others =>
            null;
            
          end case;
          
        when ld =>
          rdata           <= q;
          rdata_active       <= true;
          
        when others =>
          null;
      end case;
    end if;
  end process read_p;


END ARCHITECTURE behav;

