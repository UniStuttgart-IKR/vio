
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	0190                	.insn	2, 0x0190
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
  2c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x36d>
  30:	00000297          	auipc	t0,0x0
  34:	11c28293          	addi	t0,t0,284 # 14c <core.exc_handel>
  38:	30529073          	csrrw	zero,mtvec,t0
  3c:	01020337          	lui	t1,0x1020
  40:	30430313          	addi	t1,t1,772 # 1020304 <_end+0x101fe6c>
  44:	000083b7          	lui	t2,0x8
  48:	00538393          	addi	t2,t2,5 # 8005 <_end+0x7b6d>
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
  84:	00100313          	addi	t1,zero,1
  88:	00600393          	addi	t2,zero,6
  8c:	fe7305f3          	ciop	a1,t1,t2
  90:	47800513          	addi	a0,zero,1144
  94:	fd050573          	ccp	a0,a0
  98:	048000ef          	jal	ra,e0 <core.out_str>
  9c:	00000013          	addi	zero,zero,0
  a0:	00000013          	addi	zero,zero,0
  a4:	00100073          	ebreak
  a8:	0031708b          	push	1,0
  ac:	0011100b          	sp	ra,0(frame)
  b0:	00000517          	auipc	a0,0x0
  b4:	14850513          	addi	a0,a0,328 # 1f8 <usb.end+0x4>
  b8:	fd050573          	ccp	a0,a0
  bc:	00000417          	auipc	s0,0x0
  c0:	0ec40413          	addi	s0,s0,236 # 1a8 <core.end+0xc>
  c4:	fd040473          	ccp	s0,s0
  c8:	00040493          	addi	s1,s0,0
  cc:	0091100b          	sp	s1,0(frame)
  d0:	000400e7          	jalr	ra,0(s0)
  d4:	0001240b          	lp	s0,0(frame)
  d8:	004400e7          	jalr	ra,4(s0)
  dc:	00100073          	ebreak

000000e0 <core.out_str>:
  e0:	02050063          	beq	a0,zero,100 <.done>
  e4:	0805028b          	qdtb	t0,a0
  e8:	00028c63          	beq	t0,zero,100 <.done>
  ec:	00000313          	addi	t1,zero,0

000000f0 <.outloop>:
  f0:	80657383          	lbu.r	t2,t1(a0)
  f4:	00758023          	sb	t2,0(a1)
  f8:	00130313          	addi	t1,t1,1
  fc:	fe531ae3          	bne	t1,t0,f0 <.outloop>

00000100 <.done>:
 100:	00008067          	jalr	zero,0(ra)

00000104 <core.out_str_zero>:
 104:	04050263          	beq	a0,zero,148 <.donez>
 108:	0805028b          	qdtb	t0,a0
 10c:	02028e63          	beq	t0,zero,148 <.donez>
 110:	00000313          	addi	t1,zero,0
 114:	00160613          	addi	a2,a2,1

00000118 <.srcloop>:
 118:	80657383          	lbu.r	t2,t1(a0)
 11c:	00039a63          	bne	t2,zero,130 <.notzero>
 120:	fff60613          	addi	a2,a2,-1
 124:	00130313          	addi	t1,t1,1
 128:	fc0604e3          	beq	a2,zero,f0 <.outloop>
 12c:	fff30313          	addi	t1,t1,-1

00000130 <.notzero>:
 130:	00130313          	addi	t1,t1,1
 134:	fe5ff06f          	jal	zero,118 <.srcloop>

00000138 <.outloopz>:
 138:	80657383          	lbu.r	t2,t1(a0)
 13c:	00758023          	sb	t2,0(a1)
 140:	00130313          	addi	t1,t1,1
 144:	fe039ae3          	bne	t2,zero,138 <.outloopz>

00000148 <.donez>:
 148:	00008067          	jalr	zero,0(ra)

0000014c <core.exc_handel>:
 14c:	00000013          	addi	zero,zero,0
 150:	00000013          	addi	zero,zero,0
 154:	00000013          	addi	zero,zero,0
 158:	00100313          	addi	t1,zero,1
 15c:	00600393          	addi	t2,zero,6
 160:	fe7305f3          	ciop	a1,t1,t2
 164:	21000513          	addi	a0,zero,528
 168:	fd050573          	ccp	a0,a0
 16c:	f75ff0ef          	jal	ra,e0 <core.out_str>
 170:	23000513          	addi	a0,zero,560
 174:	fd050573          	ccp	a0,a0
 178:	34202673          	csrrs	a2,mcause,zero
 17c:	f89ff0ef          	jal	ra,104 <core.out_str_zero>
 180:	00000013          	addi	zero,zero,0
 184:	00000013          	addi	zero,zero,0
 188:	00000013          	addi	zero,zero,0
 18c:	00000013          	addi	zero,zero,0
 190:	30200073          	mret
 194:	ffb28293          	addi	t0,t0,-5
 198:	ff730313          	addi	t1,t1,-9

