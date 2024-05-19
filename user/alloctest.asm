
user/_alloctest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <test0>:
#include "kernel/fcntl.h"
#include "kernel/memlayout.h"
#include "user/user.h"

void test0() {
   0:	715d                	addi	sp,sp,-80
   2:	e486                	sd	ra,72(sp)
   4:	e0a2                	sd	s0,64(sp)
   6:	fc26                	sd	s1,56(sp)
   8:	f84a                	sd	s2,48(sp)
   a:	f44e                	sd	s3,40(sp)
   c:	f052                	sd	s4,32(sp)
   e:	ec56                	sd	s5,24(sp)
  10:	0880                	addi	s0,sp,80
  enum { NCHILD = 50, NFD = 10, NFILE = 100 };
  int i, j;
  int fd;

  printf("filetest: start\n");
  12:	00001517          	auipc	a0,0x1
  16:	9fe50513          	addi	a0,a0,-1538 # a10 <malloc+0xe6>
  1a:	00001097          	auipc	ra,0x1
  1e:	852080e7          	jalr	-1966(ra) # 86c <printf>
  22:	03200493          	li	s1,50
    printf("test setup is wrong\n");
    exit(1);
  }

  for (i = 0; i < NCHILD; i++) {
    int pid = fork();
  26:	00000097          	auipc	ra,0x0
  2a:	4c6080e7          	jalr	1222(ra) # 4ec <fork>
    if (pid < 0) {
  2e:	00054f63          	bltz	a0,4c <test0+0x4c>
      printf("fork failed");
      exit(1);
    }
    if (pid == 0) {
  32:	c915                	beqz	a0,66 <test0+0x66>
  for (i = 0; i < NCHILD; i++) {
  34:	34fd                	addiw	s1,s1,-1
  36:	f8e5                	bnez	s1,26 <test0+0x26>
  38:	03200493          	li	s1,50
      sleep(10);
      exit(0);  // no errors; exit with 0.
    }
  }

  int all_ok = 1;
  3c:	4905                	li	s2,1
  for (int i = 0; i < NCHILD; i++) {
    int xstatus;
    wait(&xstatus);
    if (xstatus != 0) {
      if (all_ok == 1) printf("filetest: FAILED\n");
  3e:	4985                	li	s3,1
  40:	00001a97          	auipc	s5,0x1
  44:	a08a8a93          	addi	s5,s5,-1528 # a48 <malloc+0x11e>
      all_ok = 0;
  48:	4a01                	li	s4,0
  4a:	a8b1                	j	a6 <test0+0xa6>
      printf("fork failed");
  4c:	00001517          	auipc	a0,0x1
  50:	9dc50513          	addi	a0,a0,-1572 # a28 <malloc+0xfe>
  54:	00001097          	auipc	ra,0x1
  58:	818080e7          	jalr	-2024(ra) # 86c <printf>
      exit(1);
  5c:	4505                	li	a0,1
  5e:	00000097          	auipc	ra,0x0
  62:	496080e7          	jalr	1174(ra) # 4f4 <exit>
  66:	44a9                	li	s1,10
        if ((fd = open("xv6-readme", O_RDONLY)) < 0) {
  68:	00001917          	auipc	s2,0x1
  6c:	9d090913          	addi	s2,s2,-1584 # a38 <malloc+0x10e>
  70:	4581                	li	a1,0
  72:	854a                	mv	a0,s2
  74:	00000097          	auipc	ra,0x0
  78:	4c0080e7          	jalr	1216(ra) # 534 <open>
  7c:	00054e63          	bltz	a0,98 <test0+0x98>
      for (j = 0; j < NFD; j++) {
  80:	34fd                	addiw	s1,s1,-1
  82:	f4fd                	bnez	s1,70 <test0+0x70>
      sleep(10);
  84:	4529                	li	a0,10
  86:	00000097          	auipc	ra,0x0
  8a:	4fe080e7          	jalr	1278(ra) # 584 <sleep>
      exit(0);  // no errors; exit with 0.
  8e:	4501                	li	a0,0
  90:	00000097          	auipc	ra,0x0
  94:	464080e7          	jalr	1124(ra) # 4f4 <exit>
          exit(1);
  98:	4505                	li	a0,1
  9a:	00000097          	auipc	ra,0x0
  9e:	45a080e7          	jalr	1114(ra) # 4f4 <exit>
  for (int i = 0; i < NCHILD; i++) {
  a2:	34fd                	addiw	s1,s1,-1
  a4:	c09d                	beqz	s1,ca <test0+0xca>
    wait(&xstatus);
  a6:	fbc40513          	addi	a0,s0,-68
  aa:	00000097          	auipc	ra,0x0
  ae:	452080e7          	jalr	1106(ra) # 4fc <wait>
    if (xstatus != 0) {
  b2:	fbc42783          	lw	a5,-68(s0)
  b6:	d7f5                	beqz	a5,a2 <test0+0xa2>
      if (all_ok == 1) printf("filetest: FAILED\n");
  b8:	ff3915e3          	bne	s2,s3,a2 <test0+0xa2>
  bc:	8556                	mv	a0,s5
  be:	00000097          	auipc	ra,0x0
  c2:	7ae080e7          	jalr	1966(ra) # 86c <printf>
      all_ok = 0;
  c6:	8952                	mv	s2,s4
  c8:	bfe9                	j	a2 <test0+0xa2>
    }
  }

  if (all_ok) printf("filetest: OK\n");
  ca:	00091b63          	bnez	s2,e0 <test0+0xe0>
}
  ce:	60a6                	ld	ra,72(sp)
  d0:	6406                	ld	s0,64(sp)
  d2:	74e2                	ld	s1,56(sp)
  d4:	7942                	ld	s2,48(sp)
  d6:	79a2                	ld	s3,40(sp)
  d8:	7a02                	ld	s4,32(sp)
  da:	6ae2                	ld	s5,24(sp)
  dc:	6161                	addi	sp,sp,80
  de:	8082                	ret
  if (all_ok) printf("filetest: OK\n");
  e0:	00001517          	auipc	a0,0x1
  e4:	98050513          	addi	a0,a0,-1664 # a60 <malloc+0x136>
  e8:	00000097          	auipc	ra,0x0
  ec:	784080e7          	jalr	1924(ra) # 86c <printf>
}
  f0:	bff9                	j	ce <test0+0xce>

00000000000000f2 <test1>:

// Allocate all free memory and count how it is
void test1() {
  f2:	7139                	addi	sp,sp,-64
  f4:	fc06                	sd	ra,56(sp)
  f6:	f822                	sd	s0,48(sp)
  f8:	f426                	sd	s1,40(sp)
  fa:	f04a                	sd	s2,32(sp)
  fc:	ec4e                	sd	s3,24(sp)
  fe:	0080                	addi	s0,sp,64
  void *a;
  int tot = 0;
  char buf[1];
  int fds[2];

  printf("memtest: start\n");
 100:	00001517          	auipc	a0,0x1
 104:	97050513          	addi	a0,a0,-1680 # a70 <malloc+0x146>
 108:	00000097          	auipc	ra,0x0
 10c:	764080e7          	jalr	1892(ra) # 86c <printf>
  if (pipe(fds) != 0) {
 110:	fc040513          	addi	a0,s0,-64
 114:	00000097          	auipc	ra,0x0
 118:	3f0080e7          	jalr	1008(ra) # 504 <pipe>
 11c:	e525                	bnez	a0,184 <test1+0x92>
 11e:	84aa                	mv	s1,a0
    printf("pipe() failed\n");
    exit(1);
  }
  int pid = fork();
 120:	00000097          	auipc	ra,0x0
 124:	3cc080e7          	jalr	972(ra) # 4ec <fork>
  if (pid < 0) {
 128:	06054b63          	bltz	a0,19e <test1+0xac>
    printf("fork failed");
    exit(1);
  }
  if (pid == 0) {
 12c:	e959                	bnez	a0,1c2 <test1+0xd0>
    close(fds[0]);
 12e:	fc042503          	lw	a0,-64(s0)
 132:	00000097          	auipc	ra,0x0
 136:	3ea080e7          	jalr	1002(ra) # 51c <close>
    while (1) {
      a = sbrk(PGSIZE);
      if (a == (char *)0xffffffffffffffffL) exit(0);
 13a:	597d                	li	s2,-1
      *(int *)(a + 4) = 1;
 13c:	4485                	li	s1,1
      if (write(fds[1], "x", 1) != 1) {
 13e:	00001997          	auipc	s3,0x1
 142:	95298993          	addi	s3,s3,-1710 # a90 <malloc+0x166>
      a = sbrk(PGSIZE);
 146:	6505                	lui	a0,0x1
 148:	00000097          	auipc	ra,0x0
 14c:	434080e7          	jalr	1076(ra) # 57c <sbrk>
      if (a == (char *)0xffffffffffffffffL) exit(0);
 150:	07250463          	beq	a0,s2,1b8 <test1+0xc6>
      *(int *)(a + 4) = 1;
 154:	c144                	sw	s1,4(a0)
      if (write(fds[1], "x", 1) != 1) {
 156:	8626                	mv	a2,s1
 158:	85ce                	mv	a1,s3
 15a:	fc442503          	lw	a0,-60(s0)
 15e:	00000097          	auipc	ra,0x0
 162:	3b6080e7          	jalr	950(ra) # 514 <write>
 166:	fe9500e3          	beq	a0,s1,146 <test1+0x54>
        printf("write failed");
 16a:	00001517          	auipc	a0,0x1
 16e:	92e50513          	addi	a0,a0,-1746 # a98 <malloc+0x16e>
 172:	00000097          	auipc	ra,0x0
 176:	6fa080e7          	jalr	1786(ra) # 86c <printf>
        exit(1);
 17a:	4505                	li	a0,1
 17c:	00000097          	auipc	ra,0x0
 180:	378080e7          	jalr	888(ra) # 4f4 <exit>
    printf("pipe() failed\n");
 184:	00001517          	auipc	a0,0x1
 188:	8fc50513          	addi	a0,a0,-1796 # a80 <malloc+0x156>
 18c:	00000097          	auipc	ra,0x0
 190:	6e0080e7          	jalr	1760(ra) # 86c <printf>
    exit(1);
 194:	4505                	li	a0,1
 196:	00000097          	auipc	ra,0x0
 19a:	35e080e7          	jalr	862(ra) # 4f4 <exit>
    printf("fork failed");
 19e:	00001517          	auipc	a0,0x1
 1a2:	88a50513          	addi	a0,a0,-1910 # a28 <malloc+0xfe>
 1a6:	00000097          	auipc	ra,0x0
 1aa:	6c6080e7          	jalr	1734(ra) # 86c <printf>
    exit(1);
 1ae:	4505                	li	a0,1
 1b0:	00000097          	auipc	ra,0x0
 1b4:	344080e7          	jalr	836(ra) # 4f4 <exit>
      if (a == (char *)0xffffffffffffffffL) exit(0);
 1b8:	4501                	li	a0,0
 1ba:	00000097          	auipc	ra,0x0
 1be:	33a080e7          	jalr	826(ra) # 4f4 <exit>
      }
    }
    exit(0);
  }
  close(fds[1]);
 1c2:	fc442503          	lw	a0,-60(s0)
 1c6:	00000097          	auipc	ra,0x0
 1ca:	356080e7          	jalr	854(ra) # 51c <close>
  while (1) {
    if (read(fds[0], buf, 1) != 1) {
 1ce:	4605                	li	a2,1
 1d0:	fc840593          	addi	a1,s0,-56
 1d4:	fc042503          	lw	a0,-64(s0)
 1d8:	00000097          	auipc	ra,0x0
 1dc:	334080e7          	jalr	820(ra) # 50c <read>
 1e0:	4785                	li	a5,1
 1e2:	00f51463          	bne	a0,a5,1ea <test1+0xf8>
      break;
    } else {
      tot += 1;
 1e6:	2485                	addiw	s1,s1,1
    if (read(fds[0], buf, 1) != 1) {
 1e8:	b7dd                	j	1ce <test1+0xdc>
    }
  }
  int n = (PHYSTOP - KERNBASE) / PGSIZE;
  printf("allocated %d out of %d pages\n", tot, n);
 1ea:	6621                	lui	a2,0x8
 1ec:	85a6                	mv	a1,s1
 1ee:	00001517          	auipc	a0,0x1
 1f2:	8ba50513          	addi	a0,a0,-1862 # aa8 <malloc+0x17e>
 1f6:	00000097          	auipc	ra,0x0
 1fa:	676080e7          	jalr	1654(ra) # 86c <printf>
  if (tot < 31950) {
 1fe:	67a1                	lui	a5,0x8
 200:	ccd78793          	addi	a5,a5,-819 # 7ccd <base+0x6cbd>
 204:	0297ca63          	blt	a5,s1,238 <test1+0x146>
    printf("expected to allocate at least 31950, only got %d\n", tot);
 208:	85a6                	mv	a1,s1
 20a:	00001517          	auipc	a0,0x1
 20e:	8be50513          	addi	a0,a0,-1858 # ac8 <malloc+0x19e>
 212:	00000097          	auipc	ra,0x0
 216:	65a080e7          	jalr	1626(ra) # 86c <printf>
    printf("memtest: FAILED\n");
 21a:	00001517          	auipc	a0,0x1
 21e:	8e650513          	addi	a0,a0,-1818 # b00 <malloc+0x1d6>
 222:	00000097          	auipc	ra,0x0
 226:	64a080e7          	jalr	1610(ra) # 86c <printf>
  } else {
    printf("memtest: OK\n");
  }
}
 22a:	70e2                	ld	ra,56(sp)
 22c:	7442                	ld	s0,48(sp)
 22e:	74a2                	ld	s1,40(sp)
 230:	7902                	ld	s2,32(sp)
 232:	69e2                	ld	s3,24(sp)
 234:	6121                	addi	sp,sp,64
 236:	8082                	ret
    printf("memtest: OK\n");
 238:	00001517          	auipc	a0,0x1
 23c:	8e050513          	addi	a0,a0,-1824 # b18 <malloc+0x1ee>
 240:	00000097          	auipc	ra,0x0
 244:	62c080e7          	jalr	1580(ra) # 86c <printf>
}
 248:	b7cd                	j	22a <test1+0x138>

000000000000024a <main>:

int main(int argc, char *argv[]) {
 24a:	1141                	addi	sp,sp,-16
 24c:	e406                	sd	ra,8(sp)
 24e:	e022                	sd	s0,0(sp)
 250:	0800                	addi	s0,sp,16
  test0();
 252:	00000097          	auipc	ra,0x0
 256:	dae080e7          	jalr	-594(ra) # 0 <test0>
  test1();
 25a:	00000097          	auipc	ra,0x0
 25e:	e98080e7          	jalr	-360(ra) # f2 <test1>
  exit(0);
 262:	4501                	li	a0,0
 264:	00000097          	auipc	ra,0x0
 268:	290080e7          	jalr	656(ra) # 4f4 <exit>

000000000000026c <_main>:
#include "user/user.h"

//
// wrapper so that it's OK if main() does not call exit().
//
void _main() {
 26c:	1141                	addi	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	addi	s0,sp,16
  extern int main();
  main();
 274:	00000097          	auipc	ra,0x0
 278:	fd6080e7          	jalr	-42(ra) # 24a <main>
  exit(0);
 27c:	4501                	li	a0,0
 27e:	00000097          	auipc	ra,0x0
 282:	276080e7          	jalr	630(ra) # 4f4 <exit>

0000000000000286 <strcpy>:
}

char *strcpy(char *s, const char *t) {
 286:	1141                	addi	sp,sp,-16
 288:	e422                	sd	s0,8(sp)
 28a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 28c:	87aa                	mv	a5,a0
 28e:	0585                	addi	a1,a1,1
 290:	0785                	addi	a5,a5,1
 292:	fff5c703          	lbu	a4,-1(a1)
 296:	fee78fa3          	sb	a4,-1(a5)
 29a:	fb75                	bnez	a4,28e <strcpy+0x8>
    ;
  return os;
}
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret

00000000000002a2 <strcmp>:

int strcmp(const char *p, const char *q) {
 2a2:	1141                	addi	sp,sp,-16
 2a4:	e422                	sd	s0,8(sp)
 2a6:	0800                	addi	s0,sp,16
  while (*p && *p == *q) p++, q++;
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	cb91                	beqz	a5,2c0 <strcmp+0x1e>
 2ae:	0005c703          	lbu	a4,0(a1)
 2b2:	00f71763          	bne	a4,a5,2c0 <strcmp+0x1e>
 2b6:	0505                	addi	a0,a0,1
 2b8:	0585                	addi	a1,a1,1
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	fbe5                	bnez	a5,2ae <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2c0:	0005c503          	lbu	a0,0(a1)
}
 2c4:	40a7853b          	subw	a0,a5,a0
 2c8:	6422                	ld	s0,8(sp)
 2ca:	0141                	addi	sp,sp,16
 2cc:	8082                	ret

00000000000002ce <strlen>:

uint strlen(const char *s) {
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 2d4:	00054783          	lbu	a5,0(a0)
 2d8:	cf91                	beqz	a5,2f4 <strlen+0x26>
 2da:	0505                	addi	a0,a0,1
 2dc:	87aa                	mv	a5,a0
 2de:	4685                	li	a3,1
 2e0:	9e89                	subw	a3,a3,a0
 2e2:	00f6853b          	addw	a0,a3,a5
 2e6:	0785                	addi	a5,a5,1
 2e8:	fff7c703          	lbu	a4,-1(a5)
 2ec:	fb7d                	bnez	a4,2e2 <strlen+0x14>
    ;
  return n;
}
 2ee:	6422                	ld	s0,8(sp)
 2f0:	0141                	addi	sp,sp,16
 2f2:	8082                	ret
  for (n = 0; s[n]; n++)
 2f4:	4501                	li	a0,0
 2f6:	bfe5                	j	2ee <strlen+0x20>

00000000000002f8 <memset>:

void *memset(void *dst, int c, uint n) {
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e422                	sd	s0,8(sp)
 2fc:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 2fe:	ca19                	beqz	a2,314 <memset+0x1c>
 300:	87aa                	mv	a5,a0
 302:	1602                	slli	a2,a2,0x20
 304:	9201                	srli	a2,a2,0x20
 306:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 30a:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 30e:	0785                	addi	a5,a5,1
 310:	fee79de3          	bne	a5,a4,30a <memset+0x12>
  }
  return dst;
}
 314:	6422                	ld	s0,8(sp)
 316:	0141                	addi	sp,sp,16
 318:	8082                	ret

000000000000031a <strchr>:

char *strchr(const char *s, char c) {
 31a:	1141                	addi	sp,sp,-16
 31c:	e422                	sd	s0,8(sp)
 31e:	0800                	addi	s0,sp,16
  for (; *s; s++)
 320:	00054783          	lbu	a5,0(a0)
 324:	cb99                	beqz	a5,33a <strchr+0x20>
    if (*s == c) return (char *)s;
 326:	00f58763          	beq	a1,a5,334 <strchr+0x1a>
  for (; *s; s++)
 32a:	0505                	addi	a0,a0,1
 32c:	00054783          	lbu	a5,0(a0)
 330:	fbfd                	bnez	a5,326 <strchr+0xc>
  return 0;
 332:	4501                	li	a0,0
}
 334:	6422                	ld	s0,8(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret
  return 0;
 33a:	4501                	li	a0,0
 33c:	bfe5                	j	334 <strchr+0x1a>

000000000000033e <gets>:

char *gets(char *buf, int max) {
 33e:	711d                	addi	sp,sp,-96
 340:	ec86                	sd	ra,88(sp)
 342:	e8a2                	sd	s0,80(sp)
 344:	e4a6                	sd	s1,72(sp)
 346:	e0ca                	sd	s2,64(sp)
 348:	fc4e                	sd	s3,56(sp)
 34a:	f852                	sd	s4,48(sp)
 34c:	f456                	sd	s5,40(sp)
 34e:	f05a                	sd	s6,32(sp)
 350:	ec5e                	sd	s7,24(sp)
 352:	1080                	addi	s0,sp,96
 354:	8baa                	mv	s7,a0
 356:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 358:	892a                	mv	s2,a0
 35a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1) break;
    buf[i++] = c;
    if (c == '\n' || c == '\r') break;
 35c:	4aa9                	li	s5,10
 35e:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
 360:	89a6                	mv	s3,s1
 362:	2485                	addiw	s1,s1,1
 364:	0344d863          	bge	s1,s4,394 <gets+0x56>
    cc = read(0, &c, 1);
 368:	4605                	li	a2,1
 36a:	faf40593          	addi	a1,s0,-81
 36e:	4501                	li	a0,0
 370:	00000097          	auipc	ra,0x0
 374:	19c080e7          	jalr	412(ra) # 50c <read>
    if (cc < 1) break;
 378:	00a05e63          	blez	a0,394 <gets+0x56>
    buf[i++] = c;
 37c:	faf44783          	lbu	a5,-81(s0)
 380:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r') break;
 384:	01578763          	beq	a5,s5,392 <gets+0x54>
 388:	0905                	addi	s2,s2,1
 38a:	fd679be3          	bne	a5,s6,360 <gets+0x22>
  for (i = 0; i + 1 < max;) {
 38e:	89a6                	mv	s3,s1
 390:	a011                	j	394 <gets+0x56>
 392:	89a6                	mv	s3,s1
  }
  buf[i] = '\0';
 394:	99de                	add	s3,s3,s7
 396:	00098023          	sb	zero,0(s3)
  return buf;
}
 39a:	855e                	mv	a0,s7
 39c:	60e6                	ld	ra,88(sp)
 39e:	6446                	ld	s0,80(sp)
 3a0:	64a6                	ld	s1,72(sp)
 3a2:	6906                	ld	s2,64(sp)
 3a4:	79e2                	ld	s3,56(sp)
 3a6:	7a42                	ld	s4,48(sp)
 3a8:	7aa2                	ld	s5,40(sp)
 3aa:	7b02                	ld	s6,32(sp)
 3ac:	6be2                	ld	s7,24(sp)
 3ae:	6125                	addi	sp,sp,96
 3b0:	8082                	ret

00000000000003b2 <stat>:

int stat(const char *n, struct stat *st) {
 3b2:	1101                	addi	sp,sp,-32
 3b4:	ec06                	sd	ra,24(sp)
 3b6:	e822                	sd	s0,16(sp)
 3b8:	e426                	sd	s1,8(sp)
 3ba:	e04a                	sd	s2,0(sp)
 3bc:	1000                	addi	s0,sp,32
 3be:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c0:	4581                	li	a1,0
 3c2:	00000097          	auipc	ra,0x0
 3c6:	172080e7          	jalr	370(ra) # 534 <open>
  if (fd < 0) return -1;
 3ca:	02054563          	bltz	a0,3f4 <stat+0x42>
 3ce:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 3d0:	85ca                	mv	a1,s2
 3d2:	00000097          	auipc	ra,0x0
 3d6:	17a080e7          	jalr	378(ra) # 54c <fstat>
 3da:	892a                	mv	s2,a0
  close(fd);
 3dc:	8526                	mv	a0,s1
 3de:	00000097          	auipc	ra,0x0
 3e2:	13e080e7          	jalr	318(ra) # 51c <close>
  return r;
}
 3e6:	854a                	mv	a0,s2
 3e8:	60e2                	ld	ra,24(sp)
 3ea:	6442                	ld	s0,16(sp)
 3ec:	64a2                	ld	s1,8(sp)
 3ee:	6902                	ld	s2,0(sp)
 3f0:	6105                	addi	sp,sp,32
 3f2:	8082                	ret
  if (fd < 0) return -1;
 3f4:	597d                	li	s2,-1
 3f6:	bfc5                	j	3e6 <stat+0x34>

00000000000003f8 <atoi>:

int atoi(const char *s) {
 3f8:	1141                	addi	sp,sp,-16
 3fa:	e422                	sd	s0,8(sp)
 3fc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
 3fe:	00054603          	lbu	a2,0(a0)
 402:	fd06079b          	addiw	a5,a2,-48
 406:	0ff7f793          	andi	a5,a5,255
 40a:	4725                	li	a4,9
 40c:	02f76963          	bltu	a4,a5,43e <atoi+0x46>
 410:	86aa                	mv	a3,a0
  n = 0;
 412:	4501                	li	a0,0
  while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
 414:	45a5                	li	a1,9
 416:	0685                	addi	a3,a3,1
 418:	0025179b          	slliw	a5,a0,0x2
 41c:	9fa9                	addw	a5,a5,a0
 41e:	0017979b          	slliw	a5,a5,0x1
 422:	9fb1                	addw	a5,a5,a2
 424:	fd07851b          	addiw	a0,a5,-48
 428:	0006c603          	lbu	a2,0(a3)
 42c:	fd06071b          	addiw	a4,a2,-48
 430:	0ff77713          	andi	a4,a4,255
 434:	fee5f1e3          	bgeu	a1,a4,416 <atoi+0x1e>
  return n;
}
 438:	6422                	ld	s0,8(sp)
 43a:	0141                	addi	sp,sp,16
 43c:	8082                	ret
  n = 0;
 43e:	4501                	li	a0,0
 440:	bfe5                	j	438 <atoi+0x40>

0000000000000442 <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 442:	1141                	addi	sp,sp,-16
 444:	e422                	sd	s0,8(sp)
 446:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 448:	02b57463          	bgeu	a0,a1,470 <memmove+0x2e>
    while (n-- > 0) *dst++ = *src++;
 44c:	00c05f63          	blez	a2,46a <memmove+0x28>
 450:	1602                	slli	a2,a2,0x20
 452:	9201                	srli	a2,a2,0x20
 454:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 458:	872a                	mv	a4,a0
    while (n-- > 0) *dst++ = *src++;
 45a:	0585                	addi	a1,a1,1
 45c:	0705                	addi	a4,a4,1
 45e:	fff5c683          	lbu	a3,-1(a1)
 462:	fed70fa3          	sb	a3,-1(a4)
 466:	fee79ae3          	bne	a5,a4,45a <memmove+0x18>
    dst += n;
    src += n;
    while (n-- > 0) *--dst = *--src;
  }
  return vdst;
}
 46a:	6422                	ld	s0,8(sp)
 46c:	0141                	addi	sp,sp,16
 46e:	8082                	ret
    dst += n;
 470:	00c50733          	add	a4,a0,a2
    src += n;
 474:	95b2                	add	a1,a1,a2
    while (n-- > 0) *--dst = *--src;
 476:	fec05ae3          	blez	a2,46a <memmove+0x28>
 47a:	fff6079b          	addiw	a5,a2,-1
 47e:	1782                	slli	a5,a5,0x20
 480:	9381                	srli	a5,a5,0x20
 482:	fff7c793          	not	a5,a5
 486:	97ba                	add	a5,a5,a4
 488:	15fd                	addi	a1,a1,-1
 48a:	177d                	addi	a4,a4,-1
 48c:	0005c683          	lbu	a3,0(a1)
 490:	00d70023          	sb	a3,0(a4)
 494:	fee79ae3          	bne	a5,a4,488 <memmove+0x46>
 498:	bfc9                	j	46a <memmove+0x28>

000000000000049a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 49a:	1141                	addi	sp,sp,-16
 49c:	e422                	sd	s0,8(sp)
 49e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4a0:	ca05                	beqz	a2,4d0 <memcmp+0x36>
 4a2:	fff6069b          	addiw	a3,a2,-1
 4a6:	1682                	slli	a3,a3,0x20
 4a8:	9281                	srli	a3,a3,0x20
 4aa:	0685                	addi	a3,a3,1
 4ac:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4ae:	00054783          	lbu	a5,0(a0)
 4b2:	0005c703          	lbu	a4,0(a1)
 4b6:	00e79863          	bne	a5,a4,4c6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4ba:	0505                	addi	a0,a0,1
    p2++;
 4bc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4be:	fed518e3          	bne	a0,a3,4ae <memcmp+0x14>
  }
  return 0;
 4c2:	4501                	li	a0,0
 4c4:	a019                	j	4ca <memcmp+0x30>
      return *p1 - *p2;
 4c6:	40e7853b          	subw	a0,a5,a4
}
 4ca:	6422                	ld	s0,8(sp)
 4cc:	0141                	addi	sp,sp,16
 4ce:	8082                	ret
  return 0;
 4d0:	4501                	li	a0,0
 4d2:	bfe5                	j	4ca <memcmp+0x30>

00000000000004d4 <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 4d4:	1141                	addi	sp,sp,-16
 4d6:	e406                	sd	ra,8(sp)
 4d8:	e022                	sd	s0,0(sp)
 4da:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4dc:	00000097          	auipc	ra,0x0
 4e0:	f66080e7          	jalr	-154(ra) # 442 <memmove>
}
 4e4:	60a2                	ld	ra,8(sp)
 4e6:	6402                	ld	s0,0(sp)
 4e8:	0141                	addi	sp,sp,16
 4ea:	8082                	ret

00000000000004ec <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4ec:	4885                	li	a7,1
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4f4:	4889                	li	a7,2
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <wait>:
.global wait
wait:
 li a7, SYS_wait
 4fc:	488d                	li	a7,3
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 504:	4891                	li	a7,4
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <read>:
.global read
read:
 li a7, SYS_read
 50c:	4895                	li	a7,5
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <write>:
.global write
write:
 li a7, SYS_write
 514:	48c1                	li	a7,16
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <close>:
.global close
close:
 li a7, SYS_close
 51c:	48d5                	li	a7,21
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <kill>:
.global kill
kill:
 li a7, SYS_kill
 524:	4899                	li	a7,6
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <exec>:
.global exec
exec:
 li a7, SYS_exec
 52c:	489d                	li	a7,7
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <open>:
.global open
open:
 li a7, SYS_open
 534:	48bd                	li	a7,15
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 53c:	48c5                	li	a7,17
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 544:	48c9                	li	a7,18
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 54c:	48a1                	li	a7,8
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <link>:
.global link
link:
 li a7, SYS_link
 554:	48cd                	li	a7,19
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 55c:	48d1                	li	a7,20
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 564:	48a5                	li	a7,9
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <dup>:
.global dup
dup:
 li a7, SYS_dup
 56c:	48a9                	li	a7,10
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 574:	48ad                	li	a7,11
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 57c:	48b1                	li	a7,12
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 584:	48b5                	li	a7,13
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 58c:	48b9                	li	a7,14
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <putc>:
#include "kernel/types.h"
#include "user/user.h"

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
 594:	1101                	addi	sp,sp,-32
 596:	ec06                	sd	ra,24(sp)
 598:	e822                	sd	s0,16(sp)
 59a:	1000                	addi	s0,sp,32
 59c:	feb407a3          	sb	a1,-17(s0)
 5a0:	4605                	li	a2,1
 5a2:	fef40593          	addi	a1,s0,-17
 5a6:	00000097          	auipc	ra,0x0
 5aa:	f6e080e7          	jalr	-146(ra) # 514 <write>
 5ae:	60e2                	ld	ra,24(sp)
 5b0:	6442                	ld	s0,16(sp)
 5b2:	6105                	addi	sp,sp,32
 5b4:	8082                	ret

