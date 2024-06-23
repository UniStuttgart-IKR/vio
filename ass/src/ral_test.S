# 0 "src/alc_test.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "src/alc_test.S"
# generated from src/alc_test.s by riscvio-preproc.py by LeyLux Group
.globl _start

.text

_start:     
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            li t0, 12
            li t1, 24
            nop
            nop
            nop
            nop
            alci    s0, 1, 4
            sw      t1, 0(s0)
            nop
            nop
            nop
            nop
            nop
            nop
            # data ral
            lw      t2, 0(s0)
            add    t3, zero, t2
            nop
            nop
            nop
            alci    s1, 1, 4
            sp      s1, 0(s0)
            alci    s2, 1, 4
            sp      s2, 0(s1)
            nop
            nop
            # not a data ral
            lw      t2, 0(s0)
            j       no_reg_rd
            add     t4, zero, t2
            nop
            nop
            nop
no_reg_rd:
            nop
            nop
            nop
            nop
            nop
            lp      t0, 0(s0)
            lp      t1, 0(t0)
            # we should have s2 = t1 now
            nop
            nop
            nop
            nop
            lp      t3, 0(s0)
            j       no_ptr_reg_load
            lp      t4, 0(t3)
            nop
            nop
            nop
no_ptr_reg_load:
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            ebreak
            li frame, 0x300
            li rix, 0xDC
            li rcd, 0xBA


            alci    frame, 1,3
            sw      t0, 0(frame)
            lw      t1, 0(frame)

            
            #pusht   3, 1
            #nop
            #nop
            #nop
            #nop
            #nop
            sw      rix, 55(frame)
            sw      t0, 0(frame)
            lw      t1, 0(frame)
            lw      rix, 34(frame)
            lp      rix, 3(frame)

            pushg   1, 3
            #nop
            #nop
            #nop
            #nop
            #nop
            sw      rix, 55(frame)
            sp      rcd, 33(frame)
            sw      t0, 0(frame)
            lw      t1, 0(frame)
            lw      rix, 34(frame)
            lp      rix, 3(frame)
            lp      rcd, 3(frame)

            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            ebreak

            li t1, 3
            li t2, 12
            li t3, 14
            li t4, 17
            #nop
            #nop
            #nop
            #nop
            alc s0, t1, t2
            #nop
            #nop
            #nop
            #nop
            #nop
            #nop
            lw      t0, 13(s0)
            lw.r    t0, t4(s0)
            lp      t0, 13(s0)
            lp.r    t0, t4(s0)
            #nop
            #nop
            #nop
            #nop
            #nop
            ebreak
            alci s1, 8, 12
            #nop
            #nop
            #nop
            #nop
            alci.p s2, t3, 17
            #nop
            #nop
            #nop
            #nop
            alci.d s3, t1, 19
            #nop
            #nop
            #nop
            #nop
            pushg 1, 3
            #nop
            #nop
            #nop
            #nop
            #pusht 4, 9
            li t3, 0x555
            li t4, 1
            #nop
            #nop
            #nop

            sw t3, 0(s0)
            lw t5, 0(s0)

            li  t1, 8
            li  t6, 0xFE
            #nop
            #nop
            #nop
            #nop
            sw.r t6, t1(s0)
            lw.r t2, t1(s0)
            #nop
            #nop
            #nop
            #nop
            sp s0, 0(s0)
            lp t1, 0(s0)

            li t0, 1
            #nop
            #nop
            #nop
            #nop
            sp.r s0, t0(s0)
            lp.r t2, t0(s0)

            #nop
            #nop
            #nop
            #nop
            lui  t0, 0x55555
            #nop
            #nop
            #nop
            #nop
            ori  t0, t0, 0x555
            #nop
            #nop
            #nop
            #nop
            #nop
            #nop
            #nop
            ebreak



doom: jal t0, doom
