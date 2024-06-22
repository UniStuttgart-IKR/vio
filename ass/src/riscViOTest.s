.globl core.start


@core>
start
private
core.start: li      frame, 0x305
            pusht   4,8
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
            ccp     s0, s0
            sp      s0, 0(frame)

            jlib    s0, @usb.af

            lp      s0, 0(frame)
            jlib    s0, @usb.b

            li      t0, 12
            li      t1, 24
            add     t2, t1,t0

doom:       jal     t0, doom


@usb>
af
b
private


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
            rtlib

usb.b:      pusht   0,0
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
            rtlib

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
