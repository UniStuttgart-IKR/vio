.globl _start

.text

_start:     li      frame, 0x305
            pusht   4,8
            jal     entry
            nop
            nop

entry:
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            li      t0, 12
            li      t1, 24
            add     t2, t1,t0

            pushg   1,3
            sp      ra, 55(frame)
            sw      ra, 55(frame)
            sw      t2, 0(frame)
            lw      t3, 0(frame)
            lp      ra, 3(frame)
            lw      ra, 3(frame)
            pop

            alci    frame, 4,9
            sp      ra, 55(frame)
            sw      ra, 55(frame)
            sw      t2, 0(frame)
            lw      t3, 0(frame)
            lp      ra, 3(frame)
            lw      ra, 3(frame)
            pop

            pusht   4,9
            sp      ra, 55(frame)
            sw      ra, 55(frame)
            sw      t2, 0(frame)
            lw      t3, 0(frame)
            lp      ra, 3(frame)
            lw      ra, 3(frame)
            pop

            nop
            nop
            nop
            nop
            nop
            nop
            ebreak

doom:       jal     doom
