.globl _start

.text

_start:     
            li      t0, 69
            li      t1, 2

            nop
            nop
            nop
            nop
            nop
            nop

            li      t0, 1
            li      t1, 1

            nop
            nop
            nop
            nop

            beq     t0, t1, ok1
            j       failure

ok1:        bne     zero, t1, ok2
            j       failure

ok2:        bne     zero, t1, ok3
            j       failure

ok3:        li      t1, 2
            nop
            nop
            nop
            nop
            blt     t0, t1, ok4
            j       failure         

ok4:        li      t1, 2
            blt     t0, t1, ok5
            j       failure  

ok5:        li      t1, 2
            bgt     t1, t0, ok6
            j       failure  

ok6:        ble     t0, t1, ok7
            j       failure  

ok7:        bge     t1, t0, ok8
            j       failure  

ok8:        li      t0, 2
            nop
            nop
            nop
            nop

            ble     t0, t1, ok9
            j       failure  

ok9:        bge     t1, t0, ok10
            j       failure

ok10:       li      a0, 0x111
            j       doom

            add     t3, t0,t1
            sub     t4, t0,t1
            sll     t5, t0,t1
            slt     t6, t0,t1
            sltu    a0, t0,t1
            xor     a1, t0,t1
            srl     a2, t0,t1
            sra     a3, t0,t1
            or      a4, t0,t1
            and     a5, t0,t1

            addi    s0, t0,420
            addi    s1, t1,-420
            slti    s2, t0,420
            sltiu   s3, t0,420
            xori    s4, t0,420
            ori     s5, t0,420
            andi    s6, t0,420
            slli    s8, t0,2
            srli    s9, t0,2
            srai    s10, t0,2

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

            jlib    t0, usb.a
            jal     t0, usb.a

            sp      frame, 0(a0)


failure:    li      a0, 0x555
            j       doom

doom:       jal     t0, doom


.section usb
.word usb.trampEnd - usb
.word usb.end - usb
.equ usb.a, usb.a__-usb

.globl  usb.a
usb.a__:    j       usb.a_
usb.b:      j       usb.b_
usb.c:      j       usb.c_
usb.trampEnd:

usb.a_:

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
usb.b_:

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
usb.c_:

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
usb.end:
