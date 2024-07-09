
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	01b4                	.insn	2, 0x01b4
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
  2c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x355>
  30:	00000297          	auipc	t0,0x0
  34:	14028293          	addi	t0,t0,320 # 170 <core.exc_handel>
  38:	30529073          	csrrw	zero,mtvec,t0
  3c:	01020337          	lui	t1,0x1020
  40:	30430313          	addi	t1,t1,772 # 1020304 <_end+0x101fe54>
  44:	000083b7          	lui	t2,0x8
  48:	00538393          	addi	t2,t2,5 # 8005 <_end+0x7b55>
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
  84:	00200313          	addi	t1,zero,2
  88:	00a00393          	addi	t2,zero,10
  8c:	fe730973          	ciop	s2,t1,t2
  90:	00100993          	addi	s3,zero,1
  94:	10000a13          	addi	s4,zero,256
  98:	00100313          	addi	t1,zero,1
  9c:	00600393          	addi	t2,zero,6
  a0:	fe7304f3          	ciop	s1,t1,t2
  a4:	49000513          	addi	a0,zero,1168
  a8:	fd050473          	ccp	s0,a0

000000ac <core.loop>:
  ac:	01390023          	sb	s3,0(s2)
  b0:	00199993          	slli	s3,s3,0x1
  b4:	0149c463          	blt	s3,s4,bc <core.byteOk>
  b8:	00100993          	addi	s3,zero,1

000000bc <core.byteOk>:
  bc:	00040513          	addi	a0,s0,0
  c0:	00048593          	addi	a1,s1,0
  c4:	040000ef          	jal	ra,104 <core.out_str>
  c8:	fe5ff06f          	jal	zero,ac <core.loop>
  cc:	0031708b          	push	1,0
  d0:	0011100b          	sp	ra,0(frame)
  d4:	00000517          	auipc	a0,0x0
  d8:	13c50513          	addi	a0,a0,316 # 210 <usb.end+0x4>
  dc:	fd050573          	ccp	a0,a0
  e0:	00000417          	auipc	s0,0x0
  e4:	0e040413          	addi	s0,s0,224 # 1c0 <core.end>
  e8:	fd040473          	ccp	s0,s0
  ec:	00040493          	addi	s1,s0,0
  f0:	0091100b          	sp	s1,0(frame)
  f4:	000400e7          	jalr	ra,0(s0)
  f8:	0001240b          	lp	s0,0(frame)
  fc:	004400e7          	jalr	ra,4(s0)
 100:	00100073          	ebreak

00000104 <core.out_str>:
 104:	02050063          	beq	a0,zero,124 <.done>
 108:	0805028b          	qdtb	t0,a0
 10c:	00028c63          	beq	t0,zero,124 <.done>
 110:	00000313          	addi	t1,zero,0

00000114 <.outloop>:
 114:	80657383          	lbu.r	t2,t1(a0)
 118:	00758023          	sb	t2,0(a1)
 11c:	00130313          	addi	t1,t1,1
 120:	fe531ae3          	bne	t1,t0,114 <.outloop>

00000124 <.done>:
 124:	00008067          	jalr	zero,0(ra)

00000128 <core.out_str_zero>:
 128:	04050263          	beq	a0,zero,16c <.donez>
 12c:	0805028b          	qdtb	t0,a0
 130:	02028e63          	beq	t0,zero,16c <.donez>
 134:	00000313          	addi	t1,zero,0
 138:	00160613          	addi	a2,a2,1

0000013c <.srcloop>:
 13c:	80657383          	lbu.r	t2,t1(a0)
 140:	00039a63          	bne	t2,zero,154 <.notzero>
 144:	fff60613          	addi	a2,a2,-1
 148:	00130313          	addi	t1,t1,1
 14c:	fc0604e3          	beq	a2,zero,114 <.outloop>
 150:	fff30313          	addi	t1,t1,-1