00000000000005b6 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
 5b6:	7139                	addi	sp,sp,-64
 5b8:	fc06                	sd	ra,56(sp)
 5ba:	f822                	sd	s0,48(sp)
 5bc:	f426                	sd	s1,40(sp)
 5be:	f04a                	sd	s2,32(sp)
 5c0:	ec4e                	sd	s3,24(sp)
 5c2:	0080                	addi	s0,sp,64
 5c4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if (sgn && xx < 0) {
 5c6:	c299                	beqz	a3,5cc <printint+0x16>
 5c8:	0805c863          	bltz	a1,658 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5cc:	2581                	sext.w	a1,a1
  neg = 0;
 5ce:	4881                	li	a7,0
 5d0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5d4:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 5d6:	2601                	sext.w	a2,a2
 5d8:	00000517          	auipc	a0,0x0
 5dc:	55850513          	addi	a0,a0,1368 # b30 <digits>
 5e0:	883a                	mv	a6,a4
 5e2:	2705                	addiw	a4,a4,1
 5e4:	02c5f7bb          	remuw	a5,a1,a2
 5e8:	1782                	slli	a5,a5,0x20
 5ea:	9381                	srli	a5,a5,0x20
 5ec:	97aa                	add	a5,a5,a0
 5ee:	0007c783          	lbu	a5,0(a5)
 5f2:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 5f6:	0005879b          	sext.w	a5,a1
 5fa:	02c5d5bb          	divuw	a1,a1,a2
 5fe:	0685                	addi	a3,a3,1
 600:	fec7f0e3          	bgeu	a5,a2,5e0 <printint+0x2a>
  if (neg) buf[i++] = '-';
 604:	00088b63          	beqz	a7,61a <printint+0x64>
 608:	fd040793          	addi	a5,s0,-48
 60c:	973e                	add	a4,a4,a5
 60e:	02d00793          	li	a5,45
 612:	fef70823          	sb	a5,-16(a4)
 616:	0028071b          	addiw	a4,a6,2

  while (--i >= 0) putc(fd, buf[i]);
 61a:	02e05863          	blez	a4,64a <printint+0x94>
 61e:	fc040793          	addi	a5,s0,-64
 622:	00e78933          	add	s2,a5,a4
 626:	fff78993          	addi	s3,a5,-1
 62a:	99ba                	add	s3,s3,a4
 62c:	377d                	addiw	a4,a4,-1
 62e:	1702                	slli	a4,a4,0x20
 630:	9301                	srli	a4,a4,0x20
 632:	40e989b3          	sub	s3,s3,a4
 636:	fff94583          	lbu	a1,-1(s2)
 63a:	8526                	mv	a0,s1
 63c:	00000097          	auipc	ra,0x0
 640:	f58080e7          	jalr	-168(ra) # 594 <putc>
 644:	197d                	addi	s2,s2,-1
 646:	ff3918e3          	bne	s2,s3,636 <printint+0x80>
}
 64a:	70e2                	ld	ra,56(sp)
 64c:	7442                	ld	s0,48(sp)
 64e:	74a2                	ld	s1,40(sp)
 650:	7902                	ld	s2,32(sp)
 652:	69e2                	ld	s3,24(sp)
 654:	6121                	addi	sp,sp,64
 656:	8082                	ret
    x = -xx;
 658:	40b005bb          	negw	a1,a1
    neg = 1;
 65c:	4885                	li	a7,1
    x = -xx;
 65e:	bf8d                	j	5d0 <printint+0x1a>

