
out/ral_test.elf:     Dateiformat elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0004                	.insn	2, 0x0004
   2:	0000                	.insn	2, 0x
   4:	000001f3          	.insn	4, 0x01f3

00000008 <core.start_>:
   8:	0040006f          	jal	zero,c <core.start>

0000000c <core.start>:
   c:	00000013          	addi	zero,zero,0
  10:	00000013          	addi	zero,zero,0
  14:	00000013          	addi	zero,zero,0
  18:	00000013          	addi	zero,zero,0
  1c:	00000013          	addi	zero,zero,0
  20:	00000013          	addi	zero,zero,0
  24:	00000013          	addi	zero,zero,0
  28:	00000013          	addi	zero,zero,0
  2c:	00c00293          	addi	t0,zero,12
  30:	01800313          	addi	t1,zero,24
  34:	00000013          	addi	zero,zero,0
  38:	00000013          	addi	zero,zero,0
  3c:	00000013          	addi	zero,zero,0
  40:	00000013          	addi	zero,zero,0
  44:	0804708b          	alci	s0,1,4
  48:	00642023          	sw	t1,0(s0)
  4c:	00000013          	addi	zero,zero,0
  50:	00000013          	addi	zero,zero,0
  54:	00000013          	addi	zero,zero,0
  58:	00000013          	addi	zero,zero,0
  5c:	00000013          	addi	zero,zero,0
  60:	00000013          	addi	zero,zero,0
  64:	00042383          	lw	t2,0(s0)
  68:	00700e33          	add	t3,zero,t2
  6c:	00000013          	addi	zero,zero,0
  70:	00000013          	addi	zero,zero,0
  74:	00000013          	addi	zero,zero,0
  78:	0804f08b          	alci	s1,1,4
  7c:	0094100b          	sp	s1,0(s0)
  80:	0809708b          	alci	s2,1,4
  84:	0124900b          	sp	s2,0(s1)
  88:	00000013          	addi	zero,zero,0
  8c:	00000013          	addi	zero,zero,0
  90:	00042383          	lw	t2,0(s0)
  94:	0140006f          	jal	zero,a8 <no_reg_rd>
  98:	00700eb3          	add	t4,zero,t2
  9c:	00000013          	addi	zero,zero,0
  a0:	00000013          	addi	zero,zero,0
  a4:	00000013          	addi	zero,zero,0

000000a8 <no_reg_rd>:
  a8:	00000013          	addi	zero,zero,0
  ac:	00000013          	addi	zero,zero,0
  b0:	00000013          	addi	zero,zero,0
  b4:	00000013          	addi	zero,zero,0
  b8:	00000013          	addi	zero,zero,0
  bc:	0004228b          	lp	t0,0(s0)
  c0:	0002a30b          	lp	t1,0(t0)
  c4:	00000013          	addi	zero,zero,0
  c8:	00000013          	addi	zero,zero,0
  cc:	00000013          	addi	zero,zero,0
  d0:	00000013          	addi	zero,zero,0
  d4:	00042e0b          	lp	t3,0(s0)
  d8:	0140006f          	jal	zero,ec <no_ptr_reg_load>
  dc:	000e2e8b          	lp	t4,0(t3)
  e0:	00000013          	addi	zero,zero,0
  e4:	00000013          	addi	zero,zero,0
  e8:	00000013          	addi	zero,zero,0

000000ec <no_ptr_reg_load>:
  ec:	00000013          	addi	zero,zero,0
  f0:	00000013          	addi	zero,zero,0
  f4:	00000013          	addi	zero,zero,0
  f8:	00000013          	addi	zero,zero,0
  fc:	00000013          	addi	zero,zero,0
 100:	00000013          	addi	zero,zero,0
 104:	00000013          	addi	zero,zero,0
 108:	00000013          	addi	zero,zero,0
 10c:	00100073          	ebreak
 110:	30000113          	addi	frame,zero,768
 114:	0dc00093          	addi	rix,zero,220
 118:	0ba00193          	addi	rcd,zero,186
 11c:	0601708b          	alci	frame,1,3
 120:	00512023          	sw	t0,0(frame)
 124:	00012303          	lw	t1,0(frame)
 128:	02112ba3          	sw	rix,55(frame)
 12c:	00512023          	sw	t0,0(frame)
 130:	00012303          	lw	t1,0(frame)
 134:	02212083          	lw	rix,34(frame)
 138:	0031208b          	lp	rix,3(frame)
 13c:	0621708b          	pushg	1,3
 140:	02112ba3          	sw	rix,55(frame)
 144:	0231108b          	sp	rcd,33(frame)
 148:	00512023          	sw	t0,0(frame)
 14c:	00012303          	lw	t1,0(frame)
 150:	02212083          	lw	rix,34(frame)
 154:	0031208b          	lp	rix,3(frame)
 158:	0031218b          	lp	rcd,3(frame)
 15c:	00000013          	addi	zero,zero,0
 160:	00000013          	addi	zero,zero,0
 164:	00000013          	addi	zero,zero,0
 168:	00000013          	addi	zero,zero,0
 16c:	00000013          	addi	zero,zero,0
 170:	00000013          	addi	zero,zero,0
 174:	00000013          	addi	zero,zero,0
 178:	00000013          	addi	zero,zero,0
 17c:	00100073          	ebreak
 180:	00300313          	addi	t1,zero,3
 184:	00c00393          	addi	t2,zero,12
 188:	00e00e13          	addi	t3,zero,14
 18c:	01100e93          	addi	t4,zero,17
 190:	0073440b          	alc	s0,t1,t2
 194:	00d42283          	lw	t0,13(s0)
 198:	05d47283          	lw.r	t0,t4(s0)
 19c:	00d4228b          	lp	t0,13(s0)
 1a0:	03d4028b          	lp.r	t0,t4(s0)
 1a4:	00100073          	ebreak
 1a8:	1804f40b          	alci	s1,8,12
 1ac:	011e590b          	alci.p	s2,t3,17
 1b0:	0133698b          	alci.d	s3,t1,19
 1b4:	0621708b          	pushg	1,3
 1b8:	55500e13          	addi	t3,zero,1365
 1bc:	00100e93          	addi	t4,zero,1
 1c0:	01c42023          	sw	t3,0(s0)
 1c4:	00042f03          	lw	t5,0(s0)
 1c8:	00800313          	addi	t1,zero,8
 1cc:	0fe00f93          	addi	t6,zero,254
 1d0:	04647fa3          	sw.r	t6,t1(s0)
 1d4:	04647383          	lw.r	t2,t1(s0)
 1d8:	0084100b          	sp	s0,0(s0)
 1dc:	0004230b          	lp	t1,0(s0)
 1e0:	00100293          	addi	t0,zero,1
 1e4:	0054040b          	sp.r	s0,t0(s0)
 1e8:	0254038b          	lp.r	t2,t0(s0)
 1ec:	555552b7          	lui	t0,0x55555
 1f0:	5552e293          	ori	t0,t0,1365
 1f4:	00100073          	ebreak

000001f8 <doom>:
 1f8:	000002ef          	jal	t0,1f8 <doom>

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2e41                	.insn	2, 0x2e41
   2:	0000                	.insn	2, 0x
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <core.start+0x8>
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
