
out/riscViOTest.elf:     file format elf32-littleriscv


Disassembly of section core:

00000000 <core.start_-0x8>:
   0:	0008                	.insn	2, 0x0008
   2:	0000                	.insn	2, 0x
   4:	0160                	.insn	2, 0x0160
	...

00000008 <core.start_>:
   8:	0080006f          	jal	zero,10 <core.start>

0000000c <core.init_>:
   c:	0140006f          	jal	zero,20 <core.init>

00000010 <core.start>:
  10:	00000197          	auipc	root,0x0
  14:	ff018193          	addi	root,root,-16 # 0 <core.start_-0x8>
  18:	fd0181f3          	ccp	root,root
  1c:	004180e7          	jalr	ra,4(root)

00000020 <core.init>:
  20:	00001137          	lui	frame,0x1
  24:	80510113          	addi	frame,frame,-2043 # 805 <_end+0x220>
  28:	00000297          	auipc	t0,0x0
  2c:	0f428293          	addi	t0,t0,244 # 11c <core.exc_handel>
  30:	30529073          	csrrw	zero,mtvec,t0
  34:	00000417          	auipc	s0,0x0
  38:	13c40413          	addi	s0,s0,316 # 170 <core.end+0x4>
  3c:	fd040473          	ccp	s0,s0
  40:	2b800493          	addi	s1,zero,696
  44:	fd0484f3          	ccp	s1,s1
  48:	00800b13          	addi	s6,zero,8
  4c:	00d00b93          	addi	s7,zero,13
  50:	03000c13          	addi	s8,zero,48
  54:	03900c93          	addi	s9,zero,57
  58:	00000d17          	auipc	bm,0x0
  5c:	1e8d0d13          	addi	bm,bm,488 # 240 <uart.end+0x4>
  60:	fd0d0d73          	ccp	bm,bm
  64:	00048513          	addi	a0,s1,0
  68:	00c400e7          	jalr	ra,12(s0)

0000006c <core.repeat>:
  6c:	00048513          	addi	a0,s1,0
  70:	00100593          	addi	a1,zero,1
  74:	008400e7          	jalr	ra,8(s0)
  78:	00000913          	addi	s2,zero,0
  7c:	00000993          	addi	s3,zero,0

00000080 <core.repeat.sizeloop>:
  80:	000400e7          	jalr	ra,0(s0)
  84:	05750863          	beq	a0,s7,d4 <core.repeat.sizeEntered>
  88:	ff854ce3          	blt	a0,s8,80 <core.repeat.sizeloop>
  8c:	feaccae3          	blt	s9,a0,80 <core.repeat.sizeloop>
  90:	03651463          	bne	a0,s6,b8 <core.repeat.sizeNotBs>
  94:	fe0406e3          	beq	s0,zero,80 <core.repeat.sizeloop>
  98:	fff90913          	addi	s2,s2,-1
  9c:	00800513          	addi	a0,zero,8
  a0:	004400e7          	jalr	ra,4(s0)
  a4:	02000513          	addi	a0,zero,32
  a8:	004400e7          	jalr	ra,4(s0)
  ac:	00800513          	addi	a0,zero,8
  b0:	004400e7          	jalr	ra,4(s0)
  b4:	fcdff06f          	jal	zero,80 <core.repeat.sizeloop>

000000b8 <core.repeat.sizeNotBs>:
  b8:	004400e7          	jalr	ra,4(s0)
  bc:	418506b3          	sub	a3,a0,s8
  c0:	00098513          	addi	a0,s3,0
  c4:	00a00593          	addi	a1,zero,10
  c8:	000d00e7          	jalr	ra,0(bm)
  cc:	00d609b3          	add	s3,a2,a3
  d0:	fb1ff06f          	jal	zero,80 <core.repeat.sizeloop>