00000154 <.notzero>:
 154:	00130313          	addi	t1,t1,1
 158:	fe5ff06f          	jal	zero,13c <.srcloop>

0000015c <.outloopz>:
 15c:	80657383          	lbu.r	t2,t1(a0)
 160:	00758023          	sb	t2,0(a1)
 164:	00130313          	addi	t1,t1,1
 168:	fe039ae3          	bne	t2,zero,15c <.outloopz>

0000016c <.donez>:
 16c:	00008067          	jalr	zero,0(ra)

00000170 <core.exc_handel>:
 170:	00000013          	addi	zero,zero,0
 174:	00000013          	addi	zero,zero,0
 178:	00000013          	addi	zero,zero,0
 17c:	00100313          	addi	t1,zero,1
 180:	00600393          	addi	t2,zero,6
 184:	fe7305f3          	ciop	a1,t1,t2
 188:	22800513          	addi	a0,zero,552
 18c:	fd050573          	ccp	a0,a0
 190:	f75ff0ef          	jal	ra,104 <core.out_str>
 194:	24800513          	addi	a0,zero,584
 198:	fd050573          	ccp	a0,a0
 19c:	34202673          	csrrs	a2,mcause,zero
 1a0:	f89ff0ef          	jal	ra,128 <core.out_str_zero>
 1a4:	00000013          	addi	zero,zero,0
 1a8:	00000013          	addi	zero,zero,0
 1ac:	00000013          	addi	zero,zero,0
 1b0:	00000013          	addi	zero,zero,0
 1b4:	30200073          	mret
 1b8:	ffb28293          	addi	t0,t0,-5
 1bc:	ff730313          	addi	t1,t1,-9

Disassembly of section usb:

000001c0 <usb.af_-0x8>:
 1c0:	0008                	.insn	2, 0x0008
 1c2:	0000                	.insn	2, 0x
 1c4:	0040                	.insn	2, 0x0040
	...

000001c8 <usb.af_>:
 1c8:	0080006f          	jal	zero,1d0 <usb.af>

000001cc <usb.b_>:
 1cc:	0100006f          	jal	zero,1dc <usb.b>

000001d0 <usb.af>:
 1d0:	00230293          	addi	t0,t1,2
 1d4:	005e8e13          	addi	t3,t4,5
 1d8:	00008067          	jalr	zero,0(ra)

000001dc <usb.b>:
 1dc:	0031700b          	push	0,0
 1e0:	0011100b          	sp	ra,0(frame)
 1e4:	010000ef          	jal	ra,1f4 <usb.c>
 1e8:	0001208b          	lp	ra,0(frame)
 1ec:	1800000b          	pop
 1f0:	00008067          	jalr	zero,0(ra)

000001f4 <usb.c>:
 1f4:	0031700b          	push	0,0
 1f8:	0011100b          	sp	ra,0(frame)
 1fc:	000500e7          	jalr	ra,0(a0)
 200:	0001208b          	lp	ra,0(frame)
 204:	1800000b          	pop
 208:	00008067          	jalr	zero,0(ra)

0000020c <usb.end>:
 20c:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

00000210 <hdmi.s_-0x8>:
 210:	0004                	.insn	2, 0x0004
 212:	0000                	.insn	2, 0x
 214:	000c                	.insn	2, 0x000c
	...

00000218 <hdmi.s_>:
 218:	0040006f          	jal	zero,21c <hdmi.s>

0000021c <hdmi.s>:
 21c:	00230293          	addi	t0,t1,2
 220:	005e8e13          	addi	t3,t4,5
 224:	00008067          	jalr	zero,0(ra)

Disassembly of section exception_hdr_str:

00000228 <exception_hdr_str_-0x8>:
 228:	0000                	.insn	2, 0x
 22a:	0000                	.insn	2, 0x
 22c:	0016                	.insn	2, 0x0016
	...

