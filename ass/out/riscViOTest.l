
out/riscViOTest.elf:     Dateiformat elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0004                	.insn	2, 0x0004
   2:	0000                	.insn	2, 0x
   4:	0000004b          	.insn	4, 0x004b

00000008 <core.start_>:
   8:	0040006f          	jal	zero,c <core.start>

0000000c <core.start>:
   c:	30500113          	addi	frame,zero,773
  10:	1031720b          	push	4,8
  14:	00c000ef          	jal	ra,20 <core.entry>
  18:	00000013          	addi	zero,zero,0
  1c:	00000013          	addi	zero,zero,0

00000020 <core.entry>:
  20:	0021708b          	pushg	1,0
  24:	0011100b          	sp	ra,0(frame)
  28:	00112023          	sw	ra,0(frame)
  2c:	00000517          	auipc	a0,0x0
  30:	07450513          	addi	a0,a0,116 # a0 <usb.end>
  34:	00000417          	auipc	s0,0x0
  38:	02040413          	addi	s0,s0,32 # 54 <core.end>
  3c:	00040493          	addi	s1,s0,0
  40:	0091100b          	sp	s1,0(frame)
  44:	0084300b          	jlib	s0,8
  48:	0001240b          	lp	s0,0(frame)
  4c:	00c4300b          	jlib	s0,12
  50:	00100073          	ebreak

Disassembly of section usb:

00000054 <usb.af_-0x8>:
  54:	0008                	.insn	2, 0x0008
  56:	0000                	.insn	2, 0x
  58:	0000003f  	.insn	8, 0x0080006f0000003f

0000005c <usb.af_>:
  5c:	0080006f          	jal	zero,64 <usb.af>

00000060 <usb.b_>:
  60:	0100006f          	jal	zero,70 <usb.b>

00000064 <usb.af>:
  64:	00000013          	addi	zero,zero,0
  68:	00000013          	addi	zero,zero,0
  6c:	00008067          	jalr	zero,0(ra)

00000070 <usb.b>:
  70:	0031700b          	push	0,0
  74:	00112023          	sw	ra,0(frame)
  78:	00c000ef          	jal	ra,84 <usb.c>
  7c:	00012083          	lw	ra,0(frame)
  80:	00008067          	jalr	zero,0(ra)

00000084 <usb.c>:
  84:	0021700b          	pushg	0,0
  88:	00112023          	sw	ra,0(frame)
  8c:	0011100b          	sp	ra,0(frame)
  90:	0085300b          	jlib	a0,8
  94:	0001208b          	lp	ra,0(frame)
  98:	00012083          	lw	ra,0(frame)
  9c:	00008067          	jalr	zero,0(ra)

Disassembly of section hdmi:

000000a0 <hdmi.s_-0x8>:
  a0:	0004                	.insn	2, 0x0004
  a2:	0000                	.insn	2, 0x
  a4:	0000000f          	fence	unknown,unknown

000000a8 <hdmi.s_>:
  a8:	0040006f          	jal	zero,ac <hdmi.s>

000000ac <hdmi.s>:
  ac:	00000013          	addi	zero,zero,0
  b0:	00000013          	addi	zero,zero,0
  b4:	00008067          	jalr	zero,0(ra)

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
