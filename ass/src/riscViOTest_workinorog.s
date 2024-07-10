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

core.init:       # Device 2
            li      t1, 2
            # 3 Registers, register capability
            li      t2, 5 * 2 + 0
            ciop    s2, t1, t2
            li      s3, 0x80
            li      s4, 0x100
            
loop:       sb      s3, 0(s2)
            slli    s3, s3,1
            blt     s3,s4,byteOk
            li      s3, 1
byteOk:     li      t1, 2500000
wait:       addi    t1, t1,-1
            bnez    t1, wait
            ebreak
            j       loop

core.end:   nop
            nop
            nop

.section uart, "xa"
.word uart.trampEnd - uart.trampStart
.word (uart.end - uart.trampStart - 4)

uart.trampStart:
core.start_: j core.start
core.init_: j core.init
uart.trampEnd:


uart.printStr:
            addi    sp, sp,-16
            sd		ra, 0(sp)
            sd      s0, 8(sp)
			mv      s0, a0
hps.next:   lbu     a0, 0(s0)
            beqz    a0, hps.end
            jal     hdmi.printChar
            addi    s0, s0,1
            j       hps.next
hps.end:    ld      s0, 8(sp)
            ld		ra, 0(sp)
            addi    sp, sp,16
			ret

uart.printByte:
            li      a1, 8
            j       hdmi.printReg

uart.printHalf:
            li      a1, 16
            j       hdmi.printReg

uart.printWord:
            li      a1, 32
            j       hdmi.printReg

uart.printDouble:
            li      a1, 64
            j       hdmi.printReg

#a0: reg
#a1: length
uart.printReg:
            addi    sp, sp,-32
            sd      ra, 0(sp)
            sd      s0, 8(sp)
            sd      s1, 16(sp)
            sd      s2, 24(sp)
            mv	    s0, a0
            mv	    s1, a1
            li	    s2, 9
hpr.next:
            addi	s1, s1,-4
            srl	    a0, s0,s1
            andi	a0, a0,0xF
            ble	    a0,s2,hpr.DD
            addi	a0, a0,7
hpr.DD:
            addi	a0, a0,48
            jal	    hdmi.printChar
            bnez	s1, hpr.next
            ld      s2, 24(sp)
            ld      s1, 16(sp)
            ld      s0, 8(sp)
            ld      ra, 0(sp)
            addi    sp, sp,32
            ret

uart.end:

