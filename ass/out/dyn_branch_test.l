
out/dyn_branch_test.elf:     Dateiformat elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
   0:	04500293          	addi	t0,zero,69
   4:	00200313          	addi	t1,zero,2
   8:	00000013          	addi	zero,zero,0
   c:	00000013          	addi	zero,zero,0
  10:	00000013          	addi	zero,zero,0
  14:	00000013          	addi	zero,zero,0
  18:	00000013          	addi	zero,zero,0
  1c:	00000013          	addi	zero,zero,0
  20:	00100293          	addi	t0,zero,1
  24:	00100313          	addi	t1,zero,1
  28:	00000013          	addi	zero,zero,0
  2c:	00000013          	addi	zero,zero,0
  30:	00000013          	addi	zero,zero,0
  34:	00000013          	addi	zero,zero,0
  38:	00628463          	beq	t0,t1,40 <ok1>
  3c:	1480006f          	jal	zero,184 <failure>

00000040 <ok1>:
  40:	00601463          	bne	zero,t1,48 <ok2>
  44:	1400006f          	jal	zero,184 <failure>

00000048 <ok2>:
  48:	00601463          	bne	zero,t1,50 <ok3>
  4c:	1380006f          	jal	zero,184 <failure>

00000050 <ok3>:
  50:	00200313          	addi	t1,zero,2
  54:	00000013          	addi	zero,zero,0
  58:	00000013          	addi	zero,zero,0
  5c:	00000013          	addi	zero,zero,0
  60:	00000013          	addi	zero,zero,0
  64:	0062c463          	blt	t0,t1,6c <ok4>
  68:	11c0006f          	jal	zero,184 <failure>

0000006c <ok4>:
  6c:	00200313          	addi	t1,zero,2
  70:	0062c463          	blt	t0,t1,78 <ok5>
  74:	1100006f          	jal	zero,184 <failure>

00000078 <ok5>:
  78:	00200313          	addi	t1,zero,2
  7c:	0062e463          	bltu	t0,t1,84 <ok6>
  80:	1040006f          	jal	zero,184 <failure>

00000084 <ok6>:
  84:	00535463          	bge	t1,t0,8c <ok7>
  88:	0fc0006f          	jal	zero,184 <failure>

0000008c <ok7>:
  8c:	00535463          	bge	t1,t0,94 <ok8>
  90:	0f40006f          	jal	zero,184 <failure>

00000094 <ok8>:
  94:	00200293          	addi	t0,zero,2
  98:	00000013          	addi	zero,zero,0
  9c:	00000013          	addi	zero,zero,0
  a0:	00000013          	addi	zero,zero,0
  a4:	00000013          	addi	zero,zero,0
  a8:	00535463          	bge	t1,t0,b0 <ok9>
  ac:	0d80006f          	jal	zero,184 <failure>

000000b0 <ok9>:
  b0:	00535463          	bge	t1,t0,b8 <ok10>
  b4:	0d00006f          	jal	zero,184 <failure>

000000b8 <ok10>:
  b8:	00000297          	auipc	t0,0x0
  bc:	02428293          	addi	t0,t0,36 # dc <ok11>
  c0:	00000013          	addi	zero,zero,0
  c4:	00000013          	addi	zero,zero,0
  c8:	00000013          	addi	zero,zero,0
  cc:	00000013          	addi	zero,zero,0
  d0:	00000013          	addi	zero,zero,0
  d4:	00028067          	jalr	zero,0(t0)
  d8:	0ac0006f          	jal	zero,184 <failure>

000000dc <ok11>:
  dc:	11100513          	addi	a0,zero,273
  e0:	0ac0006f          	jal	zero,18c <doom>
  e4:	00628e33          	add	t3,t0,t1
  e8:	40628eb3          	sub	t4,t0,t1
  ec:	00629f33          	sll	t5,t0,t1
  f0:	0062afb3          	slt	t6,t0,t1
  f4:	0062b533          	sltu	a0,t0,t1
  f8:	0062c5b3          	xor	a1,t0,t1
  fc:	0062d633          	srl	a2,t0,t1
 100:	4062d6b3          	sra	a3,t0,t1
 104:	0062e733          	or	a4,t0,t1
 108:	0062f7b3          	and	a5,t0,t1
 10c:	1a428413          	addi	s0,t0,420
 110:	e5c30493          	addi	s1,t1,-420
 114:	1a42a913          	slti	s2,t0,420
 118:	1a42b993          	sltiu	s3,t0,420
 11c:	1a42ca13          	xori	s4,t0,420
 120:	1a42ea93          	ori	s5,t0,420
 124:	1a42fb13          	andi	s6,t0,420
 128:	00229c13          	slli	s8,t0,0x2
 12c:	0022dc93          	srli	s9,t0,0x2
 130:	4022dd13          	srai	bm,t0,0x2
 134:	4062fe33          	andn	t3,t0,t1
 138:	4062eeb3          	orn	t4,t0,t1
 13c:	4062cf33          	xnor	t5,t0,t1
 140:	60029f93          	clz	t6,t0
 144:	60129513          	ctz	a0,t0
 148:	60229593          	cpop	a1,t0
 14c:	0a62e633          	max	a2,t0,t1
 150:	0a62f6b3          	maxu	a3,t0,t1
 154:	0a62c733          	min	a4,t0,t1
 158:	0a62d7b3          	minu	a5,t0,t1
 15c:	60429413          	sext.b	s0,t0
 160:	60531493          	sext.h	s1,t1
 164:	0802c933          	zext.h	s2,t0
 168:	606299b3          	rol	s3,t0,t1
 16c:	6062da33          	ror	s4,t0,t1
 170:	6102da93          	rori	s5,t0,0x10
 174:	2872db13          	orc.b	s6,t0
 178:	6982dc13          	rev8	s8,t0
 17c:	e8dff2ef          	jal	t0,8 <usb.a__>
 180:	0025100b          	sp	frame,0(a0)

