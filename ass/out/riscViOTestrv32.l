
out/riscViOTestrv32.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
   0:	04500293          	addi	t0,zero,69
   4:	00200313          	addi	t1,zero,2
   8:	00628e33          	add	t3,t0,t1
   c:	40628eb3          	sub	t4,t0,t1
  10:	00629f33          	sll	t5,t0,t1
  14:	0062afb3          	slt	t6,t0,t1
  18:	0062b533          	sltu	a0,t0,t1
  1c:	0062c5b3          	xor	a1,t0,t1
  20:	0062d633          	srl	a2,t0,t1
  24:	4062d6b3          	sra	a3,t0,t1
  28:	0062e733          	or	a4,t0,t1
  2c:	0062f7b3          	and	a5,t0,t1
  30:	1a428413          	addi	s0,t0,420
  34:	e5c30493          	addi	s1,t1,-420
  38:	1a42a913          	slti	s2,t0,420
  3c:	1a42b993          	sltiu	s3,t0,420
  40:	1a42ca13          	xori	s4,t0,420
  44:	1a42ea93          	ori	s5,t0,420
  48:	1a42fb13          	andi	s6,t0,420
  4c:	00229c13          	slli	s8,t0,0x2
  50:	0022dc93          	srli	s9,t0,0x2
  54:	4022dd13          	srai	bm,t0,0x2

00000058 <doom>:
  58:	000002ef          	jal	t0,58 <doom>
  5c:	4062fe33          	andn	t3,t0,t1
  60:	4062eeb3          	orn	t4,t0,t1
  64:	4062cf33          	xnor	t5,t0,t1
  68:	60029f93          	clz	t6,t0
  6c:	60129513          	ctz	a0,t0
  70:	60229593          	cpop	a1,t0
  74:	0a62e633          	max	a2,t0,t1
  78:	0a62f6b3          	maxu	a3,t0,t1
  7c:	0a62c733          	min	a4,t0,t1
  80:	0a62d7b3          	minu	a5,t0,t1
  84:	60429413          	sext.b	s0,t0
  88:	60531493          	sext.h	s1,t1
  8c:	0802c933          	zext.h	s2,t0
  90:	606299b3          	rol	s3,t0,t1
  94:	6062da33          	ror	s4,t0,t1
  98:	6102da93          	rori	s5,t0,0x10
  9c:	2872db13          	orc.b	s6,t0
  a0:	6982dc13          	rev8	s8,t0

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2e41                	.insn	2, 0x2e41
   2:	0000                	.insn	2, 0x
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <_start+0x14>
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
