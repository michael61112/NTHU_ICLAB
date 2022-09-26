BIT_N = 16
INSTRUCTION_N = 32


fp_a = open("pat_a.dat" ,'w')
fp_b = open("pat_b.dat" ,'w')
fp_intr = open("pat_instr.dat" ,'w')
fp_gold = open("golden.dat" ,'w')


for i in range(0,INSTRUCTION_N):
    for j in range(0, BIT_N):
        a = (1<<j) & 0xffff
        for k in range(0, BIT_N):
            b = (1<<k) & 0xffff
            if i == 0 :
                out = a
            elif i == 1:
                out = a + 1
            elif i == 2:
                out = a + (~b)
            elif i == 3:
                out = a + (~b) + 1
            elif i == 4:
                out = a + b
            elif i == 5:
                out = a + b + 1
            elif i == 6:
                out = b
            elif i == 7:
                out = a - 1
            
            elif i == 8:
                out = a & b
            elif i == 9:
                out = a | b
            elif i == 10:
                out = a ^ b
            elif i == 11:
                out = ~a
            
            elif i == 16:
                out = b>>1
            elif i == 17:
                out = b*2
            elif i == 18:
                if ((b%2)!=0):
                    out = (b>>1) + 32768 #2^15
                else:
                    out = b>>1
            elif i == 19:
                if ((b & 32768) != 0):
                    out = (b*2) + 1
                else :
                    out = (b*2)
            else:
                break
            out = out & 0xffff
            print(f'instr: {hex(i)[2:]}, A: {hex(a)[2:]}, B: {hex(b)[2:]}, out: {hex(out)[2:]}')
            fp_a.write(f'{hex(a)[2:]}\n')
            fp_b.write(f'{hex(b)[2:]}\n')
            fp_intr.write(f'{hex(i)[2:]}\n')
            fp_gold.write(f'{hex(out)[2:]}\n')
            
            
fp_a.close()
fp_b.close()
fp_intr.close()
fp_gold.close()


