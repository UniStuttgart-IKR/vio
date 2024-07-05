LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.pipeline.all;

ENTITY dc_wrapper IS
   PORT( 
      addr               : IN     mem_addr_T;
      clk                : IN     std_logic;
      mode               : IN     mem_mode_T;
      next_addr          : IN     mem_addr_T;
      next_mode          : IN     mem_mode_T;
      next_obj_init_addr : IN     word_T;
      obj_init_addr      : IN     word_T;
      obj_init_byte_ena  : IN     std_logic_vector (BUS_WIDTH/8 - 1 DOWNTO 0);
      obj_init_data      : IN     buzz_word_T;
      obj_init_wr        : IN     boolean;
      rack               : IN     boolean;
      rdata              : IN     buzz_word_T;
      res_n              : IN     std_logic;
      sd_raux            : IN     raux_T;
      sd_rdat            : IN     rdat_T;
      sd_rptr            : IN     rptr_T;
      wack               : IN     boolean;
      ld                 : OUT    dword_T;
      raddr              : OUT    std_logic_vector (31 DOWNTO 0);
      rreq               : OUT    boolean;
      stall              : OUT    std_logic;
      stall_bool         : OUT    boolean;
      waddr              : OUT    std_logic_vector (31 DOWNTO 0);
      wbyte_ena          : OUT    std_logic_vector (BUS_WIDTH/8 - 1 DOWNTO 0);
      wdata              : OUT    buzz_word_T;
      wreq               : OUT    boolean
   );

-- Declarations

END dc_wrapper ;
