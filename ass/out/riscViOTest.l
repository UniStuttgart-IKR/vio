
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	00fc                	.insn	2, 0x00fc
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
  2c:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x3a8>
  30:	00000297          	auipc	t0,0x0
  34:	08028293          	addi	t0,t0,128 # b0 <core.exc_handel>
  38:	30529073          	csrrw	zero,mtvec,t0
  3c:	00000297          	auipc	t0,0x0
  40:	0d428293          	addi	t0,t0,212 # 110 <core.end+0x8>
  44:	fd0282f3          	ccp	t0,t0
  48:	1f800513          	addi	a0,zero,504
  4c:	fd050573          	ccp	a0,a0
  50:	00400593          	addi	a1,zero,4
  54:	000280e7          	jalr	ra,0(t0)
  58:	00100073          	ebreak
  5c:	00200313          	addi	t1,zero,2
  60:	00a00393          	addi	t2,zero,10
  64:	fe730973          	ciop	s2,t1,t2
  68:	00100993          	addi	s3,zero,1
  6c:	10000a13          	addi	s4,zero,256
  70:	00100313          	addi	t1,zero,1
  74:	00600393          	addi	t2,zero,6
  78:	fe7304f3          	ciop	s1,t1,t2
  7c:	44000513          	addi	a0,zero,1088
  80:	fd050473          	ccp	s0,a0

00000084 <core.init.loop>:
  84:	01390023          	sb	s3,0(s2)
  88:	00199993          	slli	s3,s3,0x1
  8c:	0149c463          	blt	s3,s4,94 <core.init.byteOk>
  90:	00100993          	addi	s3,zero,1

00000094 <core.init.byteOk>:
  94:	00000297          	auipc	t0,0x0
  98:	07c28293          	addi	t0,t0,124 # 110 <core.end+0x8>
  9c:	00040513          	addi	a0,s0,0
  a0:	00048593          	addi	a1,s1,0
  a4:	004280e7          	jalr	ra,4(t0)
  a8:	00100073          	ebreak
  ac:	fd9ff06f          	jal	zero,84 <core.init.loop>

000000b0 <core.exc_handel>:
  b0:	00000013          	addi	zero,zero,0
  b4:	00000013          	addi	zero,zero,0
  b8:	00000013          	addi	zero,zero,0
  bc:	00100313          	addi	t1,zero,1
  c0:	00600393          	addi	t2,zero,6
  c4:	fe7305f3          	ciop	a1,t1,t2
  c8:	00000417          	auipc	s0,0x0
  cc:	04840413          	addi	s0,s0,72 # 110 <core.end+0x8>
  d0:	1d800513          	addi	a0,zero,472
  d4:	fd050573          	ccp	a0,a0
  d8:	004400e7          	jalr	ra,4(s0)
  dc:	1f800513          	addi	a0,zero,504
  e0:	fd050573          	ccp	a0,a0
  e4:	34202673          	csrrs	a2,mcause,zero
  e8:	004400e7          	jalr	ra,4(s0)
  ec:	00000013          	addi	zero,zero,0
  f0:	00000013          	addi	zero,zero,0
  f4:	00000013          	addi	zero,zero,0
  f8:	00000013          	addi	zero,zero,0
  fc:	30200073          	mret
 100:	ffb28293          	addi	t0,t0,-5
 104:	ff730313          	addi	t1,t1,-9

00000108 <core.end>:
 108:	0000                	.insn	2, 0x
	...

Disassembly of section uart:

00000110 <uart.stringElOut_-0x8>:
 110:	0008                	.insn	2, 0x0008
 112:	0000                	.insn	2, 0x
 114:	00b4                	.insn	2, 0x00b4
	...

00000118 <uart.stringElOut_>:
 118:	0300006f          	jal	zero,148 <uart.stringElOut>

0000011c <uart.stringOut_>:
 11c:	07c0006f          	jal	zero,198 <uart.stringOut>

00000120 <uart.charOut>:
 120:	00100313          	addi	t1,zero,1
 124:	00600393          	addi	t2,zero,6
 128:	fe7302f3          	ciop	t0,t1,t2
 12c:	00a28023          	sb	a0,0(t0)
 130:	00008067          	jalr	zero,0(ra)

00000134 <uart.charIn>:
 134:	00100313          	addi	t1,zero,1
 138:	00600393          	addi	t2,zero,6
 13c:	fe7302f3          	ciop	t0,t1,t2
 140:	0002c503          	lbu	a0,0(t0)
 144:	00008067          	jalr	zero,0(ra)

00000148 <uart.stringElOut>:
 148:	00050893          	addi	a7,a0,0
 14c:	0808880b          	qdtb	a6,a7
 150:	ffc00793          	addi	a5,zero,-4
 154:	00000713          	addi	a4,zero,0

00000158 <uart.stringElOut.next>:
 158:	00478793          	addi	a5,a5,4
 15c:	0307da63          	bge	a5,a6,190 <uart.stringElOut.oob>
 160:	04f8f303          	lw.r	t1,a5(a7)
 164:	28735313          	orc.b	t1,t1
 168:	fff34313          	xori	t1,t1,-1

0000016c <uart.stringElOut.again>:
 16c:	fe0306e3          	beq	t1,zero,158 <uart.stringElOut.next>
 170:	60131393          	ctz	t2,t1
 174:	00838393          	addi	t2,t2,8
 178:	00735333          	srl	t1,t1,t2
 17c:	00170713          	addi	a4,a4,1
 180:	feb716e3          	bne	a4,a1,16c <uart.stringElOut.again>
 184:	0033d393          	srli	t2,t2,0x3
 188:	007785b3          	add	a1,a5,t2
 18c:	0180006f          	jal	zero,1a4 <uart.stringOutInt>

00000190 <uart.stringElOut.oob>:
 190:	fff00593          	addi	a1,zero,-1
 194:	00008067          	jalr	zero,0(ra)

00000198 <uart.stringOut>:
 198:	00000593          	addi	a1,zero,0
 19c:	00050893          	addi	a7,a0,0
 1a0:	0808880b          	qdtb	a6,a7

000001a4 <uart.stringOutInt>:
 1a4:	0031700b          	push	0,0
 1a8:	0011100b          	sp	ra,0(frame)

000001ac <uart.stringOutInt.nxt>:
 1ac:	01058c63          	beq	a1,a6,1c4 <uart.stringOutInt.end>
 1b0:	80b8f503          	lbu.r	a0,a1(a7)
 1b4:	00050863          	beq	a0,zero,1c4 <uart.stringOutInt.end>
 1b8:	f69ff0ef          	jal	ra,120 <uart.charOut>
 1bc:	00158593          	addi	a1,a1,1
 1c0:	fedff06f          	jal	zero,1ac <uart.stringOutInt.nxt>

000001c4 <uart.stringOutInt.end>:
 1c4:	0001208b          	lp	ra,0(frame)
 1c8:	1800000b          	pop
 1cc:	00008067          	jalr	zero,0(ra)

000001d0 <uart.end>:
 1d0:	0000                	.insn	2, 0x
	...

Disassembly of section exception_hdr_str:

000001d8 <exception_hdr_str_-0x8>:
 1d8:	0000                	.insn	2, 0x
 1da:	0000                	.insn	2, 0x
 1dc:	0016                	.insn	2, 0x0016
	...

000001e0 <exception_hdr_str_>:
 1e0:	6e41                	.insn	2, 0x6e41
 1e2:	4520                	.insn	2, 0x4520
 1e4:	6378                	.insn	2, 0x6378
 1e6:	7065                	.insn	2, 0x7065
 1e8:	6974                	.insn	2, 0x6974
 1ea:	6f206e6f          	jal	t3,68dc <_end+0x647f>
 1ee:	72756363          	bltu	a0,t2,914 <_end+0x4b7>
 1f2:	6465                	.insn	2, 0x6465
 1f4:	203a                	.insn	2, 0x203a

000001f6 <exception_hdr_str.end>:
	...

Disassembly of section exceptionStrs:

000001f8 <exceptionStrs_-0x8>:
 1f8:	0000                	.insn	2, 0x
 1fa:	0000                	.insn	2, 0x
 1fc:	0000023f  	.insn	8, 0x696e61700000023f

