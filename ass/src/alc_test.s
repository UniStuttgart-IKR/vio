.globl _start

.text

_start:     
            li      t0, 12
            li      t1, 24


            li      t3, 0x555
            li      t4, 1
            nop
            nop
            nop
            nop
            nop
            nop

            alci     t0, 8, 12

            nop
            nop
            nop

            sw.r    t3, t4(t0)      

            

doom:       jal     t0, doom

