
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
//      asm volatile("");

#include "kernel/fcntl.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	8ca78793          	addi	a5,a5,-1846 # 8e0 <malloc+0x116>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	88450513          	addi	a0,a0,-1916 # 8b0 <malloc+0xe6>
  34:	00000097          	auipc	ra,0x0
  38:	6d8080e7          	jalr	1752(ra) # 70c <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	150080e7          	jalr	336(ra) # 198 <memset>

  for (i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if (fork() > 0) break;
  54:	00000097          	auipc	ra,0x0
  58:	338080e7          	jalr	824(ra) # 38c <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for (i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	86050513          	addi	a0,a0,-1952 # 8c8 <malloc+0xfe>
  70:	00000097          	auipc	ra,0x0
  74:	69c080e7          	jalr	1692(ra) # 70c <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9cbd                	addw	s1,s1,a5
  7e:	fc940c23          	sb	s1,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	34a080e7          	jalr	842(ra) # 3d4 <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    //    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	314080e7          	jalr	788(ra) # 3b4 <write>
  for (i = 0; i < 20; i++)
  a8:	34fd                	addiw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	30e080e7          	jalr	782(ra) # 3bc <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	82250513          	addi	a0,a0,-2014 # 8d8 <malloc+0x10e>
  be:	00000097          	auipc	ra,0x0
  c2:	64e080e7          	jalr	1614(ra) # 70c <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	308080e7          	jalr	776(ra) # 3d4 <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++) read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	2ca080e7          	jalr	714(ra) # 3ac <read>
  ea:	34fd                	addiw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	2cc080e7          	jalr	716(ra) # 3bc <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	2a2080e7          	jalr	674(ra) # 39c <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	290080e7          	jalr	656(ra) # 394 <exit>

000000000000010c <_main>:
#include "user/user.h"

//
// wrapper so that it's OK if main() does not call exit().
//
void _main() {
 10c:	1141                	addi	sp,sp,-16
 10e:	e406                	sd	ra,8(sp)
 110:	e022                	sd	s0,0(sp)
 112:	0800                	addi	s0,sp,16
  extern int main();
  main();
 114:	00000097          	auipc	ra,0x0
 118:	eec080e7          	jalr	-276(ra) # 0 <main>
  exit(0);
 11c:	4501                	li	a0,0
 11e:	00000097          	auipc	ra,0x0
 122:	276080e7          	jalr	630(ra) # 394 <exit>

0000000000000126 <strcpy>:
}

char *strcpy(char *s, const char *t) {
 126:	1141                	addi	sp,sp,-16
 128:	e422                	sd	s0,8(sp)
 12a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 12c:	87aa                	mv	a5,a0
 12e:	0585                	addi	a1,a1,1
 130:	0785                	addi	a5,a5,1
 132:	fff5c703          	lbu	a4,-1(a1)
 136:	fee78fa3          	sb	a4,-1(a5)
 13a:	fb75                	bnez	a4,12e <strcpy+0x8>
    ;
  return os;
}
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret

0000000000000142 <strcmp>:

int strcmp(const char *p, const char *q) {
 142:	1141                	addi	sp,sp,-16
 144:	e422                	sd	s0,8(sp)
 146:	0800                	addi	s0,sp,16
  while (*p && *p == *q) p++, q++;
 148:	00054783          	lbu	a5,0(a0)
 14c:	cb91                	beqz	a5,160 <strcmp+0x1e>
 14e:	0005c703          	lbu	a4,0(a1)
 152:	00f71763          	bne	a4,a5,160 <strcmp+0x1e>
 156:	0505                	addi	a0,a0,1
 158:	0585                	addi	a1,a1,1
 15a:	00054783          	lbu	a5,0(a0)
 15e:	fbe5                	bnez	a5,14e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 160:	0005c503          	lbu	a0,0(a1)
}
 164:	40a7853b          	subw	a0,a5,a0
 168:	6422                	ld	s0,8(sp)
 16a:	0141                	addi	sp,sp,16
 16c:	8082                	ret

000000000000016e <strlen>:

uint strlen(const char *s) {
 16e:	1141                	addi	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 174:	00054783          	lbu	a5,0(a0)
 178:	cf91                	beqz	a5,194 <strlen+0x26>
 17a:	0505                	addi	a0,a0,1
 17c:	87aa                	mv	a5,a0
 17e:	4685                	li	a3,1
 180:	9e89                	subw	a3,a3,a0
 182:	00f6853b          	addw	a0,a3,a5
 186:	0785                	addi	a5,a5,1
 188:	fff7c703          	lbu	a4,-1(a5)
 18c:	fb7d                	bnez	a4,182 <strlen+0x14>
    ;
  return n;
}
 18e:	6422                	ld	s0,8(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret
  for (n = 0; s[n]; n++)
 194:	4501                	li	a0,0
 196:	bfe5                	j	18e <strlen+0x20>

0000000000000198 <memset>:

void *memset(void *dst, int c, uint n) {
 198:	1141                	addi	sp,sp,-16
 19a:	e422                	sd	s0,8(sp)
 19c:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 19e:	ca19                	beqz	a2,1b4 <memset+0x1c>
 1a0:	87aa                	mv	a5,a0
 1a2:	1602                	slli	a2,a2,0x20
 1a4:	9201                	srli	a2,a2,0x20
 1a6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1aa:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 1ae:	0785                	addi	a5,a5,1
 1b0:	fee79de3          	bne	a5,a4,1aa <memset+0x12>
  }
  return dst;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strchr>:

char *strchr(const char *s, char c) {
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  for (; *s; s++)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cb99                	beqz	a5,1da <strchr+0x20>
    if (*s == c) return (char *)s;
 1c6:	00f58763          	beq	a1,a5,1d4 <strchr+0x1a>
  for (; *s; s++)
 1ca:	0505                	addi	a0,a0,1
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	fbfd                	bnez	a5,1c6 <strchr+0xc>
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret
  return 0;
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strchr+0x1a>

00000000000001de <gets>:

char *gets(char *buf, int max) {
 1de:	711d                	addi	sp,sp,-96
 1e0:	ec86                	sd	ra,88(sp)
 1e2:	e8a2                	sd	s0,80(sp)
 1e4:	e4a6                	sd	s1,72(sp)
 1e6:	e0ca                	sd	s2,64(sp)
 1e8:	fc4e                	sd	s3,56(sp)
 1ea:	f852                	sd	s4,48(sp)
 1ec:	f456                	sd	s5,40(sp)
 1ee:	f05a                	sd	s6,32(sp)
 1f0:	ec5e                	sd	s7,24(sp)
 1f2:	1080                	addi	s0,sp,96
 1f4:	8baa                	mv	s7,a0
 1f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 1f8:	892a                	mv	s2,a0
 1fa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1) break;
    buf[i++] = c;
    if (c == '\n' || c == '\r') break;
 1fc:	4aa9                	li	s5,10
 1fe:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
 200:	89a6                	mv	s3,s1
 202:	2485                	addiw	s1,s1,1
 204:	0344d863          	bge	s1,s4,234 <gets+0x56>
    cc = read(0, &c, 1);
 208:	4605                	li	a2,1
 20a:	faf40593          	addi	a1,s0,-81
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	19c080e7          	jalr	412(ra) # 3ac <read>
    if (cc < 1) break;
 218:	00a05e63          	blez	a0,234 <gets+0x56>
    buf[i++] = c;
 21c:	faf44783          	lbu	a5,-81(s0)
 220:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r') break;
 224:	01578763          	beq	a5,s5,232 <gets+0x54>
 228:	0905                	addi	s2,s2,1
 22a:	fd679be3          	bne	a5,s6,200 <gets+0x22>
  for (i = 0; i + 1 < max;) {
 22e:	89a6                	mv	s3,s1
 230:	a011                	j	234 <gets+0x56>
 232:	89a6                	mv	s3,s1
  }
  buf[i] = '\0';
 234:	99de                	add	s3,s3,s7
 236:	00098023          	sb	zero,0(s3)
  return buf;
}
 23a:	855e                	mv	a0,s7
 23c:	60e6                	ld	ra,88(sp)
 23e:	6446                	ld	s0,80(sp)
 240:	64a6                	ld	s1,72(sp)
 242:	6906                	ld	s2,64(sp)
 244:	79e2                	ld	s3,56(sp)
 246:	7a42                	ld	s4,48(sp)
 248:	7aa2                	ld	s5,40(sp)
 24a:	7b02                	ld	s6,32(sp)
 24c:	6be2                	ld	s7,24(sp)
 24e:	6125                	addi	sp,sp,96
 250:	8082                	ret

0000000000000252 <stat>:

int stat(const char *n, struct stat *st) {
 252:	1101                	addi	sp,sp,-32
 254:	ec06                	sd	ra,24(sp)
 256:	e822                	sd	s0,16(sp)
 258:	e426                	sd	s1,8(sp)
 25a:	e04a                	sd	s2,0(sp)
 25c:	1000                	addi	s0,sp,32
 25e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 260:	4581                	li	a1,0
 262:	00000097          	auipc	ra,0x0
 266:	172080e7          	jalr	370(ra) # 3d4 <open>
  if (fd < 0) return -1;
 26a:	02054563          	bltz	a0,294 <stat+0x42>
 26e:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 270:	85ca                	mv	a1,s2
 272:	00000097          	auipc	ra,0x0
 276:	17a080e7          	jalr	378(ra) # 3ec <fstat>
 27a:	892a                	mv	s2,a0
  close(fd);
 27c:	8526                	mv	a0,s1
 27e:	00000097          	auipc	ra,0x0
 282:	13e080e7          	jalr	318(ra) # 3bc <close>
  return r;
}
 286:	854a                	mv	a0,s2
 288:	60e2                	ld	ra,24(sp)
 28a:	6442                	ld	s0,16(sp)
 28c:	64a2                	ld	s1,8(sp)
 28e:	6902                	ld	s2,0(sp)
 290:	6105                	addi	sp,sp,32
 292:	8082                	ret
  if (fd < 0) return -1;
 294:	597d                	li	s2,-1
 296:	bfc5                	j	286 <stat+0x34>

0000000000000298 <atoi>:

int atoi(const char *s) {
 298:	1141                	addi	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
 29e:	00054603          	lbu	a2,0(a0)
 2a2:	fd06079b          	addiw	a5,a2,-48
 2a6:	0ff7f793          	andi	a5,a5,255
 2aa:	4725                	li	a4,9
 2ac:	02f76963          	bltu	a4,a5,2de <atoi+0x46>
 2b0:	86aa                	mv	a3,a0
  n = 0;
 2b2:	4501                	li	a0,0
  while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
 2b4:	45a5                	li	a1,9
 2b6:	0685                	addi	a3,a3,1
 2b8:	0025179b          	slliw	a5,a0,0x2
 2bc:	9fa9                	addw	a5,a5,a0
 2be:	0017979b          	slliw	a5,a5,0x1
 2c2:	9fb1                	addw	a5,a5,a2
 2c4:	fd07851b          	addiw	a0,a5,-48
 2c8:	0006c603          	lbu	a2,0(a3)
 2cc:	fd06071b          	addiw	a4,a2,-48
 2d0:	0ff77713          	andi	a4,a4,255
 2d4:	fee5f1e3          	bgeu	a1,a4,2b6 <atoi+0x1e>
  return n;
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
  n = 0;
 2de:	4501                	li	a0,0
 2e0:	bfe5                	j	2d8 <atoi+0x40>

00000000000002e2 <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e8:	02b57463          	bgeu	a0,a1,310 <memmove+0x2e>
    while (n-- > 0) *dst++ = *src++;
 2ec:	00c05f63          	blez	a2,30a <memmove+0x28>
 2f0:	1602                	slli	a2,a2,0x20
 2f2:	9201                	srli	a2,a2,0x20
 2f4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2f8:	872a                	mv	a4,a0
    while (n-- > 0) *dst++ = *src++;
 2fa:	0585                	addi	a1,a1,1
 2fc:	0705                	addi	a4,a4,1
 2fe:	fff5c683          	lbu	a3,-1(a1)
 302:	fed70fa3          	sb	a3,-1(a4)
 306:	fee79ae3          	bne	a5,a4,2fa <memmove+0x18>
    dst += n;
    src += n;
    while (n-- > 0) *--dst = *--src;
  }
  return vdst;
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
    dst += n;
 310:	00c50733          	add	a4,a0,a2
    src += n;
 314:	95b2                	add	a1,a1,a2
    while (n-- > 0) *--dst = *--src;
 316:	fec05ae3          	blez	a2,30a <memmove+0x28>
 31a:	fff6079b          	addiw	a5,a2,-1
 31e:	1782                	slli	a5,a5,0x20
 320:	9381                	srli	a5,a5,0x20
 322:	fff7c793          	not	a5,a5
 326:	97ba                	add	a5,a5,a4
 328:	15fd                	addi	a1,a1,-1
 32a:	177d                	addi	a4,a4,-1
 32c:	0005c683          	lbu	a3,0(a1)
 330:	00d70023          	sb	a3,0(a4)
 334:	fee79ae3          	bne	a5,a4,328 <memmove+0x46>
 338:	bfc9                	j	30a <memmove+0x28>

000000000000033a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 33a:	1141                	addi	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 340:	ca05                	beqz	a2,370 <memcmp+0x36>
 342:	fff6069b          	addiw	a3,a2,-1
 346:	1682                	slli	a3,a3,0x20
 348:	9281                	srli	a3,a3,0x20
 34a:	0685                	addi	a3,a3,1
 34c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 34e:	00054783          	lbu	a5,0(a0)
 352:	0005c703          	lbu	a4,0(a1)
 356:	00e79863          	bne	a5,a4,366 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 35a:	0505                	addi	a0,a0,1
    p2++;
 35c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 35e:	fed518e3          	bne	a0,a3,34e <memcmp+0x14>
  }
  return 0;
 362:	4501                	li	a0,0
 364:	a019                	j	36a <memcmp+0x30>
      return *p1 - *p2;
 366:	40e7853b          	subw	a0,a5,a4
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret
  return 0;
 370:	4501                	li	a0,0
 372:	bfe5                	j	36a <memcmp+0x30>

0000000000000374 <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 374:	1141                	addi	sp,sp,-16
 376:	e406                	sd	ra,8(sp)
 378:	e022                	sd	s0,0(sp)
 37a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 37c:	00000097          	auipc	ra,0x0
 380:	f66080e7          	jalr	-154(ra) # 2e2 <memmove>
}
 384:	60a2                	ld	ra,8(sp)
 386:	6402                	ld	s0,0(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret

000000000000038c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 38c:	4885                	li	a7,1
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <exit>:
.global exit
exit:
 li a7, SYS_exit
 394:	4889                	li	a7,2
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <wait>:
.global wait
wait:
 li a7, SYS_wait
 39c:	488d                	li	a7,3
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a4:	4891                	li	a7,4
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <read>:
.global read
read:
 li a7, SYS_read
 3ac:	4895                	li	a7,5
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <write>:
.global write
write:
 li a7, SYS_write
 3b4:	48c1                	li	a7,16
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <close>:
.global close
close:
 li a7, SYS_close
 3bc:	48d5                	li	a7,21
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c4:	4899                	li	a7,6
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <exec>:
.global exec
exec:
 li a7, SYS_exec
 3cc:	489d                	li	a7,7
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <open>:
.global open
open:
 li a7, SYS_open
 3d4:	48bd                	li	a7,15
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3dc:	48c5                	li	a7,17
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e4:	48c9                	li	a7,18
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ec:	48a1                	li	a7,8
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <link>:
.global link
link:
 li a7, SYS_link
 3f4:	48cd                	li	a7,19
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3fc:	48d1                	li	a7,20
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 404:	48a5                	li	a7,9
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <dup>:
.global dup
dup:
 li a7, SYS_dup
 40c:	48a9                	li	a7,10
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 414:	48ad                	li	a7,11
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 41c:	48b1                	li	a7,12
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 424:	48b5                	li	a7,13
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 42c:	48b9                	li	a7,14
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <putc>:
#include "kernel/types.h"
#include "user/user.h"

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
 434:	1101                	addi	sp,sp,-32
 436:	ec06                	sd	ra,24(sp)
 438:	e822                	sd	s0,16(sp)
 43a:	1000                	addi	s0,sp,32
 43c:	feb407a3          	sb	a1,-17(s0)
 440:	4605                	li	a2,1
 442:	fef40593          	addi	a1,s0,-17
 446:	00000097          	auipc	ra,0x0
 44a:	f6e080e7          	jalr	-146(ra) # 3b4 <write>
 44e:	60e2                	ld	ra,24(sp)
 450:	6442                	ld	s0,16(sp)
 452:	6105                	addi	sp,sp,32
 454:	8082                	ret

0000000000000456 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
 456:	7139                	addi	sp,sp,-64
 458:	fc06                	sd	ra,56(sp)
 45a:	f822                	sd	s0,48(sp)
 45c:	f426                	sd	s1,40(sp)
 45e:	f04a                	sd	s2,32(sp)
 460:	ec4e                	sd	s3,24(sp)
 462:	0080                	addi	s0,sp,64
 464:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if (sgn && xx < 0) {
 466:	c299                	beqz	a3,46c <printint+0x16>
 468:	0805c863          	bltz	a1,4f8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 46c:	2581                	sext.w	a1,a1
  neg = 0;
 46e:	4881                	li	a7,0
 470:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 474:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
 476:	2601                	sext.w	a2,a2
 478:	00000517          	auipc	a0,0x0
 47c:	48050513          	addi	a0,a0,1152 # 8f8 <digits>
 480:	883a                	mv	a6,a4
 482:	2705                	addiw	a4,a4,1
 484:	02c5f7bb          	remuw	a5,a1,a2
 488:	1782                	slli	a5,a5,0x20
 48a:	9381                	srli	a5,a5,0x20
 48c:	97aa                	add	a5,a5,a0
 48e:	0007c783          	lbu	a5,0(a5)
 492:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
 496:	0005879b          	sext.w	a5,a1
 49a:	02c5d5bb          	divuw	a1,a1,a2
 49e:	0685                	addi	a3,a3,1
 4a0:	fec7f0e3          	bgeu	a5,a2,480 <printint+0x2a>
  if (neg) buf[i++] = '-';
 4a4:	00088b63          	beqz	a7,4ba <printint+0x64>
 4a8:	fd040793          	addi	a5,s0,-48
 4ac:	973e                	add	a4,a4,a5
 4ae:	02d00793          	li	a5,45
 4b2:	fef70823          	sb	a5,-16(a4)
 4b6:	0028071b          	addiw	a4,a6,2

  while (--i >= 0) putc(fd, buf[i]);
 4ba:	02e05863          	blez	a4,4ea <printint+0x94>
 4be:	fc040793          	addi	a5,s0,-64
 4c2:	00e78933          	add	s2,a5,a4
 4c6:	fff78993          	addi	s3,a5,-1
 4ca:	99ba                	add	s3,s3,a4
 4cc:	377d                	addiw	a4,a4,-1
 4ce:	1702                	slli	a4,a4,0x20
 4d0:	9301                	srli	a4,a4,0x20
 4d2:	40e989b3          	sub	s3,s3,a4
 4d6:	fff94583          	lbu	a1,-1(s2)
 4da:	8526                	mv	a0,s1
 4dc:	00000097          	auipc	ra,0x0
 4e0:	f58080e7          	jalr	-168(ra) # 434 <putc>
 4e4:	197d                	addi	s2,s2,-1
 4e6:	ff3918e3          	bne	s2,s3,4d6 <printint+0x80>
}
 4ea:	70e2                	ld	ra,56(sp)
 4ec:	7442                	ld	s0,48(sp)
 4ee:	74a2                	ld	s1,40(sp)
 4f0:	7902                	ld	s2,32(sp)
 4f2:	69e2                	ld	s3,24(sp)
 4f4:	6121                	addi	sp,sp,64
 4f6:	8082                	ret
    x = -xx;
 4f8:	40b005bb          	negw	a1,a1
    neg = 1;
 4fc:	4885                	li	a7,1
    x = -xx;
 4fe:	bf8d                	j	470 <printint+0x1a>

0000000000000500 <vprintf>:
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
 500:	7119                	addi	sp,sp,-128
 502:	fc86                	sd	ra,120(sp)
 504:	f8a2                	sd	s0,112(sp)
 506:	f4a6                	sd	s1,104(sp)
 508:	f0ca                	sd	s2,96(sp)
 50a:	ecce                	sd	s3,88(sp)
 50c:	e8d2                	sd	s4,80(sp)
 50e:	e4d6                	sd	s5,72(sp)
 510:	e0da                	sd	s6,64(sp)
 512:	fc5e                	sd	s7,56(sp)
 514:	f862                	sd	s8,48(sp)
 516:	f466                	sd	s9,40(sp)
 518:	f06a                	sd	s10,32(sp)
 51a:	ec6e                	sd	s11,24(sp)
 51c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 51e:	0005c903          	lbu	s2,0(a1)
 522:	18090f63          	beqz	s2,6c0 <vprintf+0x1c0>
 526:	8aaa                	mv	s5,a0
 528:	8b32                	mv	s6,a2
 52a:	00158493          	addi	s1,a1,1
  state = 0;
 52e:	4981                	li	s3,0
      if (c == '%') {
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if (state == '%') {
 530:	02500a13          	li	s4,37
      if (c == 'd') {
 534:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c == 'l') {
 538:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if (c == 'x') {
 53c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if (c == 'p') {
 540:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 544:	00000b97          	auipc	s7,0x0
 548:	3b4b8b93          	addi	s7,s7,948 # 8f8 <digits>
 54c:	a839                	j	56a <vprintf+0x6a>
        putc(fd, c);
 54e:	85ca                	mv	a1,s2
 550:	8556                	mv	a0,s5
 552:	00000097          	auipc	ra,0x0
 556:	ee2080e7          	jalr	-286(ra) # 434 <putc>
 55a:	a019                	j	560 <vprintf+0x60>
    } else if (state == '%') {
 55c:	01498f63          	beq	s3,s4,57a <vprintf+0x7a>
  for (i = 0; fmt[i]; i++) {
 560:	0485                	addi	s1,s1,1
 562:	fff4c903          	lbu	s2,-1(s1)
 566:	14090d63          	beqz	s2,6c0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 56a:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 56e:	fe0997e3          	bnez	s3,55c <vprintf+0x5c>
      if (c == '%') {
 572:	fd479ee3          	bne	a5,s4,54e <vprintf+0x4e>
        state = '%';
 576:	89be                	mv	s3,a5
 578:	b7e5                	j	560 <vprintf+0x60>
      if (c == 'd') {
 57a:	05878063          	beq	a5,s8,5ba <vprintf+0xba>
      } else if (c == 'l') {
 57e:	05978c63          	beq	a5,s9,5d6 <vprintf+0xd6>
      } else if (c == 'x') {
 582:	07a78863          	beq	a5,s10,5f2 <vprintf+0xf2>
      } else if (c == 'p') {
 586:	09b78463          	beq	a5,s11,60e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if (c == 's') {
 58a:	07300713          	li	a4,115
 58e:	0ce78663          	beq	a5,a4,65a <vprintf+0x15a>
        if (s == 0) s = "(null)";
        while (*s != 0) {
          putc(fd, *s);
          s++;
        }
      } else if (c == 'c') {
 592:	06300713          	li	a4,99
 596:	0ee78e63          	beq	a5,a4,692 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if (c == '%') {
 59a:	11478863          	beq	a5,s4,6aa <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 59e:	85d2                	mv	a1,s4
 5a0:	8556                	mv	a0,s5
 5a2:	00000097          	auipc	ra,0x0
 5a6:	e92080e7          	jalr	-366(ra) # 434 <putc>
        putc(fd, c);
 5aa:	85ca                	mv	a1,s2
 5ac:	8556                	mv	a0,s5
 5ae:	00000097          	auipc	ra,0x0
 5b2:	e86080e7          	jalr	-378(ra) # 434 <putc>
      }
      state = 0;
 5b6:	4981                	li	s3,0
 5b8:	b765                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5ba:	008b0913          	addi	s2,s6,8
 5be:	4685                	li	a3,1
 5c0:	4629                	li	a2,10
 5c2:	000b2583          	lw	a1,0(s6)
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	e8e080e7          	jalr	-370(ra) # 456 <printint>
 5d0:	8b4a                	mv	s6,s2
      state = 0;
 5d2:	4981                	li	s3,0
 5d4:	b771                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d6:	008b0913          	addi	s2,s6,8
 5da:	4681                	li	a3,0
 5dc:	4629                	li	a2,10
 5de:	000b2583          	lw	a1,0(s6)
 5e2:	8556                	mv	a0,s5
 5e4:	00000097          	auipc	ra,0x0
 5e8:	e72080e7          	jalr	-398(ra) # 456 <printint>
 5ec:	8b4a                	mv	s6,s2
      state = 0;
 5ee:	4981                	li	s3,0
 5f0:	bf85                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5f2:	008b0913          	addi	s2,s6,8
 5f6:	4681                	li	a3,0
 5f8:	4641                	li	a2,16
 5fa:	000b2583          	lw	a1,0(s6)
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	e56080e7          	jalr	-426(ra) # 456 <printint>
 608:	8b4a                	mv	s6,s2
      state = 0;
 60a:	4981                	li	s3,0
 60c:	bf91                	j	560 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 60e:	008b0793          	addi	a5,s6,8
 612:	f8f43423          	sd	a5,-120(s0)
 616:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 61a:	03000593          	li	a1,48
 61e:	8556                	mv	a0,s5
 620:	00000097          	auipc	ra,0x0
 624:	e14080e7          	jalr	-492(ra) # 434 <putc>
  putc(fd, 'x');
 628:	85ea                	mv	a1,s10
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e08080e7          	jalr	-504(ra) # 434 <putc>
 634:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 636:	03c9d793          	srli	a5,s3,0x3c
 63a:	97de                	add	a5,a5,s7
 63c:	0007c583          	lbu	a1,0(a5)
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	df2080e7          	jalr	-526(ra) # 434 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 64a:	0992                	slli	s3,s3,0x4
 64c:	397d                	addiw	s2,s2,-1
 64e:	fe0914e3          	bnez	s2,636 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 652:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 656:	4981                	li	s3,0
 658:	b721                	j	560 <vprintf+0x60>
        s = va_arg(ap, char *);
 65a:	008b0993          	addi	s3,s6,8
 65e:	000b3903          	ld	s2,0(s6)
        if (s == 0) s = "(null)";
 662:	02090163          	beqz	s2,684 <vprintf+0x184>
        while (*s != 0) {
 666:	00094583          	lbu	a1,0(s2)
 66a:	c9a1                	beqz	a1,6ba <vprintf+0x1ba>
          putc(fd, *s);
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	dc6080e7          	jalr	-570(ra) # 434 <putc>
          s++;
 676:	0905                	addi	s2,s2,1
        while (*s != 0) {
 678:	00094583          	lbu	a1,0(s2)
 67c:	f9e5                	bnez	a1,66c <vprintf+0x16c>
        s = va_arg(ap, char *);
 67e:	8b4e                	mv	s6,s3
      state = 0;
 680:	4981                	li	s3,0
 682:	bdf9                	j	560 <vprintf+0x60>
        if (s == 0) s = "(null)";
 684:	00000917          	auipc	s2,0x0
 688:	26c90913          	addi	s2,s2,620 # 8f0 <malloc+0x126>
        while (*s != 0) {
 68c:	02800593          	li	a1,40
 690:	bff1                	j	66c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 692:	008b0913          	addi	s2,s6,8
 696:	000b4583          	lbu	a1,0(s6)
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	d98080e7          	jalr	-616(ra) # 434 <putc>
 6a4:	8b4a                	mv	s6,s2
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	bd65                	j	560 <vprintf+0x60>
        putc(fd, c);
 6aa:	85d2                	mv	a1,s4
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	d86080e7          	jalr	-634(ra) # 434 <putc>
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b565                	j	560 <vprintf+0x60>
        s = va_arg(ap, char *);
 6ba:	8b4e                	mv	s6,s3
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b54d                	j	560 <vprintf+0x60>
    }
  }
}
 6c0:	70e6                	ld	ra,120(sp)
 6c2:	7446                	ld	s0,112(sp)
 6c4:	74a6                	ld	s1,104(sp)
 6c6:	7906                	ld	s2,96(sp)
 6c8:	69e6                	ld	s3,88(sp)
 6ca:	6a46                	ld	s4,80(sp)
 6cc:	6aa6                	ld	s5,72(sp)
 6ce:	6b06                	ld	s6,64(sp)
 6d0:	7be2                	ld	s7,56(sp)
 6d2:	7c42                	ld	s8,48(sp)
 6d4:	7ca2                	ld	s9,40(sp)
 6d6:	7d02                	ld	s10,32(sp)
 6d8:	6de2                	ld	s11,24(sp)
 6da:	6109                	addi	sp,sp,128
 6dc:	8082                	ret

00000000000006de <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
 6de:	715d                	addi	sp,sp,-80
 6e0:	ec06                	sd	ra,24(sp)
 6e2:	e822                	sd	s0,16(sp)
 6e4:	1000                	addi	s0,sp,32
 6e6:	e010                	sd	a2,0(s0)
 6e8:	e414                	sd	a3,8(s0)
 6ea:	e818                	sd	a4,16(s0)
 6ec:	ec1c                	sd	a5,24(s0)
 6ee:	03043023          	sd	a6,32(s0)
 6f2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6f6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6fa:	8622                	mv	a2,s0
 6fc:	00000097          	auipc	ra,0x0
 700:	e04080e7          	jalr	-508(ra) # 500 <vprintf>
}
 704:	60e2                	ld	ra,24(sp)
 706:	6442                	ld	s0,16(sp)
 708:	6161                	addi	sp,sp,80
 70a:	8082                	ret

000000000000070c <printf>:

void printf(const char *fmt, ...) {
 70c:	711d                	addi	sp,sp,-96
 70e:	ec06                	sd	ra,24(sp)
 710:	e822                	sd	s0,16(sp)
 712:	1000                	addi	s0,sp,32
 714:	e40c                	sd	a1,8(s0)
 716:	e810                	sd	a2,16(s0)
 718:	ec14                	sd	a3,24(s0)
 71a:	f018                	sd	a4,32(s0)
 71c:	f41c                	sd	a5,40(s0)
 71e:	03043823          	sd	a6,48(s0)
 722:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 726:	00840613          	addi	a2,s0,8
 72a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 72e:	85aa                	mv	a1,a0
 730:	4505                	li	a0,1
 732:	00000097          	auipc	ra,0x0
 736:	dce080e7          	jalr	-562(ra) # 500 <vprintf>
}
 73a:	60e2                	ld	ra,24(sp)
 73c:	6442                	ld	s0,16(sp)
 73e:	6125                	addi	sp,sp,96
 740:	8082                	ret

0000000000000742 <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
 742:	1141                	addi	sp,sp,-16
 744:	e422                	sd	s0,8(sp)
 746:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 748:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74c:	00001797          	auipc	a5,0x1
 750:	8b47b783          	ld	a5,-1868(a5) # 1000 <freep>
 754:	a805                	j	784 <free+0x42>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
 756:	4618                	lw	a4,8(a2)
 758:	9db9                	addw	a1,a1,a4
 75a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 75e:	6398                	ld	a4,0(a5)
 760:	6318                	ld	a4,0(a4)
 762:	fee53823          	sd	a4,-16(a0)
 766:	a091                	j	7aa <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
 768:	ff852703          	lw	a4,-8(a0)
 76c:	9e39                	addw	a2,a2,a4
 76e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 770:	ff053703          	ld	a4,-16(a0)
 774:	e398                	sd	a4,0(a5)
 776:	a099                	j	7bc <free+0x7a>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
 778:	6398                	ld	a4,0(a5)
 77a:	00e7e463          	bltu	a5,a4,782 <free+0x40>
 77e:	00e6ea63          	bltu	a3,a4,792 <free+0x50>
void free(void *ap) {
 782:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 784:	fed7fae3          	bgeu	a5,a3,778 <free+0x36>
 788:	6398                	ld	a4,0(a5)
 78a:	00e6e463          	bltu	a3,a4,792 <free+0x50>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
 78e:	fee7eae3          	bltu	a5,a4,782 <free+0x40>
  if (bp + bp->s.size == p->s.ptr) {
 792:	ff852583          	lw	a1,-8(a0)
 796:	6390                	ld	a2,0(a5)
 798:	02059713          	slli	a4,a1,0x20
 79c:	9301                	srli	a4,a4,0x20
 79e:	0712                	slli	a4,a4,0x4
 7a0:	9736                	add	a4,a4,a3
 7a2:	fae60ae3          	beq	a2,a4,756 <free+0x14>
    bp->s.ptr = p->s.ptr;
 7a6:	fec53823          	sd	a2,-16(a0)
  if (p + p->s.size == bp) {
 7aa:	4790                	lw	a2,8(a5)
 7ac:	02061713          	slli	a4,a2,0x20
 7b0:	9301                	srli	a4,a4,0x20
 7b2:	0712                	slli	a4,a4,0x4
 7b4:	973e                	add	a4,a4,a5
 7b6:	fae689e3          	beq	a3,a4,768 <free+0x26>
  } else
    p->s.ptr = bp;
 7ba:	e394                	sd	a3,0(a5)
  freep = p;
 7bc:	00001717          	auipc	a4,0x1
 7c0:	84f73223          	sd	a5,-1980(a4) # 1000 <freep>
}
 7c4:	6422                	ld	s0,8(sp)
 7c6:	0141                	addi	sp,sp,16
 7c8:	8082                	ret

00000000000007ca <malloc>:
  hp->s.size = nu;
  free((void *)(hp + 1));
  return freep;
}

void *malloc(uint nbytes) {
 7ca:	7139                	addi	sp,sp,-64
 7cc:	fc06                	sd	ra,56(sp)
 7ce:	f822                	sd	s0,48(sp)
 7d0:	f426                	sd	s1,40(sp)
 7d2:	f04a                	sd	s2,32(sp)
 7d4:	ec4e                	sd	s3,24(sp)
 7d6:	e852                	sd	s4,16(sp)
 7d8:	e456                	sd	s5,8(sp)
 7da:	e05a                	sd	s6,0(sp)
 7dc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 7de:	02051493          	slli	s1,a0,0x20
 7e2:	9081                	srli	s1,s1,0x20
 7e4:	04bd                	addi	s1,s1,15
 7e6:	8091                	srli	s1,s1,0x4
 7e8:	0014899b          	addiw	s3,s1,1
 7ec:	0485                	addi	s1,s1,1
  if ((prevp = freep) == 0) {
 7ee:	00001517          	auipc	a0,0x1
 7f2:	81253503          	ld	a0,-2030(a0) # 1000 <freep>
 7f6:	c515                	beqz	a0,822 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 7f8:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 7fa:	4798                	lw	a4,8(a5)
 7fc:	02977f63          	bgeu	a4,s1,83a <malloc+0x70>
 800:	8a4e                	mv	s4,s3
 802:	0009871b          	sext.w	a4,s3
 806:	6685                	lui	a3,0x1
 808:	00d77363          	bgeu	a4,a3,80e <malloc+0x44>
 80c:	6a05                	lui	s4,0x1
 80e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 812:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 816:	00000917          	auipc	s2,0x0
 81a:	7ea90913          	addi	s2,s2,2026 # 1000 <freep>
  if (p == (char *)-1) return 0;
 81e:	5afd                	li	s5,-1
 820:	a88d                	j	892 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 822:	00000797          	auipc	a5,0x0
 826:	7ee78793          	addi	a5,a5,2030 # 1010 <base>
 82a:	00000717          	auipc	a4,0x0
 82e:	7cf73b23          	sd	a5,2006(a4) # 1000 <freep>
 832:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 834:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 838:	b7e1                	j	800 <malloc+0x36>
      if (p->s.size == nunits)
 83a:	02e48b63          	beq	s1,a4,870 <malloc+0xa6>
        p->s.size -= nunits;
 83e:	4137073b          	subw	a4,a4,s3
 842:	c798                	sw	a4,8(a5)
        p += p->s.size;
 844:	1702                	slli	a4,a4,0x20
 846:	9301                	srli	a4,a4,0x20
 848:	0712                	slli	a4,a4,0x4
 84a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 84c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 850:	00000717          	auipc	a4,0x0
 854:	7aa73823          	sd	a0,1968(a4) # 1000 <freep>
      return (void *)(p + 1);
 858:	01078513          	addi	a0,a5,16
      if ((p = morecore(nunits)) == 0) return 0;
  }
}
 85c:	70e2                	ld	ra,56(sp)
 85e:	7442                	ld	s0,48(sp)
 860:	74a2                	ld	s1,40(sp)
 862:	7902                	ld	s2,32(sp)
 864:	69e2                	ld	s3,24(sp)
 866:	6a42                	ld	s4,16(sp)
 868:	6aa2                	ld	s5,8(sp)
 86a:	6b02                	ld	s6,0(sp)
 86c:	6121                	addi	sp,sp,64
 86e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 870:	6398                	ld	a4,0(a5)
 872:	e118                	sd	a4,0(a0)
 874:	bff1                	j	850 <malloc+0x86>
  hp->s.size = nu;
 876:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 87a:	0541                	addi	a0,a0,16
 87c:	00000097          	auipc	ra,0x0
 880:	ec6080e7          	jalr	-314(ra) # 742 <free>
  return freep;
 884:	00093503          	ld	a0,0(s2)
      if ((p = morecore(nunits)) == 0) return 0;
 888:	d971                	beqz	a0,85c <malloc+0x92>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 88a:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 88c:	4798                	lw	a4,8(a5)
 88e:	fa9776e3          	bgeu	a4,s1,83a <malloc+0x70>
    if (p == freep)
 892:	00093703          	ld	a4,0(s2)
 896:	853e                	mv	a0,a5
 898:	fef719e3          	bne	a4,a5,88a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 89c:	8552                	mv	a0,s4
 89e:	00000097          	auipc	ra,0x0
 8a2:	b7e080e7          	jalr	-1154(ra) # 41c <sbrk>
  if (p == (char *)-1) return 0;
 8a6:	fd5518e3          	bne	a0,s5,876 <malloc+0xac>
      if ((p = morecore(nunits)) == 0) return 0;
 8aa:	4501                	li	a0,0
 8ac:	bf45                	j	85c <malloc+0x92>
