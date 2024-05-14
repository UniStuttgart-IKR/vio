.globl _start

.text
#https://irsnasnoc.synology.me/

_start:     li      t0, 69
            li      t1, 2
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

