onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /riscvio_tb/riscvio_i/dc_reg_i/clk
add wave -noupdate /riscvio_tb/riscvio_i/dc_reg_i/res_n
add wave -noupdate -color Turquoise -itemcolor {Light Blue} /riscvio_tb/riscvio_i/if_reg_i/pc_if
add wave -noupdate -color Turquoise -itemcolor {Light Blue} /riscvio_tb/riscvio_i/if_reg_i/if_instr
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/ctrl_dc.mnemonic
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/rdst_ix_dc
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/rdat_dc.ali
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/rdat_dc.val
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/rptr_dc.ali
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/rptr_dc.val
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/rptr_dc.pi
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/rptr_dc.dt
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/raux_dc.ali
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/raux_dc.tag
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/raux_dc.val
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/imm_dc
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/alu_mode_dc
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/alu_a_in_sel
add wave -noupdate -color Magenta -itemcolor Plum /riscvio_tb/riscvio_i/dc_reg_i/alu_b_in_sel
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/ctrl_ex.mnemonic
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/rdst_ix_ex
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/rdat_ex.ali
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/rdat_ex.val
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/rptr_ex.ali
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/rptr_ex.val
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/rptr_ex.pi
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/rptr_ex.dt
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/raux_ex.ali
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/raux_ex.tag
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/raux_ex.val
add wave -noupdate -color Yellow -itemcolor Khaki /riscvio_tb/riscvio_i/ex_reg_i/imm_ex
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/ctrl_me.mnemonic
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/rdst_ix_me
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/rdat_me.ali
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/rdat_me.val
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/rptr_me.ali
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/rptr_me.val
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/rptr_me.pi
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/rptr_me.dt
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/raux_me.ali
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/raux_me.tag
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/raux_me.val
add wave -noupdate -color {Spring Green} -itemcolor {Pale Green} /riscvio_tb/riscvio_i/me_reg_i/imm_me
add wave -noupdate -color Gray60 -itemcolor Gray90 /riscvio_tb/riscvio_i/at_reg_i/rd_wb.ali
add wave -noupdate -color Gray60 -itemcolor Gray90 /riscvio_tb/riscvio_i/at_reg_i/rd_wb.mem.tag
add wave -noupdate -color Gray60 -itemcolor Gray90 /riscvio_tb/riscvio_i/at_reg_i/rd_wb.mem.data
add wave -noupdate -color Gray60 -itemcolor Gray90 /riscvio_tb/riscvio_i/at_reg_i/rd_wb.mem.pi
add wave -noupdate -color Gray60 -itemcolor Gray90 /riscvio_tb/riscvio_i/at_reg_i/rd_wb.mem.delta
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 296
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {947 ns}