00000184 <failure>:
 184:	55500513          	addi	a0,zero,1365
 188:	0040006f          	jal	zero,18c <doom>

0000018c <doom>:
 18c:	00000013          	addi	zero,zero,0
 190:	00000013          	addi	zero,zero,0
 194:	00000013          	addi	zero,zero,0
 198:	00000013          	addi	zero,zero,0
 19c:	00000013          	addi	zero,zero,0
 1a0:	00000013          	addi	zero,zero,0
 1a4:	00100073          	ebreak
 1a8:	fe5ff2ef          	jal	t0,18c <doom>

Disassembly of section usb:

00000000 <usb.a__-0x8>:
   0:	0014                	.insn	2, 0x0014
   2:	0000                	.insn	2, 0x
   4:	00ec                	.insn	2, 0x00ec
	...

00000008 <usb.a__>:
   8:	00c0006f          	jal	zero,14 <usb.a_>

0000000c <usb.b>:
   c:	0500006f          	jal	zero,5c <usb.b_>

00000010 <usb.c>:
  10:	0940006f          	jal	zero,a4 <usb.c_>

00000014 <usb.a_>:
  14:	4062fe33          	andn	t3,t0,t1
  18:	4062eeb3          	orn	t4,t0,t1
  1c:	4062cf33          	xnor	t5,t0,t1
  20:	60029f93          	clz	t6,t0
  24:	60129513          	ctz	a0,t0
  28:	60229593          	cpop	a1,t0
  2c:	0a62e633          	max	a2,t0,t1
  30:	0a62f6b3          	maxu	a3,t0,t1
  34:	0a62c733          	min	a4,t0,t1
  38:	0a62d7b3          	minu	a5,t0,t1
  3c:	60429413          	sext.b	s0,t0
  40:	60531493          	sext.h	s1,t1
  44:	0802c933          	zext.h	s2,t0
  48:	606299b3          	rol	s3,t0,t1
  4c:	6062da33          	ror	s4,t0,t1
  50:	6102da93          	rori	s5,t0,0x10
  54:	2872db13          	orc.b	s6,t0
  58:	6982dc13          	rev8	s8,t0

0000005c <usb.b_>:
  5c:	4062fe33          	andn	t3,t0,t1
  60:	4062eeb3          	orn	t4,t0,t1
  64:	4062cf33          	xnor	t5,t0,t1
  68:	60029f93          	clz	t6,t0
  6c:	60129513          	ctz	a0,t0
  70:	60229593          	cpop	a1,t0
  74:	0a62e633          	max	a2,t0,t1
  78:	0a62f6b3          	maxu	a3,t0,t1
  7c:	0a62c733          	min	a4,t0,t1
  80:	0a62d7b3          	minu	a5,t0,t1
  84:	60429413          	sext.b	s0,t0
  88:	60531493          	sext.h	s1,t1
  8c:	0802c933          	zext.h	s2,t0
  90:	606299b3          	rol	s3,t0,t1
  94:	6062da33          	ror	s4,t0,t1
  98:	6102da93          	rori	s5,t0,0x10
  9c:	2872db13          	orc.b	s6,t0
  a0:	6982dc13          	rev8	s8,t0

000000a4 <usb.c_>:
  a4:	4062fe33          	andn	t3,t0,t1
  a8:	4062eeb3          	orn	t4,t0,t1
  ac:	4062cf33          	xnor	t5,t0,t1
  b0:	60029f93          	clz	t6,t0
  b4:	60129513          	ctz	a0,t0
  b8:	60229593          	cpop	a1,t0
  bc:	0a62e633          	max	a2,t0,t1
  c0:	0a62f6b3          	maxu	a3,t0,t1
  c4:	0a62c733          	min	a4,t0,t1
  c8:	0a62d7b3          	minu	a5,t0,t1
  cc:	60429413          	sext.b	s0,t0
  d0:	60531493          	sext.h	s1,t1
  d4:	0802c933          	zext.h	s2,t0
  d8:	606299b3          	rol	s3,t0,t1
  dc:	6062da33          	ror	s4,t0,t1
  e0:	6102da93          	rori	s5,t0,0x10
  e4:	2872db13          	orc.b	s6,t0
  e8:	6982dc13          	rev8	s8,t0

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2e41                	.insn	2, 0x2e41
   2:	0000                	.insn	2, 0x
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <usb.a_>
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
