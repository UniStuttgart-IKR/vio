--
-- VHDL Architecture riscvio_lib.riscvio.struct
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY riscvio_lib;
USE riscvio_lib.isa.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;


ARCHITECTURE struct OF riscvio IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL REG_MEM_NULL_SIG              : reg_mem_T;
   SIGNAL a                             : word_T;
   SIGNAL addr_me_uq                    : reg_mem_T;
   SIGNAL allocating_at                 : boolean;
   SIGNAL allocating_me                 : boolean                      := false;
   SIGNAL allocating_wb                 : boolean;
   SIGNAL alu_a_in_sel_dc               : alu_in_sel_T;
   SIGNAL alu_b_in_sel_dc               : alu_in_sel_T;
   SIGNAL alu_mode_dc                   : alu_mode_T;
   SIGNAL alu_out_ex_u                  : word_T;
   SIGNAL at_mode_me                    : at_mode_T;
   SIGNAL b                             : word_T;
   SIGNAL branch_mode_dc                : branch_mode_T;
   SIGNAL byteena_b                     : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '1');
   SIGNAL csr_ix                        : csr_ix_T;
   SIGNAL csr_val                       : word_T;
   SIGNAL ctrl_dc                       : ctrl_sig_T;
   SIGNAL ctrl_dc_u                     : ctrl_sig_t;
   SIGNAL ctrl_ex                       : ctrl_sig_T;
   SIGNAL ctrl_me                       : ctrl_sig_T;
   SIGNAL current_pc_d                  : pc_T;
   SIGNAL current_pc_uq                 : pc_T;
   SIGNAL data_b                        : STD_LOGIC_VECTOR(63 DOWNTO 0);
   SIGNAL dbt                           : pc_T;
   SIGNAL dbt_valid                     : boolean;
   SIGNAL dram_address_a                : word_T;
   SIGNAL dram_byteena_a                : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL dram_data_a                   : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL dram_wren_a                   : STD_LOGIC;
   SIGNAL dt_at_u                       : word_T;
   SIGNAL end_addr                      : word_T;
   SIGNAL false_sig                     : boolean;
   SIGNAL flags                         : alu_flags_T;
   SIGNAL frame_type_exception          : boolean;
   SIGNAL heap_overflow                 : boolean;
   SIGNAL if_instr                      : word_T;
   SIGNAL if_instr_d                    : word_T;
   SIGNAL imm_dc                        : word_T;
   SIGNAL imm_dc_reg                    : word_T;
   SIGNAL imm_dc_u                      : word_T;
   SIGNAL imm_ex                        : word_T;
   SIGNAL imm_ex_reg                    : word_T;
   SIGNAL imm_me                        : word_T;
   SIGNAL incremented_pc                : pc_T;
   SIGNAL index_out_of_bounds_exception : boolean;
   SIGNAL me_mode_dc_uq                 : mem_mode_t;
   SIGNAL me_mode_ex                    : mem_mode_T;
   SIGNAL mem_out_me_u                  : word_T;
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
   SIGNAL ra_ex_u                       : reg_mem_T;
   SIGNAL ram_addr_at                   : std_logic_vector(8 DOWNTO 0);
   SIGNAL ram_addr_me                   : STD_LOGIC_VECTOR(9 DOWNTO 0);
   SIGNAL ram_byteena_me                : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '1');
   SIGNAL ram_rdata_at                  : std_logic_vector(63 DOWNTO 0);
   SIGNAL ram_rdata_me                  : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL ram_wdata_me                  : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL ram_wren_me                   : STD_LOGIC                    := '0';
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
   SIGNAL rdat_ex                       : rdat_T;
   SIGNAL rdat_ex_reg                   : rdat_T;
   SIGNAL rdat_ix                       : reg_ix_T;
   SIGNAL rdat_me                       : rdat_T;
   SIGNAL rdat_rf                       : rdat_T;
   SIGNAL rdst_ix_at                    : reg_ix_T;
   SIGNAL rdst_ix_dc                    : reg_ix_T;
   SIGNAL rdst_ix_dc_reg                : reg_ix_T;
   SIGNAL rdst_ix_dc_u                  : reg_ix_T;
   SIGNAL rdst_ix_ex                    : reg_ix_T;
   SIGNAL rdst_ix_ex_reg                : reg_ix_T;
   SIGNAL rdst_ix_me                    : reg_ix_T                     := 0;
   SIGNAL rdst_ix_me_reg                : reg_ix_T                     := 0;
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
   SIGNAL state_error_dbu               : boolean;
   SIGNAL state_error_pgu               : boolean;
   SIGNAL wren_b                        : STD_LOGIC                    := '0';
   SIGNAL zero_reg_ix                   : reg_ix_T                     := 0;


   -- Component Declarations
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
      pc           : IN     pc_T ;
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
      clk            : IN     std_logic ;
      ctrl_me        : IN     ctrl_sig_T ;
      imm_me         : IN     word_T ;
      obj_init_stall : IN     boolean ;
      raux_me        : IN     raux_T ;
      rdat_me        : IN     rdat_T ;
      rdst_ix_me     : IN     reg_ix_T ;
      res_at_u       : IN     reg_mem_T ;
      res_n          : IN     std_logic ;
      rptr_me        : IN     rptr_T ;
      allocating_wb  : OUT    boolean ;
      rd_wb          : OUT    reg_wb_T ;
      rdst_ix_at     : OUT    reg_ix_T ;
      res_at         : OUT    reg_mem_T 
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
   COMPONENT attr_load_unit
   PORT (
      addr_me_uq   : IN     reg_mem_T ;
      at_mode_me   : IN     at_mode_T ;
      ram_rdata_at : IN     std_logic_vector (63 DOWNTO 0);
      dt_at_u      : OUT    word_T ;
      pi_at_u      : OUT    word_T ;
      ram_addr_at  : OUT    std_logic_vector (8 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT block_ram_if
   PORT (
      addr           : IN     reg_mem_T ;
      dram_q_a       : IN     STD_LOGIC_VECTOR (31 DOWNTO 0);
      mode           : IN     mem_mode_T ;
      mode_u         : IN     mem_mode_T ;
      raux           : IN     raux_T ;
      rptr           : IN     rptr_T ;
      dram_address_a : OUT    word_T ;
      dram_byteena_a : OUT    STD_LOGIC_VECTOR (3 DOWNTO 0);
      dram_data_a    : OUT    STD_LOGIC_VECTOR (31 DOWNTO 0);
      dram_wren_a    : OUT    STD_LOGIC ;
      mem_out        : OUT    word_T 
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
      ctrl_dc_u       : IN     ctrl_sig_t ;
      dbt_valid       : IN     boolean ;
      heap_overflow   : IN     boolean ;
      imm_dc_u        : IN     word_T ;
      obj_init_stall  : IN     boolean ;
      pc_if           : IN     pc_T ;
      raux_dc_u       : IN     raux_T ;
      rdat_dc_u       : IN     rdat_T ;
      rdst_ix_dc_u    : IN     reg_ix_T ;
      res_n           : IN     std_logic ;
      rptr_dc_u       : IN     rptr_T ;
      stack_overflow  : IN     boolean ;
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
   COMPONENT dcbr_wraccess_mux
   PORT (
      dram_address_a : IN     word_T ;
      dram_byteena_a : IN     STD_LOGIC_VECTOR (3 DOWNTO 0);
      dram_data_a    : IN     STD_LOGIC_VECTOR (31 DOWNTO 0);
      dram_wren_a    : IN     STD_LOGIC ;
      obj_init_addr  : IN     word_T ;
      obj_init_data  : IN     word_T ;
      obj_init_wr    : IN     boolean ;
      ram_addr_me    : OUT    STD_LOGIC_VECTOR (9 DOWNTO 0);
      ram_byteena_me : OUT    STD_LOGIC_VECTOR (3 DOWNTO 0);
      ram_wdata_me   : OUT    STD_LOGIC_VECTOR (31 DOWNTO 0);
      ram_wren_me    : OUT    STD_LOGIC 
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
   COMPONENT dual_port_memory
   PORT (
      address_a : IN     STD_LOGIC_VECTOR (9 DOWNTO 0);
      address_b : IN     STD_LOGIC_VECTOR (8 DOWNTO 0);
      byteena_a : IN     STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
      byteena_b : IN     STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '1');
      clock     : IN     STD_LOGIC                     := '1';
      data_a    : IN     STD_LOGIC_VECTOR (31 DOWNTO 0);
      data_b    : IN     STD_LOGIC_VECTOR (63 DOWNTO 0);
      wren_a    : IN     STD_LOGIC                     := '0';
      wren_b    : IN     STD_LOGIC                     := '0';
      q_a       : OUT    STD_LOGIC_VECTOR (31 DOWNTO 0);
      q_b       : OUT    STD_LOGIC_VECTOR (63 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT dyn_branch_unit
   PORT (
      alu_flags      : IN     alu_flags_T;
      branch_mode    : IN     branch_mode_T;
      dyn_branch_tgt : IN     word_T;
      frame          : IN     raux_T;
      imm            : IN     word_T;
      pc             : IN     pc_T;
      ra_in          : IN     rptr_T;
      rdat           : IN     rdat_T;
      rdst_ix        : IN     reg_ix_T;
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
      obj_init_stall                : IN     boolean ;
      raux_dc                       : IN     raux_T ;
      rdat_dc                       : IN     rdat_T ;
      rdst_ix_dc                    : IN     reg_ix_T ;
      res_ex_u                      : IN     reg_mem_T ;
      res_n                         : IN     std_logic ;
      rptr_dc                       : IN     rptr_T ;
      state_error_dbu               : IN     boolean ;
      state_error_pgu               : IN     boolean ;
      allocating_me                 : OUT    boolean ;
      ctrl_ex                       : OUT    ctrl_sig_T ;
      imm_ex_reg                    : OUT    word_T ;
      me_mode_dc_uq                 : OUT    mem_mode_t ;
      me_mode_ex                    : OUT    mem_mode_T ;
      pgu_mode_ex                   : OUT    pgu_mode_T ;
      raux_dc_uq                    : OUT    raux_T ;
      raux_ex_reg                   : OUT    raux_T ;
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
      pgu_mode_dc    : IN     pgu_mode_T ;
      pgu_ptr_ex_u   : IN     reg_mem_T ;
      ra_ex_u        : IN     reg_mem_T ;
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
   COMPONENT if_reg
   PORT (
      clk            : IN     std_logic ;
      dbt_valid      : IN     boolean ;
      if_instr_d     : IN     word_T ;
      obj_init_stall : IN     boolean ;
      pc_current_pc  : IN     pc_T ;
      res_n          : IN     std_logic ;
      sbt_valid      : IN     boolean ;
      if_instr       : OUT    word_T ;
      pc_if          : OUT    pc_T 
   );
   END COMPONENT;
   COMPONENT instruction_rom
   PORT (
      clock : IN     STD_LOGIC  := '1';
      pc    : IN     pc_T;
      q     : OUT    STD_LOGIC_VECTOR (31 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT me_reg
   PORT (
      clk            : IN     std_logic ;
      ctrl_ex        : IN     ctrl_sig_T ;
      imm_ex         : IN     word_T ;
      obj_init_stall : IN     boolean ;
      raux_ex        : IN     raux_T ;
      rdat_ex        : IN     rdat_T ;
      rdst_ix_ex     : IN     reg_ix_T ;
      res_me_u       : IN     reg_mem_T ;
      res_n          : IN     std_logic ;
      rptr_ex        : IN     rptr_T ;
      addr_me_uq     : OUT    reg_mem_T ;
      allocating_at  : OUT    boolean ;
      at_mode_me     : OUT    at_mode_T ;
      ctrl_me        : OUT    ctrl_sig_T ;
      imm_me         : OUT    word_T ;
      raux_me        : OUT    raux_T ;
      rdat_me        : OUT    rdat_T ;
      rdst_ix_me     : OUT    reg_ix_T ;
      res_me         : OUT    reg_mem_T ;
      rptr_me        : OUT    rptr_T 
   );
   END COMPONENT;
   COMPONENT me_res_mux
   PORT (
      ctrl_ex      : IN     ctrl_sig_T ;
      mem_out_me_u : IN     word_T ;
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
   COMPONENT obj_init_fsm
   PORT (
      clk            : IN     std_logic ;
      end_addr       : IN     word_T ;
      pgu_mode_ex    : IN     pgu_mode_T ;
      res_ex         : IN     reg_mem_T ;
      res_n          : IN     std_logic ;
      obj_init_addr  : OUT    word_T ;
      obj_init_data  : OUT    word_T ;
      obj_init_stall : OUT    boolean ;
      obj_init_wr    : OUT    boolean 
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
      clk            : IN     std_logic ;
      current_pc_d   : IN     pc_T ;
      obj_init_stall : IN     boolean ;
      res_n          : IN     std_logic ;
      current_pc_uq  : OUT    pc_T ;
      pc_current_pc  : OUT    pc_T 
   );
   END COMPONENT;
   COMPONENT pgu
   PORT (
      imm                           : IN     word_T ;
      pgu_mode                      : IN     pgu_mode_T ;
      raux                          : IN     raux_T ;
      rdat                          : IN     rdat_T ;
      rdst_ix                       : IN     reg_ix_T ;
      rptr                          : IN     rptr_T ;
      frame_type_exception          : OUT    boolean ;
      index_out_of_bounds_exception : OUT    boolean ;
      ptr                           : OUT    reg_mem_T ;
      state_error_exception         : OUT    boolean 
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

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : alu USE ENTITY riscvio_lib.alu;
   FOR ALL : alu_a_mux USE ENTITY riscvio_lib.alu_a_mux;
   FOR ALL : alu_b_mux USE ENTITY riscvio_lib.alu_b_mux;
   FOR ALL : at_reg USE ENTITY riscvio_lib.at_reg;
   FOR ALL : at_res_mux USE ENTITY riscvio_lib.at_res_mux;
   FOR ALL : attr_load_unit USE ENTITY riscvio_lib.attr_load_unit;
   FOR ALL : block_ram_if USE ENTITY riscvio_lib.block_ram_if;
   FOR ALL : clr_ptr_end_addr_mux USE ENTITY riscvio_lib.clr_ptr_end_addr_mux;
   FOR ALL : csr_rf_mux USE ENTITY riscvio_lib.csr_rf_mux;
   FOR ALL : csr_unit USE ENTITY riscvio_lib.csr_unit;
   FOR ALL : dc_reg USE ENTITY riscvio_lib.dc_reg;
   FOR ALL : dcbr_wraccess_mux USE ENTITY riscvio_lib.dcbr_wraccess_mux;
   FOR ALL : decoder USE ENTITY riscvio_lib.decoder;
   FOR ALL : dual_port_memory USE ENTITY riscvio_lib.dual_port_memory;
   FOR ALL : dyn_branch_unit USE ENTITY riscvio_lib.dyn_branch_unit;
   FOR ALL : ex_reg USE ENTITY riscvio_lib.ex_reg;
   FOR ALL : ex_res_mux USE ENTITY riscvio_lib.ex_res_mux;
   FOR ALL : fwd_unit USE ENTITY riscvio_lib.fwd_unit;
   FOR ALL : if_reg USE ENTITY riscvio_lib.if_reg;
   FOR ALL : instruction_rom USE ENTITY riscvio_lib.instruction_rom;
   FOR ALL : me_reg USE ENTITY riscvio_lib.me_reg;
   FOR ALL : me_res_mux USE ENTITY riscvio_lib.me_res_mux;
   FOR ALL : next_pc_mux USE ENTITY riscvio_lib.next_pc_mux;
   FOR ALL : obj_init_fsm USE ENTITY riscvio_lib.obj_init_fsm;
   FOR ALL : pc_incrementer USE ENTITY riscvio_lib.pc_incrementer;
   FOR ALL : pc_reg USE ENTITY riscvio_lib.pc_reg;
   FOR ALL : pgu USE ENTITY riscvio_lib.pgu;
   FOR ALL : register_file USE ENTITY riscvio_lib.register_file;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 eb1
   -- eb1 1  
   byteena_b <= (others => '1');
   data_b <= (others => '0');
   wren_b <= '0';                                    

   -- HDL Embedded Text Block 2 eb2
   -- eb2 2  
   REG_MEM_NULL_SIG <= REG_MEM_NULL;
   ZERO_REG_IX <= ali_T'pos(zero);       
   false_sig <= false;                              


   -- Instance port mappings.
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
         pc           => pc_dc,
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
         clk            => clk,
         ctrl_me        => ctrl_me,
         imm_me         => imm_me,
         obj_init_stall => obj_init_stall,
         raux_me        => raux_me,
         rdat_me        => rdat_me,
         rdst_ix_me     => rdst_ix_me,
         res_at_u       => res_at_u,
         res_n          => res_n,
         rptr_me        => rptr_me,
         allocating_wb  => allocating_wb,
         rd_wb          => rd_wb,
         rdst_ix_at     => rdst_ix_at,
         res_at         => res_at
      );
   at_res_mux_i : at_res_mux
      PORT MAP (
         ctrl_me  => ctrl_me,
         dt_at_u  => dt_at_u,
         pi_at_u  => pi_at_u,
         res_me   => res_me,
         res_at_u => res_at_u
      );
   attr_ld_i : attr_load_unit
      PORT MAP (
         addr_me_uq   => addr_me_uq,
         at_mode_me   => at_mode_me,
         ram_rdata_at => ram_rdata_at,
         dt_at_u      => dt_at_u,
         pi_at_u      => pi_at_u,
         ram_addr_at  => ram_addr_at
      );
   block_ram_if_i : block_ram_if
      PORT MAP (
         addr           => res_ex_uq,
         dram_q_a       => ram_rdata_me,
         mode           => me_mode_ex,
         mode_u         => me_mode_dc_uq,
         raux           => raux_dc_uq,
         rptr           => rptr_dc_uq,
         dram_address_a => dram_address_a,
         dram_byteena_a => dram_byteena_a,
         dram_data_a    => dram_data_a,
         dram_wren_a    => dram_wren_a,
         mem_out        => mem_out_me_u
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
         obj_init_stall  => obj_init_stall,
         pc_if           => pc_if,
         raux_dc_u       => raux_dc_u,
         rdat_dc_u       => rdat_dc_u,
         rdst_ix_dc_u    => rdst_ix_dc_u,
         res_n           => res_n,
         rptr_dc_u       => rptr_dc_u,
         stack_overflow  => stack_overflow,
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
   dcbr_wraccs_mux_i : dcbr_wraccess_mux
      PORT MAP (
         dram_address_a => dram_address_a,
         dram_byteena_a => dram_byteena_a,
         dram_data_a    => dram_data_a,
         dram_wren_a    => dram_wren_a,
         obj_init_addr  => obj_init_addr,
         obj_init_data  => obj_init_data,
         obj_init_wr    => obj_init_wr,
         ram_addr_me    => ram_addr_me,
         ram_byteena_me => ram_byteena_me,
         ram_wdata_me   => ram_wdata_me,
         ram_wren_me    => ram_wren_me
      );
   decoder_i : decoder
      PORT MAP (
         pc          => pc_if,
         instruction => if_instr,
         rdat_ix     => rdat_ix,
         rptr_ix     => rptr_ix,
         raux_ix     => raux_ix,
         csr_ix      => csr_ix,
         rdst_ix     => rdst_ix_dc_u,
         imm         => imm_dc_u,
         ctr_sig     => ctrl_dc_u,
         sbt_valid   => sbt_valid,
         sbt         => sbt
      );
   dram : dual_port_memory
      PORT MAP (
         address_a => ram_addr_me,
         address_b => ram_addr_at,
         byteena_a => ram_byteena_me,
         byteena_b => byteena_b,
         clock     => clk,
         data_a    => ram_wdata_me,
         data_b    => data_b,
         wren_a    => ram_wren_me,
         wren_b    => wren_b,
         q_a       => ram_rdata_me,
         q_b       => ram_rdata_at
      );
   dbu_i : dyn_branch_unit
      PORT MAP (
         rdat           => rdat_dc,
         frame          => raux_dc,
         ra_in          => rptr_dc,
         imm            => imm_dc,
         rdst_ix        => rdst_ix_dc,
         alu_flags      => flags,
         branch_mode    => branch_mode_dc,
         pc             => pc_dc,
         dyn_branch_tgt => alu_out_ex_u,
         state_error    => state_error_dbu,
         ra_out         => ra_ex_u,
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
         obj_init_stall                => obj_init_stall,
         raux_dc                       => raux_dc,
         rdat_dc                       => rdat_dc,
         rdst_ix_dc                    => rdst_ix_dc,
         res_ex_u                      => res_ex_u,
         res_n                         => res_n,
         rptr_dc                       => rptr_dc,
         state_error_dbu               => state_error_dbu,
         state_error_pgu               => state_error_pgu,
         allocating_me                 => allocating_me,
         ctrl_ex                       => ctrl_ex,
         imm_ex_reg                    => imm_ex_reg,
         me_mode_dc_uq                 => me_mode_dc_uq,
         me_mode_ex                    => me_mode_ex,
         pgu_mode_ex                   => pgu_mode_ex,
         raux_dc_uq                    => raux_dc_uq,
         raux_ex_reg                   => raux_ex_reg,
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
         pgu_mode_dc    => pgu_mode_dc,
         pgu_ptr_ex_u   => pgu_ptr_ex_u,
         ra_ex_u        => ra_ex_u,
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
   if_reg_i : if_reg
      PORT MAP (
         clk            => clk,
         dbt_valid      => dbt_valid,
         if_instr_d     => if_instr_d,
         obj_init_stall => obj_init_stall,
         pc_current_pc  => pc_current_pc,
         res_n          => res_n,
         sbt_valid      => sbt_valid,
         if_instr       => if_instr,
         pc_if          => pc_if
      );
   irom_i : instruction_rom
      PORT MAP (
         pc    => current_pc_uq,
         clock => clk,
         q     => if_instr_d
      );
   me_reg_i : me_reg
      PORT MAP (
         clk            => clk,
         ctrl_ex        => ctrl_ex,
         imm_ex         => imm_ex,
         obj_init_stall => obj_init_stall,
         raux_ex        => raux_ex,
         rdat_ex        => rdat_ex,
         rdst_ix_ex     => rdst_ix_ex,
         res_me_u       => res_me_u,
         res_n          => res_n,
         rptr_ex        => rptr_ex,
         addr_me_uq     => addr_me_uq,
         allocating_at  => allocating_at,
         at_mode_me     => at_mode_me,
         ctrl_me        => ctrl_me,
         imm_me         => imm_me,
         raux_me        => raux_me,
         rdat_me        => rdat_me,
         rdst_ix_me     => rdst_ix_me,
         res_me         => res_me,
         rptr_me        => rptr_me
      );
   me_res_mux_i : me_res_mux
      PORT MAP (
         ctrl_ex      => ctrl_ex,
         mem_out_me_u => mem_out_me_u,
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
   obj_init_fsm_i : obj_init_fsm
      PORT MAP (
         clk            => clk,
         end_addr       => end_addr,
         pgu_mode_ex    => pgu_mode_ex,
         res_ex         => res_ex,
         res_n          => res_n,
         obj_init_addr  => obj_init_addr,
         obj_init_data  => obj_init_data,
         obj_init_stall => obj_init_stall,
         obj_init_wr    => obj_init_wr
      );
   pc_increment_i : pc_incrementer
      PORT MAP (
         pc      => pc_current_pc,
         next_pc => incremented_pc
      );
   pc_reg_i : pc_reg
      PORT MAP (
         clk            => clk,
         current_pc_d   => current_pc_d,
         obj_init_stall => obj_init_stall,
         res_n          => res_n,
         current_pc_uq  => current_pc_uq,
         pc_current_pc  => pc_current_pc
      );
   pgu_i : pgu
      PORT MAP (
         imm                           => imm_dc,
         pgu_mode                      => pgu_mode_dc,
         raux                          => raux_dc,
         rdat                          => rdat_dc,
         rdst_ix                       => rdst_ix_dc,
         rptr                          => rptr_dc,
         frame_type_exception          => frame_type_exception,
         index_out_of_bounds_exception => index_out_of_bounds_exception,
         ptr                           => pgu_ptr_ex_u,
         state_error_exception         => state_error_pgu
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

END struct;
