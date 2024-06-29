# generated from src/riscViOTest.s3 by riscvio-preproc.py by LeyLux Group
.globl core.start


.section core, "xa"
.word core.trampEnd - core.trampStart
.word (core.end - core.trampStart - 4)

core.trampStart:
core.start_: j core.start
core.init_: j core.init
core.trampEnd:

core.start:      la      x3, core
            addi    x3, x3,-8
            li      frame, 0x805
            jlib    x3,  4
            nop
            nop

core.init:     
            li      frame, 0x805
            la      t0, exc_handel
            csrw    mtvec, t0

            alci    t1, 4, 8

            lw      t2, 377(t1)


            push    4,8
            jal     core.entry
            addi    t0, t1,2
            addi    t3, t4,5

core.entry:
            pushg   1,2
            sp      ra, 0(frame)

            la      a0, hdmi



            la      s0, usb
            mv      s1, s0
            sp      s1, 0(frame)

            jlib    s0,  0

            lp      s0, 0(frame)
            jlib    s0,  4

            ebreak

            nop
            nop


exc_handel:
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            mret
            # test instr abort
            addi    t0, t0, -5
            addi    t1, t1, -9



core.end:


.align 3
.section usb, "xa"
.word usb.trampEnd - usb.trampStart
.word (usb.end - usb.trampStart - 4)

usb.trampStart:
usb.af_: j usb.af
usb.b_: j usb.b
usb.trampEnd:


usb.af:         addi    t0, t1,2
            addi    t3, t4,5
            ret                 #standard risc-v pseudo-instruction for jalr zero, 0(ra)

usb.b:          pushg   0,0
            sp      ra, 0(frame)
            jal     usb.c
            lp      ra, 0(frame)
            pop
            ret                 #standard risc-v pseudo-instruction for jr zero, 0(ra)

usb.c:          pushg   0,0
            sp      ra, 0(frame)
            jlib    a0,  0
            lp      ra, 0(frame)
            pop
            ret                 #standard risc-v pseudo-instruction for jr zero, 0(ra)




usb.end:


.align 3
.section hdmi, "xa"
.word hdmi.trampEnd - hdmi.trampStart
.word (hdmi.end - hdmi.trampStart - 4)

hdmi.trampStart:
hdmi.s_: j hdmi.s
hdmi.trampEnd:


hdmi.s:          addi    t0, t1,2
            addi    t3, t4,5
            ret                 #standard risc-v pseudo-instruction for jr zero, 0(ra)


hdmi.end:



