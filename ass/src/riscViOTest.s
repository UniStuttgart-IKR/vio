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

core.init:       li      frame, 0x805
            la      t0, core.exc_handel
            csrw    mtvec, t0
            
            la      s0, uart
            ccp     s0, s0
            la      s1, demo_strings
            ccp     s1, s1

            li      s6, 0x08
            li      s7, '\r'
            li      s8, 48
            li      s9, 57
            la      s10, util
            ccp     s10, s10
            
            mv      a0, s1
            jalr    ra,  12(s0)

core.repeat:     mv      a0, s1
            li      a1, 1
            jalr    ra,  8(s0)

            li      s2, 0
            li      s3, 0
core.repeat.sizeloop:  jalr    ra,  0(s0)
            beq     a0,s7,core.repeat.sizeEntered
            blt     a0,s8,core.repeat.sizeloop
            bgt     a0,s9,core.repeat.sizeloop
            bne     a0,s6,core.repeat.sizeNotBs
            
            beqz    s0,core.repeat.sizeloop
            addi    s2, s2,-1
            li      a0, 0x8
            jalr    ra,  4(s0)
            li      a0, ' '
            jalr    ra,  4(s0)
            li      a0, 0x8
            jalr    ra,  4(s0)
            j       core.repeat.sizeloop
            
core.repeat.sizeNotBs: jalr    ra,  4(s0)
            sub     a3, a0,s8
            mv      a0, s3
            li      a1, 10
            jalr    ra,  0(s10)
            add     s3, a2,a3
            j       core.repeat.sizeloop

core.repeat.sizeEntered:
            mv      a0, s1
            li      a1, 2
            jalr    ra,  8(s0)
            slli    s3, s3,2
            la      s2, fibo_string
            ccp     s2, s2
            lbu.r   a0, s3(s2)
            jalr    ra,  4(s0)
            addi    s3, s3,1
            lbu.r   a0, s3(s2)
            jalr    ra,  4(s0)
            addi    s3, s3,1
            lbu.r   a0, s3(s2)
            jalr    ra,  4(s0)
            addi    s3, s3,1
            lbu.r   a0, s3(s2)
            jalr    ra,  4(s0)

core.doom:       j       core.repeat
            


core.exc_handel:     
            # Device 1
            li      t1, 1
            # 3 Registers, register capability
            li      t2, 3 * 2 + 0
            ciop    a1, t1, t2
            la      s0, uart
            ccp     s0, s0
            la      a0, exception_hdr_str
            ccp     a0, a0
            jalr    ra,  12(s0)
            la      a0, exceptionStrs
            ccp     a0, a0
            csrw    mcause, a1
            jalr    ra,  8(s0)
            li      a0, '\n'
            jalr    ra,  4(s0)
            li      a0, '\r'
            jalr    ra,  4(s0)

            ebreak
            j       core.repeat
            
            mret




core.end:

.align 3
.section demo_strings, "a"
.word 0
.word (demo_strings.end - demo_strings_)

demo_strings_:
            .asciz "Fibonacci Example"
            .asciz "\n\rEnter Index: "
            .asciz "\n\rValue is: "
            


demo_strings.end:

.align 3
.section fibo_string, "a"
.word 0
.word (fibo_string.end - fibo_string_)

fibo_string_:
            .asciz "000"
            .asciz "001"
            .asciz "001"
            .asciz "002"
            .asciz "003"
            .asciz "005"
            .asciz "008"
            .asciz "013"
            .asciz "021"
            .asciz "034"
            .asciz "055"
            .asciz "089"
            .asciz "144"
            .asciz "233"
            .asciz "377"
            .asciz "610"
            .asciz "987"


fibo_string.end:

.align 3
.section exception_hdr_str, "a"
.word 0
.word (exception_hdr_str.end - exception_hdr_str_)

exception_hdr_str_:
            .ascii "\n\rAn Exception occured: "


exception_hdr_str.end:

.align 3
.section exceptionStrs, "a"
.word 0
.word (exceptionStrs.end - exceptionStrs_)

exceptionStrs_:
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
            .asciz "ptari - arithmetic on pointer register"
            .word  0



exceptionStrs.end:

.align 3
.section hello_world_str, "a"
.word 0
.word (hello_world_str.end - hello_world_str_)

hello_world_str_:
            .ascii "Hello from RiscViO!\n\r"


hello_world_str.end:


.section uart, "xa"
.align 3
.word uart.trampEnd - uart.trampStart
.word (uart.end - uart.trampStart - 4)

uart.trampStart:
uart.charIn_: j uart.charIn
uart.charOut_: j uart.charOut
uart.stringElOut_: j uart.stringElOut
uart.stringOut_: j uart.stringOut
uart.trampEnd:


uart.charOut:    li      t1, 1
            li      t2, 3 * 2 + 0
            ciop    t0, t1, t2
            sb      a0, 0(t0)
            ret

uart.charIn:     li      t1, 1
            li      t2, 3 * 2 + 0
            ciop    t0, t1, t2
            lbu     a0, 0(t0)
            ret


uart.stringElOut:
            mv      a7, a0
            qdtb    a6, a7
            li      a5, -4
            li      a4, 0

uart.stringElOut.next:      addi    a5, a5,4
            bge     a5,a6,uart.stringElOut.oob
            lw.r    t1, a5(a7)  #CAFFE00FF
            orc.b   t1, t1      #BBBBB00BB
            not     t1, t1      #00000BB00
uart.stringElOut.again:     beqz    t1, uart.stringElOut.next
            #found a chunk with at leat one zero byte
            ctz     t2, t1
            addi    t2, t2,8
            srl     t1, t1,t2
            addi    a4, a4,1
            bne     a4,a1,uart.stringElOut.again
            srli    t2, t2,3
            add     a1, a5,t2
            j       uart.stringOutInt

uart.stringElOut.oob:       li      a1, -1
            ret

uart.stringOut:  li      a1, 0
            mv      a7, a0
            qdtb    a6, a7

uart.stringOutInt:
            push    0,0
            sp      ra, 0(frame)

uart.stringOutInt.nxt:       beq     a1,a6,uart.stringOutInt.end
            nop
            lbu.r   a0, a1(a7)
            beqz    a0, uart.stringOutInt.end
            jal     uart.charOut
            addi    a1, a1,1
            j       uart.stringOutInt.nxt

uart.stringOutInt.end:       lp      ra, 0(frame)
            pop
            ret


uart.end:


.section util, "xa"
.align 3
.word util.trampEnd - util.trampStart
.word (util.end - util.trampStart - 4)

util.trampStart:
util.mul__: j util.mul_
util.divu__: j util.divu_
util.trampEnd:

#mul a2, a1,a0
util.mul_:       mv      a2, zero
util.mul_loop:   beqz    a1, util.mul_end
            add     a2, a2,a0
            addi    a1, a1,-1
            j       util.mul_loop
util.mul_end:    ret


#takes:		a0 = dividend, a1 = divisor
#returns:	a0 = quotient, a1 = rest
util.divu_:		beqz	a1,util.divu_end    #TODO: fix this
			li	    t2, 32			#counter
			clz		t1, a0			#leading zeros
			sub		t2, t2,t1   	#remaining counter (may be 0) 
			sll		a0, a0,t1
			li      t1, 0           #AC
			beqz    t2, util.divu_done
util.divu_loop:	rori	t0, a0,31
            and		t0, t0,1		#Bit 31 alter Dividend
			slli   	a0, a0,1		#Dividend << 1
            slli   	t1, t1,1		#AC << 1
			or		t1, t1,t0
			bltu	t1,a1,util.divu_nope
			sub		t1, t1,a1
			addi    a0, a0,1
util.divu_nope: 	addi    t2, t2,-1
			bnez    t2, util.divu_loop
util.divu_done:	mv		a1, t1
util.divu_end:   ret

util.end:



