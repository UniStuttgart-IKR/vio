LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
USE riscvio_lib.caches.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
USE riscvio_lib.caches.all;


ARCHITECTURE struct OF riscvio IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL REG_MEM_NULL_SIG              : reg_mem_T;
   SIGNAL a                             : word_T;
   SIGNAL ac_stall                      : boolean;
   SIGNAL addr_me                       : reg_mem_T;
   SIGNAL addr_me_uq                    : reg_mem_T;
   SIGNAL allocating_at                 : boolean;
   SIGNAL allocating_me                 : boolean  := false;
   SIGNAL allocating_wb                 : boolean;
   SIGNAL alu_a_in_sel_dc               : alu_in_sel_T;
   SIGNAL alu_b_in_sel_dc               : alu_in_sel_T;
   SIGNAL alu_mode_dc                   : alu_mode_T;
   SIGNAL alu_out_ex_u                  : word_T;
   SIGNAL b                             : word_T;
   SIGNAL branch_mode_dc                : branch_mode_T;
   SIGNAL csr_ix                        : csr_ix_T;
   SIGNAL csr_val                       : word_T;
   SIGNAL ctrl_dc                       : ctrl_sig_T;
   SIGNAL ctrl_dc_dec                   : ctrl_sig_t;
   SIGNAL ctrl_dc_u                     : ctrl_sig_T;
   SIGNAL ctrl_ex                       : ctrl_sig_T;
   SIGNAL ctrl_me                       : ctrl_sig_T;
   SIGNAL current_pc_d                  : pc_T;
   SIGNAL current_pc_uq                 : pc_T;
   SIGNAL dbt                           : pc_T;
   SIGNAL dbt_valid                     : boolean;
   SIGNAL dbu_out_ex_u                  : reg_mem_T;
   SIGNAL dc_stall                      : boolean;
   SIGNAL dt_at_u                       : word_T;
   SIGNAL end_addr                      : word_T;
   SIGNAL false_sig                     : boolean;
   SIGNAL flags                         : alu_flags_T;
   SIGNAL frame_type_exception          : boolean;
   SIGNAL heap_overflow                 : boolean;
   SIGNAL ic_stall                      : boolean;
   SIGNAL if_instr                      : word_T;
   SIGNAL if_instr_d                    : word_T;
   SIGNAL imm_dc                        : word_T;
   SIGNAL imm_dc_reg                    : word_T;
   SIGNAL imm_dc_u                      : word_T;
   SIGNAL imm_dec                       : word_T;
   SIGNAL imm_ex                        : word_T;
   SIGNAL imm_ex_reg                    : word_T;
   SIGNAL imm_me                        : word_T;
   SIGNAL incremented_pc                : pc_T;
   SIGNAL index_out_of_bounds_exception : boolean;
   SIGNAL insert_nop                    : boolean;
   SIGNAL ld_attr                       : boolean;
   SIGNAL me_addr                       : word_T;
   SIGNAL me_addr_u                     : word_T;
   SIGNAL me_addr_uq                    : word_T;
   SIGNAL me_mode_ex                    : mem_mode_T;
   SIGNAL me_mode_ex_uq                 : mem_mode_T;
   SIGNAL mem_out_me_u                  : word_T;
   SIGNAL next_obj_init_addr            : word_T;
   SIGNAL obj_init_addr                 : word_T;
   SIGNAL obj_init_data                 : word_T;
   SIGNAL obj_init_stall                : boolean;
   SIGNAL obj_init_wr                   : boolean;
   SIGNAL pc_current_pc                 : pc_T;
   SIGNAL pc_dc                         : pc_T;
   SIGNAL pc_if                         : pc_T;
   SIGNAL pgu_mode_dc                   : pgu_mode_T;
   SIGNAL pgu_mode_ex                   : pgu_mode_T;
   SIGNAL pgu_ptr_ex_u                  : reg_mem_T;
   SIGNAL pi_at_u                       : word_T;
   SIGNAL raux_dc                       : raux_T;
   SIGNAL raux_dc_reg                   : raux_T;
   SIGNAL raux_dc_u                     : raux_T;
   SIGNAL raux_dc_uq                    : raux_T;
   SIGNAL raux_ex                       : raux_T;
   SIGNAL raux_ex_reg                   : raux_T;
   SIGNAL raux_ix                       : reg_ix_T;
   SIGNAL raux_me                       : raux_T;
   SIGNAL raux_rf                       : raux_T;
   SIGNAL rd_wb                         : reg_wb_T;
   SIGNAL rdat_dc                       : rdat_T;
   SIGNAL rdat_dc_reg                   : rdat_T;
   SIGNAL rdat_dc_u                     : rdat_T;
   SIGNAL rdat_dc_uq                    : rdat_T;
   SIGNAL rdat_ex                       : rdat_T;
   SIGNAL rdat_ex_reg                   : rdat_T;
   SIGNAL rdat_ix                       : reg_ix_T;
   SIGNAL rdat_me                       : rdat_T;
   SIGNAL rdat_rf                       : rdat_T;
   SIGNAL rdst_ix_at                    : reg_ix_T;
   SIGNAL rdst_ix_dc                    : reg_ix_T;
   SIGNAL rdst_ix_dc_reg                : reg_ix_T;
   SIGNAL rdst_ix_dc_u                  : reg_ix_T;
   SIGNAL rdst_ix_dec                   : reg_ix_T;
   SIGNAL rdst_ix_ex                    : reg_ix_T;
   SIGNAL rdst_ix_ex_reg                : reg_ix_T;
   SIGNAL rdst_ix_me                    : reg_ix_T := 0;
   SIGNAL rdst_ix_me_reg                : reg_ix_T := 0;
   SIGNAL res_at                        : reg_mem_T;
   SIGNAL res_at_u                      : reg_mem_T;
   SIGNAL res_ex                        : reg_mem_T;
   SIGNAL res_ex_u                      : reg_mem_T;
   SIGNAL res_ex_uq                     : reg_mem_T;
   SIGNAL res_me                        : reg_mem_T;
   SIGNAL res_me_u                      : reg_mem_T;
   SIGNAL res_wb                        : reg_mem_T;
   SIGNAL rptr_dc                       : rptr_T;
   SIGNAL rptr_dc_reg                   : rptr_T;
   SIGNAL rptr_dc_u                     : rptr_T;
   SIGNAL rptr_dc_uq                    : rptr_T;
   SIGNAL rptr_ex                       : rptr_T;
   SIGNAL rptr_ex_reg                   : rptr_T;
   SIGNAL rptr_ix                       : reg_ix_T;
   SIGNAL rptr_me                       : rptr_T;
   SIGNAL rptr_rf                       : rptr_T;
   SIGNAL sbt                           : pc_T;
   SIGNAL sbt_valid                     : boolean;
   SIGNAL stack_overflow                : boolean;
   SIGNAL stall                         : boolean;
   SIGNAL state_error_dbu               : boolean;
   SIGNAL state_error_pgu               : boolean;
   SIGNAL zero_reg_ix                   : reg_ix_T := 0;


   -- Component Declarations
   COMPONENT ac_wrapper
   PORT (
      addr      : IN     reg_mem_T ;
      clk       : IN     std_logic ;
      ld_attr   : IN     boolean ;
      next_addr : IN     reg_mem_T ;
      rack      : IN     boolean ;
      rdata     : IN     buzz_word_T ;
      res_n     : IN     std_logic ;
      dt        : OUT    word_T ;
      pi        : OUT    word_T ;
      raddr     : OUT    std_logic_vector (31 DOWNTO 0);
      rreq      : OUT    boolean ;
      stall     : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT alu
   PORT (
      a       : IN     word_T ;
      b       : IN     word_T ;
      mode    : IN     alu_mode_T ;
      alu_out : OUT    word_T ;
      flags   : OUT    alu_flags_T 
   );
   END COMPONENT;
   COMPONENT alu_a_mux
   PORT (
      alu_a_in_sel : IN     alu_in_sel_T ;
      raux_dc      : IN     raux_T ;
      rdat_dc      : IN     rdat_T ;
      rptr_dc      : IN     rptr_T ;
      a            : OUT    word_T 
   );
   END COMPONENT;
   COMPONENT alu_b_mux
   PORT (
      alu_b_in_sel : IN     alu_in_sel_T ;
      imm_dc       : IN     word_T ;
      raux_dc      : IN     raux_T ;
      rdat_dc      : IN     rdat_T ;
      rptr_dc      : IN     rptr_T ;
      b            : OUT    word_T 
   );
   END COMPONENT;
   COMPONENT at_reg
   PORT (
      clk           : IN     std_logic ;
      ctrl_me       : IN     ctrl_sig_T ;
      imm_me        : IN     word_T ;
      raux_me       : IN     raux_T ;
      rdat_me       : IN     rdat_T ;
      rdst_ix_me    : IN     reg_ix_T ;
      res_at_u      : IN     reg_mem_T ;
      res_n         : IN     std_logic ;
      rptr_me       : IN     rptr_T ;
      stall         : IN     boolean ;
      allocating_wb : OUT    boolean ;
      rd_wb         : OUT    reg_wb_T ;
      rdst_ix_at    : OUT    reg_ix_T ;
      res_at        : OUT    reg_mem_T 
   );
   END COMPONENT;
   COMPONENT at_res_mux
   PORT (
      ctrl_me  : IN     ctrl_sig_T ;
      dt_at_u  : IN     word_T ;
      pi_at_u  : IN     word_T ;
      res_me   : IN     reg_mem_T ;
      res_at_u : OUT    reg_mem_T 
   );
   END COMPONENT;
   COMPONENT clr_ptr_end_addr_mux
   PORT (
      raux_ex    : IN     raux_T ;
      rdst_ix_ex : IN     reg_ix_T ;
      rptr_ex    : IN     rptr_T ;
      end_addr   : OUT    word_T 
   );
   END COMPONENT;
   COMPONENT csr_rf_mux
   PORT (
      csr_val   : IN     word_T ;
      raux_rf   : IN     raux_T ;
      rdat_ix   : IN     reg_ix_T ;
      rdat_rf   : IN     rdat_T ;
      rptr_ix   : IN     reg_ix_T ;
      rptr_rf   : IN     rptr_T ;
      raux_dc_u : OUT    raux_T ;
      rdat_dc_u : OUT    rdat_T ;
      rptr_dc_u : OUT    rptr_T 
   );
   END COMPONENT;
   COMPONENT csr_unit
   PORT (
      clk            : IN     std_logic ;
      csr_ix         : IN     csr_ix_T ;
      rd_wb          : IN     reg_wb_T ;
      res_n          : IN     std_logic ;
      csr_val        : OUT    word_T ;
      heap_overflow  : OUT    boolean ;
      stack_overflow : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT dc_reg
   PORT (
      clk             : IN     std_logic ;
      ctrl_dc_u       : IN     ctrl_sig_T ;
      dbt_valid       : IN     boolean ;
      heap_overflow   : IN     boolean ;
      imm_dc_u        : IN     word_T ;
      pc_if           : IN     pc_T ;
      raux_dc_u       : IN     raux_T ;
      rdat_dc_u       : IN     rdat_T ;
      rdst_ix_dc_u    : IN     reg_ix_T ;
      res_n           : IN     std_logic ;
      rptr_dc_u       : IN     rptr_T ;
      stack_overflow  : IN     boolean ;
      stall           : IN     boolean ;
      alu_a_in_sel_dc : OUT    alu_in_sel_T ;
      alu_b_in_sel_dc : OUT    alu_in_sel_T ;
      alu_mode_dc     : OUT    alu_mode_T ;
      branch_mode_dc  : OUT    branch_mode_T ;
      ctrl_dc         : OUT    ctrl_sig_T ;
      imm_dc_reg      : OUT    word_T ;
      pc_dc           : OUT    pc_T ;
      pgu_mode_dc     : OUT    pgu_mode_T ;
      raux_dc_reg     : OUT    raux_T ;
      rdat_dc_reg     : OUT    rdat_T ;
      rdst_ix_dc_reg  : OUT    reg_ix_T ;
      rptr_dc_reg     : OUT    rptr_T 
   );
   END COMPONENT;
   COMPONENT dc_wrapper
   PORT (
      addr               : IN     word_T ;
      clk                : IN     std_logic ;
      mode               : IN     mem_mode_T ;
      next_addr          : IN     word_T ;
      next_mode          : IN     mem_mode_T ;
      next_obj_init_addr : IN     word_T ;
      obj_init_addr      : IN     word_T ;
      obj_init_data      : IN     word_T ;
      obj_init_wr        : IN     boolean ;
      rack               : IN     boolean ;
      rdata              : IN     buzz_word_T ;
      res_n              : IN     std_logic ;
      sd_raux            : IN     raux_T ;
      sd_rdat            : IN     rdat_T ;
      sd_rptr            : IN     rptr_T ;
      wack               : IN     boolean ;
      ld                 : OUT    word_T ;
      raddr              : OUT    std_logic_vector (31 DOWNTO 0);
      rreq               : OUT    boolean ;
      stall              : OUT    boolean ;
      waddr              : OUT    std_logic_vector (31 DOWNTO 0);
      wdata              : OUT    buzz_word_T ;
      wreq               : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT decoder
   PORT (
      instruction : IN     word_T;
      pc          : IN     pc_T;
      csr_ix      : OUT    csr_ix_T;
      ctr_sig     : OUT    ctrl_sig_t;
      imm         : OUT    word_T;
      raux_ix     : OUT    reg_ix_T;
      rdat_ix     : OUT    reg_ix_T;
      rdst_ix     : OUT    reg_ix_T;
      rptr_ix     : OUT    reg_ix_T;
      sbt         : OUT    pc_T;
      sbt_valid   : OUT    boolean
   );
   END COMPONENT;
   COMPONENT dyn_branch_unit
   PORT (
      alu_flags      : IN     alu_flags_T;
      branch_mode    : IN     branch_mode_T;
      dyn_branch_tgt : IN     word_T;
      imm            : IN     word_T;
      pc             : IN     pc_T;
      raux           : IN     raux_T;
      rdat           : IN     rdat_T;
      rdst_ix        : IN     reg_ix_T;
      rptr           : IN     rptr_T;
      dbt            : OUT    pc_T;
      dbt_valid      : OUT    boolean;
      ra_out         : OUT    reg_mem_T;
      state_error    : OUT    boolean
   );
   END COMPONENT;
   COMPONENT ex_reg
   PORT (
      clk                           : IN     std_logic ;
      ctrl_dc                       : IN     ctrl_sig_T ;
      frame_type_exception          : IN     boolean ;
      imm_dc                        : IN     word_T ;
      index_out_of_bounds_exception : IN     boolean ;
      me_addr_u                     : IN     word_T ;
      raux_dc                       : IN     raux_T ;
      rdat_dc                       : IN     rdat_T ;
      rdst_ix_dc                    : IN     reg_ix_T ;
      res_ex_u                      : IN     reg_mem_T ;
      res_n                         : IN     std_logic ;
      rptr_dc                       : IN     rptr_T ;
      stall                         : IN     boolean ;
      state_error_dbu               : IN     boolean ;
      state_error_pgu               : IN     boolean ;
      allocating_me                 : OUT    boolean ;
      ctrl_ex                       : OUT    ctrl_sig_T ;
      imm_ex_reg                    : OUT    word_T ;
      me_addr                       : OUT    word_T ;
      me_addr_uq                    : OUT    word_T ;
      me_mode_ex                    : OUT    mem_mode_T ;
      me_mode_ex_uq                 : OUT    mem_mode_T ;
      pgu_mode_ex                   : OUT    pgu_mode_T ;
      raux_dc_uq                    : OUT    raux_T ;
      raux_ex_reg                   : OUT    raux_T ;
      rdat_dc_uq                    : OUT    rdat_T ;
      rdat_ex_reg                   : OUT    rdat_T ;
      rdst_ix_ex_reg                : OUT    reg_ix_T ;
      res_ex                        : OUT    reg_mem_T ;
      res_ex_uq                     : OUT    reg_mem_T ;
      rptr_dc_uq                    : OUT    rptr_T ;
      rptr_ex_reg                   : OUT    rptr_T 
   );
   END COMPONENT;
   COMPONENT ex_res_mux
   PORT (
      alu_out_ex_u   : IN     word_T ;
      branch_mode_dc : IN     branch_mode_T ;
      dbu_out_ex_u   : IN     reg_mem_T ;
      pgu_mode_dc    : IN     pgu_mode_T ;
      pgu_ptr_ex_u   : IN     reg_mem_T ;
      raux_dc        : IN     raux_T ;
      res_ex_u       : OUT    reg_mem_T 
   );
   END COMPONENT;
   COMPONENT fwd_unit
   PORT (
      fwd_0     : IN     boolean ;
      fwd_1     : IN     boolean ;
      fwd_2     : IN     boolean ;
      fwd_idx_0 : IN     reg_ix_T   := 0;
      fwd_idx_1 : IN     reg_ix_T   := 0;
      fwd_idx_2 : IN     reg_ix_T   := 0;
      fwd_res_0 : IN     reg_mem_T  := REG_MEM_NULL;
      fwd_res_1 : IN     reg_mem_T  := REG_MEM_NULL;
      fwd_res_2 : IN     reg_mem_T  := REG_MEM_NULL;
      imm_reg   : IN     word_T ;
      raux_reg  : IN     raux_T ;
      rdat_reg  : IN     rdat_T ;
      rdst_reg  : IN     reg_ix_T ;
      rptr_reg  : IN     rptr_T ;
      imm_fwd   : OUT    word_T ;
      raux_fwd  : OUT    raux_T ;
      rdat_fwd  : OUT    rdat_T ;
      rdst_fwd  : OUT    reg_ix_T ;
      rptr_fwd  : OUT    rptr_T 
   );
   END COMPONENT;
   COMPONENT ic_wrapper
   PORT (
      clk      : IN     STD_LOGIC  := '1';
      dbranch  : IN     boolean;
      ic_rack  : IN     boolean;
      ic_rdata : IN     std_logic_vector (BUS_WIDTH - 1 DOWNTO 0);
      next_pc  : IN     pc_T;
      pc       : IN     pc_T;
      res_n    : IN     std_logic;
      sbranch  : IN     boolean;
      ic_raddr : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      ic_rreq  : OUT    boolean;
      instr    : OUT    STD_LOGIC_VECTOR (31 DOWNTO 0);
      stall    : OUT    boolean
   );
   END COMPONENT;
   COMPONENT if_reg
   PORT (
      clk           : IN     std_logic ;
      dbt_valid     : IN     boolean ;
      if_instr_d    : IN     word_T ;
      insert_nop    : IN     boolean ;
      pc_current_pc : IN     pc_T ;
      res_n         : IN     std_logic ;
      sbt_valid     : IN     boolean ;
      stall         : IN     boolean ;
      if_instr      : OUT    word_T ;
      pc_if         : OUT    pc_T 
   );
   END COMPONENT;
   COMPONENT me_reg
   PORT (
      clk           : IN     std_logic ;
      ctrl_ex       : IN     ctrl_sig_T ;
      imm_ex        : IN     word_T ;
      raux_ex       : IN     raux_T ;
      rdat_ex       : IN     rdat_T ;
      rdst_ix_ex    : IN     reg_ix_T ;
      res_me_u      : IN     reg_mem_T ;
      res_n         : IN     std_logic ;
      rptr_ex       : IN     rptr_T ;
      stall         : IN     boolean ;
      addr_me       : OUT    reg_mem_T ;
      addr_me_uq    : OUT    reg_mem_T ;
      allocating_at : OUT    boolean ;
      ctrl_me       : OUT    ctrl_sig_T ;
      imm_me        : OUT    word_T ;
      ld_attr       : OUT    boolean ;
      raux_me       : OUT    raux_T ;
      rdat_me       : OUT    rdat_T ;
      rdst_ix_me    : OUT    reg_ix_T ;
      res_me        : OUT    reg_mem_T ;
      rptr_me       : OUT    rptr_T 
   );
   END COMPONENT;
   COMPONENT me_res_mux
   PORT (
      ctrl_ex      : IN     ctrl_sig_T ;
      mem_out_me_u : IN     word_T ;
      raux_ex      : IN     raux_T ;
      res_ex       : IN     reg_mem_T ;
      res_me_u     : OUT    reg_mem_T 
   );
   END COMPONENT;
   COMPONENT next_pc_mux
   PORT (
      dbta_valid        : IN     boolean;
      dynamic_branch_pc : IN     pc_T;
      incremented_pc    : IN     pc_T;
      sbta_valid        : IN     boolean;
      static_branch_pc  : IN     pc_T;
      next_pc           : OUT    pc_T
   );
   END COMPONENT;
   COMPONENT nop_gen
   PORT (
      ctrl_dc_dec  : IN     ctrl_sig_t;
      imm_dec      : IN     word_T;
      insert_nop   : IN     boolean;
      rdst_ix_dec  : IN     reg_ix_T;
      ctrl_dc_u    : OUT    ctrl_sig_T;
      imm_dc_u     : OUT    word_T;
      rdst_ix_dc_u : OUT    reg_ix_T
   );
   END COMPONENT;
   COMPONENT obj_init_fsm
   PORT (
      clk                : IN     std_logic ;
      dc_stall           : IN     boolean ;
      end_addr           : IN     word_T ;
      pgu_mode_ex        : IN     pgu_mode_T ;
      res_ex             : IN     reg_mem_T ;
      res_ex_uq          : IN     reg_mem_T ;
      res_n              : IN     std_logic ;
      next_obj_init_addr : OUT    word_T ;
      obj_init_addr      : OUT    word_T ;
      obj_init_data      : OUT    word_T ;
      obj_init_stall     : OUT    boolean ;
      obj_init_wr        : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT pc_incrementer
   PORT (
      pc      : IN     pc_T;
      next_pc : OUT    pc_T
   );
   END COMPONENT;
   COMPONENT pc_reg
   PORT (
      clk           : IN     std_logic ;
      current_pc_d  : IN     pc_T ;
      dbt_valid     : IN     boolean ;
      insert_nop    : IN     boolean ;
      res_n         : IN     std_logic ;
      sbt_valid     : IN     boolean ;
      stall         : IN     boolean ;
      current_pc_uq : OUT    pc_T ;
      pc_current_pc : OUT    pc_T 
   );
   END COMPONENT;
   COMPONENT pgu
   PORT (
      imm                           : IN     word_T ;
      pc                            : IN     pc_T ;
      pgu_mode                      : IN     pgu_mode_T ;
      raux                          : IN     raux_T ;
      rdat                          : IN     rdat_T ;
      rdst_ix                       : IN     reg_ix_T ;
      rptr                          : IN     rptr_T ;
      frame_type_exception          : OUT    boolean ;
      index_out_of_bounds_exception : OUT    boolean ;
      me_addr                       : OUT    word_T ;
      ptr                           : OUT    reg_mem_T ;
      state_error_exception         : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT ral_nop_unit
   PORT (
      ctrl_dc    : IN     ctrl_sig_T;
      ctrl_ex    : IN     ctrl_sig_T;
      ctrl_if    : IN     ctrl_sig_T;
      dbt_valid  : IN     boolean;
      raux_ix    : IN     reg_ix_T;
      rdat_ix    : IN     reg_ix_T;
      rdst_dc    : IN     reg_ix_T;
      rdst_ex    : IN     reg_ix_T;
      rptr_ix    : IN     reg_ix_T;
      insert_nop : OUT    boolean
   );
   END COMPONENT;
   COMPONENT register_file
   PORT (
      clk     : IN     std_logic;
      raux_ix : IN     reg_ix_T;
      rd_wb   : IN     reg_wb_T;
      rdat_ix : IN     reg_ix_T;
      res_n   : IN     std_logic;
      rptr_ix : IN     reg_ix_T;
      raux    : OUT    raux_T;
      rdat    : OUT    rdat_T;
      rptr    : OUT    rptr_T
   );
   END COMPONENT;
   COMPONENT stall_logic
   PORT (
      ac_stall       : IN     boolean ;
      dc_stall       : IN     boolean ;
      ic_stall       : IN     boolean ;
      obj_init_stall : IN     boolean ;
      stall          : OUT    boolean 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : ac_wrapper USE ENTITY riscvio_lib.ac_wrapper;
   FOR ALL : alu USE ENTITY riscvio_lib.alu;
   FOR ALL : alu_a_mux USE ENTITY riscvio_lib.alu_a_mux;
   FOR ALL : alu_b_mux USE ENTITY riscvio_lib.alu_b_mux;
   FOR ALL : at_reg USE ENTITY riscvio_lib.at_reg;
   FOR ALL : at_res_mux USE ENTITY riscvio_lib.at_res_mux;
   FOR ALL : clr_ptr_end_addr_mux USE ENTITY riscvio_lib.clr_ptr_end_addr_mux;
   FOR ALL : csr_rf_mux USE ENTITY riscvio_lib.csr_rf_mux;
   FOR ALL : csr_unit USE ENTITY riscvio_lib.csr_unit;
   FOR ALL : dc_reg USE ENTITY riscvio_lib.dc_reg;
   FOR ALL : dc_wrapper USE ENTITY riscvio_lib.dc_wrapper;
   FOR ALL : decoder USE ENTITY riscvio_lib.decoder;
   FOR ALL : dyn_branch_unit USE ENTITY riscvio_lib.dyn_branch_unit;
   FOR ALL : ex_reg USE ENTITY riscvio_lib.ex_reg;
   FOR ALL : ex_res_mux USE ENTITY riscvio_lib.ex_res_mux;
   FOR ALL : fwd_unit USE ENTITY riscvio_lib.fwd_unit;
   FOR ALL : ic_wrapper USE ENTITY riscvio_lib.ic_wrapper;
   FOR ALL : if_reg USE ENTITY riscvio_lib.if_reg;
   FOR ALL : me_reg USE ENTITY riscvio_lib.me_reg;
   FOR ALL : me_res_mux USE ENTITY riscvio_lib.me_res_mux;
   FOR ALL : next_pc_mux USE ENTITY riscvio_lib.next_pc_mux;
   FOR ALL : nop_gen USE ENTITY riscvio_lib.nop_gen;
   FOR ALL : obj_init_fsm USE ENTITY riscvio_lib.obj_init_fsm;
   FOR ALL : pc_incrementer USE ENTITY riscvio_lib.pc_incrementer;
   FOR ALL : pc_reg USE ENTITY riscvio_lib.pc_reg;
   FOR ALL : pgu USE ENTITY riscvio_lib.pgu;
   FOR ALL : ral_nop_unit USE ENTITY riscvio_lib.ral_nop_unit;
   FOR ALL : register_file USE ENTITY riscvio_lib.register_file;
   FOR ALL : stall_logic USE ENTITY riscvio_lib.stall_logic;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 2 eb2
   -- eb2 2  
   REG_MEM_NULL_SIG <= REG_MEM_NULL;
   ZERO_REG_IX <= ali_T'pos(zero);       
   false_sig <= false;                              


   -- Instance port mappings.
   ac_i : ac_wrapper
      PORT MAP (
         addr      => addr_me,
         clk       => clk,
         ld_attr   => ld_attr,
         next_addr => addr_me_uq,
         rack      => ac_rack,
         rdata     => ac_rdata,
         res_n     => res_n,
         dt        => dt_at_u,
         pi        => pi_at_u,
         raddr     => ac_raddr,
         rreq      => ac_rreq,
         stall     => ac_stall
      );
   alu_i : alu
      PORT MAP (
         a       => a,
         b       => b,
         mode    => alu_mode_dc,
         alu_out => alu_out_ex_u,
         flags   => flags
      );
   alu_a_mux_i : alu_a_mux
      PORT MAP (
         alu_a_in_sel => alu_a_in_sel_dc,
         raux_dc      => raux_dc,
         rdat_dc      => rdat_dc,
         rptr_dc      => rptr_dc,
         a            => a
      );
   alu_b_mux_i : alu_b_mux
      PORT MAP (
         alu_b_in_sel => alu_b_in_sel_dc,
         imm_dc       => imm_dc,
         raux_dc      => raux_dc,
         rdat_dc      => rdat_dc,
         rptr_dc      => rptr_dc,
         b            => b
      );
   at_reg_i : at_reg
      PORT MAP (
         clk           => clk,
         ctrl_me       => ctrl_me,
         imm_me        => imm_me,
         raux_me       => raux_me,
         rdat_me       => rdat_me,
         rdst_ix_me    => rdst_ix_me,
         res_at_u      => res_at_u,
         res_n         => res_n,
         rptr_me       => rptr_me,
         stall         => stall,
         allocating_wb => allocating_wb,
         rd_wb         => rd_wb,
         rdst_ix_at    => rdst_ix_at,
         res_at        => res_at
      );
   at_res_mux_i : at_res_mux
      PORT MAP (
         ctrl_me  => ctrl_me,
         dt_at_u  => dt_at_u,
         pi_at_u  => pi_at_u,
         res_me   => res_me,
         res_at_u => res_at_u
      );
   clr_ptr_end_addr_mux_i : clr_ptr_end_addr_mux
      PORT MAP (
         raux_ex    => raux_ex,
         rdst_ix_ex => rdst_ix_ex,
         rptr_ex    => rptr_ex,
         end_addr   => end_addr
      );
   csr_rf_mux_i : csr_rf_mux
      PORT MAP (
         csr_val   => csr_val,
         raux_rf   => raux_rf,
         rdat_ix   => rdat_ix,
         rdat_rf   => rdat_rf,
         rptr_ix   => rptr_ix,
         rptr_rf   => rptr_rf,
         raux_dc_u => raux_dc_u,
         rdat_dc_u => rdat_dc_u,
         rptr_dc_u => rptr_dc_u
      );
   csr_unit_i : csr_unit
      PORT MAP (
         clk            => clk,
         csr_ix         => csr_ix,
         rd_wb          => rd_wb,
         res_n          => res_n,
         csr_val        => csr_val,
         heap_overflow  => heap_overflow,
         stack_overflow => stack_overflow
      );
   dc_reg_i : dc_reg
      PORT MAP (
         clk             => clk,
         ctrl_dc_u       => ctrl_dc_u,
         dbt_valid       => dbt_valid,
         heap_overflow   => heap_overflow,
         imm_dc_u        => imm_dc_u,
         pc_if           => pc_if,
         raux_dc_u       => raux_dc_u,
         rdat_dc_u       => rdat_dc_u,
         rdst_ix_dc_u    => rdst_ix_dc_u,
         res_n           => res_n,
         rptr_dc_u       => rptr_dc_u,
         stack_overflow  => stack_overflow,
         stall           => stall,
         alu_a_in_sel_dc => alu_a_in_sel_dc,
         alu_b_in_sel_dc => alu_b_in_sel_dc,
         alu_mode_dc     => alu_mode_dc,
         branch_mode_dc  => branch_mode_dc,
         ctrl_dc         => ctrl_dc,
         imm_dc_reg      => imm_dc_reg,
         pc_dc           => pc_dc,
         pgu_mode_dc     => pgu_mode_dc,
         raux_dc_reg     => raux_dc_reg,
         rdat_dc_reg     => rdat_dc_reg,
         rdst_ix_dc_reg  => rdst_ix_dc_reg,
         rptr_dc_reg     => rptr_dc_reg
      );
   dc_i : dc_wrapper
      PORT MAP (
         addr               => me_addr,
         clk                => clk,
         mode               => me_mode_ex,
         next_addr          => me_addr_uq,
         next_mode          => me_mode_ex_uq,
         next_obj_init_addr => next_obj_init_addr,
         obj_init_addr      => obj_init_addr,
         obj_init_data      => obj_init_data,
         obj_init_wr        => obj_init_wr,
         rack               => dc_rack,
         rdata              => dc_rdata,
         res_n              => res_n,
         sd_raux            => raux_dc_uq,
         sd_rdat            => rdat_dc_uq,
         sd_rptr            => rptr_dc_uq,
         wack               => dc_wack,
         ld                 => mem_out_me_u,
         raddr              => dc_raddr,
         rreq               => dc_rreq,
         stall              => dc_stall,
         waddr              => dc_waddr,
         wdata              => dc_wdata,
         wreq               => dc_wreq
      );
   decoder_i : decoder
      PORT MAP (
         pc          => pc_if,
         instruction => if_instr,
         rdat_ix     => rdat_ix,
         rptr_ix     => rptr_ix,
         raux_ix     => raux_ix,
         csr_ix      => csr_ix,
         rdst_ix     => rdst_ix_dec,
         imm         => imm_dec,
         ctr_sig     => ctrl_dc_dec,
         sbt_valid   => sbt_valid,
         sbt         => sbt
      );
   dbu_i : dyn_branch_unit
      PORT MAP (
         rdat           => rdat_dc,
         raux           => raux_dc,
         rptr           => rptr_dc,
         imm            => imm_dc,
         rdst_ix        => rdst_ix_dc,
         alu_flags      => flags,
         branch_mode    => branch_mode_dc,
         pc             => pc_dc,
         dyn_branch_tgt => alu_out_ex_u,
         state_error    => state_error_dbu,
         ra_out         => dbu_out_ex_u,
         dbt_valid      => dbt_valid,
         dbt            => dbt
      );
   ex_reg_i : ex_reg
      PORT MAP (
         clk                           => clk,
         ctrl_dc                       => ctrl_dc,
         frame_type_exception          => frame_type_exception,
         imm_dc                        => imm_dc,
         index_out_of_bounds_exception => index_out_of_bounds_exception,
         me_addr_u                     => me_addr_u,
         raux_dc                       => raux_dc,
         rdat_dc                       => rdat_dc,
         rdst_ix_dc                    => rdst_ix_dc,
         res_ex_u                      => res_ex_u,
         res_n                         => res_n,
         rptr_dc                       => rptr_dc,
         stall                         => stall,
         state_error_dbu               => state_error_dbu,
         state_error_pgu               => state_error_pgu,
         allocating_me                 => allocating_me,
         ctrl_ex                       => ctrl_ex,
         imm_ex_reg                    => imm_ex_reg,
         me_addr                       => me_addr,
         me_addr_uq                    => me_addr_uq,
         me_mode_ex                    => me_mode_ex,
         me_mode_ex_uq                 => me_mode_ex_uq,
         pgu_mode_ex                   => pgu_mode_ex,
         raux_dc_uq                    => raux_dc_uq,
         raux_ex_reg                   => raux_ex_reg,
         rdat_dc_uq                    => rdat_dc_uq,
         rdat_ex_reg                   => rdat_ex_reg,
         rdst_ix_ex_reg                => rdst_ix_ex_reg,
         res_ex                        => res_ex,
         res_ex_uq                     => res_ex_uq,
         rptr_dc_uq                    => rptr_dc_uq,
         rptr_ex_reg                   => rptr_ex_reg
      );
   ex_res_mux_i : ex_res_mux
      PORT MAP (
         alu_out_ex_u   => alu_out_ex_u,
         branch_mode_dc => branch_mode_dc,
         dbu_out_ex_u   => dbu_out_ex_u,
         pgu_mode_dc    => pgu_mode_dc,
         pgu_ptr_ex_u   => pgu_ptr_ex_u,
         raux_dc        => raux_dc,
         res_ex_u       => res_ex_u
      );
   fwd_ex_i : fwd_unit
      PORT MAP (
         fwd_0     => allocating_me,
         fwd_1     => allocating_at,
         fwd_2     => allocating_wb,
         fwd_idx_0 => rdst_ix_ex_reg,
         fwd_idx_1 => rdst_ix_me,
         fwd_idx_2 => rdst_ix_at,
         fwd_res_0 => res_ex,
         fwd_res_1 => res_me,
         fwd_res_2 => res_at,
         imm_reg   => imm_dc_reg,
         raux_reg  => raux_dc_reg,
         rdat_reg  => rdat_dc_reg,
         rdst_reg  => rdst_ix_dc_reg,
         rptr_reg  => rptr_dc_reg,
         imm_fwd   => imm_dc,
         raux_fwd  => raux_dc,
         rdat_fwd  => rdat_dc,
         rdst_fwd  => rdst_ix_dc,
         rptr_fwd  => rptr_dc
      );
   fwd_me_i : fwd_unit
      PORT MAP (
         fwd_0     => false_sig,
         fwd_1     => false_sig,
         fwd_2     => false_sig,
         fwd_idx_0 => rdst_ix_me_reg,
         fwd_idx_1 => zero_reg_ix,
         fwd_idx_2 => zero_reg_ix,
         fwd_res_0 => res_me,
         fwd_res_1 => res_wb,
         fwd_res_2 => REG_MEM_NULL_SIG,
         imm_reg   => imm_ex_reg,
         raux_reg  => raux_ex_reg,
         rdat_reg  => rdat_ex_reg,
         rdst_reg  => rdst_ix_ex_reg,
         rptr_reg  => rptr_ex_reg,
         imm_fwd   => imm_ex,
         raux_fwd  => raux_ex,
         rdat_fwd  => rdat_ex,
         rdst_fwd  => rdst_ix_ex,
         rptr_fwd  => rptr_ex
      );
   ic_i : ic_wrapper
      PORT MAP (
         pc       => pc_current_pc,
         next_pc  => current_pc_uq,
         clk      => clk,
         res_n    => res_n,
         instr    => if_instr_d,
         stall    => ic_stall,
         sbranch  => sbt_valid,
         dbranch  => dbt_valid,
         ic_rreq  => ic_rreq,
         ic_rack  => ic_rack,
         ic_raddr => ic_raddr,
         ic_rdata => ic_rdata
      );
   if_reg_i : if_reg
      PORT MAP (
         clk           => clk,
         dbt_valid     => dbt_valid,
         if_instr_d    => if_instr_d,
         insert_nop    => insert_nop,
         pc_current_pc => pc_current_pc,
         res_n         => res_n,
         sbt_valid     => sbt_valid,
         stall         => stall,
         if_instr      => if_instr,
         pc_if         => pc_if
      );
   me_reg_i : me_reg
      PORT MAP (
         clk           => clk,
         ctrl_ex       => ctrl_ex,
         imm_ex        => imm_ex,
         raux_ex       => raux_ex,
         rdat_ex       => rdat_ex,
         rdst_ix_ex    => rdst_ix_ex,
         res_me_u      => res_me_u,
         res_n         => res_n,
         rptr_ex       => rptr_ex,
         stall         => stall,
         addr_me       => addr_me,
         addr_me_uq    => addr_me_uq,
         allocating_at => allocating_at,
         ctrl_me       => ctrl_me,
         imm_me        => imm_me,
         ld_attr       => ld_attr,
         raux_me       => raux_me,
         rdat_me       => rdat_me,
         rdst_ix_me    => rdst_ix_me,
         res_me        => res_me,
         rptr_me       => rptr_me
      );
   me_res_mux_i : me_res_mux
      PORT MAP (
         ctrl_ex      => ctrl_ex,
         mem_out_me_u => mem_out_me_u,
         raux_ex      => raux_ex,
         res_ex       => res_ex,
         res_me_u     => res_me_u
      );
   next_pc_mux_i : next_pc_mux
      PORT MAP (
         incremented_pc    => incremented_pc,
         static_branch_pc  => sbt,
         dynamic_branch_pc => dbt,
         dbta_valid        => dbt_valid,
         sbta_valid        => sbt_valid,
         next_pc           => current_pc_d
      );
   nop_gen_i : nop_gen
      PORT MAP (
         ctrl_dc_dec  => ctrl_dc_dec,
         ctrl_dc_u    => ctrl_dc_u,
         imm_dc_u     => imm_dc_u,
         imm_dec      => imm_dec,
         insert_nop   => insert_nop,
         rdst_ix_dc_u => rdst_ix_dc_u,
         rdst_ix_dec  => rdst_ix_dec
      );
   obj_init_fsm_i : obj_init_fsm
      PORT MAP (
         clk                => clk,
         dc_stall           => dc_stall,
         end_addr           => end_addr,
         pgu_mode_ex        => pgu_mode_ex,
         res_ex             => res_ex,
         res_ex_uq          => res_ex_uq,
         res_n              => res_n,
         next_obj_init_addr => next_obj_init_addr,
         obj_init_addr      => obj_init_addr,
         obj_init_data      => obj_init_data,
         obj_init_stall     => obj_init_stall,
         obj_init_wr        => obj_init_wr
      );
   pc_increment_i : pc_incrementer
      PORT MAP (
         pc      => pc_current_pc,
         next_pc => incremented_pc
      );
   pc_reg_i : pc_reg
      PORT MAP (
         clk           => clk,
         current_pc_d  => current_pc_d,
         dbt_valid     => dbt_valid,
         insert_nop    => insert_nop,
         res_n         => res_n,
         sbt_valid     => sbt_valid,
         stall         => stall,
         current_pc_uq => current_pc_uq,
         pc_current_pc => pc_current_pc
      );
   pgu_i : pgu
      PORT MAP (
         imm                           => imm_dc,
         pc                            => pc_dc,
         pgu_mode                      => pgu_mode_dc,
         raux                          => raux_dc,
         rdat                          => rdat_dc,
         rdst_ix                       => rdst_ix_dc,
         rptr                          => rptr_dc,
         frame_type_exception          => frame_type_exception,
         index_out_of_bounds_exception => index_out_of_bounds_exception,
         me_addr                       => me_addr_u,
         ptr                           => pgu_ptr_ex_u,
         state_error_exception         => state_error_pgu
      );
   ral_nop_i : ral_nop_unit
      PORT MAP (
         ctrl_if    => ctrl_dc_dec,
         ctrl_dc    => ctrl_dc,
         ctrl_ex    => ctrl_ex,
         rdat_ix    => rdat_ix,
         raux_ix    => raux_ix,
         rptr_ix    => rptr_ix,
         rdst_dc    => rdst_ix_dc,
         rdst_ex    => rdst_ix_ex,
         dbt_valid  => dbt_valid,
         insert_nop => insert_nop
      );
   register_file_i : register_file
      PORT MAP (
         clk     => clk,
         res_n   => res_n,
         rdat_ix => rdat_ix,
         rptr_ix => rptr_ix,
         raux_ix => raux_ix,
         rdat    => rdat_rf,
         rptr    => rptr_rf,
         raux    => raux_rf,
         rd_wb   => rd_wb
      );
   stall_i : stall_logic
      PORT MAP (
         ac_stall       => ac_stall,
         dc_stall       => dc_stall,
         ic_stall       => ic_stall,
         obj_init_stall => obj_init_stall,
         stall          => stall
      );

END struct;
