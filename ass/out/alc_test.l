
out/alc_test.elf:     file format elf32-littleriscv


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
  28:	005303b3          	add	t2,t1,t0
  2c:	00000013          	addi	zero,zero,0
  30:	00000013          	addi	zero,zero,0
  34:	00000013          	addi	zero,zero,0
  38:	00000013          	addi	zero,zero,0
  3c:	0204720b          	alci	s0,1,4
  40:	0604f90b          	alci	s1,3,18
  44:	0209720b          	alci	s2,1,4
  48:	0609f90b          	alci	s3,3,18
  4c:	00000013          	addi	zero,zero,0
  50:	00000013          	addi	zero,zero,0
  54:	00000013          	addi	zero,zero,0
  58:	00000013          	addi	zero,zero,0
  5c:	00000013          	addi	zero,zero,0
  60:	00000013          	addi	zero,zero,0
  64:	00100073          	ebreak
  68:	30000113          	addi	frame,zero,768
  6c:	0dc00093          	addi	rix,zero,220
  70:	0ba00193          	addi	rcd,zero,186
  74:	0201718b          	alci	frame,1,3
  78:	00512023          	sw	t0,0(frame)
  7c:	00012303          	lw	t1,0(frame)
  80:	0631708b          	pusht	3,1
  84:	02112ba3          	sw	rix,55(frame)
  88:	00512023          	sw	t0,0(frame)
  8c:	00012303          	lw	t1,0(frame)
  90:	02212083          	lw	rix,34(frame)
  94:	0031208b          	lp	rix,3(frame)
  98:	0221718b          	pushg	1,3
  9c:	02112ba3          	sw	rix,55(frame)
  a0:	0231108b          	sp	rcd,33(frame)
  a4:	00512023          	sw	t0,0(frame)
  a8:	00012303          	lw	t1,0(frame)
  ac:	02212083          	lw	rix,34(frame)
  b0:	0031208b          	lp	rix,3(frame)
  b4:	0031218b          	lp	rcd,3(frame)
  b8:	00000013          	addi	zero,zero,0
  bc:	00000013          	addi	zero,zero,0
  c0:	00000013          	addi	zero,zero,0
  c4:	00000013          	addi	zero,zero,0
  c8:	00000013          	addi	zero,zero,0
  cc:	00000013          	addi	zero,zero,0
  d0:	00000013          	addi	zero,zero,0
  d4:	00000013          	addi	zero,zero,0
  d8:	00100073          	ebreak
  dc:	00300313          	addi	t1,zero,3
  e0:	00c00393          	addi	t2,zero,12
  e4:	00e00e13          	addi	t3,zero,14
  e8:	01100e93          	addi	t4,zero,17
  ec:	0073440b          	alc	s0,t1,t2
  f0:	00d42283          	lw	t0,13(s0)
  f4:	05d47283          	lw.r	t0,t4(s0)
  f8:	00d4228b          	lp	t0,13(s0)
  fc:	03d4028b          	lp.r	t0,t4(s0)
 100:	00100073          	ebreak
 104:	1004f60b          	alci	s1,8,12
 108:	011e590b          	alci.p	s2,t3,17
 10c:	0133698b          	alci.d	s3,t1,19
 110:	0221718b          	pushg	1,3
 114:	0831748b          	pusht	4,9
 118:	55500e13          	addi	t3,zero,1365
 11c:	00100e93          	addi	t4,zero,1
 120:	01c42023          	sw	t3,0(s0)
 124:	00042f03          	lw	t5,0(s0)
 128:	00800313          	addi	t1,zero,8
 12c:	0fe00f93          	addi	t6,zero,254
 130:	04647fa3          	sw.r	t6,t1(s0)
 134:	04647383          	lw.r	t2,t1(s0)
 138:	0084100b          	sp	s0,0(s0)
 13c:	0004230b          	lp	t1,0(s0)
 140:	00100293          	addi	t0,zero,1
 144:	0054040b          	sp.r	s0,t0(s0)
 148:	0254038b          	lp.r	t2,t0(s0)
 14c:	555552b7          	lui	t0,0x55555
 150:	5552e293          	ori	t0,t0,1365
 154:	00100073          	ebreak

00000158 <doom>:
 158:	000002ef          	jal	t0,158 <doom>

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