0000019c <core.end>:
 19c:	00000013          	addi	zero,zero,0
 1a0:	0000                	.insn	2, 0x
	...

Disassembly of section usb:

000001a8 <usb.af_-0x8>:
 1a8:	0008                	.insn	2, 0x0008
 1aa:	0000                	.insn	2, 0x
 1ac:	0040                	.insn	2, 0x0040
	...

000001b0 <usb.af_>:
 1b0:	0080006f          	jal	zero,1b8 <usb.af>

000001b4 <usb.b_>:
 1b4:	0100006f          	jal	zero,1c4 <usb.b>

000001b8 <usb.af>:
 1b8:	00230293          	addi	t0,t1,2
 1bc:	005e8e13          	addi	t3,t4,5
 1c0:	00008067          	jalr	zero,0(ra)

000001c4 <usb.b>:
 1c4:	0031700b          	push	0,0
 1c8:	0011100b          	sp	ra,0(frame)
 1cc:	010000ef          	jal	ra,1dc <usb.c>
 1d0:	0001208b          	lp	ra,0(frame)
 1d4:	1800000b          	pop
 1d8:	00008067          	jalr	zero,0(ra)

000001dc <usb.c>:
 1dc:	0031700b          	push	0,0
 1e0:	0011100b          	sp	ra,0(frame)
 1e4:	000500e7          	jalr	ra,0(a0)
 1e8:	0001208b          	lp	ra,0(frame)
 1ec:	1800000b          	pop
 1f0:	00008067          	jalr	zero,0(ra)

000001f4 <usb.end>:
 1f4:	00000013          	addi	zero,zero,0

Disassembly of section hdmi:

000001f8 <hdmi.s_-0x8>:
 1f8:	0004                	.insn	2, 0x0004
 1fa:	0000                	.insn	2, 0x
 1fc:	000c                	.insn	2, 0x000c
	...

00000200 <hdmi.s_>:
 200:	0040006f          	jal	zero,204 <hdmi.s>

00000204 <hdmi.s>:
 204:	00230293          	addi	t0,t1,2
 208:	005e8e13          	addi	t3,t4,5
 20c:	00008067          	jalr	zero,0(ra)

Disassembly of section exception_hdr_str:

00000210 <exception_hdr_str_-0x8>:
 210:	0000                	.insn	2, 0x
 212:	0000                	.insn	2, 0x
 214:	0016                	.insn	2, 0x0016
	...

00000218 <exception_hdr_str_>:
 218:	6e41                	.insn	2, 0x6e41
 21a:	4520                	.insn	2, 0x4520
 21c:	6378                	.insn	2, 0x6378
 21e:	7065                	.insn	2, 0x7065
 220:	6974                	.insn	2, 0x6974
 222:	6f206e6f          	jal	t3,6914 <_end+0x647c>
 226:	72756363          	bltu	a0,t2,94c <_end+0x4b4>
 22a:	6465                	.insn	2, 0x6465
 22c:	203a                	.insn	2, 0x203a

0000022e <exception_hdr_str.end>:
	...

Disassembly of section exception_strs:

00000230 <exception_strs_-0x8>:
 230:	0000                	.insn	2, 0x
 232:	0000                	.insn	2, 0x
 234:	0000023b          	.insn	4, 0x023b

