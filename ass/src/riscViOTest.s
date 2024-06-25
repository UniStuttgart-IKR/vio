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
            pushg   1, 0
            sp      ra, 0(frame)
            sw      ra, 0(frame)

            la      a0, hdmi

            la      s0, usb
            mv      s1, s0
            sp      s1, 0(frame)

            jlib    s0, 0

            lp      s0, 0(frame)
            jlib    s0, 4

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


usb.af:     nop
            nop
            ret                 #standard risc-v pseudo-instruction for jr zero, 0(ra)

usb.b:      push    0,0
            sw      ra, 0(frame)
            jal     usb.c
            lw      ra, 0(frame)
            ret                 #standard risc-v pseudo-instruction for jr zero, 0(ra)

usb.c:      pushg   0,0
            sw      ra, 0(frame)
            sp      ra, 0(frame)
            jlib    a0, 0
            lp      ra, 0(frame)
            lw      ra, 0(frame)
            ret                 #standard risc-v pseudo-instruction for jr zero, 0(ra)
usb.end:


.section hdmi, "xa"
.word hdmi.trampEnd - hdmi.trampStart
.word (hdmi.end - hdmi.trampEnd) | 0b11

hdmi.trampStart:
hdmi.start_: j hdmi.start
hdmi.trampEnd:


hdmi.start: nop
            nop
            ret                 #standard risc-v pseudo-instruction for jr zero, 0(ra)
hdmi.end:



