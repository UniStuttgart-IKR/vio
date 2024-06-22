
out/ral_test.elf:     Dateiformat elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
   0:	00000013          	addi	zero,zero,0
   4:	00000013          	addi	zero,zero,0
   8:	00000013          	addi	zero,zero,0
   c:	00000013          	addi	zero,zero,0
  10:	00000013          	addi	zero,zero,0
  14:	00000013          	addi	zero,zero,0
  18:	00000013          	addi	zero,zero,0
  1c:	00000013          	addi	zero,zero,0
  20:	00c00293          	addi	t0,zero,12
  24:	01800313          	addi	t1,zero,24
  28:	00000013          	addi	zero,zero,0
  2c:	00000013          	addi	zero,zero,0
  30:	00000013          	addi	zero,zero,0
  34:	00000013          	addi	zero,zero,0
  38:	0804708b          	alci	s0,1,4
  3c:	00642023          	sw	t1,0(s0)
  40:	00000013          	addi	zero,zero,0
  44:	00000013          	addi	zero,zero,0
  48:	00000013          	addi	zero,zero,0
  4c:	00000013          	addi	zero,zero,0
  50:	00000013          	addi	zero,zero,0
  54:	00000013          	addi	zero,zero,0
  58:	00042383          	lw	t2,0(s0)
  5c:	00700e33          	add	t3,zero,t2
  60:	00000013          	addi	zero,zero,0
  64:	00000013          	addi	zero,zero,0
  68:	00000013          	addi	zero,zero,0
  6c:	0804f08b          	alci	s1,1,4
  70:	0094100b          	sp	s1,0(s0)
  74:	0809708b          	alci	s2,1,4
  78:	0124900b          	sp	s2,0(s1)
  7c:	00000013          	addi	zero,zero,0
  80:	00000013          	addi	zero,zero,0
  84:	00042383          	lw	t2,0(s0)
  88:	0140006f          	jal	zero,9c <no_reg_rd>
  8c:	00700eb3          	add	t4,zero,t2
  90:	00000013          	addi	zero,zero,0
  94:	00000013          	addi	zero,zero,0
  98:	00000013          	addi	zero,zero,0

0000009c <no_reg_rd>:
  9c:	00000013          	addi	zero,zero,0
  a0:	00000013          	addi	zero,zero,0
  a4:	00000013          	addi	zero,zero,0
  a8:	00000013          	addi	zero,zero,0
  ac:	00000013          	addi	zero,zero,0
  b0:	0004228b          	lp	t0,0(s0)
  b4:	0002a30b          	lp	t1,0(t0)
  b8:	00000013          	addi	zero,zero,0
  bc:	00000013          	addi	zero,zero,0
  c0:	00000013          	addi	zero,zero,0
  c4:	00000013          	addi	zero,zero,0
  c8:	00042e0b          	lp	t3,0(s0)
  cc:	0140006f          	jal	zero,e0 <no_ptr_reg_load>
  d0:	000e2e8b          	lp	t4,0(t3)
  d4:	00000013          	addi	zero,zero,0
  d8:	00000013          	addi	zero,zero,0
  dc:	00000013          	addi	zero,zero,0

000000e0 <no_ptr_reg_load>:
  e0:	00000013          	addi	zero,zero,0
  e4:	00000013          	addi	zero,zero,0
  e8:	00000013          	addi	zero,zero,0
  ec:	00000013          	addi	zero,zero,0
  f0:	00000013          	addi	zero,zero,0
  f4:	00000013          	addi	zero,zero,0
  f8:	00000013          	addi	zero,zero,0
  fc:	00000013          	addi	zero,zero,0
 100:	00100073          	ebreak
 104:	30000113          	addi	frame,zero,768
 108:	0dc00093          	addi	rix,zero,220
 10c:	0ba00193          	addi	rcd,zero,186
 110:	0601708b          	alci	frame,1,3
 114:	00512023          	sw	t0,0(frame)
 118:	00012303          	lw	t1,0(frame)
 11c:	02112ba3          	sw	rix,55(frame)
 120:	00512023          	sw	t0,0(frame)
 124:	00012303          	lw	t1,0(frame)
 128:	02212083          	lw	rix,34(frame)
 12c:	0031208b          	lp	rix,3(frame)
 130:	0621708b          	pushg	1,3
 134:	02112ba3          	sw	rix,55(frame)
 138:	0231108b          	sp	rcd,33(frame)
 13c:	00512023          	sw	t0,0(frame)
 140:	00012303          	lw	t1,0(frame)
 144:	02212083          	lw	rix,34(frame)
 148:	0031208b          	lp	rix,3(frame)
 14c:	0031218b          	lp	rcd,3(frame)
 150:	00000013          	addi	zero,zero,0
 154:	00000013          	addi	zero,zero,0
 158:	00000013          	addi	zero,zero,0
 15c:	00000013          	addi	zero,zero,0
 160:	00000013          	addi	zero,zero,0
 164:	00000013          	addi	zero,zero,0
 168:	00000013          	addi	zero,zero,0
 16c:	00000013          	addi	zero,zero,0
 170:	00100073          	ebreak
 174:	00300313          	addi	t1,zero,3
 178:	00c00393          	addi	t2,zero,12
 17c:	00e00e13          	addi	t3,zero,14
 180:	01100e93          	addi	t4,zero,17
 184:	0073440b          	alc	s0,t1,t2
 188:	00d42283          	lw	t0,13(s0)
 18c:	05d47283          	lw.r	t0,t4(s0)
 190:	00d4228b          	lp	t0,13(s0)
 194:	03d4028b          	lp.r	t0,t4(s0)
 198:	00100073          	ebreak
 19c:	1804f40b          	alci	s1,8,12
 1a0:	011e590b          	alci.p	s2,t3,17
 1a4:	0133698b          	alci.d	s3,t1,19
 1a8:	0621708b          	pushg	1,3
 1ac:	55500e13          	addi	t3,zero,1365
 1b0:	00100e93          	addi	t4,zero,1
 1b4:	01c42023          	sw	t3,0(s0)
 1b8:	00042f03          	lw	t5,0(s0)
 1bc:	00800313          	addi	t1,zero,8
 1c0:	0fe00f93          	addi	t6,zero,254
 1c4:	04647fa3          	sw.r	t6,t1(s0)
 1c8:	04647383          	lw.r	t2,t1(s0)
 1cc:	0084100b          	sp	s0,0(s0)
 1d0:	0004230b          	lp	t1,0(s0)
 1d4:	00100293          	addi	t0,zero,1
 1d8:	0054040b          	sp.r	s0,t0(s0)
 1dc:	0254038b          	lp.r	t2,t0(s0)
 1e0:	555552b7          	lui	t0,0x55555
 1e4:	5552e293          	ori	t0,t0,1365
 1e8:	00100073          	ebreak

000001ec <doom>:
 1ec:	000002ef          	jal	t0,1ec <doom>

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
