
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0004                	.insn	2, 0x0004
   2:	0000                	.insn	2, 0x
   4:	006c                	.insn	2, 0x006c
	...

00000008 <core.start_>:
   8:	0040006f          	jal	zero,c <core.start>

0000000c <core.start>:
   c:	00000197          	auipc	root,0x0
  10:	ff418193          	addi	root,root,-12 # 0 <core.start_-0x8>
  14:	ff818193          	addi	root,root,-8
  18:	00001137          	lui	frame,0x1
  1c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x71d>
  20:	00000297          	auipc	t0,0x0
  24:	05428293          	addi	t0,t0,84 # 74 <exc_handel>
  28:	34329073          	csrrw	zero,mtval,t0
  2c:	1031720b          	push	4,8
  30:	00c000ef          	jal	ra,3c <core.entry>
  34:	00230293          	addi	t0,t1,2
  38:	005e8e13          	addi	t3,t4,5

0000003c <core.entry>:
  3c:	0421708b          	pushg	1,2
  40:	0011100b          	sp	ra,0(frame)
  44:	00000517          	auipc	a0,0x0
  48:	08c50513          	addi	a0,a0,140 # d0 <usb.end+0x4>
  4c:	00000417          	auipc	s0,0x0
  50:	03440413          	addi	s0,s0,52 # 80 <core.end+0x8>
  54:	00040493          	addi	s1,s0,0
  58:	0091100b          	sp	s1,0(frame)
  5c:	0004300b          	jlib	s0,0
  60:	0001240b          	lp	s0,0(frame)
  64:	0044300b          	jlib	s0,4
  68:	00100073          	ebreak
  6c:	00000013          	addi	zero,zero,0
  70:	00000013          	addi	zero,zero,0

00000074 <exc_handel>:
  74:	0000006f          	jal	zero,74 <exc_handel>

00000078 <core.end>:
  78:	0000                	.insn	2, 0x
	...

Disassembly of section usb:

00000080 <usb.af_-0x8>:
  80:	0008                	.insn	2, 0x0008
  82:	0000                	.insn	2, 0x
  84:	0040                	.insn	2, 0x0040
	...

00000088 <usb.af_>:
  88:	0080006f          	jal	zero,90 <usb.af>

0000008c <usb.b_>:
  8c:	0100006f          	jal	zero,9c <usb.b>

00000090 <usb.af>:
  90:	00230293          	addi	t0,t1,2
  94:	005e8e13          	addi	t3,t4,5
  98:	00008067          	jalr	zero,0(ra)

0000009c <usb.b>:
  9c:	0021700b          	pushg	0,0
  a0:	0011100b          	sp	ra,0(frame)
  a4:	010000ef          	jal	ra,b4 <usb.c>
  a8:	0001208b          	lp	ra,0(frame)
  ac:	1800000b          	pop
  b0:	00008067          	jalr	zero,0(ra)

000000b4 <usb.c>:
  b4:	0021700b          	pushg	0,0
  b8:	0011100b          	sp	ra,0(frame)
  bc:	0005300b          	jlib	a0,0
  c0:	0001208b          	lp	ra,0(frame)
  c4:	1800000b          	pop
  c8:	00008067          	jalr	zero,0(ra)

000000cc <usb.end>:
  cc:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

000000d0 <hdmi.s_-0x8>:
  d0:	0004                	.insn	2, 0x0004
  d2:	0000                	.insn	2, 0x
  d4:	000c                	.insn	2, 0x000c
	...

000000d8 <hdmi.s_>:
  d8:	0040006f          	jal	zero,dc <hdmi.s>

000000dc <hdmi.s>:
  dc:	00230293          	addi	t0,t1,2
  e0:	005e8e13          	addi	t3,t4,5
  e4:	00008067          	jalr	zero,0(ra)

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3b41                	.insn	2, 0x3b41
   2:	0000                	.insn	2, 0x
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <core.start+0x8>
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
  2a:	32727363          	bgeu	ctxt,t2,350 <_end+0x268>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
