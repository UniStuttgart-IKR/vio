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

            push    8,7
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
            li      t1, 2
            # 3 Registers, register capability
            li      t2, 5 * 2 + 0
            ciop    s2, t1, t2
            li      s3, 1
            li      s4, 0x100

            # Device 1
            li      t1, 1
            # 3 Registers, register capability
            li      t2, 3 * 2 + 0
            ciop    s1, t1, t2            
            
            la      a0, hello_world_str
            ccp     s0, a0
            
core.loop:       sb      s3, 0(s2)
            #slli    s3, s3,1
            #blt     s3,s4,byteOk
            #li      s3, 1
#byteOk:    
            rori    s3, s3, 1
            mv      a0, s0
            mv      a1, s1
            jal     core.out_str

            j       core.loop

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
            sb      t2, 0(a1)
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
                sb      t2, 0(a1)
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
                ccp     a0, a0
                jal     core.out_str


                la      a0, exception_strs
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
            .asciz "panic - severe internal error"
            .asciz "illeg - illegal instruction"
            .asciz "sverr - supervisor error"
            .asciz "sterr - state error"
            .asciz "privv - privilegded instruction"
            .asciz "tcoil - target code index"
            .asciz "tciob - target code index out of bound"
            .asciz "endoc - end of code"
            .asciz "rixeq - return index is zero"
            .asciz "rcdnu - return code is null"
            .asciz "rcdnc - return code ptr is not a code ptr"
            .asciz "drfnu - dereferenced null pointer"
            .asciz "drfcd - dereferenced code pointer"
            .asciz "wrptv - wrote using read only pointer"
            .asciz "sealv - wrote to read only object"
            .asciz "ixoob - index out of bounds"
            .asciz "frtyp - frame type"
            .asciz "aperr - ???"
            .asciz "hpovf - heap full"
            .asciz "stovf - stack overflow"
            .asciz "ptari - ???"



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



