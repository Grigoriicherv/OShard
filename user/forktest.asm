
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <forktest>:
#include "user/user.h"

#define N 4096
#define NMIN 2560

void forktest(void) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	1800                	addi	s0,sp,48
  int n, pid;

  int fd[2];
  char buf[1];
  if (pipe(fd) != 0) {
   c:	fd840513          	addi	a0,s0,-40
  10:	00000097          	auipc	ra,0x0
  14:	430080e7          	jalr	1072(ra) # 440 <pipe>
  18:	ed39                	bnez	a0,76 <forktest+0x76>
  1a:	84aa                	mv	s1,a0
    printf("pipe() failed\n");
    exit(1);
  }

  printf("forktest\n");
  1c:	00000517          	auipc	a0,0x0
  20:	7d450513          	addi	a0,a0,2004 # 7f0 <printf+0x48>
  24:	00000097          	auipc	ra,0x0
  28:	784080e7          	jalr	1924(ra) # 7a8 <printf>

  for (n = 0; n < N; n++) {
  2c:	6905                	lui	s2,0x1
    pid = fork();
  2e:	00000097          	auipc	ra,0x0
  32:	3fa080e7          	jalr	1018(ra) # 428 <fork>
    if (pid < 0) break;
  36:	08054163          	bltz	a0,b8 <forktest+0xb8>
    if (pid == 0) {
  3a:	c939                	beqz	a0,90 <forktest+0x90>
  for (n = 0; n < N; n++) {
  3c:	2485                	addiw	s1,s1,1
  3e:	ff2498e3          	bne	s1,s2,2e <forktest+0x2e>
      read(fd[0], buf, 1);
      exit(0);
    }
  }

  close(fd[0]);
  42:	fd842503          	lw	a0,-40(s0)
  46:	00000097          	auipc	ra,0x0
  4a:	412080e7          	jalr	1042(ra) # 458 <close>
  close(fd[1]);
  4e:	fdc42503          	lw	a0,-36(s0)
  52:	00000097          	auipc	ra,0x0
  56:	406080e7          	jalr	1030(ra) # 458 <close>

  if (n == N) {
    // 4096 processes take more space than available RAM
    printf("fork claimed to work %d times!\n", N);
  5a:	6585                	lui	a1,0x1
  5c:	00000517          	auipc	a0,0x0
  60:	7a450513          	addi	a0,a0,1956 # 800 <printf+0x58>
  64:	00000097          	auipc	ra,0x0
  68:	744080e7          	jalr	1860(ra) # 7a8 <printf>
    exit(1);
  6c:	4505                	li	a0,1
  6e:	00000097          	auipc	ra,0x0
  72:	3c2080e7          	jalr	962(ra) # 430 <exit>
    printf("pipe() failed\n");
  76:	00000517          	auipc	a0,0x0
  7a:	76a50513          	addi	a0,a0,1898 # 7e0 <printf+0x38>
  7e:	00000097          	auipc	ra,0x0
  82:	72a080e7          	jalr	1834(ra) # 7a8 <printf>
    exit(1);
  86:	4505                	li	a0,1
  88:	00000097          	auipc	ra,0x0
  8c:	3a8080e7          	jalr	936(ra) # 430 <exit>
      close(fd[1]);
  90:	fdc42503          	lw	a0,-36(s0)
  94:	00000097          	auipc	ra,0x0
  98:	3c4080e7          	jalr	964(ra) # 458 <close>
      read(fd[0], buf, 1);
  9c:	4605                	li	a2,1
  9e:	fd040593          	addi	a1,s0,-48
  a2:	fd842503          	lw	a0,-40(s0)
  a6:	00000097          	auipc	ra,0x0
  aa:	3a2080e7          	jalr	930(ra) # 448 <read>
      exit(0);
  ae:	4501                	li	a0,0
  b0:	00000097          	auipc	ra,0x0
  b4:	380080e7          	jalr	896(ra) # 430 <exit>
  close(fd[0]);
  b8:	fd842503          	lw	a0,-40(s0)
  bc:	00000097          	auipc	ra,0x0
  c0:	39c080e7          	jalr	924(ra) # 458 <close>
  close(fd[1]);
  c4:	fdc42503          	lw	a0,-36(s0)
  c8:	00000097          	auipc	ra,0x0
  cc:	390080e7          	jalr	912(ra) # 458 <close>
  if (n == N) {
  d0:	6785                	lui	a5,0x1
  d2:	f8f484e3          	beq	s1,a5,5a <forktest+0x5a>
  }

  printf("forked %d processes", n);
  d6:	85a6                	mv	a1,s1
  d8:	00000517          	auipc	a0,0x0
  dc:	74850513          	addi	a0,a0,1864 # 820 <printf+0x78>
  e0:	00000097          	auipc	ra,0x0
  e4:	6c8080e7          	jalr	1736(ra) # 7a8 <printf>
  if (n < NMIN) {
  e8:	6785                	lui	a5,0x1
  ea:	9ff78793          	addi	a5,a5,-1537 # 9ff <__BSS_END__+0x157>
  ee:	0497d963          	bge	a5,s1,140 <forktest+0x140>
    printf(", not enough\n");
    exit(1);
  }
  printf("\n");
  f2:	00000517          	auipc	a0,0x0
  f6:	70650513          	addi	a0,a0,1798 # 7f8 <printf+0x50>
  fa:	00000097          	auipc	ra,0x0
  fe:	6ae080e7          	jalr	1710(ra) # 7a8 <printf>

  for (; n > 0; n--) {
    if (wait(0) < 0) {
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	334080e7          	jalr	820(ra) # 438 <wait>
 10c:	04054763          	bltz	a0,15a <forktest+0x15a>
  for (; n > 0; n--) {
 110:	34fd                	addiw	s1,s1,-1
 112:	f8e5                	bnez	s1,102 <forktest+0x102>
      printf("wait stopped early\n");
      exit(1);
    }
  }

  if (wait(0) != -1) {
 114:	4501                	li	a0,0
 116:	00000097          	auipc	ra,0x0
 11a:	322080e7          	jalr	802(ra) # 438 <wait>
 11e:	57fd                	li	a5,-1
 120:	04f51a63          	bne	a0,a5,174 <forktest+0x174>
    printf("wait got too many\n");
    exit(1);
  }

  printf("forktest: OK\n");
 124:	00000517          	auipc	a0,0x0
 128:	75450513          	addi	a0,a0,1876 # 878 <printf+0xd0>
 12c:	00000097          	auipc	ra,0x0
 130:	67c080e7          	jalr	1660(ra) # 7a8 <printf>
}
 134:	70a2                	ld	ra,40(sp)
 136:	7402                	ld	s0,32(sp)
 138:	64e2                	ld	s1,24(sp)
 13a:	6942                	ld	s2,16(sp)
 13c:	6145                	addi	sp,sp,48
 13e:	8082                	ret
    printf(", not enough\n");
 140:	00000517          	auipc	a0,0x0
 144:	6f850513          	addi	a0,a0,1784 # 838 <printf+0x90>
 148:	00000097          	auipc	ra,0x0
 14c:	660080e7          	jalr	1632(ra) # 7a8 <printf>
    exit(1);
 150:	4505                	li	a0,1
 152:	00000097          	auipc	ra,0x0
 156:	2de080e7          	jalr	734(ra) # 430 <exit>
      printf("wait stopped early\n");
 15a:	00000517          	auipc	a0,0x0
 15e:	6ee50513          	addi	a0,a0,1774 # 848 <printf+0xa0>
 162:	00000097          	auipc	ra,0x0
 166:	646080e7          	jalr	1606(ra) # 7a8 <printf>
      exit(1);
 16a:	4505                	li	a0,1
 16c:	00000097          	auipc	ra,0x0
 170:	2c4080e7          	jalr	708(ra) # 430 <exit>
    printf("wait got too many\n");
 174:	00000517          	auipc	a0,0x0
 178:	6ec50513          	addi	a0,a0,1772 # 860 <printf+0xb8>
 17c:	00000097          	auipc	ra,0x0
 180:	62c080e7          	jalr	1580(ra) # 7a8 <printf>
    exit(1);
 184:	4505                	li	a0,1
 186:	00000097          	auipc	ra,0x0
 18a:	2aa080e7          	jalr	682(ra) # 430 <exit>

000000000000018e <main>:

int main(void) {
 18e:	1141                	addi	sp,sp,-16
 190:	e406                	sd	ra,8(sp)
 192:	e022                	sd	s0,0(sp)
 194:	0800                	addi	s0,sp,16
  forktest();
 196:	00000097          	auipc	ra,0x0
 19a:	e6a080e7          	jalr	-406(ra) # 0 <forktest>
  exit(0);
 19e:	4501                	li	a0,0
 1a0:	00000097          	auipc	ra,0x0
 1a4:	290080e7          	jalr	656(ra) # 430 <exit>

00000000000001a8 <_main>:
#include "user/user.h"

//
// wrapper so that it's OK if main() does not call exit().
//
void _main() {
 1a8:	1141                	addi	sp,sp,-16
 1aa:	e406                	sd	ra,8(sp)
 1ac:	e022                	sd	s0,0(sp)
 1ae:	0800                	addi	s0,sp,16
  extern int main();
  main();
 1b0:	00000097          	auipc	ra,0x0
 1b4:	fde080e7          	jalr	-34(ra) # 18e <main>
  exit(0);
 1b8:	4501                	li	a0,0
 1ba:	00000097          	auipc	ra,0x0
 1be:	276080e7          	jalr	630(ra) # 430 <exit>

00000000000001c2 <strcpy>:
}

char *strcpy(char *s, const char *t) {
 1c2:	1141                	addi	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 1c8:	87aa                	mv	a5,a0
 1ca:	0585                	addi	a1,a1,1
 1cc:	0785                	addi	a5,a5,1
 1ce:	fff5c703          	lbu	a4,-1(a1) # fff <__BSS_END__+0x757>
 1d2:	fee78fa3          	sb	a4,-1(a5)
 1d6:	fb75                	bnez	a4,1ca <strcpy+0x8>
    ;
  return os;
}
 1d8:	6422                	ld	s0,8(sp)
 1da:	0141                	addi	sp,sp,16
 1dc:	8082                	ret

00000000000001de <strcmp>:

int strcmp(const char *p, const char *q) {
 1de:	1141                	addi	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	addi	s0,sp,16
  while (*p && *p == *q) p++, q++;
 1e4:	00054783          	lbu	a5,0(a0)
 1e8:	cb91                	beqz	a5,1fc <strcmp+0x1e>
 1ea:	0005c703          	lbu	a4,0(a1)
 1ee:	00f71763          	bne	a4,a5,1fc <strcmp+0x1e>
 1f2:	0505                	addi	a0,a0,1
 1f4:	0585                	addi	a1,a1,1
 1f6:	00054783          	lbu	a5,0(a0)
 1fa:	fbe5                	bnez	a5,1ea <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1fc:	0005c503          	lbu	a0,0(a1)
}
 200:	40a7853b          	subw	a0,a5,a0
 204:	6422                	ld	s0,8(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret

000000000000020a <strlen>:

uint strlen(const char *s) {
 20a:	1141                	addi	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 210:	00054783          	lbu	a5,0(a0)
 214:	cf91                	beqz	a5,230 <strlen+0x26>
 216:	0505                	addi	a0,a0,1
 218:	87aa                	mv	a5,a0
 21a:	4685                	li	a3,1
 21c:	9e89                	subw	a3,a3,a0
 21e:	00f6853b          	addw	a0,a3,a5
 222:	0785                	addi	a5,a5,1
 224:	fff7c703          	lbu	a4,-1(a5)
 228:	fb7d                	bnez	a4,21e <strlen+0x14>
    ;
  return n;
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret
  for (n = 0; s[n]; n++)
 230:	4501                	li	a0,0
 232:	bfe5                	j	22a <strlen+0x20>

0000000000000234 <memset>:

void *memset(void *dst, int c, uint n) {
 234:	1141                	addi	sp,sp,-16
 236:	e422                	sd	s0,8(sp)
 238:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 23a:	ca19                	beqz	a2,250 <memset+0x1c>
 23c:	87aa                	mv	a5,a0
 23e:	1602                	slli	a2,a2,0x20
 240:	9201                	srli	a2,a2,0x20
 242:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 246:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 24a:	0785                	addi	a5,a5,1
 24c:	fee79de3          	bne	a5,a4,246 <memset+0x12>
  }
  return dst;
}
 250:	6422                	ld	s0,8(sp)
 252:	0141                	addi	sp,sp,16
 254:	8082                	ret

0000000000000256 <strchr>:

char *strchr(const char *s, char c) {
 256:	1141                	addi	sp,sp,-16
 258:	e422                	sd	s0,8(sp)
 25a:	0800                	addi	s0,sp,16
  for (; *s; s++)
 25c:	00054783          	lbu	a5,0(a0)
 260:	cb99                	beqz	a5,276 <strchr+0x20>
    if (*s == c) return (char *)s;
 262:	00f58763          	beq	a1,a5,270 <strchr+0x1a>
  for (; *s; s++)
 266:	0505                	addi	a0,a0,1
 268:	00054783          	lbu	a5,0(a0)
 26c:	fbfd                	bnez	a5,262 <strchr+0xc>
  return 0;
 26e:	4501                	li	a0,0
}
 270:	6422                	ld	s0,8(sp)
 272:	0141                	addi	sp,sp,16
 274:	8082                	ret
  return 0;
 276:	4501                	li	a0,0
 278:	bfe5                	j	270 <strchr+0x1a>

000000000000027a <gets>:

char *gets(char *buf, int max) {
 27a:	711d                	addi	sp,sp,-96
 27c:	ec86                	sd	ra,88(sp)
 27e:	e8a2                	sd	s0,80(sp)
 280:	e4a6                	sd	s1,72(sp)
 282:	e0ca                	sd	s2,64(sp)
 284:	fc4e                	sd	s3,56(sp)
 286:	f852                	sd	s4,48(sp)
 288:	f456                	sd	s5,40(sp)
 28a:	f05a                	sd	s6,32(sp)
 28c:	ec5e                	sd	s7,24(sp)
 28e:	1080                	addi	s0,sp,96
 290:	8baa                	mv	s7,a0
 292:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 294:	892a                	mv	s2,a0
 296:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1) break;
    buf[i++] = c;
    if (c == '\n' || c == '\r') break;
 298:	4aa9                	li	s5,10
 29a:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
 29c:	89a6                	mv	s3,s1
 29e:	2485                	addiw	s1,s1,1
 2a0:	0344d863          	bge	s1,s4,2d0 <gets+0x56>
    cc = read(0, &c, 1);
 2a4:	4605                	li	a2,1
 2a6:	faf40593          	addi	a1,s0,-81
 2aa:	4501                	li	a0,0
 2ac:	00000097          	auipc	ra,0x0
 2b0:	19c080e7          	jalr	412(ra) # 448 <read>
    if (cc < 1) break;
 2b4:	00a05e63          	blez	a0,2d0 <gets+0x56>
    buf[i++] = c;
 2b8:	faf44783          	lbu	a5,-81(s0)
 2bc:	00f90023          	sb	a5,0(s2) # 1000 <__BSS_END__+0x758>
    if (c == '\n' || c == '\r') break;
 2c0:	01578763          	beq	a5,s5,2ce <gets+0x54>
 2c4:	0905                	addi	s2,s2,1
 2c6:	fd679be3          	bne	a5,s6,29c <gets+0x22>
  for (i = 0; i + 1 < max;) {
 2ca:	89a6                	mv	s3,s1
 2cc:	a011                	j	2d0 <gets+0x56>
 2ce:	89a6                	mv	s3,s1
  }
  buf[i] = '\0';
 2d0:	99de                	add	s3,s3,s7
 2d2:	00098023          	sb	zero,0(s3)
  return buf;
}
 2d6:	855e                	mv	a0,s7
 2d8:	60e6                	ld	ra,88(sp)
 2da:	6446                	ld	s0,80(sp)
 2dc:	64a6                	ld	s1,72(sp)
 2de:	6906                	ld	s2,64(sp)
 2e0:	79e2                	ld	s3,56(sp)
 2e2:	7a42                	ld	s4,48(sp)
 2e4:	7aa2                	ld	s5,40(sp)
 2e6:	7b02                	ld	s6,32(sp)
 2e8:	6be2                	ld	s7,24(sp)
 2ea:	6125                	addi	sp,sp,96
 2ec:	8082                	ret

00000000000002ee <stat>:

int stat(const char *n, struct stat *st) {
 2ee:	1101                	addi	sp,sp,-32
 2f0:	ec06                	sd	ra,24(sp)
 2f2:	e822                	sd	s0,16(sp)
 2f4:	e426                	sd	s1,8(sp)
 2f6:	e04a                	sd	s2,0(sp)
 2f8:	1000                	addi	s0,sp,32
 2fa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2fc:	4581                	li	a1,0
 2fe:	00000097          	auipc	ra,0x0
 302:	172080e7          	jalr	370(ra) # 470 <open>
  if (fd < 0) return -1;
 306:	02054563          	bltz	a0,330 <stat+0x42>
 30a:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 30c:	85ca                	mv	a1,s2
 30e:	00000097          	auipc	ra,0x0
 312:	17a080e7          	jalr	378(ra) # 488 <fstat>
 316:	892a                	mv	s2,a0
  close(fd);
 318:	8526                	mv	a0,s1
 31a:	00000097          	auipc	ra,0x0
 31e:	13e080e7          	jalr	318(ra) # 458 <close>
  return r;
}
 322:	854a                	mv	a0,s2
 324:	60e2                	ld	ra,24(sp)
 326:	6442                	ld	s0,16(sp)
 328:	64a2                	ld	s1,8(sp)
 32a:	6902                	ld	s2,0(sp)
 32c:	6105                	addi	sp,sp,32
 32e:	8082                	ret
  if (fd < 0) return -1;
 330:	597d                	li	s2,-1
 332:	bfc5                	j	322 <stat+0x34>

0000000000000334 <atoi>:

int atoi(const char *s) {
 334:	1141                	addi	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
 33a:	00054603          	lbu	a2,0(a0)
 33e:	fd06079b          	addiw	a5,a2,-48
 342:	0ff7f793          	andi	a5,a5,255
 346:	4725                	li	a4,9
 348:	02f76963          	bltu	a4,a5,37a <atoi+0x46>
 34c:	86aa                	mv	a3,a0
  n = 0;
 34e:	4501                	li	a0,0
  while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
 350:	45a5                	li	a1,9
 352:	0685                	addi	a3,a3,1
 354:	0025179b          	slliw	a5,a0,0x2
 358:	9fa9                	addw	a5,a5,a0
 35a:	0017979b          	slliw	a5,a5,0x1
 35e:	9fb1                	addw	a5,a5,a2
 360:	fd07851b          	addiw	a0,a5,-48
 364:	0006c603          	lbu	a2,0(a3)
 368:	fd06071b          	addiw	a4,a2,-48
 36c:	0ff77713          	andi	a4,a4,255
 370:	fee5f1e3          	bgeu	a1,a4,352 <atoi+0x1e>
  return n;
}
 374:	6422                	ld	s0,8(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret
  n = 0;
 37a:	4501                	li	a0,0
 37c:	bfe5                	j	374 <atoi+0x40>

000000000000037e <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 37e:	1141                	addi	sp,sp,-16
 380:	e422                	sd	s0,8(sp)
 382:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 384:	02b57463          	bgeu	a0,a1,3ac <memmove+0x2e>
    while (n-- > 0) *dst++ = *src++;
 388:	00c05f63          	blez	a2,3a6 <memmove+0x28>
 38c:	1602                	slli	a2,a2,0x20
 38e:	9201                	srli	a2,a2,0x20
 390:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 394:	872a                	mv	a4,a0
    while (n-- > 0) *dst++ = *src++;
 396:	0585                	addi	a1,a1,1
 398:	0705                	addi	a4,a4,1
 39a:	fff5c683          	lbu	a3,-1(a1)
 39e:	fed70fa3          	sb	a3,-1(a4)
 3a2:	fee79ae3          	bne	a5,a4,396 <memmove+0x18>
    dst += n;
    src += n;
    while (n-- > 0) *--dst = *--src;
  }
  return vdst;
}
 3a6:	6422                	ld	s0,8(sp)
 3a8:	0141                	addi	sp,sp,16
 3aa:	8082                	ret
    dst += n;
 3ac:	00c50733          	add	a4,a0,a2
    src += n;
 3b0:	95b2                	add	a1,a1,a2
    while (n-- > 0) *--dst = *--src;
 3b2:	fec05ae3          	blez	a2,3a6 <memmove+0x28>
 3b6:	fff6079b          	addiw	a5,a2,-1
 3ba:	1782                	slli	a5,a5,0x20
 3bc:	9381                	srli	a5,a5,0x20
 3be:	fff7c793          	not	a5,a5
 3c2:	97ba                	add	a5,a5,a4
 3c4:	15fd                	addi	a1,a1,-1
 3c6:	177d                	addi	a4,a4,-1
 3c8:	0005c683          	lbu	a3,0(a1)
 3cc:	00d70023          	sb	a3,0(a4)
 3d0:	fee79ae3          	bne	a5,a4,3c4 <memmove+0x46>
 3d4:	bfc9                	j	3a6 <memmove+0x28>

00000000000003d6 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 3d6:	1141                	addi	sp,sp,-16
 3d8:	e422                	sd	s0,8(sp)
 3da:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3dc:	ca05                	beqz	a2,40c <memcmp+0x36>
 3de:	fff6069b          	addiw	a3,a2,-1
 3e2:	1682                	slli	a3,a3,0x20
 3e4:	9281                	srli	a3,a3,0x20
 3e6:	0685                	addi	a3,a3,1
 3e8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3ea:	00054783          	lbu	a5,0(a0)
 3ee:	0005c703          	lbu	a4,0(a1)
 3f2:	00e79863          	bne	a5,a4,402 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3f6:	0505                	addi	a0,a0,1
    p2++;
 3f8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3fa:	fed518e3          	bne	a0,a3,3ea <memcmp+0x14>
  }
  return 0;
 3fe:	4501                	li	a0,0
 400:	a019                	j	406 <memcmp+0x30>
      return *p1 - *p2;
 402:	40e7853b          	subw	a0,a5,a4
}
 406:	6422                	ld	s0,8(sp)
 408:	0141                	addi	sp,sp,16
 40a:	8082                	ret
  return 0;
 40c:	4501                	li	a0,0
 40e:	bfe5                	j	406 <memcmp+0x30>

0000000000000410 <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 410:	1141                	addi	sp,sp,-16
 412:	e406                	sd	ra,8(sp)
 414:	e022                	sd	s0,0(sp)
 416:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 418:	00000097          	auipc	ra,0x0
 41c:	f66080e7          	jalr	-154(ra) # 37e <memmove>
}
 420:	60a2                	ld	ra,8(sp)
 422:	6402                	ld	s0,0(sp)
 424:	0141                	addi	sp,sp,16
 426:	8082                	ret

0000000000000428 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 428:	4885                	li	a7,1
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <exit>:
.global exit
exit:
 li a7, SYS_exit
 430:	4889                	li	a7,2
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <wait>:
.global wait
wait:
 li a7, SYS_wait
 438:	488d                	li	a7,3
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 440:	4891                	li	a7,4
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <read>:
.global read
read:
 li a7, SYS_read
 448:	4895                	li	a7,5
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <write>:
.global write
write:
 li a7, SYS_write
 450:	48c1                	li	a7,16
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <close>:
.global close
close:
 li a7, SYS_close
 458:	48d5                	li	a7,21
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <kill>:
.global kill
kill:
 li a7, SYS_kill
 460:	4899                	li	a7,6
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <exec>:
.global exec
exec:
 li a7, SYS_exec
 468:	489d                	li	a7,7
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <open>:
.global open
open:
 li a7, SYS_open
 470:	48bd                	li	a7,15
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 478:	48c5                	li	a7,17
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 480:	48c9                	li	a7,18
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 488:	48a1                	li	a7,8
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <link>:
.global link
link:
 li a7, SYS_link
 490:	48cd                	li	a7,19
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 498:	48d1                	li	a7,20
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4a0:	48a5                	li	a7,9
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4a8:	48a9                	li	a7,10
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4b0:	48ad                	li	a7,11
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4b8:	48b1                	li	a7,12
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4c0:	48b5                	li	a7,13
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4c8:	48b9                	li	a7,14
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <putc>:
#include "kernel/types.h"
#include "user/user.h"

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
 4d0:	1101                	addi	sp,sp,-32
 4d2:	ec06                	sd	ra,24(sp)
 4d4:	e822                	sd	s0,16(sp)
 4d6:	1000                	addi	s0,sp,32
 4d8:	feb407a3          	sb	a1,-17(s0)
 4dc:	4605                	li	a2,1
 4de:	fef40593          	addi	a1,s0,-17
 4e2:	00000097          	auipc	ra,0x0
 4e6:	f6e080e7          	jalr	-146(ra) # 450 <write>
 4ea:	60e2                	ld	ra,24(sp)
 4ec:	6442                	ld	s0,16(sp)
 4ee:	6105                	addi	sp,sp,32
 4f0:	8082                	ret

00000000000004f2 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
 4f2:	7139                	addi	sp,sp,-64
 4f4:	fc06                	sd	ra,56(sp)
 4f6:	f822                	sd	s0,48(sp)
 4f8:	f426                	sd	s1,40(sp)
 4fa:	f04a                	sd	s2,32(sp)
 4fc:	ec4e                	sd	s3,24(sp)
 4fe:	0080                	addi	s0,sp,64
 500:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if (sgn && xx < 0) {
 502:	c299                	beqz	a3,508 <printint+0x16>
 504:	0805c863          	bltz	a1,594 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 508:	2581                	sext.w	a1,a1
  neg = 0;
 50a:	4881                	li	a7,0
 50c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 510:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 512:	2601                	sext.w	a2,a2
 514:	00000517          	auipc	a0,0x0
 518:	37c50513          	addi	a0,a0,892 # 890 <digits>
 51c:	883a                	mv	a6,a4
 51e:	2705                	addiw	a4,a4,1
 520:	02c5f7bb          	remuw	a5,a1,a2
 524:	1782                	slli	a5,a5,0x20
 526:	9381                	srli	a5,a5,0x20
 528:	97aa                	add	a5,a5,a0
 52a:	0007c783          	lbu	a5,0(a5)
 52e:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 532:	0005879b          	sext.w	a5,a1
 536:	02c5d5bb          	divuw	a1,a1,a2
 53a:	0685                	addi	a3,a3,1
 53c:	fec7f0e3          	bgeu	a5,a2,51c <printint+0x2a>
  if (neg) buf[i++] = '-';
 540:	00088b63          	beqz	a7,556 <printint+0x64>
 544:	fd040793          	addi	a5,s0,-48
 548:	973e                	add	a4,a4,a5
 54a:	02d00793          	li	a5,45
 54e:	fef70823          	sb	a5,-16(a4)
 552:	0028071b          	addiw	a4,a6,2

  while (--i >= 0) putc(fd, buf[i]);
 556:	02e05863          	blez	a4,586 <printint+0x94>
 55a:	fc040793          	addi	a5,s0,-64
 55e:	00e78933          	add	s2,a5,a4
 562:	fff78993          	addi	s3,a5,-1
 566:	99ba                	add	s3,s3,a4
 568:	377d                	addiw	a4,a4,-1
 56a:	1702                	slli	a4,a4,0x20
 56c:	9301                	srli	a4,a4,0x20
 56e:	40e989b3          	sub	s3,s3,a4
 572:	fff94583          	lbu	a1,-1(s2)
 576:	8526                	mv	a0,s1
 578:	00000097          	auipc	ra,0x0
 57c:	f58080e7          	jalr	-168(ra) # 4d0 <putc>
 580:	197d                	addi	s2,s2,-1
 582:	ff3918e3          	bne	s2,s3,572 <printint+0x80>
}
 586:	70e2                	ld	ra,56(sp)
 588:	7442                	ld	s0,48(sp)
 58a:	74a2                	ld	s1,40(sp)
 58c:	7902                	ld	s2,32(sp)
 58e:	69e2                	ld	s3,24(sp)
 590:	6121                	addi	sp,sp,64
 592:	8082                	ret
    x = -xx;
 594:	40b005bb          	negw	a1,a1
    neg = 1;
 598:	4885                	li	a7,1
    x = -xx;
 59a:	bf8d                	j	50c <printint+0x1a>

000000000000059c <vprintf>:
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
 59c:	7119                	addi	sp,sp,-128
 59e:	fc86                	sd	ra,120(sp)
 5a0:	f8a2                	sd	s0,112(sp)
 5a2:	f4a6                	sd	s1,104(sp)
 5a4:	f0ca                	sd	s2,96(sp)
 5a6:	ecce                	sd	s3,88(sp)
 5a8:	e8d2                	sd	s4,80(sp)
 5aa:	e4d6                	sd	s5,72(sp)
 5ac:	e0da                	sd	s6,64(sp)
 5ae:	fc5e                	sd	s7,56(sp)
 5b0:	f862                	sd	s8,48(sp)
 5b2:	f466                	sd	s9,40(sp)
 5b4:	f06a                	sd	s10,32(sp)
 5b6:	ec6e                	sd	s11,24(sp)
 5b8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 5ba:	0005c903          	lbu	s2,0(a1)
 5be:	18090f63          	beqz	s2,75c <vprintf+0x1c0>
 5c2:	8aaa                	mv	s5,a0
 5c4:	8b32                	mv	s6,a2
 5c6:	00158493          	addi	s1,a1,1
  state = 0;
 5ca:	4981                	li	s3,0
      if (c == '%') {
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if (state == '%') {
 5cc:	02500a13          	li	s4,37
      if (c == 'd') {
 5d0:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c == 'l') {
 5d4:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if (c == 'x') {
 5d8:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if (c == 'p') {
 5dc:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5e0:	00000b97          	auipc	s7,0x0
 5e4:	2b0b8b93          	addi	s7,s7,688 # 890 <digits>
 5e8:	a839                	j	606 <vprintf+0x6a>
        putc(fd, c);
 5ea:	85ca                	mv	a1,s2
 5ec:	8556                	mv	a0,s5
 5ee:	00000097          	auipc	ra,0x0
 5f2:	ee2080e7          	jalr	-286(ra) # 4d0 <putc>
 5f6:	a019                	j	5fc <vprintf+0x60>
    } else if (state == '%') {
 5f8:	01498f63          	beq	s3,s4,616 <vprintf+0x7a>
  for (i = 0; fmt[i]; i++) {
 5fc:	0485                	addi	s1,s1,1
 5fe:	fff4c903          	lbu	s2,-1(s1)
 602:	14090d63          	beqz	s2,75c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 606:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 60a:	fe0997e3          	bnez	s3,5f8 <vprintf+0x5c>
      if (c == '%') {
 60e:	fd479ee3          	bne	a5,s4,5ea <vprintf+0x4e>
        state = '%';
 612:	89be                	mv	s3,a5
 614:	b7e5                	j	5fc <vprintf+0x60>
      if (c == 'd') {
 616:	05878063          	beq	a5,s8,656 <vprintf+0xba>
      } else if (c == 'l') {
 61a:	05978c63          	beq	a5,s9,672 <vprintf+0xd6>
      } else if (c == 'x') {
 61e:	07a78863          	beq	a5,s10,68e <vprintf+0xf2>
      } else if (c == 'p') {
 622:	09b78463          	beq	a5,s11,6aa <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if (c == 's') {
 626:	07300713          	li	a4,115
 62a:	0ce78663          	beq	a5,a4,6f6 <vprintf+0x15a>
        if (s == 0) s = "(null)";
        while (*s != 0) {
          putc(fd, *s);
          s++;
        }
      } else if (c == 'c') {
 62e:	06300713          	li	a4,99
 632:	0ee78e63          	beq	a5,a4,72e <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if (c == '%') {
 636:	11478863          	beq	a5,s4,746 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63a:	85d2                	mv	a1,s4
 63c:	8556                	mv	a0,s5
 63e:	00000097          	auipc	ra,0x0
 642:	e92080e7          	jalr	-366(ra) # 4d0 <putc>
        putc(fd, c);
 646:	85ca                	mv	a1,s2
 648:	8556                	mv	a0,s5
 64a:	00000097          	auipc	ra,0x0
 64e:	e86080e7          	jalr	-378(ra) # 4d0 <putc>
      }
      state = 0;
 652:	4981                	li	s3,0
 654:	b765                	j	5fc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 656:	008b0913          	addi	s2,s6,8
 65a:	4685                	li	a3,1
 65c:	4629                	li	a2,10
 65e:	000b2583          	lw	a1,0(s6)
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	e8e080e7          	jalr	-370(ra) # 4f2 <printint>
 66c:	8b4a                	mv	s6,s2
      state = 0;
 66e:	4981                	li	s3,0
 670:	b771                	j	5fc <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 672:	008b0913          	addi	s2,s6,8
 676:	4681                	li	a3,0
 678:	4629                	li	a2,10
 67a:	000b2583          	lw	a1,0(s6)
 67e:	8556                	mv	a0,s5
 680:	00000097          	auipc	ra,0x0
 684:	e72080e7          	jalr	-398(ra) # 4f2 <printint>
 688:	8b4a                	mv	s6,s2
      state = 0;
 68a:	4981                	li	s3,0
 68c:	bf85                	j	5fc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 68e:	008b0913          	addi	s2,s6,8
 692:	4681                	li	a3,0
 694:	4641                	li	a2,16
 696:	000b2583          	lw	a1,0(s6)
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	e56080e7          	jalr	-426(ra) # 4f2 <printint>
 6a4:	8b4a                	mv	s6,s2
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	bf91                	j	5fc <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6aa:	008b0793          	addi	a5,s6,8
 6ae:	f8f43423          	sd	a5,-120(s0)
 6b2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6b6:	03000593          	li	a1,48
 6ba:	8556                	mv	a0,s5
 6bc:	00000097          	auipc	ra,0x0
 6c0:	e14080e7          	jalr	-492(ra) # 4d0 <putc>
  putc(fd, 'x');
 6c4:	85ea                	mv	a1,s10
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	e08080e7          	jalr	-504(ra) # 4d0 <putc>
 6d0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d2:	03c9d793          	srli	a5,s3,0x3c
 6d6:	97de                	add	a5,a5,s7
 6d8:	0007c583          	lbu	a1,0(a5)
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	df2080e7          	jalr	-526(ra) # 4d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e6:	0992                	slli	s3,s3,0x4
 6e8:	397d                	addiw	s2,s2,-1
 6ea:	fe0914e3          	bnez	s2,6d2 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6ee:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b721                	j	5fc <vprintf+0x60>
        s = va_arg(ap, char *);
 6f6:	008b0993          	addi	s3,s6,8
 6fa:	000b3903          	ld	s2,0(s6)
        if (s == 0) s = "(null)";
 6fe:	02090163          	beqz	s2,720 <vprintf+0x184>
        while (*s != 0) {
 702:	00094583          	lbu	a1,0(s2)
 706:	c9a1                	beqz	a1,756 <vprintf+0x1ba>
          putc(fd, *s);
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	dc6080e7          	jalr	-570(ra) # 4d0 <putc>
          s++;
 712:	0905                	addi	s2,s2,1
        while (*s != 0) {
 714:	00094583          	lbu	a1,0(s2)
 718:	f9e5                	bnez	a1,708 <vprintf+0x16c>
        s = va_arg(ap, char *);
 71a:	8b4e                	mv	s6,s3
      state = 0;
 71c:	4981                	li	s3,0
 71e:	bdf9                	j	5fc <vprintf+0x60>
        if (s == 0) s = "(null)";
 720:	00000917          	auipc	s2,0x0
 724:	16890913          	addi	s2,s2,360 # 888 <printf+0xe0>
        while (*s != 0) {
 728:	02800593          	li	a1,40
 72c:	bff1                	j	708 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 72e:	008b0913          	addi	s2,s6,8
 732:	000b4583          	lbu	a1,0(s6)
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	d98080e7          	jalr	-616(ra) # 4d0 <putc>
 740:	8b4a                	mv	s6,s2
      state = 0;
 742:	4981                	li	s3,0
 744:	bd65                	j	5fc <vprintf+0x60>
        putc(fd, c);
 746:	85d2                	mv	a1,s4
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	d86080e7          	jalr	-634(ra) # 4d0 <putc>
      state = 0;
 752:	4981                	li	s3,0
 754:	b565                	j	5fc <vprintf+0x60>
        s = va_arg(ap, char *);
 756:	8b4e                	mv	s6,s3
      state = 0;
 758:	4981                	li	s3,0
 75a:	b54d                	j	5fc <vprintf+0x60>
    }
  }
}
 75c:	70e6                	ld	ra,120(sp)
 75e:	7446                	ld	s0,112(sp)
 760:	74a6                	ld	s1,104(sp)
 762:	7906                	ld	s2,96(sp)
 764:	69e6                	ld	s3,88(sp)
 766:	6a46                	ld	s4,80(sp)
 768:	6aa6                	ld	s5,72(sp)
 76a:	6b06                	ld	s6,64(sp)
 76c:	7be2                	ld	s7,56(sp)
 76e:	7c42                	ld	s8,48(sp)
 770:	7ca2                	ld	s9,40(sp)
 772:	7d02                	ld	s10,32(sp)
 774:	6de2                	ld	s11,24(sp)
 776:	6109                	addi	sp,sp,128
 778:	8082                	ret

000000000000077a <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
 77a:	715d                	addi	sp,sp,-80
 77c:	ec06                	sd	ra,24(sp)
 77e:	e822                	sd	s0,16(sp)
 780:	1000                	addi	s0,sp,32
 782:	e010                	sd	a2,0(s0)
 784:	e414                	sd	a3,8(s0)
 786:	e818                	sd	a4,16(s0)
 788:	ec1c                	sd	a5,24(s0)
 78a:	03043023          	sd	a6,32(s0)
 78e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 792:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 796:	8622                	mv	a2,s0
 798:	00000097          	auipc	ra,0x0
 79c:	e04080e7          	jalr	-508(ra) # 59c <vprintf>
}
 7a0:	60e2                	ld	ra,24(sp)
 7a2:	6442                	ld	s0,16(sp)
 7a4:	6161                	addi	sp,sp,80
 7a6:	8082                	ret

00000000000007a8 <printf>:

void printf(const char *fmt, ...) {
 7a8:	711d                	addi	sp,sp,-96
 7aa:	ec06                	sd	ra,24(sp)
 7ac:	e822                	sd	s0,16(sp)
 7ae:	1000                	addi	s0,sp,32
 7b0:	e40c                	sd	a1,8(s0)
 7b2:	e810                	sd	a2,16(s0)
 7b4:	ec14                	sd	a3,24(s0)
 7b6:	f018                	sd	a4,32(s0)
 7b8:	f41c                	sd	a5,40(s0)
 7ba:	03043823          	sd	a6,48(s0)
 7be:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7c2:	00840613          	addi	a2,s0,8
 7c6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7ca:	85aa                	mv	a1,a0
 7cc:	4505                	li	a0,1
 7ce:	00000097          	auipc	ra,0x0
 7d2:	dce080e7          	jalr	-562(ra) # 59c <vprintf>
}
 7d6:	60e2                	ld	ra,24(sp)
 7d8:	6442                	ld	s0,16(sp)
 7da:	6125                	addi	sp,sp,96
 7dc:	8082                	ret
