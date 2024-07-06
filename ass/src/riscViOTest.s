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

            lbu     a5, 6(frame)
            lb      a4, 6(frame)
            lhu     a3, 4(frame)
            lh      a2, 4(frame)
            lw      a1, 0(frame)
            lp      a0, 0(frame)
            lp      ra, 0(frame)



            # Device 1
            li      t1, 1
            # 3 Registers, register capability
            li      t2, 3 * 2 + 0
            ciop    a1, t1, t2
            
            la      a0, hello_world_str
            #TODO: find a nicer way to do this
            addi    a0, a0, -8 
            ccp     a0, a0
            
            jal     core.out_str

          
            nop
            nop
            ebreak


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

# output string in object a0 via io obj in a1
core.out_str:    beq     a0, zero, .done
            qdtb    t0, a0
            beq     t0, zero, .done
            li      t1, 0
.outloop:   lbu.r    t2, t1(a0)
            #TODO: change the index back to 0 for output 
            sb      t2, 2(a1)
            addi    t1, t1, 1
            bne     t1, t0, .outloop
.done:
            ret


# output zero terminated string no a2 in object a0 via io obj in a1
core.out_str_zero:   beq     a0, zero, .donez
                qdtb    t0, a0
                beq     t0, zero, .donez
                li      t1, 0
                addi    a2, a2, 1

.srcloop:       lbu.r   t2, t1(a0)
                bne     t2, zero, .notzero
                addi    a2, a2, -1 
                addi    t1, t1, 1
                beq     a2, zero, .outloop
                addi    t1, t1, -1
.notzero:       addi    t1, t1,  1
                j       .srcloop


.outloopz:      lbu.r    t2, t1(a0)
                #TODO: change the index back to 0 for output 
                sb      t2, 2(a1)
                addi    t1, t1, 1
                bne     t2, zero, .outloopz
.donez:
                ret


core.exc_handel:
                nop
                nop
                nop
                # Device 1
                li      t1, 1
                # 3 Registers, register capability
                li      t2, 3 * 2 + 0
                ciop    a1, t1, t2

                la      a0, exception_hdr_str
                addi    a0, a0, -8 
                ccp     a0, a0
                jal     core.out_str


                la      a0, exception_strs
                addi    a0, a0, -8 
                ccp     a0, a0
                csrr    a2, mcause
                jal     core.out_str_zero

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
.section exception_hdr_str, "a"
.word 0
.word (exception_hdr_str.end - exception_hdr_str_)

exception_hdr_str_:
            .ascii "An Exception occured: "


exception_hdr_str.end:

.align 3
.section exception_strs, "a"
.word 0
.word (exception_strs.end - exception_strs_)

exception_strs_:
            .ascii "panic - severe internal error\0"
            .ascii "illeg - illegal instruction\0"
            .ascii "sverr - supervisor error\0"
            .ascii "sterr - state error\0"
            .ascii "privv - privilegded instruction\0"
            .ascii "tcoil - target code index\0"
            .ascii "tciob - target code index out of bound\0"
            .ascii "endoc - end of code\0"
            .ascii "rixeq - return index is zero\0"
            .ascii "rcdnu - return code is null\0"
            .ascii "rcdnc - return code ptr is not a code ptr\0"
            .ascii "drfnu - dereferenced null pointer\0"
            .ascii "drfcd - dereferenced code pointer\0"
            .ascii "wrptv - wrote using read only pointer\0"
            .ascii "sealv - wrote to read only object\0"
            .ascii "ixoob - index out of bounds\0"
            .ascii "frtyp - frame type\0"
            .ascii "aperr - ???\0"
            .ascii "hpovf - heap full\0"
            .ascii "stovf - stack overflow\0"
            .ascii "ptari - ???\0"



exception_strs.end:

.align 3
.section hello_world_str, "a"
.word 0
.word (hello_world_str.end - hello_world_str_)

hello_world_str_:
            .ascii "Hello from RiscViO!\n"



hello_world_str.end:


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



