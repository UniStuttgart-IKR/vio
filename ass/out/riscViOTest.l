
out/riscViOTest.elf:     Dateiformat elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0004                	.insn	2, 0x0004
   2:	0000                	.insn	2, 0x
   4:	00000067          	jalr	zero,0(zero) # 0 <core.start_-0x8>

00000008 <core.start_>:
   8:	0040006f          	jal	zero,c <core.start>

0000000c <core.start>:
   c:	00001137          	lui	frame,0x1
  10:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x731>
  14:	00000297          	auipc	t0,0x0
  18:	05828293          	addi	t0,t0,88 # 6c <exc_handel>
  1c:	34329073          	csrrw	zero,mtval,t0
  20:	1031720b          	push	4,8
  24:	00c000ef          	jal	ra,30 <core.entry>
  28:	00230293          	addi	t0,t1,2
  2c:	005e8e13          	addi	t3,t4,5

00000030 <core.entry>:
  30:	0021708b          	pushg	1,0
  34:	0011100b          	sp	ra,0(frame)
  38:	00112023          	sw	ra,0(frame)
  3c:	00000517          	auipc	a0,0x0
  40:	08050513          	addi	a0,a0,128 # bc <usb.end>
  44:	00000417          	auipc	s0,0x0
  48:	02c40413          	addi	s0,s0,44 # 70 <core.end>
  4c:	00040493          	addi	s1,s0,0
  50:	0091100b          	sp	s1,0(frame)
  54:	0004300b          	jlib	s0,0
  58:	0001240b          	lp	s0,0(frame)
  5c:	0044300b          	jlib	s0,4
  60:	00100073          	ebreak
  64:	00000013          	addi	zero,zero,0
  68:	00000013          	addi	zero,zero,0

0000006c <exc_handel>:
  6c:	0000006f          	jal	zero,6c <exc_handel>

Disassembly of section usb:

00000070 <usb.af_-0x8>:
  70:	0008                	.insn	2, 0x0008
  72:	0000                	.insn	2, 0x
  74:	0000003f  	.insn	8, 0x0080006f0000003f

00000078 <usb.af_>:
  78:	0080006f          	jal	zero,80 <usb.af>

0000007c <usb.b_>:
  7c:	0100006f          	jal	zero,8c <usb.b>

00000080 <usb.af>:
  80:	00230293          	addi	t0,t1,2
  84:	005e8e13          	addi	t3,t4,5
  88:	00008067          	jalr	zero,0(ra)

0000008c <usb.b>:
  8c:	0031700b          	push	0,0
  90:	00112023          	sw	ra,0(frame)
  94:	00c000ef          	jal	ra,a0 <usb.c>
  98:	00012083          	lw	ra,0(frame)
  9c:	00008067          	jalr	zero,0(ra)

000000a0 <usb.c>:
  a0:	0021700b          	pushg	0,0
  a4:	00112023          	sw	ra,0(frame)
  a8:	0011100b          	sp	ra,0(frame)
  ac:	0005300b          	jlib	a0,0
  b0:	0001208b          	lp	ra,0(frame)
  b4:	00012083          	lw	ra,0(frame)
  b8:	00008067          	jalr	zero,0(ra)

Disassembly of section hdmi:

000000bc <hdmi.s_-0x8>:
  bc:	0004                	.insn	2, 0x0004
  be:	0000                	.insn	2, 0x
  c0:	0000000f          	fence	unknown,unknown

000000c4 <hdmi.s_>:
  c4:	0040006f          	jal	zero,c8 <hdmi.s>

000000c8 <hdmi.s>:
  c8:	00230293          	addi	t0,t1,2
  cc:	005e8e13          	addi	t3,t4,5
  d0:	00008067          	jalr	zero,0(ra)

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
  2a:	32727363          	bgeu	ctxt,t2,350 <_end+0x27c>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