00000238 <exception_strs_>:
 238:	6170                	.insn	2, 0x6170
 23a:	696e                	.insn	2, 0x696e
 23c:	202d2063          	.insn	4, 0x202d2063
 240:	65766573          	csrrsi	a0,hviprio2h,12
 244:	6572                	.insn	2, 0x6572
 246:	6920                	.insn	2, 0x6920
 248:	746e                	.insn	2, 0x746e
 24a:	7265                	.insn	2, 0x7265
 24c:	616e                	.insn	2, 0x616e
 24e:	206c                	.insn	2, 0x206c
 250:	7265                	.insn	2, 0x7265
 252:	6f72                	.insn	2, 0x6f72
 254:	0072                	.insn	2, 0x0072
 256:	6c69                	.insn	2, 0x6c69
 258:	656c                	.insn	2, 0x656c
 25a:	202d2067          	.insn	4, 0x202d2067
 25e:	6c69                	.insn	2, 0x6c69
 260:	656c                	.insn	2, 0x656c
 262:	206c6167          	.insn	4, 0x206c6167
 266:	6e69                	.insn	2, 0x6e69
 268:	75727473          	csrrci	s0,0x757,4
 26c:	6f697463          	bgeu	s2,s6,954 <_end+0x4bc>
 270:	006e                	.insn	2, 0x006e
 272:	72657673          	csrrci	a2,mhpmevent6h,10
 276:	2072                	.insn	2, 0x2072
 278:	202d                	.insn	2, 0x202d
 27a:	65707573          	csrrci	a0,hviprio2h,0
 27e:	7672                	.insn	2, 0x7672
 280:	7369                	.insn	2, 0x7369
 282:	6520726f          	jal	ctxt,78d4 <_end+0x743c>
 286:	7272                	.insn	2, 0x7272
 288:	7300726f          	jal	ctxt,79b8 <_end+0x7520>
 28c:	6574                	.insn	2, 0x6574
 28e:	7272                	.insn	2, 0x7272
 290:	2d20                	.insn	2, 0x2d20
 292:	7320                	.insn	2, 0x7320
 294:	6174                	.insn	2, 0x6174
 296:	6574                	.insn	2, 0x6574
 298:	6520                	.insn	2, 0x6520
 29a:	7272                	.insn	2, 0x7272
 29c:	7000726f          	jal	ctxt,799c <_end+0x7504>
 2a0:	6972                	.insn	2, 0x6972
 2a2:	7676                	.insn	2, 0x7676
 2a4:	2d20                	.insn	2, 0x2d20
 2a6:	7020                	.insn	2, 0x7020
 2a8:	6972                	.insn	2, 0x6972
 2aa:	6976                	.insn	2, 0x6976
 2ac:	656c                	.insn	2, 0x656c
 2ae:	64656467          	.insn	4, 0x64656467
 2b2:	6920                	.insn	2, 0x6920
 2b4:	736e                	.insn	2, 0x736e
 2b6:	7274                	.insn	2, 0x7274
 2b8:	6375                	.insn	2, 0x6375
 2ba:	6974                	.insn	2, 0x6974
 2bc:	74006e6f          	jal	t3,69fc <_end+0x6564>
 2c0:	6c696f63          	bltu	s2,t1,99e <_end+0x506>
 2c4:	2d20                	.insn	2, 0x2d20
 2c6:	7420                	.insn	2, 0x7420
 2c8:	7261                	.insn	2, 0x7261
 2ca:	20746567          	.insn	4, 0x20746567
 2ce:	65646f63          	bltu	s0,s6,92c <_end+0x494>
 2d2:	6920                	.insn	2, 0x6920
 2d4:	646e                	.insn	2, 0x646e
 2d6:	7865                	.insn	2, 0x7865
 2d8:	7400                	.insn	2, 0x7400
 2da:	626f6963          	bltu	t5,t1,90c <_end+0x474>
 2de:	2d20                	.insn	2, 0x2d20
 2e0:	7420                	.insn	2, 0x7420
 2e2:	7261                	.insn	2, 0x7261
 2e4:	20746567          	.insn	4, 0x20746567
 2e8:	65646f63          	bltu	s0,s6,946 <_end+0x4ae>
 2ec:	6920                	.insn	2, 0x6920
 2ee:	646e                	.insn	2, 0x646e
 2f0:	7865                	.insn	2, 0x7865
 2f2:	6f20                	.insn	2, 0x6f20
 2f4:	7475                	.insn	2, 0x7475
 2f6:	6f20                	.insn	2, 0x6f20
 2f8:	2066                	.insn	2, 0x2066
 2fa:	6f62                	.insn	2, 0x6f62
 2fc:	6e75                	.insn	2, 0x6e75
 2fe:	0064                	.insn	2, 0x0064
 300:	6e65                	.insn	2, 0x6e65
 302:	6f64                	.insn	2, 0x6f64
 304:	202d2063          	.insn	4, 0x202d2063
 308:	6e65                	.insn	2, 0x6e65
 30a:	2064                	.insn	2, 0x2064
 30c:	6320666f          	jal	a2,693e <_end+0x64a6>
 310:	0065646f          	jal	s0,56316 <_end+0x55e7e>
 314:	6972                	.insn	2, 0x6972
 316:	6578                	.insn	2, 0x6578
 318:	2071                	.insn	2, 0x2071
 31a:	202d                	.insn	2, 0x202d
 31c:	6572                	.insn	2, 0x6572
 31e:	7574                	.insn	2, 0x7574
 320:	6e72                	.insn	2, 0x6e72
 322:	6920                	.insn	2, 0x6920
 324:	646e                	.insn	2, 0x646e
 326:	7865                	.insn	2, 0x7865
 328:	6920                	.insn	2, 0x6920
 32a:	657a2073          	csrrs	zero,hviprio2h,s4
 32e:	6f72                	.insn	2, 0x6f72
 330:	7200                	.insn	2, 0x7200
 332:	756e6463          	bltu	t3,s6,a7a <_end+0x5e2>
 336:	2d20                	.insn	2, 0x2d20
 338:	7220                	.insn	2, 0x7220
 33a:	7465                	.insn	2, 0x7465
 33c:	7275                	.insn	2, 0x7275
 33e:	206e                	.insn	2, 0x206e
 340:	65646f63          	bltu	s0,s6,99e <_end+0x506>
 344:	6920                	.insn	2, 0x6920
 346:	756e2073          	csrrs	zero,0x756,t3
 34a:	6c6c                	.insn	2, 0x6c6c
 34c:	7200                	.insn	2, 0x7200
 34e:	636e6463          	bltu	t3,s6,976 <_end+0x4de>
 352:	2d20                	.insn	2, 0x2d20
 354:	7220                	.insn	2, 0x7220
 356:	7465                	.insn	2, 0x7465
 358:	7275                	.insn	2, 0x7275
 35a:	206e                	.insn	2, 0x206e
 35c:	65646f63          	bltu	s0,s6,9ba <_end+0x522>
 360:	7020                	.insn	2, 0x7020
 362:	7274                	.insn	2, 0x7274
 364:	6920                	.insn	2, 0x6920
 366:	6f6e2073          	csrrs	zero,0x6f6,t3
 36a:	2074                	.insn	2, 0x2074
 36c:	2061                	.insn	2, 0x2061
 36e:	65646f63          	bltu	s0,s6,9cc <_end+0x534>
 372:	7020                	.insn	2, 0x7020
 374:	7274                	.insn	2, 0x7274
 376:	6400                	.insn	2, 0x6400
 378:	6672                	.insn	2, 0x6672
 37a:	756e                	.insn	2, 0x756e
 37c:	2d20                	.insn	2, 0x2d20
 37e:	6420                	.insn	2, 0x6420
 380:	7265                	.insn	2, 0x7265
 382:	6665                	.insn	2, 0x6665
 384:	7265                	.insn	2, 0x7265
 386:	6e65                	.insn	2, 0x6e65
 388:	20646563          	bltu	s0,t1,592 <_end+0xfa>
 38c:	756e                	.insn	2, 0x756e
 38e:	6c6c                	.insn	2, 0x6c6c
 390:	7020                	.insn	2, 0x7020
 392:	746e696f          	jal	s2,e6ad8 <_end+0xe6640>
 396:	7265                	.insn	2, 0x7265
 398:	6400                	.insn	2, 0x6400
 39a:	6672                	.insn	2, 0x6672
 39c:	2d206463          	bltu	zero,s2,664 <_end+0x1cc>
 3a0:	6420                	.insn	2, 0x6420
 3a2:	7265                	.insn	2, 0x7265
 3a4:	6665                	.insn	2, 0x6665
 3a6:	7265                	.insn	2, 0x7265
 3a8:	6e65                	.insn	2, 0x6e65
 3aa:	20646563          	bltu	s0,t1,5b4 <_end+0x11c>
 3ae:	65646f63          	bltu	s0,s6,a0c <_end+0x574>
 3b2:	7020                	.insn	2, 0x7020
 3b4:	746e696f          	jal	s2,e6afa <_end+0xe6662>
 3b8:	7265                	.insn	2, 0x7265
 3ba:	7700                	.insn	2, 0x7700
 3bc:	7072                	.insn	2, 0x7072
 3be:	7674                	.insn	2, 0x7674
 3c0:	2d20                	.insn	2, 0x2d20
 3c2:	7720                	.insn	2, 0x7720
 3c4:	6f72                	.insn	2, 0x6f72
 3c6:	6574                	.insn	2, 0x6574
 3c8:	7520                	.insn	2, 0x7520
 3ca:	676e6973          	csrrsi	s2,0x676,28
 3ce:	7220                	.insn	2, 0x7220
 3d0:	6165                	.insn	2, 0x6165
 3d2:	2064                	.insn	2, 0x2064
 3d4:	796c6e6f          	jal	t3,c6b6a <_end+0xc66d2>
 3d8:	7020                	.insn	2, 0x7020
 3da:	746e696f          	jal	s2,e6b20 <_end+0xe6688>
 3de:	7265                	.insn	2, 0x7265
 3e0:	7300                	.insn	2, 0x7300
 3e2:	6165                	.insn	2, 0x6165
 3e4:	766c                	.insn	2, 0x766c
 3e6:	2d20                	.insn	2, 0x2d20
 3e8:	7720                	.insn	2, 0x7720
 3ea:	6f72                	.insn	2, 0x6f72
 3ec:	6574                	.insn	2, 0x6574
 3ee:	7420                	.insn	2, 0x7420
 3f0:	6572206f          	jal	zero,23246 <_end+0x22dae>
 3f4:	6461                	.insn	2, 0x6461
 3f6:	6f20                	.insn	2, 0x6f20
 3f8:	6c6e                	.insn	2, 0x6c6e
 3fa:	2079                	.insn	2, 0x2079
 3fc:	656a626f          	jal	ctxt,a6a52 <_end+0xa65ba>
 400:	69007463          	bgeu	zero,a6,a88 <_end+0x5f0>
 404:	6f78                	.insn	2, 0x6f78
 406:	2d20626f          	jal	ctxt,66d8 <_end+0x6240>
 40a:	6920                	.insn	2, 0x6920
 40c:	646e                	.insn	2, 0x646e
 40e:	7865                	.insn	2, 0x7865
 410:	6f20                	.insn	2, 0x6f20
 412:	7475                	.insn	2, 0x7475
 414:	6f20                	.insn	2, 0x6f20
 416:	2066                	.insn	2, 0x2066
 418:	6f62                	.insn	2, 0x6f62
 41a:	6e75                	.insn	2, 0x6e75
 41c:	7364                	.insn	2, 0x7364
 41e:	6600                	.insn	2, 0x6600
 420:	7472                	.insn	2, 0x7472
 422:	7079                	.insn	2, 0x7079
 424:	2d20                	.insn	2, 0x2d20
 426:	6620                	.insn	2, 0x6620
 428:	6172                	.insn	2, 0x6172
 42a:	656d                	.insn	2, 0x656d
 42c:	7420                	.insn	2, 0x7420
 42e:	7079                	.insn	2, 0x7079
 430:	0065                	.insn	2, 0x0065
 432:	7061                	.insn	2, 0x7061
 434:	7265                	.insn	2, 0x7265
 436:	2072                	.insn	2, 0x2072
 438:	202d                	.insn	2, 0x202d
 43a:	003f3f3f 766f7068 	.insn	8, 0x766f7068003f3f3f
 442:	2066                	.insn	2, 0x2066
 444:	202d                	.insn	2, 0x202d
 446:	6568                	.insn	2, 0x6568
 448:	7061                	.insn	2, 0x7061
 44a:	6620                	.insn	2, 0x6620
 44c:	6c75                	.insn	2, 0x6c75
 44e:	006c                	.insn	2, 0x006c
 450:	766f7473          	csrrci	s0,0x766,30
 454:	2066                	.insn	2, 0x2066
 456:	202d                	.insn	2, 0x202d
 458:	63617473          	csrrci	s0,0x636,2
 45c:	766f206b          	.insn	4, 0x766f206b
 460:	7265                	.insn	2, 0x7265
 462:	6c66                	.insn	2, 0x6c66
 464:	7000776f          	jal	a4,7b64 <_end+0x76cc>
 468:	6174                	.insn	2, 0x6174
 46a:	6972                	.insn	2, 0x6972
 46c:	2d20                	.insn	2, 0x2d20
 46e:	3f20                	.insn	2, 0x3f20
 470:	  	.insn	8, 0x3f3f

00000473 <exception_strs.end>:
 473:	0000                	.insn	2, 0x
 475:	0000                	.insn	2, 0x
	...

Disassembly of section hello_world_str:

00000478 <hello_world_str_-0x8>:
 478:	0000                	.insn	2, 0x
 47a:	0000                	.insn	2, 0x
 47c:	0014                	.insn	2, 0x0014
	...

00000480 <hello_world_str_>:
 480:	6548                	.insn	2, 0x6548
 482:	6c6c                	.insn	2, 0x6c6c
 484:	7266206f          	jal	zero,62baa <_end+0x62712>
 488:	52206d6f          	jal	bm,69aa <_end+0x6512>
 48c:	7369                	.insn	2, 0x7369
 48e:	4f695663          	bge	s2,s6,97a <_end+0x4e2>
 492:	0a21                	.insn	2, 0x0a21

00000494 <hello_world_str.end>:
 494:	0000                	.insn	2, 0x
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
  2a:	32727363          	bgeu	ctxt,t2,350 <exception_strs_+0x118>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