000000d4 <core.repeat.sizeEntered>:
  d4:	00048513          	addi	a0,s1,0
  d8:	00200593          	addi	a1,zero,2
  dc:	008400e7          	jalr	ra,8(s0)
  e0:	00299993          	slli	s3,s3,0x2
  e4:	2f000913          	addi	s2,zero,752
  e8:	fd090973          	ccp	s2,s2
  ec:	81397503          	lbu.r	a0,s3(s2)
  f0:	004400e7          	jalr	ra,4(s0)
  f4:	00198993          	addi	s3,s3,1
  f8:	81397503          	lbu.r	a0,s3(s2)
  fc:	004400e7          	jalr	ra,4(s0)
 100:	00198993          	addi	s3,s3,1
 104:	81397503          	lbu.r	a0,s3(s2)
 108:	004400e7          	jalr	ra,4(s0)
 10c:	00198993          	addi	s3,s3,1
 110:	81397503          	lbu.r	a0,s3(s2)
 114:	004400e7          	jalr	ra,4(s0)

00000118 <core.doom>:
 118:	f55ff06f          	jal	zero,6c <core.repeat>

0000011c <core.exc_handel>:
 11c:	00100313          	addi	t1,zero,1
 120:	00600393          	addi	t2,zero,6
 124:	fe7305f3          	ciop	a1,t1,t2
 128:	00000417          	auipc	s0,0x0
 12c:	04840413          	addi	s0,s0,72 # 170 <core.end+0x4>
 130:	fd040473          	ccp	s0,s0
 134:	34000513          	addi	a0,zero,832
 138:	fd050573          	ccp	a0,a0
 13c:	00c400e7          	jalr	ra,12(s0)
 140:	36000513          	addi	a0,zero,864
 144:	fd050573          	ccp	a0,a0
 148:	34259073          	csrrw	zero,mcause,a1
 14c:	008400e7          	jalr	ra,8(s0)
 150:	00a00513          	addi	a0,zero,10
 154:	004400e7          	jalr	ra,4(s0)
 158:	00d00513          	addi	a0,zero,13
 15c:	004400e7          	jalr	ra,4(s0)
 160:	00100073          	ebreak
 164:	f09ff06f          	jal	zero,6c <core.repeat>
 168:	30200073          	mret

0000016c <core.end>:
 16c:	00000013          	addi	zero,zero,0

Disassembly of section uart:

00000170 <uart.charIn_-0x8>:
 170:	0010                	.insn	2, 0x0010
 172:	0000                	.insn	2, 0x
 174:	00c0                	.insn	2, 0x00c0
	...

00000178 <uart.charIn_>:
 178:	0240006f          	jal	zero,19c <uart.charIn>

0000017c <uart.charOut_>:
 17c:	00c0006f          	jal	zero,188 <uart.charOut>

00000180 <uart.stringElOut_>:
 180:	0300006f          	jal	zero,1b0 <uart.stringElOut>

00000184 <uart.stringOut_>:
 184:	07c0006f          	jal	zero,200 <uart.stringOut>

00000188 <uart.charOut>:
 188:	00100313          	addi	t1,zero,1
 18c:	00600393          	addi	t2,zero,6
 190:	fe7302f3          	ciop	t0,t1,t2
 194:	00a28023          	sb	a0,0(t0)
 198:	00008067          	jalr	zero,0(ra)

0000019c <uart.charIn>:
 19c:	00100313          	addi	t1,zero,1
 1a0:	00600393          	addi	t2,zero,6
 1a4:	fe7302f3          	ciop	t0,t1,t2
 1a8:	0002c503          	lbu	a0,0(t0)
 1ac:	00008067          	jalr	zero,0(ra)

000001b0 <uart.stringElOut>:
 1b0:	00050893          	addi	a7,a0,0
 1b4:	0808880b          	qdtb	a6,a7
 1b8:	ffc00793          	addi	a5,zero,-4
 1bc:	00000713          	addi	a4,zero,0

000001c0 <uart.stringElOut.next>:
 1c0:	00478793          	addi	a5,a5,4
 1c4:	0307da63          	bge	a5,a6,1f8 <uart.stringElOut.oob>
 1c8:	04f8f303          	lw.r	t1,a5(a7)
 1cc:	28735313          	orc.b	t1,t1
 1d0:	fff34313          	xori	t1,t1,-1

000001d4 <uart.stringElOut.again>:
 1d4:	fe0306e3          	beq	t1,zero,1c0 <uart.stringElOut.next>
 1d8:	60131393          	ctz	t2,t1
 1dc:	00838393          	addi	t2,t2,8
 1e0:	00735333          	srl	t1,t1,t2
 1e4:	00170713          	addi	a4,a4,1
 1e8:	feb716e3          	bne	a4,a1,1d4 <uart.stringElOut.again>
 1ec:	0033d393          	srli	t2,t2,0x3
 1f0:	007785b3          	add	a1,a5,t2
 1f4:	0180006f          	jal	zero,20c <uart.stringOutInt>

000001f8 <uart.stringElOut.oob>:
 1f8:	fff00593          	addi	a1,zero,-1
 1fc:	00008067          	jalr	zero,0(ra)

00000200 <uart.stringOut>:
 200:	00000593          	addi	a1,zero,0
 204:	00050893          	addi	a7,a0,0
 208:	0808880b          	qdtb	a6,a7

0000020c <uart.stringOutInt>:
 20c:	0031700b          	push	0,0
 210:	0011100b          	sp	ra,0(frame)

00000214 <uart.stringOutInt.nxt>:
 214:	01058e63          	beq	a1,a6,230 <uart.stringOutInt.end>
 218:	00000013          	addi	zero,zero,0
 21c:	80b8f503          	lbu.r	a0,a1(a7)
 220:	00050863          	beq	a0,zero,230 <uart.stringOutInt.end>
 224:	f65ff0ef          	jal	ra,188 <uart.charOut>
 228:	00158593          	addi	a1,a1,1
 22c:	fe9ff06f          	jal	zero,214 <uart.stringOutInt.nxt>

00000230 <uart.stringOutInt.end>:
 230:	0001208b          	lp	ra,0(frame)
 234:	1800000b          	pop
 238:	00008067          	jalr	zero,0(ra)

Disassembly of section util:

00000240 <util.mul__-0x8>:
 240:	0008                	.insn	2, 0x0008
 242:	0000                	.insn	2, 0x
 244:	0068                	.insn	2, 0x0068
	...

00000248 <util.mul__>:
 248:	0080006f          	jal	zero,250 <util.mul_>

0000024c <util.divu__>:
 24c:	01c0006f          	jal	zero,268 <util.divu_>

00000250 <util.mul_>:
 250:	00000613          	addi	a2,zero,0

00000254 <util.mul_loop>:
 254:	00058863          	beq	a1,zero,264 <util.mul_end>
 258:	00a60633          	add	a2,a2,a0
 25c:	fff58593          	addi	a1,a1,-1
 260:	ff5ff06f          	jal	zero,254 <util.mul_loop>

00000264 <util.mul_end>:
 264:	00008067          	jalr	zero,0(ra)

00000268 <util.divu_>:
 268:	04058463          	beq	a1,zero,2b0 <util.divu_end>
 26c:	02000393          	addi	t2,zero,32
 270:	60051313          	clz	t1,a0
 274:	406383b3          	sub	t2,t2,t1
 278:	00651533          	sll	a0,a0,t1
 27c:	00000313          	addi	t1,zero,0
 280:	02038663          	beq	t2,zero,2ac <util.divu_done>

00000284 <util.divu_loop>:
 284:	61f55293          	rori	t0,a0,0x1f
 288:	0012f293          	andi	t0,t0,1
 28c:	00151513          	slli	a0,a0,0x1
 290:	00131313          	slli	t1,t1,0x1
 294:	00536333          	or	t1,t1,t0
 298:	00b36663          	bltu	t1,a1,2a4 <util.divu_nope>
 29c:	40b30333          	sub	t1,t1,a1
 2a0:	00150513          	addi	a0,a0,1

000002a4 <util.divu_nope>:
 2a4:	fff38393          	addi	t2,t2,-1
 2a8:	fc039ee3          	bne	t2,zero,284 <util.divu_loop>

000002ac <util.divu_done>:
 2ac:	00030593          	addi	a1,t1,0

000002b0 <util.divu_end>:
 2b0:	00008067          	jalr	zero,0(ra)

Disassembly of section demo_strings:

000002b8 <demo_strings_-0x8>:
 2b8:	0000                	.insn	2, 0x
 2ba:	0000                	.insn	2, 0x
 2bc:	0000002f          	.insn	4, 0x002f

000002c0 <demo_strings_>:
 2c0:	6946                	.insn	2, 0x6946
 2c2:	6f62                	.insn	2, 0x6f62
 2c4:	616e                	.insn	2, 0x616e
 2c6:	20696363          	bltu	s2,t1,4cc <exceptionStrs_+0x164>
 2ca:	7845                	.insn	2, 0x7845
 2cc:	6d61                	.insn	2, 0x6d61
 2ce:	6c70                	.insn	2, 0x6c70
 2d0:	0065                	.insn	2, 0x0065
 2d2:	0d0a                	.insn	2, 0x0d0a
 2d4:	6e45                	.insn	2, 0x6e45
 2d6:	6574                	.insn	2, 0x6574
 2d8:	2072                	.insn	2, 0x2072
 2da:	6e49                	.insn	2, 0x6e49
 2dc:	6564                	.insn	2, 0x6564
 2de:	3a78                	.insn	2, 0x3a78
 2e0:	0020                	.insn	2, 0x0020
 2e2:	0d0a                	.insn	2, 0x0d0a
 2e4:	6156                	.insn	2, 0x6156
 2e6:	756c                	.insn	2, 0x756c
 2e8:	2065                	.insn	2, 0x2065
 2ea:	7369                	.insn	2, 0x7369
 2ec:	203a                	.insn	2, 0x203a
	...

000002ef <demo_strings.end>:
	...

Disassembly of section fibo_string:

000002f0 <fibo_string_-0x8>:
 2f0:	0000                	.insn	2, 0x
 2f2:	0000                	.insn	2, 0x
 2f4:	0044                	.insn	2, 0x0044
	...

000002f8 <fibo_string_>:
 2f8:	3030                	.insn	2, 0x3030
 2fa:	0030                	.insn	2, 0x0030
 2fc:	3030                	.insn	2, 0x3030
 2fe:	0031                	.insn	2, 0x0031
 300:	3030                	.insn	2, 0x3030
 302:	0031                	.insn	2, 0x0031
 304:	3030                	.insn	2, 0x3030
 306:	0032                	.insn	2, 0x0032
 308:	3030                	.insn	2, 0x3030
 30a:	30300033          	.insn	4, 0x30300033
 30e:	0035                	.insn	2, 0x0035
 310:	3030                	.insn	2, 0x3030
 312:	0038                	.insn	2, 0x0038
 314:	3130                	.insn	2, 0x3130
 316:	32300033          	.insn	4, 0x32300033
 31a:	0031                	.insn	2, 0x0031
 31c:	3330                	.insn	2, 0x3330
 31e:	0034                	.insn	2, 0x0034
 320:	3530                	.insn	2, 0x3530
 322:	0035                	.insn	2, 0x0035
 324:	3830                	.insn	2, 0x3830
 326:	0039                	.insn	2, 0x0039
 328:	3431                	.insn	2, 0x3431
 32a:	0034                	.insn	2, 0x0034
 32c:	3332                	.insn	2, 0x3332
 32e:	37330033          	.insn	4, 0x37330033
 332:	31360037          	lui	zero,0x31360
 336:	0030                	.insn	2, 0x0030
 338:	3839                	.insn	2, 0x3839
 33a:	          	lui	zero,0x0

0000033c <fibo_string.end>:
 33c:	0000                	.insn	2, 0x
	...

Disassembly of section exception_hdr_str:

00000340 <exception_hdr_str_-0x8>:
 340:	0000                	.insn	2, 0x
 342:	0000                	.insn	2, 0x
 344:	0018                	.insn	2, 0x0018
	...

00000348 <exception_hdr_str_>:
 348:	0d0a                	.insn	2, 0x0d0a
 34a:	6e41                	.insn	2, 0x6e41
 34c:	4520                	.insn	2, 0x4520
 34e:	6378                	.insn	2, 0x6378
 350:	7065                	.insn	2, 0x7065
 352:	6974                	.insn	2, 0x6974
 354:	6f206e6f          	jal	t3,6a46 <_end+0x6461>
 358:	72756363          	bltu	a0,t2,a7e <_end+0x499>
 35c:	6465                	.insn	2, 0x6465
 35e:	203a                	.insn	2, 0x203a

