collect:    qsz     t1, a1
            lw      a0, 0(a1)   #load backlink
            lw      s1, 4(a1)   #load next pointer
            add     t6, a1,t1
            add     t5, a0,t1
loop:       lw      t2, 0(t5)
entry:      addi    a0, a0,4
            addi    a1, a1,4
            bltu    t6,a1,end

            lw      t2, 0(t5)
            spt     t3, t2

            bnez    t3, pointer
            sw      t2, 0(t6)
            j       loop

pointer:    lf      t4, t2
            andi    t4, t4,128
            bnez    t4, visited
            
            qsz     t3, t2
            alc     t3, t3
            sw      t3, 8(s0)
            lf      t4, t2
            sf      t4, t3
            ori     t4, t4,128
            sf      t4, t2
            itd     t4, t2
            sub     t2, t2,t4
            lw      t1, 0(t2)
            sw      t1, 0(t3)
            sw      t2, 4(t3)
            add     t3, t3,t4
            sw      t3, 0(t6)
            j       loop

visited:    