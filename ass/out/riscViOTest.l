
out/riscViOTest.elf:     Dateiformat elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	00d0                	.insn	2, 0x00d0
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
  2c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x6a3>
  30:	00000297          	auipc	t0,0x0
  34:	08028293          	addi	t0,t0,128 # b0 <exc_handel>
  38:	30529073          	csrrw	zero,mtvec,t0
  3c:	00100313          	addi	t1,zero,1
  40:	00600393          	addi	t2,zero,6
  44:	fe730cf3          	ciop	s9,t1,t2
  48:	00000c17          	auipc	s8,0x0
  4c:	104c0c13          	addi	s8,s8,260 # 14c <hdmi.end+0x4>
  50:	00000313          	addi	t1,zero,0
  54:	080c038b          	qdtb	t2,s8

00000058 <core.sloop>:
  58:	006c7383          	lb.r	t2,t1(s8)
  5c:	007c8023          	sb	t2,0(s9)
  60:	00130313          	addi	t1,t1,1
  64:	fe731ae3          	bne	t1,t2,58 <core.sloop>
  68:	1031720b          	push	4,8
  6c:	00c000ef          	jal	ra,78 <core.entry>
  70:	00230293          	addi	t0,t1,2
  74:	005e8e13          	addi	t3,t4,5

00000078 <core.entry>:
  78:	0421708b          	pushg	1,2
  7c:	0011100b          	sp	ra,0(frame)
  80:	00000517          	auipc	a0,0x0
  84:	0b050513          	addi	a0,a0,176 # 130 <usb.end+0x4>
  88:	00000417          	auipc	s0,0x0
  8c:	05840413          	addi	s0,s0,88 # e0 <core.end+0x4>
  90:	00040493          	addi	s1,s0,0
  94:	0091100b          	sp	s1,0(frame)
  98:	0004300b          	jlib	s0,0
  9c:	0001240b          	lp	s0,0(frame)
  a0:	0044300b          	jlib	s0,4
  a4:	00100073          	ebreak
  a8:	00000013          	addi	zero,zero,0
  ac:	00000013          	addi	zero,zero,0

000000b0 <exc_handel>:
  b0:	00000013          	addi	zero,zero,0
  b4:	00000013          	addi	zero,zero,0
  b8:	00000013          	addi	zero,zero,0
  bc:	00000013          	addi	zero,zero,0
  c0:	00000013          	addi	zero,zero,0
  c4:	00000013          	addi	zero,zero,0
  c8:	00000013          	addi	zero,zero,0
  cc:	00000013          	addi	zero,zero,0
  d0:	30200073          	mret
  d4:	ffb28293          	addi	t0,t0,-5
  d8:	ff730313          	addi	t1,t1,-9

000000dc <core.end>:
  dc:	00000013          	addi	zero,zero,0

Disassembly of section usb:

000000e0 <usb.af_-0x8>:
  e0:	0008                	.insn	2, 0x0008
  e2:	0000                	.insn	2, 0x
  e4:	0040                	.insn	2, 0x0040
	...

000000e8 <usb.af_>:
  e8:	0080006f          	jal	zero,f0 <usb.af>

000000ec <usb.b_>:
  ec:	0100006f          	jal	zero,fc <usb.b>

000000f0 <usb.af>:
  f0:	00230293          	addi	t0,t1,2
  f4:	005e8e13          	addi	t3,t4,5
  f8:	00008067          	jalr	zero,0(ra)

000000fc <usb.b>:
  fc:	0021700b          	pushg	0,0
 100:	0011100b          	sp	ra,0(frame)
 104:	010000ef          	jal	ra,114 <usb.c>
 108:	0001208b          	lp	ra,0(frame)
 10c:	1800000b          	pop
 110:	00008067          	jalr	zero,0(ra)

00000114 <usb.c>:
 114:	0021700b          	pushg	0,0
 118:	0011100b          	sp	ra,0(frame)
 11c:	0005300b          	jlib	a0,0
 120:	0001208b          	lp	ra,0(frame)
 124:	1800000b          	pop
 128:	00008067          	jalr	zero,0(ra)

0000012c <usb.end>:
 12c:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

00000130 <hdmi.s_-0x8>:
 130:	0004                	.insn	2, 0x0004
 132:	0000                	.insn	2, 0x
 134:	000c                	.insn	2, 0x000c
	...

00000138 <hdmi.s_>:
 138:	0040006f          	jal	zero,13c <hdmi.s>

0000013c <hdmi.s>:
 13c:	00230293          	addi	t0,t1,2
 140:	005e8e13          	addi	t3,t4,5
 144:	00008067          	jalr	zero,0(ra)

00000148 <hdmi.end>:
 148:	0000                	.insn	2, 0x
	...

Disassembly of section hellostr:

0000014c <hellostr.dummy_-0x8>:
 14c:	0004                	.insn	2, 0x0004
 14e:	0000                	.insn	2, 0x
 150:	000a                	.insn	2, 0x000a
	...

00000154 <hellostr.dummy_>:
 154:	0040006f          	jal	zero,158 <hellostr.dummy>

00000158 <hellostr.dummy>:
 158:	5449                	.insn	2, 0x5449
 15a:	4c412053          	.insn	4, 0x4c412053
 15e:	5649                	.insn	2, 0x5649
 160:	2145                	.insn	2, 0x2145

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
  2a:	32727363          	bgeu	ctxt,t2,350 <_end+0x1ee>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