Disassembly of section exceptionStrs:

00000360 <exceptionStrs_-0x8>:
 360:	0000                	.insn	2, 0x
 362:	0000                	.insn	2, 0x
 364:	025a                	.insn	2, 0x025a
	...

00000368 <exceptionStrs_>:
 368:	6170                	.insn	2, 0x6170
 36a:	696e                	.insn	2, 0x696e
 36c:	202d2063          	.insn	4, 0x202d2063
 370:	65766573          	csrrsi	a0,hviprio2h,12
 374:	6572                	.insn	2, 0x6572
 376:	6920                	.insn	2, 0x6920
 378:	746e                	.insn	2, 0x746e
 37a:	7265                	.insn	2, 0x7265
 37c:	616e                	.insn	2, 0x616e
 37e:	206c                	.insn	2, 0x206c
 380:	7265                	.insn	2, 0x7265
 382:	6f72                	.insn	2, 0x6f72
 384:	0072                	.insn	2, 0x0072
 386:	6c69                	.insn	2, 0x6c69
 388:	656c                	.insn	2, 0x656c
 38a:	202d2067          	.insn	4, 0x202d2067
 38e:	6c69                	.insn	2, 0x6c69
 390:	656c                	.insn	2, 0x656c
 392:	206c6167          	.insn	4, 0x206c6167
 396:	6e69                	.insn	2, 0x6e69
 398:	75727473          	csrrci	s0,0x757,4
 39c:	6f697463          	bgeu	s2,s6,a84 <_end+0x49f>
 3a0:	006e                	.insn	2, 0x006e
 3a2:	72657673          	csrrci	a2,mhpmevent6h,10
 3a6:	2072                	.insn	2, 0x2072
 3a8:	202d                	.insn	2, 0x202d
 3aa:	65707573          	csrrci	a0,hviprio2h,0
 3ae:	7672                	.insn	2, 0x7672
 3b0:	7369                	.insn	2, 0x7369
 3b2:	6520726f          	jal	ctxt,7a04 <_end+0x741f>
 3b6:	7272                	.insn	2, 0x7272
 3b8:	7300726f          	jal	ctxt,7ae8 <_end+0x7503>
 3bc:	6574                	.insn	2, 0x6574
 3be:	7272                	.insn	2, 0x7272
 3c0:	2d20                	.insn	2, 0x2d20
 3c2:	7320                	.insn	2, 0x7320
 3c4:	6174                	.insn	2, 0x6174
 3c6:	6574                	.insn	2, 0x6574
 3c8:	6520                	.insn	2, 0x6520
 3ca:	7272                	.insn	2, 0x7272
 3cc:	7000726f          	jal	ctxt,7acc <_end+0x74e7>
 3d0:	6972                	.insn	2, 0x6972
 3d2:	7676                	.insn	2, 0x7676
 3d4:	2d20                	.insn	2, 0x2d20
 3d6:	7020                	.insn	2, 0x7020
 3d8:	6972                	.insn	2, 0x6972
 3da:	6976                	.insn	2, 0x6976
 3dc:	656c                	.insn	2, 0x656c
 3de:	64656467          	.insn	4, 0x64656467
 3e2:	6920                	.insn	2, 0x6920
 3e4:	736e                	.insn	2, 0x736e
 3e6:	7274                	.insn	2, 0x7274
 3e8:	6375                	.insn	2, 0x6375
 3ea:	6974                	.insn	2, 0x6974
 3ec:	74006e6f          	jal	t3,6b2c <_end+0x6547>
 3f0:	6c696f63          	bltu	s2,t1,ace <_end+0x4e9>
 3f4:	2d20                	.insn	2, 0x2d20
 3f6:	7420                	.insn	2, 0x7420
 3f8:	7261                	.insn	2, 0x7261
 3fa:	20746567          	.insn	4, 0x20746567
 3fe:	65646f63          	bltu	s0,s6,a5c <_end+0x477>
 402:	6920                	.insn	2, 0x6920
 404:	646e                	.insn	2, 0x646e
 406:	7865                	.insn	2, 0x7865
 408:	7400                	.insn	2, 0x7400
 40a:	626f6963          	bltu	t5,t1,a3c <_end+0x457>
 40e:	2d20                	.insn	2, 0x2d20
 410:	7420                	.insn	2, 0x7420
 412:	7261                	.insn	2, 0x7261
 414:	20746567          	.insn	4, 0x20746567
 418:	65646f63          	bltu	s0,s6,a76 <_end+0x491>
 41c:	6920                	.insn	2, 0x6920
 41e:	646e                	.insn	2, 0x646e
 420:	7865                	.insn	2, 0x7865
 422:	6f20                	.insn	2, 0x6f20
 424:	7475                	.insn	2, 0x7475
 426:	6f20                	.insn	2, 0x6f20
 428:	2066                	.insn	2, 0x2066
 42a:	6f62                	.insn	2, 0x6f62
 42c:	6e75                	.insn	2, 0x6e75
 42e:	0064                	.insn	2, 0x0064
 430:	6e65                	.insn	2, 0x6e65
 432:	6f64                	.insn	2, 0x6f64
 434:	202d2063          	.insn	4, 0x202d2063
 438:	6e65                	.insn	2, 0x6e65
 43a:	2064                	.insn	2, 0x2064
 43c:	6320666f          	jal	a2,6a6e <_end+0x6489>
 440:	0065646f          	jal	s0,56446 <_end+0x55e61>
 444:	6972                	.insn	2, 0x6972
 446:	6578                	.insn	2, 0x6578
 448:	2071                	.insn	2, 0x2071
 44a:	202d                	.insn	2, 0x202d
 44c:	6572                	.insn	2, 0x6572
 44e:	7574                	.insn	2, 0x7574
 450:	6e72                	.insn	2, 0x6e72
 452:	6920                	.insn	2, 0x6920
 454:	646e                	.insn	2, 0x646e
 456:	7865                	.insn	2, 0x7865
 458:	6920                	.insn	2, 0x6920
 45a:	657a2073          	csrrs	zero,hviprio2h,s4
 45e:	6f72                	.insn	2, 0x6f72
 460:	7200                	.insn	2, 0x7200
 462:	756e6463          	bltu	t3,s6,baa <_end+0x5c5>
 466:	2d20                	.insn	2, 0x2d20
 468:	7220                	.insn	2, 0x7220
 46a:	7465                	.insn	2, 0x7465
 46c:	7275                	.insn	2, 0x7275
 46e:	206e                	.insn	2, 0x206e
 470:	65646f63          	bltu	s0,s6,ace <_end+0x4e9>
 474:	6920                	.insn	2, 0x6920
 476:	756e2073          	csrrs	zero,0x756,t3
 47a:	6c6c                	.insn	2, 0x6c6c
 47c:	7200                	.insn	2, 0x7200
 47e:	636e6463          	bltu	t3,s6,aa6 <_end+0x4c1>
 482:	2d20                	.insn	2, 0x2d20
 484:	7220                	.insn	2, 0x7220
 486:	7465                	.insn	2, 0x7465
 488:	7275                	.insn	2, 0x7275
 48a:	206e                	.insn	2, 0x206e
 48c:	65646f63          	bltu	s0,s6,aea <_end+0x505>
 490:	7020                	.insn	2, 0x7020
 492:	7274                	.insn	2, 0x7274
 494:	6920                	.insn	2, 0x6920
 496:	6f6e2073          	csrrs	zero,0x6f6,t3
 49a:	2074                	.insn	2, 0x2074
 49c:	2061                	.insn	2, 0x2061
 49e:	65646f63          	bltu	s0,s6,afc <_end+0x517>
 4a2:	7020                	.insn	2, 0x7020
 4a4:	7274                	.insn	2, 0x7274
 4a6:	6400                	.insn	2, 0x6400
 4a8:	6672                	.insn	2, 0x6672
 4aa:	756e                	.insn	2, 0x756e
 4ac:	2d20                	.insn	2, 0x2d20
 4ae:	6420                	.insn	2, 0x6420
 4b0:	7265                	.insn	2, 0x7265
 4b2:	6665                	.insn	2, 0x6665
 4b4:	7265                	.insn	2, 0x7265
 4b6:	6e65                	.insn	2, 0x6e65
 4b8:	20646563          	bltu	s0,t1,6c2 <_end+0xdd>
 4bc:	756e                	.insn	2, 0x756e
 4be:	6c6c                	.insn	2, 0x6c6c
 4c0:	7020                	.insn	2, 0x7020
 4c2:	746e696f          	jal	s2,e6c08 <_end+0xe6623>
 4c6:	7265                	.insn	2, 0x7265
 4c8:	6400                	.insn	2, 0x6400
 4ca:	6672                	.insn	2, 0x6672
 4cc:	2d206463          	bltu	zero,s2,794 <_end+0x1af>
 4d0:	6420                	.insn	2, 0x6420
 4d2:	7265                	.insn	2, 0x7265
 4d4:	6665                	.insn	2, 0x6665
 4d6:	7265                	.insn	2, 0x7265
 4d8:	6e65                	.insn	2, 0x6e65
 4da:	20646563          	bltu	s0,t1,6e4 <_end+0xff>
 4de:	65646f63          	bltu	s0,s6,b3c <_end+0x557>
 4e2:	7020                	.insn	2, 0x7020
 4e4:	746e696f          	jal	s2,e6c2a <_end+0xe6645>
 4e8:	7265                	.insn	2, 0x7265
 4ea:	7700                	.insn	2, 0x7700
 4ec:	7072                	.insn	2, 0x7072
 4ee:	7674                	.insn	2, 0x7674
 4f0:	2d20                	.insn	2, 0x2d20
 4f2:	7720                	.insn	2, 0x7720
 4f4:	6f72                	.insn	2, 0x6f72
 4f6:	6574                	.insn	2, 0x6574
 4f8:	7520                	.insn	2, 0x7520
 4fa:	676e6973          	csrrsi	s2,0x676,28
 4fe:	7220                	.insn	2, 0x7220
 500:	6165                	.insn	2, 0x6165
 502:	2064                	.insn	2, 0x2064
 504:	796c6e6f          	jal	t3,c6c9a <_end+0xc66b5>
 508:	7020                	.insn	2, 0x7020
 50a:	746e696f          	jal	s2,e6c50 <_end+0xe666b>
 50e:	7265                	.insn	2, 0x7265
 510:	7300                	.insn	2, 0x7300
 512:	6165                	.insn	2, 0x6165
 514:	766c                	.insn	2, 0x766c
 516:	2d20                	.insn	2, 0x2d20
 518:	7720                	.insn	2, 0x7720
 51a:	6f72                	.insn	2, 0x6f72
 51c:	6574                	.insn	2, 0x6574
 51e:	7420                	.insn	2, 0x7420
 520:	6572206f          	jal	zero,23376 <_end+0x22d91>
 524:	6461                	.insn	2, 0x6461
 526:	6f20                	.insn	2, 0x6f20
 528:	6c6e                	.insn	2, 0x6c6e
 52a:	2079                	.insn	2, 0x2079
 52c:	656a626f          	jal	ctxt,a6b82 <_end+0xa659d>
 530:	69007463          	bgeu	zero,a6,bb8 <_end+0x5d3>
 534:	6f78                	.insn	2, 0x6f78
 536:	2d20626f          	jal	ctxt,6808 <_end+0x6223>
 53a:	6920                	.insn	2, 0x6920
 53c:	646e                	.insn	2, 0x646e
 53e:	7865                	.insn	2, 0x7865
 540:	6f20                	.insn	2, 0x6f20
 542:	7475                	.insn	2, 0x7475
 544:	6f20                	.insn	2, 0x6f20
 546:	2066                	.insn	2, 0x2066
 548:	6f62                	.insn	2, 0x6f62
 54a:	6e75                	.insn	2, 0x6e75
 54c:	7364                	.insn	2, 0x7364
 54e:	6600                	.insn	2, 0x6600
 550:	7472                	.insn	2, 0x7472
 552:	7079                	.insn	2, 0x7079
 554:	2d20                	.insn	2, 0x2d20
 556:	6620                	.insn	2, 0x6620
 558:	6172                	.insn	2, 0x6172
 55a:	656d                	.insn	2, 0x656d
 55c:	7420                	.insn	2, 0x7420
 55e:	7079                	.insn	2, 0x7079
 560:	0065                	.insn	2, 0x0065
 562:	7061                	.insn	2, 0x7061
 564:	7265                	.insn	2, 0x7265
 566:	2072                	.insn	2, 0x2072
 568:	202d                	.insn	2, 0x202d
 56a:	003f3f3f 766f7068 	.insn	8, 0x766f7068003f3f3f
 572:	2066                	.insn	2, 0x2066
 574:	202d                	.insn	2, 0x202d
 576:	6568                	.insn	2, 0x6568
 578:	7061                	.insn	2, 0x7061
 57a:	6620                	.insn	2, 0x6620
 57c:	6c75                	.insn	2, 0x6c75
 57e:	006c                	.insn	2, 0x006c
 580:	766f7473          	csrrci	s0,0x766,30
 584:	2066                	.insn	2, 0x2066
 586:	202d                	.insn	2, 0x202d
 588:	63617473          	csrrci	s0,0x636,2
 58c:	766f206b          	.insn	4, 0x766f206b
 590:	7265                	.insn	2, 0x7265
 592:	6c66                	.insn	2, 0x6c66
 594:	7000776f          	jal	a4,7c94 <_end+0x76af>
 598:	6174                	.insn	2, 0x6174
 59a:	6972                	.insn	2, 0x6972
 59c:	2d20                	.insn	2, 0x2d20
 59e:	6120                	.insn	2, 0x6120
 5a0:	6972                	.insn	2, 0x6972
 5a2:	6874                	.insn	2, 0x6874
 5a4:	656d                	.insn	2, 0x656d
 5a6:	6974                	.insn	2, 0x6974
 5a8:	6e6f2063          	.insn	4, 0x6e6f2063
 5ac:	7020                	.insn	2, 0x7020
 5ae:	746e696f          	jal	s2,e6cf4 <_end+0xe670f>
 5b2:	7265                	.insn	2, 0x7265
 5b4:	7220                	.insn	2, 0x7220
 5b6:	6765                	.insn	2, 0x6765
 5b8:	7369                	.insn	2, 0x7369
 5ba:	6574                	.insn	2, 0x6574
 5bc:	0072                	.insn	2, 0x0072
 5be:	0000                	.insn	2, 0x
	...

