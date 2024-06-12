
out/alc_test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
   0:	00c00293          	addi	t0,zero,12
   4:	01800313          	addi	t1,zero,24
   8:	30000113          	addi	frame,zero,768
   c:	00000013          	addi	zero,zero,0
  10:	00000013          	addi	zero,zero,0
  14:	00000013          	addi	zero,zero,0
  18:	00000013          	addi	zero,zero,0
  1c:	00000013          	addi	zero,zero,0
  20:	00000013          	addi	zero,zero,0
  24:	00300313          	addi	t1,zero,3
  28:	00c00393          	addi	t2,zero,12
  2c:	00e00e13          	addi	t3,zero,14
  30:	01100e93          	addi	t4,zero,17
  34:	00000013          	addi	zero,zero,0
  38:	00000013          	addi	zero,zero,0
  3c:	00000013          	addi	zero,zero,0
  40:	00000013          	addi	zero,zero,0
  44:	0073440b          	alc	s0,t1,t2
  48:	00000013          	addi	zero,zero,0
  4c:	00000013          	addi	zero,zero,0
  50:	00000013          	addi	zero,zero,0
  54:	00000013          	addi	zero,zero,0
  58:	1004f60b          	alci	s1,8,12
  5c:	00000013          	addi	zero,zero,0
  60:	00000013          	addi	zero,zero,0
  64:	00000013          	addi	zero,zero,0
  68:	00000013          	addi	zero,zero,0
  6c:	011e590b          	alci.p	s2,t3,17
  70:	00000013          	addi	zero,zero,0
  74:	00000013          	addi	zero,zero,0
  78:	00000013          	addi	zero,zero,0
  7c:	00000013          	addi	zero,zero,0
  80:	0133698b          	alci.d	s3,t1,19
  84:	00000013          	addi	zero,zero,0
  88:	00000013          	addi	zero,zero,0
  8c:	00000013          	addi	zero,zero,0
  90:	00000013          	addi	zero,zero,0
  94:	0221718b          	pushg	1,3
  98:	00000013          	addi	zero,zero,0
  9c:	00000013          	addi	zero,zero,0
  a0:	00000013          	addi	zero,zero,0
  a4:	00000013          	addi	zero,zero,0
  a8:	0831748b          	pusht	4,9
  ac:	55500e13          	addi	t3,zero,1365
  b0:	00100e93          	addi	t4,zero,1
  b4:	00000013          	addi	zero,zero,0
  b8:	00000013          	addi	zero,zero,0
  bc:	00000013          	addi	zero,zero,0
  c0:	01c42023          	sw	t3,0(s0)
  c4:	00042f03          	lw	t5,0(s0)
  c8:	00800313          	addi	t1,zero,8
  cc:	0fe00f93          	addi	t6,zero,254
  d0:	00000013          	addi	zero,zero,0
  d4:	00000013          	addi	zero,zero,0
  d8:	00000013          	addi	zero,zero,0
  dc:	00000013          	addi	zero,zero,0
  e0:	04647fa3          	sw.r	t6,t1(s0)
  e4:	04647383          	lw.r	t2,t1(s0)

000000e8 <doom>:
  e8:	000002ef          	jal	t0,e8 <doom>

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2e41                	.insn	2, 0x2e41
   2:	0000                	.insn	2, 0x
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <_start+0x14>
   c:	0024                	.insn	2, 0x0024
   e:	0000                	.insn	2, 0x
  10:	7205                	.insn	2, 0x7205
  12:	3376                	.insn	2, 0x3376
  14:	6932                	.insn	2, 0x6932
  16:	7032                	.insn	2, 0x7032
  18:	5f31                	.insn	2, 0x5f31
  1a:	727a                	.insn	2, 0x727a
  1c:	3169                	.insn	2, 0x3169
  1e:	3070                	.insn	2, 0x3070
  20:	7a5f 726f 7031      	.insn	6, 0x7031726f7a5f
  26:	5f30                	.insn	2, 0x5f30
  28:	627a                	.insn	2, 0x627a
  2a:	3162                	.insn	2, 0x3162
  2c:	3070                	.insn	2, 0x3070
	...
