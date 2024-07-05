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
            ccp     x3, x3
            jalr    ra,  4(x3)
            nop
            nop

core.init:     
            li      frame, 0x805
            la      t0, core.exc_handel
            csrw    mtvec, t0

            li      t1, 0x01020304
            li      t2, 0x8005
            li      t3, 0x86

            push    1,7
            sp      ra, 0(frame)
            sp      x3, 0(frame)
            sw      t1, 0(frame)
            sh      t2, 4(frame)
            sb      t3, 6(frame)

            lbu     a4, 6(frame)
            lb      a3, 6(frame)
            lhu     a2, 4(frame)
            lh      a1, 0(frame)
            lp      a0, 0(frame)
            lp      ra, 0(frame)

            ebreak

            # Device 1
            li      t1, 1
            # 3 Registers, register capability
            li      t2, 3 * 2 + 0
            ciop    s9, t1, t2

            # without this lw there is no way to clear t0 pointer tag
core.loop:       lw      t0, 0(zero)
            li      t1, 'I'
            sb      t1, 0(s9)
            #li      t1, 'T'
            #sb      t1, 0(s9)
            #li      t1, 'S'
            #sb      t1, 0(s9)
            #li      t1, ' '
            #sb      t1, 0(s9)
            #li      t1, 'A'
            #sb      t1, 0(s9)
            #li      t1, 'L'
            #sb      t1, 0(s9)
            #li      t1, 'I'
            #sb      t1, 0(s9)
            #li      t1, 'V'
            #sb      t1, 0(s9)
            #li      t1, 'E'
            #sb      t1, 0(s9)
            #li      t1, '!'
            #sb      t1, 0(s9)
            #li      t1, 10
            #sb      t1, 0(s9)

            push    1,0
            sp      ra, 0(frame)

            la      a0, hdmi
            ccp     a0, a0

            la      s0, usb
            ccp     s0, s0
            mv      s1, s0
            sp      s1, 0(frame)

            jalr    ra,  0(s0)

            lp      s0, 0(frame)
            jalr    ra,  4(s0)

            ebreak


core.exc_handel:
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

usb.b:          push    0,0
            sp      ra, 0(frame)
            jal     usb.c
            lp      ra, 0(frame)
            pop
            ret                 #standard risc-v pseudo-instruction for jr zero, 0(ra)

usb.c:          push    0,0
            sp      ra, 0(frame)
            jalr    ra,  0(a0)
            lp      ra, 0(frame)
            pop
            ret                 #standard risc-v pseudo-instruction for jr zero, 0(ra)


usb.end:

.align 3
.section cosnt_obj
.word 0 # todo: add ptr support
.word (cosnt_obj.end - cosnt_obj)

cosnt_obj_:
            .ascii "asdfihsofhs"



cosnt_obj.end:


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



