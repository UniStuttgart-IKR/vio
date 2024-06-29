
out/riscViOTest.elf:     Dateiformat elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	00b4                	.insn	2, 0x00b4
	...

00000008 <core.start_>:
   8:	0080006f          	jal	zero,10 <core.start>

0000000c <core.init_>:
   c:	0240006f          	jal	zero,30 <core.init>

00000010 <core.start>:
  10:	00000197          	auipc	root,0x0
  14:	ff018193          	addi	root,root,-16 # 0 <core.start_-0x8>
  18:	ff818193          	addi	root,root,-8
  1c:	00001137          	lui	frame,0x1
  20:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x6d5>
  24:	0041b00b          	jlib	root,4
  28:	00000013          	addi	zero,zero,0
  2c:	00000013          	addi	zero,zero,0

00000030 <core.init>:
  30:	00001137          	lui	frame,0x1
  34:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x6d5>
  38:	00000297          	auipc	t0,0x0
  3c:	05c28293          	addi	t0,t0,92 # 94 <exc_handel>
  40:	30529073          	csrrw	zero,mtvec,t0
  44:	1003720b          	alci	t1,4,8
  48:	17932383          	lw	t2,377(t1)
  4c:	1031720b          	push	4,8
  50:	00c000ef          	jal	ra,5c <core.entry>
  54:	00230293          	addi	t0,t1,2
  58:	005e8e13          	addi	t3,t4,5

0000005c <core.entry>:
  5c:	0421708b          	pushg	1,2
  60:	0011100b          	sp	ra,0(frame)
  64:	00000517          	auipc	a0,0x0
  68:	0b450513          	addi	a0,a0,180 # 118 <usb.end+0x4>
  6c:	00000417          	auipc	s0,0x0
  70:	05c40413          	addi	s0,s0,92 # c8 <core.end+0x8>
  74:	00040493          	addi	s1,s0,0
  78:	0091100b          	sp	s1,0(frame)
  7c:	0004300b          	jlib	s0,0
  80:	0001240b          	lp	s0,0(frame)
  84:	0044300b          	jlib	s0,4
  88:	00100073          	ebreak
  8c:	00000013          	addi	zero,zero,0
  90:	00000013          	addi	zero,zero,0

00000094 <exc_handel>:
  94:	00000013          	addi	zero,zero,0
  98:	00000013          	addi	zero,zero,0
  9c:	00000013          	addi	zero,zero,0
  a0:	00000013          	addi	zero,zero,0
  a4:	00000013          	addi	zero,zero,0
  a8:	00000013          	addi	zero,zero,0
  ac:	00000013          	addi	zero,zero,0
  b0:	00000013          	addi	zero,zero,0
  b4:	30200073          	mret
  b8:	ffb28293          	addi	t0,t0,-5
  bc:	ff730313          	addi	t1,t1,-9

000000c0 <core.end>:
  c0:	0000                	.insn	2, 0x
	...

Disassembly of section usb:

000000c8 <usb.af_-0x8>:
  c8:	0008                	.insn	2, 0x0008
  ca:	0000                	.insn	2, 0x
  cc:	0040                	.insn	2, 0x0040
	...

000000d0 <usb.af_>:
  d0:	0080006f          	jal	zero,d8 <usb.af>

000000d4 <usb.b_>:
  d4:	0100006f          	jal	zero,e4 <usb.b>

000000d8 <usb.af>:
  d8:	00230293          	addi	t0,t1,2
  dc:	005e8e13          	addi	t3,t4,5
  e0:	00008067          	jalr	zero,0(ra)

000000e4 <usb.b>:
  e4:	0021700b          	pushg	0,0
  e8:	0011100b          	sp	ra,0(frame)
  ec:	010000ef          	jal	ra,fc <usb.c>
  f0:	0001208b          	lp	ra,0(frame)
  f4:	1800000b          	pop
  f8:	00008067          	jalr	zero,0(ra)

000000fc <usb.c>:
  fc:	0021700b          	pushg	0,0
 100:	0011100b          	sp	ra,0(frame)
 104:	0005300b          	jlib	a0,0
 108:	0001208b          	lp	ra,0(frame)
 10c:	1800000b          	pop
 110:	00008067          	jalr	zero,0(ra)

00000114 <usb.end>:
 114:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

00000118 <hdmi.s_-0x8>:
 118:	0004                	.insn	2, 0x0004
 11a:	0000                	.insn	2, 0x
 11c:	000c                	.insn	2, 0x000c
	...

00000120 <hdmi.s_>:
 120:	0040006f          	jal	zero,124 <hdmi.s>

00000124 <hdmi.s>:
 124:	00230293          	addi	t0,t1,2
 128:	005e8e13          	addi	t3,t4,5
 12c:	00008067          	jalr	zero,0(ra)

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
  2a:	32727363          	bgeu	ctxt,t2,350 <_end+0x220>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
