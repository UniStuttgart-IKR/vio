
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0004                	.insn	2, 0x0004
   2:	0000                	.insn	2, 0x
   4:	00000063          	beq	zero,zero,4 <core.start_-0x4>

00000008 <core.start_>:
   8:	0040006f          	jal	zero,c <core.start>

0000000c <core.start>:
   c:	30500113          	addi	frame,zero,773
  10:	00000297          	auipc	t0,0x0
  14:	05828293          	addi	t0,t0,88 # 68 <exc_handel>
  18:	34329073          	csrrw	zero,mtval,t0
  1c:	1031720b          	push	4,8
  20:	00c000ef          	jal	ra,2c <core.entry>
  24:	00230293          	addi	t0,t1,2
  28:	005e8e13          	addi	t3,t4,5

0000002c <core.entry>:
  2c:	0021708b          	pushg	1,0
  30:	0011100b          	sp	ra,0(frame)
  34:	00112023          	sw	ra,0(frame)
  38:	00000517          	auipc	a0,0x0
  3c:	08050513          	addi	a0,a0,128 # b8 <usb.end>
  40:	00000417          	auipc	s0,0x0
  44:	02c40413          	addi	s0,s0,44 # 6c <core.end>
  48:	00040493          	addi	s1,s0,0
  4c:	0091100b          	sp	s1,0(frame)
  50:	0004300b          	jlib	s0,0
  54:	0001240b          	lp	s0,0(frame)
  58:	0044300b          	jlib	s0,4
  5c:	00100073          	ebreak
  60:	00000013          	addi	zero,zero,0
  64:	00000013          	addi	zero,zero,0

00000068 <exc_handel>:
  68:	0000006f          	jal	zero,68 <exc_handel>

Disassembly of section usb:

0000006c <usb.af_-0x8>:
  6c:	0008                	.insn	2, 0x0008
  6e:	0000                	.insn	2, 0x
  70:	0000003f  	.insn	8, 0x0080006f0000003f

00000074 <usb.af_>:
  74:	0080006f          	jal	zero,7c <usb.af>

00000078 <usb.b_>:
  78:	0100006f          	jal	zero,88 <usb.b>

0000007c <usb.af>:
  7c:	00230293          	addi	t0,t1,2
  80:	005e8e13          	addi	t3,t4,5
  84:	00008067          	jalr	zero,0(ra)

00000088 <usb.b>:
  88:	0031700b          	push	0,0
  8c:	00112023          	sw	ra,0(frame)
  90:	00c000ef          	jal	ra,9c <usb.c>
  94:	00012083          	lw	ra,0(frame)
  98:	00008067          	jalr	zero,0(ra)

0000009c <usb.c>:
  9c:	0021700b          	pushg	0,0
  a0:	00112023          	sw	ra,0(frame)
  a4:	0011100b          	sp	ra,0(frame)
  a8:	0005300b          	jlib	a0,0
  ac:	0001208b          	lp	ra,0(frame)
  b0:	00012083          	lw	ra,0(frame)
  b4:	00008067          	jalr	zero,0(ra)

Disassembly of section hdmi:

000000b8 <hdmi.s_-0x8>:
  b8:	0004                	.insn	2, 0x0004
  ba:	0000                	.insn	2, 0x
  bc:	0000000f          	fence	unknown,unknown

000000c0 <hdmi.s_>:
  c0:	0040006f          	jal	zero,c4 <hdmi.s>

000000c4 <hdmi.s>:
  c4:	00230293          	addi	t0,t1,2
  c8:	005e8e13          	addi	t3,t4,5
  cc:	00008067          	jalr	zero,0(ra)

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
  2a:	32727363          	bgeu	ctxt,t2,350 <_end+0x280>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
