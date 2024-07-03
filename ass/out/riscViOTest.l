
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	00fc                	.insn	2, 0x00fc
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
  2c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x68d>
  30:	00000297          	auipc	t0,0x0
  34:	0ac28293          	addi	t0,t0,172 # dc <exc_handel>
  38:	30529073          	csrrw	zero,mtvec,t0
  3c:	00100313          	addi	t1,zero,1
  40:	00600393          	addi	t2,zero,6
  44:	fe730cf3          	ciop	s9,t1,t2

00000048 <core.loop>:
  48:	00002283          	lw	t0,0(zero) # 0 <core.start_-0x8>
  4c:	04900313          	addi	t1,zero,73
  50:	006c8023          	sb	t1,0(s9)
  54:	05400313          	addi	t1,zero,84
  58:	006c8023          	sb	t1,0(s9)
  5c:	05300313          	addi	t1,zero,83
  60:	006c8023          	sb	t1,0(s9)
  64:	02000313          	addi	t1,zero,32
  68:	006c8023          	sb	t1,0(s9)
  6c:	04100313          	addi	t1,zero,65
  70:	006c8023          	sb	t1,0(s9)
  74:	04c00313          	addi	t1,zero,76
  78:	006c8023          	sb	t1,0(s9)
  7c:	04900313          	addi	t1,zero,73
  80:	006c8023          	sb	t1,0(s9)
  84:	05600313          	addi	t1,zero,86
  88:	006c8023          	sb	t1,0(s9)
  8c:	04500313          	addi	t1,zero,69
  90:	006c8023          	sb	t1,0(s9)
  94:	02100313          	addi	t1,zero,33
  98:	006c8023          	sb	t1,0(s9)
  9c:	00a00313          	addi	t1,zero,10
  a0:	006c8023          	sb	t1,0(s9)
  a4:	0031708b          	push	1,0
  a8:	0011100b          	sp	ra,0(frame)
  ac:	00000517          	auipc	a0,0x0
  b0:	0b450513          	addi	a0,a0,180 # 160 <usb.end+0x4>
  b4:	fd050573          	ccp	a0,a0
  b8:	00000417          	auipc	s0,0x0
  bc:	05840413          	addi	s0,s0,88 # 110 <core.end+0x8>
  c0:	fd040473          	ccp	s0,s0
  c4:	00040493          	addi	s1,s0,0
  c8:	0091100b          	sp	s1,0(frame)
  cc:	000400e7          	jalr	ra,0(s0)
  d0:	0001240b          	lp	s0,0(frame)
  d4:	004400e7          	jalr	ra,4(s0)
  d8:	f71ff06f          	jal	zero,48 <core.loop>

000000dc <exc_handel>:
  dc:	00000013          	addi	zero,zero,0
  e0:	00000013          	addi	zero,zero,0
  e4:	00000013          	addi	zero,zero,0
  e8:	00000013          	addi	zero,zero,0
  ec:	00000013          	addi	zero,zero,0
  f0:	00000013          	addi	zero,zero,0
  f4:	00000013          	addi	zero,zero,0
  f8:	00000013          	addi	zero,zero,0
  fc:	30200073          	mret
 100:	ffb28293          	addi	t0,t0,-5
 104:	ff730313          	addi	t1,t1,-9

00000108 <core.end>:
 108:	0000                	.insn	2, 0x
	...

Disassembly of section usb:

00000110 <usb.af_-0x8>:
 110:	0008                	.insn	2, 0x0008
 112:	0000                	.insn	2, 0x
 114:	0040                	.insn	2, 0x0040
	...

00000118 <usb.af_>:
 118:	0080006f          	jal	zero,120 <usb.af>

0000011c <usb.b_>:
 11c:	0100006f          	jal	zero,12c <usb.b>

00000120 <usb.af>:
 120:	00230293          	addi	t0,t1,2
 124:	005e8e13          	addi	t3,t4,5
 128:	00008067          	jalr	zero,0(ra)

0000012c <usb.b>:
 12c:	0031700b          	push	0,0
 130:	0011100b          	sp	ra,0(frame)
 134:	010000ef          	jal	ra,144 <usb.c>
 138:	0001208b          	lp	ra,0(frame)
 13c:	1800000b          	pop
 140:	00008067          	jalr	zero,0(ra)

00000144 <usb.c>:
 144:	0031700b          	push	0,0
 148:	0011100b          	sp	ra,0(frame)
 14c:	000500e7          	jalr	ra,0(a0)
 150:	0001208b          	lp	ra,0(frame)
 154:	1800000b          	pop
 158:	00008067          	jalr	zero,0(ra)

0000015c <usb.end>:
 15c:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

00000160 <hdmi.s_-0x8>:
 160:	0004                	.insn	2, 0x0004
 162:	0000                	.insn	2, 0x
 164:	000c                	.insn	2, 0x000c
	...

00000168 <hdmi.s_>:
 168:	0040006f          	jal	zero,16c <hdmi.s>

0000016c <hdmi.s>:
 16c:	00230293          	addi	t0,t1,2
 170:	005e8e13          	addi	t3,t4,5
 174:	00008067          	jalr	zero,0(ra)

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3b41                	.insn	2, 0x3b41
   2:	0000                	.insn	2, 0x
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <core.start+0x4>
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
  2a:	32727363          	bgeu	ctxt,t2,350 <_end+0x1d8>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
