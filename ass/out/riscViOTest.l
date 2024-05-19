
out/riscViOTest.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
   0:	04500293          	addi	t0,zero,69
   4:	00200313          	addi	t1,zero,2
   8:	00000013          	addi	zero,zero,0
   c:	00000013          	addi	zero,zero,0
  10:	00000013          	addi	zero,zero,0
  14:	00000013          	addi	zero,zero,0
  18:	00000013          	addi	zero,zero,0
  1c:	00000013          	addi	zero,zero,0
  20:	00628e33          	add	t3,t0,t1
  24:	40628eb3          	sub	t4,t0,t1
  28:	00629f33          	sll	t5,t0,t1
  2c:	0062afb3          	slt	t6,t0,t1
  30:	0062b533          	sltu	a0,t0,t1
  34:	0062c5b3          	xor	a1,t0,t1
  38:	0062d633          	srl	a2,t0,t1
  3c:	4062d6b3          	sra	a3,t0,t1
  40:	0062e733          	or	a4,t0,t1
  44:	0062f7b3          	and	a5,t0,t1
  48:	1a428413          	addi	s0,t0,420
  4c:	e5c30493          	addi	s1,t1,-420
  50:	1a42a913          	slti	s2,t0,420
  54:	1a42b993          	sltiu	s3,t0,420
  58:	1a42ca13          	xori	s4,t0,420
  5c:	1a42ea93          	ori	s5,t0,420
  60:	1a42fb13          	andi	s6,t0,420
  64:	00229c13          	slli	s8,t0,0x2
  68:	0022dc93          	srli	s9,t0,0x2
  6c:	4022dd13          	srai	s10,t0,0x2
  70:	4062fe33          	andn	t3,t0,t1
  74:	4062eeb3          	orn	t4,t0,t1
  78:	4062cf33          	xnor	t5,t0,t1
  7c:	60029f93          	clz	t6,t0
  80:	60129513          	ctz	a0,t0
  84:	60229593          	cpop	a1,t0
  88:	0a62e633          	max	a2,t0,t1
  8c:	0a62f6b3          	maxu	a3,t0,t1
  90:	0a62c733          	min	a4,t0,t1
  94:	0a62d7b3          	minu	a5,t0,t1
  98:	60429413          	sext.b	s0,t0
  9c:	60531493          	sext.h	s1,t1
  a0:	0802c93b          	zext.h	s2,t0
  a4:	606299b3          	rol	s3,t0,t1
  a8:	6062da33          	ror	s4,t0,t1
  ac:	6102da93          	rori	s5,t0,0x10
  b0:	2872db13          	orc.b	s6,t0
  b4:	6b82dc13          	rev8	s8,t0

00000000000000b8 <doom>:
  b8:	000002ef          	jal	t0,b8 <doom>

Disassembly of section .riscv.attributes:

0000000000000000 <.riscv.attributes>:
   0:	2141                	c.addiw	sp,16
   2:	0000                	c.unimp
   4:	7200                	c.ld	s0,32(a2)
   6:	7369                	c.lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <_start+0x14>
   c:	00000017          	auipc	zero,0x0
  10:	7205                	c.lui	tp,0xfffe1
  12:	3676                	c.fldsp	fa2,376(sp)
  14:	6934                	c.ld	a3,80(a0)
  16:	7032                	0x7032
  18:	5f30                	c.lw	a2,120(a4)
  1a:	627a                	c.ldsp	tp,408(sp)
  1c:	3062                	c.fldsp	ft0,56(sp)
  1e:	3970                	c.fld	fa2,240(a0)
  20:	          	add	zero,zero,zero
