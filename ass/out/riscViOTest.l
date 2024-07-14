
out/riscViOTest.elf:     Dateiformat elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	01d0                	.insn	2, 0x01d0
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
  2c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x32d>
  30:	00000297          	auipc	t0,0x0
  34:	15c28293          	addi	t0,t0,348 # 18c <core.exc_handel>
  38:	30529073          	csrrw	zero,mtvec,t0
  3c:	01020337          	lui	t1,0x1020
  40:	30430313          	addi	t1,t1,772 # 1020304 <_end+0x101fe2c>
  44:	000083b7          	lui	t2,0x8
  48:	00538393          	addi	t2,t2,5 # 8005 <_end+0x7b2d>
  4c:	08600e13          	addi	t3,zero,134
  50:	0e31740b          	push	8,7
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
  84:	15a1250b          	lp	a0,346(frame)
  88:	00200313          	addi	t1,zero,2
  8c:	00a00393          	addi	t2,zero,10
  90:	fe730973          	ciop	s2,t1,t2
  94:	00100993          	addi	s3,zero,1
  98:	10000a13          	addi	s4,zero,256
  9c:	00100313          	addi	t1,zero,1
  a0:	00600393          	addi	t2,zero,6
  a4:	fe7304f3          	ciop	s1,t1,t2
  a8:	4b800513          	addi	a0,zero,1208
  ac:	fd050473          	ccp	s0,a0

000000b0 <core.loop>:
  b0:	01390023          	sb	s3,0(s2)
  b4:	6019d993          	rori	s3,s3,0x1
  b8:	00040513          	addi	a0,s0,0
  bc:	00048593          	addi	a1,s1,0
  c0:	05c000ef          	jal	ra,11c <core.out_str>
  c4:	00000013          	addi	zero,zero,0
  c8:	00000013          	addi	zero,zero,0
  cc:	00000013          	addi	zero,zero,0
  d0:	00000013          	addi	zero,zero,0
  d4:	00000013          	addi	zero,zero,0
  d8:	00000013          	addi	zero,zero,0
  dc:	00100073          	ebreak
  e0:	fd1ff06f          	jal	zero,b0 <core.loop>
  e4:	0031708b          	push	1,0
  e8:	0011100b          	sp	ra,0(frame)
  ec:	00000517          	auipc	a0,0x0
  f0:	14c50513          	addi	a0,a0,332 # 238 <usb.end+0x4>
  f4:	fd050573          	ccp	a0,a0
  f8:	00000417          	auipc	s0,0x0
  fc:	0f040413          	addi	s0,s0,240 # 1e8 <core.end+0xc>
 100:	fd040473          	ccp	s0,s0
 104:	00040493          	addi	s1,s0,0
 108:	0091100b          	sp	s1,0(frame)
 10c:	000400e7          	jalr	ra,0(s0)
 110:	0001240b          	lp	s0,0(frame)
 114:	004400e7          	jalr	ra,4(s0)
 118:	00100073          	ebreak

0000011c <core.out_str>:
 11c:	02050263          	beq	a0,zero,140 <.done>
 120:	0805028b          	qdtb	t0,a0
 124:	00028e63          	beq	t0,zero,140 <.done>
 128:	00000313          	addi	t1,zero,0

0000012c <.outloop>:
 12c:	80657383          	lbu.r	t2,t1(a0)
 130:	00758023          	sb	t2,0(a1)
 134:	00058e03          	lb	t3,0(a1)
 138:	00130313          	addi	t1,t1,1
 13c:	fe5318e3          	bne	t1,t0,12c <.outloop>

00000140 <.done>:
 140:	00008067          	jalr	zero,0(ra)

00000144 <core.out_str_zero>:
 144:	04050263          	beq	a0,zero,188 <.donez>
 148:	0805028b          	qdtb	t0,a0
 14c:	02028e63          	beq	t0,zero,188 <.donez>
 150:	00000313          	addi	t1,zero,0
 154:	00160613          	addi	a2,a2,1

