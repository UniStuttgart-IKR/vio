
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	00bc                	.insn	2, 0x00bc
	...

00000008 <core.start_>:
   8:	0080006f          	jal	zero,10 <core.start>

0000000c <core.init_>:
   c:	01c0006f          	jal	zero,28 <core.init>

00000010 <core.start>:
  10:	00000197          	auipc	root,0x0
  14:	ff018193          	addi	root,root,-16 # 0 <core.start_-0x8>
  18:	ff818193          	addi	root,root,-8
  1c:	0041b00b          	jlib	root,4
  20:	00000013          	addi	zero,zero,0
  24:	00000013          	addi	zero,zero,0

00000028 <core.init>:
  28:	00001137          	lui	frame,0x1
  2c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x6cd>
  30:	00000297          	auipc	t0,0x0
  34:	06c28293          	addi	t0,t0,108 # 9c <exc_handel>
  38:	30529073          	csrrw	zero,mtvec,t0
  3c:	00100313          	addi	t1,zero,1
  40:	00600393          	addi	t2,zero,6
  44:	fe730cf3          	ciop	s9,t1,t2
  48:	00002283          	lw	t0,0(zero) # 0 <core.start_-0x8>
  4c:	04900313          	addi	t1,zero,73
  50:	006c8023          	sb	t1,0(s9)
  54:	1031720b          	push	4,8
  58:	00c000ef          	jal	ra,64 <core.entry>
  5c:	00230293          	addi	t0,t1,2
  60:	005e8e13          	addi	t3,t4,5

00000064 <core.entry>:
  64:	0421708b          	pushg	1,2
  68:	0011100b          	sp	ra,0(frame)
  6c:	00000517          	auipc	a0,0x0
  70:	0b450513          	addi	a0,a0,180 # 120 <usb.end+0x4>
  74:	00000417          	auipc	s0,0x0
  78:	05c40413          	addi	s0,s0,92 # d0 <core.end+0x8>
  7c:	00040493          	addi	s1,s0,0
  80:	0091100b          	sp	s1,0(frame)
  84:	0004300b          	jlib	s0,0
  88:	0001240b          	lp	s0,0(frame)
  8c:	0044300b          	jlib	s0,4
  90:	00100073          	ebreak
  94:	00000013          	addi	zero,zero,0
  98:	00000013          	addi	zero,zero,0

0000009c <exc_handel>:
  9c:	00000013          	addi	zero,zero,0
  a0:	00000013          	addi	zero,zero,0
  a4:	00000013          	addi	zero,zero,0
  a8:	00000013          	addi	zero,zero,0
  ac:	00000013          	addi	zero,zero,0
  b0:	00000013          	addi	zero,zero,0
  b4:	00000013          	addi	zero,zero,0
  b8:	00000013          	addi	zero,zero,0
  bc:	30200073          	mret
  c0:	ffb28293          	addi	t0,t0,-5
  c4:	ff730313          	addi	t1,t1,-9

000000c8 <core.end>:
  c8:	0000                	.insn	2, 0x
	...

Disassembly of section usb:

000000d0 <usb.af_-0x8>:
  d0:	0008                	.insn	2, 0x0008
  d2:	0000                	.insn	2, 0x
  d4:	0040                	.insn	2, 0x0040
	...

000000d8 <usb.af_>:
  d8:	0080006f          	jal	zero,e0 <usb.af>

000000dc <usb.b_>:
  dc:	0100006f          	jal	zero,ec <usb.b>

000000e0 <usb.af>:
  e0:	00230293          	addi	t0,t1,2
  e4:	005e8e13          	addi	t3,t4,5
  e8:	00008067          	jalr	zero,0(ra)

000000ec <usb.b>:
  ec:	0021700b          	pushg	0,0
  f0:	0011100b          	sp	ra,0(frame)
  f4:	010000ef          	jal	ra,104 <usb.c>
  f8:	0001208b          	lp	ra,0(frame)
  fc:	1800000b          	pop
 100:	00008067          	jalr	zero,0(ra)

00000104 <usb.c>:
 104:	0021700b          	pushg	0,0
 108:	0011100b          	sp	ra,0(frame)
 10c:	0005300b          	jlib	a0,0
 110:	0001208b          	lp	ra,0(frame)
 114:	1800000b          	pop
 118:	00008067          	jalr	zero,0(ra)

0000011c <usb.end>:
 11c:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

00000120 <hdmi.s_-0x8>:
 120:	0004                	.insn	2, 0x0004
 122:	0000                	.insn	2, 0x
 124:	000c                	.insn	2, 0x000c
	...

00000128 <hdmi.s_>:
 128:	0040006f          	jal	zero,12c <hdmi.s>

0000012c <hdmi.s>:
 12c:	00230293          	addi	t0,t1,2
 130:	005e8e13          	addi	t3,t4,5
 134:	00008067          	jalr	zero,0(ra)

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
  2a:	32727363          	bgeu	ctxt,t2,350 <_end+0x218>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