000005c2 <exceptionStrs.end>:
 5c2:	0000                	.insn	2, 0x
 5c4:	0000                	.insn	2, 0x
	...

Disassembly of section hello_world_str:

000005c8 <hello_world_str_-0x8>:
 5c8:	0000                	.insn	2, 0x
 5ca:	0000                	.insn	2, 0x
 5cc:	0015                	.insn	2, 0x0015
	...

000005d0 <hello_world_str_>:
 5d0:	6548                	.insn	2, 0x6548
 5d2:	6c6c                	.insn	2, 0x6c6c
 5d4:	7266206f          	jal	zero,62cfa <_end+0x62715>
 5d8:	52206d6f          	jal	bm,6afa <_end+0x6515>
 5dc:	7369                	.insn	2, 0x7369
 5de:	4f695663          	bge	s2,s6,aca <_end+0x4e5>
 5e2:	0a21                	.insn	2, 0x0a21
 5e4:	Address 0x5e4 is out of bounds.


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
  2a:	32727363          	bgeu	ctxt,t2,350 <exception_hdr_str_+0x8>
  2e:	3070                	.insn	2, 0x3070
  30:	7a5f 6262 7031      	.insn	6, 0x703162627a5f
  36:	0030                	.insn	2, 0x0030
  38:	0108                	.insn	2, 0x0108
  3a:	0b0a                	.insn	2, 0x0b0a
