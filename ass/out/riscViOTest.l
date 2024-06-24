
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0004                	.insn	2, 0x0004
   2:	0000                	.insn	2, 0x
   4:	007f 0000   	.insn	10, 0x01130040006f0000007f
   c:	 

00000008 <core.start_>:
   8:	0040006f          	jal	zero,c <core.start>

0000000c <core.start>:
   c:	30500113          	addi	frame,zero,773
  10:	1031720b          	push	4,8
  14:	00c000ef          	jal	rix,20 <core.entry>
  18:	00000013          	addi	zero,zero,0
  1c:	00000013          	addi	zero,zero,0

00000020 <core.entry>:
  20:	00000013          	addi	zero,zero,0
  24:	00000013          	addi	zero,zero,0
  28:	00000013          	addi	zero,zero,0
  2c:	00000013          	addi	zero,zero,0
  30:	00000013          	addi	zero,zero,0
  34:	00000013          	addi	zero,zero,0
  38:	00000013          	addi	zero,zero,0
  3c:	00000013          	addi	zero,zero,0
  40:	00c00293          	addi	t0,zero,12
  44:	01800313          	addi	t1,zero,24
  48:	005303b3          	add	t2,t1,t0
  4c:	0021708b          	pushg	1,0
  50:	0011100b          	sp	rix,0(frame)
  54:	00112023          	sw	rix,0(frame)
  58:	00000417          	auipc	s0,0x0
  5c:	03040413          	addi	s0,s0,48 # 88 <core.end>
  60:	00040493          	addi	s1,s0,0
  64:	0091100b          	sp	s1,0(frame)
  68:	0084300b          	jlib	s0,8
  6c:	0001240b          	lp	s0,0(frame)
  70:	00c4300b          	jlib	s0,12
  74:	00c00293          	addi	t0,zero,12
  78:	01800313          	addi	t1,zero,24
  7c:	005303b3          	add	t2,t1,t0
  80:	00100073          	ebreak

00000084 <doom>:
  84:	000002ef          	jal	t0,84 <doom>

Disassembly of section usb:

00000088 <usb.af_-0x8>:
  88:	0008                	.insn	2, 0x0008
  8a:	0000                	.insn	2, 0x
  8c:	000000f7          	.insn	4, 0x00f7

00000090 <usb.af_>:
  90:	0080006f          	jal	zero,98 <usb.af>

00000094 <usb.b_>:
  94:	0500006f          	jal	zero,e4 <usb.b>

00000098 <usb.af>:
  98:	4062fe33          	andn	t3,t0,t1
  9c:	4062eeb3          	orn	t4,t0,t1
  a0:	4062cf33          	xnor	t5,t0,t1
  a4:	60029f93          	clz	t6,t0
  a8:	60129513          	ctz	a0,t0
  ac:	60229593          	cpop	a1,t0
  b0:	0a62e633          	max	a2,t0,t1
  b4:	0a62f6b3          	maxu	a3,t0,t1
  b8:	0a62c733          	min	a4,t0,t1
  bc:	0a62d7b3          	minu	a5,t0,t1
  c0:	60429413          	sext.b	s0,t0
  c4:	60531493          	sext.h	s1,t1
  c8:	0802c933          	zext.h	s2,t0
  cc:	606299b3          	rol	s3,t0,t1
  d0:	6062da33          	ror	s4,t0,t1
  d4:	6102da93          	rori	s5,t0,0x10
  d8:	2872db13          	orc.b	s6,t0
  dc:	6982dc13          	rev8	s8,t0
  e0:	00008067          	jalr	zero,0(rix)

000000e4 <usb.b>:
  e4:	0031700b          	push	0,0
  e8:	00112023          	sw	rix,0(frame)
  ec:	4062fe33          	andn	t3,t0,t1
  f0:	4062eeb3          	orn	t4,t0,t1
  f4:	4062cf33          	xnor	t5,t0,t1
  f8:	60029f93          	clz	t6,t0
  fc:	60129513          	ctz	a0,t0
 100:	60229593          	cpop	a1,t0
 104:	0a62e633          	max	a2,t0,t1
 108:	0a62f6b3          	maxu	a3,t0,t1
 10c:	0a62c733          	min	a4,t0,t1
 110:	0a62d7b3          	minu	a5,t0,t1
 114:	60429413          	sext.b	s0,t0
 118:	60531493          	sext.h	s1,t1
 11c:	0802c933          	zext.h	s2,t0
 120:	606299b3          	rol	s3,t0,t1
 124:	6062da33          	ror	s4,t0,t1
 128:	6102da93          	rori	s5,t0,0x10
 12c:	2872db13          	orc.b	s6,t0
 130:	6982dc13          	rev8	s8,t0
 134:	00c000ef          	jal	rix,140 <usb.c>
 138:	00012083          	lw	rix,0(frame)
 13c:	00008067          	jalr	zero,0(rix)

00000140 <usb.c>:
 140:	4062fe33          	andn	t3,t0,t1
 144:	4062eeb3          	orn	t4,t0,t1
 148:	4062cf33          	xnor	t5,t0,t1
 14c:	60029f93          	clz	t6,t0
 150:	60129513          	ctz	a0,t0
 154:	60229593          	cpop	a1,t0
 158:	0a62e633          	max	a2,t0,t1
 15c:	0a62f6b3          	maxu	a3,t0,t1
 160:	0a62c733          	min	a4,t0,t1
 164:	0a62d7b3          	minu	a5,t0,t1
 168:	60429413          	sext.b	s0,t0
 16c:	60531493          	sext.h	s1,t1
 170:	0802c933          	zext.h	s2,t0
 174:	606299b3          	rol	s3,t0,t1
 178:	6062da33          	ror	s4,t0,t1
 17c:	6102da93          	rori	s5,t0,0x10
 180:	2872db13          	orc.b	s6,t0
 184:	6982dc13          	rev8	s8,t0
 188:	00008067          	jalr	zero,0(rix)

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
