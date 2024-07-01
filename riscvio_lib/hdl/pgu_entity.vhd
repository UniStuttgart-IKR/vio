LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.pipeline.all;

ENTITY pgu IS
   PORT( 
      imm                           : IN     word_T;
      pc                            : IN     pc_T;
      pgu_mode                      : IN     pgu_mode_T;
      raux                          : IN     raux_T;
      rdat                          : IN     rdat_T;
      rdst_ix                       : IN     reg_nbr_T;
      rptr                          : IN     rptr_T;
      frame_type_exception          : OUT    boolean;
      index_out_of_bounds_exception : OUT    boolean;
      me_addr                       : OUT    mem_addr_T;
      ptr                           : OUT    reg_mem_T;
      state_error_exception         : OUT    boolean
   );

-- Declarations

END pgu ;
