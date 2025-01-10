onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /riscvio_tb/riscvio_i/dc_reg_i/clk
add wave -noupdate /riscvio_tb/riscvio_i/dc_reg_i/res_n
add wave -noupdate /riscvio_tb/riscvio_i/obj_init_stall
add wave -noupdate -expand -group PC -color Orange -itemcolor Goldenrod -radix hexadecimal /riscvio_tb/riscvio_i/next_pc_mux_i/dynamic_branch_pc.ix
add wave -noupdate -expand -group PC -color Orange -itemcolor Goldenrod /riscvio_tb/riscvio_i/next_pc_mux_i/dbta_valid
add wave -noupdate -expand -group PC -color Orange -itemcolor Goldenrod -radix hexadecimal /riscvio_tb/riscvio_i/next_pc_mux_i/static_branch_pc.ix
add wave -noupdate -expand -group PC -color Orange -itemcolor Goldenrod /riscvio_tb/riscvio_i/next_pc_mux_i/sbta_valid
add wave -noupdate -expand -group PC -color Orange -itemcolor Goldenrod -radix hexadecimal /riscvio_tb/riscvio_i/next_pc_mux_i/incremented_pc.ix
add wave -noupdate -expand -group PC -color Orange -itemcolor Goldenrod -radix hexadecimal -childformat {{/riscvio_tb/riscvio_i/next_pc_mux_i/next_pc.ptr -radix hexadecimal} {/riscvio_tb/riscvio_i/next_pc_mux_i/next_pc.ix -radix hexadecimal} {/riscvio_tb/riscvio_i/next_pc_mux_i/next_pc.pi -radix hexadecimal} {/riscvio_tb/riscvio_i/next_pc_mux_i/next_pc.dt -radix hexadecimal}} -expand -subitemconfig {/riscvio_tb/riscvio_i/next_pc_mux_i/next_pc.ptr {-color Orange -height 21 -itemcolor Goldenrod -radix hexadecimal} /riscvio_tb/riscvio_i/next_pc_mux_i/next_pc.ix {-color Orange -height 21 -itemcolor Goldenrod -radix hexadecimal} /riscvio_tb/riscvio_i/next_pc_mux_i/next_pc.pi {-color Orange -height 21 -itemcolor Goldenrod -radix hexadecimal} /riscvio_tb/riscvio_i/next_pc_mux_i/next_pc.dt {-color Orange -height 21 -itemcolor Goldenrod -radix hexadecimal}} /riscvio_tb/riscvio_i/next_pc_mux_i/next_pc
add wave -noupdate -expand -group DC -color Turquoise -itemcolor {Light Blue} -radix hexadecimal -childformat {{/riscvio_tb/riscvio_i/if_reg_i/pc_if.ptr -radix hexadecimal} {/riscvio_tb/riscvio_i/if_reg_i/pc_if.ix -radix hexadecimal} {/riscvio_tb/riscvio_i/if_reg_i/pc_if.pi -radix hexadecimal} {/riscvio_tb/riscvio_i/if_reg_i/pc_if.dt -radix hexadecimal}} -subitemconfig {/riscvio_tb/riscvio_i/if_reg_i/pc_if.ptr {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/if_reg_i/pc_if.ix {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/if_reg_i/pc_if.pi {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/if_reg_i/pc_if.dt {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal}} /riscvio_tb/riscvio_i/if_reg_i/pc_if
add wave -noupdate -expand -group DC -color Turquoise -itemcolor {Light Blue} -radix hexadecimal /riscvio_tb/riscvio_i/if_reg_i/if_instr
add wave -noupdate -expand -group DC -color Cyan -itemcolor {Light Blue} -radix hexadecimal -childformat {{/riscvio_tb/riscvio_i/register_file_i/registers(t6) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(t5) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(t4) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(t3) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(cnst) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(bm) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(s9) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(s8) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(s7) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(s6) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(s5) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(s4) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(s3) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(s2) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(a7) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(a6) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(a5) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(a4) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(a3) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(a2) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(a1) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(a0) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(s1) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(s0) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(t2) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(t1) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(t0) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(ctxt) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(rcd) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(frame) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(rix) -radix hexadecimal} {/riscvio_tb/riscvio_i/register_file_i/registers(zero) -radix hexadecimal}} -subitemconfig {/riscvio_tb/riscvio_i/register_file_i/registers(t6) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(t5) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(t4) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(t3) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(cnst) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(bm) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(s9) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(s8) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(s7) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(s6) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(s5) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(s4) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(s3) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(s2) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(a7) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(a6) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(a5) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(a4) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(a3) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(a2) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(a1) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(a0) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(s1) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(s0) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(t2) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(t1) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(t0) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(ctxt) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(rcd) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(frame) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(rix) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/register_file_i/registers(zero) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal}} /riscvio_tb/riscvio_i/register_file_i/registers
add wave -noupdate -expand -group DC -color Cyan -itemcolor {Light Blue} -radix hexadecimal -childformat {{/riscvio_tb/riscvio_i/csr_unit_i/csrs(alc_lim) -radix hexadecimal} {/riscvio_tb/riscvio_i/csr_unit_i/csrs(alc_addr) -radix hexadecimal} {/riscvio_tb/riscvio_i/csr_unit_i/csrs(frame_lim) -radix hexadecimal} {/riscvio_tb/riscvio_i/csr_unit_i/csrs(core) -radix hexadecimal} {/riscvio_tb/riscvio_i/csr_unit_i/csrs(root) -radix hexadecimal}} -expand -subitemconfig {/riscvio_tb/riscvio_i/csr_unit_i/csrs(alc_lim) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/csr_unit_i/csrs(alc_addr) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/csr_unit_i/csrs(frame_lim) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/csr_unit_i/csrs(core) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_tb/riscvio_i/csr_unit_i/csrs(root) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal}} /riscvio_tb/riscvio_i/csr_unit_i/csrs
add wave -noupdate -expand -group DC -color Cyan -itemcolor {Light Blue} /riscvio_tb/riscvio_i/ctrl_dc_u.mnemonic
add wave -noupdate -expand -group DC -color Cyan -itemcolor {Light Blue} -radix hexadecimal /riscvio_tb/riscvio_i/csr_val
add wave -noupdate -expand -group DC /riscvio_tb/riscvio_i/ctrl_dc_u
add wave -noupdate -expand -group DC /riscvio_tb/riscvio_i/raux_dc_u
add wave -noupdate -expand -group DC /riscvio_tb/riscvio_i/rdat_dc_u
add wave -noupdate -expand -group DC /riscvio_tb/riscvio_i/rptr_dc_u
add wave -noupdate -expand -group EX /riscvio_tb/riscvio_i/rdst_ix_ex_reg
add wave -noupdate -expand -group EX /riscvio_tb/riscvio_i/rdst_ix_me_reg
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/ctrl_dc.mnemonic
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/ctrl_dc.branch_mode
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/alu_mode_dc
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/pgu_mode_dc
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/frame_type_exception
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/index_out_of_bounds_exception
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/state_error_exception
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/rdst_ix_dc
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/rdat_dc.ali
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum -radix hexadecimal /riscvio_tb/riscvio_i/fwd_ex_i/rdat_fwd.val
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/rdat_dc.val
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum -radix hexadecimal /riscvio_tb/riscvio_i/dc_reg_i/rdat_dc_reg.val
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/rptr_dc.ali
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/rptr_dc_reg.val
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/rptr_dc.val
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/rptr_dc_reg.pi
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/rptr_dc.pi
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/rptr_dc_reg.dt
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/rptr_dc.dt
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/raux_dc.ali
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/raux_dc.tag
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/raux_dc_reg.val
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/raux_dc.val
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/imm_dc
add wave -noupdate -expand -group EX /riscvio_tb/riscvio_i/alu_out_ex_u
add wave -noupdate -expand -group EX /riscvio_tb/riscvio_i/pgu_ptr_ex_u
add wave -noupdate -expand -group EX /riscvio_tb/riscvio_i/res_ex_u
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/ctrl_ex.mnemonic
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/rdst_ix_ex
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/rdat_ex.ali
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki -radix hexadecimal /riscvio_tb/riscvio_i/fwd_me_i/rdat_fwd.val
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/rdat_ex.val
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/rptr_ex.ali
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/rptr_ex_reg.val
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/rptr_ex.val
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/rptr_ex_reg.pi
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/rptr_ex.pi
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/rptr_ex_reg.dt
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/rptr_ex.dt
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/raux_ex.ali
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/raux_ex.tag
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/raux_ex_reg.val
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/raux_ex.val
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/res_ex
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/ctrl_me.mnemonic
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/rdst_ix_me
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/rdat_me.ali
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_tb/riscvio_i/me_reg_i/rdat_me.val
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/rptr_me.ali
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_tb/riscvio_i/me_reg_i/rptr_me.val
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_tb/riscvio_i/me_reg_i/rptr_me.pi
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_tb/riscvio_i/me_reg_i/rptr_me.dt
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/raux_me.ali
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/raux_me.tag
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_tb/riscvio_i/me_reg_i/raux_me.val
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_tb/riscvio_i/me_reg_i/imm_me
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/res_me
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 /riscvio_tb/riscvio_i/at_reg_i/rd_wb.ali
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 /riscvio_tb/riscvio_i/at_reg_i/rd_wb.mem.tag
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 -radix hexadecimal /riscvio_tb/riscvio_i/at_reg_i/rd_wb.mem.data
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 -radix hexadecimal /riscvio_tb/riscvio_i/at_reg_i/rd_wb.mem.pi
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 -radix hexadecimal /riscvio_tb/riscvio_i/at_reg_i/rd_wb.mem.delta
add wave -noupdate -expand -group WB -color Gray60 /riscvio_tb/riscvio_i/rd_wb.csr_index
add wave -noupdate -expand -group WB -color Gray60 /riscvio_tb/riscvio_i/rd_wb.rf_index
add wave -noupdate /riscvio_tb/riscvio_i/raux_ix
add wave -noupdate /riscvio_tb/riscvio_i/rdat_ix
add wave -noupdate /riscvio_tb/riscvio_i/rptr_ix
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {616 ns} 1} {{Cursor 2} {622 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 241
configure wave -valuecolwidth 163
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {328 ns} {905 ns}
