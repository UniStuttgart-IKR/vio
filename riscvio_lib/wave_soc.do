onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /riscvio_soc_tb/soc_i/riscvio_i/dc_reg_i/clk
add wave -noupdate /riscvio_soc_tb/soc_i/riscvio_i/dc_reg_i/res_n
add wave -noupdate /riscvio_soc_tb/U_1/res_n
add wave -noupdate /riscvio_soc_tb/soc_i/riscvio_i/stall
add wave -noupdate -group Global -color Cyan -itemcolor {Sky Blue} /riscvio_soc_tb/soc_i/riscvio_i/ic_stall
add wave -noupdate -group Global -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/dc_stall
add wave -noupdate -group Global -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/ac_stall
add wave -noupdate -group Global /riscvio_soc_tb/soc_i/riscvio_i/insert_nop
add wave -noupdate -group Global -color {Lime Green} -itemcolor White /riscvio_soc_tb/soc_i/riscvio_i/ral_nop_i/data_ral
add wave -noupdate -group Global -color {Lime Green} -itemcolor White /riscvio_soc_tb/soc_i/riscvio_i/ral_nop_i/pointer_ral
add wave -noupdate -group Global -color {Lime Green} -itemcolor White /riscvio_soc_tb/soc_i/riscvio_i/ral_nop_i/attr_ral
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/ac_rreq
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/ac_rack
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/ac_wreq
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/ac_wack
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/dc_rreq
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/dc_rack
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/dc_wreq
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/dc_wack
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/ic_rreq
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/ic_rack
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/ac_wack_int
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/dc_wack_int
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/addr
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/byte_ena
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/rdata
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/request_current_state
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/request_next_state
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/wdata
add wave -noupdate -group RAM /riscvio_soc_tb/soc_i/int_ram_i/we
add wave -noupdate -expand -group IO -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/io_mode
add wave -noupdate -expand -group IO -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/io_dev
add wave -noupdate -expand -group IO /riscvio_soc_tb/soc_i/io_ix
add wave -noupdate -expand -group IO -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/io_rdata
add wave -noupdate -expand -group IO -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/io_stall
add wave -noupdate -expand -group IO -radix ascii /riscvio_soc_tb/soc_i/riscvio_i/io_wdata
add wave -noupdate -expand -group IO /riscvio_soc_tb/soc_i/rx
add wave -noupdate -expand -group IO /riscvio_soc_tb/soc_i/tx
add wave -noupdate -expand -group IO -radix ascii /riscvio_soc_tb/soc_i/iio/iuart_interface/uart_tx_data
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/line_ix
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/fill_state
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/line_hit
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/row_selected_bytes
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/rd
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/ld
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/rreq
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/raddr
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/rack
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/rdata
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/eff_rdata
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/line_fill_ctr
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/stall
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/writeback_state
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/addr
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/next_addr
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/sd
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/last_sd
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/last_wr_addr
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/burst_addr
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/we
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/byte_ena
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/used_line_ctr
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/used_addr
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/wbyte_ena
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/waddr
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/wreq
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/wack
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/write_stall
add wave -noupdate -group ACache /riscvio_soc_tb/soc_i/riscvio_i/ac_i/acache/wdata
add wave -noupdate -group ICache /riscvio_soc_tb/soc_i/riscvio_i/ic_i/icache/invalidation_state
add wave -noupdate -group ICache -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/ic_i/icache/line_ix
add wave -noupdate -group ICache -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/ic_i/icache/line_fill_ctr
add wave -noupdate -group ICache /riscvio_soc_tb/soc_i/riscvio_i/ic_i/icache/last_line_fill_ctr
add wave -noupdate -group ICache /riscvio_soc_tb/soc_i/riscvio_i/ic_i/icache/valid_bit_to_write
add wave -noupdate -group ICache /riscvio_soc_tb/soc_i/riscvio_i/ic_i/icache/line_hit
add wave -noupdate -group ICache /riscvio_soc_tb/soc_i/riscvio_i/ic_i/icache/fill_state
add wave -noupdate -group ICache /riscvio_soc_tb/soc_i/riscvio_i/ic_i/icache/line_valid
add wave -noupdate -group ICache /riscvio_soc_tb/soc_i/riscvio_i/ic_i/icache/line_tag_selected
add wave -noupdate -group ICache /riscvio_soc_tb/soc_i/riscvio_i/ic_i/ic_rack
add wave -noupdate -group ICache -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/ic_i/ic_raddr
add wave -noupdate -group ICache -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/ic_i/ic_rdata
add wave -noupdate -group ICache /riscvio_soc_tb/soc_i/riscvio_i/ic_i/ic_rreq
add wave -noupdate -group ICache -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/ic_i/next_instr_addr
add wave -noupdate -group ICache -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/ic_i/instr_addr
add wave -noupdate -group ICache -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/ic_i/instr
add wave -noupdate -group ObjInit -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/end_addr
add wave -noupdate -group ObjInit -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/end_addr_aligned
add wave -noupdate -group ObjInit -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/next_obj_init_addr
add wave -noupdate -group ObjInit -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/obj_init_addr
add wave -noupdate -group ObjInit -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/obj_init_data
add wave -noupdate -group ObjInit -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/obj_init_wr
add wave -noupdate -group ObjInit /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/obj_init_byte_ena
add wave -noupdate -group ObjInit -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/start_addr_aligned
add wave -noupdate -group ObjInit -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/unit_active
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/invalidate
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/invalidation_active
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/invalidation_line_ix
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/invalidation_state
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/fill_state
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/line_ix
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/line_tag_selected
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/line_valid
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/rreq
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/rack
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/raddr
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/eff_rdata
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/rdata
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/used_addr
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/used_line_ctr
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/row_selected_bytes
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/rd
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/addr
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/next_addr
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/ld
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/addr
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/next_addr
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/we
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/sd
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/byte_ena
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/bytes_we
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/bytes_to_write
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/writeback_state
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/wreq
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/wack
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/waddr
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/wbyte_ena
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/wdata
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/accumulated_bus_word
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/accumulated_byteena
add wave -noupdate -group DCache /riscvio_soc_tb/soc_i/riscvio_i/dc_i/dcache/write_stall
add wave -noupdate -group PC -color Orange -itemcolor Goldenrod -expand -subitemconfig {/riscvio_soc_tb/soc_i/riscvio_i/dbt.ptr {-color Orange -height 24 -itemcolor Goldenrod} /riscvio_soc_tb/soc_i/riscvio_i/dbt.ix {-color Orange -height 24 -itemcolor Goldenrod} /riscvio_soc_tb/soc_i/riscvio_i/dbt.eoc {-color Orange -height 24 -itemcolor Goldenrod}} /riscvio_soc_tb/soc_i/riscvio_i/dbt
add wave -noupdate -group PC -color Orange -itemcolor Goldenrod -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/dynamic_branch_pc.ix
add wave -noupdate -group PC -color Orange -itemcolor Goldenrod /riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/dbta_valid
add wave -noupdate -group PC -color Orange -itemcolor Goldenrod -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/static_branch_pc.ix
add wave -noupdate -group PC -color Orange -itemcolor Goldenrod /riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/sbta_valid
add wave -noupdate -group PC -color Orange -itemcolor Goldenrod -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/incremented_pc.ix
add wave -noupdate -group PC -color Orange -itemcolor Goldenrod -radix hexadecimal -childformat {{/riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/next_pc.ptr -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/next_pc.ix -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/next_pc.eoc -radix hexadecimal}} -expand -subitemconfig {/riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/next_pc.ptr {-color Orange -height 24 -itemcolor Goldenrod -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/next_pc.ix {-color Orange -height 24 -itemcolor Goldenrod -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/next_pc.eoc {-color Orange -height 24 -itemcolor Goldenrod -radix hexadecimal}} /riscvio_soc_tb/soc_i/riscvio_i/next_pc_mux_i/next_pc
add wave -noupdate -expand -group DC -color Cyan -itemcolor {Light Blue} /riscvio_soc_tb/soc_i/riscvio_i/ctrl_dc_u.mnemonic
add wave -noupdate -expand -group DC -color Turquoise -itemcolor {Light Blue} -radix hexadecimal -childformat {{/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/pc_if.ptr -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/pc_if.ix -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/pc_if.eoc -radix hexadecimal}} -subitemconfig {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/pc_if.ptr {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/pc_if.ix {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/pc_if.eoc {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal}} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/pc_if
add wave -noupdate -expand -group DC -color Turquoise -itemcolor {Light Blue} -radix hexadecimal -childformat {{/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(31) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(30) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(29) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(28) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(27) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(26) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(25) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(24) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(23) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(22) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(21) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(20) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(19) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(18) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(17) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(16) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(15) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(14) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(13) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(12) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(11) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(10) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(9) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(8) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(7) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(6) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(5) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(4) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(3) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(2) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(1) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(0) -radix hexadecimal}} -subitemconfig {/riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(31) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(30) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(29) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(28) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(27) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(26) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(25) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(24) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(23) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(22) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(21) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(20) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(19) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(18) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(17) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(16) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(15) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(14) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(13) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(12) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(11) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(10) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(9) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(8) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(7) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(6) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(5) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(4) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(3) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(2) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(1) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr(0) {-color Turquoise -height 24 -itemcolor {Light Blue} -radix hexadecimal}} /riscvio_soc_tb/soc_i/riscvio_i/if_reg_i/if_instr
add wave -noupdate -expand -group DC -color Cyan -itemcolor {Light Blue} -radix hexadecimal -childformat {{/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(31) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(30) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(29) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(28) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(27) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(26) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(25) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(24) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(23) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(22) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(21) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(20) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(19) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(18) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(17) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(16) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(15) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(14) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(13) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(12) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(11) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(10) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(9) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(8) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(7) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(6) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(5) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(4) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(3) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(2) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(1) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(0) -radix hexadecimal}} -subitemconfig {/riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(31) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(30) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(29) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(28) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(27) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(26) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(25) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(24) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(23) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(22) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(21) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(20) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(19) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(18) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(17) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(16) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(15) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(14) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(13) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(12) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(11) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(10) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(9) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(8) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(7) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(6) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(5) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(4) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(3) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(2) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(1) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers(0) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal}} /riscvio_soc_tb/soc_i/riscvio_i/register_file_i/registers
add wave -noupdate -expand -group DC -color Cyan -itemcolor {Light Blue} -radix hexadecimal -childformat {{/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(34) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(35) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(36) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(37) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(38) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(39) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(40) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(41) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(42) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(43) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(44) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(45) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(46) -radix hexadecimal}} -subitemconfig {/riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(34) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(35) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(36) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(37) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(38) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(39) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(40) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(41) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(42) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(43) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(44) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(45) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs(46) {-color Cyan -height 24 -itemcolor {Light Blue} -radix hexadecimal}} /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/csrs
add wave -noupdate -expand -group DC -color Cyan -itemcolor {Light Blue} /riscvio_soc_tb/soc_i/riscvio_i/decoder_i/csr_mux_sel
add wave -noupdate -expand -group DC -color Cyan -itemcolor {Light Blue} /riscvio_soc_tb/soc_i/riscvio_i/insert_nop
add wave -noupdate -expand -group DC -color Cyan -itemcolor {Light Blue} /riscvio_soc_tb/soc_i/riscvio_i/atomic_swap
add wave -noupdate -expand -group DC -color Red -itemcolor Salmon -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/exc_dc_u
add wave -noupdate -expand -group DC -color Red -itemcolor Salmon -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/csr_unit_i/exc_wb
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/dc_reg_i/ctrl_dc.mnemonic
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/pc_dc
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/dc_reg_i/fwd_allowed_dc
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/ctrl_dc.branch_mode
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/dc_reg_i/alu_mode_dc
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/alu_a_mux_i/alu_a_in_sel
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/alu_b_mux_i/alu_b_in_sel
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/pgu_mode_dc
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/rdst_ix_dc
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/rdat_dc.ali
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/rdat_dc.val
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/rptr_dc.ali
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/rptr_dc.val
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/rptr_dc.ix
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/rptr_dc.pi
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/rptr_dc.dt
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/raux_dc.ali
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/raux_dc.tag
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/raux_dc.val
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/raux_dc.ix
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/imm_dc
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/alu_out_ex_u
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/dbu_out_ex_u
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/pgu_ptr_ex_u
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/res_mux_sel
add wave -noupdate -expand -group EX -color Magenta -itemcolor Plum /riscvio_soc_tb/soc_i/riscvio_i/res_ex_u
add wave -noupdate -expand -group EX -color Red -itemcolor Salmon /riscvio_soc_tb/soc_i/riscvio_i/exc_ex_u
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/ex_reg_i/ctrl_ex.mnemonic
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/ex_reg_i/fwd_allowed_ex
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/rdst_ix_ex
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/rdat_ex.ali
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/rdat_ex.val
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/rptr_ex.ali
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/rptr_ex.val
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/rptr_ex.ix
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/rptr_ex.pi
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/rptr_ex.dt
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.ali
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.tag
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki -radix hexadecimal -childformat {{/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(31) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(30) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(29) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(28) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(27) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(26) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(25) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(24) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(23) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(22) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(21) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(20) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(19) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(18) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(17) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(16) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(15) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(14) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(13) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(12) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(11) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(10) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(9) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(8) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(7) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(6) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(5) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(4) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(3) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(2) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(1) -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(0) -radix hexadecimal}} -subitemconfig {/riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(31) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(30) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(29) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(28) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(27) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(26) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(25) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(24) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(23) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(22) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(21) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(20) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(19) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(18) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(17) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(16) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(15) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(14) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(13) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(12) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(11) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(10) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(9) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(8) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(7) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(6) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(5) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(4) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(3) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(2) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(1) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val(0) {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal}} /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.val
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/raux_ex.ix
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki -radix hexadecimal -childformat {{/riscvio_soc_tb/soc_i/riscvio_i/res_ex.tag -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/res_ex.val -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/res_ex.ix -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/res_ex.pi -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/res_ex.dt -radix hexadecimal}} -subitemconfig {/riscvio_soc_tb/soc_i/riscvio_i/res_ex.tag {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/res_ex.val {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/res_ex.ix {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/res_ex.pi {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/res_ex.dt {-color Yellow -height 24 -itemcolor Khaki -radix hexadecimal}} /riscvio_soc_tb/soc_i/riscvio_i/res_ex
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/me_addr
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/me_mode_ex
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/me_addr_uq
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/me_mode_ex_uq
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/unit_activating
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/obj_init_fsm_i/unit_active
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/io_out_me_u
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/mem_out_me_u
add wave -noupdate -expand -group ME -color Yellow -itemcolor Khaki /riscvio_soc_tb/soc_i/riscvio_i/res_me_u
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/ctrl_me.mnemonic
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/rdst_ix_me
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/rdat_me.ali
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/rdat_me.val
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/rptr_me.ali
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/rptr_me.val
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/rptr_me.ix
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/rptr_me.pi
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/rptr_me.dt
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/raux_me.ali
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/raux_me.tag
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/raux_me.val
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/raux_me.ix
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/me_reg_i/imm_me
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/addr_me
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/addr_me_uq
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/at_mode
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/ac_i/ldt
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/ac_i/lpi
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/wdt_me
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/wpi_me
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} -radix hexadecimal -childformat {{/riscvio_soc_tb/soc_i/riscvio_i/res_me.tag -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/res_me.val -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/res_me.ix -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/res_me.pi -radix hexadecimal} {/riscvio_soc_tb/soc_i/riscvio_i/res_me.dt -radix hexadecimal}} -subitemconfig {/riscvio_soc_tb/soc_i/riscvio_i/res_me.tag {-color {Spring Green} -height 24 -itemcolor {Pale Green} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/res_me.val {-color {Spring Green} -height 24 -itemcolor {Pale Green} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/res_me.ix {-color {Spring Green} -height 24 -itemcolor {Pale Green} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/res_me.pi {-color {Spring Green} -height 24 -itemcolor {Pale Green} -radix hexadecimal} /riscvio_soc_tb/soc_i/riscvio_i/res_me.dt {-color {Spring Green} -height 24 -itemcolor {Pale Green} -radix hexadecimal}} /riscvio_soc_tb/soc_i/riscvio_i/res_me
add wave -noupdate -expand -group AT -color {Spring Green} -itemcolor {Pale Green} /riscvio_soc_tb/soc_i/riscvio_i/res_at_u
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 /riscvio_soc_tb/soc_i/riscvio_i/at_reg_i/rd_wb.ali
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 /riscvio_soc_tb/soc_i/riscvio_i/rd_wb.rf_nbr
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 /riscvio_soc_tb/soc_i/riscvio_i/rd_wb.csr_nbr
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 /riscvio_soc_tb/soc_i/riscvio_i/at_reg_i/rd_wb.mem.tag
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 /riscvio_soc_tb/soc_i/riscvio_i/rd_wb.mem.val
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 /riscvio_soc_tb/soc_i/riscvio_i/rd_wb.mem.ix
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 -radix hexadecimal /riscvio_soc_tb/soc_i/riscvio_i/at_reg_i/rd_wb.mem.pi
add wave -noupdate -expand -group WB -color Gray60 -itemcolor Gray90 /riscvio_soc_tb/soc_i/riscvio_i/rd_wb.mem.dt
add wave -noupdate -expand -group WB -color Red -itemcolor Salmon /riscvio_soc_tb/soc_i/riscvio_i/exc_wb
add wave -noupdate /riscvio_soc_tb/soc_i/riscvio_i/if_instr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3339425416 ps} 0} {{Cursor 2} {1713000 ps} 1}
quietly wave cursor active 1
configure wave -namecolwidth 278
configure wave -valuecolwidth 281
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
WaveRestoreZoom {3338116249 ps} {3345177725 ps}