00000158 <.srcloop>:
 158:	80657383          	lbu.r	t2,t1(a0)
 15c:	00039a63          	bne	t2,zero,170 <.notzero>
 160:	fff60613          	addi	a2,a2,-1
 164:	00130313          	addi	t1,t1,1
 168:	fc0602e3          	beq	a2,zero,12c <.outloop>
 16c:	fff30313          	addi	t1,t1,-1

00000170 <.notzero>:
 170:	00130313          	addi	t1,t1,1
 174:	fe5ff06f          	jal	zero,158 <.srcloop>

00000178 <.outloopz>:
 178:	80657383          	lbu.r	t2,t1(a0)
 17c:	00758023          	sb	t2,0(a1)
 180:	00130313          	addi	t1,t1,1
 184:	fe039ae3          	bne	t2,zero,178 <.outloopz>

00000188 <.donez>:
 188:	00008067          	jalr	zero,0(ra)

0000018c <core.exc_handel>:
 18c:	00000013          	addi	zero,zero,0
 190:	00000013          	addi	zero,zero,0
 194:	00000013          	addi	zero,zero,0
 198:	00100313          	addi	t1,zero,1
 19c:	00600393          	addi	t2,zero,6
 1a0:	fe7305f3          	ciop	a1,t1,t2
 1a4:	25000513          	addi	a0,zero,592
 1a8:	fd050573          	ccp	a0,a0
 1ac:	f71ff0ef          	jal	ra,11c <core.out_str>
 1b0:	27000513          	addi	a0,zero,624
 1b4:	fd050573          	ccp	a0,a0
 1b8:	34202673          	csrrs	a2,mcause,zero
 1bc:	f89ff0ef          	jal	ra,144 <core.out_str_zero>
 1c0:	00000013          	addi	zero,zero,0
 1c4:	00000013          	addi	zero,zero,0
 1c8:	00000013          	addi	zero,zero,0
 1cc:	00000013          	addi	zero,zero,0
 1d0:	30200073          	mret
 1d4:	ffb28293          	addi	t0,t0,-5
 1d8:	ff730313          	addi	t1,t1,-9

000001dc <core.end>:
 1dc:	00000013          	addi	zero,zero,0
 1e0:	0000                	.insn	2, 0x
	...

Disassembly of section usb:

000001e8 <usb.af_-0x8>:
 1e8:	0008                	.insn	2, 0x0008
 1ea:	0000                	.insn	2, 0x
 1ec:	0040                	.insn	2, 0x0040
	...

000001f0 <usb.af_>:
 1f0:	0080006f          	jal	zero,1f8 <usb.af>

000001f4 <usb.b_>:
 1f4:	0100006f          	jal	zero,204 <usb.b>

000001f8 <usb.af>:
 1f8:	00230293          	addi	t0,t1,2
 1fc:	005e8e13          	addi	t3,t4,5
 200:	00008067          	jalr	zero,0(ra)

00000204 <usb.b>:
 204:	0031700b          	push	0,0
 208:	0011100b          	sp	ra,0(frame)
 20c:	010000ef          	jal	ra,21c <usb.c>
 210:	0001208b          	lp	ra,0(frame)
 214:	1800000b          	pop
 218:	00008067          	jalr	zero,0(ra)

0000021c <usb.c>:
 21c:	0031700b          	push	0,0
 220:	0011100b          	sp	ra,0(frame)
 224:	000500e7          	jalr	ra,0(a0)
 228:	0001208b          	lp	ra,0(frame)
 22c:	1800000b          	pop
 230:	00008067          	jalr	zero,0(ra)

00000234 <usb.end>:
 234:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

00000238 <hdmi.s_-0x8>:
 238:	0004                	.insn	2, 0x0004
 23a:	0000                	.insn	2, 0x
 23c:	000c                	.insn	2, 0x000c
	...

00000240 <hdmi.s_>:
 240:	0040006f          	jal	zero,244 <hdmi.s>

00000244 <hdmi.s>:
 244:	00230293          	addi	t0,t1,2
 248:	005e8e13          	addi	t3,t4,5
 24c:	00008067          	jalr	zero,0(ra)

