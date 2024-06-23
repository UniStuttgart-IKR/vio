# generated from src/riscViOTest.s3 by riscvio-preproc.py by LeyLux Group
.globl core.start


.section core, "xa"
.word core.trampEnd - core.trampStart
.word (core.end - core.trampEnd) | 0b11

core.trampStart:
core.start_: j core.start
core.trampEnd:

core.start: li      frame, 0x305
            push    4,8
            jal     core.entry
            nop
            nop

core.entry:
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

            pushg   1, 0
            sp      ra, 0(frame)
            sw      ra, 0(frame)

            la      s0, usb
            mv      s1, s0
            sp      s1, 0(frame)

            jlib    s0,  0

            lp      s0, 0(frame)
            jlib    s0,  4

            li      t0, 12
            li      t1, 24
            add     t2, t1,t0

            ebreak

doom:       jal     t0, doom



core.end:


.section usb, "xa"
.word usb.trampEnd - usb.trampStart
.word (usb.end - usb.trampEnd) | 0b11

usb.trampStart:
usb.af_: j usb.af
usb.b_: j usb.b
usb.trampEnd:



usb.af:     andn    t3, t0,t1
            orn     t4, t0,t1
            xnor    t5, t0,t1
            clz     t6, t0
            ctz     a0, t0
            cpop    a1, t0
            max     a2, t0,t1
            maxu    a3, t0,t1
            min     a4, t0,t1
            minu    a5, t0,t1
            sext.b  s0, t0
            sext.h  s1, t1
            zext.h  s2, t0
            rol     s3, t0,t1
            ror     s4, t0,t1
            rori    s5, t0,16
            orc.b   s6, t0
            rev8    s8, t0
            ret

usb.b:      push    0,0
            sw      ra, 0(frame)
            andn    t3, t0,t1
            orn     t4, t0,t1
            xnor    t5, t0,t1
            clz     t6, t0
            ctz     a0, t0
            cpop    a1, t0
            max     a2, t0,t1
            maxu    a3, t0,t1
            min     a4, t0,t1
            minu    a5, t0,t1
            sext.b  s0, t0
            sext.h  s1, t1
            zext.h  s2, t0
            rol     s3, t0,t1
            ror     s4, t0,t1
            rori    s5, t0,16
            orc.b   s6, t0
            rev8    s8, t0
            jal     usb.c
            lw      ra, 0(frame)
            ret

usb.c:      andn    t3, t0,t1
            orn     t4, t0,t1
            xnor    t5, t0,t1
            clz     t6, t0
            ctz     a0, t0
            cpop    a1, t0
            max     a2, t0,t1
            maxu    a3, t0,t1
            min     a4, t0,t1
            minu    a5, t0,t1
            sext.b  s0, t0
            sext.h  s1, t1
            zext.h  s2, t0
            rol     s3, t0,t1
            ror     s4, t0,t1
            rori    s5, t0,16
            orc.b   s6, t0
            rev8    s8, t0
            ret
usb.end:



