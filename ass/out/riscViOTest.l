
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	01b0                	.insn	2, 0x01b0
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
  2c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x34d>
  30:	00000297          	auipc	t0,0x0
  34:	13c28293          	addi	t0,t0,316 # 16c <core.exc_handel>
  38:	30529073          	csrrw	zero,mtvec,t0
  3c:	01020337          	lui	t1,0x1020
  40:	30430313          	addi	t1,t1,772 # 1020304 <_end+0x101fe4c>
  44:	000083b7          	lui	t2,0x8
  48:	00538393          	addi	t2,t2,5 # 8005 <_end+0x7b4d>
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
  a4:	49800513          	addi	a0,zero,1176
  a8:	fd050473          	ccp	s0,a0

000000ac <core.loop>:
  ac:	01390023          	sb	s3,0(s2)
  b0:	6019d993          	rori	s3,s3,0x1
  b4:	00040513          	addi	a0,s0,0
  b8:	00048593          	addi	a1,s1,0
  bc:	044000ef          	jal	ra,100 <core.out_str>
  c0:	00100073          	ebreak
  c4:	fe9ff06f          	jal	zero,ac <core.loop>
  c8:	0031708b          	push	1,0
  cc:	0011100b          	sp	ra,0(frame)
  d0:	00000517          	auipc	a0,0x0
  d4:	14850513          	addi	a0,a0,328 # 218 <usb.end+0x4>
  d8:	fd050573          	ccp	a0,a0
  dc:	00000417          	auipc	s0,0x0
  e0:	0ec40413          	addi	s0,s0,236 # 1c8 <core.end+0xc>
  e4:	fd040473          	ccp	s0,s0
  e8:	00040493          	addi	s1,s0,0
  ec:	0091100b          	sp	s1,0(frame)
  f0:	000400e7          	jalr	ra,0(s0)
  f4:	0001240b          	lp	s0,0(frame)
  f8:	004400e7          	jalr	ra,4(s0)
  fc:	00100073          	ebreak

00000100 <core.out_str>:
 100:	02050063          	beq	a0,zero,120 <.done>
 104:	0805028b          	qdtb	t0,a0
 108:	00028c63          	beq	t0,zero,120 <.done>
 10c:	00000313          	addi	t1,zero,0

00000110 <.outloop>:
 110:	80657383          	lbu.r	t2,t1(a0)
 114:	00758023          	sb	t2,0(a1)
 118:	00130313          	addi	t1,t1,1
 11c:	fe531ae3          	bne	t1,t0,110 <.outloop>

00000120 <.done>:
 120:	00008067          	jalr	zero,0(ra)

00000124 <core.out_str_zero>:
 124:	04050263          	beq	a0,zero,168 <.donez>
 128:	0805028b          	qdtb	t0,a0
 12c:	02028e63          	beq	t0,zero,168 <.donez>
 130:	00000313          	addi	t1,zero,0
 134:	00160613          	addi	a2,a2,1

00000138 <.srcloop>:
 138:	80657383          	lbu.r	t2,t1(a0)
 13c:	00039a63          	bne	t2,zero,150 <.notzero>
 140:	fff60613          	addi	a2,a2,-1
 144:	00130313          	addi	t1,t1,1
 148:	fc0604e3          	beq	a2,zero,110 <.outloop>
 14c:	fff30313          	addi	t1,t1,-1

00000150 <.notzero>:
 150:	00130313          	addi	t1,t1,1
 154:	fe5ff06f          	jal	zero,138 <.srcloop>

00000158 <.outloopz>:
 158:	80657383          	lbu.r	t2,t1(a0)
 15c:	00758023          	sb	t2,0(a1)
 160:	00130313          	addi	t1,t1,1
 164:	fe039ae3          	bne	t2,zero,158 <.outloopz>

00000168 <.donez>:
 168:	00008067          	jalr	zero,0(ra)

0000016c <core.exc_handel>:
 16c:	00000013          	addi	zero,zero,0
 170:	00000013          	addi	zero,zero,0
 174:	00000013          	addi	zero,zero,0
 178:	00100313          	addi	t1,zero,1
 17c:	00600393          	addi	t2,zero,6
 180:	fe7305f3          	ciop	a1,t1,t2
 184:	23000513          	addi	a0,zero,560
 188:	fd050573          	ccp	a0,a0
 18c:	f75ff0ef          	jal	ra,100 <core.out_str>
 190:	25000513          	addi	a0,zero,592
 194:	fd050573          	ccp	a0,a0
 198:	34202673          	csrrs	a2,mcause,zero
 19c:	f89ff0ef          	jal	ra,124 <core.out_str_zero>
 1a0:	00000013          	addi	zero,zero,0
 1a4:	00000013          	addi	zero,zero,0
 1a8:	00000013          	addi	zero,zero,0
 1ac:	00000013          	addi	zero,zero,0
 1b0:	30200073          	mret
 1b4:	ffb28293          	addi	t0,t0,-5
 1b8:	ff730313          	addi	t1,t1,-9

