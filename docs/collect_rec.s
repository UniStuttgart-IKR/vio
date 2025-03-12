collect:
        lf      t2, a0
        andi    t1, t2,8
        beqz    t1, visit
        #return forwarding ptr if obj was already visited
        lw      a0, 0(a0)
        ret

        #mark obj as visited
visit:  mv      a2, a0
        ori     t1, t2,8
        sf      t1, a2

        #allocate new hülle
        qsz     t1, a2
        alc     a1, t1
        sf      t2, a1

        beqz    t1, end #if obj of size 0, nothing has to be copied

        #pre-load first element and store fwd-ptr
        lw      a0, 0(a2)
        sw      a1, 0(a2)

        #iterate over every element
        add     t6, a2,t1
loop:   addi    a2, a2,4

        #check if word is data
        spt     t4, a0
        beqz    t4, copy

        #has to be a ptr from here on
        #check if target obj is already copied
        lf      t5, a0
        andi    t5, t5,8
        bnez    t5, loadfwdptr

        #target has not been visited yet
        #save current state
        itd     t1, a2
        sw      t1, -4(t6)  #current index at bottom of to-space obj
        sw      s2, 0(a2)   #current caller at current element
        btd     s2, a2
        dtp     s2, s2,zero #current object to current caller

        jal     collect

        qsz     t1, s2
        add     t6, s2,t1
        lw      a1, 0(s2)  #restore current to-space base-ptr
        lw      t1, -4(t6) #restore current index
        addi    a1, a1,t1  #add index to to-space ptr
        addi    a2, s2,t1  #add index to from-space ptr

        j       copy

loadfwdptr:
        lw      t3, 0(t3)
copy:   sw      t3, 0(t3)
        addi    a0, a0,4
        j       loop

end:    lw      