Disassembly of section exception_hdr_str:

00000250 <exception_hdr_str_-0x8>:
 250:	0000                	.insn	2, 0x
 252:	0000                	.insn	2, 0x
 254:	0016                	.insn	2, 0x0016
	...

00000258 <exception_hdr_str_>:
 258:	6e41                	.insn	2, 0x6e41
 25a:	4520                	.insn	2, 0x4520
 25c:	6378                	.insn	2, 0x6378
 25e:	7065                	.insn	2, 0x7065
 260:	6974                	.insn	2, 0x6974
 262:	6f206e6f          	jal	t3,6954 <_end+0x647c>
 266:	72756363          	bltu	a0,t2,98c <_end+0x4b4>
 26a:	6465                	.insn	2, 0x6465
 26c:	203a                	.insn	2, 0x203a

0000026e <exception_hdr_str.end>:
	...

Disassembly of section exception_strs:

00000270 <exception_strs_-0x8>:
 270:	0000                	.insn	2, 0x
 272:	0000                	.insn	2, 0x
 274:	0000023b          	.insn	4, 0x023b

00000278 <exception_strs_>:
 278:	6170                	.insn	2, 0x6170
 27a:	696e                	.insn	2, 0x696e
 27c:	202d2063          	.insn	4, 0x202d2063
 280:	65766573          	csrrsi	a0,hviprio2h,12
 284:	6572                	.insn	2, 0x6572
 286:	6920                	.insn	2, 0x6920
 288:	746e                	.insn	2, 0x746e
 28a:	7265                	.insn	2, 0x7265
 28c:	616e                	.insn	2, 0x616e
 28e:	206c                	.insn	2, 0x206c
 290:	7265                	.insn	2, 0x7265
 292:	6f72                	.insn	2, 0x6f72
 294:	0072                	.insn	2, 0x0072
 296:	6c69                	.insn	2, 0x6c69
 298:	656c                	.insn	2, 0x656c
 29a:	202d2067          	.insn	4, 0x202d2067
 29e:	6c69                	.insn	2, 0x6c69
 2a0:	656c                	.insn	2, 0x656c
 2a2:	206c6167          	.insn	4, 0x206c6167
 2a6:	6e69                	.insn	2, 0x6e69
 2a8:	75727473          	csrrci	s0,0x757,4
 2ac:	6f697463          	bgeu	s2,s6,994 <_end+0x4bc>
 2b0:	006e                	.insn	2, 0x006e
 2b2:	72657673          	csrrci	a2,mhpmevent6h,10
 2b6:	2072                	.insn	2, 0x2072
 2b8:	202d                	.insn	2, 0x202d
 2ba:	65707573          	csrrci	a0,hviprio2h,0
 2be:	7672                	.insn	2, 0x7672
 2c0:	7369                	.insn	2, 0x7369
 2c2:	6520726f          	jal	ctxt,7914 <_end+0x743c>
 2c6:	7272                	.insn	2, 0x7272
 2c8:	7300726f          	jal	ctxt,79f8 <_end+0x7520>
 2cc:	6574                	.insn	2, 0x6574
 2ce:	7272                	.insn	2, 0x7272
 2d0:	2d20                	.insn	2, 0x2d20
 2d2:	7320                	.insn	2, 0x7320
 2d4:	6174                	.insn	2, 0x6174
 2d6:	6574                	.insn	2, 0x6574
 2d8:	6520                	.insn	2, 0x6520
 2da:	7272                	.insn	2, 0x7272
 2dc:	7000726f          	jal	ctxt,79dc <_end+0x7504>
 2e0:	6972                	.insn	2, 0x6972
 2e2:	7676                	.insn	2, 0x7676
 2e4:	2d20                	.insn	2, 0x2d20
 2e6:	7020                	.insn	2, 0x7020
 2e8:	6972                	.insn	2, 0x6972
 2ea:	6976                	.insn	2, 0x6976
 2ec:	656c                	.insn	2, 0x656c
 2ee:	64656467          	.insn	4, 0x64656467
 2f2:	6920                	.insn	2, 0x6920
 2f4:	736e                	.insn	2, 0x736e
 2f6:	7274                	.insn	2, 0x7274
 2f8:	6375                	.insn	2, 0x6375
 2fa:	6974                	.insn	2, 0x6974
 2fc:	74006e6f          	jal	t3,6a3c <_end+0x6564>
 300:	6c696f63          	bltu	s2,t1,9de <_end+0x506>
 304:	2d20                	.insn	2, 0x2d20
 306:	7420                	.insn	2, 0x7420
 308:	7261                	.insn	2, 0x7261
 30a:	20746567          	.insn	4, 0x20746567
 30e:	65646f63          	bltu	s0,s6,96c <_end+0x494>
 312:	6920                	.insn	2, 0x6920
 314:	646e                	.insn	2, 0x646e
 316:	7865                	.insn	2, 0x7865
 318:	7400                	.insn	2, 0x7400
 31a:	626f6963          	bltu	t5,t1,94c <_end+0x474>
 31e:	2d20                	.insn	2, 0x2d20
 320:	7420                	.insn	2, 0x7420
 322:	7261                	.insn	2, 0x7261
 324:	20746567          	.insn	4, 0x20746567
 328:	65646f63          	bltu	s0,s6,986 <_end+0x4ae>
 32c:	6920                	.insn	2, 0x6920
 32e:	646e                	.insn	2, 0x646e
 330:	7865                	.insn	2, 0x7865
 332:	6f20                	.insn	2, 0x6f20
 334:	7475                	.insn	2, 0x7475
 336:	6f20                	.insn	2, 0x6f20
 338:	2066                	.insn	2, 0x2066
 33a:	6f62                	.insn	2, 0x6f62
 33c:	6e75                	.insn	2, 0x6e75
 33e:	0064                	.insn	2, 0x0064
 340:	6e65                	.insn	2, 0x6e65
 342:	6f64                	.insn	2, 0x6f64
 344:	202d2063          	.insn	4, 0x202d2063
 348:	6e65                	.insn	2, 0x6e65
 34a:	2064                	.insn	2, 0x2064
 34c:	6320666f          	jal	a2,697e <_end+0x64a6>
 350:	0065646f          	jal	s0,56356 <_end+0x55e7e>
 354:	6972                	.insn	2, 0x6972
 356:	6578                	.insn	2, 0x6578
 358:	2071                	.insn	2, 0x2071
 35a:	202d                	.insn	2, 0x202d
 35c:	6572                	.insn	2, 0x6572
 35e:	7574                	.insn	2, 0x7574
 360:	6e72                	.insn	2, 0x6e72
 362:	6920                	.insn	2, 0x6920
 364:	646e                	.insn	2, 0x646e
 366:	7865                	.insn	2, 0x7865
 368:	6920                	.insn	2, 0x6920
 36a:	657a2073          	csrrs	zero,hviprio2h,s4
 36e:	6f72                	.insn	2, 0x6f72
 370:	7200                	.insn	2, 0x7200
 372:	756e6463          	bltu	t3,s6,aba <_end+0x5e2>
 376:	2d20                	.insn	2, 0x2d20
 378:	7220                	.insn	2, 0x7220
 37a:	7465                	.insn	2, 0x7465
 37c:	7275                	.insn	2, 0x7275
 37e:	206e                	.insn	2, 0x206e
 380:	65646f63          	bltu	s0,s6,9de <_end+0x506>
 384:	6920                	.insn	2, 0x6920
 386:	756e2073          	csrrs	zero,0x756,t3
 38a:	6c6c                	.insn	2, 0x6c6c
 38c:	7200                	.insn	2, 0x7200
 38e:	636e6463          	bltu	t3,s6,9b6 <_end+0x4de>
 392:	2d20                	.insn	2, 0x2d20
 394:	7220                	.insn	2, 0x7220
 396:	7465                	.insn	2, 0x7465
 398:	7275                	.insn	2, 0x7275
 39a:	206e                	.insn	2, 0x206e
 39c:	65646f63          	bltu	s0,s6,9fa <_end+0x522>
 3a0:	7020                	.insn	2, 0x7020
 3a2:	7274                	.insn	2, 0x7274
 3a4:	6920                	.insn	2, 0x6920
 3a6:	6f6e2073          	csrrs	zero,0x6f6,t3
 3aa:	2074                	.insn	2, 0x2074
 3ac:	2061                	.insn	2, 0x2061
 3ae:	65646f63          	bltu	s0,s6,a0c <_end+0x534>
 3b2:	7020                	.insn	2, 0x7020
 3b4:	7274                	.insn	2, 0x7274
 3b6:	6400                	.insn	2, 0x6400
 3b8:	6672                	.insn	2, 0x6672
 3ba:	756e                	.insn	2, 0x756e
 3bc:	2d20                	.insn	2, 0x2d20
 3be:	6420                	.insn	2, 0x6420
 3c0:	7265                	.insn	2, 0x7265
 3c2:	6665                	.insn	2, 0x6665
 3c4:	7265                	.insn	2, 0x7265
 3c6:	6e65                	.insn	2, 0x6e65
 3c8:	20646563          	bltu	s0,t1,5d2 <_end+0xfa>
 3cc:	756e                	.insn	2, 0x756e
 3ce:	6c6c                	.insn	2, 0x6c6c
 3d0:	7020                	.insn	2, 0x7020
 3d2:	746e696f          	jal	s2,e6b18 <_end+0xe6640>
 3d6:	7265                	.insn	2, 0x7265
 3d8:	6400                	.insn	2, 0x6400
 3da:	6672                	.insn	2, 0x6672
 3dc:	2d206463          	bltu	zero,s2,6a4 <_end+0x1cc>
 3e0:	6420                	.insn	2, 0x6420
 3e2:	7265                	.insn	2, 0x7265
 3e4:	6665                	.insn	2, 0x6665
 3e6:	7265                	.insn	2, 0x7265
 3e8:	6e65                	.insn	2, 0x6e65
 3ea:	20646563          	bltu	s0,t1,5f4 <_end+0x11c>
 3ee:	65646f63          	bltu	s0,s6,a4c <_end+0x574>
 3f2:	7020                	.insn	2, 0x7020
 3f4:	746e696f          	jal	s2,e6b3a <_end+0xe6662>
 3f8:	7265                	.insn	2, 0x7265
 3fa:	7700                	.insn	2, 0x7700
 3fc:	7072                	.insn	2, 0x7072
 3fe:	7674                	.insn	2, 0x7674
 400:	2d20                	.insn	2, 0x2d20
 402:	7720                	.insn	2, 0x7720
 404:	6f72                	.insn	2, 0x6f72
 406:	6574                	.insn	2, 0x6574
 408:	7520                	.insn	2, 0x7520
 40a:	676e6973          	csrrsi	s2,0x676,28
 40e:	7220                	.insn	2, 0x7220
 410:	6165                	.insn	2, 0x6165
 412:	2064                	.insn	2, 0x2064
 414:	796c6e6f          	jal	t3,c6baa <_end+0xc66d2>
 418:	7020                	.insn	2, 0x7020
 41a:	746e696f          	jal	s2,e6b60 <_end+0xe6688>
 41e:	7265                	.insn	2, 0x7265
 420:	7300                	.insn	2, 0x7300
 422:	6165                	.insn	2, 0x6165
 424:	766c                	.insn	2, 0x766c
 426:	2d20                	.insn	2, 0x2d20
 428:	7720                	.insn	2, 0x7720
 42a:	6f72                	.insn	2, 0x6f72
 42c:	6574                	.insn	2, 0x6574
 42e:	7420                	.insn	2, 0x7420
 430:	6572206f          	jal	zero,23286 <_end+0x22dae>
 434:	6461                	.insn	2, 0x6461
 436:	6f20                	.insn	2, 0x6f20
 438:	6c6e                	.insn	2, 0x6c6e
 43a:	2079                	.insn	2, 0x2079
 43c:	656a626f          	jal	ctxt,a6a92 <_end+0xa65ba>
 440:	69007463          	bgeu	zero,a6,ac8 <_end+0x5f0>
 444:	6f78                	.insn	2, 0x6f78
 446:	2d20626f          	jal	ctxt,6718 <_end+0x6240>
 44a:	6920                	.insn	2, 0x6920
 44c:	646e                	.insn	2, 0x646e
 44e:	7865                	.insn	2, 0x7865
 450:	6f20                	.insn	2, 0x6f20
 452:	7475                	.insn	2, 0x7475
 454:	6f20                	.insn	2, 0x6f20
 456:	2066                	.insn	2, 0x2066
 458:	6f62                	.insn	2, 0x6f62
 45a:	6e75                	.insn	2, 0x6e75
 45c:	7364                	.insn	2, 0x7364
 45e:	6600                	.insn	2, 0x6600
 460:	7472                	.insn	2, 0x7472
 462:	7079                	.insn	2, 0x7079
 464:	2d20                	.insn	2, 0x2d20
 466:	6620                	.insn	2, 0x6620
 468:	6172                	.insn	2, 0x6172
 46a:	656d                	.insn	2, 0x656d
 46c:	7420                	.insn	2, 0x7420
 46e:	7079                	.insn	2, 0x7079
 470:	0065                	.insn	2, 0x0065
 472:	7061                	.insn	2, 0x7061
 474:	7265                	.insn	2, 0x7265
 476:	2072                	.insn	2, 0x2072
 478:	202d                	.insn	2, 0x202d
 47a:	003f3f3f 766f7068 	.insn	8, 0x766f7068003f3f3f
 482:	2066                	.insn	2, 0x2066
 484:	202d                	.insn	2, 0x202d
 486:	6568                	.insn	2, 0x6568
 488:	7061                	.insn	2, 0x7061
 48a:	6620                	.insn	2, 0x6620
 48c:	6c75                	.insn	2, 0x6c75
 48e:	006c                	.insn	2, 0x006c
 490:	766f7473          	csrrci	s0,0x766,30
 494:	2066                	.insn	2, 0x2066
 496:	202d                	.insn	2, 0x202d
 498:	63617473          	csrrci	s0,0x636,2
 49c:	766f206b          	.insn	4, 0x766f206b
 4a0:	7265                	.insn	2, 0x7265
 4a2:	6c66                	.insn	2, 0x6c66
 4a4:	7000776f          	jal	a4,7ba4 <_end+0x76cc>
 4a8:	6174                	.insn	2, 0x6174
 4aa:	6972                	.insn	2, 0x6972
 4ac:	2d20                	.insn	2, 0x2d20
 4ae:	3f20                	.insn	2, 0x3f20
 4b0:	  	.insn	8, 0x3f3f

000004b3 <exception_strs.end>:
 4b3:	0000                	.insn	2, 0x
 4b5:	0000                	.insn	2, 0x
	...

Disassembly of section hello_world_str:

000004b8 <hello_world_str_-0x8>:
 4b8:	0000                	.insn	2, 0x
 4ba:	0000                	.insn	2, 0x
 4bc:	0015                	.insn	2, 0x0015
	...

000004c0 <hello_world_str_>:
 4c0:	6548                	.insn	2, 0x6548
 4c2:	6c6c                	.insn	2, 0x6c6c
 4c4:	7266206f          	jal	zero,62bea <_end+0x62712>
 4c8:	52206d6f          	jal	bm,69ea <_end+0x6512>
 4cc:	7369                	.insn	2, 0x7369
 4ce:	4f695663          	bge	s2,s6,9ba <_end+0x4e2>
 4d2:	0a21                	.insn	2, 0x0a21
 4d4:	                	.insn	2, 0x000d

000004d5 <hello_world_str.end>:
 4d5:	0000                	.insn	2, 0x
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
  2a:	32727363          	bgeu	ctxt,t2,350 <exception_strs_+0xd8>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