0000000000000660 <vprintf>:
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
 660:	7119                	addi	sp,sp,-128
 662:	fc86                	sd	ra,120(sp)
 664:	f8a2                	sd	s0,112(sp)
 666:	f4a6                	sd	s1,104(sp)
 668:	f0ca                	sd	s2,96(sp)
 66a:	ecce                	sd	s3,88(sp)
 66c:	e8d2                	sd	s4,80(sp)
 66e:	e4d6                	sd	s5,72(sp)
 670:	e0da                	sd	s6,64(sp)
 672:	fc5e                	sd	s7,56(sp)
 674:	f862                	sd	s8,48(sp)
 676:	f466                	sd	s9,40(sp)
 678:	f06a                	sd	s10,32(sp)
 67a:	ec6e                	sd	s11,24(sp)
 67c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 67e:	0005c903          	lbu	s2,0(a1)
 682:	18090f63          	beqz	s2,820 <vprintf+0x1c0>
 686:	8aaa                	mv	s5,a0
 688:	8b32                	mv	s6,a2
 68a:	00158493          	addi	s1,a1,1
  state = 0;
 68e:	4981                	li	s3,0
      if (c == '%') {
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if (state == '%') {
 690:	02500a13          	li	s4,37
      if (c == 'd') {
 694:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c == 'l') {
 698:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if (c == 'x') {
 69c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if (c == 'p') {
 6a0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6a4:	00000b97          	auipc	s7,0x0
 6a8:	48cb8b93          	addi	s7,s7,1164 # b30 <digits>
 6ac:	a839                	j	6ca <vprintf+0x6a>
        putc(fd, c);
 6ae:	85ca                	mv	a1,s2
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	ee2080e7          	jalr	-286(ra) # 594 <putc>
 6ba:	a019                	j	6c0 <vprintf+0x60>
    } else if (state == '%') {
 6bc:	01498f63          	beq	s3,s4,6da <vprintf+0x7a>
  for (i = 0; fmt[i]; i++) {
 6c0:	0485                	addi	s1,s1,1
 6c2:	fff4c903          	lbu	s2,-1(s1)
 6c6:	14090d63          	beqz	s2,820 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6ca:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 6ce:	fe0997e3          	bnez	s3,6bc <vprintf+0x5c>
      if (c == '%') {
 6d2:	fd479ee3          	bne	a5,s4,6ae <vprintf+0x4e>
        state = '%';
 6d6:	89be                	mv	s3,a5
 6d8:	b7e5                	j	6c0 <vprintf+0x60>
      if (c == 'd') {
 6da:	05878063          	beq	a5,s8,71a <vprintf+0xba>
      } else if (c == 'l') {
 6de:	05978c63          	beq	a5,s9,736 <vprintf+0xd6>
      } else if (c == 'x') {
 6e2:	07a78863          	beq	a5,s10,752 <vprintf+0xf2>
      } else if (c == 'p') {
 6e6:	09b78463          	beq	a5,s11,76e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if (c == 's') {
 6ea:	07300713          	li	a4,115
 6ee:	0ce78663          	beq	a5,a4,7ba <vprintf+0x15a>
        if (s == 0) s = "(null)";
        while (*s != 0) {
          putc(fd, *s);
          s++;
        }
      } else if (c == 'c') {
 6f2:	06300713          	li	a4,99
 6f6:	0ee78e63          	beq	a5,a4,7f2 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if (c == '%') {
 6fa:	11478863          	beq	a5,s4,80a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6fe:	85d2                	mv	a1,s4
 700:	8556                	mv	a0,s5
 702:	00000097          	auipc	ra,0x0
 706:	e92080e7          	jalr	-366(ra) # 594 <putc>
        putc(fd, c);
 70a:	85ca                	mv	a1,s2
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	e86080e7          	jalr	-378(ra) # 594 <putc>
      }
      state = 0;
 716:	4981                	li	s3,0
 718:	b765                	j	6c0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 71a:	008b0913          	addi	s2,s6,8
 71e:	4685                	li	a3,1
 720:	4629                	li	a2,10
 722:	000b2583          	lw	a1,0(s6)
 726:	8556                	mv	a0,s5
 728:	00000097          	auipc	ra,0x0
 72c:	e8e080e7          	jalr	-370(ra) # 5b6 <printint>
 730:	8b4a                	mv	s6,s2
      state = 0;
 732:	4981                	li	s3,0
 734:	b771                	j	6c0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 736:	008b0913          	addi	s2,s6,8
 73a:	4681                	li	a3,0
 73c:	4629                	li	a2,10
 73e:	000b2583          	lw	a1,0(s6)
 742:	8556                	mv	a0,s5
 744:	00000097          	auipc	ra,0x0
 748:	e72080e7          	jalr	-398(ra) # 5b6 <printint>
 74c:	8b4a                	mv	s6,s2
      state = 0;
 74e:	4981                	li	s3,0
 750:	bf85                	j	6c0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 752:	008b0913          	addi	s2,s6,8
 756:	4681                	li	a3,0
 758:	4641                	li	a2,16
 75a:	000b2583          	lw	a1,0(s6)
 75e:	8556                	mv	a0,s5
 760:	00000097          	auipc	ra,0x0
 764:	e56080e7          	jalr	-426(ra) # 5b6 <printint>
 768:	8b4a                	mv	s6,s2
      state = 0;
 76a:	4981                	li	s3,0
 76c:	bf91                	j	6c0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 76e:	008b0793          	addi	a5,s6,8
 772:	f8f43423          	sd	a5,-120(s0)
 776:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 77a:	03000593          	li	a1,48
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	e14080e7          	jalr	-492(ra) # 594 <putc>
  putc(fd, 'x');
 788:	85ea                	mv	a1,s10
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e08080e7          	jalr	-504(ra) # 594 <putc>
 794:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 796:	03c9d793          	srli	a5,s3,0x3c
 79a:	97de                	add	a5,a5,s7
 79c:	0007c583          	lbu	a1,0(a5)
 7a0:	8556                	mv	a0,s5
 7a2:	00000097          	auipc	ra,0x0
 7a6:	df2080e7          	jalr	-526(ra) # 594 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7aa:	0992                	slli	s3,s3,0x4
 7ac:	397d                	addiw	s2,s2,-1
 7ae:	fe0914e3          	bnez	s2,796 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7b2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7b6:	4981                	li	s3,0
 7b8:	b721                	j	6c0 <vprintf+0x60>
        s = va_arg(ap, char *);
 7ba:	008b0993          	addi	s3,s6,8
 7be:	000b3903          	ld	s2,0(s6)
        if (s == 0) s = "(null)";
 7c2:	02090163          	beqz	s2,7e4 <vprintf+0x184>
        while (*s != 0) {
 7c6:	00094583          	lbu	a1,0(s2)
 7ca:	c9a1                	beqz	a1,81a <vprintf+0x1ba>
          putc(fd, *s);
 7cc:	8556                	mv	a0,s5
 7ce:	00000097          	auipc	ra,0x0
 7d2:	dc6080e7          	jalr	-570(ra) # 594 <putc>
          s++;
 7d6:	0905                	addi	s2,s2,1
        while (*s != 0) {
 7d8:	00094583          	lbu	a1,0(s2)
 7dc:	f9e5                	bnez	a1,7cc <vprintf+0x16c>
        s = va_arg(ap, char *);
 7de:	8b4e                	mv	s6,s3
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	bdf9                	j	6c0 <vprintf+0x60>
        if (s == 0) s = "(null)";
 7e4:	00000917          	auipc	s2,0x0
 7e8:	34490913          	addi	s2,s2,836 # b28 <malloc+0x1fe>
        while (*s != 0) {
 7ec:	02800593          	li	a1,40
 7f0:	bff1                	j	7cc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7f2:	008b0913          	addi	s2,s6,8
 7f6:	000b4583          	lbu	a1,0(s6)
 7fa:	8556                	mv	a0,s5
 7fc:	00000097          	auipc	ra,0x0
 800:	d98080e7          	jalr	-616(ra) # 594 <putc>
 804:	8b4a                	mv	s6,s2
      state = 0;
 806:	4981                	li	s3,0
 808:	bd65                	j	6c0 <vprintf+0x60>
        putc(fd, c);
 80a:	85d2                	mv	a1,s4
 80c:	8556                	mv	a0,s5
 80e:	00000097          	auipc	ra,0x0
 812:	d86080e7          	jalr	-634(ra) # 594 <putc>
      state = 0;
 816:	4981                	li	s3,0
 818:	b565                	j	6c0 <vprintf+0x60>
        s = va_arg(ap, char *);
 81a:	8b4e                	mv	s6,s3
      state = 0;
 81c:	4981                	li	s3,0
 81e:	b54d                	j	6c0 <vprintf+0x60>
    }
  }
}
 820:	70e6                	ld	ra,120(sp)
 822:	7446                	ld	s0,112(sp)
 824:	74a6                	ld	s1,104(sp)
 826:	7906                	ld	s2,96(sp)
 828:	69e6                	ld	s3,88(sp)
 82a:	6a46                	ld	s4,80(sp)
 82c:	6aa6                	ld	s5,72(sp)
 82e:	6b06                	ld	s6,64(sp)
 830:	7be2                	ld	s7,56(sp)
 832:	7c42                	ld	s8,48(sp)
 834:	7ca2                	ld	s9,40(sp)
 836:	7d02                	ld	s10,32(sp)
 838:	6de2                	ld	s11,24(sp)
 83a:	6109                	addi	sp,sp,128
 83c:	8082                	ret

000000000000083e <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
 83e:	715d                	addi	sp,sp,-80
 840:	ec06                	sd	ra,24(sp)
 842:	e822                	sd	s0,16(sp)
 844:	1000                	addi	s0,sp,32
 846:	e010                	sd	a2,0(s0)
 848:	e414                	sd	a3,8(s0)
 84a:	e818                	sd	a4,16(s0)
 84c:	ec1c                	sd	a5,24(s0)
 84e:	03043023          	sd	a6,32(s0)
 852:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 856:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 85a:	8622                	mv	a2,s0
 85c:	00000097          	auipc	ra,0x0
 860:	e04080e7          	jalr	-508(ra) # 660 <vprintf>
}
 864:	60e2                	ld	ra,24(sp)
 866:	6442                	ld	s0,16(sp)
 868:	6161                	addi	sp,sp,80
 86a:	8082                	ret

000000000000086c <printf>:

void printf(const char *fmt, ...) {
 86c:	711d                	addi	sp,sp,-96
 86e:	ec06                	sd	ra,24(sp)
 870:	e822                	sd	s0,16(sp)
 872:	1000                	addi	s0,sp,32
 874:	e40c                	sd	a1,8(s0)
 876:	e810                	sd	a2,16(s0)
 878:	ec14                	sd	a3,24(s0)
 87a:	f018                	sd	a4,32(s0)
 87c:	f41c                	sd	a5,40(s0)
 87e:	03043823          	sd	a6,48(s0)
 882:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 886:	00840613          	addi	a2,s0,8
 88a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 88e:	85aa                	mv	a1,a0
 890:	4505                	li	a0,1
 892:	00000097          	auipc	ra,0x0
 896:	dce080e7          	jalr	-562(ra) # 660 <vprintf>
}
 89a:	60e2                	ld	ra,24(sp)
 89c:	6442                	ld	s0,16(sp)
 89e:	6125                	addi	sp,sp,96
 8a0:	8082                	ret

00000000000008a2 <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
 8a2:	1141                	addi	sp,sp,-16
 8a4:	e422                	sd	s0,8(sp)
 8a6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 8a8:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ac:	00000797          	auipc	a5,0x0
 8b0:	7547b783          	ld	a5,1876(a5) # 1000 <freep>
 8b4:	a805                	j	8e4 <free+0x42>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
 8b6:	4618                	lw	a4,8(a2)
 8b8:	9db9                	addw	a1,a1,a4
 8ba:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8be:	6398                	ld	a4,0(a5)
 8c0:	6318                	ld	a4,0(a4)
 8c2:	fee53823          	sd	a4,-16(a0)
 8c6:	a091                	j	90a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
 8c8:	ff852703          	lw	a4,-8(a0)
 8cc:	9e39                	addw	a2,a2,a4
 8ce:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8d0:	ff053703          	ld	a4,-16(a0)
 8d4:	e398                	sd	a4,0(a5)
 8d6:	a099                	j	91c <free+0x7a>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
 8d8:	6398                	ld	a4,0(a5)
 8da:	00e7e463          	bltu	a5,a4,8e2 <free+0x40>
 8de:	00e6ea63          	bltu	a3,a4,8f2 <free+0x50>
void free(void *ap) {
 8e2:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e4:	fed7fae3          	bgeu	a5,a3,8d8 <free+0x36>
 8e8:	6398                	ld	a4,0(a5)
 8ea:	00e6e463          	bltu	a3,a4,8f2 <free+0x50>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
 8ee:	fee7eae3          	bltu	a5,a4,8e2 <free+0x40>
  if (bp + bp->s.size == p->s.ptr) {
 8f2:	ff852583          	lw	a1,-8(a0)
 8f6:	6390                	ld	a2,0(a5)
 8f8:	02059713          	slli	a4,a1,0x20
 8fc:	9301                	srli	a4,a4,0x20
 8fe:	0712                	slli	a4,a4,0x4
 900:	9736                	add	a4,a4,a3
 902:	fae60ae3          	beq	a2,a4,8b6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 906:	fec53823          	sd	a2,-16(a0)
  if (p + p->s.size == bp) {
 90a:	4790                	lw	a2,8(a5)
 90c:	02061713          	slli	a4,a2,0x20
 910:	9301                	srli	a4,a4,0x20
 912:	0712                	slli	a4,a4,0x4
 914:	973e                	add	a4,a4,a5
 916:	fae689e3          	beq	a3,a4,8c8 <free+0x26>
  } else
    p->s.ptr = bp;
 91a:	e394                	sd	a3,0(a5)
  freep = p;
 91c:	00000717          	auipc	a4,0x0
 920:	6ef73223          	sd	a5,1764(a4) # 1000 <freep>
}
 924:	6422                	ld	s0,8(sp)
 926:	0141                	addi	sp,sp,16
 928:	8082                	ret

000000000000092a <malloc>:
  hp->s.size = nu;
  free((void *)(hp + 1));
  return freep;
}

void *malloc(uint nbytes) {
 92a:	7139                	addi	sp,sp,-64
 92c:	fc06                	sd	ra,56(sp)
 92e:	f822                	sd	s0,48(sp)
 930:	f426                	sd	s1,40(sp)
 932:	f04a                	sd	s2,32(sp)
 934:	ec4e                	sd	s3,24(sp)
 936:	e852                	sd	s4,16(sp)
 938:	e456                	sd	s5,8(sp)
 93a:	e05a                	sd	s6,0(sp)
 93c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 93e:	02051493          	slli	s1,a0,0x20
 942:	9081                	srli	s1,s1,0x20
 944:	04bd                	addi	s1,s1,15
 946:	8091                	srli	s1,s1,0x4
 948:	0014899b          	addiw	s3,s1,1
 94c:	0485                	addi	s1,s1,1
  if ((prevp = freep) == 0) {
 94e:	00000517          	auipc	a0,0x0
 952:	6b253503          	ld	a0,1714(a0) # 1000 <freep>
 956:	c515                	beqz	a0,982 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 958:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 95a:	4798                	lw	a4,8(a5)
 95c:	02977f63          	bgeu	a4,s1,99a <malloc+0x70>
 960:	8a4e                	mv	s4,s3
 962:	0009871b          	sext.w	a4,s3
 966:	6685                	lui	a3,0x1
 968:	00d77363          	bgeu	a4,a3,96e <malloc+0x44>
 96c:	6a05                	lui	s4,0x1
 96e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 972:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 976:	00000917          	auipc	s2,0x0
 97a:	68a90913          	addi	s2,s2,1674 # 1000 <freep>
  if (p == (char *)-1) return 0;
 97e:	5afd                	li	s5,-1
 980:	a88d                	j	9f2 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 982:	00000797          	auipc	a5,0x0
 986:	68e78793          	addi	a5,a5,1678 # 1010 <base>
 98a:	00000717          	auipc	a4,0x0
 98e:	66f73b23          	sd	a5,1654(a4) # 1000 <freep>
 992:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 994:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 998:	b7e1                	j	960 <malloc+0x36>
      if (p->s.size == nunits)
 99a:	02e48b63          	beq	s1,a4,9d0 <malloc+0xa6>
        p->s.size -= nunits;
 99e:	4137073b          	subw	a4,a4,s3
 9a2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9a4:	1702                	slli	a4,a4,0x20
 9a6:	9301                	srli	a4,a4,0x20
 9a8:	0712                	slli	a4,a4,0x4
 9aa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9ac:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9b0:	00000717          	auipc	a4,0x0
 9b4:	64a73823          	sd	a0,1616(a4) # 1000 <freep>
      return (void *)(p + 1);
 9b8:	01078513          	addi	a0,a5,16
      if ((p = morecore(nunits)) == 0) return 0;
  }
}
 9bc:	70e2                	ld	ra,56(sp)
 9be:	7442                	ld	s0,48(sp)
 9c0:	74a2                	ld	s1,40(sp)
 9c2:	7902                	ld	s2,32(sp)
 9c4:	69e2                	ld	s3,24(sp)
 9c6:	6a42                	ld	s4,16(sp)
 9c8:	6aa2                	ld	s5,8(sp)
 9ca:	6b02                	ld	s6,0(sp)
 9cc:	6121                	addi	sp,sp,64
 9ce:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9d0:	6398                	ld	a4,0(a5)
 9d2:	e118                	sd	a4,0(a0)
 9d4:	bff1                	j	9b0 <malloc+0x86>
  hp->s.size = nu;
 9d6:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 9da:	0541                	addi	a0,a0,16
 9dc:	00000097          	auipc	ra,0x0
 9e0:	ec6080e7          	jalr	-314(ra) # 8a2 <free>
  return freep;
 9e4:	00093503          	ld	a0,0(s2)
      if ((p = morecore(nunits)) == 0) return 0;
 9e8:	d971                	beqz	a0,9bc <malloc+0x92>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 9ea:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 9ec:	4798                	lw	a4,8(a5)
 9ee:	fa9776e3          	bgeu	a4,s1,99a <malloc+0x70>
    if (p == freep)
 9f2:	00093703          	ld	a4,0(s2)
 9f6:	853e                	mv	a0,a5
 9f8:	fef719e3          	bne	a4,a5,9ea <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 9fc:	8552                	mv	a0,s4
 9fe:	00000097          	auipc	ra,0x0
 a02:	b7e080e7          	jalr	-1154(ra) # 57c <sbrk>
  if (p == (char *)-1) return 0;
 a06:	fd5518e3          	bne	a0,s5,9d6 <malloc+0xac>
      if ((p = morecore(nunits)) == 0) return 0;
 a0a:	4501                	li	a0,0
 a0c:	bf45                	j	9bc <malloc+0x92>
