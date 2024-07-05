
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	00f4                	.insn	2, 0x00f4
	...

00000008 <core.start_>:
   8:	0080006f          	jal	zero,10 <core.start>

0000000c <core.init_>:
   c:	01c0006f          	jal	zero,28 <core.init>

00000010 <core.start>:
  10:	00000197          	auipc	root,0x0
  14:	ff018193          	addi	root,root,-16 # 0 <core.start_-0x8>
  18:	fd0181f3          	ccp	root,root
  1c:	004180e7          	jalr	ra,4(root)
  20:	00000013          	addi	zero,zero,0
  24:	00000013          	addi	zero,zero,0

00000028 <core.init>:
  28:	00001137          	lui	frame,0x1
  2c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x695>
  30:	00000297          	auipc	t0,0x0
  34:	0a428293          	addi	t0,t0,164 # d4 <core.exc_handel>
  38:	30529073          	csrrw	zero,mtvec,t0
  3c:	01020337          	lui	t1,0x1020
  40:	30430313          	addi	t1,t1,772 # 1020304 <_end+0x1020194>
  44:	000083b7          	lui	t2,0x8
  48:	00538393          	addi	t2,t2,5 # 8005 <_end+0x7e95>
  4c:	08600e13          	addi	t3,zero,134
  50:	0e31708b          	push	1,7
  54:	0011100b          	sp	ra,0(frame)
  58:	0031100b          	sp	root,0(frame)
  5c:	00612023          	sw	t1,0(frame)
  60:	00711223          	sh	t2,4(frame)
  64:	01c10323          	sb	t3,6(frame)
  68:	00614703          	lbu	a4,6(frame)
  6c:	00610683          	lb	a3,6(frame)
  70:	00415603          	lhu	a2,4(frame)
  74:	00011583          	lh	a1,0(frame)
  78:	0001250b          	lp	a0,0(frame)
  7c:	0001208b          	lp	ra,0(frame)
  80:	00100073          	ebreak
  84:	00100313          	addi	t1,zero,1
  88:	00600393          	addi	t2,zero,6
  8c:	fe730cf3          	ciop	s9,t1,t2

00000090 <core.loop>:
  90:	00002283          	lw	t0,0(zero) # 0 <core.start_-0x8>
  94:	04900313          	addi	t1,zero,73
  98:	006c8023          	sb	t1,0(s9)
  9c:	0031708b          	push	1,0
  a0:	0011100b          	sp	ra,0(frame)
  a4:	00000517          	auipc	a0,0x0
  a8:	0b450513          	addi	a0,a0,180 # 158 <usb.end+0x4>
  ac:	fd050573          	ccp	a0,a0
  b0:	00000417          	auipc	s0,0x0
  b4:	05840413          	addi	s0,s0,88 # 108 <core.end+0x8>
  b8:	fd040473          	ccp	s0,s0
  bc:	00040493          	addi	s1,s0,0
  c0:	0091100b          	sp	s1,0(frame)
  c4:	000400e7          	jalr	ra,0(s0)
  c8:	0001240b          	lp	s0,0(frame)
  cc:	004400e7          	jalr	ra,4(s0)
  d0:	00100073          	ebreak

000000d4 <core.exc_handel>:
  d4:	00000013          	addi	zero,zero,0
  d8:	00000013          	addi	zero,zero,0
  dc:	00000013          	addi	zero,zero,0
  e0:	00000013          	addi	zero,zero,0
  e4:	00000013          	addi	zero,zero,0
  e8:	00000013          	addi	zero,zero,0
  ec:	00000013          	addi	zero,zero,0
  f0:	00000013          	addi	zero,zero,0
  f4:	30200073          	mret
  f8:	ffb28293          	addi	t0,t0,-5
  fc:	ff730313          	addi	t1,t1,-9

00000100 <core.end>:
 100:	0000                	.insn	2, 0x
	...

Disassembly of section usb:

00000108 <usb.af_-0x8>:
 108:	0008                	.insn	2, 0x0008
 10a:	0000                	.insn	2, 0x
 10c:	0040                	.insn	2, 0x0040
	...

00000110 <usb.af_>:
 110:	0080006f          	jal	zero,118 <usb.af>

00000114 <usb.b_>:
 114:	0100006f          	jal	zero,124 <usb.b>

00000118 <usb.af>:
 118:	00230293          	addi	t0,t1,2
 11c:	005e8e13          	addi	t3,t4,5
 120:	00008067          	jalr	zero,0(ra)

00000124 <usb.b>:
 124:	0031700b          	push	0,0
 128:	0011100b          	sp	ra,0(frame)
 12c:	010000ef          	jal	ra,13c <usb.c>
 130:	0001208b          	lp	ra,0(frame)
 134:	1800000b          	pop
 138:	00008067          	jalr	zero,0(ra)

0000013c <usb.c>:
 13c:	0031700b          	push	0,0
 140:	0011100b          	sp	ra,0(frame)
 144:	000500e7          	jalr	ra,0(a0)
 148:	0001208b          	lp	ra,0(frame)
 14c:	1800000b          	pop
 150:	00008067          	jalr	zero,0(ra)

00000154 <usb.end>:
 154:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

00000158 <hdmi.s_-0x8>:
 158:	0004                	.insn	2, 0x0004
 15a:	0000                	.insn	2, 0x
 15c:	000c                	.insn	2, 0x000c
	...

00000160 <hdmi.s_>:
 160:	0040006f          	jal	zero,164 <hdmi.s>

00000164 <hdmi.s>:
 164:	00230293          	addi	t0,t1,2
 168:	005e8e13          	addi	t3,t4,5
 16c:	00008067          	jalr	zero,0(ra)

Disassembly of section cosnt_obj:

00000000 <cosnt_obj_-0x8>:
   0:	0000                	.insn	2, 0x
   2:	0000                	.insn	2, 0x
   4:	00000013          	addi	zero,zero,0

00000008 <cosnt_obj_>:
   8:	7361                	.insn	2, 0x7361
   a:	6664                	.insn	2, 0x6664
   c:	6869                	.insn	2, 0x6869
   e:	68666f73          	csrrsi	t5,0x686,12
  12:	          	ecall

00000013 <cosnt_obj.end>:
  13:	0000                	.insn	2, 0x
  15:	0000                	.insn	2, 0x
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3b41                	.insn	2, 0x3b41
   2:	0000                	.insn	2, 0x
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <cosnt_obj.end+0x1>
   c:	0031                	.insn	2, 0x0031
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
  28:	697a                	.insn	2, 0x697a
  2a:	32727363          	bgeu	ctxt,t2,350 <_end+0x1e0>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
