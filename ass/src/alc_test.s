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
            li t0, 12
            li t1, 24
            li frame, 0x300


            nop
            nop
            nop
            nop
            nop
            nop

            li t1, 3
            li t2, 12
            li t3, 14
            li t4, 17
            nop
            nop
            nop
            nop
            alc s0, t1, t2
            nop
            nop
            nop
            nop
            alci s1, 8, 12
            nop
            nop
            nop
            nop
            alci.p s2, t3, 17
            nop
            nop
            nop
            nop
            alci.d s3, t1, 19
            nop
            nop
            nop
            nop
            pushg 1, 3
            nop
            nop
            nop
            nop
            pusht 4, 9
            li t3, 0x555
            li t4, 1
            nop
            nop
            nop

            sw t3, 0(s0)
            nop
            nop
            nop
            nop
            lw t5, 0(s0)

doom: jal t0, doom
