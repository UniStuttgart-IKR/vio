
out/riscViOTest.elf:     Dateiformat elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	0124                	.insn	2, 0x0124
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
  2c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x64d>
  30:	00000297          	auipc	t0,0x0
  34:	0d428293          	addi	t0,t0,212 # 104 <core.exc_handel>
  38:	30529073          	csrrw	zero,mtvec,t0
  3c:	01020337          	lui	t1,0x1020
  40:	30430313          	addi	t1,t1,772 # 1020304 <_end+0x102014c>
  44:	000083b7          	lui	t2,0x8
  48:	00538393          	addi	t2,t2,5 # 8005 <_end+0x7e4d>
  4c:	08600e13          	addi	t3,zero,134
  50:	0e31708b          	push	1,7
  54:	0011100b          	sp	ra,0(frame)
  58:	0031100b          	sp	root,0(frame)
  5c:	00612023          	sw	t1,0(frame)
  60:	00711223          	sh	t2,4(frame)
  64:	01c10323          	sb	t3,6(frame)
  68:	00614783          	lbu	a5,6(frame)
  6c:	00610703          	lb	a4,6(frame)
  70:	00415683          	lhu	a3,4(frame)
  74:	00411603          	lh	a2,4(frame)
  78:	00012583          	lw	a1,0(frame)
  7c:	0001250b          	lp	a0,0(frame)
  80:	0001208b          	lp	ra,0(frame)
  84:	00100313          	addi	t1,zero,1
  88:	00600393          	addi	t2,zero,6
  8c:	fe730cf3          	ciop	s9,t1,t2
  90:	000c8593          	addi	a1,s9,0
  94:	19800513          	addi	a0,zero,408
  98:	ff850513          	addi	a0,a0,-8
  9c:	fd050573          	ccp	a0,a0
  a0:	048000ef          	jal	ra,e8 <core.out_str>
  a4:	00000013          	addi	zero,zero,0
  a8:	00000013          	addi	zero,zero,0
  ac:	00100073          	ebreak
  b0:	0031708b          	push	1,0
  b4:	0011100b          	sp	ra,0(frame)
  b8:	00000517          	auipc	a0,0x0
  bc:	0c850513          	addi	a0,a0,200 # 180 <usb.end+0x4>
  c0:	fd050573          	ccp	a0,a0
  c4:	00000417          	auipc	s0,0x0
  c8:	06c40413          	addi	s0,s0,108 # 130 <core.end>
  cc:	fd040473          	ccp	s0,s0
  d0:	00040493          	addi	s1,s0,0
  d4:	0091100b          	sp	s1,0(frame)
  d8:	000400e7          	jalr	ra,0(s0)
  dc:	0001240b          	lp	s0,0(frame)
  e0:	004400e7          	jalr	ra,4(s0)
  e4:	00100073          	ebreak

000000e8 <core.out_str>:
  e8:	0805028b          	qdtb	t0,a0
  ec:	00000313          	addi	t1,zero,0

000000f0 <.outloop>:
  f0:	80657383          	lbu.r	t2,t1(a0)
  f4:	00758123          	sb	t2,2(a1)
  f8:	00130313          	addi	t1,t1,1
  fc:	fe531ae3          	bne	t1,t0,f0 <.outloop>
 100:	00008067          	jalr	zero,0(ra)

00000104 <core.exc_handel>:
 104:	00000013          	addi	zero,zero,0
 108:	00000013          	addi	zero,zero,0
 10c:	00000013          	addi	zero,zero,0
 110:	00000013          	addi	zero,zero,0
 114:	00000013          	addi	zero,zero,0
 118:	00000013          	addi	zero,zero,0
 11c:	00000013          	addi	zero,zero,0
 120:	00000013          	addi	zero,zero,0
 124:	30200073          	mret
 128:	ffb28293          	addi	t0,t0,-5
 12c:	ff730313          	addi	t1,t1,-9

Disassembly of section usb:

00000130 <usb.af_-0x8>:
 130:	0008                	.insn	2, 0x0008
 132:	0000                	.insn	2, 0x
 134:	0040                	.insn	2, 0x0040
	...

00000138 <usb.af_>:
 138:	0080006f          	jal	zero,140 <usb.af>

0000013c <usb.b_>:
 13c:	0100006f          	jal	zero,14c <usb.b>

00000140 <usb.af>:
 140:	00230293          	addi	t0,t1,2
 144:	005e8e13          	addi	t3,t4,5
 148:	00008067          	jalr	zero,0(ra)

0000014c <usb.b>:
 14c:	0031700b          	push	0,0
 150:	0011100b          	sp	ra,0(frame)
 154:	010000ef          	jal	ra,164 <usb.c>
 158:	0001208b          	lp	ra,0(frame)
 15c:	1800000b          	pop
 160:	00008067          	jalr	zero,0(ra)

00000164 <usb.c>:
 164:	0031700b          	push	0,0
 168:	0011100b          	sp	ra,0(frame)
 16c:	000500e7          	jalr	ra,0(a0)
 170:	0001208b          	lp	ra,0(frame)
 174:	1800000b          	pop
 178:	00008067          	jalr	zero,0(ra)

0000017c <usb.end>:
 17c:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

00000180 <hdmi.s_-0x8>:
 180:	0004                	.insn	2, 0x0004
 182:	0000                	.insn	2, 0x
 184:	000c                	.insn	2, 0x000c
	...

00000188 <hdmi.s_>:
 188:	0040006f          	jal	zero,18c <hdmi.s>

0000018c <hdmi.s>:
 18c:	00230293          	addi	t0,t1,2
 190:	005e8e13          	addi	t3,t4,5
 194:	00008067          	jalr	zero,0(ra)

Disassembly of section hello_world_str:

00000198 <hello_world_str_-0x8>:
 198:	0000                	.insn	2, 0x
 19a:	0000                	.insn	2, 0x
 19c:	0014                	.insn	2, 0x0014
	...

000001a0 <hello_world_str_>:
 1a0:	6548                	.insn	2, 0x6548
 1a2:	6c6c                	.insn	2, 0x6c6c
 1a4:	7266206f          	jal	zero,628ca <_end+0x62712>
 1a8:	52206d6f          	jal	bm,66ca <_end+0x6512>
 1ac:	7369                	.insn	2, 0x7369
 1ae:	4f695663          	bge	s2,s6,69a <_end+0x4e2>
 1b2:	0a21                	.insn	2, 0x0a21

000001b4 <hello_world_str.end>:
 1b4:	0000                	.insn	2, 0x
	...

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
  2a:	32727363          	bgeu	ctxt,t2,350 <_end+0x198>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