000001bc <core.end>:
 1bc:	00000013          	addi	zero,zero,0
 1c0:	0000                	.insn	2, 0x
	...

Disassembly of section usb:

000001c8 <usb.af_-0x8>:
 1c8:	0008                	.insn	2, 0x0008
 1ca:	0000                	.insn	2, 0x
 1cc:	0040                	.insn	2, 0x0040
	...

000001d0 <usb.af_>:
 1d0:	0080006f          	jal	zero,1d8 <usb.af>

000001d4 <usb.b_>:
 1d4:	0100006f          	jal	zero,1e4 <usb.b>

000001d8 <usb.af>:
 1d8:	00230293          	addi	t0,t1,2
 1dc:	005e8e13          	addi	t3,t4,5
 1e0:	00008067          	jalr	zero,0(ra)

000001e4 <usb.b>:
 1e4:	0031700b          	push	0,0
 1e8:	0011100b          	sp	ra,0(frame)
 1ec:	010000ef          	jal	ra,1fc <usb.c>
 1f0:	0001208b          	lp	ra,0(frame)
 1f4:	1800000b          	pop
 1f8:	00008067          	jalr	zero,0(ra)

000001fc <usb.c>:
 1fc:	0031700b          	push	0,0
 200:	0011100b          	sp	ra,0(frame)
 204:	000500e7          	jalr	ra,0(a0)
 208:	0001208b          	lp	ra,0(frame)
 20c:	1800000b          	pop
 210:	00008067          	jalr	zero,0(ra)

00000214 <usb.end>:
 214:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

00000218 <hdmi.s_-0x8>:
 218:	0004                	.insn	2, 0x0004
 21a:	0000                	.insn	2, 0x
 21c:	000c                	.insn	2, 0x000c
	...

00000220 <hdmi.s_>:
 220:	0040006f          	jal	zero,224 <hdmi.s>

00000224 <hdmi.s>:
 224:	00230293          	addi	t0,t1,2
 228:	005e8e13          	addi	t3,t4,5
 22c:	00008067          	jalr	zero,0(ra)

Disassembly of section exception_hdr_str:

00000230 <exception_hdr_str_-0x8>:
 230:	0000                	.insn	2, 0x
 232:	0000                	.insn	2, 0x
 234:	0016                	.insn	2, 0x0016
	...

00000238 <exception_hdr_str_>:
 238:	6e41                	.insn	2, 0x6e41
 23a:	4520                	.insn	2, 0x4520
 23c:	6378                	.insn	2, 0x6378
 23e:	7065                	.insn	2, 0x7065
 240:	6974                	.insn	2, 0x6974
 242:	6f206e6f          	jal	t3,6934 <_end+0x647c>
 246:	72756363          	bltu	a0,t2,96c <_end+0x4b4>
 24a:	6465                	.insn	2, 0x6465
 24c:	203a                	.insn	2, 0x203a

0000024e <exception_hdr_str.end>:
	...

Disassembly of section exception_strs:

00000250 <exception_strs_-0x8>:
 250:	0000                	.insn	2, 0x
 252:	0000                	.insn	2, 0x
 254:	0000023b          	.insn	4, 0x023b

00000258 <exception_strs_>:
 258:	6170                	.insn	2, 0x6170
 25a:	696e                	.insn	2, 0x696e
 25c:	202d2063          	.insn	4, 0x202d2063
 260:	65766573          	csrrsi	a0,hviprio2h,12
 264:	6572                	.insn	2, 0x6572
 266:	6920                	.insn	2, 0x6920
 268:	746e                	.insn	2, 0x746e
 26a:	7265                	.insn	2, 0x7265
 26c:	616e                	.insn	2, 0x616e
 26e:	206c                	.insn	2, 0x206c
 270:	7265                	.insn	2, 0x7265
 272:	6f72                	.insn	2, 0x6f72
 274:	0072                	.insn	2, 0x0072
 276:	6c69                	.insn	2, 0x6c69
 278:	656c                	.insn	2, 0x656c
 27a:	202d2067          	.insn	4, 0x202d2067
 27e:	6c69                	.insn	2, 0x6c69
 280:	656c                	.insn	2, 0x656c
 282:	206c6167          	.insn	4, 0x206c6167
 286:	6e69                	.insn	2, 0x6e69
 288:	75727473          	csrrci	s0,0x757,4
 28c:	6f697463          	bgeu	s2,s6,974 <_end+0x4bc>
 290:	006e                	.insn	2, 0x006e
 292:	72657673          	csrrci	a2,mhpmevent6h,10
 296:	2072                	.insn	2, 0x2072
 298:	202d                	.insn	2, 0x202d
 29a:	65707573          	csrrci	a0,hviprio2h,0
 29e:	7672                	.insn	2, 0x7672
 2a0:	7369                	.insn	2, 0x7369
 2a2:	6520726f          	jal	ctxt,78f4 <_end+0x743c>
 2a6:	7272                	.insn	2, 0x7272
 2a8:	7300726f          	jal	ctxt,79d8 <_end+0x7520>
 2ac:	6574                	.insn	2, 0x6574
 2ae:	7272                	.insn	2, 0x7272
 2b0:	2d20                	.insn	2, 0x2d20
 2b2:	7320                	.insn	2, 0x7320
 2b4:	6174                	.insn	2, 0x6174
 2b6:	6574                	.insn	2, 0x6574
 2b8:	6520                	.insn	2, 0x6520
 2ba:	7272                	.insn	2, 0x7272
 2bc:	7000726f          	jal	ctxt,79bc <_end+0x7504>
 2c0:	6972                	.insn	2, 0x6972
 2c2:	7676                	.insn	2, 0x7676
 2c4:	2d20                	.insn	2, 0x2d20
 2c6:	7020                	.insn	2, 0x7020
 2c8:	6972                	.insn	2, 0x6972
 2ca:	6976                	.insn	2, 0x6976
 2cc:	656c                	.insn	2, 0x656c
 2ce:	64656467          	.insn	4, 0x64656467
 2d2:	6920                	.insn	2, 0x6920
 2d4:	736e                	.insn	2, 0x736e
 2d6:	7274                	.insn	2, 0x7274
 2d8:	6375                	.insn	2, 0x6375
 2da:	6974                	.insn	2, 0x6974
 2dc:	74006e6f          	jal	t3,6a1c <_end+0x6564>
 2e0:	6c696f63          	bltu	s2,t1,9be <_end+0x506>
 2e4:	2d20                	.insn	2, 0x2d20
 2e6:	7420                	.insn	2, 0x7420
 2e8:	7261                	.insn	2, 0x7261
 2ea:	20746567          	.insn	4, 0x20746567
 2ee:	65646f63          	bltu	s0,s6,94c <_end+0x494>
 2f2:	6920                	.insn	2, 0x6920
 2f4:	646e                	.insn	2, 0x646e
 2f6:	7865                	.insn	2, 0x7865
 2f8:	7400                	.insn	2, 0x7400
 2fa:	626f6963          	bltu	t5,t1,92c <_end+0x474>
 2fe:	2d20                	.insn	2, 0x2d20
 300:	7420                	.insn	2, 0x7420
 302:	7261                	.insn	2, 0x7261
 304:	20746567          	.insn	4, 0x20746567
 308:	65646f63          	bltu	s0,s6,966 <_end+0x4ae>
 30c:	6920                	.insn	2, 0x6920
 30e:	646e                	.insn	2, 0x646e
 310:	7865                	.insn	2, 0x7865
 312:	6f20                	.insn	2, 0x6f20
 314:	7475                	.insn	2, 0x7475
 316:	6f20                	.insn	2, 0x6f20
 318:	2066                	.insn	2, 0x2066
 31a:	6f62                	.insn	2, 0x6f62
 31c:	6e75                	.insn	2, 0x6e75
 31e:	0064                	.insn	2, 0x0064
 320:	6e65                	.insn	2, 0x6e65
 322:	6f64                	.insn	2, 0x6f64
 324:	202d2063          	.insn	4, 0x202d2063
 328:	6e65                	.insn	2, 0x6e65
 32a:	2064                	.insn	2, 0x2064
 32c:	6320666f          	jal	a2,695e <_end+0x64a6>
 330:	0065646f          	jal	s0,56336 <_end+0x55e7e>
 334:	6972                	.insn	2, 0x6972
 336:	6578                	.insn	2, 0x6578
 338:	2071                	.insn	2, 0x2071
 33a:	202d                	.insn	2, 0x202d
 33c:	6572                	.insn	2, 0x6572
 33e:	7574                	.insn	2, 0x7574
 340:	6e72                	.insn	2, 0x6e72
 342:	6920                	.insn	2, 0x6920
 344:	646e                	.insn	2, 0x646e
 346:	7865                	.insn	2, 0x7865
 348:	6920                	.insn	2, 0x6920
 34a:	657a2073          	csrrs	zero,hviprio2h,s4
 34e:	6f72                	.insn	2, 0x6f72
 350:	7200                	.insn	2, 0x7200
 352:	756e6463          	bltu	t3,s6,a9a <_end+0x5e2>
 356:	2d20                	.insn	2, 0x2d20
 358:	7220                	.insn	2, 0x7220
 35a:	7465                	.insn	2, 0x7465
 35c:	7275                	.insn	2, 0x7275
 35e:	206e                	.insn	2, 0x206e
 360:	65646f63          	bltu	s0,s6,9be <_end+0x506>
 364:	6920                	.insn	2, 0x6920
 366:	756e2073          	csrrs	zero,0x756,t3
 36a:	6c6c                	.insn	2, 0x6c6c
 36c:	7200                	.insn	2, 0x7200
 36e:	636e6463          	bltu	t3,s6,996 <_end+0x4de>
 372:	2d20                	.insn	2, 0x2d20
 374:	7220                	.insn	2, 0x7220
 376:	7465                	.insn	2, 0x7465
 378:	7275                	.insn	2, 0x7275
 37a:	206e                	.insn	2, 0x206e
 37c:	65646f63          	bltu	s0,s6,9da <_end+0x522>
 380:	7020                	.insn	2, 0x7020
 382:	7274                	.insn	2, 0x7274
 384:	6920                	.insn	2, 0x6920
 386:	6f6e2073          	csrrs	zero,0x6f6,t3
 38a:	2074                	.insn	2, 0x2074
 38c:	2061                	.insn	2, 0x2061
 38e:	65646f63          	bltu	s0,s6,9ec <_end+0x534>
 392:	7020                	.insn	2, 0x7020
 394:	7274                	.insn	2, 0x7274
 396:	6400                	.insn	2, 0x6400
 398:	6672                	.insn	2, 0x6672
 39a:	756e                	.insn	2, 0x756e
 39c:	2d20                	.insn	2, 0x2d20
 39e:	6420                	.insn	2, 0x6420
 3a0:	7265                	.insn	2, 0x7265
 3a2:	6665                	.insn	2, 0x6665
 3a4:	7265                	.insn	2, 0x7265
 3a6:	6e65                	.insn	2, 0x6e65
 3a8:	20646563          	bltu	s0,t1,5b2 <_end+0xfa>
 3ac:	756e                	.insn	2, 0x756e
 3ae:	6c6c                	.insn	2, 0x6c6c
 3b0:	7020                	.insn	2, 0x7020
 3b2:	746e696f          	jal	s2,e6af8 <_end+0xe6640>
 3b6:	7265                	.insn	2, 0x7265
 3b8:	6400                	.insn	2, 0x6400
 3ba:	6672                	.insn	2, 0x6672
 3bc:	2d206463          	bltu	zero,s2,684 <_end+0x1cc>
 3c0:	6420                	.insn	2, 0x6420
 3c2:	7265                	.insn	2, 0x7265
 3c4:	6665                	.insn	2, 0x6665
 3c6:	7265                	.insn	2, 0x7265
 3c8:	6e65                	.insn	2, 0x6e65
 3ca:	20646563          	bltu	s0,t1,5d4 <_end+0x11c>
 3ce:	65646f63          	bltu	s0,s6,a2c <_end+0x574>
 3d2:	7020                	.insn	2, 0x7020
 3d4:	746e696f          	jal	s2,e6b1a <_end+0xe6662>
 3d8:	7265                	.insn	2, 0x7265
 3da:	7700                	.insn	2, 0x7700
 3dc:	7072                	.insn	2, 0x7072
 3de:	7674                	.insn	2, 0x7674
 3e0:	2d20                	.insn	2, 0x2d20
 3e2:	7720                	.insn	2, 0x7720
 3e4:	6f72                	.insn	2, 0x6f72
 3e6:	6574                	.insn	2, 0x6574
 3e8:	7520                	.insn	2, 0x7520
 3ea:	676e6973          	csrrsi	s2,0x676,28
 3ee:	7220                	.insn	2, 0x7220
 3f0:	6165                	.insn	2, 0x6165
 3f2:	2064                	.insn	2, 0x2064
 3f4:	796c6e6f          	jal	t3,c6b8a <_end+0xc66d2>
 3f8:	7020                	.insn	2, 0x7020
 3fa:	746e696f          	jal	s2,e6b40 <_end+0xe6688>
 3fe:	7265                	.insn	2, 0x7265
 400:	7300                	.insn	2, 0x7300
 402:	6165                	.insn	2, 0x6165
 404:	766c                	.insn	2, 0x766c
 406:	2d20                	.insn	2, 0x2d20
 408:	7720                	.insn	2, 0x7720
 40a:	6f72                	.insn	2, 0x6f72
 40c:	6574                	.insn	2, 0x6574
 40e:	7420                	.insn	2, 0x7420
 410:	6572206f          	jal	zero,23266 <_end+0x22dae>
 414:	6461                	.insn	2, 0x6461
 416:	6f20                	.insn	2, 0x6f20
 418:	6c6e                	.insn	2, 0x6c6e
 41a:	2079                	.insn	2, 0x2079
 41c:	656a626f          	jal	ctxt,a6a72 <_end+0xa65ba>
 420:	69007463          	bgeu	zero,a6,aa8 <_end+0x5f0>
 424:	6f78                	.insn	2, 0x6f78
 426:	2d20626f          	jal	ctxt,66f8 <_end+0x6240>
 42a:	6920                	.insn	2, 0x6920
 42c:	646e                	.insn	2, 0x646e
 42e:	7865                	.insn	2, 0x7865
 430:	6f20                	.insn	2, 0x6f20
 432:	7475                	.insn	2, 0x7475
 434:	6f20                	.insn	2, 0x6f20
 436:	2066                	.insn	2, 0x2066
 438:	6f62                	.insn	2, 0x6f62
 43a:	6e75                	.insn	2, 0x6e75
 43c:	7364                	.insn	2, 0x7364
 43e:	6600                	.insn	2, 0x6600
 440:	7472                	.insn	2, 0x7472
 442:	7079                	.insn	2, 0x7079
 444:	2d20                	.insn	2, 0x2d20
 446:	6620                	.insn	2, 0x6620
 448:	6172                	.insn	2, 0x6172
 44a:	656d                	.insn	2, 0x656d
 44c:	7420                	.insn	2, 0x7420
 44e:	7079                	.insn	2, 0x7079
 450:	0065                	.insn	2, 0x0065
 452:	7061                	.insn	2, 0x7061
 454:	7265                	.insn	2, 0x7265
 456:	2072                	.insn	2, 0x2072
 458:	202d                	.insn	2, 0x202d
 45a:	003f3f3f 766f7068 	.insn	8, 0x766f7068003f3f3f
 462:	2066                	.insn	2, 0x2066
 464:	202d                	.insn	2, 0x202d
 466:	6568                	.insn	2, 0x6568
 468:	7061                	.insn	2, 0x7061
 46a:	6620                	.insn	2, 0x6620
 46c:	6c75                	.insn	2, 0x6c75
 46e:	006c                	.insn	2, 0x006c
 470:	766f7473          	csrrci	s0,0x766,30
 474:	2066                	.insn	2, 0x2066
 476:	202d                	.insn	2, 0x202d
 478:	63617473          	csrrci	s0,0x636,2
 47c:	766f206b          	.insn	4, 0x766f206b
 480:	7265                	.insn	2, 0x7265
 482:	6c66                	.insn	2, 0x6c66
 484:	7000776f          	jal	a4,7b84 <_end+0x76cc>
 488:	6174                	.insn	2, 0x6174
 48a:	6972                	.insn	2, 0x6972
 48c:	2d20                	.insn	2, 0x2d20
 48e:	3f20                	.insn	2, 0x3f20
 490:	  	.insn	8, 0x3f3f

00000493 <exception_strs.end>:
 493:	0000                	.insn	2, 0x
 495:	0000                	.insn	2, 0x
	...

Disassembly of section hello_world_str:

00000498 <hello_world_str_-0x8>:
 498:	0000                	.insn	2, 0x
 49a:	0000                	.insn	2, 0x
 49c:	0015                	.insn	2, 0x0015
	...

000004a0 <hello_world_str_>:
 4a0:	6548                	.insn	2, 0x6548
 4a2:	6c6c                	.insn	2, 0x6c6c
 4a4:	7266206f          	jal	zero,62bca <_end+0x62712>
 4a8:	52206d6f          	jal	bm,69ca <_end+0x6512>
 4ac:	7369                	.insn	2, 0x7369
 4ae:	4f695663          	bge	s2,s6,99a <_end+0x4e2>
 4b2:	0a21                	.insn	2, 0x0a21
 4b4:	                	.insn	2, 0x000d

000004b5 <hello_world_str.end>:
 4b5:	0000                	.insn	2, 0x
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
  2a:	32727363          	bgeu	ctxt,t2,350 <exception_strs_+0xf8>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