00000230 <exception_hdr_str_>:
 230:	6e41                	.insn	2, 0x6e41
 232:	4520                	.insn	2, 0x4520
 234:	6378                	.insn	2, 0x6378
 236:	7065                	.insn	2, 0x7065
 238:	6974                	.insn	2, 0x6974
 23a:	6f206e6f          	jal	t3,692c <_end+0x647c>
 23e:	72756363          	bltu	a0,t2,964 <_end+0x4b4>
 242:	6465                	.insn	2, 0x6465
 244:	203a                	.insn	2, 0x203a

00000246 <exception_hdr_str.end>:
	...

Disassembly of section exception_strs:

00000248 <exception_strs_-0x8>:
 248:	0000                	.insn	2, 0x
 24a:	0000                	.insn	2, 0x
 24c:	0000023b          	.insn	4, 0x023b

00000250 <exception_strs_>:
 250:	6170                	.insn	2, 0x6170
 252:	696e                	.insn	2, 0x696e
 254:	202d2063          	.insn	4, 0x202d2063
 258:	65766573          	csrrsi	a0,hviprio2h,12
 25c:	6572                	.insn	2, 0x6572
 25e:	6920                	.insn	2, 0x6920
 260:	746e                	.insn	2, 0x746e
 262:	7265                	.insn	2, 0x7265
 264:	616e                	.insn	2, 0x616e
 266:	206c                	.insn	2, 0x206c
 268:	7265                	.insn	2, 0x7265
 26a:	6f72                	.insn	2, 0x6f72
 26c:	0072                	.insn	2, 0x0072
 26e:	6c69                	.insn	2, 0x6c69
 270:	656c                	.insn	2, 0x656c
 272:	202d2067          	.insn	4, 0x202d2067
 276:	6c69                	.insn	2, 0x6c69
 278:	656c                	.insn	2, 0x656c
 27a:	206c6167          	.insn	4, 0x206c6167
 27e:	6e69                	.insn	2, 0x6e69
 280:	75727473          	csrrci	s0,0x757,4
 284:	6f697463          	bgeu	s2,s6,96c <_end+0x4bc>
 288:	006e                	.insn	2, 0x006e
 28a:	72657673          	csrrci	a2,mhpmevent6h,10
 28e:	2072                	.insn	2, 0x2072
 290:	202d                	.insn	2, 0x202d
 292:	65707573          	csrrci	a0,hviprio2h,0
 296:	7672                	.insn	2, 0x7672
 298:	7369                	.insn	2, 0x7369
 29a:	6520726f          	jal	ctxt,78ec <_end+0x743c>
 29e:	7272                	.insn	2, 0x7272
 2a0:	7300726f          	jal	ctxt,79d0 <_end+0x7520>
 2a4:	6574                	.insn	2, 0x6574
 2a6:	7272                	.insn	2, 0x7272
 2a8:	2d20                	.insn	2, 0x2d20
 2aa:	7320                	.insn	2, 0x7320
 2ac:	6174                	.insn	2, 0x6174
 2ae:	6574                	.insn	2, 0x6574
 2b0:	6520                	.insn	2, 0x6520
 2b2:	7272                	.insn	2, 0x7272
 2b4:	7000726f          	jal	ctxt,79b4 <_end+0x7504>
 2b8:	6972                	.insn	2, 0x6972
 2ba:	7676                	.insn	2, 0x7676
 2bc:	2d20                	.insn	2, 0x2d20
 2be:	7020                	.insn	2, 0x7020
 2c0:	6972                	.insn	2, 0x6972
 2c2:	6976                	.insn	2, 0x6976
 2c4:	656c                	.insn	2, 0x656c
 2c6:	64656467          	.insn	4, 0x64656467
 2ca:	6920                	.insn	2, 0x6920
 2cc:	736e                	.insn	2, 0x736e
 2ce:	7274                	.insn	2, 0x7274
 2d0:	6375                	.insn	2, 0x6375
 2d2:	6974                	.insn	2, 0x6974
 2d4:	74006e6f          	jal	t3,6a14 <_end+0x6564>
 2d8:	6c696f63          	bltu	s2,t1,9b6 <_end+0x506>
 2dc:	2d20                	.insn	2, 0x2d20
 2de:	7420                	.insn	2, 0x7420
 2e0:	7261                	.insn	2, 0x7261
 2e2:	20746567          	.insn	4, 0x20746567
 2e6:	65646f63          	bltu	s0,s6,944 <_end+0x494>
 2ea:	6920                	.insn	2, 0x6920
 2ec:	646e                	.insn	2, 0x646e
 2ee:	7865                	.insn	2, 0x7865
 2f0:	7400                	.insn	2, 0x7400
 2f2:	626f6963          	bltu	t5,t1,924 <_end+0x474>
 2f6:	2d20                	.insn	2, 0x2d20
 2f8:	7420                	.insn	2, 0x7420
 2fa:	7261                	.insn	2, 0x7261
 2fc:	20746567          	.insn	4, 0x20746567
 300:	65646f63          	bltu	s0,s6,95e <_end+0x4ae>
 304:	6920                	.insn	2, 0x6920
 306:	646e                	.insn	2, 0x646e
 308:	7865                	.insn	2, 0x7865
 30a:	6f20                	.insn	2, 0x6f20
 30c:	7475                	.insn	2, 0x7475
 30e:	6f20                	.insn	2, 0x6f20
 310:	2066                	.insn	2, 0x2066
 312:	6f62                	.insn	2, 0x6f62
 314:	6e75                	.insn	2, 0x6e75
 316:	0064                	.insn	2, 0x0064
 318:	6e65                	.insn	2, 0x6e65
 31a:	6f64                	.insn	2, 0x6f64
 31c:	202d2063          	.insn	4, 0x202d2063
 320:	6e65                	.insn	2, 0x6e65
 322:	2064                	.insn	2, 0x2064
 324:	6320666f          	jal	a2,6956 <_end+0x64a6>
 328:	0065646f          	jal	s0,5632e <_end+0x55e7e>
 32c:	6972                	.insn	2, 0x6972
 32e:	6578                	.insn	2, 0x6578
 330:	2071                	.insn	2, 0x2071
 332:	202d                	.insn	2, 0x202d
 334:	6572                	.insn	2, 0x6572
 336:	7574                	.insn	2, 0x7574
 338:	6e72                	.insn	2, 0x6e72
 33a:	6920                	.insn	2, 0x6920
 33c:	646e                	.insn	2, 0x646e
 33e:	7865                	.insn	2, 0x7865
 340:	6920                	.insn	2, 0x6920
 342:	657a2073          	csrrs	zero,hviprio2h,s4
 346:	6f72                	.insn	2, 0x6f72
 348:	7200                	.insn	2, 0x7200
 34a:	756e6463          	bltu	t3,s6,a92 <_end+0x5e2>
 34e:	2d20                	.insn	2, 0x2d20
 350:	7220                	.insn	2, 0x7220
 352:	7465                	.insn	2, 0x7465
 354:	7275                	.insn	2, 0x7275
 356:	206e                	.insn	2, 0x206e
 358:	65646f63          	bltu	s0,s6,9b6 <_end+0x506>
 35c:	6920                	.insn	2, 0x6920
 35e:	756e2073          	csrrs	zero,0x756,t3
 362:	6c6c                	.insn	2, 0x6c6c
 364:	7200                	.insn	2, 0x7200
 366:	636e6463          	bltu	t3,s6,98e <_end+0x4de>
 36a:	2d20                	.insn	2, 0x2d20
 36c:	7220                	.insn	2, 0x7220
 36e:	7465                	.insn	2, 0x7465
 370:	7275                	.insn	2, 0x7275
 372:	206e                	.insn	2, 0x206e
 374:	65646f63          	bltu	s0,s6,9d2 <_end+0x522>
 378:	7020                	.insn	2, 0x7020
 37a:	7274                	.insn	2, 0x7274
 37c:	6920                	.insn	2, 0x6920
 37e:	6f6e2073          	csrrs	zero,0x6f6,t3
 382:	2074                	.insn	2, 0x2074
 384:	2061                	.insn	2, 0x2061
 386:	65646f63          	bltu	s0,s6,9e4 <_end+0x534>
 38a:	7020                	.insn	2, 0x7020
 38c:	7274                	.insn	2, 0x7274
 38e:	6400                	.insn	2, 0x6400
 390:	6672                	.insn	2, 0x6672
 392:	756e                	.insn	2, 0x756e
 394:	2d20                	.insn	2, 0x2d20
 396:	6420                	.insn	2, 0x6420
 398:	7265                	.insn	2, 0x7265
 39a:	6665                	.insn	2, 0x6665
 39c:	7265                	.insn	2, 0x7265
 39e:	6e65                	.insn	2, 0x6e65
 3a0:	20646563          	bltu	s0,t1,5aa <_end+0xfa>
 3a4:	756e                	.insn	2, 0x756e
 3a6:	6c6c                	.insn	2, 0x6c6c
 3a8:	7020                	.insn	2, 0x7020
 3aa:	746e696f          	jal	s2,e6af0 <_end+0xe6640>
 3ae:	7265                	.insn	2, 0x7265
 3b0:	6400                	.insn	2, 0x6400
 3b2:	6672                	.insn	2, 0x6672
 3b4:	2d206463          	bltu	zero,s2,67c <_end+0x1cc>
 3b8:	6420                	.insn	2, 0x6420
 3ba:	7265                	.insn	2, 0x7265
 3bc:	6665                	.insn	2, 0x6665
 3be:	7265                	.insn	2, 0x7265
 3c0:	6e65                	.insn	2, 0x6e65
 3c2:	20646563          	bltu	s0,t1,5cc <_end+0x11c>
 3c6:	65646f63          	bltu	s0,s6,a24 <_end+0x574>
 3ca:	7020                	.insn	2, 0x7020
 3cc:	746e696f          	jal	s2,e6b12 <_end+0xe6662>
 3d0:	7265                	.insn	2, 0x7265
 3d2:	7700                	.insn	2, 0x7700
 3d4:	7072                	.insn	2, 0x7072
 3d6:	7674                	.insn	2, 0x7674
 3d8:	2d20                	.insn	2, 0x2d20
 3da:	7720                	.insn	2, 0x7720
 3dc:	6f72                	.insn	2, 0x6f72
 3de:	6574                	.insn	2, 0x6574
 3e0:	7520                	.insn	2, 0x7520
 3e2:	676e6973          	csrrsi	s2,0x676,28
 3e6:	7220                	.insn	2, 0x7220
 3e8:	6165                	.insn	2, 0x6165
 3ea:	2064                	.insn	2, 0x2064
 3ec:	796c6e6f          	jal	t3,c6b82 <_end+0xc66d2>
 3f0:	7020                	.insn	2, 0x7020
 3f2:	746e696f          	jal	s2,e6b38 <_end+0xe6688>
 3f6:	7265                	.insn	2, 0x7265
 3f8:	7300                	.insn	2, 0x7300
 3fa:	6165                	.insn	2, 0x6165
 3fc:	766c                	.insn	2, 0x766c
 3fe:	2d20                	.insn	2, 0x2d20
 400:	7720                	.insn	2, 0x7720
 402:	6f72                	.insn	2, 0x6f72
 404:	6574                	.insn	2, 0x6574
 406:	7420                	.insn	2, 0x7420
 408:	6572206f          	jal	zero,2325e <_end+0x22dae>
 40c:	6461                	.insn	2, 0x6461
 40e:	6f20                	.insn	2, 0x6f20
 410:	6c6e                	.insn	2, 0x6c6e
 412:	2079                	.insn	2, 0x2079
 414:	656a626f          	jal	ctxt,a6a6a <_end+0xa65ba>
 418:	69007463          	bgeu	zero,a6,aa0 <_end+0x5f0>
 41c:	6f78                	.insn	2, 0x6f78
 41e:	2d20626f          	jal	ctxt,66f0 <_end+0x6240>
 422:	6920                	.insn	2, 0x6920
 424:	646e                	.insn	2, 0x646e
 426:	7865                	.insn	2, 0x7865
 428:	6f20                	.insn	2, 0x6f20
 42a:	7475                	.insn	2, 0x7475
 42c:	6f20                	.insn	2, 0x6f20
 42e:	2066                	.insn	2, 0x2066
 430:	6f62                	.insn	2, 0x6f62
 432:	6e75                	.insn	2, 0x6e75
 434:	7364                	.insn	2, 0x7364
 436:	6600                	.insn	2, 0x6600
 438:	7472                	.insn	2, 0x7472
 43a:	7079                	.insn	2, 0x7079
 43c:	2d20                	.insn	2, 0x2d20
 43e:	6620                	.insn	2, 0x6620
 440:	6172                	.insn	2, 0x6172
 442:	656d                	.insn	2, 0x656d
 444:	7420                	.insn	2, 0x7420
 446:	7079                	.insn	2, 0x7079
 448:	0065                	.insn	2, 0x0065
 44a:	7061                	.insn	2, 0x7061
 44c:	7265                	.insn	2, 0x7265
 44e:	2072                	.insn	2, 0x2072
 450:	202d                	.insn	2, 0x202d
 452:	003f3f3f 766f7068 	.insn	8, 0x766f7068003f3f3f
 45a:	2066                	.insn	2, 0x2066
 45c:	202d                	.insn	2, 0x202d
 45e:	6568                	.insn	2, 0x6568
 460:	7061                	.insn	2, 0x7061
 462:	6620                	.insn	2, 0x6620
 464:	6c75                	.insn	2, 0x6c75
 466:	006c                	.insn	2, 0x006c
 468:	766f7473          	csrrci	s0,0x766,30
 46c:	2066                	.insn	2, 0x2066
 46e:	202d                	.insn	2, 0x202d
 470:	63617473          	csrrci	s0,0x636,2
 474:	766f206b          	.insn	4, 0x766f206b
 478:	7265                	.insn	2, 0x7265
 47a:	6c66                	.insn	2, 0x6c66
 47c:	7000776f          	jal	a4,7b7c <_end+0x76cc>
 480:	6174                	.insn	2, 0x6174
 482:	6972                	.insn	2, 0x6972
 484:	2d20                	.insn	2, 0x2d20
 486:	3f20                	.insn	2, 0x3f20
 488:	  	.insn	8, 0x3f3f

0000048b <exception_strs.end>:
 48b:	0000                	.insn	2, 0x
 48d:	0000                	.insn	2, 0x
	...

Disassembly of section hello_world_str:

00000490 <hello_world_str_-0x8>:
 490:	0000                	.insn	2, 0x
 492:	0000                	.insn	2, 0x
 494:	0014                	.insn	2, 0x0014
	...

00000498 <hello_world_str_>:
 498:	6548                	.insn	2, 0x6548
 49a:	6c6c                	.insn	2, 0x6c6c
 49c:	7266206f          	jal	zero,62bc2 <_end+0x62712>
 4a0:	52206d6f          	jal	bm,69c2 <_end+0x6512>
 4a4:	7369                	.insn	2, 0x7369
 4a6:	4f695663          	bge	s2,s6,992 <_end+0x4e2>
 4aa:	0a21                	.insn	2, 0x0a21

000004ac <hello_world_str.end>:
 4ac:	0000                	.insn	2, 0x
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
  2a:	32727363          	bgeu	ctxt,t2,350 <exception_strs_+0x100>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
