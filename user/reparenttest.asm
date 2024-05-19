
user/_reparenttest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <allocate>:
// childrens and abandons all of them. Children should be reparented
// to initproc and gracefully waited.

#include "user/user.h"

void allocate(int cnt) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	1800                	addi	s0,sp,48
   c:	892a                	mv	s2,a0
  int n, pid;

  int fd[2];
  char buf[1];
  if (pipe(fd) != 0) {
   e:	fd840513          	addi	a0,s0,-40
  12:	00000097          	auipc	ra,0x0
  16:	5c6080e7          	jalr	1478(ra) # 5d8 <pipe>
  1a:	e11d                	bnez	a0,40 <allocate+0x40>
  1c:	84aa                	mv	s1,a0
    printf("pipe() failed\n");
    exit(1);
  }

  for (n = 0; n < cnt; n++) {
  1e:	01205c63          	blez	s2,36 <allocate+0x36>
    pid = fork();
  22:	00000097          	auipc	ra,0x0
  26:	59e080e7          	jalr	1438(ra) # 5c0 <fork>
    if (pid < 0) break;
  2a:	04054c63          	bltz	a0,82 <allocate+0x82>
    if (pid == 0) {
  2e:	c515                	beqz	a0,5a <allocate+0x5a>
  for (n = 0; n < cnt; n++) {
  30:	2485                	addiw	s1,s1,1
  32:	fe9918e3          	bne	s2,s1,22 <allocate+0x22>

  if (n < cnt) {
    exit(1);
  }

  exit(0);
  36:	4501                	li	a0,0
  38:	00000097          	auipc	ra,0x0
  3c:	590080e7          	jalr	1424(ra) # 5c8 <exit>
    printf("pipe() failed\n");
  40:	00001517          	auipc	a0,0x1
  44:	ab050513          	addi	a0,a0,-1360 # af0 <malloc+0xf2>
  48:	00001097          	auipc	ra,0x1
  4c:	8f8080e7          	jalr	-1800(ra) # 940 <printf>
    exit(1);
  50:	4505                	li	a0,1
  52:	00000097          	auipc	ra,0x0
  56:	576080e7          	jalr	1398(ra) # 5c8 <exit>
      close(fd[1]);
  5a:	fdc42503          	lw	a0,-36(s0)
  5e:	00000097          	auipc	ra,0x0
  62:	592080e7          	jalr	1426(ra) # 5f0 <close>
      read(fd[0], buf, 1);
  66:	4605                	li	a2,1
  68:	fd040593          	addi	a1,s0,-48
  6c:	fd842503          	lw	a0,-40(s0)
  70:	00000097          	auipc	ra,0x0
  74:	570080e7          	jalr	1392(ra) # 5e0 <read>
      exit(0);
  78:	4501                	li	a0,0
  7a:	00000097          	auipc	ra,0x0
  7e:	54e080e7          	jalr	1358(ra) # 5c8 <exit>
  if (n < cnt) {
  82:	fb24dae3          	bge	s1,s2,36 <allocate+0x36>
    exit(1);
  86:	4505                	li	a0,1
  88:	00000097          	auipc	ra,0x0
  8c:	540080e7          	jalr	1344(ra) # 5c8 <exit>

0000000000000090 <small>:
}

void small(const char* s) {
  90:	7119                	addi	sp,sp,-128
  92:	fc86                	sd	ra,120(sp)
  94:	f8a2                	sd	s0,112(sp)
  96:	f4a6                	sd	s1,104(sp)
  98:	f0ca                	sd	s2,96(sp)
  9a:	ecce                	sd	s3,88(sp)
  9c:	e8d2                	sd	s4,80(sp)
  9e:	e4d6                	sd	s5,72(sp)
  a0:	e0da                	sd	s6,64(sp)
  a2:	fc5e                	sd	s7,56(sp)
  a4:	f862                	sd	s8,48(sp)
  a6:	f466                	sd	s9,40(sp)
  a8:	f06a                	sd	s10,32(sp)
  aa:	ec6e                	sd	s11,24(sp)
  ac:	0100                	addi	s0,sp,128
  ae:	8a2a                	mv	s4,a0
  for (int test = 0; test < 20; test++) {
  b0:	4b01                	li	s6,0
    printf("%s: small test %d\n", s, test + 1);
  b2:	00001c97          	auipc	s9,0x1
  b6:	a4ec8c93          	addi	s9,s9,-1458 # b00 <malloc+0x102>
    // and then quit.

    int i;
    int failed = 0;
    int uncompleted = 0;
    for (i = 0; i < 10; i++) {
  ba:	4aa9                	li	s5,10
      int pid = fork();

      if (pid < 0) {
        printf("%s: could not fork\n", s);
        failed = 1;
  bc:	4985                	li	s3,1

    for (int j = 0; j < i; j++) {
      int status;
      int c = wait(&status);
      if (c < 0) {
        printf("%s: lost children\n", s);
  be:	00001c17          	auipc	s8,0x1
  c2:	a72c0c13          	addi	s8,s8,-1422 # b30 <malloc+0x132>
        failed = 1;
      }
      if (status != 0 && status != 1) {
        printf("%s: unexpected exit status %d\n", s, status);
  c6:	00001b97          	auipc	s7,0x1
  ca:	a82b8b93          	addi	s7,s7,-1406 # b48 <malloc+0x14a>
  ce:	a079                	j	15c <small+0xcc>
        printf("%s: could not fork\n", s);
  d0:	85d2                	mv	a1,s4
  d2:	00001517          	auipc	a0,0x1
  d6:	a4650513          	addi	a0,a0,-1466 # b18 <malloc+0x11a>
  da:	00001097          	auipc	ra,0x1
  de:	866080e7          	jalr	-1946(ra) # 940 <printf>
    for (int j = 0; j < i; j++) {
  e2:	0a905463          	blez	s1,18a <small+0xfa>
        failed = 1;
  e6:	8dce                	mv	s11,s3
  e8:	a871                	j	184 <small+0xf4>
        allocate(32);
  ea:	02000513          	li	a0,32
  ee:	00000097          	auipc	ra,0x0
  f2:	f12080e7          	jalr	-238(ra) # 0 <allocate>
        printf("%s: lost children\n", s);
  f6:	85d2                	mv	a1,s4
  f8:	8562                	mv	a0,s8
  fa:	00001097          	auipc	ra,0x1
  fe:	846080e7          	jalr	-1978(ra) # 940 <printf>
        failed = 1;
 102:	8dce                	mv	s11,s3
 104:	a80d                	j	136 <small+0xa6>
        printf("%s: unexpected exit status %d\n", s, status);
 106:	85d2                	mv	a1,s4
 108:	855e                	mv	a0,s7
 10a:	00001097          	auipc	ra,0x1
 10e:	836080e7          	jalr	-1994(ra) # 940 <printf>
        failed = 1;
      }
      uncompleted += status;
 112:	f8c42783          	lw	a5,-116(s0)
 116:	01a78d3b          	addw	s10,a5,s10
    for (int j = 0; j < i; j++) {
 11a:	0009079b          	sext.w	a5,s2
 11e:	0697d663          	bge	a5,s1,18a <small+0xfa>
        failed = 1;
 122:	8dce                	mv	s11,s3
 124:	2905                	addiw	s2,s2,1
      int c = wait(&status);
 126:	f8c40513          	addi	a0,s0,-116
 12a:	00000097          	auipc	ra,0x0
 12e:	4a6080e7          	jalr	1190(ra) # 5d0 <wait>
      if (c < 0) {
 132:	fc0542e3          	bltz	a0,f6 <small+0x66>
      if (status != 0 && status != 1) {
 136:	f8c42603          	lw	a2,-116(s0)
 13a:	0006079b          	sext.w	a5,a2
 13e:	fcf9e4e3          	bltu	s3,a5,106 <small+0x76>
      uncompleted += status;
 142:	01a60d3b          	addw	s10,a2,s10
    for (int j = 0; j < i; j++) {
 146:	0009079b          	sext.w	a5,s2
 14a:	fc97cde3          	blt	a5,s1,124 <small+0x94>
    }

    if (failed) {
 14e:	020d9e63          	bnez	s11,18a <small+0xfa>
      exit(1);
    }

    if (uncompleted > 0) {
 152:	05a04163          	bgtz	s10,194 <small+0x104>
  for (int test = 0; test < 20; test++) {
 156:	47d1                	li	a5,20
 158:	04fb0963          	beq	s6,a5,1aa <small+0x11a>
    printf("%s: small test %d\n", s, test + 1);
 15c:	2b05                	addiw	s6,s6,1
 15e:	865a                	mv	a2,s6
 160:	85d2                	mv	a1,s4
 162:	8566                	mv	a0,s9
 164:	00000097          	auipc	ra,0x0
 168:	7dc080e7          	jalr	2012(ra) # 940 <printf>
    for (i = 0; i < 10; i++) {
 16c:	4481                	li	s1,0
      int pid = fork();
 16e:	00000097          	auipc	ra,0x0
 172:	452080e7          	jalr	1106(ra) # 5c0 <fork>
      if (pid < 0) {
 176:	f4054de3          	bltz	a0,d0 <small+0x40>
      if (pid == 0) {
 17a:	d925                	beqz	a0,ea <small+0x5a>
    for (i = 0; i < 10; i++) {
 17c:	2485                	addiw	s1,s1,1
 17e:	ff5498e3          	bne	s1,s5,16e <small+0xde>
    int failed = 0;
 182:	4d81                	li	s11,0
 184:	894e                	mv	s2,s3
 186:	4d01                	li	s10,0
 188:	bf79                	j	126 <small+0x96>
      exit(1);
 18a:	4505                	li	a0,1
 18c:	00000097          	auipc	ra,0x0
 190:	43c080e7          	jalr	1084(ra) # 5c8 <exit>
      printf("%s: %d masters failed to allocate processes\n", s, uncompleted);
 194:	866a                	mv	a2,s10
 196:	85d2                	mv	a1,s4
 198:	00001517          	auipc	a0,0x1
 19c:	9d050513          	addi	a0,a0,-1584 # b68 <malloc+0x16a>
 1a0:	00000097          	auipc	ra,0x0
 1a4:	7a0080e7          	jalr	1952(ra) # 940 <printf>
 1a8:	b77d                	j	156 <small+0xc6>
    }
  }
}
 1aa:	70e6                	ld	ra,120(sp)
 1ac:	7446                	ld	s0,112(sp)
 1ae:	74a6                	ld	s1,104(sp)
 1b0:	7906                	ld	s2,96(sp)
 1b2:	69e6                	ld	s3,88(sp)
 1b4:	6a46                	ld	s4,80(sp)
 1b6:	6aa6                	ld	s5,72(sp)
 1b8:	6b06                	ld	s6,64(sp)
 1ba:	7be2                	ld	s7,56(sp)
 1bc:	7c42                	ld	s8,48(sp)
 1be:	7ca2                	ld	s9,40(sp)
 1c0:	7d02                	ld	s10,32(sp)
 1c2:	6de2                	ld	s11,24(sp)
 1c4:	6109                	addi	sp,sp,128
 1c6:	8082                	ret

00000000000001c8 <big>:

void big(const char* s) {
 1c8:	7139                	addi	sp,sp,-64
 1ca:	fc06                	sd	ra,56(sp)
 1cc:	f822                	sd	s0,48(sp)
 1ce:	f426                	sd	s1,40(sp)
 1d0:	f04a                	sd	s2,32(sp)
 1d2:	ec4e                	sd	s3,24(sp)
 1d4:	e852                	sd	s4,16(sp)
 1d6:	0080                	addi	s0,sp,64
 1d8:	892a                	mv	s2,a0
  for (int test = 0; test < 3; test++) {
 1da:	4481                	li	s1,0
    printf("%s: large test %d\n", s, test + 1);
 1dc:	00001997          	auipc	s3,0x1
 1e0:	9bc98993          	addi	s3,s3,-1604 # b98 <malloc+0x19a>
  for (int test = 0; test < 3; test++) {
 1e4:	4a0d                	li	s4,3
    printf("%s: large test %d\n", s, test + 1);
 1e6:	2485                	addiw	s1,s1,1
 1e8:	8626                	mv	a2,s1
 1ea:	85ca                	mv	a1,s2
 1ec:	854e                	mv	a0,s3
 1ee:	00000097          	auipc	ra,0x0
 1f2:	752080e7          	jalr	1874(ra) # 940 <printf>

    // Large test: single master allocates as much processes
    // as it can, then quits.

    int pid = fork();
 1f6:	00000097          	auipc	ra,0x0
 1fa:	3ca080e7          	jalr	970(ra) # 5c0 <fork>
    if (pid < 0) {
 1fe:	02054d63          	bltz	a0,238 <big+0x70>
      printf("%s: could not fork\n", s);
      exit(1);
    }

    if (pid == 0) {
 202:	c929                	beqz	a0,254 <big+0x8c>
      allocate(5555);
    }

    int status;
    int c = wait(&status);
 204:	fcc40513          	addi	a0,s0,-52
 208:	00000097          	auipc	ra,0x0
 20c:	3c8080e7          	jalr	968(ra) # 5d0 <wait>
    if (c < 0) {
 210:	04054963          	bltz	a0,262 <big+0x9a>
      printf("%s: lost children\n", s);
      exit(1);
    }
    if (status == 0) {
 214:	fcc42783          	lw	a5,-52(s0)
 218:	c3bd                	beqz	a5,27e <big+0xb6>
      printf("%s: allocated all processes for big test\n", s);
      exit(1);
    }
    sleep(30);  // sleep a bit to unload some processes
 21a:	4579                	li	a0,30
 21c:	00000097          	auipc	ra,0x0
 220:	43c080e7          	jalr	1084(ra) # 658 <sleep>
  for (int test = 0; test < 3; test++) {
 224:	fd4491e3          	bne	s1,s4,1e6 <big+0x1e>
  }
}
 228:	70e2                	ld	ra,56(sp)
 22a:	7442                	ld	s0,48(sp)
 22c:	74a2                	ld	s1,40(sp)
 22e:	7902                	ld	s2,32(sp)
 230:	69e2                	ld	s3,24(sp)
 232:	6a42                	ld	s4,16(sp)
 234:	6121                	addi	sp,sp,64
 236:	8082                	ret
      printf("%s: could not fork\n", s);
 238:	85ca                	mv	a1,s2
 23a:	00001517          	auipc	a0,0x1
 23e:	8de50513          	addi	a0,a0,-1826 # b18 <malloc+0x11a>
 242:	00000097          	auipc	ra,0x0
 246:	6fe080e7          	jalr	1790(ra) # 940 <printf>
      exit(1);
 24a:	4505                	li	a0,1
 24c:	00000097          	auipc	ra,0x0
 250:	37c080e7          	jalr	892(ra) # 5c8 <exit>
      allocate(5555);
 254:	6505                	lui	a0,0x1
 256:	5b350513          	addi	a0,a0,1459 # 15b3 <base+0x5a3>
 25a:	00000097          	auipc	ra,0x0
 25e:	da6080e7          	jalr	-602(ra) # 0 <allocate>
      printf("%s: lost children\n", s);
 262:	85ca                	mv	a1,s2
 264:	00001517          	auipc	a0,0x1
 268:	8cc50513          	addi	a0,a0,-1844 # b30 <malloc+0x132>
 26c:	00000097          	auipc	ra,0x0
 270:	6d4080e7          	jalr	1748(ra) # 940 <printf>
      exit(1);
 274:	4505                	li	a0,1
 276:	00000097          	auipc	ra,0x0
 27a:	352080e7          	jalr	850(ra) # 5c8 <exit>
      printf("%s: allocated all processes for big test\n", s);
 27e:	85ca                	mv	a1,s2
 280:	00001517          	auipc	a0,0x1
 284:	93050513          	addi	a0,a0,-1744 # bb0 <malloc+0x1b2>
 288:	00000097          	auipc	ra,0x0
 28c:	6b8080e7          	jalr	1720(ra) # 940 <printf>
      exit(1);
 290:	4505                	li	a0,1
 292:	00000097          	auipc	ra,0x0
 296:	336080e7          	jalr	822(ra) # 5c8 <exit>

000000000000029a <main>:

int main(int argc, const char** argv) {
 29a:	1101                	addi	sp,sp,-32
 29c:	ec06                	sd	ra,24(sp)
 29e:	e822                	sd	s0,16(sp)
 2a0:	e426                	sd	s1,8(sp)
 2a2:	1000                	addi	s0,sp,32
 2a4:	84ae                	mv	s1,a1
  if (argc != 2) {
 2a6:	4789                	li	a5,2
 2a8:	04f51063          	bne	a0,a5,2e8 <main+0x4e>
    printf("usage: %s (small | big)\n", argv[0]);
    exit(1);
  }

  if (strcmp(argv[1], "small") == 0) {
 2ac:	00001597          	auipc	a1,0x1
 2b0:	95458593          	addi	a1,a1,-1708 # c00 <malloc+0x202>
 2b4:	6488                	ld	a0,8(s1)
 2b6:	00000097          	auipc	ra,0x0
 2ba:	0c0080e7          	jalr	192(ra) # 376 <strcmp>
 2be:	e139                	bnez	a0,304 <main+0x6a>
    small(argv[0]);
 2c0:	6088                	ld	a0,0(s1)
 2c2:	00000097          	auipc	ra,0x0
 2c6:	dce080e7          	jalr	-562(ra) # 90 <small>
  } else {
    printf("usage: %s (small | big)\n", argv[0]);
    exit(1);
  }

  printf("%s: OK\n", argv[0]);
 2ca:	608c                	ld	a1,0(s1)
 2cc:	00001517          	auipc	a0,0x1
 2d0:	94450513          	addi	a0,a0,-1724 # c10 <malloc+0x212>
 2d4:	00000097          	auipc	ra,0x0
 2d8:	66c080e7          	jalr	1644(ra) # 940 <printf>
  return 0;
}
 2dc:	4501                	li	a0,0
 2de:	60e2                	ld	ra,24(sp)
 2e0:	6442                	ld	s0,16(sp)
 2e2:	64a2                	ld	s1,8(sp)
 2e4:	6105                	addi	sp,sp,32
 2e6:	8082                	ret
    printf("usage: %s (small | big)\n", argv[0]);
 2e8:	618c                	ld	a1,0(a1)
 2ea:	00001517          	auipc	a0,0x1
 2ee:	8f650513          	addi	a0,a0,-1802 # be0 <malloc+0x1e2>
 2f2:	00000097          	auipc	ra,0x0
 2f6:	64e080e7          	jalr	1614(ra) # 940 <printf>
    exit(1);
 2fa:	4505                	li	a0,1
 2fc:	00000097          	auipc	ra,0x0
 300:	2cc080e7          	jalr	716(ra) # 5c8 <exit>
  } else if (strcmp(argv[1], "big") == 0) {
 304:	00001597          	auipc	a1,0x1
 308:	90458593          	addi	a1,a1,-1788 # c08 <malloc+0x20a>
 30c:	6488                	ld	a0,8(s1)
 30e:	00000097          	auipc	ra,0x0
 312:	068080e7          	jalr	104(ra) # 376 <strcmp>
 316:	e519                	bnez	a0,324 <main+0x8a>
    big(argv[0]);
 318:	6088                	ld	a0,0(s1)
 31a:	00000097          	auipc	ra,0x0
 31e:	eae080e7          	jalr	-338(ra) # 1c8 <big>
 322:	b765                	j	2ca <main+0x30>
    printf("usage: %s (small | big)\n", argv[0]);
 324:	608c                	ld	a1,0(s1)
 326:	00001517          	auipc	a0,0x1
 32a:	8ba50513          	addi	a0,a0,-1862 # be0 <malloc+0x1e2>
 32e:	00000097          	auipc	ra,0x0
 332:	612080e7          	jalr	1554(ra) # 940 <printf>
    exit(1);
 336:	4505                	li	a0,1
 338:	00000097          	auipc	ra,0x0
 33c:	290080e7          	jalr	656(ra) # 5c8 <exit>

0000000000000340 <_main>:
#include "user/user.h"

//
// wrapper so that it's OK if main() does not call exit().
//
void _main() {
 340:	1141                	addi	sp,sp,-16
 342:	e406                	sd	ra,8(sp)
 344:	e022                	sd	s0,0(sp)
 346:	0800                	addi	s0,sp,16
  extern int main();
  main();
 348:	00000097          	auipc	ra,0x0
 34c:	f52080e7          	jalr	-174(ra) # 29a <main>
  exit(0);
 350:	4501                	li	a0,0
 352:	00000097          	auipc	ra,0x0
 356:	276080e7          	jalr	630(ra) # 5c8 <exit>

000000000000035a <strcpy>:
}

char *strcpy(char *s, const char *t) {
 35a:	1141                	addi	sp,sp,-16
 35c:	e422                	sd	s0,8(sp)
 35e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 360:	87aa                	mv	a5,a0
 362:	0585                	addi	a1,a1,1
 364:	0785                	addi	a5,a5,1
 366:	fff5c703          	lbu	a4,-1(a1)
 36a:	fee78fa3          	sb	a4,-1(a5)
 36e:	fb75                	bnez	a4,362 <strcpy+0x8>
    ;
  return os;
}
 370:	6422                	ld	s0,8(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret

0000000000000376 <strcmp>:

int strcmp(const char *p, const char *q) {
 376:	1141                	addi	sp,sp,-16
 378:	e422                	sd	s0,8(sp)
 37a:	0800                	addi	s0,sp,16
  while (*p && *p == *q) p++, q++;
 37c:	00054783          	lbu	a5,0(a0)
 380:	cb91                	beqz	a5,394 <strcmp+0x1e>
 382:	0005c703          	lbu	a4,0(a1)
 386:	00f71763          	bne	a4,a5,394 <strcmp+0x1e>
 38a:	0505                	addi	a0,a0,1
 38c:	0585                	addi	a1,a1,1
 38e:	00054783          	lbu	a5,0(a0)
 392:	fbe5                	bnez	a5,382 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 394:	0005c503          	lbu	a0,0(a1)
}
 398:	40a7853b          	subw	a0,a5,a0
 39c:	6422                	ld	s0,8(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret

00000000000003a2 <strlen>:

uint strlen(const char *s) {
 3a2:	1141                	addi	sp,sp,-16
 3a4:	e422                	sd	s0,8(sp)
 3a6:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 3a8:	00054783          	lbu	a5,0(a0)
 3ac:	cf91                	beqz	a5,3c8 <strlen+0x26>
 3ae:	0505                	addi	a0,a0,1
 3b0:	87aa                	mv	a5,a0
 3b2:	4685                	li	a3,1
 3b4:	9e89                	subw	a3,a3,a0
 3b6:	00f6853b          	addw	a0,a3,a5
 3ba:	0785                	addi	a5,a5,1
 3bc:	fff7c703          	lbu	a4,-1(a5)
 3c0:	fb7d                	bnez	a4,3b6 <strlen+0x14>
    ;
  return n;
}
 3c2:	6422                	ld	s0,8(sp)
 3c4:	0141                	addi	sp,sp,16
 3c6:	8082                	ret
  for (n = 0; s[n]; n++)
 3c8:	4501                	li	a0,0
 3ca:	bfe5                	j	3c2 <strlen+0x20>

00000000000003cc <memset>:

void *memset(void *dst, int c, uint n) {
 3cc:	1141                	addi	sp,sp,-16
 3ce:	e422                	sd	s0,8(sp)
 3d0:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 3d2:	ca19                	beqz	a2,3e8 <memset+0x1c>
 3d4:	87aa                	mv	a5,a0
 3d6:	1602                	slli	a2,a2,0x20
 3d8:	9201                	srli	a2,a2,0x20
 3da:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3de:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 3e2:	0785                	addi	a5,a5,1
 3e4:	fee79de3          	bne	a5,a4,3de <memset+0x12>
  }
  return dst;
}
 3e8:	6422                	ld	s0,8(sp)
 3ea:	0141                	addi	sp,sp,16
 3ec:	8082                	ret

00000000000003ee <strchr>:

char *strchr(const char *s, char c) {
 3ee:	1141                	addi	sp,sp,-16
 3f0:	e422                	sd	s0,8(sp)
 3f2:	0800                	addi	s0,sp,16
  for (; *s; s++)
 3f4:	00054783          	lbu	a5,0(a0)
 3f8:	cb99                	beqz	a5,40e <strchr+0x20>
    if (*s == c) return (char *)s;
 3fa:	00f58763          	beq	a1,a5,408 <strchr+0x1a>
  for (; *s; s++)
 3fe:	0505                	addi	a0,a0,1
 400:	00054783          	lbu	a5,0(a0)
 404:	fbfd                	bnez	a5,3fa <strchr+0xc>
  return 0;
 406:	4501                	li	a0,0
}
 408:	6422                	ld	s0,8(sp)
 40a:	0141                	addi	sp,sp,16
 40c:	8082                	ret
  return 0;
 40e:	4501                	li	a0,0
 410:	bfe5                	j	408 <strchr+0x1a>

0000000000000412 <gets>:

char *gets(char *buf, int max) {
 412:	711d                	addi	sp,sp,-96
 414:	ec86                	sd	ra,88(sp)
 416:	e8a2                	sd	s0,80(sp)
 418:	e4a6                	sd	s1,72(sp)
 41a:	e0ca                	sd	s2,64(sp)
 41c:	fc4e                	sd	s3,56(sp)
 41e:	f852                	sd	s4,48(sp)
 420:	f456                	sd	s5,40(sp)
 422:	f05a                	sd	s6,32(sp)
 424:	ec5e                	sd	s7,24(sp)
 426:	1080                	addi	s0,sp,96
 428:	8baa                	mv	s7,a0
 42a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 42c:	892a                	mv	s2,a0
 42e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1) break;
    buf[i++] = c;
    if (c == '\n' || c == '\r') break;
 430:	4aa9                	li	s5,10
 432:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
 434:	89a6                	mv	s3,s1
 436:	2485                	addiw	s1,s1,1
 438:	0344d863          	bge	s1,s4,468 <gets+0x56>
    cc = read(0, &c, 1);
 43c:	4605                	li	a2,1
 43e:	faf40593          	addi	a1,s0,-81
 442:	4501                	li	a0,0
 444:	00000097          	auipc	ra,0x0
 448:	19c080e7          	jalr	412(ra) # 5e0 <read>
    if (cc < 1) break;
 44c:	00a05e63          	blez	a0,468 <gets+0x56>
    buf[i++] = c;
 450:	faf44783          	lbu	a5,-81(s0)
 454:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r') break;
 458:	01578763          	beq	a5,s5,466 <gets+0x54>
 45c:	0905                	addi	s2,s2,1
 45e:	fd679be3          	bne	a5,s6,434 <gets+0x22>
  for (i = 0; i + 1 < max;) {
 462:	89a6                	mv	s3,s1
 464:	a011                	j	468 <gets+0x56>
 466:	89a6                	mv	s3,s1
  }
  buf[i] = '\0';
 468:	99de                	add	s3,s3,s7
 46a:	00098023          	sb	zero,0(s3)
  return buf;
}
 46e:	855e                	mv	a0,s7
 470:	60e6                	ld	ra,88(sp)
 472:	6446                	ld	s0,80(sp)
 474:	64a6                	ld	s1,72(sp)
 476:	6906                	ld	s2,64(sp)
 478:	79e2                	ld	s3,56(sp)
 47a:	7a42                	ld	s4,48(sp)
 47c:	7aa2                	ld	s5,40(sp)
 47e:	7b02                	ld	s6,32(sp)
 480:	6be2                	ld	s7,24(sp)
 482:	6125                	addi	sp,sp,96
 484:	8082                	ret

0000000000000486 <stat>:

int stat(const char *n, struct stat *st) {
 486:	1101                	addi	sp,sp,-32
 488:	ec06                	sd	ra,24(sp)
 48a:	e822                	sd	s0,16(sp)
 48c:	e426                	sd	s1,8(sp)
 48e:	e04a                	sd	s2,0(sp)
 490:	1000                	addi	s0,sp,32
 492:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 494:	4581                	li	a1,0
 496:	00000097          	auipc	ra,0x0
 49a:	172080e7          	jalr	370(ra) # 608 <open>
  if (fd < 0) return -1;
 49e:	02054563          	bltz	a0,4c8 <stat+0x42>
 4a2:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 4a4:	85ca                	mv	a1,s2
 4a6:	00000097          	auipc	ra,0x0
 4aa:	17a080e7          	jalr	378(ra) # 620 <fstat>
 4ae:	892a                	mv	s2,a0
  close(fd);
 4b0:	8526                	mv	a0,s1
 4b2:	00000097          	auipc	ra,0x0
 4b6:	13e080e7          	jalr	318(ra) # 5f0 <close>
  return r;
}
 4ba:	854a                	mv	a0,s2
 4bc:	60e2                	ld	ra,24(sp)
 4be:	6442                	ld	s0,16(sp)
 4c0:	64a2                	ld	s1,8(sp)
 4c2:	6902                	ld	s2,0(sp)
 4c4:	6105                	addi	sp,sp,32
 4c6:	8082                	ret
  if (fd < 0) return -1;
 4c8:	597d                	li	s2,-1
 4ca:	bfc5                	j	4ba <stat+0x34>

00000000000004cc <atoi>:

int atoi(const char *s) {
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e422                	sd	s0,8(sp)
 4d0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
 4d2:	00054603          	lbu	a2,0(a0)
 4d6:	fd06079b          	addiw	a5,a2,-48
 4da:	0ff7f793          	andi	a5,a5,255
 4de:	4725                	li	a4,9
 4e0:	02f76963          	bltu	a4,a5,512 <atoi+0x46>
 4e4:	86aa                	mv	a3,a0
  n = 0;
 4e6:	4501                	li	a0,0
  while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
 4e8:	45a5                	li	a1,9
 4ea:	0685                	addi	a3,a3,1
 4ec:	0025179b          	slliw	a5,a0,0x2
 4f0:	9fa9                	addw	a5,a5,a0
 4f2:	0017979b          	slliw	a5,a5,0x1
 4f6:	9fb1                	addw	a5,a5,a2
 4f8:	fd07851b          	addiw	a0,a5,-48
 4fc:	0006c603          	lbu	a2,0(a3)
 500:	fd06071b          	addiw	a4,a2,-48
 504:	0ff77713          	andi	a4,a4,255
 508:	fee5f1e3          	bgeu	a1,a4,4ea <atoi+0x1e>
  return n;
}
 50c:	6422                	ld	s0,8(sp)
 50e:	0141                	addi	sp,sp,16
 510:	8082                	ret
  n = 0;
 512:	4501                	li	a0,0
 514:	bfe5                	j	50c <atoi+0x40>

0000000000000516 <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 516:	1141                	addi	sp,sp,-16
 518:	e422                	sd	s0,8(sp)
 51a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 51c:	02b57463          	bgeu	a0,a1,544 <memmove+0x2e>
    while (n-- > 0) *dst++ = *src++;
 520:	00c05f63          	blez	a2,53e <memmove+0x28>
 524:	1602                	slli	a2,a2,0x20
 526:	9201                	srli	a2,a2,0x20
 528:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 52c:	872a                	mv	a4,a0
    while (n-- > 0) *dst++ = *src++;
 52e:	0585                	addi	a1,a1,1
 530:	0705                	addi	a4,a4,1
 532:	fff5c683          	lbu	a3,-1(a1)
 536:	fed70fa3          	sb	a3,-1(a4)
 53a:	fee79ae3          	bne	a5,a4,52e <memmove+0x18>
    dst += n;
    src += n;
    while (n-- > 0) *--dst = *--src;
  }
  return vdst;
}
 53e:	6422                	ld	s0,8(sp)
 540:	0141                	addi	sp,sp,16
 542:	8082                	ret
    dst += n;
 544:	00c50733          	add	a4,a0,a2
    src += n;
 548:	95b2                	add	a1,a1,a2
    while (n-- > 0) *--dst = *--src;
 54a:	fec05ae3          	blez	a2,53e <memmove+0x28>
 54e:	fff6079b          	addiw	a5,a2,-1
 552:	1782                	slli	a5,a5,0x20
 554:	9381                	srli	a5,a5,0x20
 556:	fff7c793          	not	a5,a5
 55a:	97ba                	add	a5,a5,a4
 55c:	15fd                	addi	a1,a1,-1
 55e:	177d                	addi	a4,a4,-1
 560:	0005c683          	lbu	a3,0(a1)
 564:	00d70023          	sb	a3,0(a4)
 568:	fee79ae3          	bne	a5,a4,55c <memmove+0x46>
 56c:	bfc9                	j	53e <memmove+0x28>

000000000000056e <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 56e:	1141                	addi	sp,sp,-16
 570:	e422                	sd	s0,8(sp)
 572:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 574:	ca05                	beqz	a2,5a4 <memcmp+0x36>
 576:	fff6069b          	addiw	a3,a2,-1
 57a:	1682                	slli	a3,a3,0x20
 57c:	9281                	srli	a3,a3,0x20
 57e:	0685                	addi	a3,a3,1
 580:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 582:	00054783          	lbu	a5,0(a0)
 586:	0005c703          	lbu	a4,0(a1)
 58a:	00e79863          	bne	a5,a4,59a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 58e:	0505                	addi	a0,a0,1
    p2++;
 590:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 592:	fed518e3          	bne	a0,a3,582 <memcmp+0x14>
  }
  return 0;
 596:	4501                	li	a0,0
 598:	a019                	j	59e <memcmp+0x30>
      return *p1 - *p2;
 59a:	40e7853b          	subw	a0,a5,a4
}
 59e:	6422                	ld	s0,8(sp)
 5a0:	0141                	addi	sp,sp,16
 5a2:	8082                	ret
  return 0;
 5a4:	4501                	li	a0,0
 5a6:	bfe5                	j	59e <memcmp+0x30>

00000000000005a8 <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 5a8:	1141                	addi	sp,sp,-16
 5aa:	e406                	sd	ra,8(sp)
 5ac:	e022                	sd	s0,0(sp)
 5ae:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5b0:	00000097          	auipc	ra,0x0
 5b4:	f66080e7          	jalr	-154(ra) # 516 <memmove>
}
 5b8:	60a2                	ld	ra,8(sp)
 5ba:	6402                	ld	s0,0(sp)
 5bc:	0141                	addi	sp,sp,16
 5be:	8082                	ret

00000000000005c0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5c0:	4885                	li	a7,1
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5c8:	4889                	li	a7,2
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5d0:	488d                	li	a7,3
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5d8:	4891                	li	a7,4
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <read>:
.global read
read:
 li a7, SYS_read
 5e0:	4895                	li	a7,5
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <write>:
.global write
write:
 li a7, SYS_write
 5e8:	48c1                	li	a7,16
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <close>:
.global close
close:
 li a7, SYS_close
 5f0:	48d5                	li	a7,21
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5f8:	4899                	li	a7,6
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <exec>:
.global exec
exec:
 li a7, SYS_exec
 600:	489d                	li	a7,7
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <open>:
.global open
open:
 li a7, SYS_open
 608:	48bd                	li	a7,15
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 610:	48c5                	li	a7,17
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 618:	48c9                	li	a7,18
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 620:	48a1                	li	a7,8
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <link>:
.global link
link:
 li a7, SYS_link
 628:	48cd                	li	a7,19
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 630:	48d1                	li	a7,20
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 638:	48a5                	li	a7,9
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <dup>:
.global dup
dup:
 li a7, SYS_dup
 640:	48a9                	li	a7,10
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 648:	48ad                	li	a7,11
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 650:	48b1                	li	a7,12
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 658:	48b5                	li	a7,13
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 660:	48b9                	li	a7,14
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <putc>:
#include "kernel/types.h"
#include "user/user.h"

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
 668:	1101                	addi	sp,sp,-32
 66a:	ec06                	sd	ra,24(sp)
 66c:	e822                	sd	s0,16(sp)
 66e:	1000                	addi	s0,sp,32
 670:	feb407a3          	sb	a1,-17(s0)
 674:	4605                	li	a2,1
 676:	fef40593          	addi	a1,s0,-17
 67a:	00000097          	auipc	ra,0x0
 67e:	f6e080e7          	jalr	-146(ra) # 5e8 <write>
 682:	60e2                	ld	ra,24(sp)
 684:	6442                	ld	s0,16(sp)
 686:	6105                	addi	sp,sp,32
 688:	8082                	ret

000000000000068a <printint>:

static void printint(int fd, int xx, int base, int sgn) {
 68a:	7139                	addi	sp,sp,-64
 68c:	fc06                	sd	ra,56(sp)
 68e:	f822                	sd	s0,48(sp)
 690:	f426                	sd	s1,40(sp)
 692:	f04a                	sd	s2,32(sp)
 694:	ec4e                	sd	s3,24(sp)
 696:	0080                	addi	s0,sp,64
 698:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if (sgn && xx < 0) {
 69a:	c299                	beqz	a3,6a0 <printint+0x16>
 69c:	0805c863          	bltz	a1,72c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6a0:	2581                	sext.w	a1,a1
  neg = 0;
 6a2:	4881                	li	a7,0
 6a4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6a8:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 6aa:	2601                	sext.w	a2,a2
 6ac:	00000517          	auipc	a0,0x0
 6b0:	57450513          	addi	a0,a0,1396 # c20 <digits>
 6b4:	883a                	mv	a6,a4
 6b6:	2705                	addiw	a4,a4,1
 6b8:	02c5f7bb          	remuw	a5,a1,a2
 6bc:	1782                	slli	a5,a5,0x20
 6be:	9381                	srli	a5,a5,0x20
 6c0:	97aa                	add	a5,a5,a0
 6c2:	0007c783          	lbu	a5,0(a5)
 6c6:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 6ca:	0005879b          	sext.w	a5,a1
 6ce:	02c5d5bb          	divuw	a1,a1,a2
 6d2:	0685                	addi	a3,a3,1
 6d4:	fec7f0e3          	bgeu	a5,a2,6b4 <printint+0x2a>
  if (neg) buf[i++] = '-';
 6d8:	00088b63          	beqz	a7,6ee <printint+0x64>
 6dc:	fd040793          	addi	a5,s0,-48
 6e0:	973e                	add	a4,a4,a5
 6e2:	02d00793          	li	a5,45
 6e6:	fef70823          	sb	a5,-16(a4)
 6ea:	0028071b          	addiw	a4,a6,2

  while (--i >= 0) putc(fd, buf[i]);
 6ee:	02e05863          	blez	a4,71e <printint+0x94>
 6f2:	fc040793          	addi	a5,s0,-64
 6f6:	00e78933          	add	s2,a5,a4
 6fa:	fff78993          	addi	s3,a5,-1
 6fe:	99ba                	add	s3,s3,a4
 700:	377d                	addiw	a4,a4,-1
 702:	1702                	slli	a4,a4,0x20
 704:	9301                	srli	a4,a4,0x20
 706:	40e989b3          	sub	s3,s3,a4
 70a:	fff94583          	lbu	a1,-1(s2)
 70e:	8526                	mv	a0,s1
 710:	00000097          	auipc	ra,0x0
 714:	f58080e7          	jalr	-168(ra) # 668 <putc>
 718:	197d                	addi	s2,s2,-1
 71a:	ff3918e3          	bne	s2,s3,70a <printint+0x80>
}
 71e:	70e2                	ld	ra,56(sp)
 720:	7442                	ld	s0,48(sp)
 722:	74a2                	ld	s1,40(sp)
 724:	7902                	ld	s2,32(sp)
 726:	69e2                	ld	s3,24(sp)
 728:	6121                	addi	sp,sp,64
 72a:	8082                	ret
    x = -xx;
 72c:	40b005bb          	negw	a1,a1
    neg = 1;
 730:	4885                	li	a7,1
    x = -xx;
 732:	bf8d                	j	6a4 <printint+0x1a>

0000000000000734 <vprintf>:
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
 734:	7119                	addi	sp,sp,-128
 736:	fc86                	sd	ra,120(sp)
 738:	f8a2                	sd	s0,112(sp)
 73a:	f4a6                	sd	s1,104(sp)
 73c:	f0ca                	sd	s2,96(sp)
 73e:	ecce                	sd	s3,88(sp)
 740:	e8d2                	sd	s4,80(sp)
 742:	e4d6                	sd	s5,72(sp)
 744:	e0da                	sd	s6,64(sp)
 746:	fc5e                	sd	s7,56(sp)
 748:	f862                	sd	s8,48(sp)
 74a:	f466                	sd	s9,40(sp)
 74c:	f06a                	sd	s10,32(sp)
 74e:	ec6e                	sd	s11,24(sp)
 750:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 752:	0005c903          	lbu	s2,0(a1)
 756:	18090f63          	beqz	s2,8f4 <vprintf+0x1c0>
 75a:	8aaa                	mv	s5,a0
 75c:	8b32                	mv	s6,a2
 75e:	00158493          	addi	s1,a1,1
  state = 0;
 762:	4981                	li	s3,0
      if (c == '%') {
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if (state == '%') {
 764:	02500a13          	li	s4,37
      if (c == 'd') {
 768:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c == 'l') {
 76c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if (c == 'x') {
 770:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if (c == 'p') {
 774:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 778:	00000b97          	auipc	s7,0x0
 77c:	4a8b8b93          	addi	s7,s7,1192 # c20 <digits>
 780:	a839                	j	79e <vprintf+0x6a>
        putc(fd, c);
 782:	85ca                	mv	a1,s2
 784:	8556                	mv	a0,s5
 786:	00000097          	auipc	ra,0x0
 78a:	ee2080e7          	jalr	-286(ra) # 668 <putc>
 78e:	a019                	j	794 <vprintf+0x60>
    } else if (state == '%') {
 790:	01498f63          	beq	s3,s4,7ae <vprintf+0x7a>
  for (i = 0; fmt[i]; i++) {
 794:	0485                	addi	s1,s1,1
 796:	fff4c903          	lbu	s2,-1(s1)
 79a:	14090d63          	beqz	s2,8f4 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 79e:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 7a2:	fe0997e3          	bnez	s3,790 <vprintf+0x5c>
      if (c == '%') {
 7a6:	fd479ee3          	bne	a5,s4,782 <vprintf+0x4e>
        state = '%';
 7aa:	89be                	mv	s3,a5
 7ac:	b7e5                	j	794 <vprintf+0x60>
      if (c == 'd') {
 7ae:	05878063          	beq	a5,s8,7ee <vprintf+0xba>
      } else if (c == 'l') {
 7b2:	05978c63          	beq	a5,s9,80a <vprintf+0xd6>
      } else if (c == 'x') {
 7b6:	07a78863          	beq	a5,s10,826 <vprintf+0xf2>
      } else if (c == 'p') {
 7ba:	09b78463          	beq	a5,s11,842 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if (c == 's') {
 7be:	07300713          	li	a4,115
 7c2:	0ce78663          	beq	a5,a4,88e <vprintf+0x15a>
        if (s == 0) s = "(null)";
        while (*s != 0) {
          putc(fd, *s);
          s++;
        }
      } else if (c == 'c') {
 7c6:	06300713          	li	a4,99
 7ca:	0ee78e63          	beq	a5,a4,8c6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if (c == '%') {
 7ce:	11478863          	beq	a5,s4,8de <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7d2:	85d2                	mv	a1,s4
 7d4:	8556                	mv	a0,s5
 7d6:	00000097          	auipc	ra,0x0
 7da:	e92080e7          	jalr	-366(ra) # 668 <putc>
        putc(fd, c);
 7de:	85ca                	mv	a1,s2
 7e0:	8556                	mv	a0,s5
 7e2:	00000097          	auipc	ra,0x0
 7e6:	e86080e7          	jalr	-378(ra) # 668 <putc>
      }
      state = 0;
 7ea:	4981                	li	s3,0
 7ec:	b765                	j	794 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7ee:	008b0913          	addi	s2,s6,8
 7f2:	4685                	li	a3,1
 7f4:	4629                	li	a2,10
 7f6:	000b2583          	lw	a1,0(s6)
 7fa:	8556                	mv	a0,s5
 7fc:	00000097          	auipc	ra,0x0
 800:	e8e080e7          	jalr	-370(ra) # 68a <printint>
 804:	8b4a                	mv	s6,s2
      state = 0;
 806:	4981                	li	s3,0
 808:	b771                	j	794 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 80a:	008b0913          	addi	s2,s6,8
 80e:	4681                	li	a3,0
 810:	4629                	li	a2,10
 812:	000b2583          	lw	a1,0(s6)
 816:	8556                	mv	a0,s5
 818:	00000097          	auipc	ra,0x0
 81c:	e72080e7          	jalr	-398(ra) # 68a <printint>
 820:	8b4a                	mv	s6,s2
      state = 0;
 822:	4981                	li	s3,0
 824:	bf85                	j	794 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 826:	008b0913          	addi	s2,s6,8
 82a:	4681                	li	a3,0
 82c:	4641                	li	a2,16
 82e:	000b2583          	lw	a1,0(s6)
 832:	8556                	mv	a0,s5
 834:	00000097          	auipc	ra,0x0
 838:	e56080e7          	jalr	-426(ra) # 68a <printint>
 83c:	8b4a                	mv	s6,s2
      state = 0;
 83e:	4981                	li	s3,0
 840:	bf91                	j	794 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 842:	008b0793          	addi	a5,s6,8
 846:	f8f43423          	sd	a5,-120(s0)
 84a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 84e:	03000593          	li	a1,48
 852:	8556                	mv	a0,s5
 854:	00000097          	auipc	ra,0x0
 858:	e14080e7          	jalr	-492(ra) # 668 <putc>
  putc(fd, 'x');
 85c:	85ea                	mv	a1,s10
 85e:	8556                	mv	a0,s5
 860:	00000097          	auipc	ra,0x0
 864:	e08080e7          	jalr	-504(ra) # 668 <putc>
 868:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 86a:	03c9d793          	srli	a5,s3,0x3c
 86e:	97de                	add	a5,a5,s7
 870:	0007c583          	lbu	a1,0(a5)
 874:	8556                	mv	a0,s5
 876:	00000097          	auipc	ra,0x0
 87a:	df2080e7          	jalr	-526(ra) # 668 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 87e:	0992                	slli	s3,s3,0x4
 880:	397d                	addiw	s2,s2,-1
 882:	fe0914e3          	bnez	s2,86a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 886:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 88a:	4981                	li	s3,0
 88c:	b721                	j	794 <vprintf+0x60>
        s = va_arg(ap, char *);
 88e:	008b0993          	addi	s3,s6,8
 892:	000b3903          	ld	s2,0(s6)
        if (s == 0) s = "(null)";
 896:	02090163          	beqz	s2,8b8 <vprintf+0x184>
        while (*s != 0) {
 89a:	00094583          	lbu	a1,0(s2)
 89e:	c9a1                	beqz	a1,8ee <vprintf+0x1ba>
          putc(fd, *s);
 8a0:	8556                	mv	a0,s5
 8a2:	00000097          	auipc	ra,0x0
 8a6:	dc6080e7          	jalr	-570(ra) # 668 <putc>
          s++;
 8aa:	0905                	addi	s2,s2,1
        while (*s != 0) {
 8ac:	00094583          	lbu	a1,0(s2)
 8b0:	f9e5                	bnez	a1,8a0 <vprintf+0x16c>
        s = va_arg(ap, char *);
 8b2:	8b4e                	mv	s6,s3
      state = 0;
 8b4:	4981                	li	s3,0
 8b6:	bdf9                	j	794 <vprintf+0x60>
        if (s == 0) s = "(null)";
 8b8:	00000917          	auipc	s2,0x0
 8bc:	36090913          	addi	s2,s2,864 # c18 <malloc+0x21a>
        while (*s != 0) {
 8c0:	02800593          	li	a1,40
 8c4:	bff1                	j	8a0 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8c6:	008b0913          	addi	s2,s6,8
 8ca:	000b4583          	lbu	a1,0(s6)
 8ce:	8556                	mv	a0,s5
 8d0:	00000097          	auipc	ra,0x0
 8d4:	d98080e7          	jalr	-616(ra) # 668 <putc>
 8d8:	8b4a                	mv	s6,s2
      state = 0;
 8da:	4981                	li	s3,0
 8dc:	bd65                	j	794 <vprintf+0x60>
        putc(fd, c);
 8de:	85d2                	mv	a1,s4
 8e0:	8556                	mv	a0,s5
 8e2:	00000097          	auipc	ra,0x0
 8e6:	d86080e7          	jalr	-634(ra) # 668 <putc>
      state = 0;
 8ea:	4981                	li	s3,0
 8ec:	b565                	j	794 <vprintf+0x60>
        s = va_arg(ap, char *);
 8ee:	8b4e                	mv	s6,s3
      state = 0;
 8f0:	4981                	li	s3,0
 8f2:	b54d                	j	794 <vprintf+0x60>
    }
  }
}
 8f4:	70e6                	ld	ra,120(sp)
 8f6:	7446                	ld	s0,112(sp)
 8f8:	74a6                	ld	s1,104(sp)
 8fa:	7906                	ld	s2,96(sp)
 8fc:	69e6                	ld	s3,88(sp)
 8fe:	6a46                	ld	s4,80(sp)
 900:	6aa6                	ld	s5,72(sp)
 902:	6b06                	ld	s6,64(sp)
 904:	7be2                	ld	s7,56(sp)
 906:	7c42                	ld	s8,48(sp)
 908:	7ca2                	ld	s9,40(sp)
 90a:	7d02                	ld	s10,32(sp)
 90c:	6de2                	ld	s11,24(sp)
 90e:	6109                	addi	sp,sp,128
 910:	8082                	ret

0000000000000912 <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
 912:	715d                	addi	sp,sp,-80
 914:	ec06                	sd	ra,24(sp)
 916:	e822                	sd	s0,16(sp)
 918:	1000                	addi	s0,sp,32
 91a:	e010                	sd	a2,0(s0)
 91c:	e414                	sd	a3,8(s0)
 91e:	e818                	sd	a4,16(s0)
 920:	ec1c                	sd	a5,24(s0)
 922:	03043023          	sd	a6,32(s0)
 926:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 92a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 92e:	8622                	mv	a2,s0
 930:	00000097          	auipc	ra,0x0
 934:	e04080e7          	jalr	-508(ra) # 734 <vprintf>
}
 938:	60e2                	ld	ra,24(sp)
 93a:	6442                	ld	s0,16(sp)
 93c:	6161                	addi	sp,sp,80
 93e:	8082                	ret

0000000000000940 <printf>:

void printf(const char *fmt, ...) {
 940:	711d                	addi	sp,sp,-96
 942:	ec06                	sd	ra,24(sp)
 944:	e822                	sd	s0,16(sp)
 946:	1000                	addi	s0,sp,32
 948:	e40c                	sd	a1,8(s0)
 94a:	e810                	sd	a2,16(s0)
 94c:	ec14                	sd	a3,24(s0)
 94e:	f018                	sd	a4,32(s0)
 950:	f41c                	sd	a5,40(s0)
 952:	03043823          	sd	a6,48(s0)
 956:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 95a:	00840613          	addi	a2,s0,8
 95e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 962:	85aa                	mv	a1,a0
 964:	4505                	li	a0,1
 966:	00000097          	auipc	ra,0x0
 96a:	dce080e7          	jalr	-562(ra) # 734 <vprintf>
}
 96e:	60e2                	ld	ra,24(sp)
 970:	6442                	ld	s0,16(sp)
 972:	6125                	addi	sp,sp,96
 974:	8082                	ret

0000000000000976 <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
 976:	1141                	addi	sp,sp,-16
 978:	e422                	sd	s0,8(sp)
 97a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 97c:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 980:	00000797          	auipc	a5,0x0
 984:	6807b783          	ld	a5,1664(a5) # 1000 <freep>
 988:	a805                	j	9b8 <free+0x42>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
 98a:	4618                	lw	a4,8(a2)
 98c:	9db9                	addw	a1,a1,a4
 98e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 992:	6398                	ld	a4,0(a5)
 994:	6318                	ld	a4,0(a4)
 996:	fee53823          	sd	a4,-16(a0)
 99a:	a091                	j	9de <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
 99c:	ff852703          	lw	a4,-8(a0)
 9a0:	9e39                	addw	a2,a2,a4
 9a2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9a4:	ff053703          	ld	a4,-16(a0)
 9a8:	e398                	sd	a4,0(a5)
 9aa:	a099                	j	9f0 <free+0x7a>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
 9ac:	6398                	ld	a4,0(a5)
 9ae:	00e7e463          	bltu	a5,a4,9b6 <free+0x40>
 9b2:	00e6ea63          	bltu	a3,a4,9c6 <free+0x50>
void free(void *ap) {
 9b6:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b8:	fed7fae3          	bgeu	a5,a3,9ac <free+0x36>
 9bc:	6398                	ld	a4,0(a5)
 9be:	00e6e463          	bltu	a3,a4,9c6 <free+0x50>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
 9c2:	fee7eae3          	bltu	a5,a4,9b6 <free+0x40>
  if (bp + bp->s.size == p->s.ptr) {
 9c6:	ff852583          	lw	a1,-8(a0)
 9ca:	6390                	ld	a2,0(a5)
 9cc:	02059713          	slli	a4,a1,0x20
 9d0:	9301                	srli	a4,a4,0x20
 9d2:	0712                	slli	a4,a4,0x4
 9d4:	9736                	add	a4,a4,a3
 9d6:	fae60ae3          	beq	a2,a4,98a <free+0x14>
    bp->s.ptr = p->s.ptr;
 9da:	fec53823          	sd	a2,-16(a0)
  if (p + p->s.size == bp) {
 9de:	4790                	lw	a2,8(a5)
 9e0:	02061713          	slli	a4,a2,0x20
 9e4:	9301                	srli	a4,a4,0x20
 9e6:	0712                	slli	a4,a4,0x4
 9e8:	973e                	add	a4,a4,a5
 9ea:	fae689e3          	beq	a3,a4,99c <free+0x26>
  } else
    p->s.ptr = bp;
 9ee:	e394                	sd	a3,0(a5)
  freep = p;
 9f0:	00000717          	auipc	a4,0x0
 9f4:	60f73823          	sd	a5,1552(a4) # 1000 <freep>
}
 9f8:	6422                	ld	s0,8(sp)
 9fa:	0141                	addi	sp,sp,16
 9fc:	8082                	ret

00000000000009fe <malloc>:
  hp->s.size = nu;
  free((void *)(hp + 1));
  return freep;
}

void *malloc(uint nbytes) {
 9fe:	7139                	addi	sp,sp,-64
 a00:	fc06                	sd	ra,56(sp)
 a02:	f822                	sd	s0,48(sp)
 a04:	f426                	sd	s1,40(sp)
 a06:	f04a                	sd	s2,32(sp)
 a08:	ec4e                	sd	s3,24(sp)
 a0a:	e852                	sd	s4,16(sp)
 a0c:	e456                	sd	s5,8(sp)
 a0e:	e05a                	sd	s6,0(sp)
 a10:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 a12:	02051493          	slli	s1,a0,0x20
 a16:	9081                	srli	s1,s1,0x20
 a18:	04bd                	addi	s1,s1,15
 a1a:	8091                	srli	s1,s1,0x4
 a1c:	0014899b          	addiw	s3,s1,1
 a20:	0485                	addi	s1,s1,1
  if ((prevp = freep) == 0) {
 a22:	00000517          	auipc	a0,0x0
 a26:	5de53503          	ld	a0,1502(a0) # 1000 <freep>
 a2a:	c515                	beqz	a0,a56 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 a2c:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 a2e:	4798                	lw	a4,8(a5)
 a30:	02977f63          	bgeu	a4,s1,a6e <malloc+0x70>
 a34:	8a4e                	mv	s4,s3
 a36:	0009871b          	sext.w	a4,s3
 a3a:	6685                	lui	a3,0x1
 a3c:	00d77363          	bgeu	a4,a3,a42 <malloc+0x44>
 a40:	6a05                	lui	s4,0x1
 a42:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a46:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 a4a:	00000917          	auipc	s2,0x0
 a4e:	5b690913          	addi	s2,s2,1462 # 1000 <freep>
  if (p == (char *)-1) return 0;
 a52:	5afd                	li	s5,-1
 a54:	a88d                	j	ac6 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 a56:	00000797          	auipc	a5,0x0
 a5a:	5ba78793          	addi	a5,a5,1466 # 1010 <base>
 a5e:	00000717          	auipc	a4,0x0
 a62:	5af73123          	sd	a5,1442(a4) # 1000 <freep>
 a66:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a68:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 a6c:	b7e1                	j	a34 <malloc+0x36>
      if (p->s.size == nunits)
 a6e:	02e48b63          	beq	s1,a4,aa4 <malloc+0xa6>
        p->s.size -= nunits;
 a72:	4137073b          	subw	a4,a4,s3
 a76:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a78:	1702                	slli	a4,a4,0x20
 a7a:	9301                	srli	a4,a4,0x20
 a7c:	0712                	slli	a4,a4,0x4
 a7e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a80:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a84:	00000717          	auipc	a4,0x0
 a88:	56a73e23          	sd	a0,1404(a4) # 1000 <freep>
      return (void *)(p + 1);
 a8c:	01078513          	addi	a0,a5,16
      if ((p = morecore(nunits)) == 0) return 0;
  }
}
 a90:	70e2                	ld	ra,56(sp)
 a92:	7442                	ld	s0,48(sp)
 a94:	74a2                	ld	s1,40(sp)
 a96:	7902                	ld	s2,32(sp)
 a98:	69e2                	ld	s3,24(sp)
 a9a:	6a42                	ld	s4,16(sp)
 a9c:	6aa2                	ld	s5,8(sp)
 a9e:	6b02                	ld	s6,0(sp)
 aa0:	6121                	addi	sp,sp,64
 aa2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 aa4:	6398                	ld	a4,0(a5)
 aa6:	e118                	sd	a4,0(a0)
 aa8:	bff1                	j	a84 <malloc+0x86>
  hp->s.size = nu;
 aaa:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 aae:	0541                	addi	a0,a0,16
 ab0:	00000097          	auipc	ra,0x0
 ab4:	ec6080e7          	jalr	-314(ra) # 976 <free>
  return freep;
 ab8:	00093503          	ld	a0,0(s2)
      if ((p = morecore(nunits)) == 0) return 0;
 abc:	d971                	beqz	a0,a90 <malloc+0x92>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 abe:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 ac0:	4798                	lw	a4,8(a5)
 ac2:	fa9776e3          	bgeu	a4,s1,a6e <malloc+0x70>
    if (p == freep)
 ac6:	00093703          	ld	a4,0(s2)
 aca:	853e                	mv	a0,a5
 acc:	fef719e3          	bne	a4,a5,abe <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 ad0:	8552                	mv	a0,s4
 ad2:	00000097          	auipc	ra,0x0
 ad6:	b7e080e7          	jalr	-1154(ra) # 650 <sbrk>
  if (p == (char *)-1) return 0;
 ada:	fd5518e3          	bne	a0,s5,aaa <malloc+0xac>
      if ((p = morecore(nunits)) == 0) return 0;
 ade:	4501                	li	a0,0
 ae0:	bf45                	j	a90 <malloc+0x92>