00000200 <exceptionStrs_>:
 200:	6170                	.insn	2, 0x6170
 202:	696e                	.insn	2, 0x696e
 204:	202d2063          	.insn	4, 0x202d2063
 208:	65766573          	csrrsi	a0,hviprio2h,12
 20c:	6572                	.insn	2, 0x6572
 20e:	6920                	.insn	2, 0x6920
 210:	746e                	.insn	2, 0x746e
 212:	7265                	.insn	2, 0x7265
 214:	616e                	.insn	2, 0x616e
 216:	206c                	.insn	2, 0x206c
 218:	7265                	.insn	2, 0x7265
 21a:	6f72                	.insn	2, 0x6f72
 21c:	0072                	.insn	2, 0x0072
 21e:	6c69                	.insn	2, 0x6c69
 220:	656c                	.insn	2, 0x656c
 222:	202d2067          	.insn	4, 0x202d2067
 226:	6c69                	.insn	2, 0x6c69
 228:	656c                	.insn	2, 0x656c
 22a:	206c6167          	.insn	4, 0x206c6167
 22e:	6e69                	.insn	2, 0x6e69
 230:	75727473          	csrrci	s0,0x757,4
 234:	6f697463          	bgeu	s2,s6,91c <_end+0x4bf>
 238:	006e                	.insn	2, 0x006e
 23a:	72657673          	csrrci	a2,mhpmevent6h,10
 23e:	2072                	.insn	2, 0x2072
 240:	202d                	.insn	2, 0x202d
 242:	65707573          	csrrci	a0,hviprio2h,0
 246:	7672                	.insn	2, 0x7672
 248:	7369                	.insn	2, 0x7369
 24a:	6520726f          	jal	ctxt,789c <_end+0x743f>
 24e:	7272                	.insn	2, 0x7272
 250:	7300726f          	jal	ctxt,7980 <_end+0x7523>
 254:	6574                	.insn	2, 0x6574
 256:	7272                	.insn	2, 0x7272
 258:	2d20                	.insn	2, 0x2d20
 25a:	7320                	.insn	2, 0x7320
 25c:	6174                	.insn	2, 0x6174
 25e:	6574                	.insn	2, 0x6574
 260:	6520                	.insn	2, 0x6520
 262:	7272                	.insn	2, 0x7272
 264:	7000726f          	jal	ctxt,7964 <_end+0x7507>
 268:	6972                	.insn	2, 0x6972
 26a:	7676                	.insn	2, 0x7676
 26c:	2d20                	.insn	2, 0x2d20
 26e:	7020                	.insn	2, 0x7020
 270:	6972                	.insn	2, 0x6972
 272:	6976                	.insn	2, 0x6976
 274:	656c                	.insn	2, 0x656c
 276:	64656467          	.insn	4, 0x64656467
 27a:	6920                	.insn	2, 0x6920
 27c:	736e                	.insn	2, 0x736e
 27e:	7274                	.insn	2, 0x7274
 280:	6375                	.insn	2, 0x6375
 282:	6974                	.insn	2, 0x6974
 284:	74006e6f          	jal	t3,69c4 <_end+0x6567>
 288:	6c696f63          	bltu	s2,t1,966 <_end+0x509>
 28c:	2d20                	.insn	2, 0x2d20
 28e:	7420                	.insn	2, 0x7420
 290:	7261                	.insn	2, 0x7261
 292:	20746567          	.insn	4, 0x20746567
 296:	65646f63          	bltu	s0,s6,8f4 <_end+0x497>
 29a:	6920                	.insn	2, 0x6920
 29c:	646e                	.insn	2, 0x646e
 29e:	7865                	.insn	2, 0x7865
 2a0:	7400                	.insn	2, 0x7400
 2a2:	626f6963          	bltu	t5,t1,8d4 <_end+0x477>
 2a6:	2d20                	.insn	2, 0x2d20
 2a8:	7420                	.insn	2, 0x7420
 2aa:	7261                	.insn	2, 0x7261
 2ac:	20746567          	.insn	4, 0x20746567
 2b0:	65646f63          	bltu	s0,s6,90e <_end+0x4b1>
 2b4:	6920                	.insn	2, 0x6920
 2b6:	646e                	.insn	2, 0x646e
 2b8:	7865                	.insn	2, 0x7865
 2ba:	6f20                	.insn	2, 0x6f20
 2bc:	7475                	.insn	2, 0x7475
 2be:	6f20                	.insn	2, 0x6f20
 2c0:	2066                	.insn	2, 0x2066
 2c2:	6f62                	.insn	2, 0x6f62
 2c4:	6e75                	.insn	2, 0x6e75
 2c6:	0064                	.insn	2, 0x0064
 2c8:	6e65                	.insn	2, 0x6e65
 2ca:	6f64                	.insn	2, 0x6f64
 2cc:	202d2063          	.insn	4, 0x202d2063
 2d0:	6e65                	.insn	2, 0x6e65
 2d2:	2064                	.insn	2, 0x2064
 2d4:	6320666f          	jal	a2,6906 <_end+0x64a9>
 2d8:	0065646f          	jal	s0,562de <_end+0x55e81>
 2dc:	6972                	.insn	2, 0x6972
 2de:	6578                	.insn	2, 0x6578
 2e0:	2071                	.insn	2, 0x2071
 2e2:	202d                	.insn	2, 0x202d
 2e4:	6572                	.insn	2, 0x6572
 2e6:	7574                	.insn	2, 0x7574
 2e8:	6e72                	.insn	2, 0x6e72
 2ea:	6920                	.insn	2, 0x6920
 2ec:	646e                	.insn	2, 0x646e
 2ee:	7865                	.insn	2, 0x7865
 2f0:	6920                	.insn	2, 0x6920
 2f2:	657a2073          	csrrs	zero,hviprio2h,s4
 2f6:	6f72                	.insn	2, 0x6f72
 2f8:	7200                	.insn	2, 0x7200
 2fa:	756e6463          	bltu	t3,s6,a42 <_end+0x5e5>
 2fe:	2d20                	.insn	2, 0x2d20
 300:	7220                	.insn	2, 0x7220
 302:	7465                	.insn	2, 0x7465
 304:	7275                	.insn	2, 0x7275
 306:	206e                	.insn	2, 0x206e
 308:	65646f63          	bltu	s0,s6,966 <_end+0x509>
 30c:	6920                	.insn	2, 0x6920
 30e:	756e2073          	csrrs	zero,0x756,t3
 312:	6c6c                	.insn	2, 0x6c6c
 314:	7200                	.insn	2, 0x7200
 316:	636e6463          	bltu	t3,s6,93e <_end+0x4e1>
 31a:	2d20                	.insn	2, 0x2d20
 31c:	7220                	.insn	2, 0x7220
 31e:	7465                	.insn	2, 0x7465
 320:	7275                	.insn	2, 0x7275
 322:	206e                	.insn	2, 0x206e
 324:	65646f63          	bltu	s0,s6,982 <_end+0x525>
 328:	7020                	.insn	2, 0x7020
 32a:	7274                	.insn	2, 0x7274
 32c:	6920                	.insn	2, 0x6920
 32e:	6f6e2073          	csrrs	zero,0x6f6,t3
 332:	2074                	.insn	2, 0x2074
 334:	2061                	.insn	2, 0x2061
 336:	65646f63          	bltu	s0,s6,994 <_end+0x537>
 33a:	7020                	.insn	2, 0x7020
 33c:	7274                	.insn	2, 0x7274
 33e:	6400                	.insn	2, 0x6400
 340:	6672                	.insn	2, 0x6672
 342:	756e                	.insn	2, 0x756e
 344:	2d20                	.insn	2, 0x2d20
 346:	6420                	.insn	2, 0x6420
 348:	7265                	.insn	2, 0x7265
 34a:	6665                	.insn	2, 0x6665
 34c:	7265                	.insn	2, 0x7265
 34e:	6e65                	.insn	2, 0x6e65
 350:	20646563          	bltu	s0,t1,55a <_end+0xfd>
 354:	756e                	.insn	2, 0x756e
 356:	6c6c                	.insn	2, 0x6c6c
 358:	7020                	.insn	2, 0x7020
 35a:	746e696f          	jal	s2,e6aa0 <_end+0xe6643>
 35e:	7265                	.insn	2, 0x7265
 360:	6400                	.insn	2, 0x6400
 362:	6672                	.insn	2, 0x6672
 364:	2d206463          	bltu	zero,s2,62c <_end+0x1cf>
 368:	6420                	.insn	2, 0x6420
 36a:	7265                	.insn	2, 0x7265
 36c:	6665                	.insn	2, 0x6665
 36e:	7265                	.insn	2, 0x7265
 370:	6e65                	.insn	2, 0x6e65
 372:	20646563          	bltu	s0,t1,57c <_end+0x11f>
 376:	65646f63          	bltu	s0,s6,9d4 <_end+0x577>
 37a:	7020                	.insn	2, 0x7020
 37c:	746e696f          	jal	s2,e6ac2 <_end+0xe6665>
 380:	7265                	.insn	2, 0x7265
 382:	7700                	.insn	2, 0x7700
 384:	7072                	.insn	2, 0x7072
 386:	7674                	.insn	2, 0x7674
 388:	2d20                	.insn	2, 0x2d20
 38a:	7720                	.insn	2, 0x7720
 38c:	6f72                	.insn	2, 0x6f72
 38e:	6574                	.insn	2, 0x6574
 390:	7520                	.insn	2, 0x7520
 392:	676e6973          	csrrsi	s2,0x676,28
 396:	7220                	.insn	2, 0x7220
 398:	6165                	.insn	2, 0x6165
 39a:	2064                	.insn	2, 0x2064
 39c:	796c6e6f          	jal	t3,c6b32 <_end+0xc66d5>
 3a0:	7020                	.insn	2, 0x7020
 3a2:	746e696f          	jal	s2,e6ae8 <_end+0xe668b>
 3a6:	7265                	.insn	2, 0x7265
 3a8:	7300                	.insn	2, 0x7300
 3aa:	6165                	.insn	2, 0x6165
 3ac:	766c                	.insn	2, 0x766c
 3ae:	2d20                	.insn	2, 0x2d20
 3b0:	7720                	.insn	2, 0x7720
 3b2:	6f72                	.insn	2, 0x6f72
 3b4:	6574                	.insn	2, 0x6574
 3b6:	7420                	.insn	2, 0x7420
 3b8:	6572206f          	jal	zero,2320e <_end+0x22db1>
 3bc:	6461                	.insn	2, 0x6461
 3be:	6f20                	.insn	2, 0x6f20
 3c0:	6c6e                	.insn	2, 0x6c6e
 3c2:	2079                	.insn	2, 0x2079
 3c4:	656a626f          	jal	ctxt,a6a1a <_end+0xa65bd>
 3c8:	69007463          	bgeu	zero,a6,a50 <_end+0x5f3>
 3cc:	6f78                	.insn	2, 0x6f78
 3ce:	2d20626f          	jal	ctxt,66a0 <_end+0x6243>
 3d2:	6920                	.insn	2, 0x6920
 3d4:	646e                	.insn	2, 0x646e
 3d6:	7865                	.insn	2, 0x7865
 3d8:	6f20                	.insn	2, 0x6f20
 3da:	7475                	.insn	2, 0x7475
 3dc:	6f20                	.insn	2, 0x6f20
 3de:	2066                	.insn	2, 0x2066
 3e0:	6f62                	.insn	2, 0x6f62
 3e2:	6e75                	.insn	2, 0x6e75
 3e4:	7364                	.insn	2, 0x7364
 3e6:	6600                	.insn	2, 0x6600
 3e8:	7472                	.insn	2, 0x7472
 3ea:	7079                	.insn	2, 0x7079
 3ec:	2d20                	.insn	2, 0x2d20
 3ee:	6620                	.insn	2, 0x6620
 3f0:	6172                	.insn	2, 0x6172
 3f2:	656d                	.insn	2, 0x656d
 3f4:	7420                	.insn	2, 0x7420
 3f6:	7079                	.insn	2, 0x7079
 3f8:	0065                	.insn	2, 0x0065
 3fa:	7061                	.insn	2, 0x7061
 3fc:	7265                	.insn	2, 0x7265
 3fe:	2072                	.insn	2, 0x2072
 400:	202d                	.insn	2, 0x202d
 402:	003f3f3f 766f7068 	.insn	8, 0x766f7068003f3f3f
 40a:	2066                	.insn	2, 0x2066
 40c:	202d                	.insn	2, 0x202d
 40e:	6568                	.insn	2, 0x6568
 410:	7061                	.insn	2, 0x7061
 412:	6620                	.insn	2, 0x6620
 414:	6c75                	.insn	2, 0x6c75
 416:	006c                	.insn	2, 0x006c
 418:	766f7473          	csrrci	s0,0x766,30
 41c:	2066                	.insn	2, 0x2066
 41e:	202d                	.insn	2, 0x202d
 420:	63617473          	csrrci	s0,0x636,2
 424:	766f206b          	.insn	4, 0x766f206b
 428:	7265                	.insn	2, 0x7265
 42a:	6c66                	.insn	2, 0x6c66
 42c:	7000776f          	jal	a4,7b2c <_end+0x76cf>
 430:	6174                	.insn	2, 0x6174
 432:	6972                	.insn	2, 0x6972
 434:	2d20                	.insn	2, 0x2d20
 436:	3f20                	.insn	2, 0x3f20
 438:	00003f3f  	.insn	8, 0x3f3f

0000043f <exceptionStrs.end>:
	...

Disassembly of section hello_world_str:

00000440 <hello_world_str_-0x8>:
 440:	0000                	.insn	2, 0x
 442:	0000                	.insn	2, 0x
 444:	0015                	.insn	2, 0x0015
	...

00000448 <hello_world_str_>:
 448:	6548                	.insn	2, 0x6548
 44a:	6c6c                	.insn	2, 0x6c6c
 44c:	7266206f          	jal	zero,62b72 <_end+0x62715>
 450:	52206d6f          	jal	bm,6972 <_end+0x6515>
 454:	7369                	.insn	2, 0x7369
 456:	4f695663          	bge	s2,s6,942 <_end+0x4e5>
 45a:	0a21                	.insn	2, 0x0a21
 45c:	Address 0x45c is out of bounds.


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
  2a:	32727363          	bgeu	ctxt,t2,350 <exceptionStrs_+0x150>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
