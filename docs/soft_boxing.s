excHandler:     csrrw   mscratch,t0,mscratch
                lw      t0, 40(gp)
                bnez    t0, alreadySaved
                lw      t0, 44(gp)
                csrrw   msad,t0,msad
                sw      t0, 48(gp)
                csrrw   mscratch,t0,mscratch
                sw      t0, 52(gp)
                csrrw   mepc,t0,mepc
                sw      t0, 56(gp)
                sw      t1, 60(gp)

alreadySaved:   csrr    t0, mtval
                csrr    t1, msad
                btd     t0, t0
                btd     t1, t1
                bne     t0,t1,excVector
                csrr    t0, malc
                beqz    t0, heapov

                alci.d  t0, malc,124
                csrw    t0, msad

return:         #restore state
