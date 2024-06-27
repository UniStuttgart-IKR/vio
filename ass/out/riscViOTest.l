
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.init_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	0078                	.insn	2, 0x0078
	...

00000008 <core.init_>:
   8:	0080006f          	jal	zero,10 <core.init>

0000000c <core.start_>:
   c:	0140006f          	jal	zero,20 <core.start>

00000010 <core.init>:
  10:	00000197          	auipc	root,0x0
  14:	ff018193          	addi	root,root,-16 # 0 <core.init_-0x8>
  18:	ff818193          	addi	root,root,-8
  1c:	0041b00b          	jlib	root,4

00000020 <core.start>:
  20:	00001137          	lui	frame,0x1
  24:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x71d>
  28:	00000297          	auipc	t0,0x0
  2c:	05828293          	addi	t0,t0,88 # 80 <exc_handel>
  30:	34329073          	csrrw	zero,mtval,t0
  34:	1031720b          	push	4,8
  38:	00c000ef          	jal	ra,44 <core.entry>
  3c:	00230293          	addi	t0,t1,2
  40:	005e8e13          	addi	t3,t4,5

00000044 <core.entry>:
  44:	0021708b          	pushg	1,0
  48:	0011100b          	sp	ra,0(frame)
  4c:	00112023          	sw	ra,0(frame)
  50:	00000517          	auipc	a0,0x0
  54:	08050513          	addi	a0,a0,128 # d0 <usb.end>
  58:	00000417          	auipc	s0,0x0
  5c:	02c40413          	addi	s0,s0,44 # 84 <core.end>
  60:	00040493          	addi	s1,s0,0
  64:	0091100b          	sp	s1,0(frame)
  68:	0004300b          	jlib	s0,0
  6c:	0001240b          	lp	s0,0(frame)
  70:	0044300b          	jlib	s0,4
  74:	00100073          	ebreak
  78:	00000013          	addi	zero,zero,0
  7c:	00000013          	addi	zero,zero,0

00000080 <exc_handel>:
  80:	0000006f          	jal	zero,80 <exc_handel>

Disassembly of section usb:

00000084 <usb.af_-0x8>:
  84:	0008                	.insn	2, 0x0008
  86:	0000                	.insn	2, 0x
  88:	0040                	.insn	2, 0x0040
	...

0000008c <usb.af_>:
  8c:	0080006f          	jal	zero,94 <usb.af>

00000090 <usb.b_>:
  90:	0100006f          	jal	zero,a0 <usb.b>

00000094 <usb.af>:
  94:	00230293          	addi	t0,t1,2
  98:	005e8e13          	addi	t3,t4,5
  9c:	00008067          	jalr	zero,0(ra)

000000a0 <usb.b>:
  a0:	0031700b          	push	0,0
  a4:	00112023          	sw	ra,0(frame)
  a8:	00c000ef          	jal	ra,b4 <usb.c>
  ac:	00012083          	lw	ra,0(frame)
  b0:	00008067          	jalr	zero,0(ra)

000000b4 <usb.c>:
  b4:	0021700b          	pushg	0,0
  b8:	00112023          	sw	ra,0(frame)
  bc:	0011100b          	sp	ra,0(frame)
  c0:	0005300b          	jlib	a0,0
  c4:	0001208b          	lp	ra,0(frame)
  c8:	00012083          	lw	ra,0(frame)
  cc:	00008067          	jalr	zero,0(ra)

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
   8:	01007663          	bgeu	zero,a6,14 <core.init+0x4>
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
