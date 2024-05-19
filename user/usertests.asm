
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
    close(fds[1]);
  }
}

// what if you pass ridiculous string pointers to system calls?
void copyinstr1(char *s) {
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = {0x80000000LL, 0xffffffffffffffff};

  for (int ai = 0; ai < 2; ai++) {
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE | O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	c7a080e7          	jalr	-902(ra) # 5c8a <open>
    if (fd >= 0) {
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE | O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	c68080e7          	jalr	-920(ra) # 5c8a <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if (fd >= 0) {
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	15250513          	addi	a0,a0,338 # 6190 <malloc+0x110>
      46:	00006097          	auipc	ra,0x6
      4a:	f7c080e7          	jalr	-132(ra) # 5fc2 <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00006097          	auipc	ra,0x6
      54:	bfa080e7          	jalr	-1030(ra) # 5c4a <exit>

0000000000000058 <bsstest>:
// does uninitialized data start out zero?
char uninit[10000];
void bsstest(char *s) {
  int i;

  for (i = 0; i < sizeof(uninit); i++) {
      58:	0000a797          	auipc	a5,0xa
      5c:	51078793          	addi	a5,a5,1296 # a568 <uninit>
      60:	0000d697          	auipc	a3,0xd
      64:	c1868693          	addi	a3,a3,-1000 # cc78 <buf>
    if (uninit[i] != '\0') {
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for (i = 0; i < sizeof(uninit); i++) {
      6e:	0785                	addi	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
void bsstest(char *s) {
      76:	1141                	addi	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	13050513          	addi	a0,a0,304 # 61b0 <malloc+0x130>
      88:	00006097          	auipc	ra,0x6
      8c:	f3a080e7          	jalr	-198(ra) # 5fc2 <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00006097          	auipc	ra,0x6
      96:	bb8080e7          	jalr	-1096(ra) # 5c4a <exit>

000000000000009a <opentest>:
void opentest(char *s) {
      9a:	1101                	addi	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	addi	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	12050513          	addi	a0,a0,288 # 61c8 <malloc+0x148>
      b0:	00006097          	auipc	ra,0x6
      b4:	bda080e7          	jalr	-1062(ra) # 5c8a <open>
  if (fd < 0) {
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00006097          	auipc	ra,0x6
      c0:	bb6080e7          	jalr	-1098(ra) # 5c72 <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	12250513          	addi	a0,a0,290 # 61e8 <malloc+0x168>
      ce:	00006097          	auipc	ra,0x6
      d2:	bbc080e7          	jalr	-1092(ra) # 5c8a <open>
  if (fd >= 0) {
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	addi	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	0ea50513          	addi	a0,a0,234 # 61d0 <malloc+0x150>
      ee:	00006097          	auipc	ra,0x6
      f2:	ed4080e7          	jalr	-300(ra) # 5fc2 <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00006097          	auipc	ra,0x6
      fc:	b52080e7          	jalr	-1198(ra) # 5c4a <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	0f650513          	addi	a0,a0,246 # 61f8 <malloc+0x178>
     10a:	00006097          	auipc	ra,0x6
     10e:	eb8080e7          	jalr	-328(ra) # 5fc2 <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00006097          	auipc	ra,0x6
     118:	b36080e7          	jalr	-1226(ra) # 5c4a <exit>

000000000000011c <truncate2>:
void truncate2(char *s) {
     11c:	7179                	addi	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	addi	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	0f450513          	addi	a0,a0,244 # 6220 <malloc+0x1a0>
     134:	00006097          	auipc	ra,0x6
     138:	b66080e7          	jalr	-1178(ra) # 5c9a <unlink>
  int fd1 = open("truncfile", O_CREATE | O_TRUNC | O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	0e050513          	addi	a0,a0,224 # 6220 <malloc+0x1a0>
     148:	00006097          	auipc	ra,0x6
     14c:	b42080e7          	jalr	-1214(ra) # 5c8a <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	0dc58593          	addi	a1,a1,220 # 6230 <malloc+0x1b0>
     15c:	00006097          	auipc	ra,0x6
     160:	b0e080e7          	jalr	-1266(ra) # 5c6a <write>
  int fd2 = open("truncfile", O_TRUNC | O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	0b850513          	addi	a0,a0,184 # 6220 <malloc+0x1a0>
     170:	00006097          	auipc	ra,0x6
     174:	b1a080e7          	jalr	-1254(ra) # 5c8a <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	0bc58593          	addi	a1,a1,188 # 6238 <malloc+0x1b8>
     184:	8526                	mv	a0,s1
     186:	00006097          	auipc	ra,0x6
     18a:	ae4080e7          	jalr	-1308(ra) # 5c6a <write>
  if (n != -1) {
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	08c50513          	addi	a0,a0,140 # 6220 <malloc+0x1a0>
     19c:	00006097          	auipc	ra,0x6
     1a0:	afe080e7          	jalr	-1282(ra) # 5c9a <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00006097          	auipc	ra,0x6
     1aa:	acc080e7          	jalr	-1332(ra) # 5c72 <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00006097          	auipc	ra,0x6
     1b4:	ac2080e7          	jalr	-1342(ra) # 5c72 <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	07650513          	addi	a0,a0,118 # 6240 <malloc+0x1c0>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	df0080e7          	jalr	-528(ra) # 5fc2 <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00006097          	auipc	ra,0x6
     1e0:	a6e080e7          	jalr	-1426(ra) # 5c4a <exit>

00000000000001e4 <createtest>:
void createtest(char *s) {
     1e4:	7179                	addi	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for (i = 0; i < N; i++) {
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE | O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	addi	a0,s0,-40
     210:	00006097          	auipc	ra,0x6
     214:	a7a080e7          	jalr	-1414(ra) # 5c8a <open>
    close(fd);
     218:	00006097          	auipc	ra,0x6
     21c:	a5a080e7          	jalr	-1446(ra) # 5c72 <close>
  for (i = 0; i < N; i++) {
     220:	2485                	addiw	s1,s1,1
     222:	0ff4f493          	andi	s1,s1,255
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for (i = 0; i < N; i++) {
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	addi	a0,s0,-40
     246:	00006097          	auipc	ra,0x6
     24a:	a54080e7          	jalr	-1452(ra) # 5c9a <unlink>
  for (i = 0; i < N; i++) {
     24e:	2485                	addiw	s1,s1,1
     250:	0ff4f493          	andi	s1,s1,255
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
void bigwrite(char *s) {
     264:	715d                	addi	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	addi	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	fec50513          	addi	a0,a0,-20 # 6268 <malloc+0x1e8>
     284:	00006097          	auipc	ra,0x6
     288:	a16080e7          	jalr	-1514(ra) # 5c9a <unlink>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	fd8a8a93          	addi	s5,s5,-40 # 6268 <malloc+0x1e8>
      int cc = write(fd, buf, sz);
     298:	0000da17          	auipc	s4,0xd
     29c:	9e0a0a13          	addi	s4,s4,-1568 # cc78 <buf>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <fourteen+0x19d>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00006097          	auipc	ra,0x6
     2b0:	9de080e7          	jalr	-1570(ra) # 5c8a <open>
     2b4:	892a                	mv	s2,a0
    if (fd < 0) {
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00006097          	auipc	ra,0x6
     2c2:	9ac080e7          	jalr	-1620(ra) # 5c6a <write>
     2c6:	89aa                	mv	s3,a0
      if (cc != sz) {
     2c8:	06a49463          	bne	s1,a0,330 <bigwrite+0xcc>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00006097          	auipc	ra,0x6
     2d6:	998080e7          	jalr	-1640(ra) # 5c6a <write>
      if (cc != sz) {
     2da:	04951963          	bne	a0,s1,32c <bigwrite+0xc8>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00006097          	auipc	ra,0x6
     2e4:	992080e7          	jalr	-1646(ra) # 5c72 <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00006097          	auipc	ra,0x6
     2ee:	9b0080e7          	jalr	-1616(ra) # 5c9a <unlink>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     2f2:	1d74849b          	addiw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	addi	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	f6650513          	addi	a0,a0,-154 # 6278 <malloc+0x1f8>
     31a:	00006097          	auipc	ra,0x6
     31e:	ca8080e7          	jalr	-856(ra) # 5fc2 <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00006097          	auipc	ra,0x6
     328:	926080e7          	jalr	-1754(ra) # 5c4a <exit>
     32c:	84ce                	mv	s1,s3
      int cc = write(fd, buf, sz);
     32e:	89aa                	mv	s3,a0
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     330:	86ce                	mv	a3,s3
     332:	8626                	mv	a2,s1
     334:	85de                	mv	a1,s7
     336:	00006517          	auipc	a0,0x6
     33a:	f6250513          	addi	a0,a0,-158 # 6298 <malloc+0x218>
     33e:	00006097          	auipc	ra,0x6
     342:	c84080e7          	jalr	-892(ra) # 5fc2 <printf>
        exit(1);
     346:	4505                	li	a0,1
     348:	00006097          	auipc	ra,0x6
     34c:	902080e7          	jalr	-1790(ra) # 5c4a <exit>

0000000000000350 <badwrite>:
// regression test. does write() with an invalid buffer pointer cause
// a block to be allocated for a file that is then not freed when the
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void badwrite(char *s) {
     350:	7179                	addi	sp,sp,-48
     352:	f406                	sd	ra,40(sp)
     354:	f022                	sd	s0,32(sp)
     356:	ec26                	sd	s1,24(sp)
     358:	e84a                	sd	s2,16(sp)
     35a:	e44e                	sd	s3,8(sp)
     35c:	e052                	sd	s4,0(sp)
     35e:	1800                	addi	s0,sp,48
  int assumed_free = 600;

  unlink("junk");
     360:	00006517          	auipc	a0,0x6
     364:	f5050513          	addi	a0,a0,-176 # 62b0 <malloc+0x230>
     368:	00006097          	auipc	ra,0x6
     36c:	932080e7          	jalr	-1742(ra) # 5c9a <unlink>
     370:	25800913          	li	s2,600
  for (int i = 0; i < assumed_free; i++) {
    int fd = open("junk", O_CREATE | O_WRONLY);
     374:	00006997          	auipc	s3,0x6
     378:	f3c98993          	addi	s3,s3,-196 # 62b0 <malloc+0x230>
    if (fd < 0) {
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char *)0xffffffffffL, 1);
     37c:	5a7d                	li	s4,-1
     37e:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE | O_WRONLY);
     382:	20100593          	li	a1,513
     386:	854e                	mv	a0,s3
     388:	00006097          	auipc	ra,0x6
     38c:	902080e7          	jalr	-1790(ra) # 5c8a <open>
     390:	84aa                	mv	s1,a0
    if (fd < 0) {
     392:	06054b63          	bltz	a0,408 <badwrite+0xb8>
    write(fd, (char *)0xffffffffffL, 1);
     396:	4605                	li	a2,1
     398:	85d2                	mv	a1,s4
     39a:	00006097          	auipc	ra,0x6
     39e:	8d0080e7          	jalr	-1840(ra) # 5c6a <write>
    close(fd);
     3a2:	8526                	mv	a0,s1
     3a4:	00006097          	auipc	ra,0x6
     3a8:	8ce080e7          	jalr	-1842(ra) # 5c72 <close>
    unlink("junk");
     3ac:	854e                	mv	a0,s3
     3ae:	00006097          	auipc	ra,0x6
     3b2:	8ec080e7          	jalr	-1812(ra) # 5c9a <unlink>
  for (int i = 0; i < assumed_free; i++) {
     3b6:	397d                	addiw	s2,s2,-1
     3b8:	fc0915e3          	bnez	s2,382 <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE | O_WRONLY);
     3bc:	20100593          	li	a1,513
     3c0:	00006517          	auipc	a0,0x6
     3c4:	ef050513          	addi	a0,a0,-272 # 62b0 <malloc+0x230>
     3c8:	00006097          	auipc	ra,0x6
     3cc:	8c2080e7          	jalr	-1854(ra) # 5c8a <open>
     3d0:	84aa                	mv	s1,a0
  if (fd < 0) {
     3d2:	04054863          	bltz	a0,422 <badwrite+0xd2>
    printf("open junk failed\n");
    exit(1);
  }
  if (write(fd, "x", 1) != 1) {
     3d6:	4605                	li	a2,1
     3d8:	00006597          	auipc	a1,0x6
     3dc:	e6058593          	addi	a1,a1,-416 # 6238 <malloc+0x1b8>
     3e0:	00006097          	auipc	ra,0x6
     3e4:	88a080e7          	jalr	-1910(ra) # 5c6a <write>
     3e8:	4785                	li	a5,1
     3ea:	04f50963          	beq	a0,a5,43c <badwrite+0xec>
    printf("write failed\n");
     3ee:	00006517          	auipc	a0,0x6
     3f2:	ee250513          	addi	a0,a0,-286 # 62d0 <malloc+0x250>
     3f6:	00006097          	auipc	ra,0x6
     3fa:	bcc080e7          	jalr	-1076(ra) # 5fc2 <printf>
    exit(1);
     3fe:	4505                	li	a0,1
     400:	00006097          	auipc	ra,0x6
     404:	84a080e7          	jalr	-1974(ra) # 5c4a <exit>
      printf("open junk failed\n");
     408:	00006517          	auipc	a0,0x6
     40c:	eb050513          	addi	a0,a0,-336 # 62b8 <malloc+0x238>
     410:	00006097          	auipc	ra,0x6
     414:	bb2080e7          	jalr	-1102(ra) # 5fc2 <printf>
      exit(1);
     418:	4505                	li	a0,1
     41a:	00006097          	auipc	ra,0x6
     41e:	830080e7          	jalr	-2000(ra) # 5c4a <exit>
    printf("open junk failed\n");
     422:	00006517          	auipc	a0,0x6
     426:	e9650513          	addi	a0,a0,-362 # 62b8 <malloc+0x238>
     42a:	00006097          	auipc	ra,0x6
     42e:	b98080e7          	jalr	-1128(ra) # 5fc2 <printf>
    exit(1);
     432:	4505                	li	a0,1
     434:	00006097          	auipc	ra,0x6
     438:	816080e7          	jalr	-2026(ra) # 5c4a <exit>
  }
  close(fd);
     43c:	8526                	mv	a0,s1
     43e:	00006097          	auipc	ra,0x6
     442:	834080e7          	jalr	-1996(ra) # 5c72 <close>
  unlink("junk");
     446:	00006517          	auipc	a0,0x6
     44a:	e6a50513          	addi	a0,a0,-406 # 62b0 <malloc+0x230>
     44e:	00006097          	auipc	ra,0x6
     452:	84c080e7          	jalr	-1972(ra) # 5c9a <unlink>

  exit(0);
     456:	4501                	li	a0,0
     458:	00005097          	auipc	ra,0x5
     45c:	7f2080e7          	jalr	2034(ra) # 5c4a <exit>

0000000000000460 <outofinodes>:
    name[4] = '\0';
    unlink(name);
  }
}

void outofinodes(char *s) {
     460:	715d                	addi	sp,sp,-80
     462:	e486                	sd	ra,72(sp)
     464:	e0a2                	sd	s0,64(sp)
     466:	fc26                	sd	s1,56(sp)
     468:	f84a                	sd	s2,48(sp)
     46a:	f44e                	sd	s3,40(sp)
     46c:	0880                	addi	s0,sp,80
  int nzz = 32 * 32;
  for (int i = 0; i < nzz; i++) {
     46e:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     470:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
     474:	40000993          	li	s3,1024
    name[0] = 'z';
     478:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     47c:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     480:	41f4d79b          	sraiw	a5,s1,0x1f
     484:	01b7d71b          	srliw	a4,a5,0x1b
     488:	009707bb          	addw	a5,a4,s1
     48c:	4057d69b          	sraiw	a3,a5,0x5
     490:	0306869b          	addiw	a3,a3,48
     494:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     498:	8bfd                	andi	a5,a5,31
     49a:	9f99                	subw	a5,a5,a4
     49c:	0307879b          	addiw	a5,a5,48
     4a0:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     4a4:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     4a8:	fb040513          	addi	a0,s0,-80
     4ac:	00005097          	auipc	ra,0x5
     4b0:	7ee080e7          	jalr	2030(ra) # 5c9a <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
     4b4:	60200593          	li	a1,1538
     4b8:	fb040513          	addi	a0,s0,-80
     4bc:	00005097          	auipc	ra,0x5
     4c0:	7ce080e7          	jalr	1998(ra) # 5c8a <open>
    if (fd < 0) {
     4c4:	00054963          	bltz	a0,4d6 <outofinodes+0x76>
      // failure is eventually expected.
      break;
    }
    close(fd);
     4c8:	00005097          	auipc	ra,0x5
     4cc:	7aa080e7          	jalr	1962(ra) # 5c72 <close>
  for (int i = 0; i < nzz; i++) {
     4d0:	2485                	addiw	s1,s1,1
     4d2:	fb3493e3          	bne	s1,s3,478 <outofinodes+0x18>
     4d6:	4481                	li	s1,0
  }

  for (int i = 0; i < nzz; i++) {
    char name[32];
    name[0] = 'z';
     4d8:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
     4dc:	40000993          	li	s3,1024
    name[0] = 'z';
     4e0:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     4e4:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     4e8:	41f4d79b          	sraiw	a5,s1,0x1f
     4ec:	01b7d71b          	srliw	a4,a5,0x1b
     4f0:	009707bb          	addw	a5,a4,s1
     4f4:	4057d69b          	sraiw	a3,a5,0x5
     4f8:	0306869b          	addiw	a3,a3,48
     4fc:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     500:	8bfd                	andi	a5,a5,31
     502:	9f99                	subw	a5,a5,a4
     504:	0307879b          	addiw	a5,a5,48
     508:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     50c:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     510:	fb040513          	addi	a0,s0,-80
     514:	00005097          	auipc	ra,0x5
     518:	786080e7          	jalr	1926(ra) # 5c9a <unlink>
  for (int i = 0; i < nzz; i++) {
     51c:	2485                	addiw	s1,s1,1
     51e:	fd3491e3          	bne	s1,s3,4e0 <outofinodes+0x80>
  }
}
     522:	60a6                	ld	ra,72(sp)
     524:	6406                	ld	s0,64(sp)
     526:	74e2                	ld	s1,56(sp)
     528:	7942                	ld	s2,48(sp)
     52a:	79a2                	ld	s3,40(sp)
     52c:	6161                	addi	sp,sp,80
     52e:	8082                	ret

0000000000000530 <copyin>:
void copyin(char *s) {
     530:	715d                	addi	sp,sp,-80
     532:	e486                	sd	ra,72(sp)
     534:	e0a2                	sd	s0,64(sp)
     536:	fc26                	sd	s1,56(sp)
     538:	f84a                	sd	s2,48(sp)
     53a:	f44e                	sd	s3,40(sp)
     53c:	f052                	sd	s4,32(sp)
     53e:	0880                	addi	s0,sp,80
  uint64 addrs[] = {0x80000000LL, 0xffffffffffffffff};
     540:	4785                	li	a5,1
     542:	07fe                	slli	a5,a5,0x1f
     544:	fcf43023          	sd	a5,-64(s0)
     548:	57fd                	li	a5,-1
     54a:	fcf43423          	sd	a5,-56(s0)
  for (int ai = 0; ai < 2; ai++) {
     54e:	fc040913          	addi	s2,s0,-64
    int fd = open("copyin1", O_CREATE | O_WRONLY);
     552:	00006a17          	auipc	s4,0x6
     556:	d8ea0a13          	addi	s4,s4,-626 # 62e0 <malloc+0x260>
    uint64 addr = addrs[ai];
     55a:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE | O_WRONLY);
     55e:	20100593          	li	a1,513
     562:	8552                	mv	a0,s4
     564:	00005097          	auipc	ra,0x5
     568:	726080e7          	jalr	1830(ra) # 5c8a <open>
     56c:	84aa                	mv	s1,a0
    if (fd < 0) {
     56e:	08054863          	bltz	a0,5fe <copyin+0xce>
    int n = write(fd, (void *)addr, 8192);
     572:	6609                	lui	a2,0x2
     574:	85ce                	mv	a1,s3
     576:	00005097          	auipc	ra,0x5
     57a:	6f4080e7          	jalr	1780(ra) # 5c6a <write>
    if (n >= 0) {
     57e:	08055d63          	bgez	a0,618 <copyin+0xe8>
    close(fd);
     582:	8526                	mv	a0,s1
     584:	00005097          	auipc	ra,0x5
     588:	6ee080e7          	jalr	1774(ra) # 5c72 <close>
    unlink("copyin1");
     58c:	8552                	mv	a0,s4
     58e:	00005097          	auipc	ra,0x5
     592:	70c080e7          	jalr	1804(ra) # 5c9a <unlink>
    n = write(1, (char *)addr, 8192);
     596:	6609                	lui	a2,0x2
     598:	85ce                	mv	a1,s3
     59a:	4505                	li	a0,1
     59c:	00005097          	auipc	ra,0x5
     5a0:	6ce080e7          	jalr	1742(ra) # 5c6a <write>
    if (n > 0) {
     5a4:	08a04963          	bgtz	a0,636 <copyin+0x106>
    if (pipe(fds) < 0) {
     5a8:	fb840513          	addi	a0,s0,-72
     5ac:	00005097          	auipc	ra,0x5
     5b0:	6ae080e7          	jalr	1710(ra) # 5c5a <pipe>
     5b4:	0a054063          	bltz	a0,654 <copyin+0x124>
    n = write(fds[1], (char *)addr, 8192);
     5b8:	6609                	lui	a2,0x2
     5ba:	85ce                	mv	a1,s3
     5bc:	fbc42503          	lw	a0,-68(s0)
     5c0:	00005097          	auipc	ra,0x5
     5c4:	6aa080e7          	jalr	1706(ra) # 5c6a <write>
    if (n > 0) {
     5c8:	0aa04363          	bgtz	a0,66e <copyin+0x13e>
    close(fds[0]);
     5cc:	fb842503          	lw	a0,-72(s0)
     5d0:	00005097          	auipc	ra,0x5
     5d4:	6a2080e7          	jalr	1698(ra) # 5c72 <close>
    close(fds[1]);
     5d8:	fbc42503          	lw	a0,-68(s0)
     5dc:	00005097          	auipc	ra,0x5
     5e0:	696080e7          	jalr	1686(ra) # 5c72 <close>
  for (int ai = 0; ai < 2; ai++) {
     5e4:	0921                	addi	s2,s2,8
     5e6:	fd040793          	addi	a5,s0,-48
     5ea:	f6f918e3          	bne	s2,a5,55a <copyin+0x2a>
}
     5ee:	60a6                	ld	ra,72(sp)
     5f0:	6406                	ld	s0,64(sp)
     5f2:	74e2                	ld	s1,56(sp)
     5f4:	7942                	ld	s2,48(sp)
     5f6:	79a2                	ld	s3,40(sp)
     5f8:	7a02                	ld	s4,32(sp)
     5fa:	6161                	addi	sp,sp,80
     5fc:	8082                	ret
      printf("open(copyin1) failed\n");
     5fe:	00006517          	auipc	a0,0x6
     602:	cea50513          	addi	a0,a0,-790 # 62e8 <malloc+0x268>
     606:	00006097          	auipc	ra,0x6
     60a:	9bc080e7          	jalr	-1604(ra) # 5fc2 <printf>
      exit(1);
     60e:	4505                	li	a0,1
     610:	00005097          	auipc	ra,0x5
     614:	63a080e7          	jalr	1594(ra) # 5c4a <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     618:	862a                	mv	a2,a0
     61a:	85ce                	mv	a1,s3
     61c:	00006517          	auipc	a0,0x6
     620:	ce450513          	addi	a0,a0,-796 # 6300 <malloc+0x280>
     624:	00006097          	auipc	ra,0x6
     628:	99e080e7          	jalr	-1634(ra) # 5fc2 <printf>
      exit(1);
     62c:	4505                	li	a0,1
     62e:	00005097          	auipc	ra,0x5
     632:	61c080e7          	jalr	1564(ra) # 5c4a <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     636:	862a                	mv	a2,a0
     638:	85ce                	mv	a1,s3
     63a:	00006517          	auipc	a0,0x6
     63e:	cf650513          	addi	a0,a0,-778 # 6330 <malloc+0x2b0>
     642:	00006097          	auipc	ra,0x6
     646:	980080e7          	jalr	-1664(ra) # 5fc2 <printf>
      exit(1);
     64a:	4505                	li	a0,1
     64c:	00005097          	auipc	ra,0x5
     650:	5fe080e7          	jalr	1534(ra) # 5c4a <exit>
      printf("pipe() failed\n");
     654:	00006517          	auipc	a0,0x6
     658:	d0c50513          	addi	a0,a0,-756 # 6360 <malloc+0x2e0>
     65c:	00006097          	auipc	ra,0x6
     660:	966080e7          	jalr	-1690(ra) # 5fc2 <printf>
      exit(1);
     664:	4505                	li	a0,1
     666:	00005097          	auipc	ra,0x5
     66a:	5e4080e7          	jalr	1508(ra) # 5c4a <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     66e:	862a                	mv	a2,a0
     670:	85ce                	mv	a1,s3
     672:	00006517          	auipc	a0,0x6
     676:	cfe50513          	addi	a0,a0,-770 # 6370 <malloc+0x2f0>
     67a:	00006097          	auipc	ra,0x6
     67e:	948080e7          	jalr	-1720(ra) # 5fc2 <printf>
      exit(1);
     682:	4505                	li	a0,1
     684:	00005097          	auipc	ra,0x5
     688:	5c6080e7          	jalr	1478(ra) # 5c4a <exit>

000000000000068c <copyout>:
void copyout(char *s) {
     68c:	711d                	addi	sp,sp,-96
     68e:	ec86                	sd	ra,88(sp)
     690:	e8a2                	sd	s0,80(sp)
     692:	e4a6                	sd	s1,72(sp)
     694:	e0ca                	sd	s2,64(sp)
     696:	fc4e                	sd	s3,56(sp)
     698:	f852                	sd	s4,48(sp)
     69a:	f456                	sd	s5,40(sp)
     69c:	f05a                	sd	s6,32(sp)
     69e:	1080                	addi	s0,sp,96
  uint64 addrs[] = {0LL, 0x80000000LL, 0xffffffffffffffff};
     6a0:	fa043423          	sd	zero,-88(s0)
     6a4:	4785                	li	a5,1
     6a6:	07fe                	slli	a5,a5,0x1f
     6a8:	faf43823          	sd	a5,-80(s0)
     6ac:	57fd                	li	a5,-1
     6ae:	faf43c23          	sd	a5,-72(s0)
  for (int ai = 0; ai < 2; ai++) {
     6b2:	fa840913          	addi	s2,s0,-88
     6b6:	fb840b13          	addi	s6,s0,-72
    int fd = open("xv6-readme", 0);
     6ba:	00006a17          	auipc	s4,0x6
     6be:	ce6a0a13          	addi	s4,s4,-794 # 63a0 <malloc+0x320>
    n = write(fds[1], "x", 1);
     6c2:	00006a97          	auipc	s5,0x6
     6c6:	b76a8a93          	addi	s5,s5,-1162 # 6238 <malloc+0x1b8>
    uint64 addr = addrs[ai];
     6ca:	00093983          	ld	s3,0(s2)
    int fd = open("xv6-readme", 0);
     6ce:	4581                	li	a1,0
     6d0:	8552                	mv	a0,s4
     6d2:	00005097          	auipc	ra,0x5
     6d6:	5b8080e7          	jalr	1464(ra) # 5c8a <open>
     6da:	84aa                	mv	s1,a0
    if (fd < 0) {
     6dc:	08054563          	bltz	a0,766 <copyout+0xda>
    int n = read(fd, (void *)addr, 8192);
     6e0:	6609                	lui	a2,0x2
     6e2:	85ce                	mv	a1,s3
     6e4:	00005097          	auipc	ra,0x5
     6e8:	57e080e7          	jalr	1406(ra) # 5c62 <read>
    if (n > 0) {
     6ec:	08a04a63          	bgtz	a0,780 <copyout+0xf4>
    close(fd);
     6f0:	8526                	mv	a0,s1
     6f2:	00005097          	auipc	ra,0x5
     6f6:	580080e7          	jalr	1408(ra) # 5c72 <close>
    if (pipe(fds) < 0) {
     6fa:	fa040513          	addi	a0,s0,-96
     6fe:	00005097          	auipc	ra,0x5
     702:	55c080e7          	jalr	1372(ra) # 5c5a <pipe>
     706:	08054c63          	bltz	a0,79e <copyout+0x112>
    n = write(fds[1], "x", 1);
     70a:	4605                	li	a2,1
     70c:	85d6                	mv	a1,s5
     70e:	fa442503          	lw	a0,-92(s0)
     712:	00005097          	auipc	ra,0x5
     716:	558080e7          	jalr	1368(ra) # 5c6a <write>
    if (n != 1) {
     71a:	4785                	li	a5,1
     71c:	08f51e63          	bne	a0,a5,7b8 <copyout+0x12c>
    n = read(fds[0], (void *)addr, 8192);
     720:	6609                	lui	a2,0x2
     722:	85ce                	mv	a1,s3
     724:	fa042503          	lw	a0,-96(s0)
     728:	00005097          	auipc	ra,0x5
     72c:	53a080e7          	jalr	1338(ra) # 5c62 <read>
    if (n > 0) {
     730:	0aa04163          	bgtz	a0,7d2 <copyout+0x146>
    close(fds[0]);
     734:	fa042503          	lw	a0,-96(s0)
     738:	00005097          	auipc	ra,0x5
     73c:	53a080e7          	jalr	1338(ra) # 5c72 <close>
    close(fds[1]);
     740:	fa442503          	lw	a0,-92(s0)
     744:	00005097          	auipc	ra,0x5
     748:	52e080e7          	jalr	1326(ra) # 5c72 <close>
  for (int ai = 0; ai < 2; ai++) {
     74c:	0921                	addi	s2,s2,8
     74e:	f7691ee3          	bne	s2,s6,6ca <copyout+0x3e>
}
     752:	60e6                	ld	ra,88(sp)
     754:	6446                	ld	s0,80(sp)
     756:	64a6                	ld	s1,72(sp)
     758:	6906                	ld	s2,64(sp)
     75a:	79e2                	ld	s3,56(sp)
     75c:	7a42                	ld	s4,48(sp)
     75e:	7aa2                	ld	s5,40(sp)
     760:	7b02                	ld	s6,32(sp)
     762:	6125                	addi	sp,sp,96
     764:	8082                	ret
      printf("open(xv6-readme) failed\n");
     766:	00006517          	auipc	a0,0x6
     76a:	c4a50513          	addi	a0,a0,-950 # 63b0 <malloc+0x330>
     76e:	00006097          	auipc	ra,0x6
     772:	854080e7          	jalr	-1964(ra) # 5fc2 <printf>
      exit(1);
     776:	4505                	li	a0,1
     778:	00005097          	auipc	ra,0x5
     77c:	4d2080e7          	jalr	1234(ra) # 5c4a <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     780:	862a                	mv	a2,a0
     782:	85ce                	mv	a1,s3
     784:	00006517          	auipc	a0,0x6
     788:	c4c50513          	addi	a0,a0,-948 # 63d0 <malloc+0x350>
     78c:	00006097          	auipc	ra,0x6
     790:	836080e7          	jalr	-1994(ra) # 5fc2 <printf>
      exit(1);
     794:	4505                	li	a0,1
     796:	00005097          	auipc	ra,0x5
     79a:	4b4080e7          	jalr	1204(ra) # 5c4a <exit>
      printf("pipe() failed\n");
     79e:	00006517          	auipc	a0,0x6
     7a2:	bc250513          	addi	a0,a0,-1086 # 6360 <malloc+0x2e0>
     7a6:	00006097          	auipc	ra,0x6
     7aa:	81c080e7          	jalr	-2020(ra) # 5fc2 <printf>
      exit(1);
     7ae:	4505                	li	a0,1
     7b0:	00005097          	auipc	ra,0x5
     7b4:	49a080e7          	jalr	1178(ra) # 5c4a <exit>
      printf("pipe write failed\n");
     7b8:	00006517          	auipc	a0,0x6
     7bc:	c4850513          	addi	a0,a0,-952 # 6400 <malloc+0x380>
     7c0:	00006097          	auipc	ra,0x6
     7c4:	802080e7          	jalr	-2046(ra) # 5fc2 <printf>
      exit(1);
     7c8:	4505                	li	a0,1
     7ca:	00005097          	auipc	ra,0x5
     7ce:	480080e7          	jalr	1152(ra) # 5c4a <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     7d2:	862a                	mv	a2,a0
     7d4:	85ce                	mv	a1,s3
     7d6:	00006517          	auipc	a0,0x6
     7da:	c4250513          	addi	a0,a0,-958 # 6418 <malloc+0x398>
     7de:	00005097          	auipc	ra,0x5
     7e2:	7e4080e7          	jalr	2020(ra) # 5fc2 <printf>
      exit(1);
     7e6:	4505                	li	a0,1
     7e8:	00005097          	auipc	ra,0x5
     7ec:	462080e7          	jalr	1122(ra) # 5c4a <exit>

00000000000007f0 <truncate1>:
void truncate1(char *s) {
     7f0:	711d                	addi	sp,sp,-96
     7f2:	ec86                	sd	ra,88(sp)
     7f4:	e8a2                	sd	s0,80(sp)
     7f6:	e4a6                	sd	s1,72(sp)
     7f8:	e0ca                	sd	s2,64(sp)
     7fa:	fc4e                	sd	s3,56(sp)
     7fc:	f852                	sd	s4,48(sp)
     7fe:	f456                	sd	s5,40(sp)
     800:	1080                	addi	s0,sp,96
     802:	8aaa                	mv	s5,a0
  unlink("truncfile");
     804:	00006517          	auipc	a0,0x6
     808:	a1c50513          	addi	a0,a0,-1508 # 6220 <malloc+0x1a0>
     80c:	00005097          	auipc	ra,0x5
     810:	48e080e7          	jalr	1166(ra) # 5c9a <unlink>
  int fd1 = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
     814:	60100593          	li	a1,1537
     818:	00006517          	auipc	a0,0x6
     81c:	a0850513          	addi	a0,a0,-1528 # 6220 <malloc+0x1a0>
     820:	00005097          	auipc	ra,0x5
     824:	46a080e7          	jalr	1130(ra) # 5c8a <open>
     828:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     82a:	4611                	li	a2,4
     82c:	00006597          	auipc	a1,0x6
     830:	a0458593          	addi	a1,a1,-1532 # 6230 <malloc+0x1b0>
     834:	00005097          	auipc	ra,0x5
     838:	436080e7          	jalr	1078(ra) # 5c6a <write>
  close(fd1);
     83c:	8526                	mv	a0,s1
     83e:	00005097          	auipc	ra,0x5
     842:	434080e7          	jalr	1076(ra) # 5c72 <close>
  int fd2 = open("truncfile", O_RDONLY);
     846:	4581                	li	a1,0
     848:	00006517          	auipc	a0,0x6
     84c:	9d850513          	addi	a0,a0,-1576 # 6220 <malloc+0x1a0>
     850:	00005097          	auipc	ra,0x5
     854:	43a080e7          	jalr	1082(ra) # 5c8a <open>
     858:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     85a:	02000613          	li	a2,32
     85e:	fa040593          	addi	a1,s0,-96
     862:	00005097          	auipc	ra,0x5
     866:	400080e7          	jalr	1024(ra) # 5c62 <read>
  if (n != 4) {
     86a:	4791                	li	a5,4
     86c:	0cf51e63          	bne	a0,a5,948 <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY | O_TRUNC);
     870:	40100593          	li	a1,1025
     874:	00006517          	auipc	a0,0x6
     878:	9ac50513          	addi	a0,a0,-1620 # 6220 <malloc+0x1a0>
     87c:	00005097          	auipc	ra,0x5
     880:	40e080e7          	jalr	1038(ra) # 5c8a <open>
     884:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     886:	4581                	li	a1,0
     888:	00006517          	auipc	a0,0x6
     88c:	99850513          	addi	a0,a0,-1640 # 6220 <malloc+0x1a0>
     890:	00005097          	auipc	ra,0x5
     894:	3fa080e7          	jalr	1018(ra) # 5c8a <open>
     898:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     89a:	02000613          	li	a2,32
     89e:	fa040593          	addi	a1,s0,-96
     8a2:	00005097          	auipc	ra,0x5
     8a6:	3c0080e7          	jalr	960(ra) # 5c62 <read>
     8aa:	8a2a                	mv	s4,a0
  if (n != 0) {
     8ac:	ed4d                	bnez	a0,966 <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     8ae:	02000613          	li	a2,32
     8b2:	fa040593          	addi	a1,s0,-96
     8b6:	8526                	mv	a0,s1
     8b8:	00005097          	auipc	ra,0x5
     8bc:	3aa080e7          	jalr	938(ra) # 5c62 <read>
     8c0:	8a2a                	mv	s4,a0
  if (n != 0) {
     8c2:	e971                	bnez	a0,996 <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     8c4:	4619                	li	a2,6
     8c6:	00006597          	auipc	a1,0x6
     8ca:	be258593          	addi	a1,a1,-1054 # 64a8 <malloc+0x428>
     8ce:	854e                	mv	a0,s3
     8d0:	00005097          	auipc	ra,0x5
     8d4:	39a080e7          	jalr	922(ra) # 5c6a <write>
  n = read(fd3, buf, sizeof(buf));
     8d8:	02000613          	li	a2,32
     8dc:	fa040593          	addi	a1,s0,-96
     8e0:	854a                	mv	a0,s2
     8e2:	00005097          	auipc	ra,0x5
     8e6:	380080e7          	jalr	896(ra) # 5c62 <read>
  if (n != 6) {
     8ea:	4799                	li	a5,6
     8ec:	0cf51d63          	bne	a0,a5,9c6 <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     8f0:	02000613          	li	a2,32
     8f4:	fa040593          	addi	a1,s0,-96
     8f8:	8526                	mv	a0,s1
     8fa:	00005097          	auipc	ra,0x5
     8fe:	368080e7          	jalr	872(ra) # 5c62 <read>
  if (n != 2) {
     902:	4789                	li	a5,2
     904:	0ef51063          	bne	a0,a5,9e4 <truncate1+0x1f4>
  unlink("truncfile");
     908:	00006517          	auipc	a0,0x6
     90c:	91850513          	addi	a0,a0,-1768 # 6220 <malloc+0x1a0>
     910:	00005097          	auipc	ra,0x5
     914:	38a080e7          	jalr	906(ra) # 5c9a <unlink>
  close(fd1);
     918:	854e                	mv	a0,s3
     91a:	00005097          	auipc	ra,0x5
     91e:	358080e7          	jalr	856(ra) # 5c72 <close>
  close(fd2);
     922:	8526                	mv	a0,s1
     924:	00005097          	auipc	ra,0x5
     928:	34e080e7          	jalr	846(ra) # 5c72 <close>
  close(fd3);
     92c:	854a                	mv	a0,s2
     92e:	00005097          	auipc	ra,0x5
     932:	344080e7          	jalr	836(ra) # 5c72 <close>
}
     936:	60e6                	ld	ra,88(sp)
     938:	6446                	ld	s0,80(sp)
     93a:	64a6                	ld	s1,72(sp)
     93c:	6906                	ld	s2,64(sp)
     93e:	79e2                	ld	s3,56(sp)
     940:	7a42                	ld	s4,48(sp)
     942:	7aa2                	ld	s5,40(sp)
     944:	6125                	addi	sp,sp,96
     946:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     948:	862a                	mv	a2,a0
     94a:	85d6                	mv	a1,s5
     94c:	00006517          	auipc	a0,0x6
     950:	afc50513          	addi	a0,a0,-1284 # 6448 <malloc+0x3c8>
     954:	00005097          	auipc	ra,0x5
     958:	66e080e7          	jalr	1646(ra) # 5fc2 <printf>
    exit(1);
     95c:	4505                	li	a0,1
     95e:	00005097          	auipc	ra,0x5
     962:	2ec080e7          	jalr	748(ra) # 5c4a <exit>
    printf("aaa fd3=%d\n", fd3);
     966:	85ca                	mv	a1,s2
     968:	00006517          	auipc	a0,0x6
     96c:	b0050513          	addi	a0,a0,-1280 # 6468 <malloc+0x3e8>
     970:	00005097          	auipc	ra,0x5
     974:	652080e7          	jalr	1618(ra) # 5fc2 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     978:	8652                	mv	a2,s4
     97a:	85d6                	mv	a1,s5
     97c:	00006517          	auipc	a0,0x6
     980:	afc50513          	addi	a0,a0,-1284 # 6478 <malloc+0x3f8>
     984:	00005097          	auipc	ra,0x5
     988:	63e080e7          	jalr	1598(ra) # 5fc2 <printf>
    exit(1);
     98c:	4505                	li	a0,1
     98e:	00005097          	auipc	ra,0x5
     992:	2bc080e7          	jalr	700(ra) # 5c4a <exit>
    printf("bbb fd2=%d\n", fd2);
     996:	85a6                	mv	a1,s1
     998:	00006517          	auipc	a0,0x6
     99c:	b0050513          	addi	a0,a0,-1280 # 6498 <malloc+0x418>
     9a0:	00005097          	auipc	ra,0x5
     9a4:	622080e7          	jalr	1570(ra) # 5fc2 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     9a8:	8652                	mv	a2,s4
     9aa:	85d6                	mv	a1,s5
     9ac:	00006517          	auipc	a0,0x6
     9b0:	acc50513          	addi	a0,a0,-1332 # 6478 <malloc+0x3f8>
     9b4:	00005097          	auipc	ra,0x5
     9b8:	60e080e7          	jalr	1550(ra) # 5fc2 <printf>
    exit(1);
     9bc:	4505                	li	a0,1
     9be:	00005097          	auipc	ra,0x5
     9c2:	28c080e7          	jalr	652(ra) # 5c4a <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     9c6:	862a                	mv	a2,a0
     9c8:	85d6                	mv	a1,s5
     9ca:	00006517          	auipc	a0,0x6
     9ce:	ae650513          	addi	a0,a0,-1306 # 64b0 <malloc+0x430>
     9d2:	00005097          	auipc	ra,0x5
     9d6:	5f0080e7          	jalr	1520(ra) # 5fc2 <printf>
    exit(1);
     9da:	4505                	li	a0,1
     9dc:	00005097          	auipc	ra,0x5
     9e0:	26e080e7          	jalr	622(ra) # 5c4a <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     9e4:	862a                	mv	a2,a0
     9e6:	85d6                	mv	a1,s5
     9e8:	00006517          	auipc	a0,0x6
     9ec:	ae850513          	addi	a0,a0,-1304 # 64d0 <malloc+0x450>
     9f0:	00005097          	auipc	ra,0x5
     9f4:	5d2080e7          	jalr	1490(ra) # 5fc2 <printf>
    exit(1);
     9f8:	4505                	li	a0,1
     9fa:	00005097          	auipc	ra,0x5
     9fe:	250080e7          	jalr	592(ra) # 5c4a <exit>

0000000000000a02 <writetest>:
void writetest(char *s) {
     a02:	7139                	addi	sp,sp,-64
     a04:	fc06                	sd	ra,56(sp)
     a06:	f822                	sd	s0,48(sp)
     a08:	f426                	sd	s1,40(sp)
     a0a:	f04a                	sd	s2,32(sp)
     a0c:	ec4e                	sd	s3,24(sp)
     a0e:	e852                	sd	s4,16(sp)
     a10:	e456                	sd	s5,8(sp)
     a12:	e05a                	sd	s6,0(sp)
     a14:	0080                	addi	s0,sp,64
     a16:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE | O_RDWR);
     a18:	20200593          	li	a1,514
     a1c:	00006517          	auipc	a0,0x6
     a20:	ad450513          	addi	a0,a0,-1324 # 64f0 <malloc+0x470>
     a24:	00005097          	auipc	ra,0x5
     a28:	266080e7          	jalr	614(ra) # 5c8a <open>
  if (fd < 0) {
     a2c:	0a054d63          	bltz	a0,ae6 <writetest+0xe4>
     a30:	892a                	mv	s2,a0
     a32:	4481                	li	s1,0
    if (write(fd, "aaaaaaaaaa", SZ) != SZ) {
     a34:	00006997          	auipc	s3,0x6
     a38:	ae498993          	addi	s3,s3,-1308 # 6518 <malloc+0x498>
    if (write(fd, "bbbbbbbbbb", SZ) != SZ) {
     a3c:	00006a97          	auipc	s5,0x6
     a40:	b14a8a93          	addi	s5,s5,-1260 # 6550 <malloc+0x4d0>
  for (i = 0; i < N; i++) {
     a44:	06400a13          	li	s4,100
    if (write(fd, "aaaaaaaaaa", SZ) != SZ) {
     a48:	4629                	li	a2,10
     a4a:	85ce                	mv	a1,s3
     a4c:	854a                	mv	a0,s2
     a4e:	00005097          	auipc	ra,0x5
     a52:	21c080e7          	jalr	540(ra) # 5c6a <write>
     a56:	47a9                	li	a5,10
     a58:	0af51563          	bne	a0,a5,b02 <writetest+0x100>
    if (write(fd, "bbbbbbbbbb", SZ) != SZ) {
     a5c:	4629                	li	a2,10
     a5e:	85d6                	mv	a1,s5
     a60:	854a                	mv	a0,s2
     a62:	00005097          	auipc	ra,0x5
     a66:	208080e7          	jalr	520(ra) # 5c6a <write>
     a6a:	47a9                	li	a5,10
     a6c:	0af51a63          	bne	a0,a5,b20 <writetest+0x11e>
  for (i = 0; i < N; i++) {
     a70:	2485                	addiw	s1,s1,1
     a72:	fd449be3          	bne	s1,s4,a48 <writetest+0x46>
  close(fd);
     a76:	854a                	mv	a0,s2
     a78:	00005097          	auipc	ra,0x5
     a7c:	1fa080e7          	jalr	506(ra) # 5c72 <close>
  fd = open("small", O_RDONLY);
     a80:	4581                	li	a1,0
     a82:	00006517          	auipc	a0,0x6
     a86:	a6e50513          	addi	a0,a0,-1426 # 64f0 <malloc+0x470>
     a8a:	00005097          	auipc	ra,0x5
     a8e:	200080e7          	jalr	512(ra) # 5c8a <open>
     a92:	84aa                	mv	s1,a0
  if (fd < 0) {
     a94:	0a054563          	bltz	a0,b3e <writetest+0x13c>
  i = read(fd, buf, N * SZ * 2);
     a98:	7d000613          	li	a2,2000
     a9c:	0000c597          	auipc	a1,0xc
     aa0:	1dc58593          	addi	a1,a1,476 # cc78 <buf>
     aa4:	00005097          	auipc	ra,0x5
     aa8:	1be080e7          	jalr	446(ra) # 5c62 <read>
  if (i != N * SZ * 2) {
     aac:	7d000793          	li	a5,2000
     ab0:	0af51563          	bne	a0,a5,b5a <writetest+0x158>
  close(fd);
     ab4:	8526                	mv	a0,s1
     ab6:	00005097          	auipc	ra,0x5
     aba:	1bc080e7          	jalr	444(ra) # 5c72 <close>
  if (unlink("small") < 0) {
     abe:	00006517          	auipc	a0,0x6
     ac2:	a3250513          	addi	a0,a0,-1486 # 64f0 <malloc+0x470>
     ac6:	00005097          	auipc	ra,0x5
     aca:	1d4080e7          	jalr	468(ra) # 5c9a <unlink>
     ace:	0a054463          	bltz	a0,b76 <writetest+0x174>
}
     ad2:	70e2                	ld	ra,56(sp)
     ad4:	7442                	ld	s0,48(sp)
     ad6:	74a2                	ld	s1,40(sp)
     ad8:	7902                	ld	s2,32(sp)
     ada:	69e2                	ld	s3,24(sp)
     adc:	6a42                	ld	s4,16(sp)
     ade:	6aa2                	ld	s5,8(sp)
     ae0:	6b02                	ld	s6,0(sp)
     ae2:	6121                	addi	sp,sp,64
     ae4:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     ae6:	85da                	mv	a1,s6
     ae8:	00006517          	auipc	a0,0x6
     aec:	a1050513          	addi	a0,a0,-1520 # 64f8 <malloc+0x478>
     af0:	00005097          	auipc	ra,0x5
     af4:	4d2080e7          	jalr	1234(ra) # 5fc2 <printf>
    exit(1);
     af8:	4505                	li	a0,1
     afa:	00005097          	auipc	ra,0x5
     afe:	150080e7          	jalr	336(ra) # 5c4a <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     b02:	8626                	mv	a2,s1
     b04:	85da                	mv	a1,s6
     b06:	00006517          	auipc	a0,0x6
     b0a:	a2250513          	addi	a0,a0,-1502 # 6528 <malloc+0x4a8>
     b0e:	00005097          	auipc	ra,0x5
     b12:	4b4080e7          	jalr	1204(ra) # 5fc2 <printf>
      exit(1);
     b16:	4505                	li	a0,1
     b18:	00005097          	auipc	ra,0x5
     b1c:	132080e7          	jalr	306(ra) # 5c4a <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     b20:	8626                	mv	a2,s1
     b22:	85da                	mv	a1,s6
     b24:	00006517          	auipc	a0,0x6
     b28:	a3c50513          	addi	a0,a0,-1476 # 6560 <malloc+0x4e0>
     b2c:	00005097          	auipc	ra,0x5
     b30:	496080e7          	jalr	1174(ra) # 5fc2 <printf>
      exit(1);
     b34:	4505                	li	a0,1
     b36:	00005097          	auipc	ra,0x5
     b3a:	114080e7          	jalr	276(ra) # 5c4a <exit>
    printf("%s: error: open small failed!\n", s);
     b3e:	85da                	mv	a1,s6
     b40:	00006517          	auipc	a0,0x6
     b44:	a4850513          	addi	a0,a0,-1464 # 6588 <malloc+0x508>
     b48:	00005097          	auipc	ra,0x5
     b4c:	47a080e7          	jalr	1146(ra) # 5fc2 <printf>
    exit(1);
     b50:	4505                	li	a0,1
     b52:	00005097          	auipc	ra,0x5
     b56:	0f8080e7          	jalr	248(ra) # 5c4a <exit>
    printf("%s: read failed\n", s);
     b5a:	85da                	mv	a1,s6
     b5c:	00006517          	auipc	a0,0x6
     b60:	a4c50513          	addi	a0,a0,-1460 # 65a8 <malloc+0x528>
     b64:	00005097          	auipc	ra,0x5
     b68:	45e080e7          	jalr	1118(ra) # 5fc2 <printf>
    exit(1);
     b6c:	4505                	li	a0,1
     b6e:	00005097          	auipc	ra,0x5
     b72:	0dc080e7          	jalr	220(ra) # 5c4a <exit>
    printf("%s: unlink small failed\n", s);
     b76:	85da                	mv	a1,s6
     b78:	00006517          	auipc	a0,0x6
     b7c:	a4850513          	addi	a0,a0,-1464 # 65c0 <malloc+0x540>
     b80:	00005097          	auipc	ra,0x5
     b84:	442080e7          	jalr	1090(ra) # 5fc2 <printf>
    exit(1);
     b88:	4505                	li	a0,1
     b8a:	00005097          	auipc	ra,0x5
     b8e:	0c0080e7          	jalr	192(ra) # 5c4a <exit>

0000000000000b92 <writebig>:
void writebig(char *s) {
     b92:	7139                	addi	sp,sp,-64
     b94:	fc06                	sd	ra,56(sp)
     b96:	f822                	sd	s0,48(sp)
     b98:	f426                	sd	s1,40(sp)
     b9a:	f04a                	sd	s2,32(sp)
     b9c:	ec4e                	sd	s3,24(sp)
     b9e:	e852                	sd	s4,16(sp)
     ba0:	e456                	sd	s5,8(sp)
     ba2:	0080                	addi	s0,sp,64
     ba4:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE | O_RDWR);
     ba6:	20200593          	li	a1,514
     baa:	00006517          	auipc	a0,0x6
     bae:	a3650513          	addi	a0,a0,-1482 # 65e0 <malloc+0x560>
     bb2:	00005097          	auipc	ra,0x5
     bb6:	0d8080e7          	jalr	216(ra) # 5c8a <open>
     bba:	89aa                	mv	s3,a0
  for (i = 0; i < MAXFILE; i++) {
     bbc:	4481                	li	s1,0
    ((int *)buf)[0] = i;
     bbe:	0000c917          	auipc	s2,0xc
     bc2:	0ba90913          	addi	s2,s2,186 # cc78 <buf>
  for (i = 0; i < MAXFILE; i++) {
     bc6:	10c00a13          	li	s4,268
  if (fd < 0) {
     bca:	06054c63          	bltz	a0,c42 <writebig+0xb0>
    ((int *)buf)[0] = i;
     bce:	00992023          	sw	s1,0(s2)
    if (write(fd, buf, BSIZE) != BSIZE) {
     bd2:	40000613          	li	a2,1024
     bd6:	85ca                	mv	a1,s2
     bd8:	854e                	mv	a0,s3
     bda:	00005097          	auipc	ra,0x5
     bde:	090080e7          	jalr	144(ra) # 5c6a <write>
     be2:	40000793          	li	a5,1024
     be6:	06f51c63          	bne	a0,a5,c5e <writebig+0xcc>
  for (i = 0; i < MAXFILE; i++) {
     bea:	2485                	addiw	s1,s1,1
     bec:	ff4491e3          	bne	s1,s4,bce <writebig+0x3c>
  close(fd);
     bf0:	854e                	mv	a0,s3
     bf2:	00005097          	auipc	ra,0x5
     bf6:	080080e7          	jalr	128(ra) # 5c72 <close>
  fd = open("big", O_RDONLY);
     bfa:	4581                	li	a1,0
     bfc:	00006517          	auipc	a0,0x6
     c00:	9e450513          	addi	a0,a0,-1564 # 65e0 <malloc+0x560>
     c04:	00005097          	auipc	ra,0x5
     c08:	086080e7          	jalr	134(ra) # 5c8a <open>
     c0c:	89aa                	mv	s3,a0
  n = 0;
     c0e:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     c10:	0000c917          	auipc	s2,0xc
     c14:	06890913          	addi	s2,s2,104 # cc78 <buf>
  if (fd < 0) {
     c18:	06054263          	bltz	a0,c7c <writebig+0xea>
    i = read(fd, buf, BSIZE);
     c1c:	40000613          	li	a2,1024
     c20:	85ca                	mv	a1,s2
     c22:	854e                	mv	a0,s3
     c24:	00005097          	auipc	ra,0x5
     c28:	03e080e7          	jalr	62(ra) # 5c62 <read>
    if (i == 0) {
     c2c:	c535                	beqz	a0,c98 <writebig+0x106>
    } else if (i != BSIZE) {
     c2e:	40000793          	li	a5,1024
     c32:	0af51f63          	bne	a0,a5,cf0 <writebig+0x15e>
    if (((int *)buf)[0] != n) {
     c36:	00092683          	lw	a3,0(s2)
     c3a:	0c969a63          	bne	a3,s1,d0e <writebig+0x17c>
    n++;
     c3e:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     c40:	bff1                	j	c1c <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     c42:	85d6                	mv	a1,s5
     c44:	00006517          	auipc	a0,0x6
     c48:	9a450513          	addi	a0,a0,-1628 # 65e8 <malloc+0x568>
     c4c:	00005097          	auipc	ra,0x5
     c50:	376080e7          	jalr	886(ra) # 5fc2 <printf>
    exit(1);
     c54:	4505                	li	a0,1
     c56:	00005097          	auipc	ra,0x5
     c5a:	ff4080e7          	jalr	-12(ra) # 5c4a <exit>
      printf("%s: error: write big file failed\n", s, i);
     c5e:	8626                	mv	a2,s1
     c60:	85d6                	mv	a1,s5
     c62:	00006517          	auipc	a0,0x6
     c66:	9a650513          	addi	a0,a0,-1626 # 6608 <malloc+0x588>
     c6a:	00005097          	auipc	ra,0x5
     c6e:	358080e7          	jalr	856(ra) # 5fc2 <printf>
      exit(1);
     c72:	4505                	li	a0,1
     c74:	00005097          	auipc	ra,0x5
     c78:	fd6080e7          	jalr	-42(ra) # 5c4a <exit>
    printf("%s: error: open big failed!\n", s);
     c7c:	85d6                	mv	a1,s5
     c7e:	00006517          	auipc	a0,0x6
     c82:	9b250513          	addi	a0,a0,-1614 # 6630 <malloc+0x5b0>
     c86:	00005097          	auipc	ra,0x5
     c8a:	33c080e7          	jalr	828(ra) # 5fc2 <printf>
    exit(1);
     c8e:	4505                	li	a0,1
     c90:	00005097          	auipc	ra,0x5
     c94:	fba080e7          	jalr	-70(ra) # 5c4a <exit>
      if (n == MAXFILE - 1) {
     c98:	10b00793          	li	a5,267
     c9c:	02f48a63          	beq	s1,a5,cd0 <writebig+0x13e>
  close(fd);
     ca0:	854e                	mv	a0,s3
     ca2:	00005097          	auipc	ra,0x5
     ca6:	fd0080e7          	jalr	-48(ra) # 5c72 <close>
  if (unlink("big") < 0) {
     caa:	00006517          	auipc	a0,0x6
     cae:	93650513          	addi	a0,a0,-1738 # 65e0 <malloc+0x560>
     cb2:	00005097          	auipc	ra,0x5
     cb6:	fe8080e7          	jalr	-24(ra) # 5c9a <unlink>
     cba:	06054963          	bltz	a0,d2c <writebig+0x19a>
}
     cbe:	70e2                	ld	ra,56(sp)
     cc0:	7442                	ld	s0,48(sp)
     cc2:	74a2                	ld	s1,40(sp)
     cc4:	7902                	ld	s2,32(sp)
     cc6:	69e2                	ld	s3,24(sp)
     cc8:	6a42                	ld	s4,16(sp)
     cca:	6aa2                	ld	s5,8(sp)
     ccc:	6121                	addi	sp,sp,64
     cce:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     cd0:	10b00613          	li	a2,267
     cd4:	85d6                	mv	a1,s5
     cd6:	00006517          	auipc	a0,0x6
     cda:	97a50513          	addi	a0,a0,-1670 # 6650 <malloc+0x5d0>
     cde:	00005097          	auipc	ra,0x5
     ce2:	2e4080e7          	jalr	740(ra) # 5fc2 <printf>
        exit(1);
     ce6:	4505                	li	a0,1
     ce8:	00005097          	auipc	ra,0x5
     cec:	f62080e7          	jalr	-158(ra) # 5c4a <exit>
      printf("%s: read failed %d\n", s, i);
     cf0:	862a                	mv	a2,a0
     cf2:	85d6                	mv	a1,s5
     cf4:	00006517          	auipc	a0,0x6
     cf8:	98450513          	addi	a0,a0,-1660 # 6678 <malloc+0x5f8>
     cfc:	00005097          	auipc	ra,0x5
     d00:	2c6080e7          	jalr	710(ra) # 5fc2 <printf>
      exit(1);
     d04:	4505                	li	a0,1
     d06:	00005097          	auipc	ra,0x5
     d0a:	f44080e7          	jalr	-188(ra) # 5c4a <exit>
      printf("%s: read content of block %d is %d\n", s, n, ((int *)buf)[0]);
     d0e:	8626                	mv	a2,s1
     d10:	85d6                	mv	a1,s5
     d12:	00006517          	auipc	a0,0x6
     d16:	97e50513          	addi	a0,a0,-1666 # 6690 <malloc+0x610>
     d1a:	00005097          	auipc	ra,0x5
     d1e:	2a8080e7          	jalr	680(ra) # 5fc2 <printf>
      exit(1);
     d22:	4505                	li	a0,1
     d24:	00005097          	auipc	ra,0x5
     d28:	f26080e7          	jalr	-218(ra) # 5c4a <exit>
    printf("%s: unlink big failed\n", s);
     d2c:	85d6                	mv	a1,s5
     d2e:	00006517          	auipc	a0,0x6
     d32:	98a50513          	addi	a0,a0,-1654 # 66b8 <malloc+0x638>
     d36:	00005097          	auipc	ra,0x5
     d3a:	28c080e7          	jalr	652(ra) # 5fc2 <printf>
    exit(1);
     d3e:	4505                	li	a0,1
     d40:	00005097          	auipc	ra,0x5
     d44:	f0a080e7          	jalr	-246(ra) # 5c4a <exit>

0000000000000d48 <unlinkread>:
void unlinkread(char *s) {
     d48:	7179                	addi	sp,sp,-48
     d4a:	f406                	sd	ra,40(sp)
     d4c:	f022                	sd	s0,32(sp)
     d4e:	ec26                	sd	s1,24(sp)
     d50:	e84a                	sd	s2,16(sp)
     d52:	e44e                	sd	s3,8(sp)
     d54:	1800                	addi	s0,sp,48
     d56:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     d58:	20200593          	li	a1,514
     d5c:	00006517          	auipc	a0,0x6
     d60:	97450513          	addi	a0,a0,-1676 # 66d0 <malloc+0x650>
     d64:	00005097          	auipc	ra,0x5
     d68:	f26080e7          	jalr	-218(ra) # 5c8a <open>
  if (fd < 0) {
     d6c:	0e054563          	bltz	a0,e56 <unlinkread+0x10e>
     d70:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     d72:	4615                	li	a2,5
     d74:	00006597          	auipc	a1,0x6
     d78:	98c58593          	addi	a1,a1,-1652 # 6700 <malloc+0x680>
     d7c:	00005097          	auipc	ra,0x5
     d80:	eee080e7          	jalr	-274(ra) # 5c6a <write>
  close(fd);
     d84:	8526                	mv	a0,s1
     d86:	00005097          	auipc	ra,0x5
     d8a:	eec080e7          	jalr	-276(ra) # 5c72 <close>
  fd = open("unlinkread", O_RDWR);
     d8e:	4589                	li	a1,2
     d90:	00006517          	auipc	a0,0x6
     d94:	94050513          	addi	a0,a0,-1728 # 66d0 <malloc+0x650>
     d98:	00005097          	auipc	ra,0x5
     d9c:	ef2080e7          	jalr	-270(ra) # 5c8a <open>
     da0:	84aa                	mv	s1,a0
  if (fd < 0) {
     da2:	0c054863          	bltz	a0,e72 <unlinkread+0x12a>
  if (unlink("unlinkread") != 0) {
     da6:	00006517          	auipc	a0,0x6
     daa:	92a50513          	addi	a0,a0,-1750 # 66d0 <malloc+0x650>
     dae:	00005097          	auipc	ra,0x5
     db2:	eec080e7          	jalr	-276(ra) # 5c9a <unlink>
     db6:	ed61                	bnez	a0,e8e <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     db8:	20200593          	li	a1,514
     dbc:	00006517          	auipc	a0,0x6
     dc0:	91450513          	addi	a0,a0,-1772 # 66d0 <malloc+0x650>
     dc4:	00005097          	auipc	ra,0x5
     dc8:	ec6080e7          	jalr	-314(ra) # 5c8a <open>
     dcc:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     dce:	460d                	li	a2,3
     dd0:	00006597          	auipc	a1,0x6
     dd4:	97858593          	addi	a1,a1,-1672 # 6748 <malloc+0x6c8>
     dd8:	00005097          	auipc	ra,0x5
     ddc:	e92080e7          	jalr	-366(ra) # 5c6a <write>
  close(fd1);
     de0:	854a                	mv	a0,s2
     de2:	00005097          	auipc	ra,0x5
     de6:	e90080e7          	jalr	-368(ra) # 5c72 <close>
  if (read(fd, buf, sizeof(buf)) != SZ) {
     dea:	660d                	lui	a2,0x3
     dec:	0000c597          	auipc	a1,0xc
     df0:	e8c58593          	addi	a1,a1,-372 # cc78 <buf>
     df4:	8526                	mv	a0,s1
     df6:	00005097          	auipc	ra,0x5
     dfa:	e6c080e7          	jalr	-404(ra) # 5c62 <read>
     dfe:	4795                	li	a5,5
     e00:	0af51563          	bne	a0,a5,eaa <unlinkread+0x162>
  if (buf[0] != 'h') {
     e04:	0000c717          	auipc	a4,0xc
     e08:	e7474703          	lbu	a4,-396(a4) # cc78 <buf>
     e0c:	06800793          	li	a5,104
     e10:	0af71b63          	bne	a4,a5,ec6 <unlinkread+0x17e>
  if (write(fd, buf, 10) != 10) {
     e14:	4629                	li	a2,10
     e16:	0000c597          	auipc	a1,0xc
     e1a:	e6258593          	addi	a1,a1,-414 # cc78 <buf>
     e1e:	8526                	mv	a0,s1
     e20:	00005097          	auipc	ra,0x5
     e24:	e4a080e7          	jalr	-438(ra) # 5c6a <write>
     e28:	47a9                	li	a5,10
     e2a:	0af51c63          	bne	a0,a5,ee2 <unlinkread+0x19a>
  close(fd);
     e2e:	8526                	mv	a0,s1
     e30:	00005097          	auipc	ra,0x5
     e34:	e42080e7          	jalr	-446(ra) # 5c72 <close>
  unlink("unlinkread");
     e38:	00006517          	auipc	a0,0x6
     e3c:	89850513          	addi	a0,a0,-1896 # 66d0 <malloc+0x650>
     e40:	00005097          	auipc	ra,0x5
     e44:	e5a080e7          	jalr	-422(ra) # 5c9a <unlink>
}
     e48:	70a2                	ld	ra,40(sp)
     e4a:	7402                	ld	s0,32(sp)
     e4c:	64e2                	ld	s1,24(sp)
     e4e:	6942                	ld	s2,16(sp)
     e50:	69a2                	ld	s3,8(sp)
     e52:	6145                	addi	sp,sp,48
     e54:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     e56:	85ce                	mv	a1,s3
     e58:	00006517          	auipc	a0,0x6
     e5c:	88850513          	addi	a0,a0,-1912 # 66e0 <malloc+0x660>
     e60:	00005097          	auipc	ra,0x5
     e64:	162080e7          	jalr	354(ra) # 5fc2 <printf>
    exit(1);
     e68:	4505                	li	a0,1
     e6a:	00005097          	auipc	ra,0x5
     e6e:	de0080e7          	jalr	-544(ra) # 5c4a <exit>
    printf("%s: open unlinkread failed\n", s);
     e72:	85ce                	mv	a1,s3
     e74:	00006517          	auipc	a0,0x6
     e78:	89450513          	addi	a0,a0,-1900 # 6708 <malloc+0x688>
     e7c:	00005097          	auipc	ra,0x5
     e80:	146080e7          	jalr	326(ra) # 5fc2 <printf>
    exit(1);
     e84:	4505                	li	a0,1
     e86:	00005097          	auipc	ra,0x5
     e8a:	dc4080e7          	jalr	-572(ra) # 5c4a <exit>
    printf("%s: unlink unlinkread failed\n", s);
     e8e:	85ce                	mv	a1,s3
     e90:	00006517          	auipc	a0,0x6
     e94:	89850513          	addi	a0,a0,-1896 # 6728 <malloc+0x6a8>
     e98:	00005097          	auipc	ra,0x5
     e9c:	12a080e7          	jalr	298(ra) # 5fc2 <printf>
    exit(1);
     ea0:	4505                	li	a0,1
     ea2:	00005097          	auipc	ra,0x5
     ea6:	da8080e7          	jalr	-600(ra) # 5c4a <exit>
    printf("%s: unlinkread read failed", s);
     eaa:	85ce                	mv	a1,s3
     eac:	00006517          	auipc	a0,0x6
     eb0:	8a450513          	addi	a0,a0,-1884 # 6750 <malloc+0x6d0>
     eb4:	00005097          	auipc	ra,0x5
     eb8:	10e080e7          	jalr	270(ra) # 5fc2 <printf>
    exit(1);
     ebc:	4505                	li	a0,1
     ebe:	00005097          	auipc	ra,0x5
     ec2:	d8c080e7          	jalr	-628(ra) # 5c4a <exit>
    printf("%s: unlinkread wrong data\n", s);
     ec6:	85ce                	mv	a1,s3
     ec8:	00006517          	auipc	a0,0x6
     ecc:	8a850513          	addi	a0,a0,-1880 # 6770 <malloc+0x6f0>
     ed0:	00005097          	auipc	ra,0x5
     ed4:	0f2080e7          	jalr	242(ra) # 5fc2 <printf>
    exit(1);
     ed8:	4505                	li	a0,1
     eda:	00005097          	auipc	ra,0x5
     ede:	d70080e7          	jalr	-656(ra) # 5c4a <exit>
    printf("%s: unlinkread write failed\n", s);
     ee2:	85ce                	mv	a1,s3
     ee4:	00006517          	auipc	a0,0x6
     ee8:	8ac50513          	addi	a0,a0,-1876 # 6790 <malloc+0x710>
     eec:	00005097          	auipc	ra,0x5
     ef0:	0d6080e7          	jalr	214(ra) # 5fc2 <printf>
    exit(1);
     ef4:	4505                	li	a0,1
     ef6:	00005097          	auipc	ra,0x5
     efa:	d54080e7          	jalr	-684(ra) # 5c4a <exit>

0000000000000efe <linktest>:
void linktest(char *s) {
     efe:	1101                	addi	sp,sp,-32
     f00:	ec06                	sd	ra,24(sp)
     f02:	e822                	sd	s0,16(sp)
     f04:	e426                	sd	s1,8(sp)
     f06:	e04a                	sd	s2,0(sp)
     f08:	1000                	addi	s0,sp,32
     f0a:	892a                	mv	s2,a0
  unlink("lf1");
     f0c:	00006517          	auipc	a0,0x6
     f10:	8a450513          	addi	a0,a0,-1884 # 67b0 <malloc+0x730>
     f14:	00005097          	auipc	ra,0x5
     f18:	d86080e7          	jalr	-634(ra) # 5c9a <unlink>
  unlink("lf2");
     f1c:	00006517          	auipc	a0,0x6
     f20:	89c50513          	addi	a0,a0,-1892 # 67b8 <malloc+0x738>
     f24:	00005097          	auipc	ra,0x5
     f28:	d76080e7          	jalr	-650(ra) # 5c9a <unlink>
  fd = open("lf1", O_CREATE | O_RDWR);
     f2c:	20200593          	li	a1,514
     f30:	00006517          	auipc	a0,0x6
     f34:	88050513          	addi	a0,a0,-1920 # 67b0 <malloc+0x730>
     f38:	00005097          	auipc	ra,0x5
     f3c:	d52080e7          	jalr	-686(ra) # 5c8a <open>
  if (fd < 0) {
     f40:	10054763          	bltz	a0,104e <linktest+0x150>
     f44:	84aa                	mv	s1,a0
  if (write(fd, "hello", SZ) != SZ) {
     f46:	4615                	li	a2,5
     f48:	00005597          	auipc	a1,0x5
     f4c:	7b858593          	addi	a1,a1,1976 # 6700 <malloc+0x680>
     f50:	00005097          	auipc	ra,0x5
     f54:	d1a080e7          	jalr	-742(ra) # 5c6a <write>
     f58:	4795                	li	a5,5
     f5a:	10f51863          	bne	a0,a5,106a <linktest+0x16c>
  close(fd);
     f5e:	8526                	mv	a0,s1
     f60:	00005097          	auipc	ra,0x5
     f64:	d12080e7          	jalr	-750(ra) # 5c72 <close>
  if (link("lf1", "lf2") < 0) {
     f68:	00006597          	auipc	a1,0x6
     f6c:	85058593          	addi	a1,a1,-1968 # 67b8 <malloc+0x738>
     f70:	00006517          	auipc	a0,0x6
     f74:	84050513          	addi	a0,a0,-1984 # 67b0 <malloc+0x730>
     f78:	00005097          	auipc	ra,0x5
     f7c:	d32080e7          	jalr	-718(ra) # 5caa <link>
     f80:	10054363          	bltz	a0,1086 <linktest+0x188>
  unlink("lf1");
     f84:	00006517          	auipc	a0,0x6
     f88:	82c50513          	addi	a0,a0,-2004 # 67b0 <malloc+0x730>
     f8c:	00005097          	auipc	ra,0x5
     f90:	d0e080e7          	jalr	-754(ra) # 5c9a <unlink>
  if (open("lf1", 0) >= 0) {
     f94:	4581                	li	a1,0
     f96:	00006517          	auipc	a0,0x6
     f9a:	81a50513          	addi	a0,a0,-2022 # 67b0 <malloc+0x730>
     f9e:	00005097          	auipc	ra,0x5
     fa2:	cec080e7          	jalr	-788(ra) # 5c8a <open>
     fa6:	0e055e63          	bgez	a0,10a2 <linktest+0x1a4>
  fd = open("lf2", 0);
     faa:	4581                	li	a1,0
     fac:	00006517          	auipc	a0,0x6
     fb0:	80c50513          	addi	a0,a0,-2036 # 67b8 <malloc+0x738>
     fb4:	00005097          	auipc	ra,0x5
     fb8:	cd6080e7          	jalr	-810(ra) # 5c8a <open>
     fbc:	84aa                	mv	s1,a0
  if (fd < 0) {
     fbe:	10054063          	bltz	a0,10be <linktest+0x1c0>
  if (read(fd, buf, sizeof(buf)) != SZ) {
     fc2:	660d                	lui	a2,0x3
     fc4:	0000c597          	auipc	a1,0xc
     fc8:	cb458593          	addi	a1,a1,-844 # cc78 <buf>
     fcc:	00005097          	auipc	ra,0x5
     fd0:	c96080e7          	jalr	-874(ra) # 5c62 <read>
     fd4:	4795                	li	a5,5
     fd6:	10f51263          	bne	a0,a5,10da <linktest+0x1dc>
  close(fd);
     fda:	8526                	mv	a0,s1
     fdc:	00005097          	auipc	ra,0x5
     fe0:	c96080e7          	jalr	-874(ra) # 5c72 <close>
  if (link("lf2", "lf2") >= 0) {
     fe4:	00005597          	auipc	a1,0x5
     fe8:	7d458593          	addi	a1,a1,2004 # 67b8 <malloc+0x738>
     fec:	852e                	mv	a0,a1
     fee:	00005097          	auipc	ra,0x5
     ff2:	cbc080e7          	jalr	-836(ra) # 5caa <link>
     ff6:	10055063          	bgez	a0,10f6 <linktest+0x1f8>
  unlink("lf2");
     ffa:	00005517          	auipc	a0,0x5
     ffe:	7be50513          	addi	a0,a0,1982 # 67b8 <malloc+0x738>
    1002:	00005097          	auipc	ra,0x5
    1006:	c98080e7          	jalr	-872(ra) # 5c9a <unlink>
  if (link("lf2", "lf1") >= 0) {
    100a:	00005597          	auipc	a1,0x5
    100e:	7a658593          	addi	a1,a1,1958 # 67b0 <malloc+0x730>
    1012:	00005517          	auipc	a0,0x5
    1016:	7a650513          	addi	a0,a0,1958 # 67b8 <malloc+0x738>
    101a:	00005097          	auipc	ra,0x5
    101e:	c90080e7          	jalr	-880(ra) # 5caa <link>
    1022:	0e055863          	bgez	a0,1112 <linktest+0x214>
  if (link(".", "lf1") >= 0) {
    1026:	00005597          	auipc	a1,0x5
    102a:	78a58593          	addi	a1,a1,1930 # 67b0 <malloc+0x730>
    102e:	00006517          	auipc	a0,0x6
    1032:	89250513          	addi	a0,a0,-1902 # 68c0 <malloc+0x840>
    1036:	00005097          	auipc	ra,0x5
    103a:	c74080e7          	jalr	-908(ra) # 5caa <link>
    103e:	0e055863          	bgez	a0,112e <linktest+0x230>
}
    1042:	60e2                	ld	ra,24(sp)
    1044:	6442                	ld	s0,16(sp)
    1046:	64a2                	ld	s1,8(sp)
    1048:	6902                	ld	s2,0(sp)
    104a:	6105                	addi	sp,sp,32
    104c:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    104e:	85ca                	mv	a1,s2
    1050:	00005517          	auipc	a0,0x5
    1054:	77050513          	addi	a0,a0,1904 # 67c0 <malloc+0x740>
    1058:	00005097          	auipc	ra,0x5
    105c:	f6a080e7          	jalr	-150(ra) # 5fc2 <printf>
    exit(1);
    1060:	4505                	li	a0,1
    1062:	00005097          	auipc	ra,0x5
    1066:	be8080e7          	jalr	-1048(ra) # 5c4a <exit>
    printf("%s: write lf1 failed\n", s);
    106a:	85ca                	mv	a1,s2
    106c:	00005517          	auipc	a0,0x5
    1070:	76c50513          	addi	a0,a0,1900 # 67d8 <malloc+0x758>
    1074:	00005097          	auipc	ra,0x5
    1078:	f4e080e7          	jalr	-178(ra) # 5fc2 <printf>
    exit(1);
    107c:	4505                	li	a0,1
    107e:	00005097          	auipc	ra,0x5
    1082:	bcc080e7          	jalr	-1076(ra) # 5c4a <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    1086:	85ca                	mv	a1,s2
    1088:	00005517          	auipc	a0,0x5
    108c:	76850513          	addi	a0,a0,1896 # 67f0 <malloc+0x770>
    1090:	00005097          	auipc	ra,0x5
    1094:	f32080e7          	jalr	-206(ra) # 5fc2 <printf>
    exit(1);
    1098:	4505                	li	a0,1
    109a:	00005097          	auipc	ra,0x5
    109e:	bb0080e7          	jalr	-1104(ra) # 5c4a <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    10a2:	85ca                	mv	a1,s2
    10a4:	00005517          	auipc	a0,0x5
    10a8:	76c50513          	addi	a0,a0,1900 # 6810 <malloc+0x790>
    10ac:	00005097          	auipc	ra,0x5
    10b0:	f16080e7          	jalr	-234(ra) # 5fc2 <printf>
    exit(1);
    10b4:	4505                	li	a0,1
    10b6:	00005097          	auipc	ra,0x5
    10ba:	b94080e7          	jalr	-1132(ra) # 5c4a <exit>
    printf("%s: open lf2 failed\n", s);
    10be:	85ca                	mv	a1,s2
    10c0:	00005517          	auipc	a0,0x5
    10c4:	78050513          	addi	a0,a0,1920 # 6840 <malloc+0x7c0>
    10c8:	00005097          	auipc	ra,0x5
    10cc:	efa080e7          	jalr	-262(ra) # 5fc2 <printf>
    exit(1);
    10d0:	4505                	li	a0,1
    10d2:	00005097          	auipc	ra,0x5
    10d6:	b78080e7          	jalr	-1160(ra) # 5c4a <exit>
    printf("%s: read lf2 failed\n", s);
    10da:	85ca                	mv	a1,s2
    10dc:	00005517          	auipc	a0,0x5
    10e0:	77c50513          	addi	a0,a0,1916 # 6858 <malloc+0x7d8>
    10e4:	00005097          	auipc	ra,0x5
    10e8:	ede080e7          	jalr	-290(ra) # 5fc2 <printf>
    exit(1);
    10ec:	4505                	li	a0,1
    10ee:	00005097          	auipc	ra,0x5
    10f2:	b5c080e7          	jalr	-1188(ra) # 5c4a <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    10f6:	85ca                	mv	a1,s2
    10f8:	00005517          	auipc	a0,0x5
    10fc:	77850513          	addi	a0,a0,1912 # 6870 <malloc+0x7f0>
    1100:	00005097          	auipc	ra,0x5
    1104:	ec2080e7          	jalr	-318(ra) # 5fc2 <printf>
    exit(1);
    1108:	4505                	li	a0,1
    110a:	00005097          	auipc	ra,0x5
    110e:	b40080e7          	jalr	-1216(ra) # 5c4a <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    1112:	85ca                	mv	a1,s2
    1114:	00005517          	auipc	a0,0x5
    1118:	78450513          	addi	a0,a0,1924 # 6898 <malloc+0x818>
    111c:	00005097          	auipc	ra,0x5
    1120:	ea6080e7          	jalr	-346(ra) # 5fc2 <printf>
    exit(1);
    1124:	4505                	li	a0,1
    1126:	00005097          	auipc	ra,0x5
    112a:	b24080e7          	jalr	-1244(ra) # 5c4a <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    112e:	85ca                	mv	a1,s2
    1130:	00005517          	auipc	a0,0x5
    1134:	79850513          	addi	a0,a0,1944 # 68c8 <malloc+0x848>
    1138:	00005097          	auipc	ra,0x5
    113c:	e8a080e7          	jalr	-374(ra) # 5fc2 <printf>
    exit(1);
    1140:	4505                	li	a0,1
    1142:	00005097          	auipc	ra,0x5
    1146:	b08080e7          	jalr	-1272(ra) # 5c4a <exit>

000000000000114a <validatetest>:
void validatetest(char *s) {
    114a:	7139                	addi	sp,sp,-64
    114c:	fc06                	sd	ra,56(sp)
    114e:	f822                	sd	s0,48(sp)
    1150:	f426                	sd	s1,40(sp)
    1152:	f04a                	sd	s2,32(sp)
    1154:	ec4e                	sd	s3,24(sp)
    1156:	e852                	sd	s4,16(sp)
    1158:	e456                	sd	s5,8(sp)
    115a:	e05a                	sd	s6,0(sp)
    115c:	0080                	addi	s0,sp,64
    115e:	8b2a                	mv	s6,a0
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
    1160:	4481                	li	s1,0
    if (link("nosuchfile", (char *)p) != -1) {
    1162:	00005997          	auipc	s3,0x5
    1166:	78698993          	addi	s3,s3,1926 # 68e8 <malloc+0x868>
    116a:	597d                	li	s2,-1
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
    116c:	6a85                	lui	s5,0x1
    116e:	00114a37          	lui	s4,0x114
    if (link("nosuchfile", (char *)p) != -1) {
    1172:	85a6                	mv	a1,s1
    1174:	854e                	mv	a0,s3
    1176:	00005097          	auipc	ra,0x5
    117a:	b34080e7          	jalr	-1228(ra) # 5caa <link>
    117e:	01251f63          	bne	a0,s2,119c <validatetest+0x52>
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
    1182:	94d6                	add	s1,s1,s5
    1184:	ff4497e3          	bne	s1,s4,1172 <validatetest+0x28>
}
    1188:	70e2                	ld	ra,56(sp)
    118a:	7442                	ld	s0,48(sp)
    118c:	74a2                	ld	s1,40(sp)
    118e:	7902                	ld	s2,32(sp)
    1190:	69e2                	ld	s3,24(sp)
    1192:	6a42                	ld	s4,16(sp)
    1194:	6aa2                	ld	s5,8(sp)
    1196:	6b02                	ld	s6,0(sp)
    1198:	6121                	addi	sp,sp,64
    119a:	8082                	ret
      printf("%s: link should not succeed\n", s);
    119c:	85da                	mv	a1,s6
    119e:	00005517          	auipc	a0,0x5
    11a2:	75a50513          	addi	a0,a0,1882 # 68f8 <malloc+0x878>
    11a6:	00005097          	auipc	ra,0x5
    11aa:	e1c080e7          	jalr	-484(ra) # 5fc2 <printf>
      exit(1);
    11ae:	4505                	li	a0,1
    11b0:	00005097          	auipc	ra,0x5
    11b4:	a9a080e7          	jalr	-1382(ra) # 5c4a <exit>

00000000000011b8 <bigdir>:
void bigdir(char *s) {
    11b8:	715d                	addi	sp,sp,-80
    11ba:	e486                	sd	ra,72(sp)
    11bc:	e0a2                	sd	s0,64(sp)
    11be:	fc26                	sd	s1,56(sp)
    11c0:	f84a                	sd	s2,48(sp)
    11c2:	f44e                	sd	s3,40(sp)
    11c4:	f052                	sd	s4,32(sp)
    11c6:	ec56                	sd	s5,24(sp)
    11c8:	e85a                	sd	s6,16(sp)
    11ca:	0880                	addi	s0,sp,80
    11cc:	89aa                	mv	s3,a0
  unlink("bd");
    11ce:	00005517          	auipc	a0,0x5
    11d2:	74a50513          	addi	a0,a0,1866 # 6918 <malloc+0x898>
    11d6:	00005097          	auipc	ra,0x5
    11da:	ac4080e7          	jalr	-1340(ra) # 5c9a <unlink>
  fd = open("bd", O_CREATE);
    11de:	20000593          	li	a1,512
    11e2:	00005517          	auipc	a0,0x5
    11e6:	73650513          	addi	a0,a0,1846 # 6918 <malloc+0x898>
    11ea:	00005097          	auipc	ra,0x5
    11ee:	aa0080e7          	jalr	-1376(ra) # 5c8a <open>
  if (fd < 0) {
    11f2:	0c054963          	bltz	a0,12c4 <bigdir+0x10c>
  close(fd);
    11f6:	00005097          	auipc	ra,0x5
    11fa:	a7c080e7          	jalr	-1412(ra) # 5c72 <close>
  for (i = 0; i < N; i++) {
    11fe:	4901                	li	s2,0
    name[0] = 'x';
    1200:	07800a93          	li	s5,120
    if (link("bd", name) != 0) {
    1204:	00005a17          	auipc	s4,0x5
    1208:	714a0a13          	addi	s4,s4,1812 # 6918 <malloc+0x898>
  for (i = 0; i < N; i++) {
    120c:	1f400b13          	li	s6,500
    name[0] = 'x';
    1210:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    1214:	41f9579b          	sraiw	a5,s2,0x1f
    1218:	01a7d71b          	srliw	a4,a5,0x1a
    121c:	012707bb          	addw	a5,a4,s2
    1220:	4067d69b          	sraiw	a3,a5,0x6
    1224:	0306869b          	addiw	a3,a3,48
    1228:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    122c:	03f7f793          	andi	a5,a5,63
    1230:	9f99                	subw	a5,a5,a4
    1232:	0307879b          	addiw	a5,a5,48
    1236:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    123a:	fa0409a3          	sb	zero,-77(s0)
    if (link("bd", name) != 0) {
    123e:	fb040593          	addi	a1,s0,-80
    1242:	8552                	mv	a0,s4
    1244:	00005097          	auipc	ra,0x5
    1248:	a66080e7          	jalr	-1434(ra) # 5caa <link>
    124c:	84aa                	mv	s1,a0
    124e:	e949                	bnez	a0,12e0 <bigdir+0x128>
  for (i = 0; i < N; i++) {
    1250:	2905                	addiw	s2,s2,1
    1252:	fb691fe3          	bne	s2,s6,1210 <bigdir+0x58>
  unlink("bd");
    1256:	00005517          	auipc	a0,0x5
    125a:	6c250513          	addi	a0,a0,1730 # 6918 <malloc+0x898>
    125e:	00005097          	auipc	ra,0x5
    1262:	a3c080e7          	jalr	-1476(ra) # 5c9a <unlink>
    name[0] = 'x';
    1266:	07800913          	li	s2,120
  for (i = 0; i < N; i++) {
    126a:	1f400a13          	li	s4,500
    name[0] = 'x';
    126e:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    1272:	41f4d79b          	sraiw	a5,s1,0x1f
    1276:	01a7d71b          	srliw	a4,a5,0x1a
    127a:	009707bb          	addw	a5,a4,s1
    127e:	4067d69b          	sraiw	a3,a5,0x6
    1282:	0306869b          	addiw	a3,a3,48
    1286:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    128a:	03f7f793          	andi	a5,a5,63
    128e:	9f99                	subw	a5,a5,a4
    1290:	0307879b          	addiw	a5,a5,48
    1294:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1298:	fa0409a3          	sb	zero,-77(s0)
    if (unlink(name) != 0) {
    129c:	fb040513          	addi	a0,s0,-80
    12a0:	00005097          	auipc	ra,0x5
    12a4:	9fa080e7          	jalr	-1542(ra) # 5c9a <unlink>
    12a8:	ed21                	bnez	a0,1300 <bigdir+0x148>
  for (i = 0; i < N; i++) {
    12aa:	2485                	addiw	s1,s1,1
    12ac:	fd4491e3          	bne	s1,s4,126e <bigdir+0xb6>
}
    12b0:	60a6                	ld	ra,72(sp)
    12b2:	6406                	ld	s0,64(sp)
    12b4:	74e2                	ld	s1,56(sp)
    12b6:	7942                	ld	s2,48(sp)
    12b8:	79a2                	ld	s3,40(sp)
    12ba:	7a02                	ld	s4,32(sp)
    12bc:	6ae2                	ld	s5,24(sp)
    12be:	6b42                	ld	s6,16(sp)
    12c0:	6161                	addi	sp,sp,80
    12c2:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    12c4:	85ce                	mv	a1,s3
    12c6:	00005517          	auipc	a0,0x5
    12ca:	65a50513          	addi	a0,a0,1626 # 6920 <malloc+0x8a0>
    12ce:	00005097          	auipc	ra,0x5
    12d2:	cf4080e7          	jalr	-780(ra) # 5fc2 <printf>
    exit(1);
    12d6:	4505                	li	a0,1
    12d8:	00005097          	auipc	ra,0x5
    12dc:	972080e7          	jalr	-1678(ra) # 5c4a <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    12e0:	fb040613          	addi	a2,s0,-80
    12e4:	85ce                	mv	a1,s3
    12e6:	00005517          	auipc	a0,0x5
    12ea:	65a50513          	addi	a0,a0,1626 # 6940 <malloc+0x8c0>
    12ee:	00005097          	auipc	ra,0x5
    12f2:	cd4080e7          	jalr	-812(ra) # 5fc2 <printf>
      exit(1);
    12f6:	4505                	li	a0,1
    12f8:	00005097          	auipc	ra,0x5
    12fc:	952080e7          	jalr	-1710(ra) # 5c4a <exit>
      printf("%s: bigdir unlink failed", s);
    1300:	85ce                	mv	a1,s3
    1302:	00005517          	auipc	a0,0x5
    1306:	65e50513          	addi	a0,a0,1630 # 6960 <malloc+0x8e0>
    130a:	00005097          	auipc	ra,0x5
    130e:	cb8080e7          	jalr	-840(ra) # 5fc2 <printf>
      exit(1);
    1312:	4505                	li	a0,1
    1314:	00005097          	auipc	ra,0x5
    1318:	936080e7          	jalr	-1738(ra) # 5c4a <exit>

000000000000131c <pgbug>:
void pgbug(char *s) {
    131c:	7179                	addi	sp,sp,-48
    131e:	f406                	sd	ra,40(sp)
    1320:	f022                	sd	s0,32(sp)
    1322:	ec26                	sd	s1,24(sp)
    1324:	1800                	addi	s0,sp,48
  argv[0] = 0;
    1326:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    132a:	00008497          	auipc	s1,0x8
    132e:	cd648493          	addi	s1,s1,-810 # 9000 <big>
    1332:	fd840593          	addi	a1,s0,-40
    1336:	6088                	ld	a0,0(s1)
    1338:	00005097          	auipc	ra,0x5
    133c:	94a080e7          	jalr	-1718(ra) # 5c82 <exec>
  pipe(big);
    1340:	6088                	ld	a0,0(s1)
    1342:	00005097          	auipc	ra,0x5
    1346:	918080e7          	jalr	-1768(ra) # 5c5a <pipe>
  exit(0);
    134a:	4501                	li	a0,0
    134c:	00005097          	auipc	ra,0x5
    1350:	8fe080e7          	jalr	-1794(ra) # 5c4a <exit>

0000000000001354 <badarg>:
void badarg(char *s) {
    1354:	7139                	addi	sp,sp,-64
    1356:	fc06                	sd	ra,56(sp)
    1358:	f822                	sd	s0,48(sp)
    135a:	f426                	sd	s1,40(sp)
    135c:	f04a                	sd	s2,32(sp)
    135e:	ec4e                	sd	s3,24(sp)
    1360:	0080                	addi	s0,sp,64
    1362:	64b1                	lui	s1,0xc
    1364:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char *)0xffffffff;
    1368:	597d                	li	s2,-1
    136a:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    136e:	00005997          	auipc	s3,0x5
    1372:	e5a98993          	addi	s3,s3,-422 # 61c8 <malloc+0x148>
    argv[0] = (char *)0xffffffff;
    1376:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    137a:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    137e:	fc040593          	addi	a1,s0,-64
    1382:	854e                	mv	a0,s3
    1384:	00005097          	auipc	ra,0x5
    1388:	8fe080e7          	jalr	-1794(ra) # 5c82 <exec>
  for (int i = 0; i < 50000; i++) {
    138c:	34fd                	addiw	s1,s1,-1
    138e:	f4e5                	bnez	s1,1376 <badarg+0x22>
  exit(0);
    1390:	4501                	li	a0,0
    1392:	00005097          	auipc	ra,0x5
    1396:	8b8080e7          	jalr	-1864(ra) # 5c4a <exit>

000000000000139a <copyinstr2>:
void copyinstr2(char *s) {
    139a:	7155                	addi	sp,sp,-208
    139c:	e586                	sd	ra,200(sp)
    139e:	e1a2                	sd	s0,192(sp)
    13a0:	0980                	addi	s0,sp,208
  for (int i = 0; i < MAXPATH; i++) b[i] = 'x';
    13a2:	f6840793          	addi	a5,s0,-152
    13a6:	fe840693          	addi	a3,s0,-24
    13aa:	07800713          	li	a4,120
    13ae:	00e78023          	sb	a4,0(a5)
    13b2:	0785                	addi	a5,a5,1
    13b4:	fed79de3          	bne	a5,a3,13ae <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    13b8:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    13bc:	f6840513          	addi	a0,s0,-152
    13c0:	00005097          	auipc	ra,0x5
    13c4:	8da080e7          	jalr	-1830(ra) # 5c9a <unlink>
  if (ret != -1) {
    13c8:	57fd                	li	a5,-1
    13ca:	0ef51063          	bne	a0,a5,14aa <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    13ce:	20100593          	li	a1,513
    13d2:	f6840513          	addi	a0,s0,-152
    13d6:	00005097          	auipc	ra,0x5
    13da:	8b4080e7          	jalr	-1868(ra) # 5c8a <open>
  if (fd != -1) {
    13de:	57fd                	li	a5,-1
    13e0:	0ef51563          	bne	a0,a5,14ca <copyinstr2+0x130>
  ret = link(b, b);
    13e4:	f6840593          	addi	a1,s0,-152
    13e8:	852e                	mv	a0,a1
    13ea:	00005097          	auipc	ra,0x5
    13ee:	8c0080e7          	jalr	-1856(ra) # 5caa <link>
  if (ret != -1) {
    13f2:	57fd                	li	a5,-1
    13f4:	0ef51b63          	bne	a0,a5,14ea <copyinstr2+0x150>
  char *args[] = {"xx", 0};
    13f8:	00006797          	auipc	a5,0x6
    13fc:	7c078793          	addi	a5,a5,1984 # 7bb8 <malloc+0x1b38>
    1400:	f4f43c23          	sd	a5,-168(s0)
    1404:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1408:	f5840593          	addi	a1,s0,-168
    140c:	f6840513          	addi	a0,s0,-152
    1410:	00005097          	auipc	ra,0x5
    1414:	872080e7          	jalr	-1934(ra) # 5c82 <exec>
  if (ret != -1) {
    1418:	57fd                	li	a5,-1
    141a:	0ef51963          	bne	a0,a5,150c <copyinstr2+0x172>
  int pid = fork();
    141e:	00005097          	auipc	ra,0x5
    1422:	824080e7          	jalr	-2012(ra) # 5c42 <fork>
  if (pid < 0) {
    1426:	10054363          	bltz	a0,152c <copyinstr2+0x192>
  if (pid == 0) {
    142a:	12051463          	bnez	a0,1552 <copyinstr2+0x1b8>
    142e:	00008797          	auipc	a5,0x8
    1432:	13278793          	addi	a5,a5,306 # 9560 <big.0>
    1436:	00009697          	auipc	a3,0x9
    143a:	12a68693          	addi	a3,a3,298 # a560 <big.0+0x1000>
    for (int i = 0; i < PGSIZE; i++) big[i] = 'x';
    143e:	07800713          	li	a4,120
    1442:	00e78023          	sb	a4,0(a5)
    1446:	0785                	addi	a5,a5,1
    1448:	fed79de3          	bne	a5,a3,1442 <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    144c:	00009797          	auipc	a5,0x9
    1450:	10078a23          	sb	zero,276(a5) # a560 <big.0+0x1000>
    char *args2[] = {big, big, big, 0};
    1454:	00007797          	auipc	a5,0x7
    1458:	23478793          	addi	a5,a5,564 # 8688 <malloc+0x2608>
    145c:	6390                	ld	a2,0(a5)
    145e:	6794                	ld	a3,8(a5)
    1460:	6b98                	ld	a4,16(a5)
    1462:	6f9c                	ld	a5,24(a5)
    1464:	f2c43823          	sd	a2,-208(s0)
    1468:	f2d43c23          	sd	a3,-200(s0)
    146c:	f4e43023          	sd	a4,-192(s0)
    1470:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1474:	f3040593          	addi	a1,s0,-208
    1478:	00005517          	auipc	a0,0x5
    147c:	d5050513          	addi	a0,a0,-688 # 61c8 <malloc+0x148>
    1480:	00005097          	auipc	ra,0x5
    1484:	802080e7          	jalr	-2046(ra) # 5c82 <exec>
    if (ret != -1) {
    1488:	57fd                	li	a5,-1
    148a:	0af50e63          	beq	a0,a5,1546 <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    148e:	55fd                	li	a1,-1
    1490:	00005517          	auipc	a0,0x5
    1494:	57850513          	addi	a0,a0,1400 # 6a08 <malloc+0x988>
    1498:	00005097          	auipc	ra,0x5
    149c:	b2a080e7          	jalr	-1238(ra) # 5fc2 <printf>
      exit(1);
    14a0:	4505                	li	a0,1
    14a2:	00004097          	auipc	ra,0x4
    14a6:	7a8080e7          	jalr	1960(ra) # 5c4a <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    14aa:	862a                	mv	a2,a0
    14ac:	f6840593          	addi	a1,s0,-152
    14b0:	00005517          	auipc	a0,0x5
    14b4:	4d050513          	addi	a0,a0,1232 # 6980 <malloc+0x900>
    14b8:	00005097          	auipc	ra,0x5
    14bc:	b0a080e7          	jalr	-1270(ra) # 5fc2 <printf>
    exit(1);
    14c0:	4505                	li	a0,1
    14c2:	00004097          	auipc	ra,0x4
    14c6:	788080e7          	jalr	1928(ra) # 5c4a <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    14ca:	862a                	mv	a2,a0
    14cc:	f6840593          	addi	a1,s0,-152
    14d0:	00005517          	auipc	a0,0x5
    14d4:	4d050513          	addi	a0,a0,1232 # 69a0 <malloc+0x920>
    14d8:	00005097          	auipc	ra,0x5
    14dc:	aea080e7          	jalr	-1302(ra) # 5fc2 <printf>
    exit(1);
    14e0:	4505                	li	a0,1
    14e2:	00004097          	auipc	ra,0x4
    14e6:	768080e7          	jalr	1896(ra) # 5c4a <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    14ea:	86aa                	mv	a3,a0
    14ec:	f6840613          	addi	a2,s0,-152
    14f0:	85b2                	mv	a1,a2
    14f2:	00005517          	auipc	a0,0x5
    14f6:	4ce50513          	addi	a0,a0,1230 # 69c0 <malloc+0x940>
    14fa:	00005097          	auipc	ra,0x5
    14fe:	ac8080e7          	jalr	-1336(ra) # 5fc2 <printf>
    exit(1);
    1502:	4505                	li	a0,1
    1504:	00004097          	auipc	ra,0x4
    1508:	746080e7          	jalr	1862(ra) # 5c4a <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    150c:	567d                	li	a2,-1
    150e:	f6840593          	addi	a1,s0,-152
    1512:	00005517          	auipc	a0,0x5
    1516:	4d650513          	addi	a0,a0,1238 # 69e8 <malloc+0x968>
    151a:	00005097          	auipc	ra,0x5
    151e:	aa8080e7          	jalr	-1368(ra) # 5fc2 <printf>
    exit(1);
    1522:	4505                	li	a0,1
    1524:	00004097          	auipc	ra,0x4
    1528:	726080e7          	jalr	1830(ra) # 5c4a <exit>
    printf("fork failed\n");
    152c:	00006517          	auipc	a0,0x6
    1530:	93c50513          	addi	a0,a0,-1732 # 6e68 <malloc+0xde8>
    1534:	00005097          	auipc	ra,0x5
    1538:	a8e080e7          	jalr	-1394(ra) # 5fc2 <printf>
    exit(1);
    153c:	4505                	li	a0,1
    153e:	00004097          	auipc	ra,0x4
    1542:	70c080e7          	jalr	1804(ra) # 5c4a <exit>
    exit(747);  // OK
    1546:	2eb00513          	li	a0,747
    154a:	00004097          	auipc	ra,0x4
    154e:	700080e7          	jalr	1792(ra) # 5c4a <exit>
  int st = 0;
    1552:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    1556:	f5440513          	addi	a0,s0,-172
    155a:	00004097          	auipc	ra,0x4
    155e:	6f8080e7          	jalr	1784(ra) # 5c52 <wait>
  if (st != 747) {
    1562:	f5442703          	lw	a4,-172(s0)
    1566:	2eb00793          	li	a5,747
    156a:	00f71663          	bne	a4,a5,1576 <copyinstr2+0x1dc>
}
    156e:	60ae                	ld	ra,200(sp)
    1570:	640e                	ld	s0,192(sp)
    1572:	6169                	addi	sp,sp,208
    1574:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    1576:	00005517          	auipc	a0,0x5
    157a:	4ba50513          	addi	a0,a0,1210 # 6a30 <malloc+0x9b0>
    157e:	00005097          	auipc	ra,0x5
    1582:	a44080e7          	jalr	-1468(ra) # 5fc2 <printf>
    exit(1);
    1586:	4505                	li	a0,1
    1588:	00004097          	auipc	ra,0x4
    158c:	6c2080e7          	jalr	1730(ra) # 5c4a <exit>

0000000000001590 <truncate3>:
void truncate3(char *s) {
    1590:	7159                	addi	sp,sp,-112
    1592:	f486                	sd	ra,104(sp)
    1594:	f0a2                	sd	s0,96(sp)
    1596:	eca6                	sd	s1,88(sp)
    1598:	e8ca                	sd	s2,80(sp)
    159a:	e4ce                	sd	s3,72(sp)
    159c:	e0d2                	sd	s4,64(sp)
    159e:	fc56                	sd	s5,56(sp)
    15a0:	1880                	addi	s0,sp,112
    15a2:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE | O_TRUNC | O_WRONLY));
    15a4:	60100593          	li	a1,1537
    15a8:	00005517          	auipc	a0,0x5
    15ac:	c7850513          	addi	a0,a0,-904 # 6220 <malloc+0x1a0>
    15b0:	00004097          	auipc	ra,0x4
    15b4:	6da080e7          	jalr	1754(ra) # 5c8a <open>
    15b8:	00004097          	auipc	ra,0x4
    15bc:	6ba080e7          	jalr	1722(ra) # 5c72 <close>
  pid = fork();
    15c0:	00004097          	auipc	ra,0x4
    15c4:	682080e7          	jalr	1666(ra) # 5c42 <fork>
  if (pid < 0) {
    15c8:	08054063          	bltz	a0,1648 <truncate3+0xb8>
  if (pid == 0) {
    15cc:	e969                	bnez	a0,169e <truncate3+0x10e>
    15ce:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    15d2:	00005a17          	auipc	s4,0x5
    15d6:	c4ea0a13          	addi	s4,s4,-946 # 6220 <malloc+0x1a0>
      int n = write(fd, "1234567890", 10);
    15da:	00005a97          	auipc	s5,0x5
    15de:	4b6a8a93          	addi	s5,s5,1206 # 6a90 <malloc+0xa10>
      int fd = open("truncfile", O_WRONLY);
    15e2:	4585                	li	a1,1
    15e4:	8552                	mv	a0,s4
    15e6:	00004097          	auipc	ra,0x4
    15ea:	6a4080e7          	jalr	1700(ra) # 5c8a <open>
    15ee:	84aa                	mv	s1,a0
      if (fd < 0) {
    15f0:	06054a63          	bltz	a0,1664 <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    15f4:	4629                	li	a2,10
    15f6:	85d6                	mv	a1,s5
    15f8:	00004097          	auipc	ra,0x4
    15fc:	672080e7          	jalr	1650(ra) # 5c6a <write>
      if (n != 10) {
    1600:	47a9                	li	a5,10
    1602:	06f51f63          	bne	a0,a5,1680 <truncate3+0xf0>
      close(fd);
    1606:	8526                	mv	a0,s1
    1608:	00004097          	auipc	ra,0x4
    160c:	66a080e7          	jalr	1642(ra) # 5c72 <close>
      fd = open("truncfile", O_RDONLY);
    1610:	4581                	li	a1,0
    1612:	8552                	mv	a0,s4
    1614:	00004097          	auipc	ra,0x4
    1618:	676080e7          	jalr	1654(ra) # 5c8a <open>
    161c:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    161e:	02000613          	li	a2,32
    1622:	f9840593          	addi	a1,s0,-104
    1626:	00004097          	auipc	ra,0x4
    162a:	63c080e7          	jalr	1596(ra) # 5c62 <read>
      close(fd);
    162e:	8526                	mv	a0,s1
    1630:	00004097          	auipc	ra,0x4
    1634:	642080e7          	jalr	1602(ra) # 5c72 <close>
    for (int i = 0; i < 100; i++) {
    1638:	39fd                	addiw	s3,s3,-1
    163a:	fa0994e3          	bnez	s3,15e2 <truncate3+0x52>
    exit(0);
    163e:	4501                	li	a0,0
    1640:	00004097          	auipc	ra,0x4
    1644:	60a080e7          	jalr	1546(ra) # 5c4a <exit>
    printf("%s: fork failed\n", s);
    1648:	85ca                	mv	a1,s2
    164a:	00005517          	auipc	a0,0x5
    164e:	41650513          	addi	a0,a0,1046 # 6a60 <malloc+0x9e0>
    1652:	00005097          	auipc	ra,0x5
    1656:	970080e7          	jalr	-1680(ra) # 5fc2 <printf>
    exit(1);
    165a:	4505                	li	a0,1
    165c:	00004097          	auipc	ra,0x4
    1660:	5ee080e7          	jalr	1518(ra) # 5c4a <exit>
        printf("%s: open failed\n", s);
    1664:	85ca                	mv	a1,s2
    1666:	00005517          	auipc	a0,0x5
    166a:	41250513          	addi	a0,a0,1042 # 6a78 <malloc+0x9f8>
    166e:	00005097          	auipc	ra,0x5
    1672:	954080e7          	jalr	-1708(ra) # 5fc2 <printf>
        exit(1);
    1676:	4505                	li	a0,1
    1678:	00004097          	auipc	ra,0x4
    167c:	5d2080e7          	jalr	1490(ra) # 5c4a <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1680:	862a                	mv	a2,a0
    1682:	85ca                	mv	a1,s2
    1684:	00005517          	auipc	a0,0x5
    1688:	41c50513          	addi	a0,a0,1052 # 6aa0 <malloc+0xa20>
    168c:	00005097          	auipc	ra,0x5
    1690:	936080e7          	jalr	-1738(ra) # 5fc2 <printf>
        exit(1);
    1694:	4505                	li	a0,1
    1696:	00004097          	auipc	ra,0x4
    169a:	5b4080e7          	jalr	1460(ra) # 5c4a <exit>
    169e:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
    16a2:	00005a17          	auipc	s4,0x5
    16a6:	b7ea0a13          	addi	s4,s4,-1154 # 6220 <malloc+0x1a0>
    int n = write(fd, "xxx", 3);
    16aa:	00005a97          	auipc	s5,0x5
    16ae:	416a8a93          	addi	s5,s5,1046 # 6ac0 <malloc+0xa40>
    int fd = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
    16b2:	60100593          	li	a1,1537
    16b6:	8552                	mv	a0,s4
    16b8:	00004097          	auipc	ra,0x4
    16bc:	5d2080e7          	jalr	1490(ra) # 5c8a <open>
    16c0:	84aa                	mv	s1,a0
    if (fd < 0) {
    16c2:	04054763          	bltz	a0,1710 <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    16c6:	460d                	li	a2,3
    16c8:	85d6                	mv	a1,s5
    16ca:	00004097          	auipc	ra,0x4
    16ce:	5a0080e7          	jalr	1440(ra) # 5c6a <write>
    if (n != 3) {
    16d2:	478d                	li	a5,3
    16d4:	04f51c63          	bne	a0,a5,172c <truncate3+0x19c>
    close(fd);
    16d8:	8526                	mv	a0,s1
    16da:	00004097          	auipc	ra,0x4
    16de:	598080e7          	jalr	1432(ra) # 5c72 <close>
  for (int i = 0; i < 150; i++) {
    16e2:	39fd                	addiw	s3,s3,-1
    16e4:	fc0997e3          	bnez	s3,16b2 <truncate3+0x122>
  wait(&xstatus);
    16e8:	fbc40513          	addi	a0,s0,-68
    16ec:	00004097          	auipc	ra,0x4
    16f0:	566080e7          	jalr	1382(ra) # 5c52 <wait>
  unlink("truncfile");
    16f4:	00005517          	auipc	a0,0x5
    16f8:	b2c50513          	addi	a0,a0,-1236 # 6220 <malloc+0x1a0>
    16fc:	00004097          	auipc	ra,0x4
    1700:	59e080e7          	jalr	1438(ra) # 5c9a <unlink>
  exit(xstatus);
    1704:	fbc42503          	lw	a0,-68(s0)
    1708:	00004097          	auipc	ra,0x4
    170c:	542080e7          	jalr	1346(ra) # 5c4a <exit>
      printf("%s: open failed\n", s);
    1710:	85ca                	mv	a1,s2
    1712:	00005517          	auipc	a0,0x5
    1716:	36650513          	addi	a0,a0,870 # 6a78 <malloc+0x9f8>
    171a:	00005097          	auipc	ra,0x5
    171e:	8a8080e7          	jalr	-1880(ra) # 5fc2 <printf>
      exit(1);
    1722:	4505                	li	a0,1
    1724:	00004097          	auipc	ra,0x4
    1728:	526080e7          	jalr	1318(ra) # 5c4a <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    172c:	862a                	mv	a2,a0
    172e:	85ca                	mv	a1,s2
    1730:	00005517          	auipc	a0,0x5
    1734:	39850513          	addi	a0,a0,920 # 6ac8 <malloc+0xa48>
    1738:	00005097          	auipc	ra,0x5
    173c:	88a080e7          	jalr	-1910(ra) # 5fc2 <printf>
      exit(1);
    1740:	4505                	li	a0,1
    1742:	00004097          	auipc	ra,0x4
    1746:	508080e7          	jalr	1288(ra) # 5c4a <exit>

000000000000174a <exectest>:
void exectest(char *s) {
    174a:	715d                	addi	sp,sp,-80
    174c:	e486                	sd	ra,72(sp)
    174e:	e0a2                	sd	s0,64(sp)
    1750:	fc26                	sd	s1,56(sp)
    1752:	f84a                	sd	s2,48(sp)
    1754:	0880                	addi	s0,sp,80
    1756:	892a                	mv	s2,a0
  char *echoargv[] = {"echo", "OK", 0};
    1758:	00005797          	auipc	a5,0x5
    175c:	a7078793          	addi	a5,a5,-1424 # 61c8 <malloc+0x148>
    1760:	fcf43023          	sd	a5,-64(s0)
    1764:	00005797          	auipc	a5,0x5
    1768:	38478793          	addi	a5,a5,900 # 6ae8 <malloc+0xa68>
    176c:	fcf43423          	sd	a5,-56(s0)
    1770:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    1774:	00005517          	auipc	a0,0x5
    1778:	37c50513          	addi	a0,a0,892 # 6af0 <malloc+0xa70>
    177c:	00004097          	auipc	ra,0x4
    1780:	51e080e7          	jalr	1310(ra) # 5c9a <unlink>
  pid = fork();
    1784:	00004097          	auipc	ra,0x4
    1788:	4be080e7          	jalr	1214(ra) # 5c42 <fork>
  if (pid < 0) {
    178c:	04054663          	bltz	a0,17d8 <exectest+0x8e>
    1790:	84aa                	mv	s1,a0
  if (pid == 0) {
    1792:	e959                	bnez	a0,1828 <exectest+0xde>
    close(1);
    1794:	4505                	li	a0,1
    1796:	00004097          	auipc	ra,0x4
    179a:	4dc080e7          	jalr	1244(ra) # 5c72 <close>
    fd = open("echo-ok", O_CREATE | O_WRONLY);
    179e:	20100593          	li	a1,513
    17a2:	00005517          	auipc	a0,0x5
    17a6:	34e50513          	addi	a0,a0,846 # 6af0 <malloc+0xa70>
    17aa:	00004097          	auipc	ra,0x4
    17ae:	4e0080e7          	jalr	1248(ra) # 5c8a <open>
    if (fd < 0) {
    17b2:	04054163          	bltz	a0,17f4 <exectest+0xaa>
    if (fd != 1) {
    17b6:	4785                	li	a5,1
    17b8:	04f50c63          	beq	a0,a5,1810 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    17bc:	85ca                	mv	a1,s2
    17be:	00005517          	auipc	a0,0x5
    17c2:	35250513          	addi	a0,a0,850 # 6b10 <malloc+0xa90>
    17c6:	00004097          	auipc	ra,0x4
    17ca:	7fc080e7          	jalr	2044(ra) # 5fc2 <printf>
      exit(1);
    17ce:	4505                	li	a0,1
    17d0:	00004097          	auipc	ra,0x4
    17d4:	47a080e7          	jalr	1146(ra) # 5c4a <exit>
    printf("%s: fork failed\n", s);
    17d8:	85ca                	mv	a1,s2
    17da:	00005517          	auipc	a0,0x5
    17de:	28650513          	addi	a0,a0,646 # 6a60 <malloc+0x9e0>
    17e2:	00004097          	auipc	ra,0x4
    17e6:	7e0080e7          	jalr	2016(ra) # 5fc2 <printf>
    exit(1);
    17ea:	4505                	li	a0,1
    17ec:	00004097          	auipc	ra,0x4
    17f0:	45e080e7          	jalr	1118(ra) # 5c4a <exit>
      printf("%s: create failed\n", s);
    17f4:	85ca                	mv	a1,s2
    17f6:	00005517          	auipc	a0,0x5
    17fa:	30250513          	addi	a0,a0,770 # 6af8 <malloc+0xa78>
    17fe:	00004097          	auipc	ra,0x4
    1802:	7c4080e7          	jalr	1988(ra) # 5fc2 <printf>
      exit(1);
    1806:	4505                	li	a0,1
    1808:	00004097          	auipc	ra,0x4
    180c:	442080e7          	jalr	1090(ra) # 5c4a <exit>
    if (exec("echo", echoargv) < 0) {
    1810:	fc040593          	addi	a1,s0,-64
    1814:	00005517          	auipc	a0,0x5
    1818:	9b450513          	addi	a0,a0,-1612 # 61c8 <malloc+0x148>
    181c:	00004097          	auipc	ra,0x4
    1820:	466080e7          	jalr	1126(ra) # 5c82 <exec>
    1824:	02054163          	bltz	a0,1846 <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    1828:	fdc40513          	addi	a0,s0,-36
    182c:	00004097          	auipc	ra,0x4
    1830:	426080e7          	jalr	1062(ra) # 5c52 <wait>
    1834:	02951763          	bne	a0,s1,1862 <exectest+0x118>
  if (xstatus != 0) exit(xstatus);
    1838:	fdc42503          	lw	a0,-36(s0)
    183c:	cd0d                	beqz	a0,1876 <exectest+0x12c>
    183e:	00004097          	auipc	ra,0x4
    1842:	40c080e7          	jalr	1036(ra) # 5c4a <exit>
      printf("%s: exec echo failed\n", s);
    1846:	85ca                	mv	a1,s2
    1848:	00005517          	auipc	a0,0x5
    184c:	2d850513          	addi	a0,a0,728 # 6b20 <malloc+0xaa0>
    1850:	00004097          	auipc	ra,0x4
    1854:	772080e7          	jalr	1906(ra) # 5fc2 <printf>
      exit(1);
    1858:	4505                	li	a0,1
    185a:	00004097          	auipc	ra,0x4
    185e:	3f0080e7          	jalr	1008(ra) # 5c4a <exit>
    printf("%s: wait failed!\n", s);
    1862:	85ca                	mv	a1,s2
    1864:	00005517          	auipc	a0,0x5
    1868:	2d450513          	addi	a0,a0,724 # 6b38 <malloc+0xab8>
    186c:	00004097          	auipc	ra,0x4
    1870:	756080e7          	jalr	1878(ra) # 5fc2 <printf>
    1874:	b7d1                	j	1838 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    1876:	4581                	li	a1,0
    1878:	00005517          	auipc	a0,0x5
    187c:	27850513          	addi	a0,a0,632 # 6af0 <malloc+0xa70>
    1880:	00004097          	auipc	ra,0x4
    1884:	40a080e7          	jalr	1034(ra) # 5c8a <open>
  if (fd < 0) {
    1888:	02054a63          	bltz	a0,18bc <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    188c:	4609                	li	a2,2
    188e:	fb840593          	addi	a1,s0,-72
    1892:	00004097          	auipc	ra,0x4
    1896:	3d0080e7          	jalr	976(ra) # 5c62 <read>
    189a:	4789                	li	a5,2
    189c:	02f50e63          	beq	a0,a5,18d8 <exectest+0x18e>
    printf("%s: read failed\n", s);
    18a0:	85ca                	mv	a1,s2
    18a2:	00005517          	auipc	a0,0x5
    18a6:	d0650513          	addi	a0,a0,-762 # 65a8 <malloc+0x528>
    18aa:	00004097          	auipc	ra,0x4
    18ae:	718080e7          	jalr	1816(ra) # 5fc2 <printf>
    exit(1);
    18b2:	4505                	li	a0,1
    18b4:	00004097          	auipc	ra,0x4
    18b8:	396080e7          	jalr	918(ra) # 5c4a <exit>
    printf("%s: open failed\n", s);
    18bc:	85ca                	mv	a1,s2
    18be:	00005517          	auipc	a0,0x5
    18c2:	1ba50513          	addi	a0,a0,442 # 6a78 <malloc+0x9f8>
    18c6:	00004097          	auipc	ra,0x4
    18ca:	6fc080e7          	jalr	1788(ra) # 5fc2 <printf>
    exit(1);
    18ce:	4505                	li	a0,1
    18d0:	00004097          	auipc	ra,0x4
    18d4:	37a080e7          	jalr	890(ra) # 5c4a <exit>
  unlink("echo-ok");
    18d8:	00005517          	auipc	a0,0x5
    18dc:	21850513          	addi	a0,a0,536 # 6af0 <malloc+0xa70>
    18e0:	00004097          	auipc	ra,0x4
    18e4:	3ba080e7          	jalr	954(ra) # 5c9a <unlink>
  if (buf[0] == 'O' && buf[1] == 'K')
    18e8:	fb844703          	lbu	a4,-72(s0)
    18ec:	04f00793          	li	a5,79
    18f0:	00f71863          	bne	a4,a5,1900 <exectest+0x1b6>
    18f4:	fb944703          	lbu	a4,-71(s0)
    18f8:	04b00793          	li	a5,75
    18fc:	02f70063          	beq	a4,a5,191c <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    1900:	85ca                	mv	a1,s2
    1902:	00005517          	auipc	a0,0x5
    1906:	24e50513          	addi	a0,a0,590 # 6b50 <malloc+0xad0>
    190a:	00004097          	auipc	ra,0x4
    190e:	6b8080e7          	jalr	1720(ra) # 5fc2 <printf>
    exit(1);
    1912:	4505                	li	a0,1
    1914:	00004097          	auipc	ra,0x4
    1918:	336080e7          	jalr	822(ra) # 5c4a <exit>
    exit(0);
    191c:	4501                	li	a0,0
    191e:	00004097          	auipc	ra,0x4
    1922:	32c080e7          	jalr	812(ra) # 5c4a <exit>

0000000000001926 <pipe1>:
void pipe1(char *s) {
    1926:	711d                	addi	sp,sp,-96
    1928:	ec86                	sd	ra,88(sp)
    192a:	e8a2                	sd	s0,80(sp)
    192c:	e4a6                	sd	s1,72(sp)
    192e:	e0ca                	sd	s2,64(sp)
    1930:	fc4e                	sd	s3,56(sp)
    1932:	f852                	sd	s4,48(sp)
    1934:	f456                	sd	s5,40(sp)
    1936:	f05a                	sd	s6,32(sp)
    1938:	ec5e                	sd	s7,24(sp)
    193a:	1080                	addi	s0,sp,96
    193c:	892a                	mv	s2,a0
  if (pipe(fds) != 0) {
    193e:	fa840513          	addi	a0,s0,-88
    1942:	00004097          	auipc	ra,0x4
    1946:	318080e7          	jalr	792(ra) # 5c5a <pipe>
    194a:	ed25                	bnez	a0,19c2 <pipe1+0x9c>
    194c:	84aa                	mv	s1,a0
  pid = fork();
    194e:	00004097          	auipc	ra,0x4
    1952:	2f4080e7          	jalr	756(ra) # 5c42 <fork>
    1956:	8a2a                	mv	s4,a0
  if (pid == 0) {
    1958:	c159                	beqz	a0,19de <pipe1+0xb8>
  } else if (pid > 0) {
    195a:	16a05e63          	blez	a0,1ad6 <pipe1+0x1b0>
    close(fds[1]);
    195e:	fac42503          	lw	a0,-84(s0)
    1962:	00004097          	auipc	ra,0x4
    1966:	310080e7          	jalr	784(ra) # 5c72 <close>
    total = 0;
    196a:	8a26                	mv	s4,s1
    cc = 1;
    196c:	4985                	li	s3,1
    while ((n = read(fds[0], buf, cc)) > 0) {
    196e:	0000ba97          	auipc	s5,0xb
    1972:	30aa8a93          	addi	s5,s5,778 # cc78 <buf>
      if (cc > sizeof(buf)) cc = sizeof(buf);
    1976:	6b0d                	lui	s6,0x3
    while ((n = read(fds[0], buf, cc)) > 0) {
    1978:	864e                	mv	a2,s3
    197a:	85d6                	mv	a1,s5
    197c:	fa842503          	lw	a0,-88(s0)
    1980:	00004097          	auipc	ra,0x4
    1984:	2e2080e7          	jalr	738(ra) # 5c62 <read>
    1988:	10a05263          	blez	a0,1a8c <pipe1+0x166>
      for (i = 0; i < n; i++) {
    198c:	0000b717          	auipc	a4,0xb
    1990:	2ec70713          	addi	a4,a4,748 # cc78 <buf>
    1994:	00a4863b          	addw	a2,s1,a0
        if ((buf[i] & 0xff) != (seq++ & 0xff)) {
    1998:	00074683          	lbu	a3,0(a4)
    199c:	0ff4f793          	andi	a5,s1,255
    19a0:	2485                	addiw	s1,s1,1
    19a2:	0cf69163          	bne	a3,a5,1a64 <pipe1+0x13e>
      for (i = 0; i < n; i++) {
    19a6:	0705                	addi	a4,a4,1
    19a8:	fec498e3          	bne	s1,a2,1998 <pipe1+0x72>
      total += n;
    19ac:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    19b0:	0019979b          	slliw	a5,s3,0x1
    19b4:	0007899b          	sext.w	s3,a5
      if (cc > sizeof(buf)) cc = sizeof(buf);
    19b8:	013b7363          	bgeu	s6,s3,19be <pipe1+0x98>
    19bc:	89da                	mv	s3,s6
        if ((buf[i] & 0xff) != (seq++ & 0xff)) {
    19be:	84b2                	mv	s1,a2
    19c0:	bf65                	j	1978 <pipe1+0x52>
    printf("%s: pipe() failed\n", s);
    19c2:	85ca                	mv	a1,s2
    19c4:	00005517          	auipc	a0,0x5
    19c8:	1a450513          	addi	a0,a0,420 # 6b68 <malloc+0xae8>
    19cc:	00004097          	auipc	ra,0x4
    19d0:	5f6080e7          	jalr	1526(ra) # 5fc2 <printf>
    exit(1);
    19d4:	4505                	li	a0,1
    19d6:	00004097          	auipc	ra,0x4
    19da:	274080e7          	jalr	628(ra) # 5c4a <exit>
    close(fds[0]);
    19de:	fa842503          	lw	a0,-88(s0)
    19e2:	00004097          	auipc	ra,0x4
    19e6:	290080e7          	jalr	656(ra) # 5c72 <close>
    for (n = 0; n < N; n++) {
    19ea:	0000bb17          	auipc	s6,0xb
    19ee:	28eb0b13          	addi	s6,s6,654 # cc78 <buf>
    19f2:	416004bb          	negw	s1,s6
    19f6:	0ff4f493          	andi	s1,s1,255
    19fa:	409b0993          	addi	s3,s6,1033
      if (write(fds[1], buf, SZ) != SZ) {
    19fe:	8bda                	mv	s7,s6
    for (n = 0; n < N; n++) {
    1a00:	6a85                	lui	s5,0x1
    1a02:	42da8a93          	addi	s5,s5,1069 # 142d <copyinstr2+0x93>
void pipe1(char *s) {
    1a06:	87da                	mv	a5,s6
      for (i = 0; i < SZ; i++) buf[i] = seq++;
    1a08:	0097873b          	addw	a4,a5,s1
    1a0c:	00e78023          	sb	a4,0(a5)
    1a10:	0785                	addi	a5,a5,1
    1a12:	fef99be3          	bne	s3,a5,1a08 <pipe1+0xe2>
    1a16:	409a0a1b          	addiw	s4,s4,1033
      if (write(fds[1], buf, SZ) != SZ) {
    1a1a:	40900613          	li	a2,1033
    1a1e:	85de                	mv	a1,s7
    1a20:	fac42503          	lw	a0,-84(s0)
    1a24:	00004097          	auipc	ra,0x4
    1a28:	246080e7          	jalr	582(ra) # 5c6a <write>
    1a2c:	40900793          	li	a5,1033
    1a30:	00f51c63          	bne	a0,a5,1a48 <pipe1+0x122>
    for (n = 0; n < N; n++) {
    1a34:	24a5                	addiw	s1,s1,9
    1a36:	0ff4f493          	andi	s1,s1,255
    1a3a:	fd5a16e3          	bne	s4,s5,1a06 <pipe1+0xe0>
    exit(0);
    1a3e:	4501                	li	a0,0
    1a40:	00004097          	auipc	ra,0x4
    1a44:	20a080e7          	jalr	522(ra) # 5c4a <exit>
        printf("%s: pipe1 oops 1\n", s);
    1a48:	85ca                	mv	a1,s2
    1a4a:	00005517          	auipc	a0,0x5
    1a4e:	13650513          	addi	a0,a0,310 # 6b80 <malloc+0xb00>
    1a52:	00004097          	auipc	ra,0x4
    1a56:	570080e7          	jalr	1392(ra) # 5fc2 <printf>
        exit(1);
    1a5a:	4505                	li	a0,1
    1a5c:	00004097          	auipc	ra,0x4
    1a60:	1ee080e7          	jalr	494(ra) # 5c4a <exit>
          printf("%s: pipe1 oops 2\n", s);
    1a64:	85ca                	mv	a1,s2
    1a66:	00005517          	auipc	a0,0x5
    1a6a:	13250513          	addi	a0,a0,306 # 6b98 <malloc+0xb18>
    1a6e:	00004097          	auipc	ra,0x4
    1a72:	554080e7          	jalr	1364(ra) # 5fc2 <printf>
}
    1a76:	60e6                	ld	ra,88(sp)
    1a78:	6446                	ld	s0,80(sp)
    1a7a:	64a6                	ld	s1,72(sp)
    1a7c:	6906                	ld	s2,64(sp)
    1a7e:	79e2                	ld	s3,56(sp)
    1a80:	7a42                	ld	s4,48(sp)
    1a82:	7aa2                	ld	s5,40(sp)
    1a84:	7b02                	ld	s6,32(sp)
    1a86:	6be2                	ld	s7,24(sp)
    1a88:	6125                	addi	sp,sp,96
    1a8a:	8082                	ret
    if (total != N * SZ) {
    1a8c:	6785                	lui	a5,0x1
    1a8e:	42d78793          	addi	a5,a5,1069 # 142d <copyinstr2+0x93>
    1a92:	02fa0063          	beq	s4,a5,1ab2 <pipe1+0x18c>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1a96:	85d2                	mv	a1,s4
    1a98:	00005517          	auipc	a0,0x5
    1a9c:	11850513          	addi	a0,a0,280 # 6bb0 <malloc+0xb30>
    1aa0:	00004097          	auipc	ra,0x4
    1aa4:	522080e7          	jalr	1314(ra) # 5fc2 <printf>
      exit(1);
    1aa8:	4505                	li	a0,1
    1aaa:	00004097          	auipc	ra,0x4
    1aae:	1a0080e7          	jalr	416(ra) # 5c4a <exit>
    close(fds[0]);
    1ab2:	fa842503          	lw	a0,-88(s0)
    1ab6:	00004097          	auipc	ra,0x4
    1aba:	1bc080e7          	jalr	444(ra) # 5c72 <close>
    wait(&xstatus);
    1abe:	fa440513          	addi	a0,s0,-92
    1ac2:	00004097          	auipc	ra,0x4
    1ac6:	190080e7          	jalr	400(ra) # 5c52 <wait>
    exit(xstatus);
    1aca:	fa442503          	lw	a0,-92(s0)
    1ace:	00004097          	auipc	ra,0x4
    1ad2:	17c080e7          	jalr	380(ra) # 5c4a <exit>
    printf("%s: fork() failed\n", s);
    1ad6:	85ca                	mv	a1,s2
    1ad8:	00005517          	auipc	a0,0x5
    1adc:	0f850513          	addi	a0,a0,248 # 6bd0 <malloc+0xb50>
    1ae0:	00004097          	auipc	ra,0x4
    1ae4:	4e2080e7          	jalr	1250(ra) # 5fc2 <printf>
    exit(1);
    1ae8:	4505                	li	a0,1
    1aea:	00004097          	auipc	ra,0x4
    1aee:	160080e7          	jalr	352(ra) # 5c4a <exit>

0000000000001af2 <exitwait>:
void exitwait(char *s) {
    1af2:	7139                	addi	sp,sp,-64
    1af4:	fc06                	sd	ra,56(sp)
    1af6:	f822                	sd	s0,48(sp)
    1af8:	f426                	sd	s1,40(sp)
    1afa:	f04a                	sd	s2,32(sp)
    1afc:	ec4e                	sd	s3,24(sp)
    1afe:	e852                	sd	s4,16(sp)
    1b00:	0080                	addi	s0,sp,64
    1b02:	8a2a                	mv	s4,a0
  for (i = 0; i < 100; i++) {
    1b04:	4901                	li	s2,0
    1b06:	06400993          	li	s3,100
    pid = fork();
    1b0a:	00004097          	auipc	ra,0x4
    1b0e:	138080e7          	jalr	312(ra) # 5c42 <fork>
    1b12:	84aa                	mv	s1,a0
    if (pid < 0) {
    1b14:	02054a63          	bltz	a0,1b48 <exitwait+0x56>
    if (pid) {
    1b18:	c151                	beqz	a0,1b9c <exitwait+0xaa>
      if (wait(&xstate) != pid) {
    1b1a:	fcc40513          	addi	a0,s0,-52
    1b1e:	00004097          	auipc	ra,0x4
    1b22:	134080e7          	jalr	308(ra) # 5c52 <wait>
    1b26:	02951f63          	bne	a0,s1,1b64 <exitwait+0x72>
      if (i != xstate) {
    1b2a:	fcc42783          	lw	a5,-52(s0)
    1b2e:	05279963          	bne	a5,s2,1b80 <exitwait+0x8e>
  for (i = 0; i < 100; i++) {
    1b32:	2905                	addiw	s2,s2,1
    1b34:	fd391be3          	bne	s2,s3,1b0a <exitwait+0x18>
}
    1b38:	70e2                	ld	ra,56(sp)
    1b3a:	7442                	ld	s0,48(sp)
    1b3c:	74a2                	ld	s1,40(sp)
    1b3e:	7902                	ld	s2,32(sp)
    1b40:	69e2                	ld	s3,24(sp)
    1b42:	6a42                	ld	s4,16(sp)
    1b44:	6121                	addi	sp,sp,64
    1b46:	8082                	ret
      printf("%s: fork failed\n", s);
    1b48:	85d2                	mv	a1,s4
    1b4a:	00005517          	auipc	a0,0x5
    1b4e:	f1650513          	addi	a0,a0,-234 # 6a60 <malloc+0x9e0>
    1b52:	00004097          	auipc	ra,0x4
    1b56:	470080e7          	jalr	1136(ra) # 5fc2 <printf>
      exit(1);
    1b5a:	4505                	li	a0,1
    1b5c:	00004097          	auipc	ra,0x4
    1b60:	0ee080e7          	jalr	238(ra) # 5c4a <exit>
        printf("%s: wait wrong pid\n", s);
    1b64:	85d2                	mv	a1,s4
    1b66:	00005517          	auipc	a0,0x5
    1b6a:	08250513          	addi	a0,a0,130 # 6be8 <malloc+0xb68>
    1b6e:	00004097          	auipc	ra,0x4
    1b72:	454080e7          	jalr	1108(ra) # 5fc2 <printf>
        exit(1);
    1b76:	4505                	li	a0,1
    1b78:	00004097          	auipc	ra,0x4
    1b7c:	0d2080e7          	jalr	210(ra) # 5c4a <exit>
        printf("%s: wait wrong exit status\n", s);
    1b80:	85d2                	mv	a1,s4
    1b82:	00005517          	auipc	a0,0x5
    1b86:	07e50513          	addi	a0,a0,126 # 6c00 <malloc+0xb80>
    1b8a:	00004097          	auipc	ra,0x4
    1b8e:	438080e7          	jalr	1080(ra) # 5fc2 <printf>
        exit(1);
    1b92:	4505                	li	a0,1
    1b94:	00004097          	auipc	ra,0x4
    1b98:	0b6080e7          	jalr	182(ra) # 5c4a <exit>
      exit(i);
    1b9c:	854a                	mv	a0,s2
    1b9e:	00004097          	auipc	ra,0x4
    1ba2:	0ac080e7          	jalr	172(ra) # 5c4a <exit>

0000000000001ba6 <twochildren>:
void twochildren(char *s) {
    1ba6:	1101                	addi	sp,sp,-32
    1ba8:	ec06                	sd	ra,24(sp)
    1baa:	e822                	sd	s0,16(sp)
    1bac:	e426                	sd	s1,8(sp)
    1bae:	e04a                	sd	s2,0(sp)
    1bb0:	1000                	addi	s0,sp,32
    1bb2:	892a                	mv	s2,a0
    1bb4:	3e800493          	li	s1,1000
    int pid1 = fork();
    1bb8:	00004097          	auipc	ra,0x4
    1bbc:	08a080e7          	jalr	138(ra) # 5c42 <fork>
    if (pid1 < 0) {
    1bc0:	02054c63          	bltz	a0,1bf8 <twochildren+0x52>
    if (pid1 == 0) {
    1bc4:	c921                	beqz	a0,1c14 <twochildren+0x6e>
      int pid2 = fork();
    1bc6:	00004097          	auipc	ra,0x4
    1bca:	07c080e7          	jalr	124(ra) # 5c42 <fork>
      if (pid2 < 0) {
    1bce:	04054763          	bltz	a0,1c1c <twochildren+0x76>
      if (pid2 == 0) {
    1bd2:	c13d                	beqz	a0,1c38 <twochildren+0x92>
        wait(0);
    1bd4:	4501                	li	a0,0
    1bd6:	00004097          	auipc	ra,0x4
    1bda:	07c080e7          	jalr	124(ra) # 5c52 <wait>
        wait(0);
    1bde:	4501                	li	a0,0
    1be0:	00004097          	auipc	ra,0x4
    1be4:	072080e7          	jalr	114(ra) # 5c52 <wait>
  for (int i = 0; i < 1000; i++) {
    1be8:	34fd                	addiw	s1,s1,-1
    1bea:	f4f9                	bnez	s1,1bb8 <twochildren+0x12>
}
    1bec:	60e2                	ld	ra,24(sp)
    1bee:	6442                	ld	s0,16(sp)
    1bf0:	64a2                	ld	s1,8(sp)
    1bf2:	6902                	ld	s2,0(sp)
    1bf4:	6105                	addi	sp,sp,32
    1bf6:	8082                	ret
      printf("%s: fork failed\n", s);
    1bf8:	85ca                	mv	a1,s2
    1bfa:	00005517          	auipc	a0,0x5
    1bfe:	e6650513          	addi	a0,a0,-410 # 6a60 <malloc+0x9e0>
    1c02:	00004097          	auipc	ra,0x4
    1c06:	3c0080e7          	jalr	960(ra) # 5fc2 <printf>
      exit(1);
    1c0a:	4505                	li	a0,1
    1c0c:	00004097          	auipc	ra,0x4
    1c10:	03e080e7          	jalr	62(ra) # 5c4a <exit>
      exit(0);
    1c14:	00004097          	auipc	ra,0x4
    1c18:	036080e7          	jalr	54(ra) # 5c4a <exit>
        printf("%s: fork failed\n", s);
    1c1c:	85ca                	mv	a1,s2
    1c1e:	00005517          	auipc	a0,0x5
    1c22:	e4250513          	addi	a0,a0,-446 # 6a60 <malloc+0x9e0>
    1c26:	00004097          	auipc	ra,0x4
    1c2a:	39c080e7          	jalr	924(ra) # 5fc2 <printf>
        exit(1);
    1c2e:	4505                	li	a0,1
    1c30:	00004097          	auipc	ra,0x4
    1c34:	01a080e7          	jalr	26(ra) # 5c4a <exit>
        exit(0);
    1c38:	00004097          	auipc	ra,0x4
    1c3c:	012080e7          	jalr	18(ra) # 5c4a <exit>

0000000000001c40 <forkfork>:
void forkfork(char *s) {
    1c40:	7179                	addi	sp,sp,-48
    1c42:	f406                	sd	ra,40(sp)
    1c44:	f022                	sd	s0,32(sp)
    1c46:	ec26                	sd	s1,24(sp)
    1c48:	1800                	addi	s0,sp,48
    1c4a:	84aa                	mv	s1,a0
    int pid = fork();
    1c4c:	00004097          	auipc	ra,0x4
    1c50:	ff6080e7          	jalr	-10(ra) # 5c42 <fork>
    if (pid < 0) {
    1c54:	04054163          	bltz	a0,1c96 <forkfork+0x56>
    if (pid == 0) {
    1c58:	cd29                	beqz	a0,1cb2 <forkfork+0x72>
    int pid = fork();
    1c5a:	00004097          	auipc	ra,0x4
    1c5e:	fe8080e7          	jalr	-24(ra) # 5c42 <fork>
    if (pid < 0) {
    1c62:	02054a63          	bltz	a0,1c96 <forkfork+0x56>
    if (pid == 0) {
    1c66:	c531                	beqz	a0,1cb2 <forkfork+0x72>
    wait(&xstatus);
    1c68:	fdc40513          	addi	a0,s0,-36
    1c6c:	00004097          	auipc	ra,0x4
    1c70:	fe6080e7          	jalr	-26(ra) # 5c52 <wait>
    if (xstatus != 0) {
    1c74:	fdc42783          	lw	a5,-36(s0)
    1c78:	ebbd                	bnez	a5,1cee <forkfork+0xae>
    wait(&xstatus);
    1c7a:	fdc40513          	addi	a0,s0,-36
    1c7e:	00004097          	auipc	ra,0x4
    1c82:	fd4080e7          	jalr	-44(ra) # 5c52 <wait>
    if (xstatus != 0) {
    1c86:	fdc42783          	lw	a5,-36(s0)
    1c8a:	e3b5                	bnez	a5,1cee <forkfork+0xae>
}
    1c8c:	70a2                	ld	ra,40(sp)
    1c8e:	7402                	ld	s0,32(sp)
    1c90:	64e2                	ld	s1,24(sp)
    1c92:	6145                	addi	sp,sp,48
    1c94:	8082                	ret
      printf("%s: fork failed", s);
    1c96:	85a6                	mv	a1,s1
    1c98:	00005517          	auipc	a0,0x5
    1c9c:	f8850513          	addi	a0,a0,-120 # 6c20 <malloc+0xba0>
    1ca0:	00004097          	auipc	ra,0x4
    1ca4:	322080e7          	jalr	802(ra) # 5fc2 <printf>
      exit(1);
    1ca8:	4505                	li	a0,1
    1caa:	00004097          	auipc	ra,0x4
    1cae:	fa0080e7          	jalr	-96(ra) # 5c4a <exit>
void forkfork(char *s) {
    1cb2:	0c800493          	li	s1,200
        int pid1 = fork();
    1cb6:	00004097          	auipc	ra,0x4
    1cba:	f8c080e7          	jalr	-116(ra) # 5c42 <fork>
        if (pid1 < 0) {
    1cbe:	00054f63          	bltz	a0,1cdc <forkfork+0x9c>
        if (pid1 == 0) {
    1cc2:	c115                	beqz	a0,1ce6 <forkfork+0xa6>
        wait(0);
    1cc4:	4501                	li	a0,0
    1cc6:	00004097          	auipc	ra,0x4
    1cca:	f8c080e7          	jalr	-116(ra) # 5c52 <wait>
      for (int j = 0; j < 200; j++) {
    1cce:	34fd                	addiw	s1,s1,-1
    1cd0:	f0fd                	bnez	s1,1cb6 <forkfork+0x76>
      exit(0);
    1cd2:	4501                	li	a0,0
    1cd4:	00004097          	auipc	ra,0x4
    1cd8:	f76080e7          	jalr	-138(ra) # 5c4a <exit>
          exit(1);
    1cdc:	4505                	li	a0,1
    1cde:	00004097          	auipc	ra,0x4
    1ce2:	f6c080e7          	jalr	-148(ra) # 5c4a <exit>
          exit(0);
    1ce6:	00004097          	auipc	ra,0x4
    1cea:	f64080e7          	jalr	-156(ra) # 5c4a <exit>
      printf("%s: fork in child failed", s);
    1cee:	85a6                	mv	a1,s1
    1cf0:	00005517          	auipc	a0,0x5
    1cf4:	f4050513          	addi	a0,a0,-192 # 6c30 <malloc+0xbb0>
    1cf8:	00004097          	auipc	ra,0x4
    1cfc:	2ca080e7          	jalr	714(ra) # 5fc2 <printf>
      exit(1);
    1d00:	4505                	li	a0,1
    1d02:	00004097          	auipc	ra,0x4
    1d06:	f48080e7          	jalr	-184(ra) # 5c4a <exit>

0000000000001d0a <reparent2>:
void reparent2(char *s) {
    1d0a:	1101                	addi	sp,sp,-32
    1d0c:	ec06                	sd	ra,24(sp)
    1d0e:	e822                	sd	s0,16(sp)
    1d10:	e426                	sd	s1,8(sp)
    1d12:	1000                	addi	s0,sp,32
    1d14:	32000493          	li	s1,800
    int pid1 = fork();
    1d18:	00004097          	auipc	ra,0x4
    1d1c:	f2a080e7          	jalr	-214(ra) # 5c42 <fork>
    if (pid1 < 0) {
    1d20:	00054f63          	bltz	a0,1d3e <reparent2+0x34>
    if (pid1 == 0) {
    1d24:	c915                	beqz	a0,1d58 <reparent2+0x4e>
    wait(0);
    1d26:	4501                	li	a0,0
    1d28:	00004097          	auipc	ra,0x4
    1d2c:	f2a080e7          	jalr	-214(ra) # 5c52 <wait>
  for (int i = 0; i < 800; i++) {
    1d30:	34fd                	addiw	s1,s1,-1
    1d32:	f0fd                	bnez	s1,1d18 <reparent2+0xe>
  exit(0);
    1d34:	4501                	li	a0,0
    1d36:	00004097          	auipc	ra,0x4
    1d3a:	f14080e7          	jalr	-236(ra) # 5c4a <exit>
      printf("fork failed\n");
    1d3e:	00005517          	auipc	a0,0x5
    1d42:	12a50513          	addi	a0,a0,298 # 6e68 <malloc+0xde8>
    1d46:	00004097          	auipc	ra,0x4
    1d4a:	27c080e7          	jalr	636(ra) # 5fc2 <printf>
      exit(1);
    1d4e:	4505                	li	a0,1
    1d50:	00004097          	auipc	ra,0x4
    1d54:	efa080e7          	jalr	-262(ra) # 5c4a <exit>
      fork();
    1d58:	00004097          	auipc	ra,0x4
    1d5c:	eea080e7          	jalr	-278(ra) # 5c42 <fork>
      fork();
    1d60:	00004097          	auipc	ra,0x4
    1d64:	ee2080e7          	jalr	-286(ra) # 5c42 <fork>
      exit(0);
    1d68:	4501                	li	a0,0
    1d6a:	00004097          	auipc	ra,0x4
    1d6e:	ee0080e7          	jalr	-288(ra) # 5c4a <exit>

0000000000001d72 <createdelete>:
void createdelete(char *s) {
    1d72:	7175                	addi	sp,sp,-144
    1d74:	e506                	sd	ra,136(sp)
    1d76:	e122                	sd	s0,128(sp)
    1d78:	fca6                	sd	s1,120(sp)
    1d7a:	f8ca                	sd	s2,112(sp)
    1d7c:	f4ce                	sd	s3,104(sp)
    1d7e:	f0d2                	sd	s4,96(sp)
    1d80:	ecd6                	sd	s5,88(sp)
    1d82:	e8da                	sd	s6,80(sp)
    1d84:	e4de                	sd	s7,72(sp)
    1d86:	e0e2                	sd	s8,64(sp)
    1d88:	fc66                	sd	s9,56(sp)
    1d8a:	0900                	addi	s0,sp,144
    1d8c:	8caa                	mv	s9,a0
  for (pi = 0; pi < NCHILD; pi++) {
    1d8e:	4901                	li	s2,0
    1d90:	4991                	li	s3,4
    pid = fork();
    1d92:	00004097          	auipc	ra,0x4
    1d96:	eb0080e7          	jalr	-336(ra) # 5c42 <fork>
    1d9a:	84aa                	mv	s1,a0
    if (pid < 0) {
    1d9c:	02054f63          	bltz	a0,1dda <createdelete+0x68>
    if (pid == 0) {
    1da0:	c939                	beqz	a0,1df6 <createdelete+0x84>
  for (pi = 0; pi < NCHILD; pi++) {
    1da2:	2905                	addiw	s2,s2,1
    1da4:	ff3917e3          	bne	s2,s3,1d92 <createdelete+0x20>
    1da8:	4491                	li	s1,4
    wait(&xstatus);
    1daa:	f7c40513          	addi	a0,s0,-132
    1dae:	00004097          	auipc	ra,0x4
    1db2:	ea4080e7          	jalr	-348(ra) # 5c52 <wait>
    if (xstatus != 0) exit(1);
    1db6:	f7c42903          	lw	s2,-132(s0)
    1dba:	0e091263          	bnez	s2,1e9e <createdelete+0x12c>
  for (pi = 0; pi < NCHILD; pi++) {
    1dbe:	34fd                	addiw	s1,s1,-1
    1dc0:	f4ed                	bnez	s1,1daa <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1dc2:	f8040123          	sb	zero,-126(s0)
    1dc6:	03000993          	li	s3,48
    1dca:	5a7d                	li	s4,-1
    1dcc:	07000c13          	li	s8,112
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    1dd0:	4b21                	li	s6,8
      if ((i == 0 || i >= N / 2) && fd < 0) {
    1dd2:	4ba5                	li	s7,9
    for (pi = 0; pi < NCHILD; pi++) {
    1dd4:	07400a93          	li	s5,116
    1dd8:	a29d                	j	1f3e <createdelete+0x1cc>
      printf("fork failed\n", s);
    1dda:	85e6                	mv	a1,s9
    1ddc:	00005517          	auipc	a0,0x5
    1de0:	08c50513          	addi	a0,a0,140 # 6e68 <malloc+0xde8>
    1de4:	00004097          	auipc	ra,0x4
    1de8:	1de080e7          	jalr	478(ra) # 5fc2 <printf>
      exit(1);
    1dec:	4505                	li	a0,1
    1dee:	00004097          	auipc	ra,0x4
    1df2:	e5c080e7          	jalr	-420(ra) # 5c4a <exit>
      name[0] = 'p' + pi;
    1df6:	0709091b          	addiw	s2,s2,112
    1dfa:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1dfe:	f8040123          	sb	zero,-126(s0)
      for (i = 0; i < N; i++) {
    1e02:	4951                	li	s2,20
    1e04:	a015                	j	1e28 <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1e06:	85e6                	mv	a1,s9
    1e08:	00005517          	auipc	a0,0x5
    1e0c:	cf050513          	addi	a0,a0,-784 # 6af8 <malloc+0xa78>
    1e10:	00004097          	auipc	ra,0x4
    1e14:	1b2080e7          	jalr	434(ra) # 5fc2 <printf>
          exit(1);
    1e18:	4505                	li	a0,1
    1e1a:	00004097          	auipc	ra,0x4
    1e1e:	e30080e7          	jalr	-464(ra) # 5c4a <exit>
      for (i = 0; i < N; i++) {
    1e22:	2485                	addiw	s1,s1,1
    1e24:	07248863          	beq	s1,s2,1e94 <createdelete+0x122>
        name[1] = '0' + i;
    1e28:	0304879b          	addiw	a5,s1,48
    1e2c:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1e30:	20200593          	li	a1,514
    1e34:	f8040513          	addi	a0,s0,-128
    1e38:	00004097          	auipc	ra,0x4
    1e3c:	e52080e7          	jalr	-430(ra) # 5c8a <open>
        if (fd < 0) {
    1e40:	fc0543e3          	bltz	a0,1e06 <createdelete+0x94>
        close(fd);
    1e44:	00004097          	auipc	ra,0x4
    1e48:	e2e080e7          	jalr	-466(ra) # 5c72 <close>
        if (i > 0 && (i % 2) == 0) {
    1e4c:	fc905be3          	blez	s1,1e22 <createdelete+0xb0>
    1e50:	0014f793          	andi	a5,s1,1
    1e54:	f7f9                	bnez	a5,1e22 <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1e56:	01f4d79b          	srliw	a5,s1,0x1f
    1e5a:	9fa5                	addw	a5,a5,s1
    1e5c:	4017d79b          	sraiw	a5,a5,0x1
    1e60:	0307879b          	addiw	a5,a5,48
    1e64:	f8f400a3          	sb	a5,-127(s0)
          if (unlink(name) < 0) {
    1e68:	f8040513          	addi	a0,s0,-128
    1e6c:	00004097          	auipc	ra,0x4
    1e70:	e2e080e7          	jalr	-466(ra) # 5c9a <unlink>
    1e74:	fa0557e3          	bgez	a0,1e22 <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1e78:	85e6                	mv	a1,s9
    1e7a:	00005517          	auipc	a0,0x5
    1e7e:	dd650513          	addi	a0,a0,-554 # 6c50 <malloc+0xbd0>
    1e82:	00004097          	auipc	ra,0x4
    1e86:	140080e7          	jalr	320(ra) # 5fc2 <printf>
            exit(1);
    1e8a:	4505                	li	a0,1
    1e8c:	00004097          	auipc	ra,0x4
    1e90:	dbe080e7          	jalr	-578(ra) # 5c4a <exit>
      exit(0);
    1e94:	4501                	li	a0,0
    1e96:	00004097          	auipc	ra,0x4
    1e9a:	db4080e7          	jalr	-588(ra) # 5c4a <exit>
    if (xstatus != 0) exit(1);
    1e9e:	4505                	li	a0,1
    1ea0:	00004097          	auipc	ra,0x4
    1ea4:	daa080e7          	jalr	-598(ra) # 5c4a <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1ea8:	f8040613          	addi	a2,s0,-128
    1eac:	85e6                	mv	a1,s9
    1eae:	00005517          	auipc	a0,0x5
    1eb2:	dba50513          	addi	a0,a0,-582 # 6c68 <malloc+0xbe8>
    1eb6:	00004097          	auipc	ra,0x4
    1eba:	10c080e7          	jalr	268(ra) # 5fc2 <printf>
        exit(1);
    1ebe:	4505                	li	a0,1
    1ec0:	00004097          	auipc	ra,0x4
    1ec4:	d8a080e7          	jalr	-630(ra) # 5c4a <exit>
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    1ec8:	054b7163          	bgeu	s6,s4,1f0a <createdelete+0x198>
      if (fd >= 0) close(fd);
    1ecc:	02055a63          	bgez	a0,1f00 <createdelete+0x18e>
    for (pi = 0; pi < NCHILD; pi++) {
    1ed0:	2485                	addiw	s1,s1,1
    1ed2:	0ff4f493          	andi	s1,s1,255
    1ed6:	05548c63          	beq	s1,s5,1f2e <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1eda:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1ede:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1ee2:	4581                	li	a1,0
    1ee4:	f8040513          	addi	a0,s0,-128
    1ee8:	00004097          	auipc	ra,0x4
    1eec:	da2080e7          	jalr	-606(ra) # 5c8a <open>
      if ((i == 0 || i >= N / 2) && fd < 0) {
    1ef0:	00090463          	beqz	s2,1ef8 <createdelete+0x186>
    1ef4:	fd2bdae3          	bge	s7,s2,1ec8 <createdelete+0x156>
    1ef8:	fa0548e3          	bltz	a0,1ea8 <createdelete+0x136>
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    1efc:	014b7963          	bgeu	s6,s4,1f0e <createdelete+0x19c>
      if (fd >= 0) close(fd);
    1f00:	00004097          	auipc	ra,0x4
    1f04:	d72080e7          	jalr	-654(ra) # 5c72 <close>
    1f08:	b7e1                	j	1ed0 <createdelete+0x15e>
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    1f0a:	fc0543e3          	bltz	a0,1ed0 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1f0e:	f8040613          	addi	a2,s0,-128
    1f12:	85e6                	mv	a1,s9
    1f14:	00005517          	auipc	a0,0x5
    1f18:	d7c50513          	addi	a0,a0,-644 # 6c90 <malloc+0xc10>
    1f1c:	00004097          	auipc	ra,0x4
    1f20:	0a6080e7          	jalr	166(ra) # 5fc2 <printf>
        exit(1);
    1f24:	4505                	li	a0,1
    1f26:	00004097          	auipc	ra,0x4
    1f2a:	d24080e7          	jalr	-732(ra) # 5c4a <exit>
  for (i = 0; i < N; i++) {
    1f2e:	2905                	addiw	s2,s2,1
    1f30:	2a05                	addiw	s4,s4,1
    1f32:	2985                	addiw	s3,s3,1
    1f34:	0ff9f993          	andi	s3,s3,255
    1f38:	47d1                	li	a5,20
    1f3a:	02f90a63          	beq	s2,a5,1f6e <createdelete+0x1fc>
    for (pi = 0; pi < NCHILD; pi++) {
    1f3e:	84e2                	mv	s1,s8
    1f40:	bf69                	j	1eda <createdelete+0x168>
  for (i = 0; i < N; i++) {
    1f42:	2905                	addiw	s2,s2,1
    1f44:	0ff97913          	andi	s2,s2,255
    1f48:	2985                	addiw	s3,s3,1
    1f4a:	0ff9f993          	andi	s3,s3,255
    1f4e:	03490863          	beq	s2,s4,1f7e <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1f52:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1f54:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1f58:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1f5c:	f8040513          	addi	a0,s0,-128
    1f60:	00004097          	auipc	ra,0x4
    1f64:	d3a080e7          	jalr	-710(ra) # 5c9a <unlink>
    for (pi = 0; pi < NCHILD; pi++) {
    1f68:	34fd                	addiw	s1,s1,-1
    1f6a:	f4ed                	bnez	s1,1f54 <createdelete+0x1e2>
    1f6c:	bfd9                	j	1f42 <createdelete+0x1d0>
    1f6e:	03000993          	li	s3,48
    1f72:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1f76:	4a91                	li	s5,4
  for (i = 0; i < N; i++) {
    1f78:	08400a13          	li	s4,132
    1f7c:	bfd9                	j	1f52 <createdelete+0x1e0>
}
    1f7e:	60aa                	ld	ra,136(sp)
    1f80:	640a                	ld	s0,128(sp)
    1f82:	74e6                	ld	s1,120(sp)
    1f84:	7946                	ld	s2,112(sp)
    1f86:	79a6                	ld	s3,104(sp)
    1f88:	7a06                	ld	s4,96(sp)
    1f8a:	6ae6                	ld	s5,88(sp)
    1f8c:	6b46                	ld	s6,80(sp)
    1f8e:	6ba6                	ld	s7,72(sp)
    1f90:	6c06                	ld	s8,64(sp)
    1f92:	7ce2                	ld	s9,56(sp)
    1f94:	6149                	addi	sp,sp,144
    1f96:	8082                	ret

0000000000001f98 <linkunlink>:
void linkunlink(char *s) {
    1f98:	711d                	addi	sp,sp,-96
    1f9a:	ec86                	sd	ra,88(sp)
    1f9c:	e8a2                	sd	s0,80(sp)
    1f9e:	e4a6                	sd	s1,72(sp)
    1fa0:	e0ca                	sd	s2,64(sp)
    1fa2:	fc4e                	sd	s3,56(sp)
    1fa4:	f852                	sd	s4,48(sp)
    1fa6:	f456                	sd	s5,40(sp)
    1fa8:	f05a                	sd	s6,32(sp)
    1faa:	ec5e                	sd	s7,24(sp)
    1fac:	e862                	sd	s8,16(sp)
    1fae:	e466                	sd	s9,8(sp)
    1fb0:	1080                	addi	s0,sp,96
    1fb2:	84aa                	mv	s1,a0
  unlink("x");
    1fb4:	00004517          	auipc	a0,0x4
    1fb8:	28450513          	addi	a0,a0,644 # 6238 <malloc+0x1b8>
    1fbc:	00004097          	auipc	ra,0x4
    1fc0:	cde080e7          	jalr	-802(ra) # 5c9a <unlink>
  pid = fork();
    1fc4:	00004097          	auipc	ra,0x4
    1fc8:	c7e080e7          	jalr	-898(ra) # 5c42 <fork>
  if (pid < 0) {
    1fcc:	02054b63          	bltz	a0,2002 <linkunlink+0x6a>
    1fd0:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1fd2:	4c85                	li	s9,1
    1fd4:	e119                	bnez	a0,1fda <linkunlink+0x42>
    1fd6:	06100c93          	li	s9,97
    1fda:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1fde:	41c659b7          	lui	s3,0x41c65
    1fe2:	e6d9899b          	addiw	s3,s3,-403
    1fe6:	690d                	lui	s2,0x3
    1fe8:	0399091b          	addiw	s2,s2,57
    if ((x % 3) == 0) {
    1fec:	4a0d                	li	s4,3
    } else if ((x % 3) == 1) {
    1fee:	4b05                	li	s6,1
      unlink("x");
    1ff0:	00004a97          	auipc	s5,0x4
    1ff4:	248a8a93          	addi	s5,s5,584 # 6238 <malloc+0x1b8>
      link("cat", "x");
    1ff8:	00005b97          	auipc	s7,0x5
    1ffc:	cc0b8b93          	addi	s7,s7,-832 # 6cb8 <malloc+0xc38>
    2000:	a825                	j	2038 <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    2002:	85a6                	mv	a1,s1
    2004:	00005517          	auipc	a0,0x5
    2008:	a5c50513          	addi	a0,a0,-1444 # 6a60 <malloc+0x9e0>
    200c:	00004097          	auipc	ra,0x4
    2010:	fb6080e7          	jalr	-74(ra) # 5fc2 <printf>
    exit(1);
    2014:	4505                	li	a0,1
    2016:	00004097          	auipc	ra,0x4
    201a:	c34080e7          	jalr	-972(ra) # 5c4a <exit>
      close(open("x", O_RDWR | O_CREATE));
    201e:	20200593          	li	a1,514
    2022:	8556                	mv	a0,s5
    2024:	00004097          	auipc	ra,0x4
    2028:	c66080e7          	jalr	-922(ra) # 5c8a <open>
    202c:	00004097          	auipc	ra,0x4
    2030:	c46080e7          	jalr	-954(ra) # 5c72 <close>
  for (i = 0; i < 100; i++) {
    2034:	34fd                	addiw	s1,s1,-1
    2036:	c88d                	beqz	s1,2068 <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    2038:	033c87bb          	mulw	a5,s9,s3
    203c:	012787bb          	addw	a5,a5,s2
    2040:	00078c9b          	sext.w	s9,a5
    if ((x % 3) == 0) {
    2044:	0347f7bb          	remuw	a5,a5,s4
    2048:	dbf9                	beqz	a5,201e <linkunlink+0x86>
    } else if ((x % 3) == 1) {
    204a:	01678863          	beq	a5,s6,205a <linkunlink+0xc2>
      unlink("x");
    204e:	8556                	mv	a0,s5
    2050:	00004097          	auipc	ra,0x4
    2054:	c4a080e7          	jalr	-950(ra) # 5c9a <unlink>
    2058:	bff1                	j	2034 <linkunlink+0x9c>
      link("cat", "x");
    205a:	85d6                	mv	a1,s5
    205c:	855e                	mv	a0,s7
    205e:	00004097          	auipc	ra,0x4
    2062:	c4c080e7          	jalr	-948(ra) # 5caa <link>
    2066:	b7f9                	j	2034 <linkunlink+0x9c>
  if (pid)
    2068:	020c0463          	beqz	s8,2090 <linkunlink+0xf8>
    wait(0);
    206c:	4501                	li	a0,0
    206e:	00004097          	auipc	ra,0x4
    2072:	be4080e7          	jalr	-1052(ra) # 5c52 <wait>
}
    2076:	60e6                	ld	ra,88(sp)
    2078:	6446                	ld	s0,80(sp)
    207a:	64a6                	ld	s1,72(sp)
    207c:	6906                	ld	s2,64(sp)
    207e:	79e2                	ld	s3,56(sp)
    2080:	7a42                	ld	s4,48(sp)
    2082:	7aa2                	ld	s5,40(sp)
    2084:	7b02                	ld	s6,32(sp)
    2086:	6be2                	ld	s7,24(sp)
    2088:	6c42                	ld	s8,16(sp)
    208a:	6ca2                	ld	s9,8(sp)
    208c:	6125                	addi	sp,sp,96
    208e:	8082                	ret
    exit(0);
    2090:	4501                	li	a0,0
    2092:	00004097          	auipc	ra,0x4
    2096:	bb8080e7          	jalr	-1096(ra) # 5c4a <exit>

000000000000209a <forktest>:
void forktest(char *s) {
    209a:	7179                	addi	sp,sp,-48
    209c:	f406                	sd	ra,40(sp)
    209e:	f022                	sd	s0,32(sp)
    20a0:	ec26                	sd	s1,24(sp)
    20a2:	e84a                	sd	s2,16(sp)
    20a4:	e44e                	sd	s3,8(sp)
    20a6:	1800                	addi	s0,sp,48
    20a8:	89aa                	mv	s3,a0
  for (n = 0; n < N; n++) {
    20aa:	4481                	li	s1,0
    20ac:	5dc00913          	li	s2,1500
    pid = fork();
    20b0:	00004097          	auipc	ra,0x4
    20b4:	b92080e7          	jalr	-1134(ra) # 5c42 <fork>
    if (pid < 0) break;
    20b8:	02054863          	bltz	a0,20e8 <forktest+0x4e>
    if (pid == 0) exit(0);
    20bc:	c115                	beqz	a0,20e0 <forktest+0x46>
  for (n = 0; n < N; n++) {
    20be:	2485                	addiw	s1,s1,1
    20c0:	ff2498e3          	bne	s1,s2,20b0 <forktest+0x16>
    printf("%s: fork claimed to work 1500 times!\n", s);
    20c4:	85ce                	mv	a1,s3
    20c6:	00005517          	auipc	a0,0x5
    20ca:	c1250513          	addi	a0,a0,-1006 # 6cd8 <malloc+0xc58>
    20ce:	00004097          	auipc	ra,0x4
    20d2:	ef4080e7          	jalr	-268(ra) # 5fc2 <printf>
    exit(1);
    20d6:	4505                	li	a0,1
    20d8:	00004097          	auipc	ra,0x4
    20dc:	b72080e7          	jalr	-1166(ra) # 5c4a <exit>
    if (pid == 0) exit(0);
    20e0:	00004097          	auipc	ra,0x4
    20e4:	b6a080e7          	jalr	-1174(ra) # 5c4a <exit>
  if (n == 0) {
    20e8:	cc9d                	beqz	s1,2126 <forktest+0x8c>
  if (n == N) {
    20ea:	5dc00793          	li	a5,1500
    20ee:	fcf48be3          	beq	s1,a5,20c4 <forktest+0x2a>
  for (; n > 0; n--) {
    20f2:	00905b63          	blez	s1,2108 <forktest+0x6e>
    if (wait(0) < 0) {
    20f6:	4501                	li	a0,0
    20f8:	00004097          	auipc	ra,0x4
    20fc:	b5a080e7          	jalr	-1190(ra) # 5c52 <wait>
    2100:	04054163          	bltz	a0,2142 <forktest+0xa8>
  for (; n > 0; n--) {
    2104:	34fd                	addiw	s1,s1,-1
    2106:	f8e5                	bnez	s1,20f6 <forktest+0x5c>
  if (wait(0) != -1) {
    2108:	4501                	li	a0,0
    210a:	00004097          	auipc	ra,0x4
    210e:	b48080e7          	jalr	-1208(ra) # 5c52 <wait>
    2112:	57fd                	li	a5,-1
    2114:	04f51563          	bne	a0,a5,215e <forktest+0xc4>
}
    2118:	70a2                	ld	ra,40(sp)
    211a:	7402                	ld	s0,32(sp)
    211c:	64e2                	ld	s1,24(sp)
    211e:	6942                	ld	s2,16(sp)
    2120:	69a2                	ld	s3,8(sp)
    2122:	6145                	addi	sp,sp,48
    2124:	8082                	ret
    printf("%s: no fork at all!\n", s);
    2126:	85ce                	mv	a1,s3
    2128:	00005517          	auipc	a0,0x5
    212c:	b9850513          	addi	a0,a0,-1128 # 6cc0 <malloc+0xc40>
    2130:	00004097          	auipc	ra,0x4
    2134:	e92080e7          	jalr	-366(ra) # 5fc2 <printf>
    exit(1);
    2138:	4505                	li	a0,1
    213a:	00004097          	auipc	ra,0x4
    213e:	b10080e7          	jalr	-1264(ra) # 5c4a <exit>
      printf("%s: wait stopped early\n", s);
    2142:	85ce                	mv	a1,s3
    2144:	00005517          	auipc	a0,0x5
    2148:	bbc50513          	addi	a0,a0,-1092 # 6d00 <malloc+0xc80>
    214c:	00004097          	auipc	ra,0x4
    2150:	e76080e7          	jalr	-394(ra) # 5fc2 <printf>
      exit(1);
    2154:	4505                	li	a0,1
    2156:	00004097          	auipc	ra,0x4
    215a:	af4080e7          	jalr	-1292(ra) # 5c4a <exit>
    printf("%s: wait got too many\n", s);
    215e:	85ce                	mv	a1,s3
    2160:	00005517          	auipc	a0,0x5
    2164:	bb850513          	addi	a0,a0,-1096 # 6d18 <malloc+0xc98>
    2168:	00004097          	auipc	ra,0x4
    216c:	e5a080e7          	jalr	-422(ra) # 5fc2 <printf>
    exit(1);
    2170:	4505                	li	a0,1
    2172:	00004097          	auipc	ra,0x4
    2176:	ad8080e7          	jalr	-1320(ra) # 5c4a <exit>

000000000000217a <kernmem>:
void kernmem(char *s) {
    217a:	715d                	addi	sp,sp,-80
    217c:	e486                	sd	ra,72(sp)
    217e:	e0a2                	sd	s0,64(sp)
    2180:	fc26                	sd	s1,56(sp)
    2182:	f84a                	sd	s2,48(sp)
    2184:	f44e                	sd	s3,40(sp)
    2186:	f052                	sd	s4,32(sp)
    2188:	ec56                	sd	s5,24(sp)
    218a:	0880                	addi	s0,sp,80
    218c:	8a2a                	mv	s4,a0
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    218e:	4485                	li	s1,1
    2190:	04fe                	slli	s1,s1,0x1f
    if (xstatus != -1)  // did kernel kill child?
    2192:	5afd                	li	s5,-1
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    2194:	69b1                	lui	s3,0xc
    2196:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    219a:	1003d937          	lui	s2,0x1003d
    219e:	090e                	slli	s2,s2,0x3
    21a0:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    21a4:	00004097          	auipc	ra,0x4
    21a8:	a9e080e7          	jalr	-1378(ra) # 5c42 <fork>
    if (pid < 0) {
    21ac:	02054963          	bltz	a0,21de <kernmem+0x64>
    if (pid == 0) {
    21b0:	c529                	beqz	a0,21fa <kernmem+0x80>
    wait(&xstatus);
    21b2:	fbc40513          	addi	a0,s0,-68
    21b6:	00004097          	auipc	ra,0x4
    21ba:	a9c080e7          	jalr	-1380(ra) # 5c52 <wait>
    if (xstatus != -1)  // did kernel kill child?
    21be:	fbc42783          	lw	a5,-68(s0)
    21c2:	05579d63          	bne	a5,s5,221c <kernmem+0xa2>
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    21c6:	94ce                	add	s1,s1,s3
    21c8:	fd249ee3          	bne	s1,s2,21a4 <kernmem+0x2a>
}
    21cc:	60a6                	ld	ra,72(sp)
    21ce:	6406                	ld	s0,64(sp)
    21d0:	74e2                	ld	s1,56(sp)
    21d2:	7942                	ld	s2,48(sp)
    21d4:	79a2                	ld	s3,40(sp)
    21d6:	7a02                	ld	s4,32(sp)
    21d8:	6ae2                	ld	s5,24(sp)
    21da:	6161                	addi	sp,sp,80
    21dc:	8082                	ret
      printf("%s: fork failed\n", s);
    21de:	85d2                	mv	a1,s4
    21e0:	00005517          	auipc	a0,0x5
    21e4:	88050513          	addi	a0,a0,-1920 # 6a60 <malloc+0x9e0>
    21e8:	00004097          	auipc	ra,0x4
    21ec:	dda080e7          	jalr	-550(ra) # 5fc2 <printf>
      exit(1);
    21f0:	4505                	li	a0,1
    21f2:	00004097          	auipc	ra,0x4
    21f6:	a58080e7          	jalr	-1448(ra) # 5c4a <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    21fa:	0004c683          	lbu	a3,0(s1)
    21fe:	8626                	mv	a2,s1
    2200:	85d2                	mv	a1,s4
    2202:	00005517          	auipc	a0,0x5
    2206:	b2e50513          	addi	a0,a0,-1234 # 6d30 <malloc+0xcb0>
    220a:	00004097          	auipc	ra,0x4
    220e:	db8080e7          	jalr	-584(ra) # 5fc2 <printf>
      exit(1);
    2212:	4505                	li	a0,1
    2214:	00004097          	auipc	ra,0x4
    2218:	a36080e7          	jalr	-1482(ra) # 5c4a <exit>
      exit(1);
    221c:	4505                	li	a0,1
    221e:	00004097          	auipc	ra,0x4
    2222:	a2c080e7          	jalr	-1492(ra) # 5c4a <exit>

0000000000002226 <MAXVAplus>:
void MAXVAplus(char *s) {
    2226:	7179                	addi	sp,sp,-48
    2228:	f406                	sd	ra,40(sp)
    222a:	f022                	sd	s0,32(sp)
    222c:	ec26                	sd	s1,24(sp)
    222e:	e84a                	sd	s2,16(sp)
    2230:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    2232:	4785                	li	a5,1
    2234:	179a                	slli	a5,a5,0x26
    2236:	fcf43c23          	sd	a5,-40(s0)
  for (; a != 0; a <<= 1) {
    223a:	fd843783          	ld	a5,-40(s0)
    223e:	cf85                	beqz	a5,2276 <MAXVAplus+0x50>
    2240:	892a                	mv	s2,a0
    if (xstatus != -1)  // did kernel kill child?
    2242:	54fd                	li	s1,-1
    pid = fork();
    2244:	00004097          	auipc	ra,0x4
    2248:	9fe080e7          	jalr	-1538(ra) # 5c42 <fork>
    if (pid < 0) {
    224c:	02054b63          	bltz	a0,2282 <MAXVAplus+0x5c>
    if (pid == 0) {
    2250:	c539                	beqz	a0,229e <MAXVAplus+0x78>
    wait(&xstatus);
    2252:	fd440513          	addi	a0,s0,-44
    2256:	00004097          	auipc	ra,0x4
    225a:	9fc080e7          	jalr	-1540(ra) # 5c52 <wait>
    if (xstatus != -1)  // did kernel kill child?
    225e:	fd442783          	lw	a5,-44(s0)
    2262:	06979463          	bne	a5,s1,22ca <MAXVAplus+0xa4>
  for (; a != 0; a <<= 1) {
    2266:	fd843783          	ld	a5,-40(s0)
    226a:	0786                	slli	a5,a5,0x1
    226c:	fcf43c23          	sd	a5,-40(s0)
    2270:	fd843783          	ld	a5,-40(s0)
    2274:	fbe1                	bnez	a5,2244 <MAXVAplus+0x1e>
}
    2276:	70a2                	ld	ra,40(sp)
    2278:	7402                	ld	s0,32(sp)
    227a:	64e2                	ld	s1,24(sp)
    227c:	6942                	ld	s2,16(sp)
    227e:	6145                	addi	sp,sp,48
    2280:	8082                	ret
      printf("%s: fork failed\n", s);
    2282:	85ca                	mv	a1,s2
    2284:	00004517          	auipc	a0,0x4
    2288:	7dc50513          	addi	a0,a0,2012 # 6a60 <malloc+0x9e0>
    228c:	00004097          	auipc	ra,0x4
    2290:	d36080e7          	jalr	-714(ra) # 5fc2 <printf>
      exit(1);
    2294:	4505                	li	a0,1
    2296:	00004097          	auipc	ra,0x4
    229a:	9b4080e7          	jalr	-1612(ra) # 5c4a <exit>
      *(char *)a = 99;
    229e:	fd843783          	ld	a5,-40(s0)
    22a2:	06300713          	li	a4,99
    22a6:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    22aa:	fd843603          	ld	a2,-40(s0)
    22ae:	85ca                	mv	a1,s2
    22b0:	00005517          	auipc	a0,0x5
    22b4:	aa050513          	addi	a0,a0,-1376 # 6d50 <malloc+0xcd0>
    22b8:	00004097          	auipc	ra,0x4
    22bc:	d0a080e7          	jalr	-758(ra) # 5fc2 <printf>
      exit(1);
    22c0:	4505                	li	a0,1
    22c2:	00004097          	auipc	ra,0x4
    22c6:	988080e7          	jalr	-1656(ra) # 5c4a <exit>
      exit(1);
    22ca:	4505                	li	a0,1
    22cc:	00004097          	auipc	ra,0x4
    22d0:	97e080e7          	jalr	-1666(ra) # 5c4a <exit>

00000000000022d4 <bigargtest>:
void bigargtest(char *s) {
    22d4:	7179                	addi	sp,sp,-48
    22d6:	f406                	sd	ra,40(sp)
    22d8:	f022                	sd	s0,32(sp)
    22da:	ec26                	sd	s1,24(sp)
    22dc:	1800                	addi	s0,sp,48
    22de:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    22e0:	00005517          	auipc	a0,0x5
    22e4:	a8850513          	addi	a0,a0,-1400 # 6d68 <malloc+0xce8>
    22e8:	00004097          	auipc	ra,0x4
    22ec:	9b2080e7          	jalr	-1614(ra) # 5c9a <unlink>
  pid = fork();
    22f0:	00004097          	auipc	ra,0x4
    22f4:	952080e7          	jalr	-1710(ra) # 5c42 <fork>
  if (pid == 0) {
    22f8:	c121                	beqz	a0,2338 <bigargtest+0x64>
  } else if (pid < 0) {
    22fa:	0a054063          	bltz	a0,239a <bigargtest+0xc6>
  wait(&xstatus);
    22fe:	fdc40513          	addi	a0,s0,-36
    2302:	00004097          	auipc	ra,0x4
    2306:	950080e7          	jalr	-1712(ra) # 5c52 <wait>
  if (xstatus != 0) exit(xstatus);
    230a:	fdc42503          	lw	a0,-36(s0)
    230e:	e545                	bnez	a0,23b6 <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    2310:	4581                	li	a1,0
    2312:	00005517          	auipc	a0,0x5
    2316:	a5650513          	addi	a0,a0,-1450 # 6d68 <malloc+0xce8>
    231a:	00004097          	auipc	ra,0x4
    231e:	970080e7          	jalr	-1680(ra) # 5c8a <open>
  if (fd < 0) {
    2322:	08054e63          	bltz	a0,23be <bigargtest+0xea>
  close(fd);
    2326:	00004097          	auipc	ra,0x4
    232a:	94c080e7          	jalr	-1716(ra) # 5c72 <close>
}
    232e:	70a2                	ld	ra,40(sp)
    2330:	7402                	ld	s0,32(sp)
    2332:	64e2                	ld	s1,24(sp)
    2334:	6145                	addi	sp,sp,48
    2336:	8082                	ret
    2338:	00007797          	auipc	a5,0x7
    233c:	12878793          	addi	a5,a5,296 # 9460 <args.1>
    2340:	00007697          	auipc	a3,0x7
    2344:	21868693          	addi	a3,a3,536 # 9558 <args.1+0xf8>
      args[i] =
    2348:	00005717          	auipc	a4,0x5
    234c:	a3070713          	addi	a4,a4,-1488 # 6d78 <malloc+0xcf8>
    2350:	e398                	sd	a4,0(a5)
    for (i = 0; i < MAXARG - 1; i++)
    2352:	07a1                	addi	a5,a5,8
    2354:	fed79ee3          	bne	a5,a3,2350 <bigargtest+0x7c>
    args[MAXARG - 1] = 0;
    2358:	00007597          	auipc	a1,0x7
    235c:	10858593          	addi	a1,a1,264 # 9460 <args.1>
    2360:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    2364:	00004517          	auipc	a0,0x4
    2368:	e6450513          	addi	a0,a0,-412 # 61c8 <malloc+0x148>
    236c:	00004097          	auipc	ra,0x4
    2370:	916080e7          	jalr	-1770(ra) # 5c82 <exec>
    fd = open("bigarg-ok", O_CREATE);
    2374:	20000593          	li	a1,512
    2378:	00005517          	auipc	a0,0x5
    237c:	9f050513          	addi	a0,a0,-1552 # 6d68 <malloc+0xce8>
    2380:	00004097          	auipc	ra,0x4
    2384:	90a080e7          	jalr	-1782(ra) # 5c8a <open>
    close(fd);
    2388:	00004097          	auipc	ra,0x4
    238c:	8ea080e7          	jalr	-1814(ra) # 5c72 <close>
    exit(0);
    2390:	4501                	li	a0,0
    2392:	00004097          	auipc	ra,0x4
    2396:	8b8080e7          	jalr	-1864(ra) # 5c4a <exit>
    printf("%s: bigargtest: fork failed\n", s);
    239a:	85a6                	mv	a1,s1
    239c:	00005517          	auipc	a0,0x5
    23a0:	abc50513          	addi	a0,a0,-1348 # 6e58 <malloc+0xdd8>
    23a4:	00004097          	auipc	ra,0x4
    23a8:	c1e080e7          	jalr	-994(ra) # 5fc2 <printf>
    exit(1);
    23ac:	4505                	li	a0,1
    23ae:	00004097          	auipc	ra,0x4
    23b2:	89c080e7          	jalr	-1892(ra) # 5c4a <exit>
  if (xstatus != 0) exit(xstatus);
    23b6:	00004097          	auipc	ra,0x4
    23ba:	894080e7          	jalr	-1900(ra) # 5c4a <exit>
    printf("%s: bigarg test failed!\n", s);
    23be:	85a6                	mv	a1,s1
    23c0:	00005517          	auipc	a0,0x5
    23c4:	ab850513          	addi	a0,a0,-1352 # 6e78 <malloc+0xdf8>
    23c8:	00004097          	auipc	ra,0x4
    23cc:	bfa080e7          	jalr	-1030(ra) # 5fc2 <printf>
    exit(1);
    23d0:	4505                	li	a0,1
    23d2:	00004097          	auipc	ra,0x4
    23d6:	878080e7          	jalr	-1928(ra) # 5c4a <exit>

00000000000023da <stacktest>:
void stacktest(char *s) {
    23da:	7179                	addi	sp,sp,-48
    23dc:	f406                	sd	ra,40(sp)
    23de:	f022                	sd	s0,32(sp)
    23e0:	ec26                	sd	s1,24(sp)
    23e2:	1800                	addi	s0,sp,48
    23e4:	84aa                	mv	s1,a0
  pid = fork();
    23e6:	00004097          	auipc	ra,0x4
    23ea:	85c080e7          	jalr	-1956(ra) # 5c42 <fork>
  if (pid == 0) {
    23ee:	c115                	beqz	a0,2412 <stacktest+0x38>
  } else if (pid < 0) {
    23f0:	04054463          	bltz	a0,2438 <stacktest+0x5e>
  wait(&xstatus);
    23f4:	fdc40513          	addi	a0,s0,-36
    23f8:	00004097          	auipc	ra,0x4
    23fc:	85a080e7          	jalr	-1958(ra) # 5c52 <wait>
  if (xstatus == -1)  // kernel killed child?
    2400:	fdc42503          	lw	a0,-36(s0)
    2404:	57fd                	li	a5,-1
    2406:	04f50763          	beq	a0,a5,2454 <stacktest+0x7a>
    exit(xstatus);
    240a:	00004097          	auipc	ra,0x4
    240e:	840080e7          	jalr	-1984(ra) # 5c4a <exit>
  return (x & SSTATUS_SIE) != 0;
}

static inline uint64 r_sp() {
  uint64 x;
  asm volatile("mv %0, sp" : "=r"(x));
    2412:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2414:	77fd                	lui	a5,0xfffff
    2416:	97ba                	add	a5,a5,a4
    2418:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    241c:	85a6                	mv	a1,s1
    241e:	00005517          	auipc	a0,0x5
    2422:	a7a50513          	addi	a0,a0,-1414 # 6e98 <malloc+0xe18>
    2426:	00004097          	auipc	ra,0x4
    242a:	b9c080e7          	jalr	-1124(ra) # 5fc2 <printf>
    exit(1);
    242e:	4505                	li	a0,1
    2430:	00004097          	auipc	ra,0x4
    2434:	81a080e7          	jalr	-2022(ra) # 5c4a <exit>
    printf("%s: fork failed\n", s);
    2438:	85a6                	mv	a1,s1
    243a:	00004517          	auipc	a0,0x4
    243e:	62650513          	addi	a0,a0,1574 # 6a60 <malloc+0x9e0>
    2442:	00004097          	auipc	ra,0x4
    2446:	b80080e7          	jalr	-1152(ra) # 5fc2 <printf>
    exit(1);
    244a:	4505                	li	a0,1
    244c:	00003097          	auipc	ra,0x3
    2450:	7fe080e7          	jalr	2046(ra) # 5c4a <exit>
    exit(0);
    2454:	4501                	li	a0,0
    2456:	00003097          	auipc	ra,0x3
    245a:	7f4080e7          	jalr	2036(ra) # 5c4a <exit>

000000000000245e <textwrite>:
void textwrite(char *s) {
    245e:	7179                	addi	sp,sp,-48
    2460:	f406                	sd	ra,40(sp)
    2462:	f022                	sd	s0,32(sp)
    2464:	ec26                	sd	s1,24(sp)
    2466:	1800                	addi	s0,sp,48
    2468:	84aa                	mv	s1,a0
  pid = fork();
    246a:	00003097          	auipc	ra,0x3
    246e:	7d8080e7          	jalr	2008(ra) # 5c42 <fork>
  if (pid == 0) {
    2472:	c115                	beqz	a0,2496 <textwrite+0x38>
  } else if (pid < 0) {
    2474:	02054963          	bltz	a0,24a6 <textwrite+0x48>
  wait(&xstatus);
    2478:	fdc40513          	addi	a0,s0,-36
    247c:	00003097          	auipc	ra,0x3
    2480:	7d6080e7          	jalr	2006(ra) # 5c52 <wait>
  if (xstatus == -1)  // kernel killed child?
    2484:	fdc42503          	lw	a0,-36(s0)
    2488:	57fd                	li	a5,-1
    248a:	02f50c63          	beq	a0,a5,24c2 <textwrite+0x64>
    exit(xstatus);
    248e:	00003097          	auipc	ra,0x3
    2492:	7bc080e7          	jalr	1980(ra) # 5c4a <exit>
    *addr = 10;
    2496:	47a9                	li	a5,10
    2498:	00f02023          	sw	a5,0(zero) # 0 <copyinstr1>
    exit(1);
    249c:	4505                	li	a0,1
    249e:	00003097          	auipc	ra,0x3
    24a2:	7ac080e7          	jalr	1964(ra) # 5c4a <exit>
    printf("%s: fork failed\n", s);
    24a6:	85a6                	mv	a1,s1
    24a8:	00004517          	auipc	a0,0x4
    24ac:	5b850513          	addi	a0,a0,1464 # 6a60 <malloc+0x9e0>
    24b0:	00004097          	auipc	ra,0x4
    24b4:	b12080e7          	jalr	-1262(ra) # 5fc2 <printf>
    exit(1);
    24b8:	4505                	li	a0,1
    24ba:	00003097          	auipc	ra,0x3
    24be:	790080e7          	jalr	1936(ra) # 5c4a <exit>
    exit(0);
    24c2:	4501                	li	a0,0
    24c4:	00003097          	auipc	ra,0x3
    24c8:	786080e7          	jalr	1926(ra) # 5c4a <exit>

00000000000024cc <manywrites>:
void manywrites(char *s) {
    24cc:	711d                	addi	sp,sp,-96
    24ce:	ec86                	sd	ra,88(sp)
    24d0:	e8a2                	sd	s0,80(sp)
    24d2:	e4a6                	sd	s1,72(sp)
    24d4:	e0ca                	sd	s2,64(sp)
    24d6:	fc4e                	sd	s3,56(sp)
    24d8:	f852                	sd	s4,48(sp)
    24da:	f456                	sd	s5,40(sp)
    24dc:	f05a                	sd	s6,32(sp)
    24de:	ec5e                	sd	s7,24(sp)
    24e0:	1080                	addi	s0,sp,96
    24e2:	8aaa                	mv	s5,a0
  for (int ci = 0; ci < nchildren; ci++) {
    24e4:	4981                	li	s3,0
    24e6:	4911                	li	s2,4
    int pid = fork();
    24e8:	00003097          	auipc	ra,0x3
    24ec:	75a080e7          	jalr	1882(ra) # 5c42 <fork>
    24f0:	84aa                	mv	s1,a0
    if (pid < 0) {
    24f2:	02054963          	bltz	a0,2524 <manywrites+0x58>
    if (pid == 0) {
    24f6:	c521                	beqz	a0,253e <manywrites+0x72>
  for (int ci = 0; ci < nchildren; ci++) {
    24f8:	2985                	addiw	s3,s3,1
    24fa:	ff2997e3          	bne	s3,s2,24e8 <manywrites+0x1c>
    24fe:	4491                	li	s1,4
    int st = 0;
    2500:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    2504:	fa840513          	addi	a0,s0,-88
    2508:	00003097          	auipc	ra,0x3
    250c:	74a080e7          	jalr	1866(ra) # 5c52 <wait>
    if (st != 0) exit(st);
    2510:	fa842503          	lw	a0,-88(s0)
    2514:	ed6d                	bnez	a0,260e <manywrites+0x142>
  for (int ci = 0; ci < nchildren; ci++) {
    2516:	34fd                	addiw	s1,s1,-1
    2518:	f4e5                	bnez	s1,2500 <manywrites+0x34>
  exit(0);
    251a:	4501                	li	a0,0
    251c:	00003097          	auipc	ra,0x3
    2520:	72e080e7          	jalr	1838(ra) # 5c4a <exit>
      printf("fork failed\n");
    2524:	00005517          	auipc	a0,0x5
    2528:	94450513          	addi	a0,a0,-1724 # 6e68 <malloc+0xde8>
    252c:	00004097          	auipc	ra,0x4
    2530:	a96080e7          	jalr	-1386(ra) # 5fc2 <printf>
      exit(1);
    2534:	4505                	li	a0,1
    2536:	00003097          	auipc	ra,0x3
    253a:	714080e7          	jalr	1812(ra) # 5c4a <exit>
      name[0] = 'b';
    253e:	06200793          	li	a5,98
    2542:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    2546:	0619879b          	addiw	a5,s3,97
    254a:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    254e:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    2552:	fa840513          	addi	a0,s0,-88
    2556:	00003097          	auipc	ra,0x3
    255a:	744080e7          	jalr	1860(ra) # 5c9a <unlink>
    255e:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    2560:	0000ab17          	auipc	s6,0xa
    2564:	718b0b13          	addi	s6,s6,1816 # cc78 <buf>
        for (int i = 0; i < ci + 1; i++) {
    2568:	8a26                	mv	s4,s1
    256a:	0209ce63          	bltz	s3,25a6 <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    256e:	20200593          	li	a1,514
    2572:	fa840513          	addi	a0,s0,-88
    2576:	00003097          	auipc	ra,0x3
    257a:	714080e7          	jalr	1812(ra) # 5c8a <open>
    257e:	892a                	mv	s2,a0
          if (fd < 0) {
    2580:	04054763          	bltz	a0,25ce <manywrites+0x102>
          int cc = write(fd, buf, sz);
    2584:	660d                	lui	a2,0x3
    2586:	85da                	mv	a1,s6
    2588:	00003097          	auipc	ra,0x3
    258c:	6e2080e7          	jalr	1762(ra) # 5c6a <write>
          if (cc != sz) {
    2590:	678d                	lui	a5,0x3
    2592:	04f51e63          	bne	a0,a5,25ee <manywrites+0x122>
          close(fd);
    2596:	854a                	mv	a0,s2
    2598:	00003097          	auipc	ra,0x3
    259c:	6da080e7          	jalr	1754(ra) # 5c72 <close>
        for (int i = 0; i < ci + 1; i++) {
    25a0:	2a05                	addiw	s4,s4,1
    25a2:	fd49d6e3          	bge	s3,s4,256e <manywrites+0xa2>
        unlink(name);
    25a6:	fa840513          	addi	a0,s0,-88
    25aa:	00003097          	auipc	ra,0x3
    25ae:	6f0080e7          	jalr	1776(ra) # 5c9a <unlink>
      for (int iters = 0; iters < howmany; iters++) {
    25b2:	3bfd                	addiw	s7,s7,-1
    25b4:	fa0b9ae3          	bnez	s7,2568 <manywrites+0x9c>
      unlink(name);
    25b8:	fa840513          	addi	a0,s0,-88
    25bc:	00003097          	auipc	ra,0x3
    25c0:	6de080e7          	jalr	1758(ra) # 5c9a <unlink>
      exit(0);
    25c4:	4501                	li	a0,0
    25c6:	00003097          	auipc	ra,0x3
    25ca:	684080e7          	jalr	1668(ra) # 5c4a <exit>
            printf("%s: cannot create %s\n", s, name);
    25ce:	fa840613          	addi	a2,s0,-88
    25d2:	85d6                	mv	a1,s5
    25d4:	00005517          	auipc	a0,0x5
    25d8:	8ec50513          	addi	a0,a0,-1812 # 6ec0 <malloc+0xe40>
    25dc:	00004097          	auipc	ra,0x4
    25e0:	9e6080e7          	jalr	-1562(ra) # 5fc2 <printf>
            exit(1);
    25e4:	4505                	li	a0,1
    25e6:	00003097          	auipc	ra,0x3
    25ea:	664080e7          	jalr	1636(ra) # 5c4a <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    25ee:	86aa                	mv	a3,a0
    25f0:	660d                	lui	a2,0x3
    25f2:	85d6                	mv	a1,s5
    25f4:	00004517          	auipc	a0,0x4
    25f8:	ca450513          	addi	a0,a0,-860 # 6298 <malloc+0x218>
    25fc:	00004097          	auipc	ra,0x4
    2600:	9c6080e7          	jalr	-1594(ra) # 5fc2 <printf>
            exit(1);
    2604:	4505                	li	a0,1
    2606:	00003097          	auipc	ra,0x3
    260a:	644080e7          	jalr	1604(ra) # 5c4a <exit>
    if (st != 0) exit(st);
    260e:	00003097          	auipc	ra,0x3
    2612:	63c080e7          	jalr	1596(ra) # 5c4a <exit>

0000000000002616 <copyinstr3>:
void copyinstr3(char *s) {
    2616:	7179                	addi	sp,sp,-48
    2618:	f406                	sd	ra,40(sp)
    261a:	f022                	sd	s0,32(sp)
    261c:	ec26                	sd	s1,24(sp)
    261e:	1800                	addi	s0,sp,48
  sbrk(8192);
    2620:	6509                	lui	a0,0x2
    2622:	00003097          	auipc	ra,0x3
    2626:	6b0080e7          	jalr	1712(ra) # 5cd2 <sbrk>
  uint64 top = (uint64)sbrk(0);
    262a:	4501                	li	a0,0
    262c:	00003097          	auipc	ra,0x3
    2630:	6a6080e7          	jalr	1702(ra) # 5cd2 <sbrk>
  if ((top % PGSIZE) != 0) {
    2634:	03451793          	slli	a5,a0,0x34
    2638:	e3c9                	bnez	a5,26ba <copyinstr3+0xa4>
  top = (uint64)sbrk(0);
    263a:	4501                	li	a0,0
    263c:	00003097          	auipc	ra,0x3
    2640:	696080e7          	jalr	1686(ra) # 5cd2 <sbrk>
  if (top % PGSIZE) {
    2644:	03451793          	slli	a5,a0,0x34
    2648:	e3d9                	bnez	a5,26ce <copyinstr3+0xb8>
  char *b = (char *)(top - 1);
    264a:	fff50493          	addi	s1,a0,-1 # 1fff <linkunlink+0x67>
  *b = 'x';
    264e:	07800793          	li	a5,120
    2652:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    2656:	8526                	mv	a0,s1
    2658:	00003097          	auipc	ra,0x3
    265c:	642080e7          	jalr	1602(ra) # 5c9a <unlink>
  if (ret != -1) {
    2660:	57fd                	li	a5,-1
    2662:	08f51363          	bne	a0,a5,26e8 <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    2666:	20100593          	li	a1,513
    266a:	8526                	mv	a0,s1
    266c:	00003097          	auipc	ra,0x3
    2670:	61e080e7          	jalr	1566(ra) # 5c8a <open>
  if (fd != -1) {
    2674:	57fd                	li	a5,-1
    2676:	08f51863          	bne	a0,a5,2706 <copyinstr3+0xf0>
  ret = link(b, b);
    267a:	85a6                	mv	a1,s1
    267c:	8526                	mv	a0,s1
    267e:	00003097          	auipc	ra,0x3
    2682:	62c080e7          	jalr	1580(ra) # 5caa <link>
  if (ret != -1) {
    2686:	57fd                	li	a5,-1
    2688:	08f51e63          	bne	a0,a5,2724 <copyinstr3+0x10e>
  char *args[] = {"xx", 0};
    268c:	00005797          	auipc	a5,0x5
    2690:	52c78793          	addi	a5,a5,1324 # 7bb8 <malloc+0x1b38>
    2694:	fcf43823          	sd	a5,-48(s0)
    2698:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    269c:	fd040593          	addi	a1,s0,-48
    26a0:	8526                	mv	a0,s1
    26a2:	00003097          	auipc	ra,0x3
    26a6:	5e0080e7          	jalr	1504(ra) # 5c82 <exec>
  if (ret != -1) {
    26aa:	57fd                	li	a5,-1
    26ac:	08f51c63          	bne	a0,a5,2744 <copyinstr3+0x12e>
}
    26b0:	70a2                	ld	ra,40(sp)
    26b2:	7402                	ld	s0,32(sp)
    26b4:	64e2                	ld	s1,24(sp)
    26b6:	6145                	addi	sp,sp,48
    26b8:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    26ba:	0347d513          	srli	a0,a5,0x34
    26be:	6785                	lui	a5,0x1
    26c0:	40a7853b          	subw	a0,a5,a0
    26c4:	00003097          	auipc	ra,0x3
    26c8:	60e080e7          	jalr	1550(ra) # 5cd2 <sbrk>
    26cc:	b7bd                	j	263a <copyinstr3+0x24>
    printf("oops\n");
    26ce:	00005517          	auipc	a0,0x5
    26d2:	80a50513          	addi	a0,a0,-2038 # 6ed8 <malloc+0xe58>
    26d6:	00004097          	auipc	ra,0x4
    26da:	8ec080e7          	jalr	-1812(ra) # 5fc2 <printf>
    exit(1);
    26de:	4505                	li	a0,1
    26e0:	00003097          	auipc	ra,0x3
    26e4:	56a080e7          	jalr	1386(ra) # 5c4a <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    26e8:	862a                	mv	a2,a0
    26ea:	85a6                	mv	a1,s1
    26ec:	00004517          	auipc	a0,0x4
    26f0:	29450513          	addi	a0,a0,660 # 6980 <malloc+0x900>
    26f4:	00004097          	auipc	ra,0x4
    26f8:	8ce080e7          	jalr	-1842(ra) # 5fc2 <printf>
    exit(1);
    26fc:	4505                	li	a0,1
    26fe:	00003097          	auipc	ra,0x3
    2702:	54c080e7          	jalr	1356(ra) # 5c4a <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    2706:	862a                	mv	a2,a0
    2708:	85a6                	mv	a1,s1
    270a:	00004517          	auipc	a0,0x4
    270e:	29650513          	addi	a0,a0,662 # 69a0 <malloc+0x920>
    2712:	00004097          	auipc	ra,0x4
    2716:	8b0080e7          	jalr	-1872(ra) # 5fc2 <printf>
    exit(1);
    271a:	4505                	li	a0,1
    271c:	00003097          	auipc	ra,0x3
    2720:	52e080e7          	jalr	1326(ra) # 5c4a <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    2724:	86aa                	mv	a3,a0
    2726:	8626                	mv	a2,s1
    2728:	85a6                	mv	a1,s1
    272a:	00004517          	auipc	a0,0x4
    272e:	29650513          	addi	a0,a0,662 # 69c0 <malloc+0x940>
    2732:	00004097          	auipc	ra,0x4
    2736:	890080e7          	jalr	-1904(ra) # 5fc2 <printf>
    exit(1);
    273a:	4505                	li	a0,1
    273c:	00003097          	auipc	ra,0x3
    2740:	50e080e7          	jalr	1294(ra) # 5c4a <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    2744:	567d                	li	a2,-1
    2746:	85a6                	mv	a1,s1
    2748:	00004517          	auipc	a0,0x4
    274c:	2a050513          	addi	a0,a0,672 # 69e8 <malloc+0x968>
    2750:	00004097          	auipc	ra,0x4
    2754:	872080e7          	jalr	-1934(ra) # 5fc2 <printf>
    exit(1);
    2758:	4505                	li	a0,1
    275a:	00003097          	auipc	ra,0x3
    275e:	4f0080e7          	jalr	1264(ra) # 5c4a <exit>

0000000000002762 <rwsbrk>:
void rwsbrk() {
    2762:	1101                	addi	sp,sp,-32
    2764:	ec06                	sd	ra,24(sp)
    2766:	e822                	sd	s0,16(sp)
    2768:	e426                	sd	s1,8(sp)
    276a:	e04a                	sd	s2,0(sp)
    276c:	1000                	addi	s0,sp,32
  uint64 a = (uint64)sbrk(8192);
    276e:	6509                	lui	a0,0x2
    2770:	00003097          	auipc	ra,0x3
    2774:	562080e7          	jalr	1378(ra) # 5cd2 <sbrk>
  if (a == 0xffffffffffffffffLL) {
    2778:	57fd                	li	a5,-1
    277a:	06f50363          	beq	a0,a5,27e0 <rwsbrk+0x7e>
    277e:	84aa                	mv	s1,a0
  if ((uint64)sbrk(-8192) == 0xffffffffffffffffLL) {
    2780:	7579                	lui	a0,0xffffe
    2782:	00003097          	auipc	ra,0x3
    2786:	550080e7          	jalr	1360(ra) # 5cd2 <sbrk>
    278a:	57fd                	li	a5,-1
    278c:	06f50763          	beq	a0,a5,27fa <rwsbrk+0x98>
  fd = open("rwsbrk", O_CREATE | O_WRONLY);
    2790:	20100593          	li	a1,513
    2794:	00004517          	auipc	a0,0x4
    2798:	78450513          	addi	a0,a0,1924 # 6f18 <malloc+0xe98>
    279c:	00003097          	auipc	ra,0x3
    27a0:	4ee080e7          	jalr	1262(ra) # 5c8a <open>
    27a4:	892a                	mv	s2,a0
  if (fd < 0) {
    27a6:	06054763          	bltz	a0,2814 <rwsbrk+0xb2>
  n = write(fd, (void *)(a + 4096), 1024);
    27aa:	6505                	lui	a0,0x1
    27ac:	94aa                	add	s1,s1,a0
    27ae:	40000613          	li	a2,1024
    27b2:	85a6                	mv	a1,s1
    27b4:	854a                	mv	a0,s2
    27b6:	00003097          	auipc	ra,0x3
    27ba:	4b4080e7          	jalr	1204(ra) # 5c6a <write>
    27be:	862a                	mv	a2,a0
  if (n >= 0) {
    27c0:	06054763          	bltz	a0,282e <rwsbrk+0xcc>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a + 4096, n);
    27c4:	85a6                	mv	a1,s1
    27c6:	00004517          	auipc	a0,0x4
    27ca:	77250513          	addi	a0,a0,1906 # 6f38 <malloc+0xeb8>
    27ce:	00003097          	auipc	ra,0x3
    27d2:	7f4080e7          	jalr	2036(ra) # 5fc2 <printf>
    exit(1);
    27d6:	4505                	li	a0,1
    27d8:	00003097          	auipc	ra,0x3
    27dc:	472080e7          	jalr	1138(ra) # 5c4a <exit>
    printf("sbrk(rwsbrk) failed\n");
    27e0:	00004517          	auipc	a0,0x4
    27e4:	70050513          	addi	a0,a0,1792 # 6ee0 <malloc+0xe60>
    27e8:	00003097          	auipc	ra,0x3
    27ec:	7da080e7          	jalr	2010(ra) # 5fc2 <printf>
    exit(1);
    27f0:	4505                	li	a0,1
    27f2:	00003097          	auipc	ra,0x3
    27f6:	458080e7          	jalr	1112(ra) # 5c4a <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    27fa:	00004517          	auipc	a0,0x4
    27fe:	6fe50513          	addi	a0,a0,1790 # 6ef8 <malloc+0xe78>
    2802:	00003097          	auipc	ra,0x3
    2806:	7c0080e7          	jalr	1984(ra) # 5fc2 <printf>
    exit(1);
    280a:	4505                	li	a0,1
    280c:	00003097          	auipc	ra,0x3
    2810:	43e080e7          	jalr	1086(ra) # 5c4a <exit>
    printf("open(rwsbrk) failed\n");
    2814:	00004517          	auipc	a0,0x4
    2818:	70c50513          	addi	a0,a0,1804 # 6f20 <malloc+0xea0>
    281c:	00003097          	auipc	ra,0x3
    2820:	7a6080e7          	jalr	1958(ra) # 5fc2 <printf>
    exit(1);
    2824:	4505                	li	a0,1
    2826:	00003097          	auipc	ra,0x3
    282a:	424080e7          	jalr	1060(ra) # 5c4a <exit>
  close(fd);
    282e:	854a                	mv	a0,s2
    2830:	00003097          	auipc	ra,0x3
    2834:	442080e7          	jalr	1090(ra) # 5c72 <close>
  unlink("rwsbrk");
    2838:	00004517          	auipc	a0,0x4
    283c:	6e050513          	addi	a0,a0,1760 # 6f18 <malloc+0xe98>
    2840:	00003097          	auipc	ra,0x3
    2844:	45a080e7          	jalr	1114(ra) # 5c9a <unlink>
  fd = open("xv6-readme", O_RDONLY);
    2848:	4581                	li	a1,0
    284a:	00004517          	auipc	a0,0x4
    284e:	b5650513          	addi	a0,a0,-1194 # 63a0 <malloc+0x320>
    2852:	00003097          	auipc	ra,0x3
    2856:	438080e7          	jalr	1080(ra) # 5c8a <open>
    285a:	892a                	mv	s2,a0
  if (fd < 0) {
    285c:	02054963          	bltz	a0,288e <rwsbrk+0x12c>
  n = read(fd, (void *)(a + 4096), 10);
    2860:	4629                	li	a2,10
    2862:	85a6                	mv	a1,s1
    2864:	00003097          	auipc	ra,0x3
    2868:	3fe080e7          	jalr	1022(ra) # 5c62 <read>
    286c:	862a                	mv	a2,a0
  if (n >= 0) {
    286e:	02054d63          	bltz	a0,28a8 <rwsbrk+0x146>
    printf("read(fd, %p, 10) returned %d, not -1\n", a + 4096, n);
    2872:	85a6                	mv	a1,s1
    2874:	00004517          	auipc	a0,0x4
    2878:	6f450513          	addi	a0,a0,1780 # 6f68 <malloc+0xee8>
    287c:	00003097          	auipc	ra,0x3
    2880:	746080e7          	jalr	1862(ra) # 5fc2 <printf>
    exit(1);
    2884:	4505                	li	a0,1
    2886:	00003097          	auipc	ra,0x3
    288a:	3c4080e7          	jalr	964(ra) # 5c4a <exit>
    printf("open(rwsbrk) failed\n");
    288e:	00004517          	auipc	a0,0x4
    2892:	69250513          	addi	a0,a0,1682 # 6f20 <malloc+0xea0>
    2896:	00003097          	auipc	ra,0x3
    289a:	72c080e7          	jalr	1836(ra) # 5fc2 <printf>
    exit(1);
    289e:	4505                	li	a0,1
    28a0:	00003097          	auipc	ra,0x3
    28a4:	3aa080e7          	jalr	938(ra) # 5c4a <exit>
  close(fd);
    28a8:	854a                	mv	a0,s2
    28aa:	00003097          	auipc	ra,0x3
    28ae:	3c8080e7          	jalr	968(ra) # 5c72 <close>
  exit(0);
    28b2:	4501                	li	a0,0
    28b4:	00003097          	auipc	ra,0x3
    28b8:	396080e7          	jalr	918(ra) # 5c4a <exit>

00000000000028bc <sbrkbasic>:
void sbrkbasic(char *s) {
    28bc:	7139                	addi	sp,sp,-64
    28be:	fc06                	sd	ra,56(sp)
    28c0:	f822                	sd	s0,48(sp)
    28c2:	f426                	sd	s1,40(sp)
    28c4:	f04a                	sd	s2,32(sp)
    28c6:	ec4e                	sd	s3,24(sp)
    28c8:	e852                	sd	s4,16(sp)
    28ca:	0080                	addi	s0,sp,64
    28cc:	8a2a                	mv	s4,a0
  pid = fork();
    28ce:	00003097          	auipc	ra,0x3
    28d2:	374080e7          	jalr	884(ra) # 5c42 <fork>
  if (pid < 0) {
    28d6:	02054c63          	bltz	a0,290e <sbrkbasic+0x52>
  if (pid == 0) {
    28da:	ed21                	bnez	a0,2932 <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    28dc:	40000537          	lui	a0,0x40000
    28e0:	00003097          	auipc	ra,0x3
    28e4:	3f2080e7          	jalr	1010(ra) # 5cd2 <sbrk>
    if (a == (char *)0xffffffffffffffffL) {
    28e8:	57fd                	li	a5,-1
    28ea:	02f50f63          	beq	a0,a5,2928 <sbrkbasic+0x6c>
    for (b = a; b < a + TOOMUCH; b += 4096) {
    28ee:	400007b7          	lui	a5,0x40000
    28f2:	97aa                	add	a5,a5,a0
      *b = 99;
    28f4:	06300693          	li	a3,99
    for (b = a; b < a + TOOMUCH; b += 4096) {
    28f8:	6705                	lui	a4,0x1
      *b = 99;
    28fa:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for (b = a; b < a + TOOMUCH; b += 4096) {
    28fe:	953a                	add	a0,a0,a4
    2900:	fef51de3          	bne	a0,a5,28fa <sbrkbasic+0x3e>
    exit(1);
    2904:	4505                	li	a0,1
    2906:	00003097          	auipc	ra,0x3
    290a:	344080e7          	jalr	836(ra) # 5c4a <exit>
    printf("fork failed in sbrkbasic\n");
    290e:	00004517          	auipc	a0,0x4
    2912:	68250513          	addi	a0,a0,1666 # 6f90 <malloc+0xf10>
    2916:	00003097          	auipc	ra,0x3
    291a:	6ac080e7          	jalr	1708(ra) # 5fc2 <printf>
    exit(1);
    291e:	4505                	li	a0,1
    2920:	00003097          	auipc	ra,0x3
    2924:	32a080e7          	jalr	810(ra) # 5c4a <exit>
      exit(0);
    2928:	4501                	li	a0,0
    292a:	00003097          	auipc	ra,0x3
    292e:	320080e7          	jalr	800(ra) # 5c4a <exit>
  wait(&xstatus);
    2932:	fcc40513          	addi	a0,s0,-52
    2936:	00003097          	auipc	ra,0x3
    293a:	31c080e7          	jalr	796(ra) # 5c52 <wait>
  if (xstatus == 1) {
    293e:	fcc42703          	lw	a4,-52(s0)
    2942:	4785                	li	a5,1
    2944:	00f70d63          	beq	a4,a5,295e <sbrkbasic+0xa2>
  a = sbrk(0);
    2948:	4501                	li	a0,0
    294a:	00003097          	auipc	ra,0x3
    294e:	388080e7          	jalr	904(ra) # 5cd2 <sbrk>
    2952:	84aa                	mv	s1,a0
  for (i = 0; i < 5000; i++) {
    2954:	4901                	li	s2,0
    2956:	6985                	lui	s3,0x1
    2958:	38898993          	addi	s3,s3,904 # 1388 <badarg+0x34>
    295c:	a005                	j	297c <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    295e:	85d2                	mv	a1,s4
    2960:	00004517          	auipc	a0,0x4
    2964:	65050513          	addi	a0,a0,1616 # 6fb0 <malloc+0xf30>
    2968:	00003097          	auipc	ra,0x3
    296c:	65a080e7          	jalr	1626(ra) # 5fc2 <printf>
    exit(1);
    2970:	4505                	li	a0,1
    2972:	00003097          	auipc	ra,0x3
    2976:	2d8080e7          	jalr	728(ra) # 5c4a <exit>
    a = b + 1;
    297a:	84be                	mv	s1,a5
    b = sbrk(1);
    297c:	4505                	li	a0,1
    297e:	00003097          	auipc	ra,0x3
    2982:	354080e7          	jalr	852(ra) # 5cd2 <sbrk>
    if (b != a) {
    2986:	04951c63          	bne	a0,s1,29de <sbrkbasic+0x122>
    *b = 1;
    298a:	4785                	li	a5,1
    298c:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    2990:	00148793          	addi	a5,s1,1
  for (i = 0; i < 5000; i++) {
    2994:	2905                	addiw	s2,s2,1
    2996:	ff3912e3          	bne	s2,s3,297a <sbrkbasic+0xbe>
  pid = fork();
    299a:	00003097          	auipc	ra,0x3
    299e:	2a8080e7          	jalr	680(ra) # 5c42 <fork>
    29a2:	892a                	mv	s2,a0
  if (pid < 0) {
    29a4:	04054e63          	bltz	a0,2a00 <sbrkbasic+0x144>
  c = sbrk(1);
    29a8:	4505                	li	a0,1
    29aa:	00003097          	auipc	ra,0x3
    29ae:	328080e7          	jalr	808(ra) # 5cd2 <sbrk>
  c = sbrk(1);
    29b2:	4505                	li	a0,1
    29b4:	00003097          	auipc	ra,0x3
    29b8:	31e080e7          	jalr	798(ra) # 5cd2 <sbrk>
  if (c != a + 1) {
    29bc:	0489                	addi	s1,s1,2
    29be:	04a48f63          	beq	s1,a0,2a1c <sbrkbasic+0x160>
    printf("%s: sbrk test failed post-fork\n", s);
    29c2:	85d2                	mv	a1,s4
    29c4:	00004517          	auipc	a0,0x4
    29c8:	64c50513          	addi	a0,a0,1612 # 7010 <malloc+0xf90>
    29cc:	00003097          	auipc	ra,0x3
    29d0:	5f6080e7          	jalr	1526(ra) # 5fc2 <printf>
    exit(1);
    29d4:	4505                	li	a0,1
    29d6:	00003097          	auipc	ra,0x3
    29da:	274080e7          	jalr	628(ra) # 5c4a <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    29de:	872a                	mv	a4,a0
    29e0:	86a6                	mv	a3,s1
    29e2:	864a                	mv	a2,s2
    29e4:	85d2                	mv	a1,s4
    29e6:	00004517          	auipc	a0,0x4
    29ea:	5ea50513          	addi	a0,a0,1514 # 6fd0 <malloc+0xf50>
    29ee:	00003097          	auipc	ra,0x3
    29f2:	5d4080e7          	jalr	1492(ra) # 5fc2 <printf>
      exit(1);
    29f6:	4505                	li	a0,1
    29f8:	00003097          	auipc	ra,0x3
    29fc:	252080e7          	jalr	594(ra) # 5c4a <exit>
    printf("%s: sbrk test fork failed\n", s);
    2a00:	85d2                	mv	a1,s4
    2a02:	00004517          	auipc	a0,0x4
    2a06:	5ee50513          	addi	a0,a0,1518 # 6ff0 <malloc+0xf70>
    2a0a:	00003097          	auipc	ra,0x3
    2a0e:	5b8080e7          	jalr	1464(ra) # 5fc2 <printf>
    exit(1);
    2a12:	4505                	li	a0,1
    2a14:	00003097          	auipc	ra,0x3
    2a18:	236080e7          	jalr	566(ra) # 5c4a <exit>
  if (pid == 0) exit(0);
    2a1c:	00091763          	bnez	s2,2a2a <sbrkbasic+0x16e>
    2a20:	4501                	li	a0,0
    2a22:	00003097          	auipc	ra,0x3
    2a26:	228080e7          	jalr	552(ra) # 5c4a <exit>
  wait(&xstatus);
    2a2a:	fcc40513          	addi	a0,s0,-52
    2a2e:	00003097          	auipc	ra,0x3
    2a32:	224080e7          	jalr	548(ra) # 5c52 <wait>
  exit(xstatus);
    2a36:	fcc42503          	lw	a0,-52(s0)
    2a3a:	00003097          	auipc	ra,0x3
    2a3e:	210080e7          	jalr	528(ra) # 5c4a <exit>

0000000000002a42 <sbrkmuch>:
void sbrkmuch(char *s) {
    2a42:	7179                	addi	sp,sp,-48
    2a44:	f406                	sd	ra,40(sp)
    2a46:	f022                	sd	s0,32(sp)
    2a48:	ec26                	sd	s1,24(sp)
    2a4a:	e84a                	sd	s2,16(sp)
    2a4c:	e44e                	sd	s3,8(sp)
    2a4e:	e052                	sd	s4,0(sp)
    2a50:	1800                	addi	s0,sp,48
    2a52:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2a54:	4501                	li	a0,0
    2a56:	00003097          	auipc	ra,0x3
    2a5a:	27c080e7          	jalr	636(ra) # 5cd2 <sbrk>
    2a5e:	892a                	mv	s2,a0
  a = sbrk(0);
    2a60:	4501                	li	a0,0
    2a62:	00003097          	auipc	ra,0x3
    2a66:	270080e7          	jalr	624(ra) # 5cd2 <sbrk>
    2a6a:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2a6c:	06400537          	lui	a0,0x6400
    2a70:	9d05                	subw	a0,a0,s1
    2a72:	00003097          	auipc	ra,0x3
    2a76:	260080e7          	jalr	608(ra) # 5cd2 <sbrk>
  if (p != a) {
    2a7a:	0ca49863          	bne	s1,a0,2b4a <sbrkmuch+0x108>
  char *eee = sbrk(0);
    2a7e:	4501                	li	a0,0
    2a80:	00003097          	auipc	ra,0x3
    2a84:	252080e7          	jalr	594(ra) # 5cd2 <sbrk>
    2a88:	87aa                	mv	a5,a0
  for (char *pp = a; pp < eee; pp += 4096) *pp = 1;
    2a8a:	00a4f963          	bgeu	s1,a0,2a9c <sbrkmuch+0x5a>
    2a8e:	4685                	li	a3,1
    2a90:	6705                	lui	a4,0x1
    2a92:	00d48023          	sb	a3,0(s1)
    2a96:	94ba                	add	s1,s1,a4
    2a98:	fef4ede3          	bltu	s1,a5,2a92 <sbrkmuch+0x50>
  *lastaddr = 99;
    2a9c:	064007b7          	lui	a5,0x6400
    2aa0:	06300713          	li	a4,99
    2aa4:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2aa8:	4501                	li	a0,0
    2aaa:	00003097          	auipc	ra,0x3
    2aae:	228080e7          	jalr	552(ra) # 5cd2 <sbrk>
    2ab2:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2ab4:	757d                	lui	a0,0xfffff
    2ab6:	00003097          	auipc	ra,0x3
    2aba:	21c080e7          	jalr	540(ra) # 5cd2 <sbrk>
  if (c == (char *)0xffffffffffffffffL) {
    2abe:	57fd                	li	a5,-1
    2ac0:	0af50363          	beq	a0,a5,2b66 <sbrkmuch+0x124>
  c = sbrk(0);
    2ac4:	4501                	li	a0,0
    2ac6:	00003097          	auipc	ra,0x3
    2aca:	20c080e7          	jalr	524(ra) # 5cd2 <sbrk>
  if (c != a - PGSIZE) {
    2ace:	77fd                	lui	a5,0xfffff
    2ad0:	97a6                	add	a5,a5,s1
    2ad2:	0af51863          	bne	a0,a5,2b82 <sbrkmuch+0x140>
  a = sbrk(0);
    2ad6:	4501                	li	a0,0
    2ad8:	00003097          	auipc	ra,0x3
    2adc:	1fa080e7          	jalr	506(ra) # 5cd2 <sbrk>
    2ae0:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2ae2:	6505                	lui	a0,0x1
    2ae4:	00003097          	auipc	ra,0x3
    2ae8:	1ee080e7          	jalr	494(ra) # 5cd2 <sbrk>
    2aec:	8a2a                	mv	s4,a0
  if (c != a || sbrk(0) != a + PGSIZE) {
    2aee:	0aa49a63          	bne	s1,a0,2ba2 <sbrkmuch+0x160>
    2af2:	4501                	li	a0,0
    2af4:	00003097          	auipc	ra,0x3
    2af8:	1de080e7          	jalr	478(ra) # 5cd2 <sbrk>
    2afc:	6785                	lui	a5,0x1
    2afe:	97a6                	add	a5,a5,s1
    2b00:	0af51163          	bne	a0,a5,2ba2 <sbrkmuch+0x160>
  if (*lastaddr == 99) {
    2b04:	064007b7          	lui	a5,0x6400
    2b08:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    2b0c:	06300793          	li	a5,99
    2b10:	0af70963          	beq	a4,a5,2bc2 <sbrkmuch+0x180>
  a = sbrk(0);
    2b14:	4501                	li	a0,0
    2b16:	00003097          	auipc	ra,0x3
    2b1a:	1bc080e7          	jalr	444(ra) # 5cd2 <sbrk>
    2b1e:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2b20:	4501                	li	a0,0
    2b22:	00003097          	auipc	ra,0x3
    2b26:	1b0080e7          	jalr	432(ra) # 5cd2 <sbrk>
    2b2a:	40a9053b          	subw	a0,s2,a0
    2b2e:	00003097          	auipc	ra,0x3
    2b32:	1a4080e7          	jalr	420(ra) # 5cd2 <sbrk>
  if (c != a) {
    2b36:	0aa49463          	bne	s1,a0,2bde <sbrkmuch+0x19c>
}
    2b3a:	70a2                	ld	ra,40(sp)
    2b3c:	7402                	ld	s0,32(sp)
    2b3e:	64e2                	ld	s1,24(sp)
    2b40:	6942                	ld	s2,16(sp)
    2b42:	69a2                	ld	s3,8(sp)
    2b44:	6a02                	ld	s4,0(sp)
    2b46:	6145                	addi	sp,sp,48
    2b48:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n",
    2b4a:	85ce                	mv	a1,s3
    2b4c:	00004517          	auipc	a0,0x4
    2b50:	4e450513          	addi	a0,a0,1252 # 7030 <malloc+0xfb0>
    2b54:	00003097          	auipc	ra,0x3
    2b58:	46e080e7          	jalr	1134(ra) # 5fc2 <printf>
    exit(1);
    2b5c:	4505                	li	a0,1
    2b5e:	00003097          	auipc	ra,0x3
    2b62:	0ec080e7          	jalr	236(ra) # 5c4a <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2b66:	85ce                	mv	a1,s3
    2b68:	00004517          	auipc	a0,0x4
    2b6c:	51050513          	addi	a0,a0,1296 # 7078 <malloc+0xff8>
    2b70:	00003097          	auipc	ra,0x3
    2b74:	452080e7          	jalr	1106(ra) # 5fc2 <printf>
    exit(1);
    2b78:	4505                	li	a0,1
    2b7a:	00003097          	auipc	ra,0x3
    2b7e:	0d0080e7          	jalr	208(ra) # 5c4a <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a,
    2b82:	86aa                	mv	a3,a0
    2b84:	8626                	mv	a2,s1
    2b86:	85ce                	mv	a1,s3
    2b88:	00004517          	auipc	a0,0x4
    2b8c:	51050513          	addi	a0,a0,1296 # 7098 <malloc+0x1018>
    2b90:	00003097          	auipc	ra,0x3
    2b94:	432080e7          	jalr	1074(ra) # 5fc2 <printf>
    exit(1);
    2b98:	4505                	li	a0,1
    2b9a:	00003097          	auipc	ra,0x3
    2b9e:	0b0080e7          	jalr	176(ra) # 5c4a <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2ba2:	86d2                	mv	a3,s4
    2ba4:	8626                	mv	a2,s1
    2ba6:	85ce                	mv	a1,s3
    2ba8:	00004517          	auipc	a0,0x4
    2bac:	53050513          	addi	a0,a0,1328 # 70d8 <malloc+0x1058>
    2bb0:	00003097          	auipc	ra,0x3
    2bb4:	412080e7          	jalr	1042(ra) # 5fc2 <printf>
    exit(1);
    2bb8:	4505                	li	a0,1
    2bba:	00003097          	auipc	ra,0x3
    2bbe:	090080e7          	jalr	144(ra) # 5c4a <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2bc2:	85ce                	mv	a1,s3
    2bc4:	00004517          	auipc	a0,0x4
    2bc8:	54450513          	addi	a0,a0,1348 # 7108 <malloc+0x1088>
    2bcc:	00003097          	auipc	ra,0x3
    2bd0:	3f6080e7          	jalr	1014(ra) # 5fc2 <printf>
    exit(1);
    2bd4:	4505                	li	a0,1
    2bd6:	00003097          	auipc	ra,0x3
    2bda:	074080e7          	jalr	116(ra) # 5c4a <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2bde:	86aa                	mv	a3,a0
    2be0:	8626                	mv	a2,s1
    2be2:	85ce                	mv	a1,s3
    2be4:	00004517          	auipc	a0,0x4
    2be8:	55c50513          	addi	a0,a0,1372 # 7140 <malloc+0x10c0>
    2bec:	00003097          	auipc	ra,0x3
    2bf0:	3d6080e7          	jalr	982(ra) # 5fc2 <printf>
    exit(1);
    2bf4:	4505                	li	a0,1
    2bf6:	00003097          	auipc	ra,0x3
    2bfa:	054080e7          	jalr	84(ra) # 5c4a <exit>

0000000000002bfe <sbrkarg>:
void sbrkarg(char *s) {
    2bfe:	7179                	addi	sp,sp,-48
    2c00:	f406                	sd	ra,40(sp)
    2c02:	f022                	sd	s0,32(sp)
    2c04:	ec26                	sd	s1,24(sp)
    2c06:	e84a                	sd	s2,16(sp)
    2c08:	e44e                	sd	s3,8(sp)
    2c0a:	1800                	addi	s0,sp,48
    2c0c:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2c0e:	6505                	lui	a0,0x1
    2c10:	00003097          	auipc	ra,0x3
    2c14:	0c2080e7          	jalr	194(ra) # 5cd2 <sbrk>
    2c18:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE | O_WRONLY);
    2c1a:	20100593          	li	a1,513
    2c1e:	00004517          	auipc	a0,0x4
    2c22:	54a50513          	addi	a0,a0,1354 # 7168 <malloc+0x10e8>
    2c26:	00003097          	auipc	ra,0x3
    2c2a:	064080e7          	jalr	100(ra) # 5c8a <open>
    2c2e:	84aa                	mv	s1,a0
  unlink("sbrk");
    2c30:	00004517          	auipc	a0,0x4
    2c34:	53850513          	addi	a0,a0,1336 # 7168 <malloc+0x10e8>
    2c38:	00003097          	auipc	ra,0x3
    2c3c:	062080e7          	jalr	98(ra) # 5c9a <unlink>
  if (fd < 0) {
    2c40:	0404c163          	bltz	s1,2c82 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2c44:	6605                	lui	a2,0x1
    2c46:	85ca                	mv	a1,s2
    2c48:	8526                	mv	a0,s1
    2c4a:	00003097          	auipc	ra,0x3
    2c4e:	020080e7          	jalr	32(ra) # 5c6a <write>
    2c52:	04054663          	bltz	a0,2c9e <sbrkarg+0xa0>
  close(fd);
    2c56:	8526                	mv	a0,s1
    2c58:	00003097          	auipc	ra,0x3
    2c5c:	01a080e7          	jalr	26(ra) # 5c72 <close>
  a = sbrk(PGSIZE);
    2c60:	6505                	lui	a0,0x1
    2c62:	00003097          	auipc	ra,0x3
    2c66:	070080e7          	jalr	112(ra) # 5cd2 <sbrk>
  if (pipe((int *)a) != 0) {
    2c6a:	00003097          	auipc	ra,0x3
    2c6e:	ff0080e7          	jalr	-16(ra) # 5c5a <pipe>
    2c72:	e521                	bnez	a0,2cba <sbrkarg+0xbc>
}
    2c74:	70a2                	ld	ra,40(sp)
    2c76:	7402                	ld	s0,32(sp)
    2c78:	64e2                	ld	s1,24(sp)
    2c7a:	6942                	ld	s2,16(sp)
    2c7c:	69a2                	ld	s3,8(sp)
    2c7e:	6145                	addi	sp,sp,48
    2c80:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2c82:	85ce                	mv	a1,s3
    2c84:	00004517          	auipc	a0,0x4
    2c88:	4ec50513          	addi	a0,a0,1260 # 7170 <malloc+0x10f0>
    2c8c:	00003097          	auipc	ra,0x3
    2c90:	336080e7          	jalr	822(ra) # 5fc2 <printf>
    exit(1);
    2c94:	4505                	li	a0,1
    2c96:	00003097          	auipc	ra,0x3
    2c9a:	fb4080e7          	jalr	-76(ra) # 5c4a <exit>
    printf("%s: write sbrk failed\n", s);
    2c9e:	85ce                	mv	a1,s3
    2ca0:	00004517          	auipc	a0,0x4
    2ca4:	4e850513          	addi	a0,a0,1256 # 7188 <malloc+0x1108>
    2ca8:	00003097          	auipc	ra,0x3
    2cac:	31a080e7          	jalr	794(ra) # 5fc2 <printf>
    exit(1);
    2cb0:	4505                	li	a0,1
    2cb2:	00003097          	auipc	ra,0x3
    2cb6:	f98080e7          	jalr	-104(ra) # 5c4a <exit>
    printf("%s: pipe() failed\n", s);
    2cba:	85ce                	mv	a1,s3
    2cbc:	00004517          	auipc	a0,0x4
    2cc0:	eac50513          	addi	a0,a0,-340 # 6b68 <malloc+0xae8>
    2cc4:	00003097          	auipc	ra,0x3
    2cc8:	2fe080e7          	jalr	766(ra) # 5fc2 <printf>
    exit(1);
    2ccc:	4505                	li	a0,1
    2cce:	00003097          	auipc	ra,0x3
    2cd2:	f7c080e7          	jalr	-132(ra) # 5c4a <exit>

0000000000002cd6 <argptest>:
void argptest(char *s) {
    2cd6:	1101                	addi	sp,sp,-32
    2cd8:	ec06                	sd	ra,24(sp)
    2cda:	e822                	sd	s0,16(sp)
    2cdc:	e426                	sd	s1,8(sp)
    2cde:	e04a                	sd	s2,0(sp)
    2ce0:	1000                	addi	s0,sp,32
    2ce2:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2ce4:	4581                	li	a1,0
    2ce6:	00004517          	auipc	a0,0x4
    2cea:	4ba50513          	addi	a0,a0,1210 # 71a0 <malloc+0x1120>
    2cee:	00003097          	auipc	ra,0x3
    2cf2:	f9c080e7          	jalr	-100(ra) # 5c8a <open>
  if (fd < 0) {
    2cf6:	02054b63          	bltz	a0,2d2c <argptest+0x56>
    2cfa:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2cfc:	4501                	li	a0,0
    2cfe:	00003097          	auipc	ra,0x3
    2d02:	fd4080e7          	jalr	-44(ra) # 5cd2 <sbrk>
    2d06:	567d                	li	a2,-1
    2d08:	fff50593          	addi	a1,a0,-1
    2d0c:	8526                	mv	a0,s1
    2d0e:	00003097          	auipc	ra,0x3
    2d12:	f54080e7          	jalr	-172(ra) # 5c62 <read>
  close(fd);
    2d16:	8526                	mv	a0,s1
    2d18:	00003097          	auipc	ra,0x3
    2d1c:	f5a080e7          	jalr	-166(ra) # 5c72 <close>
}
    2d20:	60e2                	ld	ra,24(sp)
    2d22:	6442                	ld	s0,16(sp)
    2d24:	64a2                	ld	s1,8(sp)
    2d26:	6902                	ld	s2,0(sp)
    2d28:	6105                	addi	sp,sp,32
    2d2a:	8082                	ret
    printf("%s: open failed\n", s);
    2d2c:	85ca                	mv	a1,s2
    2d2e:	00004517          	auipc	a0,0x4
    2d32:	d4a50513          	addi	a0,a0,-694 # 6a78 <malloc+0x9f8>
    2d36:	00003097          	auipc	ra,0x3
    2d3a:	28c080e7          	jalr	652(ra) # 5fc2 <printf>
    exit(1);
    2d3e:	4505                	li	a0,1
    2d40:	00003097          	auipc	ra,0x3
    2d44:	f0a080e7          	jalr	-246(ra) # 5c4a <exit>

0000000000002d48 <sbrkbugs>:
void sbrkbugs(char *s) {
    2d48:	1141                	addi	sp,sp,-16
    2d4a:	e406                	sd	ra,8(sp)
    2d4c:	e022                	sd	s0,0(sp)
    2d4e:	0800                	addi	s0,sp,16
  int pid = fork();
    2d50:	00003097          	auipc	ra,0x3
    2d54:	ef2080e7          	jalr	-270(ra) # 5c42 <fork>
  if (pid < 0) {
    2d58:	02054263          	bltz	a0,2d7c <sbrkbugs+0x34>
  if (pid == 0) {
    2d5c:	ed0d                	bnez	a0,2d96 <sbrkbugs+0x4e>
    int sz = (uint64)sbrk(0);
    2d5e:	00003097          	auipc	ra,0x3
    2d62:	f74080e7          	jalr	-140(ra) # 5cd2 <sbrk>
    sbrk(-sz);
    2d66:	40a0053b          	negw	a0,a0
    2d6a:	00003097          	auipc	ra,0x3
    2d6e:	f68080e7          	jalr	-152(ra) # 5cd2 <sbrk>
    exit(0);
    2d72:	4501                	li	a0,0
    2d74:	00003097          	auipc	ra,0x3
    2d78:	ed6080e7          	jalr	-298(ra) # 5c4a <exit>
    printf("fork failed\n");
    2d7c:	00004517          	auipc	a0,0x4
    2d80:	0ec50513          	addi	a0,a0,236 # 6e68 <malloc+0xde8>
    2d84:	00003097          	auipc	ra,0x3
    2d88:	23e080e7          	jalr	574(ra) # 5fc2 <printf>
    exit(1);
    2d8c:	4505                	li	a0,1
    2d8e:	00003097          	auipc	ra,0x3
    2d92:	ebc080e7          	jalr	-324(ra) # 5c4a <exit>
  wait(0);
    2d96:	4501                	li	a0,0
    2d98:	00003097          	auipc	ra,0x3
    2d9c:	eba080e7          	jalr	-326(ra) # 5c52 <wait>
  pid = fork();
    2da0:	00003097          	auipc	ra,0x3
    2da4:	ea2080e7          	jalr	-350(ra) # 5c42 <fork>
  if (pid < 0) {
    2da8:	02054563          	bltz	a0,2dd2 <sbrkbugs+0x8a>
  if (pid == 0) {
    2dac:	e121                	bnez	a0,2dec <sbrkbugs+0xa4>
    int sz = (uint64)sbrk(0);
    2dae:	00003097          	auipc	ra,0x3
    2db2:	f24080e7          	jalr	-220(ra) # 5cd2 <sbrk>
    sbrk(-(sz - 3500));
    2db6:	6785                	lui	a5,0x1
    2db8:	dac7879b          	addiw	a5,a5,-596
    2dbc:	40a7853b          	subw	a0,a5,a0
    2dc0:	00003097          	auipc	ra,0x3
    2dc4:	f12080e7          	jalr	-238(ra) # 5cd2 <sbrk>
    exit(0);
    2dc8:	4501                	li	a0,0
    2dca:	00003097          	auipc	ra,0x3
    2dce:	e80080e7          	jalr	-384(ra) # 5c4a <exit>
    printf("fork failed\n");
    2dd2:	00004517          	auipc	a0,0x4
    2dd6:	09650513          	addi	a0,a0,150 # 6e68 <malloc+0xde8>
    2dda:	00003097          	auipc	ra,0x3
    2dde:	1e8080e7          	jalr	488(ra) # 5fc2 <printf>
    exit(1);
    2de2:	4505                	li	a0,1
    2de4:	00003097          	auipc	ra,0x3
    2de8:	e66080e7          	jalr	-410(ra) # 5c4a <exit>
  wait(0);
    2dec:	4501                	li	a0,0
    2dee:	00003097          	auipc	ra,0x3
    2df2:	e64080e7          	jalr	-412(ra) # 5c52 <wait>
  pid = fork();
    2df6:	00003097          	auipc	ra,0x3
    2dfa:	e4c080e7          	jalr	-436(ra) # 5c42 <fork>
  if (pid < 0) {
    2dfe:	02054a63          	bltz	a0,2e32 <sbrkbugs+0xea>
  if (pid == 0) {
    2e02:	e529                	bnez	a0,2e4c <sbrkbugs+0x104>
    sbrk((10 * 4096 + 2048) - (uint64)sbrk(0));
    2e04:	00003097          	auipc	ra,0x3
    2e08:	ece080e7          	jalr	-306(ra) # 5cd2 <sbrk>
    2e0c:	67ad                	lui	a5,0xb
    2e0e:	8007879b          	addiw	a5,a5,-2048
    2e12:	40a7853b          	subw	a0,a5,a0
    2e16:	00003097          	auipc	ra,0x3
    2e1a:	ebc080e7          	jalr	-324(ra) # 5cd2 <sbrk>
    sbrk(-10);
    2e1e:	5559                	li	a0,-10
    2e20:	00003097          	auipc	ra,0x3
    2e24:	eb2080e7          	jalr	-334(ra) # 5cd2 <sbrk>
    exit(0);
    2e28:	4501                	li	a0,0
    2e2a:	00003097          	auipc	ra,0x3
    2e2e:	e20080e7          	jalr	-480(ra) # 5c4a <exit>
    printf("fork failed\n");
    2e32:	00004517          	auipc	a0,0x4
    2e36:	03650513          	addi	a0,a0,54 # 6e68 <malloc+0xde8>
    2e3a:	00003097          	auipc	ra,0x3
    2e3e:	188080e7          	jalr	392(ra) # 5fc2 <printf>
    exit(1);
    2e42:	4505                	li	a0,1
    2e44:	00003097          	auipc	ra,0x3
    2e48:	e06080e7          	jalr	-506(ra) # 5c4a <exit>
  wait(0);
    2e4c:	4501                	li	a0,0
    2e4e:	00003097          	auipc	ra,0x3
    2e52:	e04080e7          	jalr	-508(ra) # 5c52 <wait>
  exit(0);
    2e56:	4501                	li	a0,0
    2e58:	00003097          	auipc	ra,0x3
    2e5c:	df2080e7          	jalr	-526(ra) # 5c4a <exit>

0000000000002e60 <sbrklast>:
void sbrklast(char *s) {
    2e60:	7179                	addi	sp,sp,-48
    2e62:	f406                	sd	ra,40(sp)
    2e64:	f022                	sd	s0,32(sp)
    2e66:	ec26                	sd	s1,24(sp)
    2e68:	e84a                	sd	s2,16(sp)
    2e6a:	e44e                	sd	s3,8(sp)
    2e6c:	e052                	sd	s4,0(sp)
    2e6e:	1800                	addi	s0,sp,48
  uint64 top = (uint64)sbrk(0);
    2e70:	4501                	li	a0,0
    2e72:	00003097          	auipc	ra,0x3
    2e76:	e60080e7          	jalr	-416(ra) # 5cd2 <sbrk>
  if ((top % 4096) != 0) sbrk(4096 - (top % 4096));
    2e7a:	03451793          	slli	a5,a0,0x34
    2e7e:	ebd9                	bnez	a5,2f14 <sbrklast+0xb4>
  sbrk(4096);
    2e80:	6505                	lui	a0,0x1
    2e82:	00003097          	auipc	ra,0x3
    2e86:	e50080e7          	jalr	-432(ra) # 5cd2 <sbrk>
  sbrk(10);
    2e8a:	4529                	li	a0,10
    2e8c:	00003097          	auipc	ra,0x3
    2e90:	e46080e7          	jalr	-442(ra) # 5cd2 <sbrk>
  sbrk(-20);
    2e94:	5531                	li	a0,-20
    2e96:	00003097          	auipc	ra,0x3
    2e9a:	e3c080e7          	jalr	-452(ra) # 5cd2 <sbrk>
  top = (uint64)sbrk(0);
    2e9e:	4501                	li	a0,0
    2ea0:	00003097          	auipc	ra,0x3
    2ea4:	e32080e7          	jalr	-462(ra) # 5cd2 <sbrk>
    2ea8:	84aa                	mv	s1,a0
  char *p = (char *)(top - 64);
    2eaa:	fc050913          	addi	s2,a0,-64 # fc0 <linktest+0xc2>
  p[0] = 'x';
    2eae:	07800a13          	li	s4,120
    2eb2:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2eb6:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR | O_CREATE);
    2eba:	20200593          	li	a1,514
    2ebe:	854a                	mv	a0,s2
    2ec0:	00003097          	auipc	ra,0x3
    2ec4:	dca080e7          	jalr	-566(ra) # 5c8a <open>
    2ec8:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2eca:	4605                	li	a2,1
    2ecc:	85ca                	mv	a1,s2
    2ece:	00003097          	auipc	ra,0x3
    2ed2:	d9c080e7          	jalr	-612(ra) # 5c6a <write>
  close(fd);
    2ed6:	854e                	mv	a0,s3
    2ed8:	00003097          	auipc	ra,0x3
    2edc:	d9a080e7          	jalr	-614(ra) # 5c72 <close>
  fd = open(p, O_RDWR);
    2ee0:	4589                	li	a1,2
    2ee2:	854a                	mv	a0,s2
    2ee4:	00003097          	auipc	ra,0x3
    2ee8:	da6080e7          	jalr	-602(ra) # 5c8a <open>
  p[0] = '\0';
    2eec:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2ef0:	4605                	li	a2,1
    2ef2:	85ca                	mv	a1,s2
    2ef4:	00003097          	auipc	ra,0x3
    2ef8:	d6e080e7          	jalr	-658(ra) # 5c62 <read>
  if (p[0] != 'x') exit(1);
    2efc:	fc04c783          	lbu	a5,-64(s1)
    2f00:	03479463          	bne	a5,s4,2f28 <sbrklast+0xc8>
}
    2f04:	70a2                	ld	ra,40(sp)
    2f06:	7402                	ld	s0,32(sp)
    2f08:	64e2                	ld	s1,24(sp)
    2f0a:	6942                	ld	s2,16(sp)
    2f0c:	69a2                	ld	s3,8(sp)
    2f0e:	6a02                	ld	s4,0(sp)
    2f10:	6145                	addi	sp,sp,48
    2f12:	8082                	ret
  if ((top % 4096) != 0) sbrk(4096 - (top % 4096));
    2f14:	0347d513          	srli	a0,a5,0x34
    2f18:	6785                	lui	a5,0x1
    2f1a:	40a7853b          	subw	a0,a5,a0
    2f1e:	00003097          	auipc	ra,0x3
    2f22:	db4080e7          	jalr	-588(ra) # 5cd2 <sbrk>
    2f26:	bfa9                	j	2e80 <sbrklast+0x20>
  if (p[0] != 'x') exit(1);
    2f28:	4505                	li	a0,1
    2f2a:	00003097          	auipc	ra,0x3
    2f2e:	d20080e7          	jalr	-736(ra) # 5c4a <exit>

0000000000002f32 <sbrk8000>:
void sbrk8000(char *s) {
    2f32:	1141                	addi	sp,sp,-16
    2f34:	e406                	sd	ra,8(sp)
    2f36:	e022                	sd	s0,0(sp)
    2f38:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2f3a:	80000537          	lui	a0,0x80000
    2f3e:	0511                	addi	a0,a0,4
    2f40:	00003097          	auipc	ra,0x3
    2f44:	d92080e7          	jalr	-622(ra) # 5cd2 <sbrk>
  volatile char *top = sbrk(0);
    2f48:	4501                	li	a0,0
    2f4a:	00003097          	auipc	ra,0x3
    2f4e:	d88080e7          	jalr	-632(ra) # 5cd2 <sbrk>
  *(top - 1) = *(top - 1) + 1;
    2f52:	fff54783          	lbu	a5,-1(a0) # ffffffff7fffffff <base+0xffffffff7fff0387>
    2f56:	0785                	addi	a5,a5,1
    2f58:	0ff7f793          	andi	a5,a5,255
    2f5c:	fef50fa3          	sb	a5,-1(a0)
}
    2f60:	60a2                	ld	ra,8(sp)
    2f62:	6402                	ld	s0,0(sp)
    2f64:	0141                	addi	sp,sp,16
    2f66:	8082                	ret

0000000000002f68 <execout>:
void execout(char *s) {
    2f68:	715d                	addi	sp,sp,-80
    2f6a:	e486                	sd	ra,72(sp)
    2f6c:	e0a2                	sd	s0,64(sp)
    2f6e:	fc26                	sd	s1,56(sp)
    2f70:	f84a                	sd	s2,48(sp)
    2f72:	f44e                	sd	s3,40(sp)
    2f74:	f052                	sd	s4,32(sp)
    2f76:	0880                	addi	s0,sp,80
  for (int avail = 0; avail < 15; avail++) {
    2f78:	4901                	li	s2,0
    2f7a:	49bd                	li	s3,15
    int pid = fork();
    2f7c:	00003097          	auipc	ra,0x3
    2f80:	cc6080e7          	jalr	-826(ra) # 5c42 <fork>
    2f84:	84aa                	mv	s1,a0
    if (pid < 0) {
    2f86:	02054063          	bltz	a0,2fa6 <execout+0x3e>
    } else if (pid == 0) {
    2f8a:	c91d                	beqz	a0,2fc0 <execout+0x58>
      wait((int *)0);
    2f8c:	4501                	li	a0,0
    2f8e:	00003097          	auipc	ra,0x3
    2f92:	cc4080e7          	jalr	-828(ra) # 5c52 <wait>
  for (int avail = 0; avail < 15; avail++) {
    2f96:	2905                	addiw	s2,s2,1
    2f98:	ff3912e3          	bne	s2,s3,2f7c <execout+0x14>
  exit(0);
    2f9c:	4501                	li	a0,0
    2f9e:	00003097          	auipc	ra,0x3
    2fa2:	cac080e7          	jalr	-852(ra) # 5c4a <exit>
      printf("fork failed\n");
    2fa6:	00004517          	auipc	a0,0x4
    2faa:	ec250513          	addi	a0,a0,-318 # 6e68 <malloc+0xde8>
    2fae:	00003097          	auipc	ra,0x3
    2fb2:	014080e7          	jalr	20(ra) # 5fc2 <printf>
      exit(1);
    2fb6:	4505                	li	a0,1
    2fb8:	00003097          	auipc	ra,0x3
    2fbc:	c92080e7          	jalr	-878(ra) # 5c4a <exit>
        if (a == 0xffffffffffffffffLL) break;
    2fc0:	59fd                	li	s3,-1
        *(char *)(a + 4096 - 1) = 1;
    2fc2:	4a05                	li	s4,1
        uint64 a = (uint64)sbrk(4096);
    2fc4:	6505                	lui	a0,0x1
    2fc6:	00003097          	auipc	ra,0x3
    2fca:	d0c080e7          	jalr	-756(ra) # 5cd2 <sbrk>
        if (a == 0xffffffffffffffffLL) break;
    2fce:	01350763          	beq	a0,s3,2fdc <execout+0x74>
        *(char *)(a + 4096 - 1) = 1;
    2fd2:	6785                	lui	a5,0x1
    2fd4:	953e                	add	a0,a0,a5
    2fd6:	ff450fa3          	sb	s4,-1(a0) # fff <linktest+0x101>
      while (1) {
    2fda:	b7ed                	j	2fc4 <execout+0x5c>
      for (int i = 0; i < avail; i++) sbrk(-4096);
    2fdc:	01205a63          	blez	s2,2ff0 <execout+0x88>
    2fe0:	757d                	lui	a0,0xfffff
    2fe2:	00003097          	auipc	ra,0x3
    2fe6:	cf0080e7          	jalr	-784(ra) # 5cd2 <sbrk>
    2fea:	2485                	addiw	s1,s1,1
    2fec:	ff249ae3          	bne	s1,s2,2fe0 <execout+0x78>
      close(1);
    2ff0:	4505                	li	a0,1
    2ff2:	00003097          	auipc	ra,0x3
    2ff6:	c80080e7          	jalr	-896(ra) # 5c72 <close>
      char *args[] = {"echo", "x", 0};
    2ffa:	00003517          	auipc	a0,0x3
    2ffe:	1ce50513          	addi	a0,a0,462 # 61c8 <malloc+0x148>
    3002:	faa43c23          	sd	a0,-72(s0)
    3006:	00003797          	auipc	a5,0x3
    300a:	23278793          	addi	a5,a5,562 # 6238 <malloc+0x1b8>
    300e:	fcf43023          	sd	a5,-64(s0)
    3012:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    3016:	fb840593          	addi	a1,s0,-72
    301a:	00003097          	auipc	ra,0x3
    301e:	c68080e7          	jalr	-920(ra) # 5c82 <exec>
      exit(0);
    3022:	4501                	li	a0,0
    3024:	00003097          	auipc	ra,0x3
    3028:	c26080e7          	jalr	-986(ra) # 5c4a <exit>

000000000000302c <fourteen>:
void fourteen(char *s) {
    302c:	1101                	addi	sp,sp,-32
    302e:	ec06                	sd	ra,24(sp)
    3030:	e822                	sd	s0,16(sp)
    3032:	e426                	sd	s1,8(sp)
    3034:	1000                	addi	s0,sp,32
    3036:	84aa                	mv	s1,a0
  if (mkdir("12345678901234") != 0) {
    3038:	00004517          	auipc	a0,0x4
    303c:	34050513          	addi	a0,a0,832 # 7378 <malloc+0x12f8>
    3040:	00003097          	auipc	ra,0x3
    3044:	c72080e7          	jalr	-910(ra) # 5cb2 <mkdir>
    3048:	e165                	bnez	a0,3128 <fourteen+0xfc>
  if (mkdir("12345678901234/123456789012345") != 0) {
    304a:	00004517          	auipc	a0,0x4
    304e:	18650513          	addi	a0,a0,390 # 71d0 <malloc+0x1150>
    3052:	00003097          	auipc	ra,0x3
    3056:	c60080e7          	jalr	-928(ra) # 5cb2 <mkdir>
    305a:	e56d                	bnez	a0,3144 <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    305c:	20000593          	li	a1,512
    3060:	00004517          	auipc	a0,0x4
    3064:	1c850513          	addi	a0,a0,456 # 7228 <malloc+0x11a8>
    3068:	00003097          	auipc	ra,0x3
    306c:	c22080e7          	jalr	-990(ra) # 5c8a <open>
  if (fd < 0) {
    3070:	0e054863          	bltz	a0,3160 <fourteen+0x134>
  close(fd);
    3074:	00003097          	auipc	ra,0x3
    3078:	bfe080e7          	jalr	-1026(ra) # 5c72 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    307c:	4581                	li	a1,0
    307e:	00004517          	auipc	a0,0x4
    3082:	22250513          	addi	a0,a0,546 # 72a0 <malloc+0x1220>
    3086:	00003097          	auipc	ra,0x3
    308a:	c04080e7          	jalr	-1020(ra) # 5c8a <open>
  if (fd < 0) {
    308e:	0e054763          	bltz	a0,317c <fourteen+0x150>
  close(fd);
    3092:	00003097          	auipc	ra,0x3
    3096:	be0080e7          	jalr	-1056(ra) # 5c72 <close>
  if (mkdir("12345678901234/12345678901234") == 0) {
    309a:	00004517          	auipc	a0,0x4
    309e:	27650513          	addi	a0,a0,630 # 7310 <malloc+0x1290>
    30a2:	00003097          	auipc	ra,0x3
    30a6:	c10080e7          	jalr	-1008(ra) # 5cb2 <mkdir>
    30aa:	c57d                	beqz	a0,3198 <fourteen+0x16c>
  if (mkdir("123456789012345/12345678901234") == 0) {
    30ac:	00004517          	auipc	a0,0x4
    30b0:	2bc50513          	addi	a0,a0,700 # 7368 <malloc+0x12e8>
    30b4:	00003097          	auipc	ra,0x3
    30b8:	bfe080e7          	jalr	-1026(ra) # 5cb2 <mkdir>
    30bc:	cd65                	beqz	a0,31b4 <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    30be:	00004517          	auipc	a0,0x4
    30c2:	2aa50513          	addi	a0,a0,682 # 7368 <malloc+0x12e8>
    30c6:	00003097          	auipc	ra,0x3
    30ca:	bd4080e7          	jalr	-1068(ra) # 5c9a <unlink>
  unlink("12345678901234/12345678901234");
    30ce:	00004517          	auipc	a0,0x4
    30d2:	24250513          	addi	a0,a0,578 # 7310 <malloc+0x1290>
    30d6:	00003097          	auipc	ra,0x3
    30da:	bc4080e7          	jalr	-1084(ra) # 5c9a <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    30de:	00004517          	auipc	a0,0x4
    30e2:	1c250513          	addi	a0,a0,450 # 72a0 <malloc+0x1220>
    30e6:	00003097          	auipc	ra,0x3
    30ea:	bb4080e7          	jalr	-1100(ra) # 5c9a <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    30ee:	00004517          	auipc	a0,0x4
    30f2:	13a50513          	addi	a0,a0,314 # 7228 <malloc+0x11a8>
    30f6:	00003097          	auipc	ra,0x3
    30fa:	ba4080e7          	jalr	-1116(ra) # 5c9a <unlink>
  unlink("12345678901234/123456789012345");
    30fe:	00004517          	auipc	a0,0x4
    3102:	0d250513          	addi	a0,a0,210 # 71d0 <malloc+0x1150>
    3106:	00003097          	auipc	ra,0x3
    310a:	b94080e7          	jalr	-1132(ra) # 5c9a <unlink>
  unlink("12345678901234");
    310e:	00004517          	auipc	a0,0x4
    3112:	26a50513          	addi	a0,a0,618 # 7378 <malloc+0x12f8>
    3116:	00003097          	auipc	ra,0x3
    311a:	b84080e7          	jalr	-1148(ra) # 5c9a <unlink>
}
    311e:	60e2                	ld	ra,24(sp)
    3120:	6442                	ld	s0,16(sp)
    3122:	64a2                	ld	s1,8(sp)
    3124:	6105                	addi	sp,sp,32
    3126:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    3128:	85a6                	mv	a1,s1
    312a:	00004517          	auipc	a0,0x4
    312e:	07e50513          	addi	a0,a0,126 # 71a8 <malloc+0x1128>
    3132:	00003097          	auipc	ra,0x3
    3136:	e90080e7          	jalr	-368(ra) # 5fc2 <printf>
    exit(1);
    313a:	4505                	li	a0,1
    313c:	00003097          	auipc	ra,0x3
    3140:	b0e080e7          	jalr	-1266(ra) # 5c4a <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    3144:	85a6                	mv	a1,s1
    3146:	00004517          	auipc	a0,0x4
    314a:	0aa50513          	addi	a0,a0,170 # 71f0 <malloc+0x1170>
    314e:	00003097          	auipc	ra,0x3
    3152:	e74080e7          	jalr	-396(ra) # 5fc2 <printf>
    exit(1);
    3156:	4505                	li	a0,1
    3158:	00003097          	auipc	ra,0x3
    315c:	af2080e7          	jalr	-1294(ra) # 5c4a <exit>
    printf(
    3160:	85a6                	mv	a1,s1
    3162:	00004517          	auipc	a0,0x4
    3166:	0f650513          	addi	a0,a0,246 # 7258 <malloc+0x11d8>
    316a:	00003097          	auipc	ra,0x3
    316e:	e58080e7          	jalr	-424(ra) # 5fc2 <printf>
    exit(1);
    3172:	4505                	li	a0,1
    3174:	00003097          	auipc	ra,0x3
    3178:	ad6080e7          	jalr	-1322(ra) # 5c4a <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    317c:	85a6                	mv	a1,s1
    317e:	00004517          	auipc	a0,0x4
    3182:	15250513          	addi	a0,a0,338 # 72d0 <malloc+0x1250>
    3186:	00003097          	auipc	ra,0x3
    318a:	e3c080e7          	jalr	-452(ra) # 5fc2 <printf>
    exit(1);
    318e:	4505                	li	a0,1
    3190:	00003097          	auipc	ra,0x3
    3194:	aba080e7          	jalr	-1350(ra) # 5c4a <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    3198:	85a6                	mv	a1,s1
    319a:	00004517          	auipc	a0,0x4
    319e:	19650513          	addi	a0,a0,406 # 7330 <malloc+0x12b0>
    31a2:	00003097          	auipc	ra,0x3
    31a6:	e20080e7          	jalr	-480(ra) # 5fc2 <printf>
    exit(1);
    31aa:	4505                	li	a0,1
    31ac:	00003097          	auipc	ra,0x3
    31b0:	a9e080e7          	jalr	-1378(ra) # 5c4a <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    31b4:	85a6                	mv	a1,s1
    31b6:	00004517          	auipc	a0,0x4
    31ba:	1d250513          	addi	a0,a0,466 # 7388 <malloc+0x1308>
    31be:	00003097          	auipc	ra,0x3
    31c2:	e04080e7          	jalr	-508(ra) # 5fc2 <printf>
    exit(1);
    31c6:	4505                	li	a0,1
    31c8:	00003097          	auipc	ra,0x3
    31cc:	a82080e7          	jalr	-1406(ra) # 5c4a <exit>

00000000000031d0 <diskfull>:
void diskfull(char *s) {
    31d0:	b8010113          	addi	sp,sp,-1152
    31d4:	46113c23          	sd	ra,1144(sp)
    31d8:	46813823          	sd	s0,1136(sp)
    31dc:	46913423          	sd	s1,1128(sp)
    31e0:	47213023          	sd	s2,1120(sp)
    31e4:	45313c23          	sd	s3,1112(sp)
    31e8:	45413823          	sd	s4,1104(sp)
    31ec:	45513423          	sd	s5,1096(sp)
    31f0:	45613023          	sd	s6,1088(sp)
    31f4:	43713c23          	sd	s7,1080(sp)
    31f8:	43813823          	sd	s8,1072(sp)
    31fc:	43913423          	sd	s9,1064(sp)
    3200:	48010413          	addi	s0,sp,1152
    3204:	8caa                	mv	s9,a0
  unlink("diskfulldir");
    3206:	00004517          	auipc	a0,0x4
    320a:	1ba50513          	addi	a0,a0,442 # 73c0 <malloc+0x1340>
    320e:	00003097          	auipc	ra,0x3
    3212:	a8c080e7          	jalr	-1396(ra) # 5c9a <unlink>
    3216:	03000993          	li	s3,48
    name[0] = 'b';
    321a:	06200b13          	li	s6,98
    name[1] = 'i';
    321e:	06900a93          	li	s5,105
    name[2] = 'g';
    3222:	06700a13          	li	s4,103
    3226:	10c00b93          	li	s7,268
  for (fi = 0; done == 0 && '0' + fi < 0177; fi++) {
    322a:	07f00c13          	li	s8,127
    322e:	a269                	j	33b8 <diskfull+0x1e8>
      printf("%s: could not create file %s\n", s, name);
    3230:	b8040613          	addi	a2,s0,-1152
    3234:	85e6                	mv	a1,s9
    3236:	00004517          	auipc	a0,0x4
    323a:	19a50513          	addi	a0,a0,410 # 73d0 <malloc+0x1350>
    323e:	00003097          	auipc	ra,0x3
    3242:	d84080e7          	jalr	-636(ra) # 5fc2 <printf>
      break;
    3246:	a819                	j	325c <diskfull+0x8c>
        close(fd);
    3248:	854a                	mv	a0,s2
    324a:	00003097          	auipc	ra,0x3
    324e:	a28080e7          	jalr	-1496(ra) # 5c72 <close>
    close(fd);
    3252:	854a                	mv	a0,s2
    3254:	00003097          	auipc	ra,0x3
    3258:	a1e080e7          	jalr	-1506(ra) # 5c72 <close>
  for (int i = 0; i < nzz; i++) {
    325c:	4481                	li	s1,0
    name[0] = 'z';
    325e:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
    3262:	08000993          	li	s3,128
    name[0] = 'z';
    3266:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    326a:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    326e:	41f4d79b          	sraiw	a5,s1,0x1f
    3272:	01b7d71b          	srliw	a4,a5,0x1b
    3276:	009707bb          	addw	a5,a4,s1
    327a:	4057d69b          	sraiw	a3,a5,0x5
    327e:	0306869b          	addiw	a3,a3,48
    3282:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    3286:	8bfd                	andi	a5,a5,31
    3288:	9f99                	subw	a5,a5,a4
    328a:	0307879b          	addiw	a5,a5,48
    328e:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    3292:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    3296:	ba040513          	addi	a0,s0,-1120
    329a:	00003097          	auipc	ra,0x3
    329e:	a00080e7          	jalr	-1536(ra) # 5c9a <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
    32a2:	60200593          	li	a1,1538
    32a6:	ba040513          	addi	a0,s0,-1120
    32aa:	00003097          	auipc	ra,0x3
    32ae:	9e0080e7          	jalr	-1568(ra) # 5c8a <open>
    if (fd < 0) break;
    32b2:	00054963          	bltz	a0,32c4 <diskfull+0xf4>
    close(fd);
    32b6:	00003097          	auipc	ra,0x3
    32ba:	9bc080e7          	jalr	-1604(ra) # 5c72 <close>
  for (int i = 0; i < nzz; i++) {
    32be:	2485                	addiw	s1,s1,1
    32c0:	fb3493e3          	bne	s1,s3,3266 <diskfull+0x96>
  if (mkdir("diskfulldir") == 0)
    32c4:	00004517          	auipc	a0,0x4
    32c8:	0fc50513          	addi	a0,a0,252 # 73c0 <malloc+0x1340>
    32cc:	00003097          	auipc	ra,0x3
    32d0:	9e6080e7          	jalr	-1562(ra) # 5cb2 <mkdir>
    32d4:	12050e63          	beqz	a0,3410 <diskfull+0x240>
  unlink("diskfulldir");
    32d8:	00004517          	auipc	a0,0x4
    32dc:	0e850513          	addi	a0,a0,232 # 73c0 <malloc+0x1340>
    32e0:	00003097          	auipc	ra,0x3
    32e4:	9ba080e7          	jalr	-1606(ra) # 5c9a <unlink>
  for (int i = 0; i < nzz; i++) {
    32e8:	4481                	li	s1,0
    name[0] = 'z';
    32ea:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
    32ee:	08000993          	li	s3,128
    name[0] = 'z';
    32f2:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    32f6:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    32fa:	41f4d79b          	sraiw	a5,s1,0x1f
    32fe:	01b7d71b          	srliw	a4,a5,0x1b
    3302:	009707bb          	addw	a5,a4,s1
    3306:	4057d69b          	sraiw	a3,a5,0x5
    330a:	0306869b          	addiw	a3,a3,48
    330e:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    3312:	8bfd                	andi	a5,a5,31
    3314:	9f99                	subw	a5,a5,a4
    3316:	0307879b          	addiw	a5,a5,48
    331a:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    331e:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    3322:	ba040513          	addi	a0,s0,-1120
    3326:	00003097          	auipc	ra,0x3
    332a:	974080e7          	jalr	-1676(ra) # 5c9a <unlink>
  for (int i = 0; i < nzz; i++) {
    332e:	2485                	addiw	s1,s1,1
    3330:	fd3491e3          	bne	s1,s3,32f2 <diskfull+0x122>
    3334:	03000493          	li	s1,48
    name[0] = 'b';
    3338:	06200a93          	li	s5,98
    name[1] = 'i';
    333c:	06900a13          	li	s4,105
    name[2] = 'g';
    3340:	06700993          	li	s3,103
  for (int i = 0; '0' + i < 0177; i++) {
    3344:	07f00913          	li	s2,127
    name[0] = 'b';
    3348:	bb540023          	sb	s5,-1120(s0)
    name[1] = 'i';
    334c:	bb4400a3          	sb	s4,-1119(s0)
    name[2] = 'g';
    3350:	bb340123          	sb	s3,-1118(s0)
    name[3] = '0' + i;
    3354:	ba9401a3          	sb	s1,-1117(s0)
    name[4] = '\0';
    3358:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    335c:	ba040513          	addi	a0,s0,-1120
    3360:	00003097          	auipc	ra,0x3
    3364:	93a080e7          	jalr	-1734(ra) # 5c9a <unlink>
  for (int i = 0; '0' + i < 0177; i++) {
    3368:	2485                	addiw	s1,s1,1
    336a:	0ff4f493          	andi	s1,s1,255
    336e:	fd249de3          	bne	s1,s2,3348 <diskfull+0x178>
}
    3372:	47813083          	ld	ra,1144(sp)
    3376:	47013403          	ld	s0,1136(sp)
    337a:	46813483          	ld	s1,1128(sp)
    337e:	46013903          	ld	s2,1120(sp)
    3382:	45813983          	ld	s3,1112(sp)
    3386:	45013a03          	ld	s4,1104(sp)
    338a:	44813a83          	ld	s5,1096(sp)
    338e:	44013b03          	ld	s6,1088(sp)
    3392:	43813b83          	ld	s7,1080(sp)
    3396:	43013c03          	ld	s8,1072(sp)
    339a:	42813c83          	ld	s9,1064(sp)
    339e:	48010113          	addi	sp,sp,1152
    33a2:	8082                	ret
    close(fd);
    33a4:	854a                	mv	a0,s2
    33a6:	00003097          	auipc	ra,0x3
    33aa:	8cc080e7          	jalr	-1844(ra) # 5c72 <close>
  for (fi = 0; done == 0 && '0' + fi < 0177; fi++) {
    33ae:	2985                	addiw	s3,s3,1
    33b0:	0ff9f993          	andi	s3,s3,255
    33b4:	eb8984e3          	beq	s3,s8,325c <diskfull+0x8c>
    name[0] = 'b';
    33b8:	b9640023          	sb	s6,-1152(s0)
    name[1] = 'i';
    33bc:	b95400a3          	sb	s5,-1151(s0)
    name[2] = 'g';
    33c0:	b9440123          	sb	s4,-1150(s0)
    name[3] = '0' + fi;
    33c4:	b93401a3          	sb	s3,-1149(s0)
    name[4] = '\0';
    33c8:	b8040223          	sb	zero,-1148(s0)
    unlink(name);
    33cc:	b8040513          	addi	a0,s0,-1152
    33d0:	00003097          	auipc	ra,0x3
    33d4:	8ca080e7          	jalr	-1846(ra) # 5c9a <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
    33d8:	60200593          	li	a1,1538
    33dc:	b8040513          	addi	a0,s0,-1152
    33e0:	00003097          	auipc	ra,0x3
    33e4:	8aa080e7          	jalr	-1878(ra) # 5c8a <open>
    33e8:	892a                	mv	s2,a0
    if (fd < 0) {
    33ea:	e40543e3          	bltz	a0,3230 <diskfull+0x60>
    33ee:	84de                	mv	s1,s7
      if (write(fd, buf, BSIZE) != BSIZE) {
    33f0:	40000613          	li	a2,1024
    33f4:	ba040593          	addi	a1,s0,-1120
    33f8:	854a                	mv	a0,s2
    33fa:	00003097          	auipc	ra,0x3
    33fe:	870080e7          	jalr	-1936(ra) # 5c6a <write>
    3402:	40000793          	li	a5,1024
    3406:	e4f511e3          	bne	a0,a5,3248 <diskfull+0x78>
    for (int i = 0; i < MAXFILE; i++) {
    340a:	34fd                	addiw	s1,s1,-1
    340c:	f0f5                	bnez	s1,33f0 <diskfull+0x220>
    340e:	bf59                	j	33a4 <diskfull+0x1d4>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    3410:	00004517          	auipc	a0,0x4
    3414:	fe050513          	addi	a0,a0,-32 # 73f0 <malloc+0x1370>
    3418:	00003097          	auipc	ra,0x3
    341c:	baa080e7          	jalr	-1110(ra) # 5fc2 <printf>
    3420:	bd65                	j	32d8 <diskfull+0x108>

0000000000003422 <iputtest>:
void iputtest(char *s) {
    3422:	1101                	addi	sp,sp,-32
    3424:	ec06                	sd	ra,24(sp)
    3426:	e822                	sd	s0,16(sp)
    3428:	e426                	sd	s1,8(sp)
    342a:	1000                	addi	s0,sp,32
    342c:	84aa                	mv	s1,a0
  if (mkdir("iputdir") < 0) {
    342e:	00004517          	auipc	a0,0x4
    3432:	ff250513          	addi	a0,a0,-14 # 7420 <malloc+0x13a0>
    3436:	00003097          	auipc	ra,0x3
    343a:	87c080e7          	jalr	-1924(ra) # 5cb2 <mkdir>
    343e:	04054563          	bltz	a0,3488 <iputtest+0x66>
  if (chdir("iputdir") < 0) {
    3442:	00004517          	auipc	a0,0x4
    3446:	fde50513          	addi	a0,a0,-34 # 7420 <malloc+0x13a0>
    344a:	00003097          	auipc	ra,0x3
    344e:	870080e7          	jalr	-1936(ra) # 5cba <chdir>
    3452:	04054963          	bltz	a0,34a4 <iputtest+0x82>
  if (unlink("../iputdir") < 0) {
    3456:	00004517          	auipc	a0,0x4
    345a:	00a50513          	addi	a0,a0,10 # 7460 <malloc+0x13e0>
    345e:	00003097          	auipc	ra,0x3
    3462:	83c080e7          	jalr	-1988(ra) # 5c9a <unlink>
    3466:	04054d63          	bltz	a0,34c0 <iputtest+0x9e>
  if (chdir("/") < 0) {
    346a:	00004517          	auipc	a0,0x4
    346e:	02650513          	addi	a0,a0,38 # 7490 <malloc+0x1410>
    3472:	00003097          	auipc	ra,0x3
    3476:	848080e7          	jalr	-1976(ra) # 5cba <chdir>
    347a:	06054163          	bltz	a0,34dc <iputtest+0xba>
}
    347e:	60e2                	ld	ra,24(sp)
    3480:	6442                	ld	s0,16(sp)
    3482:	64a2                	ld	s1,8(sp)
    3484:	6105                	addi	sp,sp,32
    3486:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3488:	85a6                	mv	a1,s1
    348a:	00004517          	auipc	a0,0x4
    348e:	f9e50513          	addi	a0,a0,-98 # 7428 <malloc+0x13a8>
    3492:	00003097          	auipc	ra,0x3
    3496:	b30080e7          	jalr	-1232(ra) # 5fc2 <printf>
    exit(1);
    349a:	4505                	li	a0,1
    349c:	00002097          	auipc	ra,0x2
    34a0:	7ae080e7          	jalr	1966(ra) # 5c4a <exit>
    printf("%s: chdir iputdir failed\n", s);
    34a4:	85a6                	mv	a1,s1
    34a6:	00004517          	auipc	a0,0x4
    34aa:	f9a50513          	addi	a0,a0,-102 # 7440 <malloc+0x13c0>
    34ae:	00003097          	auipc	ra,0x3
    34b2:	b14080e7          	jalr	-1260(ra) # 5fc2 <printf>
    exit(1);
    34b6:	4505                	li	a0,1
    34b8:	00002097          	auipc	ra,0x2
    34bc:	792080e7          	jalr	1938(ra) # 5c4a <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    34c0:	85a6                	mv	a1,s1
    34c2:	00004517          	auipc	a0,0x4
    34c6:	fae50513          	addi	a0,a0,-82 # 7470 <malloc+0x13f0>
    34ca:	00003097          	auipc	ra,0x3
    34ce:	af8080e7          	jalr	-1288(ra) # 5fc2 <printf>
    exit(1);
    34d2:	4505                	li	a0,1
    34d4:	00002097          	auipc	ra,0x2
    34d8:	776080e7          	jalr	1910(ra) # 5c4a <exit>
    printf("%s: chdir / failed\n", s);
    34dc:	85a6                	mv	a1,s1
    34de:	00004517          	auipc	a0,0x4
    34e2:	fba50513          	addi	a0,a0,-70 # 7498 <malloc+0x1418>
    34e6:	00003097          	auipc	ra,0x3
    34ea:	adc080e7          	jalr	-1316(ra) # 5fc2 <printf>
    exit(1);
    34ee:	4505                	li	a0,1
    34f0:	00002097          	auipc	ra,0x2
    34f4:	75a080e7          	jalr	1882(ra) # 5c4a <exit>

00000000000034f8 <exitiputtest>:
void exitiputtest(char *s) {
    34f8:	7179                	addi	sp,sp,-48
    34fa:	f406                	sd	ra,40(sp)
    34fc:	f022                	sd	s0,32(sp)
    34fe:	ec26                	sd	s1,24(sp)
    3500:	1800                	addi	s0,sp,48
    3502:	84aa                	mv	s1,a0
  pid = fork();
    3504:	00002097          	auipc	ra,0x2
    3508:	73e080e7          	jalr	1854(ra) # 5c42 <fork>
  if (pid < 0) {
    350c:	04054663          	bltz	a0,3558 <exitiputtest+0x60>
  if (pid == 0) {
    3510:	ed45                	bnez	a0,35c8 <exitiputtest+0xd0>
    if (mkdir("iputdir") < 0) {
    3512:	00004517          	auipc	a0,0x4
    3516:	f0e50513          	addi	a0,a0,-242 # 7420 <malloc+0x13a0>
    351a:	00002097          	auipc	ra,0x2
    351e:	798080e7          	jalr	1944(ra) # 5cb2 <mkdir>
    3522:	04054963          	bltz	a0,3574 <exitiputtest+0x7c>
    if (chdir("iputdir") < 0) {
    3526:	00004517          	auipc	a0,0x4
    352a:	efa50513          	addi	a0,a0,-262 # 7420 <malloc+0x13a0>
    352e:	00002097          	auipc	ra,0x2
    3532:	78c080e7          	jalr	1932(ra) # 5cba <chdir>
    3536:	04054d63          	bltz	a0,3590 <exitiputtest+0x98>
    if (unlink("../iputdir") < 0) {
    353a:	00004517          	auipc	a0,0x4
    353e:	f2650513          	addi	a0,a0,-218 # 7460 <malloc+0x13e0>
    3542:	00002097          	auipc	ra,0x2
    3546:	758080e7          	jalr	1880(ra) # 5c9a <unlink>
    354a:	06054163          	bltz	a0,35ac <exitiputtest+0xb4>
    exit(0);
    354e:	4501                	li	a0,0
    3550:	00002097          	auipc	ra,0x2
    3554:	6fa080e7          	jalr	1786(ra) # 5c4a <exit>
    printf("%s: fork failed\n", s);
    3558:	85a6                	mv	a1,s1
    355a:	00003517          	auipc	a0,0x3
    355e:	50650513          	addi	a0,a0,1286 # 6a60 <malloc+0x9e0>
    3562:	00003097          	auipc	ra,0x3
    3566:	a60080e7          	jalr	-1440(ra) # 5fc2 <printf>
    exit(1);
    356a:	4505                	li	a0,1
    356c:	00002097          	auipc	ra,0x2
    3570:	6de080e7          	jalr	1758(ra) # 5c4a <exit>
      printf("%s: mkdir failed\n", s);
    3574:	85a6                	mv	a1,s1
    3576:	00004517          	auipc	a0,0x4
    357a:	eb250513          	addi	a0,a0,-334 # 7428 <malloc+0x13a8>
    357e:	00003097          	auipc	ra,0x3
    3582:	a44080e7          	jalr	-1468(ra) # 5fc2 <printf>
      exit(1);
    3586:	4505                	li	a0,1
    3588:	00002097          	auipc	ra,0x2
    358c:	6c2080e7          	jalr	1730(ra) # 5c4a <exit>
      printf("%s: child chdir failed\n", s);
    3590:	85a6                	mv	a1,s1
    3592:	00004517          	auipc	a0,0x4
    3596:	f1e50513          	addi	a0,a0,-226 # 74b0 <malloc+0x1430>
    359a:	00003097          	auipc	ra,0x3
    359e:	a28080e7          	jalr	-1496(ra) # 5fc2 <printf>
      exit(1);
    35a2:	4505                	li	a0,1
    35a4:	00002097          	auipc	ra,0x2
    35a8:	6a6080e7          	jalr	1702(ra) # 5c4a <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    35ac:	85a6                	mv	a1,s1
    35ae:	00004517          	auipc	a0,0x4
    35b2:	ec250513          	addi	a0,a0,-318 # 7470 <malloc+0x13f0>
    35b6:	00003097          	auipc	ra,0x3
    35ba:	a0c080e7          	jalr	-1524(ra) # 5fc2 <printf>
      exit(1);
    35be:	4505                	li	a0,1
    35c0:	00002097          	auipc	ra,0x2
    35c4:	68a080e7          	jalr	1674(ra) # 5c4a <exit>
  wait(&xstatus);
    35c8:	fdc40513          	addi	a0,s0,-36
    35cc:	00002097          	auipc	ra,0x2
    35d0:	686080e7          	jalr	1670(ra) # 5c52 <wait>
  exit(xstatus);
    35d4:	fdc42503          	lw	a0,-36(s0)
    35d8:	00002097          	auipc	ra,0x2
    35dc:	672080e7          	jalr	1650(ra) # 5c4a <exit>

00000000000035e0 <dirtest>:
void dirtest(char *s) {
    35e0:	1101                	addi	sp,sp,-32
    35e2:	ec06                	sd	ra,24(sp)
    35e4:	e822                	sd	s0,16(sp)
    35e6:	e426                	sd	s1,8(sp)
    35e8:	1000                	addi	s0,sp,32
    35ea:	84aa                	mv	s1,a0
  if (mkdir("dir0") < 0) {
    35ec:	00004517          	auipc	a0,0x4
    35f0:	edc50513          	addi	a0,a0,-292 # 74c8 <malloc+0x1448>
    35f4:	00002097          	auipc	ra,0x2
    35f8:	6be080e7          	jalr	1726(ra) # 5cb2 <mkdir>
    35fc:	04054563          	bltz	a0,3646 <dirtest+0x66>
  if (chdir("dir0") < 0) {
    3600:	00004517          	auipc	a0,0x4
    3604:	ec850513          	addi	a0,a0,-312 # 74c8 <malloc+0x1448>
    3608:	00002097          	auipc	ra,0x2
    360c:	6b2080e7          	jalr	1714(ra) # 5cba <chdir>
    3610:	04054963          	bltz	a0,3662 <dirtest+0x82>
  if (chdir("..") < 0) {
    3614:	00004517          	auipc	a0,0x4
    3618:	ed450513          	addi	a0,a0,-300 # 74e8 <malloc+0x1468>
    361c:	00002097          	auipc	ra,0x2
    3620:	69e080e7          	jalr	1694(ra) # 5cba <chdir>
    3624:	04054d63          	bltz	a0,367e <dirtest+0x9e>
  if (unlink("dir0") < 0) {
    3628:	00004517          	auipc	a0,0x4
    362c:	ea050513          	addi	a0,a0,-352 # 74c8 <malloc+0x1448>
    3630:	00002097          	auipc	ra,0x2
    3634:	66a080e7          	jalr	1642(ra) # 5c9a <unlink>
    3638:	06054163          	bltz	a0,369a <dirtest+0xba>
}
    363c:	60e2                	ld	ra,24(sp)
    363e:	6442                	ld	s0,16(sp)
    3640:	64a2                	ld	s1,8(sp)
    3642:	6105                	addi	sp,sp,32
    3644:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3646:	85a6                	mv	a1,s1
    3648:	00004517          	auipc	a0,0x4
    364c:	de050513          	addi	a0,a0,-544 # 7428 <malloc+0x13a8>
    3650:	00003097          	auipc	ra,0x3
    3654:	972080e7          	jalr	-1678(ra) # 5fc2 <printf>
    exit(1);
    3658:	4505                	li	a0,1
    365a:	00002097          	auipc	ra,0x2
    365e:	5f0080e7          	jalr	1520(ra) # 5c4a <exit>
    printf("%s: chdir dir0 failed\n", s);
    3662:	85a6                	mv	a1,s1
    3664:	00004517          	auipc	a0,0x4
    3668:	e6c50513          	addi	a0,a0,-404 # 74d0 <malloc+0x1450>
    366c:	00003097          	auipc	ra,0x3
    3670:	956080e7          	jalr	-1706(ra) # 5fc2 <printf>
    exit(1);
    3674:	4505                	li	a0,1
    3676:	00002097          	auipc	ra,0x2
    367a:	5d4080e7          	jalr	1492(ra) # 5c4a <exit>
    printf("%s: chdir .. failed\n", s);
    367e:	85a6                	mv	a1,s1
    3680:	00004517          	auipc	a0,0x4
    3684:	e7050513          	addi	a0,a0,-400 # 74f0 <malloc+0x1470>
    3688:	00003097          	auipc	ra,0x3
    368c:	93a080e7          	jalr	-1734(ra) # 5fc2 <printf>
    exit(1);
    3690:	4505                	li	a0,1
    3692:	00002097          	auipc	ra,0x2
    3696:	5b8080e7          	jalr	1464(ra) # 5c4a <exit>
    printf("%s: unlink dir0 failed\n", s);
    369a:	85a6                	mv	a1,s1
    369c:	00004517          	auipc	a0,0x4
    36a0:	e6c50513          	addi	a0,a0,-404 # 7508 <malloc+0x1488>
    36a4:	00003097          	auipc	ra,0x3
    36a8:	91e080e7          	jalr	-1762(ra) # 5fc2 <printf>
    exit(1);
    36ac:	4505                	li	a0,1
    36ae:	00002097          	auipc	ra,0x2
    36b2:	59c080e7          	jalr	1436(ra) # 5c4a <exit>

00000000000036b6 <subdir>:
void subdir(char *s) {
    36b6:	1101                	addi	sp,sp,-32
    36b8:	ec06                	sd	ra,24(sp)
    36ba:	e822                	sd	s0,16(sp)
    36bc:	e426                	sd	s1,8(sp)
    36be:	e04a                	sd	s2,0(sp)
    36c0:	1000                	addi	s0,sp,32
    36c2:	892a                	mv	s2,a0
  unlink("ff");
    36c4:	00004517          	auipc	a0,0x4
    36c8:	f8c50513          	addi	a0,a0,-116 # 7650 <malloc+0x15d0>
    36cc:	00002097          	auipc	ra,0x2
    36d0:	5ce080e7          	jalr	1486(ra) # 5c9a <unlink>
  if (mkdir("dd") != 0) {
    36d4:	00004517          	auipc	a0,0x4
    36d8:	e4c50513          	addi	a0,a0,-436 # 7520 <malloc+0x14a0>
    36dc:	00002097          	auipc	ra,0x2
    36e0:	5d6080e7          	jalr	1494(ra) # 5cb2 <mkdir>
    36e4:	38051663          	bnez	a0,3a70 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    36e8:	20200593          	li	a1,514
    36ec:	00004517          	auipc	a0,0x4
    36f0:	e5450513          	addi	a0,a0,-428 # 7540 <malloc+0x14c0>
    36f4:	00002097          	auipc	ra,0x2
    36f8:	596080e7          	jalr	1430(ra) # 5c8a <open>
    36fc:	84aa                	mv	s1,a0
  if (fd < 0) {
    36fe:	38054763          	bltz	a0,3a8c <subdir+0x3d6>
  write(fd, "ff", 2);
    3702:	4609                	li	a2,2
    3704:	00004597          	auipc	a1,0x4
    3708:	f4c58593          	addi	a1,a1,-180 # 7650 <malloc+0x15d0>
    370c:	00002097          	auipc	ra,0x2
    3710:	55e080e7          	jalr	1374(ra) # 5c6a <write>
  close(fd);
    3714:	8526                	mv	a0,s1
    3716:	00002097          	auipc	ra,0x2
    371a:	55c080e7          	jalr	1372(ra) # 5c72 <close>
  if (unlink("dd") >= 0) {
    371e:	00004517          	auipc	a0,0x4
    3722:	e0250513          	addi	a0,a0,-510 # 7520 <malloc+0x14a0>
    3726:	00002097          	auipc	ra,0x2
    372a:	574080e7          	jalr	1396(ra) # 5c9a <unlink>
    372e:	36055d63          	bgez	a0,3aa8 <subdir+0x3f2>
  if (mkdir("/dd/dd") != 0) {
    3732:	00004517          	auipc	a0,0x4
    3736:	e6650513          	addi	a0,a0,-410 # 7598 <malloc+0x1518>
    373a:	00002097          	auipc	ra,0x2
    373e:	578080e7          	jalr	1400(ra) # 5cb2 <mkdir>
    3742:	38051163          	bnez	a0,3ac4 <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3746:	20200593          	li	a1,514
    374a:	00004517          	auipc	a0,0x4
    374e:	e7650513          	addi	a0,a0,-394 # 75c0 <malloc+0x1540>
    3752:	00002097          	auipc	ra,0x2
    3756:	538080e7          	jalr	1336(ra) # 5c8a <open>
    375a:	84aa                	mv	s1,a0
  if (fd < 0) {
    375c:	38054263          	bltz	a0,3ae0 <subdir+0x42a>
  write(fd, "FF", 2);
    3760:	4609                	li	a2,2
    3762:	00004597          	auipc	a1,0x4
    3766:	e8e58593          	addi	a1,a1,-370 # 75f0 <malloc+0x1570>
    376a:	00002097          	auipc	ra,0x2
    376e:	500080e7          	jalr	1280(ra) # 5c6a <write>
  close(fd);
    3772:	8526                	mv	a0,s1
    3774:	00002097          	auipc	ra,0x2
    3778:	4fe080e7          	jalr	1278(ra) # 5c72 <close>
  fd = open("dd/dd/../ff", 0);
    377c:	4581                	li	a1,0
    377e:	00004517          	auipc	a0,0x4
    3782:	e7a50513          	addi	a0,a0,-390 # 75f8 <malloc+0x1578>
    3786:	00002097          	auipc	ra,0x2
    378a:	504080e7          	jalr	1284(ra) # 5c8a <open>
    378e:	84aa                	mv	s1,a0
  if (fd < 0) {
    3790:	36054663          	bltz	a0,3afc <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    3794:	660d                	lui	a2,0x3
    3796:	00009597          	auipc	a1,0x9
    379a:	4e258593          	addi	a1,a1,1250 # cc78 <buf>
    379e:	00002097          	auipc	ra,0x2
    37a2:	4c4080e7          	jalr	1220(ra) # 5c62 <read>
  if (cc != 2 || buf[0] != 'f') {
    37a6:	4789                	li	a5,2
    37a8:	36f51863          	bne	a0,a5,3b18 <subdir+0x462>
    37ac:	00009717          	auipc	a4,0x9
    37b0:	4cc74703          	lbu	a4,1228(a4) # cc78 <buf>
    37b4:	06600793          	li	a5,102
    37b8:	36f71063          	bne	a4,a5,3b18 <subdir+0x462>
  close(fd);
    37bc:	8526                	mv	a0,s1
    37be:	00002097          	auipc	ra,0x2
    37c2:	4b4080e7          	jalr	1204(ra) # 5c72 <close>
  if (link("dd/dd/ff", "dd/dd/ffff") != 0) {
    37c6:	00004597          	auipc	a1,0x4
    37ca:	e8258593          	addi	a1,a1,-382 # 7648 <malloc+0x15c8>
    37ce:	00004517          	auipc	a0,0x4
    37d2:	df250513          	addi	a0,a0,-526 # 75c0 <malloc+0x1540>
    37d6:	00002097          	auipc	ra,0x2
    37da:	4d4080e7          	jalr	1236(ra) # 5caa <link>
    37de:	34051b63          	bnez	a0,3b34 <subdir+0x47e>
  if (unlink("dd/dd/ff") != 0) {
    37e2:	00004517          	auipc	a0,0x4
    37e6:	dde50513          	addi	a0,a0,-546 # 75c0 <malloc+0x1540>
    37ea:	00002097          	auipc	ra,0x2
    37ee:	4b0080e7          	jalr	1200(ra) # 5c9a <unlink>
    37f2:	34051f63          	bnez	a0,3b50 <subdir+0x49a>
  if (open("dd/dd/ff", O_RDONLY) >= 0) {
    37f6:	4581                	li	a1,0
    37f8:	00004517          	auipc	a0,0x4
    37fc:	dc850513          	addi	a0,a0,-568 # 75c0 <malloc+0x1540>
    3800:	00002097          	auipc	ra,0x2
    3804:	48a080e7          	jalr	1162(ra) # 5c8a <open>
    3808:	36055263          	bgez	a0,3b6c <subdir+0x4b6>
  if (chdir("dd") != 0) {
    380c:	00004517          	auipc	a0,0x4
    3810:	d1450513          	addi	a0,a0,-748 # 7520 <malloc+0x14a0>
    3814:	00002097          	auipc	ra,0x2
    3818:	4a6080e7          	jalr	1190(ra) # 5cba <chdir>
    381c:	36051663          	bnez	a0,3b88 <subdir+0x4d2>
  if (chdir("dd/../../dd") != 0) {
    3820:	00004517          	auipc	a0,0x4
    3824:	ec050513          	addi	a0,a0,-320 # 76e0 <malloc+0x1660>
    3828:	00002097          	auipc	ra,0x2
    382c:	492080e7          	jalr	1170(ra) # 5cba <chdir>
    3830:	36051a63          	bnez	a0,3ba4 <subdir+0x4ee>
  if (chdir("dd/../../../dd") != 0) {
    3834:	00004517          	auipc	a0,0x4
    3838:	edc50513          	addi	a0,a0,-292 # 7710 <malloc+0x1690>
    383c:	00002097          	auipc	ra,0x2
    3840:	47e080e7          	jalr	1150(ra) # 5cba <chdir>
    3844:	36051e63          	bnez	a0,3bc0 <subdir+0x50a>
  if (chdir("./..") != 0) {
    3848:	00004517          	auipc	a0,0x4
    384c:	ef850513          	addi	a0,a0,-264 # 7740 <malloc+0x16c0>
    3850:	00002097          	auipc	ra,0x2
    3854:	46a080e7          	jalr	1130(ra) # 5cba <chdir>
    3858:	38051263          	bnez	a0,3bdc <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    385c:	4581                	li	a1,0
    385e:	00004517          	auipc	a0,0x4
    3862:	dea50513          	addi	a0,a0,-534 # 7648 <malloc+0x15c8>
    3866:	00002097          	auipc	ra,0x2
    386a:	424080e7          	jalr	1060(ra) # 5c8a <open>
    386e:	84aa                	mv	s1,a0
  if (fd < 0) {
    3870:	38054463          	bltz	a0,3bf8 <subdir+0x542>
  if (read(fd, buf, sizeof(buf)) != 2) {
    3874:	660d                	lui	a2,0x3
    3876:	00009597          	auipc	a1,0x9
    387a:	40258593          	addi	a1,a1,1026 # cc78 <buf>
    387e:	00002097          	auipc	ra,0x2
    3882:	3e4080e7          	jalr	996(ra) # 5c62 <read>
    3886:	4789                	li	a5,2
    3888:	38f51663          	bne	a0,a5,3c14 <subdir+0x55e>
  close(fd);
    388c:	8526                	mv	a0,s1
    388e:	00002097          	auipc	ra,0x2
    3892:	3e4080e7          	jalr	996(ra) # 5c72 <close>
  if (open("dd/dd/ff", O_RDONLY) >= 0) {
    3896:	4581                	li	a1,0
    3898:	00004517          	auipc	a0,0x4
    389c:	d2850513          	addi	a0,a0,-728 # 75c0 <malloc+0x1540>
    38a0:	00002097          	auipc	ra,0x2
    38a4:	3ea080e7          	jalr	1002(ra) # 5c8a <open>
    38a8:	38055463          	bgez	a0,3c30 <subdir+0x57a>
  if (open("dd/ff/ff", O_CREATE | O_RDWR) >= 0) {
    38ac:	20200593          	li	a1,514
    38b0:	00004517          	auipc	a0,0x4
    38b4:	f2050513          	addi	a0,a0,-224 # 77d0 <malloc+0x1750>
    38b8:	00002097          	auipc	ra,0x2
    38bc:	3d2080e7          	jalr	978(ra) # 5c8a <open>
    38c0:	38055663          	bgez	a0,3c4c <subdir+0x596>
  if (open("dd/xx/ff", O_CREATE | O_RDWR) >= 0) {
    38c4:	20200593          	li	a1,514
    38c8:	00004517          	auipc	a0,0x4
    38cc:	f3850513          	addi	a0,a0,-200 # 7800 <malloc+0x1780>
    38d0:	00002097          	auipc	ra,0x2
    38d4:	3ba080e7          	jalr	954(ra) # 5c8a <open>
    38d8:	38055863          	bgez	a0,3c68 <subdir+0x5b2>
  if (open("dd", O_CREATE) >= 0) {
    38dc:	20000593          	li	a1,512
    38e0:	00004517          	auipc	a0,0x4
    38e4:	c4050513          	addi	a0,a0,-960 # 7520 <malloc+0x14a0>
    38e8:	00002097          	auipc	ra,0x2
    38ec:	3a2080e7          	jalr	930(ra) # 5c8a <open>
    38f0:	38055a63          	bgez	a0,3c84 <subdir+0x5ce>
  if (open("dd", O_RDWR) >= 0) {
    38f4:	4589                	li	a1,2
    38f6:	00004517          	auipc	a0,0x4
    38fa:	c2a50513          	addi	a0,a0,-982 # 7520 <malloc+0x14a0>
    38fe:	00002097          	auipc	ra,0x2
    3902:	38c080e7          	jalr	908(ra) # 5c8a <open>
    3906:	38055d63          	bgez	a0,3ca0 <subdir+0x5ea>
  if (open("dd", O_WRONLY) >= 0) {
    390a:	4585                	li	a1,1
    390c:	00004517          	auipc	a0,0x4
    3910:	c1450513          	addi	a0,a0,-1004 # 7520 <malloc+0x14a0>
    3914:	00002097          	auipc	ra,0x2
    3918:	376080e7          	jalr	886(ra) # 5c8a <open>
    391c:	3a055063          	bgez	a0,3cbc <subdir+0x606>
  if (link("dd/ff/ff", "dd/dd/xx") == 0) {
    3920:	00004597          	auipc	a1,0x4
    3924:	f7058593          	addi	a1,a1,-144 # 7890 <malloc+0x1810>
    3928:	00004517          	auipc	a0,0x4
    392c:	ea850513          	addi	a0,a0,-344 # 77d0 <malloc+0x1750>
    3930:	00002097          	auipc	ra,0x2
    3934:	37a080e7          	jalr	890(ra) # 5caa <link>
    3938:	3a050063          	beqz	a0,3cd8 <subdir+0x622>
  if (link("dd/xx/ff", "dd/dd/xx") == 0) {
    393c:	00004597          	auipc	a1,0x4
    3940:	f5458593          	addi	a1,a1,-172 # 7890 <malloc+0x1810>
    3944:	00004517          	auipc	a0,0x4
    3948:	ebc50513          	addi	a0,a0,-324 # 7800 <malloc+0x1780>
    394c:	00002097          	auipc	ra,0x2
    3950:	35e080e7          	jalr	862(ra) # 5caa <link>
    3954:	3a050063          	beqz	a0,3cf4 <subdir+0x63e>
  if (link("dd/ff", "dd/dd/ffff") == 0) {
    3958:	00004597          	auipc	a1,0x4
    395c:	cf058593          	addi	a1,a1,-784 # 7648 <malloc+0x15c8>
    3960:	00004517          	auipc	a0,0x4
    3964:	be050513          	addi	a0,a0,-1056 # 7540 <malloc+0x14c0>
    3968:	00002097          	auipc	ra,0x2
    396c:	342080e7          	jalr	834(ra) # 5caa <link>
    3970:	3a050063          	beqz	a0,3d10 <subdir+0x65a>
  if (mkdir("dd/ff/ff") == 0) {
    3974:	00004517          	auipc	a0,0x4
    3978:	e5c50513          	addi	a0,a0,-420 # 77d0 <malloc+0x1750>
    397c:	00002097          	auipc	ra,0x2
    3980:	336080e7          	jalr	822(ra) # 5cb2 <mkdir>
    3984:	3a050463          	beqz	a0,3d2c <subdir+0x676>
  if (mkdir("dd/xx/ff") == 0) {
    3988:	00004517          	auipc	a0,0x4
    398c:	e7850513          	addi	a0,a0,-392 # 7800 <malloc+0x1780>
    3990:	00002097          	auipc	ra,0x2
    3994:	322080e7          	jalr	802(ra) # 5cb2 <mkdir>
    3998:	3a050863          	beqz	a0,3d48 <subdir+0x692>
  if (mkdir("dd/dd/ffff") == 0) {
    399c:	00004517          	auipc	a0,0x4
    39a0:	cac50513          	addi	a0,a0,-852 # 7648 <malloc+0x15c8>
    39a4:	00002097          	auipc	ra,0x2
    39a8:	30e080e7          	jalr	782(ra) # 5cb2 <mkdir>
    39ac:	3a050c63          	beqz	a0,3d64 <subdir+0x6ae>
  if (unlink("dd/xx/ff") == 0) {
    39b0:	00004517          	auipc	a0,0x4
    39b4:	e5050513          	addi	a0,a0,-432 # 7800 <malloc+0x1780>
    39b8:	00002097          	auipc	ra,0x2
    39bc:	2e2080e7          	jalr	738(ra) # 5c9a <unlink>
    39c0:	3c050063          	beqz	a0,3d80 <subdir+0x6ca>
  if (unlink("dd/ff/ff") == 0) {
    39c4:	00004517          	auipc	a0,0x4
    39c8:	e0c50513          	addi	a0,a0,-500 # 77d0 <malloc+0x1750>
    39cc:	00002097          	auipc	ra,0x2
    39d0:	2ce080e7          	jalr	718(ra) # 5c9a <unlink>
    39d4:	3c050463          	beqz	a0,3d9c <subdir+0x6e6>
  if (chdir("dd/ff") == 0) {
    39d8:	00004517          	auipc	a0,0x4
    39dc:	b6850513          	addi	a0,a0,-1176 # 7540 <malloc+0x14c0>
    39e0:	00002097          	auipc	ra,0x2
    39e4:	2da080e7          	jalr	730(ra) # 5cba <chdir>
    39e8:	3c050863          	beqz	a0,3db8 <subdir+0x702>
  if (chdir("dd/xx") == 0) {
    39ec:	00004517          	auipc	a0,0x4
    39f0:	ff450513          	addi	a0,a0,-12 # 79e0 <malloc+0x1960>
    39f4:	00002097          	auipc	ra,0x2
    39f8:	2c6080e7          	jalr	710(ra) # 5cba <chdir>
    39fc:	3c050c63          	beqz	a0,3dd4 <subdir+0x71e>
  if (unlink("dd/dd/ffff") != 0) {
    3a00:	00004517          	auipc	a0,0x4
    3a04:	c4850513          	addi	a0,a0,-952 # 7648 <malloc+0x15c8>
    3a08:	00002097          	auipc	ra,0x2
    3a0c:	292080e7          	jalr	658(ra) # 5c9a <unlink>
    3a10:	3e051063          	bnez	a0,3df0 <subdir+0x73a>
  if (unlink("dd/ff") != 0) {
    3a14:	00004517          	auipc	a0,0x4
    3a18:	b2c50513          	addi	a0,a0,-1236 # 7540 <malloc+0x14c0>
    3a1c:	00002097          	auipc	ra,0x2
    3a20:	27e080e7          	jalr	638(ra) # 5c9a <unlink>
    3a24:	3e051463          	bnez	a0,3e0c <subdir+0x756>
  if (unlink("dd") == 0) {
    3a28:	00004517          	auipc	a0,0x4
    3a2c:	af850513          	addi	a0,a0,-1288 # 7520 <malloc+0x14a0>
    3a30:	00002097          	auipc	ra,0x2
    3a34:	26a080e7          	jalr	618(ra) # 5c9a <unlink>
    3a38:	3e050863          	beqz	a0,3e28 <subdir+0x772>
  if (unlink("dd/dd") < 0) {
    3a3c:	00004517          	auipc	a0,0x4
    3a40:	01450513          	addi	a0,a0,20 # 7a50 <malloc+0x19d0>
    3a44:	00002097          	auipc	ra,0x2
    3a48:	256080e7          	jalr	598(ra) # 5c9a <unlink>
    3a4c:	3e054c63          	bltz	a0,3e44 <subdir+0x78e>
  if (unlink("dd") < 0) {
    3a50:	00004517          	auipc	a0,0x4
    3a54:	ad050513          	addi	a0,a0,-1328 # 7520 <malloc+0x14a0>
    3a58:	00002097          	auipc	ra,0x2
    3a5c:	242080e7          	jalr	578(ra) # 5c9a <unlink>
    3a60:	40054063          	bltz	a0,3e60 <subdir+0x7aa>
}
    3a64:	60e2                	ld	ra,24(sp)
    3a66:	6442                	ld	s0,16(sp)
    3a68:	64a2                	ld	s1,8(sp)
    3a6a:	6902                	ld	s2,0(sp)
    3a6c:	6105                	addi	sp,sp,32
    3a6e:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3a70:	85ca                	mv	a1,s2
    3a72:	00004517          	auipc	a0,0x4
    3a76:	ab650513          	addi	a0,a0,-1354 # 7528 <malloc+0x14a8>
    3a7a:	00002097          	auipc	ra,0x2
    3a7e:	548080e7          	jalr	1352(ra) # 5fc2 <printf>
    exit(1);
    3a82:	4505                	li	a0,1
    3a84:	00002097          	auipc	ra,0x2
    3a88:	1c6080e7          	jalr	454(ra) # 5c4a <exit>
    printf("%s: create dd/ff failed\n", s);
    3a8c:	85ca                	mv	a1,s2
    3a8e:	00004517          	auipc	a0,0x4
    3a92:	aba50513          	addi	a0,a0,-1350 # 7548 <malloc+0x14c8>
    3a96:	00002097          	auipc	ra,0x2
    3a9a:	52c080e7          	jalr	1324(ra) # 5fc2 <printf>
    exit(1);
    3a9e:	4505                	li	a0,1
    3aa0:	00002097          	auipc	ra,0x2
    3aa4:	1aa080e7          	jalr	426(ra) # 5c4a <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3aa8:	85ca                	mv	a1,s2
    3aaa:	00004517          	auipc	a0,0x4
    3aae:	abe50513          	addi	a0,a0,-1346 # 7568 <malloc+0x14e8>
    3ab2:	00002097          	auipc	ra,0x2
    3ab6:	510080e7          	jalr	1296(ra) # 5fc2 <printf>
    exit(1);
    3aba:	4505                	li	a0,1
    3abc:	00002097          	auipc	ra,0x2
    3ac0:	18e080e7          	jalr	398(ra) # 5c4a <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3ac4:	85ca                	mv	a1,s2
    3ac6:	00004517          	auipc	a0,0x4
    3aca:	ada50513          	addi	a0,a0,-1318 # 75a0 <malloc+0x1520>
    3ace:	00002097          	auipc	ra,0x2
    3ad2:	4f4080e7          	jalr	1268(ra) # 5fc2 <printf>
    exit(1);
    3ad6:	4505                	li	a0,1
    3ad8:	00002097          	auipc	ra,0x2
    3adc:	172080e7          	jalr	370(ra) # 5c4a <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3ae0:	85ca                	mv	a1,s2
    3ae2:	00004517          	auipc	a0,0x4
    3ae6:	aee50513          	addi	a0,a0,-1298 # 75d0 <malloc+0x1550>
    3aea:	00002097          	auipc	ra,0x2
    3aee:	4d8080e7          	jalr	1240(ra) # 5fc2 <printf>
    exit(1);
    3af2:	4505                	li	a0,1
    3af4:	00002097          	auipc	ra,0x2
    3af8:	156080e7          	jalr	342(ra) # 5c4a <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3afc:	85ca                	mv	a1,s2
    3afe:	00004517          	auipc	a0,0x4
    3b02:	b0a50513          	addi	a0,a0,-1270 # 7608 <malloc+0x1588>
    3b06:	00002097          	auipc	ra,0x2
    3b0a:	4bc080e7          	jalr	1212(ra) # 5fc2 <printf>
    exit(1);
    3b0e:	4505                	li	a0,1
    3b10:	00002097          	auipc	ra,0x2
    3b14:	13a080e7          	jalr	314(ra) # 5c4a <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3b18:	85ca                	mv	a1,s2
    3b1a:	00004517          	auipc	a0,0x4
    3b1e:	b0e50513          	addi	a0,a0,-1266 # 7628 <malloc+0x15a8>
    3b22:	00002097          	auipc	ra,0x2
    3b26:	4a0080e7          	jalr	1184(ra) # 5fc2 <printf>
    exit(1);
    3b2a:	4505                	li	a0,1
    3b2c:	00002097          	auipc	ra,0x2
    3b30:	11e080e7          	jalr	286(ra) # 5c4a <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3b34:	85ca                	mv	a1,s2
    3b36:	00004517          	auipc	a0,0x4
    3b3a:	b2250513          	addi	a0,a0,-1246 # 7658 <malloc+0x15d8>
    3b3e:	00002097          	auipc	ra,0x2
    3b42:	484080e7          	jalr	1156(ra) # 5fc2 <printf>
    exit(1);
    3b46:	4505                	li	a0,1
    3b48:	00002097          	auipc	ra,0x2
    3b4c:	102080e7          	jalr	258(ra) # 5c4a <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3b50:	85ca                	mv	a1,s2
    3b52:	00004517          	auipc	a0,0x4
    3b56:	b2e50513          	addi	a0,a0,-1234 # 7680 <malloc+0x1600>
    3b5a:	00002097          	auipc	ra,0x2
    3b5e:	468080e7          	jalr	1128(ra) # 5fc2 <printf>
    exit(1);
    3b62:	4505                	li	a0,1
    3b64:	00002097          	auipc	ra,0x2
    3b68:	0e6080e7          	jalr	230(ra) # 5c4a <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3b6c:	85ca                	mv	a1,s2
    3b6e:	00004517          	auipc	a0,0x4
    3b72:	b3250513          	addi	a0,a0,-1230 # 76a0 <malloc+0x1620>
    3b76:	00002097          	auipc	ra,0x2
    3b7a:	44c080e7          	jalr	1100(ra) # 5fc2 <printf>
    exit(1);
    3b7e:	4505                	li	a0,1
    3b80:	00002097          	auipc	ra,0x2
    3b84:	0ca080e7          	jalr	202(ra) # 5c4a <exit>
    printf("%s: chdir dd failed\n", s);
    3b88:	85ca                	mv	a1,s2
    3b8a:	00004517          	auipc	a0,0x4
    3b8e:	b3e50513          	addi	a0,a0,-1218 # 76c8 <malloc+0x1648>
    3b92:	00002097          	auipc	ra,0x2
    3b96:	430080e7          	jalr	1072(ra) # 5fc2 <printf>
    exit(1);
    3b9a:	4505                	li	a0,1
    3b9c:	00002097          	auipc	ra,0x2
    3ba0:	0ae080e7          	jalr	174(ra) # 5c4a <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3ba4:	85ca                	mv	a1,s2
    3ba6:	00004517          	auipc	a0,0x4
    3baa:	b4a50513          	addi	a0,a0,-1206 # 76f0 <malloc+0x1670>
    3bae:	00002097          	auipc	ra,0x2
    3bb2:	414080e7          	jalr	1044(ra) # 5fc2 <printf>
    exit(1);
    3bb6:	4505                	li	a0,1
    3bb8:	00002097          	auipc	ra,0x2
    3bbc:	092080e7          	jalr	146(ra) # 5c4a <exit>
    printf("chdir dd/../../dd failed\n", s);
    3bc0:	85ca                	mv	a1,s2
    3bc2:	00004517          	auipc	a0,0x4
    3bc6:	b5e50513          	addi	a0,a0,-1186 # 7720 <malloc+0x16a0>
    3bca:	00002097          	auipc	ra,0x2
    3bce:	3f8080e7          	jalr	1016(ra) # 5fc2 <printf>
    exit(1);
    3bd2:	4505                	li	a0,1
    3bd4:	00002097          	auipc	ra,0x2
    3bd8:	076080e7          	jalr	118(ra) # 5c4a <exit>
    printf("%s: chdir ./.. failed\n", s);
    3bdc:	85ca                	mv	a1,s2
    3bde:	00004517          	auipc	a0,0x4
    3be2:	b6a50513          	addi	a0,a0,-1174 # 7748 <malloc+0x16c8>
    3be6:	00002097          	auipc	ra,0x2
    3bea:	3dc080e7          	jalr	988(ra) # 5fc2 <printf>
    exit(1);
    3bee:	4505                	li	a0,1
    3bf0:	00002097          	auipc	ra,0x2
    3bf4:	05a080e7          	jalr	90(ra) # 5c4a <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3bf8:	85ca                	mv	a1,s2
    3bfa:	00004517          	auipc	a0,0x4
    3bfe:	b6650513          	addi	a0,a0,-1178 # 7760 <malloc+0x16e0>
    3c02:	00002097          	auipc	ra,0x2
    3c06:	3c0080e7          	jalr	960(ra) # 5fc2 <printf>
    exit(1);
    3c0a:	4505                	li	a0,1
    3c0c:	00002097          	auipc	ra,0x2
    3c10:	03e080e7          	jalr	62(ra) # 5c4a <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3c14:	85ca                	mv	a1,s2
    3c16:	00004517          	auipc	a0,0x4
    3c1a:	b6a50513          	addi	a0,a0,-1174 # 7780 <malloc+0x1700>
    3c1e:	00002097          	auipc	ra,0x2
    3c22:	3a4080e7          	jalr	932(ra) # 5fc2 <printf>
    exit(1);
    3c26:	4505                	li	a0,1
    3c28:	00002097          	auipc	ra,0x2
    3c2c:	022080e7          	jalr	34(ra) # 5c4a <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3c30:	85ca                	mv	a1,s2
    3c32:	00004517          	auipc	a0,0x4
    3c36:	b6e50513          	addi	a0,a0,-1170 # 77a0 <malloc+0x1720>
    3c3a:	00002097          	auipc	ra,0x2
    3c3e:	388080e7          	jalr	904(ra) # 5fc2 <printf>
    exit(1);
    3c42:	4505                	li	a0,1
    3c44:	00002097          	auipc	ra,0x2
    3c48:	006080e7          	jalr	6(ra) # 5c4a <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3c4c:	85ca                	mv	a1,s2
    3c4e:	00004517          	auipc	a0,0x4
    3c52:	b9250513          	addi	a0,a0,-1134 # 77e0 <malloc+0x1760>
    3c56:	00002097          	auipc	ra,0x2
    3c5a:	36c080e7          	jalr	876(ra) # 5fc2 <printf>
    exit(1);
    3c5e:	4505                	li	a0,1
    3c60:	00002097          	auipc	ra,0x2
    3c64:	fea080e7          	jalr	-22(ra) # 5c4a <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3c68:	85ca                	mv	a1,s2
    3c6a:	00004517          	auipc	a0,0x4
    3c6e:	ba650513          	addi	a0,a0,-1114 # 7810 <malloc+0x1790>
    3c72:	00002097          	auipc	ra,0x2
    3c76:	350080e7          	jalr	848(ra) # 5fc2 <printf>
    exit(1);
    3c7a:	4505                	li	a0,1
    3c7c:	00002097          	auipc	ra,0x2
    3c80:	fce080e7          	jalr	-50(ra) # 5c4a <exit>
    printf("%s: create dd succeeded!\n", s);
    3c84:	85ca                	mv	a1,s2
    3c86:	00004517          	auipc	a0,0x4
    3c8a:	baa50513          	addi	a0,a0,-1110 # 7830 <malloc+0x17b0>
    3c8e:	00002097          	auipc	ra,0x2
    3c92:	334080e7          	jalr	820(ra) # 5fc2 <printf>
    exit(1);
    3c96:	4505                	li	a0,1
    3c98:	00002097          	auipc	ra,0x2
    3c9c:	fb2080e7          	jalr	-78(ra) # 5c4a <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3ca0:	85ca                	mv	a1,s2
    3ca2:	00004517          	auipc	a0,0x4
    3ca6:	bae50513          	addi	a0,a0,-1106 # 7850 <malloc+0x17d0>
    3caa:	00002097          	auipc	ra,0x2
    3cae:	318080e7          	jalr	792(ra) # 5fc2 <printf>
    exit(1);
    3cb2:	4505                	li	a0,1
    3cb4:	00002097          	auipc	ra,0x2
    3cb8:	f96080e7          	jalr	-106(ra) # 5c4a <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3cbc:	85ca                	mv	a1,s2
    3cbe:	00004517          	auipc	a0,0x4
    3cc2:	bb250513          	addi	a0,a0,-1102 # 7870 <malloc+0x17f0>
    3cc6:	00002097          	auipc	ra,0x2
    3cca:	2fc080e7          	jalr	764(ra) # 5fc2 <printf>
    exit(1);
    3cce:	4505                	li	a0,1
    3cd0:	00002097          	auipc	ra,0x2
    3cd4:	f7a080e7          	jalr	-134(ra) # 5c4a <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3cd8:	85ca                	mv	a1,s2
    3cda:	00004517          	auipc	a0,0x4
    3cde:	bc650513          	addi	a0,a0,-1082 # 78a0 <malloc+0x1820>
    3ce2:	00002097          	auipc	ra,0x2
    3ce6:	2e0080e7          	jalr	736(ra) # 5fc2 <printf>
    exit(1);
    3cea:	4505                	li	a0,1
    3cec:	00002097          	auipc	ra,0x2
    3cf0:	f5e080e7          	jalr	-162(ra) # 5c4a <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3cf4:	85ca                	mv	a1,s2
    3cf6:	00004517          	auipc	a0,0x4
    3cfa:	bd250513          	addi	a0,a0,-1070 # 78c8 <malloc+0x1848>
    3cfe:	00002097          	auipc	ra,0x2
    3d02:	2c4080e7          	jalr	708(ra) # 5fc2 <printf>
    exit(1);
    3d06:	4505                	li	a0,1
    3d08:	00002097          	auipc	ra,0x2
    3d0c:	f42080e7          	jalr	-190(ra) # 5c4a <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3d10:	85ca                	mv	a1,s2
    3d12:	00004517          	auipc	a0,0x4
    3d16:	bde50513          	addi	a0,a0,-1058 # 78f0 <malloc+0x1870>
    3d1a:	00002097          	auipc	ra,0x2
    3d1e:	2a8080e7          	jalr	680(ra) # 5fc2 <printf>
    exit(1);
    3d22:	4505                	li	a0,1
    3d24:	00002097          	auipc	ra,0x2
    3d28:	f26080e7          	jalr	-218(ra) # 5c4a <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3d2c:	85ca                	mv	a1,s2
    3d2e:	00004517          	auipc	a0,0x4
    3d32:	bea50513          	addi	a0,a0,-1046 # 7918 <malloc+0x1898>
    3d36:	00002097          	auipc	ra,0x2
    3d3a:	28c080e7          	jalr	652(ra) # 5fc2 <printf>
    exit(1);
    3d3e:	4505                	li	a0,1
    3d40:	00002097          	auipc	ra,0x2
    3d44:	f0a080e7          	jalr	-246(ra) # 5c4a <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3d48:	85ca                	mv	a1,s2
    3d4a:	00004517          	auipc	a0,0x4
    3d4e:	bee50513          	addi	a0,a0,-1042 # 7938 <malloc+0x18b8>
    3d52:	00002097          	auipc	ra,0x2
    3d56:	270080e7          	jalr	624(ra) # 5fc2 <printf>
    exit(1);
    3d5a:	4505                	li	a0,1
    3d5c:	00002097          	auipc	ra,0x2
    3d60:	eee080e7          	jalr	-274(ra) # 5c4a <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3d64:	85ca                	mv	a1,s2
    3d66:	00004517          	auipc	a0,0x4
    3d6a:	bf250513          	addi	a0,a0,-1038 # 7958 <malloc+0x18d8>
    3d6e:	00002097          	auipc	ra,0x2
    3d72:	254080e7          	jalr	596(ra) # 5fc2 <printf>
    exit(1);
    3d76:	4505                	li	a0,1
    3d78:	00002097          	auipc	ra,0x2
    3d7c:	ed2080e7          	jalr	-302(ra) # 5c4a <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3d80:	85ca                	mv	a1,s2
    3d82:	00004517          	auipc	a0,0x4
    3d86:	bfe50513          	addi	a0,a0,-1026 # 7980 <malloc+0x1900>
    3d8a:	00002097          	auipc	ra,0x2
    3d8e:	238080e7          	jalr	568(ra) # 5fc2 <printf>
    exit(1);
    3d92:	4505                	li	a0,1
    3d94:	00002097          	auipc	ra,0x2
    3d98:	eb6080e7          	jalr	-330(ra) # 5c4a <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3d9c:	85ca                	mv	a1,s2
    3d9e:	00004517          	auipc	a0,0x4
    3da2:	c0250513          	addi	a0,a0,-1022 # 79a0 <malloc+0x1920>
    3da6:	00002097          	auipc	ra,0x2
    3daa:	21c080e7          	jalr	540(ra) # 5fc2 <printf>
    exit(1);
    3dae:	4505                	li	a0,1
    3db0:	00002097          	auipc	ra,0x2
    3db4:	e9a080e7          	jalr	-358(ra) # 5c4a <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3db8:	85ca                	mv	a1,s2
    3dba:	00004517          	auipc	a0,0x4
    3dbe:	c0650513          	addi	a0,a0,-1018 # 79c0 <malloc+0x1940>
    3dc2:	00002097          	auipc	ra,0x2
    3dc6:	200080e7          	jalr	512(ra) # 5fc2 <printf>
    exit(1);
    3dca:	4505                	li	a0,1
    3dcc:	00002097          	auipc	ra,0x2
    3dd0:	e7e080e7          	jalr	-386(ra) # 5c4a <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3dd4:	85ca                	mv	a1,s2
    3dd6:	00004517          	auipc	a0,0x4
    3dda:	c1250513          	addi	a0,a0,-1006 # 79e8 <malloc+0x1968>
    3dde:	00002097          	auipc	ra,0x2
    3de2:	1e4080e7          	jalr	484(ra) # 5fc2 <printf>
    exit(1);
    3de6:	4505                	li	a0,1
    3de8:	00002097          	auipc	ra,0x2
    3dec:	e62080e7          	jalr	-414(ra) # 5c4a <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3df0:	85ca                	mv	a1,s2
    3df2:	00004517          	auipc	a0,0x4
    3df6:	88e50513          	addi	a0,a0,-1906 # 7680 <malloc+0x1600>
    3dfa:	00002097          	auipc	ra,0x2
    3dfe:	1c8080e7          	jalr	456(ra) # 5fc2 <printf>
    exit(1);
    3e02:	4505                	li	a0,1
    3e04:	00002097          	auipc	ra,0x2
    3e08:	e46080e7          	jalr	-442(ra) # 5c4a <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3e0c:	85ca                	mv	a1,s2
    3e0e:	00004517          	auipc	a0,0x4
    3e12:	bfa50513          	addi	a0,a0,-1030 # 7a08 <malloc+0x1988>
    3e16:	00002097          	auipc	ra,0x2
    3e1a:	1ac080e7          	jalr	428(ra) # 5fc2 <printf>
    exit(1);
    3e1e:	4505                	li	a0,1
    3e20:	00002097          	auipc	ra,0x2
    3e24:	e2a080e7          	jalr	-470(ra) # 5c4a <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3e28:	85ca                	mv	a1,s2
    3e2a:	00004517          	auipc	a0,0x4
    3e2e:	bfe50513          	addi	a0,a0,-1026 # 7a28 <malloc+0x19a8>
    3e32:	00002097          	auipc	ra,0x2
    3e36:	190080e7          	jalr	400(ra) # 5fc2 <printf>
    exit(1);
    3e3a:	4505                	li	a0,1
    3e3c:	00002097          	auipc	ra,0x2
    3e40:	e0e080e7          	jalr	-498(ra) # 5c4a <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3e44:	85ca                	mv	a1,s2
    3e46:	00004517          	auipc	a0,0x4
    3e4a:	c1250513          	addi	a0,a0,-1006 # 7a58 <malloc+0x19d8>
    3e4e:	00002097          	auipc	ra,0x2
    3e52:	174080e7          	jalr	372(ra) # 5fc2 <printf>
    exit(1);
    3e56:	4505                	li	a0,1
    3e58:	00002097          	auipc	ra,0x2
    3e5c:	df2080e7          	jalr	-526(ra) # 5c4a <exit>
    printf("%s: unlink dd failed\n", s);
    3e60:	85ca                	mv	a1,s2
    3e62:	00004517          	auipc	a0,0x4
    3e66:	c1650513          	addi	a0,a0,-1002 # 7a78 <malloc+0x19f8>
    3e6a:	00002097          	auipc	ra,0x2
    3e6e:	158080e7          	jalr	344(ra) # 5fc2 <printf>
    exit(1);
    3e72:	4505                	li	a0,1
    3e74:	00002097          	auipc	ra,0x2
    3e78:	dd6080e7          	jalr	-554(ra) # 5c4a <exit>

0000000000003e7c <rmdot>:
void rmdot(char *s) {
    3e7c:	1101                	addi	sp,sp,-32
    3e7e:	ec06                	sd	ra,24(sp)
    3e80:	e822                	sd	s0,16(sp)
    3e82:	e426                	sd	s1,8(sp)
    3e84:	1000                	addi	s0,sp,32
    3e86:	84aa                	mv	s1,a0
  if (mkdir("dots") != 0) {
    3e88:	00004517          	auipc	a0,0x4
    3e8c:	c0850513          	addi	a0,a0,-1016 # 7a90 <malloc+0x1a10>
    3e90:	00002097          	auipc	ra,0x2
    3e94:	e22080e7          	jalr	-478(ra) # 5cb2 <mkdir>
    3e98:	e549                	bnez	a0,3f22 <rmdot+0xa6>
  if (chdir("dots") != 0) {
    3e9a:	00004517          	auipc	a0,0x4
    3e9e:	bf650513          	addi	a0,a0,-1034 # 7a90 <malloc+0x1a10>
    3ea2:	00002097          	auipc	ra,0x2
    3ea6:	e18080e7          	jalr	-488(ra) # 5cba <chdir>
    3eaa:	e951                	bnez	a0,3f3e <rmdot+0xc2>
  if (unlink(".") == 0) {
    3eac:	00003517          	auipc	a0,0x3
    3eb0:	a1450513          	addi	a0,a0,-1516 # 68c0 <malloc+0x840>
    3eb4:	00002097          	auipc	ra,0x2
    3eb8:	de6080e7          	jalr	-538(ra) # 5c9a <unlink>
    3ebc:	cd59                	beqz	a0,3f5a <rmdot+0xde>
  if (unlink("..") == 0) {
    3ebe:	00003517          	auipc	a0,0x3
    3ec2:	62a50513          	addi	a0,a0,1578 # 74e8 <malloc+0x1468>
    3ec6:	00002097          	auipc	ra,0x2
    3eca:	dd4080e7          	jalr	-556(ra) # 5c9a <unlink>
    3ece:	c545                	beqz	a0,3f76 <rmdot+0xfa>
  if (chdir("/") != 0) {
    3ed0:	00003517          	auipc	a0,0x3
    3ed4:	5c050513          	addi	a0,a0,1472 # 7490 <malloc+0x1410>
    3ed8:	00002097          	auipc	ra,0x2
    3edc:	de2080e7          	jalr	-542(ra) # 5cba <chdir>
    3ee0:	e94d                	bnez	a0,3f92 <rmdot+0x116>
  if (unlink("dots/.") == 0) {
    3ee2:	00004517          	auipc	a0,0x4
    3ee6:	c1650513          	addi	a0,a0,-1002 # 7af8 <malloc+0x1a78>
    3eea:	00002097          	auipc	ra,0x2
    3eee:	db0080e7          	jalr	-592(ra) # 5c9a <unlink>
    3ef2:	cd55                	beqz	a0,3fae <rmdot+0x132>
  if (unlink("dots/..") == 0) {
    3ef4:	00004517          	auipc	a0,0x4
    3ef8:	c2c50513          	addi	a0,a0,-980 # 7b20 <malloc+0x1aa0>
    3efc:	00002097          	auipc	ra,0x2
    3f00:	d9e080e7          	jalr	-610(ra) # 5c9a <unlink>
    3f04:	c179                	beqz	a0,3fca <rmdot+0x14e>
  if (unlink("dots") != 0) {
    3f06:	00004517          	auipc	a0,0x4
    3f0a:	b8a50513          	addi	a0,a0,-1142 # 7a90 <malloc+0x1a10>
    3f0e:	00002097          	auipc	ra,0x2
    3f12:	d8c080e7          	jalr	-628(ra) # 5c9a <unlink>
    3f16:	e961                	bnez	a0,3fe6 <rmdot+0x16a>
}
    3f18:	60e2                	ld	ra,24(sp)
    3f1a:	6442                	ld	s0,16(sp)
    3f1c:	64a2                	ld	s1,8(sp)
    3f1e:	6105                	addi	sp,sp,32
    3f20:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3f22:	85a6                	mv	a1,s1
    3f24:	00004517          	auipc	a0,0x4
    3f28:	b7450513          	addi	a0,a0,-1164 # 7a98 <malloc+0x1a18>
    3f2c:	00002097          	auipc	ra,0x2
    3f30:	096080e7          	jalr	150(ra) # 5fc2 <printf>
    exit(1);
    3f34:	4505                	li	a0,1
    3f36:	00002097          	auipc	ra,0x2
    3f3a:	d14080e7          	jalr	-748(ra) # 5c4a <exit>
    printf("%s: chdir dots failed\n", s);
    3f3e:	85a6                	mv	a1,s1
    3f40:	00004517          	auipc	a0,0x4
    3f44:	b7050513          	addi	a0,a0,-1168 # 7ab0 <malloc+0x1a30>
    3f48:	00002097          	auipc	ra,0x2
    3f4c:	07a080e7          	jalr	122(ra) # 5fc2 <printf>
    exit(1);
    3f50:	4505                	li	a0,1
    3f52:	00002097          	auipc	ra,0x2
    3f56:	cf8080e7          	jalr	-776(ra) # 5c4a <exit>
    printf("%s: rm . worked!\n", s);
    3f5a:	85a6                	mv	a1,s1
    3f5c:	00004517          	auipc	a0,0x4
    3f60:	b6c50513          	addi	a0,a0,-1172 # 7ac8 <malloc+0x1a48>
    3f64:	00002097          	auipc	ra,0x2
    3f68:	05e080e7          	jalr	94(ra) # 5fc2 <printf>
    exit(1);
    3f6c:	4505                	li	a0,1
    3f6e:	00002097          	auipc	ra,0x2
    3f72:	cdc080e7          	jalr	-804(ra) # 5c4a <exit>
    printf("%s: rm .. worked!\n", s);
    3f76:	85a6                	mv	a1,s1
    3f78:	00004517          	auipc	a0,0x4
    3f7c:	b6850513          	addi	a0,a0,-1176 # 7ae0 <malloc+0x1a60>
    3f80:	00002097          	auipc	ra,0x2
    3f84:	042080e7          	jalr	66(ra) # 5fc2 <printf>
    exit(1);
    3f88:	4505                	li	a0,1
    3f8a:	00002097          	auipc	ra,0x2
    3f8e:	cc0080e7          	jalr	-832(ra) # 5c4a <exit>
    printf("%s: chdir / failed\n", s);
    3f92:	85a6                	mv	a1,s1
    3f94:	00003517          	auipc	a0,0x3
    3f98:	50450513          	addi	a0,a0,1284 # 7498 <malloc+0x1418>
    3f9c:	00002097          	auipc	ra,0x2
    3fa0:	026080e7          	jalr	38(ra) # 5fc2 <printf>
    exit(1);
    3fa4:	4505                	li	a0,1
    3fa6:	00002097          	auipc	ra,0x2
    3faa:	ca4080e7          	jalr	-860(ra) # 5c4a <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3fae:	85a6                	mv	a1,s1
    3fb0:	00004517          	auipc	a0,0x4
    3fb4:	b5050513          	addi	a0,a0,-1200 # 7b00 <malloc+0x1a80>
    3fb8:	00002097          	auipc	ra,0x2
    3fbc:	00a080e7          	jalr	10(ra) # 5fc2 <printf>
    exit(1);
    3fc0:	4505                	li	a0,1
    3fc2:	00002097          	auipc	ra,0x2
    3fc6:	c88080e7          	jalr	-888(ra) # 5c4a <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3fca:	85a6                	mv	a1,s1
    3fcc:	00004517          	auipc	a0,0x4
    3fd0:	b5c50513          	addi	a0,a0,-1188 # 7b28 <malloc+0x1aa8>
    3fd4:	00002097          	auipc	ra,0x2
    3fd8:	fee080e7          	jalr	-18(ra) # 5fc2 <printf>
    exit(1);
    3fdc:	4505                	li	a0,1
    3fde:	00002097          	auipc	ra,0x2
    3fe2:	c6c080e7          	jalr	-916(ra) # 5c4a <exit>
    printf("%s: unlink dots failed!\n", s);
    3fe6:	85a6                	mv	a1,s1
    3fe8:	00004517          	auipc	a0,0x4
    3fec:	b6050513          	addi	a0,a0,-1184 # 7b48 <malloc+0x1ac8>
    3ff0:	00002097          	auipc	ra,0x2
    3ff4:	fd2080e7          	jalr	-46(ra) # 5fc2 <printf>
    exit(1);
    3ff8:	4505                	li	a0,1
    3ffa:	00002097          	auipc	ra,0x2
    3ffe:	c50080e7          	jalr	-944(ra) # 5c4a <exit>

0000000000004002 <dirfile>:
void dirfile(char *s) {
    4002:	1101                	addi	sp,sp,-32
    4004:	ec06                	sd	ra,24(sp)
    4006:	e822                	sd	s0,16(sp)
    4008:	e426                	sd	s1,8(sp)
    400a:	e04a                	sd	s2,0(sp)
    400c:	1000                	addi	s0,sp,32
    400e:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    4010:	20000593          	li	a1,512
    4014:	00004517          	auipc	a0,0x4
    4018:	b5450513          	addi	a0,a0,-1196 # 7b68 <malloc+0x1ae8>
    401c:	00002097          	auipc	ra,0x2
    4020:	c6e080e7          	jalr	-914(ra) # 5c8a <open>
  if (fd < 0) {
    4024:	0e054d63          	bltz	a0,411e <dirfile+0x11c>
  close(fd);
    4028:	00002097          	auipc	ra,0x2
    402c:	c4a080e7          	jalr	-950(ra) # 5c72 <close>
  if (chdir("dirfile") == 0) {
    4030:	00004517          	auipc	a0,0x4
    4034:	b3850513          	addi	a0,a0,-1224 # 7b68 <malloc+0x1ae8>
    4038:	00002097          	auipc	ra,0x2
    403c:	c82080e7          	jalr	-894(ra) # 5cba <chdir>
    4040:	cd6d                	beqz	a0,413a <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    4042:	4581                	li	a1,0
    4044:	00004517          	auipc	a0,0x4
    4048:	b6c50513          	addi	a0,a0,-1172 # 7bb0 <malloc+0x1b30>
    404c:	00002097          	auipc	ra,0x2
    4050:	c3e080e7          	jalr	-962(ra) # 5c8a <open>
  if (fd >= 0) {
    4054:	10055163          	bgez	a0,4156 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    4058:	20000593          	li	a1,512
    405c:	00004517          	auipc	a0,0x4
    4060:	b5450513          	addi	a0,a0,-1196 # 7bb0 <malloc+0x1b30>
    4064:	00002097          	auipc	ra,0x2
    4068:	c26080e7          	jalr	-986(ra) # 5c8a <open>
  if (fd >= 0) {
    406c:	10055363          	bgez	a0,4172 <dirfile+0x170>
  if (mkdir("dirfile/xx") == 0) {
    4070:	00004517          	auipc	a0,0x4
    4074:	b4050513          	addi	a0,a0,-1216 # 7bb0 <malloc+0x1b30>
    4078:	00002097          	auipc	ra,0x2
    407c:	c3a080e7          	jalr	-966(ra) # 5cb2 <mkdir>
    4080:	10050763          	beqz	a0,418e <dirfile+0x18c>
  if (unlink("dirfile/xx") == 0) {
    4084:	00004517          	auipc	a0,0x4
    4088:	b2c50513          	addi	a0,a0,-1236 # 7bb0 <malloc+0x1b30>
    408c:	00002097          	auipc	ra,0x2
    4090:	c0e080e7          	jalr	-1010(ra) # 5c9a <unlink>
    4094:	10050b63          	beqz	a0,41aa <dirfile+0x1a8>
  if (link("xv6-readme", "dirfile/xx") == 0) {
    4098:	00004597          	auipc	a1,0x4
    409c:	b1858593          	addi	a1,a1,-1256 # 7bb0 <malloc+0x1b30>
    40a0:	00002517          	auipc	a0,0x2
    40a4:	30050513          	addi	a0,a0,768 # 63a0 <malloc+0x320>
    40a8:	00002097          	auipc	ra,0x2
    40ac:	c02080e7          	jalr	-1022(ra) # 5caa <link>
    40b0:	10050b63          	beqz	a0,41c6 <dirfile+0x1c4>
  if (unlink("dirfile") != 0) {
    40b4:	00004517          	auipc	a0,0x4
    40b8:	ab450513          	addi	a0,a0,-1356 # 7b68 <malloc+0x1ae8>
    40bc:	00002097          	auipc	ra,0x2
    40c0:	bde080e7          	jalr	-1058(ra) # 5c9a <unlink>
    40c4:	10051f63          	bnez	a0,41e2 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    40c8:	4589                	li	a1,2
    40ca:	00002517          	auipc	a0,0x2
    40ce:	7f650513          	addi	a0,a0,2038 # 68c0 <malloc+0x840>
    40d2:	00002097          	auipc	ra,0x2
    40d6:	bb8080e7          	jalr	-1096(ra) # 5c8a <open>
  if (fd >= 0) {
    40da:	12055263          	bgez	a0,41fe <dirfile+0x1fc>
  fd = open(".", 0);
    40de:	4581                	li	a1,0
    40e0:	00002517          	auipc	a0,0x2
    40e4:	7e050513          	addi	a0,a0,2016 # 68c0 <malloc+0x840>
    40e8:	00002097          	auipc	ra,0x2
    40ec:	ba2080e7          	jalr	-1118(ra) # 5c8a <open>
    40f0:	84aa                	mv	s1,a0
  if (write(fd, "x", 1) > 0) {
    40f2:	4605                	li	a2,1
    40f4:	00002597          	auipc	a1,0x2
    40f8:	14458593          	addi	a1,a1,324 # 6238 <malloc+0x1b8>
    40fc:	00002097          	auipc	ra,0x2
    4100:	b6e080e7          	jalr	-1170(ra) # 5c6a <write>
    4104:	10a04b63          	bgtz	a0,421a <dirfile+0x218>
  close(fd);
    4108:	8526                	mv	a0,s1
    410a:	00002097          	auipc	ra,0x2
    410e:	b68080e7          	jalr	-1176(ra) # 5c72 <close>
}
    4112:	60e2                	ld	ra,24(sp)
    4114:	6442                	ld	s0,16(sp)
    4116:	64a2                	ld	s1,8(sp)
    4118:	6902                	ld	s2,0(sp)
    411a:	6105                	addi	sp,sp,32
    411c:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    411e:	85ca                	mv	a1,s2
    4120:	00004517          	auipc	a0,0x4
    4124:	a5050513          	addi	a0,a0,-1456 # 7b70 <malloc+0x1af0>
    4128:	00002097          	auipc	ra,0x2
    412c:	e9a080e7          	jalr	-358(ra) # 5fc2 <printf>
    exit(1);
    4130:	4505                	li	a0,1
    4132:	00002097          	auipc	ra,0x2
    4136:	b18080e7          	jalr	-1256(ra) # 5c4a <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    413a:	85ca                	mv	a1,s2
    413c:	00004517          	auipc	a0,0x4
    4140:	a5450513          	addi	a0,a0,-1452 # 7b90 <malloc+0x1b10>
    4144:	00002097          	auipc	ra,0x2
    4148:	e7e080e7          	jalr	-386(ra) # 5fc2 <printf>
    exit(1);
    414c:	4505                	li	a0,1
    414e:	00002097          	auipc	ra,0x2
    4152:	afc080e7          	jalr	-1284(ra) # 5c4a <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4156:	85ca                	mv	a1,s2
    4158:	00004517          	auipc	a0,0x4
    415c:	a6850513          	addi	a0,a0,-1432 # 7bc0 <malloc+0x1b40>
    4160:	00002097          	auipc	ra,0x2
    4164:	e62080e7          	jalr	-414(ra) # 5fc2 <printf>
    exit(1);
    4168:	4505                	li	a0,1
    416a:	00002097          	auipc	ra,0x2
    416e:	ae0080e7          	jalr	-1312(ra) # 5c4a <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4172:	85ca                	mv	a1,s2
    4174:	00004517          	auipc	a0,0x4
    4178:	a4c50513          	addi	a0,a0,-1460 # 7bc0 <malloc+0x1b40>
    417c:	00002097          	auipc	ra,0x2
    4180:	e46080e7          	jalr	-442(ra) # 5fc2 <printf>
    exit(1);
    4184:	4505                	li	a0,1
    4186:	00002097          	auipc	ra,0x2
    418a:	ac4080e7          	jalr	-1340(ra) # 5c4a <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    418e:	85ca                	mv	a1,s2
    4190:	00004517          	auipc	a0,0x4
    4194:	a5850513          	addi	a0,a0,-1448 # 7be8 <malloc+0x1b68>
    4198:	00002097          	auipc	ra,0x2
    419c:	e2a080e7          	jalr	-470(ra) # 5fc2 <printf>
    exit(1);
    41a0:	4505                	li	a0,1
    41a2:	00002097          	auipc	ra,0x2
    41a6:	aa8080e7          	jalr	-1368(ra) # 5c4a <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    41aa:	85ca                	mv	a1,s2
    41ac:	00004517          	auipc	a0,0x4
    41b0:	a6450513          	addi	a0,a0,-1436 # 7c10 <malloc+0x1b90>
    41b4:	00002097          	auipc	ra,0x2
    41b8:	e0e080e7          	jalr	-498(ra) # 5fc2 <printf>
    exit(1);
    41bc:	4505                	li	a0,1
    41be:	00002097          	auipc	ra,0x2
    41c2:	a8c080e7          	jalr	-1396(ra) # 5c4a <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    41c6:	85ca                	mv	a1,s2
    41c8:	00004517          	auipc	a0,0x4
    41cc:	a7050513          	addi	a0,a0,-1424 # 7c38 <malloc+0x1bb8>
    41d0:	00002097          	auipc	ra,0x2
    41d4:	df2080e7          	jalr	-526(ra) # 5fc2 <printf>
    exit(1);
    41d8:	4505                	li	a0,1
    41da:	00002097          	auipc	ra,0x2
    41de:	a70080e7          	jalr	-1424(ra) # 5c4a <exit>
    printf("%s: unlink dirfile failed!\n", s);
    41e2:	85ca                	mv	a1,s2
    41e4:	00004517          	auipc	a0,0x4
    41e8:	a7c50513          	addi	a0,a0,-1412 # 7c60 <malloc+0x1be0>
    41ec:	00002097          	auipc	ra,0x2
    41f0:	dd6080e7          	jalr	-554(ra) # 5fc2 <printf>
    exit(1);
    41f4:	4505                	li	a0,1
    41f6:	00002097          	auipc	ra,0x2
    41fa:	a54080e7          	jalr	-1452(ra) # 5c4a <exit>
    printf("%s: open . for writing succeeded!\n", s);
    41fe:	85ca                	mv	a1,s2
    4200:	00004517          	auipc	a0,0x4
    4204:	a8050513          	addi	a0,a0,-1408 # 7c80 <malloc+0x1c00>
    4208:	00002097          	auipc	ra,0x2
    420c:	dba080e7          	jalr	-582(ra) # 5fc2 <printf>
    exit(1);
    4210:	4505                	li	a0,1
    4212:	00002097          	auipc	ra,0x2
    4216:	a38080e7          	jalr	-1480(ra) # 5c4a <exit>
    printf("%s: write . succeeded!\n", s);
    421a:	85ca                	mv	a1,s2
    421c:	00004517          	auipc	a0,0x4
    4220:	a8c50513          	addi	a0,a0,-1396 # 7ca8 <malloc+0x1c28>
    4224:	00002097          	auipc	ra,0x2
    4228:	d9e080e7          	jalr	-610(ra) # 5fc2 <printf>
    exit(1);
    422c:	4505                	li	a0,1
    422e:	00002097          	auipc	ra,0x2
    4232:	a1c080e7          	jalr	-1508(ra) # 5c4a <exit>

0000000000004236 <iref>:
void iref(char *s) {
    4236:	7139                	addi	sp,sp,-64
    4238:	fc06                	sd	ra,56(sp)
    423a:	f822                	sd	s0,48(sp)
    423c:	f426                	sd	s1,40(sp)
    423e:	f04a                	sd	s2,32(sp)
    4240:	ec4e                	sd	s3,24(sp)
    4242:	e852                	sd	s4,16(sp)
    4244:	e456                	sd	s5,8(sp)
    4246:	e05a                	sd	s6,0(sp)
    4248:	0080                	addi	s0,sp,64
    424a:	8b2a                	mv	s6,a0
    424c:	03300913          	li	s2,51
    if (mkdir("irefd") != 0) {
    4250:	00004a17          	auipc	s4,0x4
    4254:	a70a0a13          	addi	s4,s4,-1424 # 7cc0 <malloc+0x1c40>
    mkdir("");
    4258:	00003497          	auipc	s1,0x3
    425c:	57048493          	addi	s1,s1,1392 # 77c8 <malloc+0x1748>
    link("xv6-readme", "");
    4260:	00002a97          	auipc	s5,0x2
    4264:	140a8a93          	addi	s5,s5,320 # 63a0 <malloc+0x320>
    fd = open("xx", O_CREATE);
    4268:	00004997          	auipc	s3,0x4
    426c:	95098993          	addi	s3,s3,-1712 # 7bb8 <malloc+0x1b38>
    4270:	a891                	j	42c4 <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    4272:	85da                	mv	a1,s6
    4274:	00004517          	auipc	a0,0x4
    4278:	a5450513          	addi	a0,a0,-1452 # 7cc8 <malloc+0x1c48>
    427c:	00002097          	auipc	ra,0x2
    4280:	d46080e7          	jalr	-698(ra) # 5fc2 <printf>
      exit(1);
    4284:	4505                	li	a0,1
    4286:	00002097          	auipc	ra,0x2
    428a:	9c4080e7          	jalr	-1596(ra) # 5c4a <exit>
      printf("%s: chdir irefd failed\n", s);
    428e:	85da                	mv	a1,s6
    4290:	00004517          	auipc	a0,0x4
    4294:	a5050513          	addi	a0,a0,-1456 # 7ce0 <malloc+0x1c60>
    4298:	00002097          	auipc	ra,0x2
    429c:	d2a080e7          	jalr	-726(ra) # 5fc2 <printf>
      exit(1);
    42a0:	4505                	li	a0,1
    42a2:	00002097          	auipc	ra,0x2
    42a6:	9a8080e7          	jalr	-1624(ra) # 5c4a <exit>
    if (fd >= 0) close(fd);
    42aa:	00002097          	auipc	ra,0x2
    42ae:	9c8080e7          	jalr	-1592(ra) # 5c72 <close>
    42b2:	a889                	j	4304 <iref+0xce>
    unlink("xx");
    42b4:	854e                	mv	a0,s3
    42b6:	00002097          	auipc	ra,0x2
    42ba:	9e4080e7          	jalr	-1564(ra) # 5c9a <unlink>
  for (i = 0; i < NINODE + 1; i++) {
    42be:	397d                	addiw	s2,s2,-1
    42c0:	06090063          	beqz	s2,4320 <iref+0xea>
    if (mkdir("irefd") != 0) {
    42c4:	8552                	mv	a0,s4
    42c6:	00002097          	auipc	ra,0x2
    42ca:	9ec080e7          	jalr	-1556(ra) # 5cb2 <mkdir>
    42ce:	f155                	bnez	a0,4272 <iref+0x3c>
    if (chdir("irefd") != 0) {
    42d0:	8552                	mv	a0,s4
    42d2:	00002097          	auipc	ra,0x2
    42d6:	9e8080e7          	jalr	-1560(ra) # 5cba <chdir>
    42da:	f955                	bnez	a0,428e <iref+0x58>
    mkdir("");
    42dc:	8526                	mv	a0,s1
    42de:	00002097          	auipc	ra,0x2
    42e2:	9d4080e7          	jalr	-1580(ra) # 5cb2 <mkdir>
    link("xv6-readme", "");
    42e6:	85a6                	mv	a1,s1
    42e8:	8556                	mv	a0,s5
    42ea:	00002097          	auipc	ra,0x2
    42ee:	9c0080e7          	jalr	-1600(ra) # 5caa <link>
    fd = open("", O_CREATE);
    42f2:	20000593          	li	a1,512
    42f6:	8526                	mv	a0,s1
    42f8:	00002097          	auipc	ra,0x2
    42fc:	992080e7          	jalr	-1646(ra) # 5c8a <open>
    if (fd >= 0) close(fd);
    4300:	fa0555e3          	bgez	a0,42aa <iref+0x74>
    fd = open("xx", O_CREATE);
    4304:	20000593          	li	a1,512
    4308:	854e                	mv	a0,s3
    430a:	00002097          	auipc	ra,0x2
    430e:	980080e7          	jalr	-1664(ra) # 5c8a <open>
    if (fd >= 0) close(fd);
    4312:	fa0541e3          	bltz	a0,42b4 <iref+0x7e>
    4316:	00002097          	auipc	ra,0x2
    431a:	95c080e7          	jalr	-1700(ra) # 5c72 <close>
    431e:	bf59                	j	42b4 <iref+0x7e>
    4320:	03300493          	li	s1,51
    chdir("..");
    4324:	00003997          	auipc	s3,0x3
    4328:	1c498993          	addi	s3,s3,452 # 74e8 <malloc+0x1468>
    unlink("irefd");
    432c:	00004917          	auipc	s2,0x4
    4330:	99490913          	addi	s2,s2,-1644 # 7cc0 <malloc+0x1c40>
    chdir("..");
    4334:	854e                	mv	a0,s3
    4336:	00002097          	auipc	ra,0x2
    433a:	984080e7          	jalr	-1660(ra) # 5cba <chdir>
    unlink("irefd");
    433e:	854a                	mv	a0,s2
    4340:	00002097          	auipc	ra,0x2
    4344:	95a080e7          	jalr	-1702(ra) # 5c9a <unlink>
  for (i = 0; i < NINODE + 1; i++) {
    4348:	34fd                	addiw	s1,s1,-1
    434a:	f4ed                	bnez	s1,4334 <iref+0xfe>
  chdir("/");
    434c:	00003517          	auipc	a0,0x3
    4350:	14450513          	addi	a0,a0,324 # 7490 <malloc+0x1410>
    4354:	00002097          	auipc	ra,0x2
    4358:	966080e7          	jalr	-1690(ra) # 5cba <chdir>
}
    435c:	70e2                	ld	ra,56(sp)
    435e:	7442                	ld	s0,48(sp)
    4360:	74a2                	ld	s1,40(sp)
    4362:	7902                	ld	s2,32(sp)
    4364:	69e2                	ld	s3,24(sp)
    4366:	6a42                	ld	s4,16(sp)
    4368:	6aa2                	ld	s5,8(sp)
    436a:	6b02                	ld	s6,0(sp)
    436c:	6121                	addi	sp,sp,64
    436e:	8082                	ret

0000000000004370 <openiputtest>:
void openiputtest(char *s) {
    4370:	7179                	addi	sp,sp,-48
    4372:	f406                	sd	ra,40(sp)
    4374:	f022                	sd	s0,32(sp)
    4376:	ec26                	sd	s1,24(sp)
    4378:	1800                	addi	s0,sp,48
    437a:	84aa                	mv	s1,a0
  if (mkdir("oidir") < 0) {
    437c:	00004517          	auipc	a0,0x4
    4380:	97c50513          	addi	a0,a0,-1668 # 7cf8 <malloc+0x1c78>
    4384:	00002097          	auipc	ra,0x2
    4388:	92e080e7          	jalr	-1746(ra) # 5cb2 <mkdir>
    438c:	04054263          	bltz	a0,43d0 <openiputtest+0x60>
  pid = fork();
    4390:	00002097          	auipc	ra,0x2
    4394:	8b2080e7          	jalr	-1870(ra) # 5c42 <fork>
  if (pid < 0) {
    4398:	04054a63          	bltz	a0,43ec <openiputtest+0x7c>
  if (pid == 0) {
    439c:	e93d                	bnez	a0,4412 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    439e:	4589                	li	a1,2
    43a0:	00004517          	auipc	a0,0x4
    43a4:	95850513          	addi	a0,a0,-1704 # 7cf8 <malloc+0x1c78>
    43a8:	00002097          	auipc	ra,0x2
    43ac:	8e2080e7          	jalr	-1822(ra) # 5c8a <open>
    if (fd >= 0) {
    43b0:	04054c63          	bltz	a0,4408 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    43b4:	85a6                	mv	a1,s1
    43b6:	00004517          	auipc	a0,0x4
    43ba:	96250513          	addi	a0,a0,-1694 # 7d18 <malloc+0x1c98>
    43be:	00002097          	auipc	ra,0x2
    43c2:	c04080e7          	jalr	-1020(ra) # 5fc2 <printf>
      exit(1);
    43c6:	4505                	li	a0,1
    43c8:	00002097          	auipc	ra,0x2
    43cc:	882080e7          	jalr	-1918(ra) # 5c4a <exit>
    printf("%s: mkdir oidir failed\n", s);
    43d0:	85a6                	mv	a1,s1
    43d2:	00004517          	auipc	a0,0x4
    43d6:	92e50513          	addi	a0,a0,-1746 # 7d00 <malloc+0x1c80>
    43da:	00002097          	auipc	ra,0x2
    43de:	be8080e7          	jalr	-1048(ra) # 5fc2 <printf>
    exit(1);
    43e2:	4505                	li	a0,1
    43e4:	00002097          	auipc	ra,0x2
    43e8:	866080e7          	jalr	-1946(ra) # 5c4a <exit>
    printf("%s: fork failed\n", s);
    43ec:	85a6                	mv	a1,s1
    43ee:	00002517          	auipc	a0,0x2
    43f2:	67250513          	addi	a0,a0,1650 # 6a60 <malloc+0x9e0>
    43f6:	00002097          	auipc	ra,0x2
    43fa:	bcc080e7          	jalr	-1076(ra) # 5fc2 <printf>
    exit(1);
    43fe:	4505                	li	a0,1
    4400:	00002097          	auipc	ra,0x2
    4404:	84a080e7          	jalr	-1974(ra) # 5c4a <exit>
    exit(0);
    4408:	4501                	li	a0,0
    440a:	00002097          	auipc	ra,0x2
    440e:	840080e7          	jalr	-1984(ra) # 5c4a <exit>
  sleep(1);
    4412:	4505                	li	a0,1
    4414:	00002097          	auipc	ra,0x2
    4418:	8c6080e7          	jalr	-1850(ra) # 5cda <sleep>
  if (unlink("oidir") != 0) {
    441c:	00004517          	auipc	a0,0x4
    4420:	8dc50513          	addi	a0,a0,-1828 # 7cf8 <malloc+0x1c78>
    4424:	00002097          	auipc	ra,0x2
    4428:	876080e7          	jalr	-1930(ra) # 5c9a <unlink>
    442c:	cd19                	beqz	a0,444a <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    442e:	85a6                	mv	a1,s1
    4430:	00003517          	auipc	a0,0x3
    4434:	82050513          	addi	a0,a0,-2016 # 6c50 <malloc+0xbd0>
    4438:	00002097          	auipc	ra,0x2
    443c:	b8a080e7          	jalr	-1142(ra) # 5fc2 <printf>
    exit(1);
    4440:	4505                	li	a0,1
    4442:	00002097          	auipc	ra,0x2
    4446:	808080e7          	jalr	-2040(ra) # 5c4a <exit>
  wait(&xstatus);
    444a:	fdc40513          	addi	a0,s0,-36
    444e:	00002097          	auipc	ra,0x2
    4452:	804080e7          	jalr	-2044(ra) # 5c52 <wait>
  exit(xstatus);
    4456:	fdc42503          	lw	a0,-36(s0)
    445a:	00001097          	auipc	ra,0x1
    445e:	7f0080e7          	jalr	2032(ra) # 5c4a <exit>

0000000000004462 <forkforkfork>:
void forkforkfork(char *s) {
    4462:	1101                	addi	sp,sp,-32
    4464:	ec06                	sd	ra,24(sp)
    4466:	e822                	sd	s0,16(sp)
    4468:	e426                	sd	s1,8(sp)
    446a:	1000                	addi	s0,sp,32
    446c:	84aa                	mv	s1,a0
  unlink("stopforking");
    446e:	00004517          	auipc	a0,0x4
    4472:	8d250513          	addi	a0,a0,-1838 # 7d40 <malloc+0x1cc0>
    4476:	00002097          	auipc	ra,0x2
    447a:	824080e7          	jalr	-2012(ra) # 5c9a <unlink>
  int pid = fork();
    447e:	00001097          	auipc	ra,0x1
    4482:	7c4080e7          	jalr	1988(ra) # 5c42 <fork>
  if (pid < 0) {
    4486:	04054563          	bltz	a0,44d0 <forkforkfork+0x6e>
  if (pid == 0) {
    448a:	c12d                	beqz	a0,44ec <forkforkfork+0x8a>
  sleep(20);  // two seconds
    448c:	4551                	li	a0,20
    448e:	00002097          	auipc	ra,0x2
    4492:	84c080e7          	jalr	-1972(ra) # 5cda <sleep>
  close(open("stopforking", O_CREATE | O_RDWR));
    4496:	20200593          	li	a1,514
    449a:	00004517          	auipc	a0,0x4
    449e:	8a650513          	addi	a0,a0,-1882 # 7d40 <malloc+0x1cc0>
    44a2:	00001097          	auipc	ra,0x1
    44a6:	7e8080e7          	jalr	2024(ra) # 5c8a <open>
    44aa:	00001097          	auipc	ra,0x1
    44ae:	7c8080e7          	jalr	1992(ra) # 5c72 <close>
  wait(0);
    44b2:	4501                	li	a0,0
    44b4:	00001097          	auipc	ra,0x1
    44b8:	79e080e7          	jalr	1950(ra) # 5c52 <wait>
  sleep(10);  // one second
    44bc:	4529                	li	a0,10
    44be:	00002097          	auipc	ra,0x2
    44c2:	81c080e7          	jalr	-2020(ra) # 5cda <sleep>
}
    44c6:	60e2                	ld	ra,24(sp)
    44c8:	6442                	ld	s0,16(sp)
    44ca:	64a2                	ld	s1,8(sp)
    44cc:	6105                	addi	sp,sp,32
    44ce:	8082                	ret
    printf("%s: fork failed", s);
    44d0:	85a6                	mv	a1,s1
    44d2:	00002517          	auipc	a0,0x2
    44d6:	74e50513          	addi	a0,a0,1870 # 6c20 <malloc+0xba0>
    44da:	00002097          	auipc	ra,0x2
    44de:	ae8080e7          	jalr	-1304(ra) # 5fc2 <printf>
    exit(1);
    44e2:	4505                	li	a0,1
    44e4:	00001097          	auipc	ra,0x1
    44e8:	766080e7          	jalr	1894(ra) # 5c4a <exit>
      int fd = open("stopforking", 0);
    44ec:	00004497          	auipc	s1,0x4
    44f0:	85448493          	addi	s1,s1,-1964 # 7d40 <malloc+0x1cc0>
    44f4:	4581                	li	a1,0
    44f6:	8526                	mv	a0,s1
    44f8:	00001097          	auipc	ra,0x1
    44fc:	792080e7          	jalr	1938(ra) # 5c8a <open>
      if (fd >= 0) {
    4500:	02055463          	bgez	a0,4528 <forkforkfork+0xc6>
      if (fork() < 0) {
    4504:	00001097          	auipc	ra,0x1
    4508:	73e080e7          	jalr	1854(ra) # 5c42 <fork>
    450c:	fe0554e3          	bgez	a0,44f4 <forkforkfork+0x92>
        close(open("stopforking", O_CREATE | O_RDWR));
    4510:	20200593          	li	a1,514
    4514:	8526                	mv	a0,s1
    4516:	00001097          	auipc	ra,0x1
    451a:	774080e7          	jalr	1908(ra) # 5c8a <open>
    451e:	00001097          	auipc	ra,0x1
    4522:	754080e7          	jalr	1876(ra) # 5c72 <close>
    4526:	b7f9                	j	44f4 <forkforkfork+0x92>
        exit(0);
    4528:	4501                	li	a0,0
    452a:	00001097          	auipc	ra,0x1
    452e:	720080e7          	jalr	1824(ra) # 5c4a <exit>

0000000000004532 <killstatus>:
void killstatus(char *s) {
    4532:	7139                	addi	sp,sp,-64
    4534:	fc06                	sd	ra,56(sp)
    4536:	f822                	sd	s0,48(sp)
    4538:	f426                	sd	s1,40(sp)
    453a:	f04a                	sd	s2,32(sp)
    453c:	ec4e                	sd	s3,24(sp)
    453e:	e852                	sd	s4,16(sp)
    4540:	0080                	addi	s0,sp,64
    4542:	8a2a                	mv	s4,a0
    4544:	06400913          	li	s2,100
    if (xst != -1) {
    4548:	59fd                	li	s3,-1
    int pid1 = fork();
    454a:	00001097          	auipc	ra,0x1
    454e:	6f8080e7          	jalr	1784(ra) # 5c42 <fork>
    4552:	84aa                	mv	s1,a0
    if (pid1 < 0) {
    4554:	02054f63          	bltz	a0,4592 <killstatus+0x60>
    if (pid1 == 0) {
    4558:	c939                	beqz	a0,45ae <killstatus+0x7c>
    sleep(1);
    455a:	4505                	li	a0,1
    455c:	00001097          	auipc	ra,0x1
    4560:	77e080e7          	jalr	1918(ra) # 5cda <sleep>
    kill(pid1);
    4564:	8526                	mv	a0,s1
    4566:	00001097          	auipc	ra,0x1
    456a:	714080e7          	jalr	1812(ra) # 5c7a <kill>
    wait(&xst);
    456e:	fcc40513          	addi	a0,s0,-52
    4572:	00001097          	auipc	ra,0x1
    4576:	6e0080e7          	jalr	1760(ra) # 5c52 <wait>
    if (xst != -1) {
    457a:	fcc42783          	lw	a5,-52(s0)
    457e:	03379d63          	bne	a5,s3,45b8 <killstatus+0x86>
  for (int i = 0; i < 100; i++) {
    4582:	397d                	addiw	s2,s2,-1
    4584:	fc0913e3          	bnez	s2,454a <killstatus+0x18>
  exit(0);
    4588:	4501                	li	a0,0
    458a:	00001097          	auipc	ra,0x1
    458e:	6c0080e7          	jalr	1728(ra) # 5c4a <exit>
      printf("%s: fork failed\n", s);
    4592:	85d2                	mv	a1,s4
    4594:	00002517          	auipc	a0,0x2
    4598:	4cc50513          	addi	a0,a0,1228 # 6a60 <malloc+0x9e0>
    459c:	00002097          	auipc	ra,0x2
    45a0:	a26080e7          	jalr	-1498(ra) # 5fc2 <printf>
      exit(1);
    45a4:	4505                	li	a0,1
    45a6:	00001097          	auipc	ra,0x1
    45aa:	6a4080e7          	jalr	1700(ra) # 5c4a <exit>
        getpid();
    45ae:	00001097          	auipc	ra,0x1
    45b2:	71c080e7          	jalr	1820(ra) # 5cca <getpid>
      while (1) {
    45b6:	bfe5                	j	45ae <killstatus+0x7c>
      printf("%s: status should be -1\n", s);
    45b8:	85d2                	mv	a1,s4
    45ba:	00003517          	auipc	a0,0x3
    45be:	79650513          	addi	a0,a0,1942 # 7d50 <malloc+0x1cd0>
    45c2:	00002097          	auipc	ra,0x2
    45c6:	a00080e7          	jalr	-1536(ra) # 5fc2 <printf>
      exit(1);
    45ca:	4505                	li	a0,1
    45cc:	00001097          	auipc	ra,0x1
    45d0:	67e080e7          	jalr	1662(ra) # 5c4a <exit>

00000000000045d4 <preempt>:
void preempt(char *s) {
    45d4:	7139                	addi	sp,sp,-64
    45d6:	fc06                	sd	ra,56(sp)
    45d8:	f822                	sd	s0,48(sp)
    45da:	f426                	sd	s1,40(sp)
    45dc:	f04a                	sd	s2,32(sp)
    45de:	ec4e                	sd	s3,24(sp)
    45e0:	e852                	sd	s4,16(sp)
    45e2:	0080                	addi	s0,sp,64
    45e4:	892a                	mv	s2,a0
  pid1 = fork();
    45e6:	00001097          	auipc	ra,0x1
    45ea:	65c080e7          	jalr	1628(ra) # 5c42 <fork>
  if (pid1 < 0) {
    45ee:	00054563          	bltz	a0,45f8 <preempt+0x24>
    45f2:	84aa                	mv	s1,a0
  if (pid1 == 0)
    45f4:	e105                	bnez	a0,4614 <preempt+0x40>
    for (;;)
    45f6:	a001                	j	45f6 <preempt+0x22>
    printf("%s: fork failed", s);
    45f8:	85ca                	mv	a1,s2
    45fa:	00002517          	auipc	a0,0x2
    45fe:	62650513          	addi	a0,a0,1574 # 6c20 <malloc+0xba0>
    4602:	00002097          	auipc	ra,0x2
    4606:	9c0080e7          	jalr	-1600(ra) # 5fc2 <printf>
    exit(1);
    460a:	4505                	li	a0,1
    460c:	00001097          	auipc	ra,0x1
    4610:	63e080e7          	jalr	1598(ra) # 5c4a <exit>
  pid2 = fork();
    4614:	00001097          	auipc	ra,0x1
    4618:	62e080e7          	jalr	1582(ra) # 5c42 <fork>
    461c:	89aa                	mv	s3,a0
  if (pid2 < 0) {
    461e:	00054463          	bltz	a0,4626 <preempt+0x52>
  if (pid2 == 0)
    4622:	e105                	bnez	a0,4642 <preempt+0x6e>
    for (;;)
    4624:	a001                	j	4624 <preempt+0x50>
    printf("%s: fork failed\n", s);
    4626:	85ca                	mv	a1,s2
    4628:	00002517          	auipc	a0,0x2
    462c:	43850513          	addi	a0,a0,1080 # 6a60 <malloc+0x9e0>
    4630:	00002097          	auipc	ra,0x2
    4634:	992080e7          	jalr	-1646(ra) # 5fc2 <printf>
    exit(1);
    4638:	4505                	li	a0,1
    463a:	00001097          	auipc	ra,0x1
    463e:	610080e7          	jalr	1552(ra) # 5c4a <exit>
  pipe(pfds);
    4642:	fc840513          	addi	a0,s0,-56
    4646:	00001097          	auipc	ra,0x1
    464a:	614080e7          	jalr	1556(ra) # 5c5a <pipe>
  pid3 = fork();
    464e:	00001097          	auipc	ra,0x1
    4652:	5f4080e7          	jalr	1524(ra) # 5c42 <fork>
    4656:	8a2a                	mv	s4,a0
  if (pid3 < 0) {
    4658:	02054e63          	bltz	a0,4694 <preempt+0xc0>
  if (pid3 == 0) {
    465c:	e525                	bnez	a0,46c4 <preempt+0xf0>
    close(pfds[0]);
    465e:	fc842503          	lw	a0,-56(s0)
    4662:	00001097          	auipc	ra,0x1
    4666:	610080e7          	jalr	1552(ra) # 5c72 <close>
    if (write(pfds[1], "x", 1) != 1) printf("%s: preempt write error", s);
    466a:	4605                	li	a2,1
    466c:	00002597          	auipc	a1,0x2
    4670:	bcc58593          	addi	a1,a1,-1076 # 6238 <malloc+0x1b8>
    4674:	fcc42503          	lw	a0,-52(s0)
    4678:	00001097          	auipc	ra,0x1
    467c:	5f2080e7          	jalr	1522(ra) # 5c6a <write>
    4680:	4785                	li	a5,1
    4682:	02f51763          	bne	a0,a5,46b0 <preempt+0xdc>
    close(pfds[1]);
    4686:	fcc42503          	lw	a0,-52(s0)
    468a:	00001097          	auipc	ra,0x1
    468e:	5e8080e7          	jalr	1512(ra) # 5c72 <close>
    for (;;)
    4692:	a001                	j	4692 <preempt+0xbe>
    printf("%s: fork failed\n", s);
    4694:	85ca                	mv	a1,s2
    4696:	00002517          	auipc	a0,0x2
    469a:	3ca50513          	addi	a0,a0,970 # 6a60 <malloc+0x9e0>
    469e:	00002097          	auipc	ra,0x2
    46a2:	924080e7          	jalr	-1756(ra) # 5fc2 <printf>
    exit(1);
    46a6:	4505                	li	a0,1
    46a8:	00001097          	auipc	ra,0x1
    46ac:	5a2080e7          	jalr	1442(ra) # 5c4a <exit>
    if (write(pfds[1], "x", 1) != 1) printf("%s: preempt write error", s);
    46b0:	85ca                	mv	a1,s2
    46b2:	00003517          	auipc	a0,0x3
    46b6:	6be50513          	addi	a0,a0,1726 # 7d70 <malloc+0x1cf0>
    46ba:	00002097          	auipc	ra,0x2
    46be:	908080e7          	jalr	-1784(ra) # 5fc2 <printf>
    46c2:	b7d1                	j	4686 <preempt+0xb2>
  close(pfds[1]);
    46c4:	fcc42503          	lw	a0,-52(s0)
    46c8:	00001097          	auipc	ra,0x1
    46cc:	5aa080e7          	jalr	1450(ra) # 5c72 <close>
  if (read(pfds[0], buf, sizeof(buf)) != 1) {
    46d0:	660d                	lui	a2,0x3
    46d2:	00008597          	auipc	a1,0x8
    46d6:	5a658593          	addi	a1,a1,1446 # cc78 <buf>
    46da:	fc842503          	lw	a0,-56(s0)
    46de:	00001097          	auipc	ra,0x1
    46e2:	584080e7          	jalr	1412(ra) # 5c62 <read>
    46e6:	4785                	li	a5,1
    46e8:	02f50363          	beq	a0,a5,470e <preempt+0x13a>
    printf("%s: preempt read error", s);
    46ec:	85ca                	mv	a1,s2
    46ee:	00003517          	auipc	a0,0x3
    46f2:	69a50513          	addi	a0,a0,1690 # 7d88 <malloc+0x1d08>
    46f6:	00002097          	auipc	ra,0x2
    46fa:	8cc080e7          	jalr	-1844(ra) # 5fc2 <printf>
}
    46fe:	70e2                	ld	ra,56(sp)
    4700:	7442                	ld	s0,48(sp)
    4702:	74a2                	ld	s1,40(sp)
    4704:	7902                	ld	s2,32(sp)
    4706:	69e2                	ld	s3,24(sp)
    4708:	6a42                	ld	s4,16(sp)
    470a:	6121                	addi	sp,sp,64
    470c:	8082                	ret
  close(pfds[0]);
    470e:	fc842503          	lw	a0,-56(s0)
    4712:	00001097          	auipc	ra,0x1
    4716:	560080e7          	jalr	1376(ra) # 5c72 <close>
  printf("kill... ");
    471a:	00003517          	auipc	a0,0x3
    471e:	68650513          	addi	a0,a0,1670 # 7da0 <malloc+0x1d20>
    4722:	00002097          	auipc	ra,0x2
    4726:	8a0080e7          	jalr	-1888(ra) # 5fc2 <printf>
  kill(pid1);
    472a:	8526                	mv	a0,s1
    472c:	00001097          	auipc	ra,0x1
    4730:	54e080e7          	jalr	1358(ra) # 5c7a <kill>
  kill(pid2);
    4734:	854e                	mv	a0,s3
    4736:	00001097          	auipc	ra,0x1
    473a:	544080e7          	jalr	1348(ra) # 5c7a <kill>
  kill(pid3);
    473e:	8552                	mv	a0,s4
    4740:	00001097          	auipc	ra,0x1
    4744:	53a080e7          	jalr	1338(ra) # 5c7a <kill>
  printf("wait... ");
    4748:	00003517          	auipc	a0,0x3
    474c:	66850513          	addi	a0,a0,1640 # 7db0 <malloc+0x1d30>
    4750:	00002097          	auipc	ra,0x2
    4754:	872080e7          	jalr	-1934(ra) # 5fc2 <printf>
  wait(0);
    4758:	4501                	li	a0,0
    475a:	00001097          	auipc	ra,0x1
    475e:	4f8080e7          	jalr	1272(ra) # 5c52 <wait>
  wait(0);
    4762:	4501                	li	a0,0
    4764:	00001097          	auipc	ra,0x1
    4768:	4ee080e7          	jalr	1262(ra) # 5c52 <wait>
  wait(0);
    476c:	4501                	li	a0,0
    476e:	00001097          	auipc	ra,0x1
    4772:	4e4080e7          	jalr	1252(ra) # 5c52 <wait>
    4776:	b761                	j	46fe <preempt+0x12a>

0000000000004778 <reparent>:
void reparent(char *s) {
    4778:	7179                	addi	sp,sp,-48
    477a:	f406                	sd	ra,40(sp)
    477c:	f022                	sd	s0,32(sp)
    477e:	ec26                	sd	s1,24(sp)
    4780:	e84a                	sd	s2,16(sp)
    4782:	e44e                	sd	s3,8(sp)
    4784:	e052                	sd	s4,0(sp)
    4786:	1800                	addi	s0,sp,48
    4788:	89aa                	mv	s3,a0
  int master_pid = getpid();
    478a:	00001097          	auipc	ra,0x1
    478e:	540080e7          	jalr	1344(ra) # 5cca <getpid>
    4792:	8a2a                	mv	s4,a0
    4794:	0c800913          	li	s2,200
    int pid = fork();
    4798:	00001097          	auipc	ra,0x1
    479c:	4aa080e7          	jalr	1194(ra) # 5c42 <fork>
    47a0:	84aa                	mv	s1,a0
    if (pid < 0) {
    47a2:	02054263          	bltz	a0,47c6 <reparent+0x4e>
    if (pid) {
    47a6:	cd21                	beqz	a0,47fe <reparent+0x86>
      if (wait(0) != pid) {
    47a8:	4501                	li	a0,0
    47aa:	00001097          	auipc	ra,0x1
    47ae:	4a8080e7          	jalr	1192(ra) # 5c52 <wait>
    47b2:	02951863          	bne	a0,s1,47e2 <reparent+0x6a>
  for (int i = 0; i < 200; i++) {
    47b6:	397d                	addiw	s2,s2,-1
    47b8:	fe0910e3          	bnez	s2,4798 <reparent+0x20>
  exit(0);
    47bc:	4501                	li	a0,0
    47be:	00001097          	auipc	ra,0x1
    47c2:	48c080e7          	jalr	1164(ra) # 5c4a <exit>
      printf("%s: fork failed\n", s);
    47c6:	85ce                	mv	a1,s3
    47c8:	00002517          	auipc	a0,0x2
    47cc:	29850513          	addi	a0,a0,664 # 6a60 <malloc+0x9e0>
    47d0:	00001097          	auipc	ra,0x1
    47d4:	7f2080e7          	jalr	2034(ra) # 5fc2 <printf>
      exit(1);
    47d8:	4505                	li	a0,1
    47da:	00001097          	auipc	ra,0x1
    47de:	470080e7          	jalr	1136(ra) # 5c4a <exit>
        printf("%s: wait wrong pid\n", s);
    47e2:	85ce                	mv	a1,s3
    47e4:	00002517          	auipc	a0,0x2
    47e8:	40450513          	addi	a0,a0,1028 # 6be8 <malloc+0xb68>
    47ec:	00001097          	auipc	ra,0x1
    47f0:	7d6080e7          	jalr	2006(ra) # 5fc2 <printf>
        exit(1);
    47f4:	4505                	li	a0,1
    47f6:	00001097          	auipc	ra,0x1
    47fa:	454080e7          	jalr	1108(ra) # 5c4a <exit>
      int pid2 = fork();
    47fe:	00001097          	auipc	ra,0x1
    4802:	444080e7          	jalr	1092(ra) # 5c42 <fork>
      if (pid2 < 0) {
    4806:	00054763          	bltz	a0,4814 <reparent+0x9c>
      exit(0);
    480a:	4501                	li	a0,0
    480c:	00001097          	auipc	ra,0x1
    4810:	43e080e7          	jalr	1086(ra) # 5c4a <exit>
        kill(master_pid);
    4814:	8552                	mv	a0,s4
    4816:	00001097          	auipc	ra,0x1
    481a:	464080e7          	jalr	1124(ra) # 5c7a <kill>
        exit(1);
    481e:	4505                	li	a0,1
    4820:	00001097          	auipc	ra,0x1
    4824:	42a080e7          	jalr	1066(ra) # 5c4a <exit>

0000000000004828 <sbrkfail>:
void sbrkfail(char *s) {
    4828:	7119                	addi	sp,sp,-128
    482a:	fc86                	sd	ra,120(sp)
    482c:	f8a2                	sd	s0,112(sp)
    482e:	f4a6                	sd	s1,104(sp)
    4830:	f0ca                	sd	s2,96(sp)
    4832:	ecce                	sd	s3,88(sp)
    4834:	e8d2                	sd	s4,80(sp)
    4836:	e4d6                	sd	s5,72(sp)
    4838:	0100                	addi	s0,sp,128
    483a:	8aaa                	mv	s5,a0
  if (pipe(fds) != 0) {
    483c:	fb040513          	addi	a0,s0,-80
    4840:	00001097          	auipc	ra,0x1
    4844:	41a080e7          	jalr	1050(ra) # 5c5a <pipe>
    4848:	e901                	bnez	a0,4858 <sbrkfail+0x30>
    484a:	f8040493          	addi	s1,s0,-128
    484e:	fa840993          	addi	s3,s0,-88
    4852:	8926                	mv	s2,s1
    if (pids[i] != -1) read(fds[0], &scratch, 1);
    4854:	5a7d                	li	s4,-1
    4856:	a085                	j	48b6 <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    4858:	85d6                	mv	a1,s5
    485a:	00002517          	auipc	a0,0x2
    485e:	30e50513          	addi	a0,a0,782 # 6b68 <malloc+0xae8>
    4862:	00001097          	auipc	ra,0x1
    4866:	760080e7          	jalr	1888(ra) # 5fc2 <printf>
    exit(1);
    486a:	4505                	li	a0,1
    486c:	00001097          	auipc	ra,0x1
    4870:	3de080e7          	jalr	990(ra) # 5c4a <exit>
      sbrk(BIG - (uint64)sbrk(0));
    4874:	00001097          	auipc	ra,0x1
    4878:	45e080e7          	jalr	1118(ra) # 5cd2 <sbrk>
    487c:	064007b7          	lui	a5,0x6400
    4880:	40a7853b          	subw	a0,a5,a0
    4884:	00001097          	auipc	ra,0x1
    4888:	44e080e7          	jalr	1102(ra) # 5cd2 <sbrk>
      write(fds[1], "x", 1);
    488c:	4605                	li	a2,1
    488e:	00002597          	auipc	a1,0x2
    4892:	9aa58593          	addi	a1,a1,-1622 # 6238 <malloc+0x1b8>
    4896:	fb442503          	lw	a0,-76(s0)
    489a:	00001097          	auipc	ra,0x1
    489e:	3d0080e7          	jalr	976(ra) # 5c6a <write>
      for (;;) sleep(1000);
    48a2:	3e800513          	li	a0,1000
    48a6:	00001097          	auipc	ra,0x1
    48aa:	434080e7          	jalr	1076(ra) # 5cda <sleep>
    48ae:	bfd5                	j	48a2 <sbrkfail+0x7a>
  for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
    48b0:	0911                	addi	s2,s2,4
    48b2:	03390563          	beq	s2,s3,48dc <sbrkfail+0xb4>
    if ((pids[i] = fork()) == 0) {
    48b6:	00001097          	auipc	ra,0x1
    48ba:	38c080e7          	jalr	908(ra) # 5c42 <fork>
    48be:	00a92023          	sw	a0,0(s2)
    48c2:	d94d                	beqz	a0,4874 <sbrkfail+0x4c>
    if (pids[i] != -1) read(fds[0], &scratch, 1);
    48c4:	ff4506e3          	beq	a0,s4,48b0 <sbrkfail+0x88>
    48c8:	4605                	li	a2,1
    48ca:	faf40593          	addi	a1,s0,-81
    48ce:	fb042503          	lw	a0,-80(s0)
    48d2:	00001097          	auipc	ra,0x1
    48d6:	390080e7          	jalr	912(ra) # 5c62 <read>
    48da:	bfd9                	j	48b0 <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    48dc:	6505                	lui	a0,0x1
    48de:	00001097          	auipc	ra,0x1
    48e2:	3f4080e7          	jalr	1012(ra) # 5cd2 <sbrk>
    48e6:	8a2a                	mv	s4,a0
    if (pids[i] == -1) continue;
    48e8:	597d                	li	s2,-1
    48ea:	a021                	j	48f2 <sbrkfail+0xca>
  for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
    48ec:	0491                	addi	s1,s1,4
    48ee:	01348f63          	beq	s1,s3,490c <sbrkfail+0xe4>
    if (pids[i] == -1) continue;
    48f2:	4088                	lw	a0,0(s1)
    48f4:	ff250ce3          	beq	a0,s2,48ec <sbrkfail+0xc4>
    kill(pids[i]);
    48f8:	00001097          	auipc	ra,0x1
    48fc:	382080e7          	jalr	898(ra) # 5c7a <kill>
    wait(0);
    4900:	4501                	li	a0,0
    4902:	00001097          	auipc	ra,0x1
    4906:	350080e7          	jalr	848(ra) # 5c52 <wait>
    490a:	b7cd                	j	48ec <sbrkfail+0xc4>
  if (c == (char *)0xffffffffffffffffL) {
    490c:	57fd                	li	a5,-1
    490e:	04fa0163          	beq	s4,a5,4950 <sbrkfail+0x128>
  pid = fork();
    4912:	00001097          	auipc	ra,0x1
    4916:	330080e7          	jalr	816(ra) # 5c42 <fork>
    491a:	84aa                	mv	s1,a0
  if (pid < 0) {
    491c:	04054863          	bltz	a0,496c <sbrkfail+0x144>
  if (pid == 0) {
    4920:	c525                	beqz	a0,4988 <sbrkfail+0x160>
  wait(&xstatus);
    4922:	fbc40513          	addi	a0,s0,-68
    4926:	00001097          	auipc	ra,0x1
    492a:	32c080e7          	jalr	812(ra) # 5c52 <wait>
  if (xstatus != -1 && xstatus != 2) exit(1);
    492e:	fbc42783          	lw	a5,-68(s0)
    4932:	577d                	li	a4,-1
    4934:	00e78563          	beq	a5,a4,493e <sbrkfail+0x116>
    4938:	4709                	li	a4,2
    493a:	08e79d63          	bne	a5,a4,49d4 <sbrkfail+0x1ac>
}
    493e:	70e6                	ld	ra,120(sp)
    4940:	7446                	ld	s0,112(sp)
    4942:	74a6                	ld	s1,104(sp)
    4944:	7906                	ld	s2,96(sp)
    4946:	69e6                	ld	s3,88(sp)
    4948:	6a46                	ld	s4,80(sp)
    494a:	6aa6                	ld	s5,72(sp)
    494c:	6109                	addi	sp,sp,128
    494e:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    4950:	85d6                	mv	a1,s5
    4952:	00003517          	auipc	a0,0x3
    4956:	46e50513          	addi	a0,a0,1134 # 7dc0 <malloc+0x1d40>
    495a:	00001097          	auipc	ra,0x1
    495e:	668080e7          	jalr	1640(ra) # 5fc2 <printf>
    exit(1);
    4962:	4505                	li	a0,1
    4964:	00001097          	auipc	ra,0x1
    4968:	2e6080e7          	jalr	742(ra) # 5c4a <exit>
    printf("%s: fork failed\n", s);
    496c:	85d6                	mv	a1,s5
    496e:	00002517          	auipc	a0,0x2
    4972:	0f250513          	addi	a0,a0,242 # 6a60 <malloc+0x9e0>
    4976:	00001097          	auipc	ra,0x1
    497a:	64c080e7          	jalr	1612(ra) # 5fc2 <printf>
    exit(1);
    497e:	4505                	li	a0,1
    4980:	00001097          	auipc	ra,0x1
    4984:	2ca080e7          	jalr	714(ra) # 5c4a <exit>
    a = sbrk(0);
    4988:	4501                	li	a0,0
    498a:	00001097          	auipc	ra,0x1
    498e:	348080e7          	jalr	840(ra) # 5cd2 <sbrk>
    4992:	892a                	mv	s2,a0
    sbrk(10 * BIG);
    4994:	3e800537          	lui	a0,0x3e800
    4998:	00001097          	auipc	ra,0x1
    499c:	33a080e7          	jalr	826(ra) # 5cd2 <sbrk>
    for (i = 0; i < 10 * BIG; i += PGSIZE) {
    49a0:	87ca                	mv	a5,s2
    49a2:	3e800737          	lui	a4,0x3e800
    49a6:	993a                	add	s2,s2,a4
    49a8:	6705                	lui	a4,0x1
      n += *(a + i);
    49aa:	0007c683          	lbu	a3,0(a5) # 6400000 <base+0x63f0388>
    49ae:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10 * BIG; i += PGSIZE) {
    49b0:	97ba                	add	a5,a5,a4
    49b2:	ff279ce3          	bne	a5,s2,49aa <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    49b6:	8626                	mv	a2,s1
    49b8:	85d6                	mv	a1,s5
    49ba:	00003517          	auipc	a0,0x3
    49be:	42650513          	addi	a0,a0,1062 # 7de0 <malloc+0x1d60>
    49c2:	00001097          	auipc	ra,0x1
    49c6:	600080e7          	jalr	1536(ra) # 5fc2 <printf>
    exit(1);
    49ca:	4505                	li	a0,1
    49cc:	00001097          	auipc	ra,0x1
    49d0:	27e080e7          	jalr	638(ra) # 5c4a <exit>
  if (xstatus != -1 && xstatus != 2) exit(1);
    49d4:	4505                	li	a0,1
    49d6:	00001097          	auipc	ra,0x1
    49da:	274080e7          	jalr	628(ra) # 5c4a <exit>

00000000000049de <mem>:
void mem(char *s) {
    49de:	7139                	addi	sp,sp,-64
    49e0:	fc06                	sd	ra,56(sp)
    49e2:	f822                	sd	s0,48(sp)
    49e4:	f426                	sd	s1,40(sp)
    49e6:	f04a                	sd	s2,32(sp)
    49e8:	ec4e                	sd	s3,24(sp)
    49ea:	0080                	addi	s0,sp,64
    49ec:	89aa                	mv	s3,a0
  if ((pid = fork()) == 0) {
    49ee:	00001097          	auipc	ra,0x1
    49f2:	254080e7          	jalr	596(ra) # 5c42 <fork>
    m1 = 0;
    49f6:	4481                	li	s1,0
    while ((m2 = malloc(10001)) != 0) {
    49f8:	6909                	lui	s2,0x2
    49fa:	71190913          	addi	s2,s2,1809 # 2711 <copyinstr3+0xfb>
  if ((pid = fork()) == 0) {
    49fe:	c115                	beqz	a0,4a22 <mem+0x44>
    wait(&xstatus);
    4a00:	fcc40513          	addi	a0,s0,-52
    4a04:	00001097          	auipc	ra,0x1
    4a08:	24e080e7          	jalr	590(ra) # 5c52 <wait>
    if (xstatus == -1) {
    4a0c:	fcc42503          	lw	a0,-52(s0)
    4a10:	57fd                	li	a5,-1
    4a12:	06f50363          	beq	a0,a5,4a78 <mem+0x9a>
    exit(xstatus);
    4a16:	00001097          	auipc	ra,0x1
    4a1a:	234080e7          	jalr	564(ra) # 5c4a <exit>
      *(char **)m2 = m1;
    4a1e:	e104                	sd	s1,0(a0)
      m1 = m2;
    4a20:	84aa                	mv	s1,a0
    while ((m2 = malloc(10001)) != 0) {
    4a22:	854a                	mv	a0,s2
    4a24:	00001097          	auipc	ra,0x1
    4a28:	65c080e7          	jalr	1628(ra) # 6080 <malloc>
    4a2c:	f96d                	bnez	a0,4a1e <mem+0x40>
    while (m1) {
    4a2e:	c881                	beqz	s1,4a3e <mem+0x60>
      m2 = *(char **)m1;
    4a30:	8526                	mv	a0,s1
    4a32:	6084                	ld	s1,0(s1)
      free(m1);
    4a34:	00001097          	auipc	ra,0x1
    4a38:	5c4080e7          	jalr	1476(ra) # 5ff8 <free>
    while (m1) {
    4a3c:	f8f5                	bnez	s1,4a30 <mem+0x52>
    m1 = malloc(1024 * 20);
    4a3e:	6515                	lui	a0,0x5
    4a40:	00001097          	auipc	ra,0x1
    4a44:	640080e7          	jalr	1600(ra) # 6080 <malloc>
    if (m1 == 0) {
    4a48:	c911                	beqz	a0,4a5c <mem+0x7e>
    free(m1);
    4a4a:	00001097          	auipc	ra,0x1
    4a4e:	5ae080e7          	jalr	1454(ra) # 5ff8 <free>
    exit(0);
    4a52:	4501                	li	a0,0
    4a54:	00001097          	auipc	ra,0x1
    4a58:	1f6080e7          	jalr	502(ra) # 5c4a <exit>
      printf("couldn't allocate mem?!!\n", s);
    4a5c:	85ce                	mv	a1,s3
    4a5e:	00003517          	auipc	a0,0x3
    4a62:	3b250513          	addi	a0,a0,946 # 7e10 <malloc+0x1d90>
    4a66:	00001097          	auipc	ra,0x1
    4a6a:	55c080e7          	jalr	1372(ra) # 5fc2 <printf>
      exit(1);
    4a6e:	4505                	li	a0,1
    4a70:	00001097          	auipc	ra,0x1
    4a74:	1da080e7          	jalr	474(ra) # 5c4a <exit>
      exit(0);
    4a78:	4501                	li	a0,0
    4a7a:	00001097          	auipc	ra,0x1
    4a7e:	1d0080e7          	jalr	464(ra) # 5c4a <exit>

0000000000004a82 <sharedfd>:
void sharedfd(char *s) {
    4a82:	7159                	addi	sp,sp,-112
    4a84:	f486                	sd	ra,104(sp)
    4a86:	f0a2                	sd	s0,96(sp)
    4a88:	eca6                	sd	s1,88(sp)
    4a8a:	e8ca                	sd	s2,80(sp)
    4a8c:	e4ce                	sd	s3,72(sp)
    4a8e:	e0d2                	sd	s4,64(sp)
    4a90:	fc56                	sd	s5,56(sp)
    4a92:	f85a                	sd	s6,48(sp)
    4a94:	f45e                	sd	s7,40(sp)
    4a96:	1880                	addi	s0,sp,112
    4a98:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    4a9a:	00003517          	auipc	a0,0x3
    4a9e:	39650513          	addi	a0,a0,918 # 7e30 <malloc+0x1db0>
    4aa2:	00001097          	auipc	ra,0x1
    4aa6:	1f8080e7          	jalr	504(ra) # 5c9a <unlink>
  fd = open("sharedfd", O_CREATE | O_RDWR);
    4aaa:	20200593          	li	a1,514
    4aae:	00003517          	auipc	a0,0x3
    4ab2:	38250513          	addi	a0,a0,898 # 7e30 <malloc+0x1db0>
    4ab6:	00001097          	auipc	ra,0x1
    4aba:	1d4080e7          	jalr	468(ra) # 5c8a <open>
  if (fd < 0) {
    4abe:	04054a63          	bltz	a0,4b12 <sharedfd+0x90>
    4ac2:	892a                	mv	s2,a0
  pid = fork();
    4ac4:	00001097          	auipc	ra,0x1
    4ac8:	17e080e7          	jalr	382(ra) # 5c42 <fork>
    4acc:	89aa                	mv	s3,a0
  memset(buf, pid == 0 ? 'c' : 'p', sizeof(buf));
    4ace:	06300593          	li	a1,99
    4ad2:	c119                	beqz	a0,4ad8 <sharedfd+0x56>
    4ad4:	07000593          	li	a1,112
    4ad8:	4629                	li	a2,10
    4ada:	fa040513          	addi	a0,s0,-96
    4ade:	00001097          	auipc	ra,0x1
    4ae2:	f70080e7          	jalr	-144(ra) # 5a4e <memset>
    4ae6:	3e800493          	li	s1,1000
    if (write(fd, buf, sizeof(buf)) != sizeof(buf)) {
    4aea:	4629                	li	a2,10
    4aec:	fa040593          	addi	a1,s0,-96
    4af0:	854a                	mv	a0,s2
    4af2:	00001097          	auipc	ra,0x1
    4af6:	178080e7          	jalr	376(ra) # 5c6a <write>
    4afa:	47a9                	li	a5,10
    4afc:	02f51963          	bne	a0,a5,4b2e <sharedfd+0xac>
  for (i = 0; i < N; i++) {
    4b00:	34fd                	addiw	s1,s1,-1
    4b02:	f4e5                	bnez	s1,4aea <sharedfd+0x68>
  if (pid == 0) {
    4b04:	04099363          	bnez	s3,4b4a <sharedfd+0xc8>
    exit(0);
    4b08:	4501                	li	a0,0
    4b0a:	00001097          	auipc	ra,0x1
    4b0e:	140080e7          	jalr	320(ra) # 5c4a <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4b12:	85d2                	mv	a1,s4
    4b14:	00003517          	auipc	a0,0x3
    4b18:	32c50513          	addi	a0,a0,812 # 7e40 <malloc+0x1dc0>
    4b1c:	00001097          	auipc	ra,0x1
    4b20:	4a6080e7          	jalr	1190(ra) # 5fc2 <printf>
    exit(1);
    4b24:	4505                	li	a0,1
    4b26:	00001097          	auipc	ra,0x1
    4b2a:	124080e7          	jalr	292(ra) # 5c4a <exit>
      printf("%s: write sharedfd failed\n", s);
    4b2e:	85d2                	mv	a1,s4
    4b30:	00003517          	auipc	a0,0x3
    4b34:	33850513          	addi	a0,a0,824 # 7e68 <malloc+0x1de8>
    4b38:	00001097          	auipc	ra,0x1
    4b3c:	48a080e7          	jalr	1162(ra) # 5fc2 <printf>
      exit(1);
    4b40:	4505                	li	a0,1
    4b42:	00001097          	auipc	ra,0x1
    4b46:	108080e7          	jalr	264(ra) # 5c4a <exit>
    wait(&xstatus);
    4b4a:	f9c40513          	addi	a0,s0,-100
    4b4e:	00001097          	auipc	ra,0x1
    4b52:	104080e7          	jalr	260(ra) # 5c52 <wait>
    if (xstatus != 0) exit(xstatus);
    4b56:	f9c42983          	lw	s3,-100(s0)
    4b5a:	00098763          	beqz	s3,4b68 <sharedfd+0xe6>
    4b5e:	854e                	mv	a0,s3
    4b60:	00001097          	auipc	ra,0x1
    4b64:	0ea080e7          	jalr	234(ra) # 5c4a <exit>
  close(fd);
    4b68:	854a                	mv	a0,s2
    4b6a:	00001097          	auipc	ra,0x1
    4b6e:	108080e7          	jalr	264(ra) # 5c72 <close>
  fd = open("sharedfd", 0);
    4b72:	4581                	li	a1,0
    4b74:	00003517          	auipc	a0,0x3
    4b78:	2bc50513          	addi	a0,a0,700 # 7e30 <malloc+0x1db0>
    4b7c:	00001097          	auipc	ra,0x1
    4b80:	10e080e7          	jalr	270(ra) # 5c8a <open>
    4b84:	8baa                	mv	s7,a0
  nc = np = 0;
    4b86:	8ace                	mv	s5,s3
  if (fd < 0) {
    4b88:	02054563          	bltz	a0,4bb2 <sharedfd+0x130>
    4b8c:	faa40913          	addi	s2,s0,-86
      if (buf[i] == 'c') nc++;
    4b90:	06300493          	li	s1,99
      if (buf[i] == 'p') np++;
    4b94:	07000b13          	li	s6,112
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
    4b98:	4629                	li	a2,10
    4b9a:	fa040593          	addi	a1,s0,-96
    4b9e:	855e                	mv	a0,s7
    4ba0:	00001097          	auipc	ra,0x1
    4ba4:	0c2080e7          	jalr	194(ra) # 5c62 <read>
    4ba8:	02a05f63          	blez	a0,4be6 <sharedfd+0x164>
    4bac:	fa040793          	addi	a5,s0,-96
    4bb0:	a01d                	j	4bd6 <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4bb2:	85d2                	mv	a1,s4
    4bb4:	00003517          	auipc	a0,0x3
    4bb8:	2d450513          	addi	a0,a0,724 # 7e88 <malloc+0x1e08>
    4bbc:	00001097          	auipc	ra,0x1
    4bc0:	406080e7          	jalr	1030(ra) # 5fc2 <printf>
    exit(1);
    4bc4:	4505                	li	a0,1
    4bc6:	00001097          	auipc	ra,0x1
    4bca:	084080e7          	jalr	132(ra) # 5c4a <exit>
      if (buf[i] == 'c') nc++;
    4bce:	2985                	addiw	s3,s3,1
    for (i = 0; i < sizeof(buf); i++) {
    4bd0:	0785                	addi	a5,a5,1
    4bd2:	fd2783e3          	beq	a5,s2,4b98 <sharedfd+0x116>
      if (buf[i] == 'c') nc++;
    4bd6:	0007c703          	lbu	a4,0(a5)
    4bda:	fe970ae3          	beq	a4,s1,4bce <sharedfd+0x14c>
      if (buf[i] == 'p') np++;
    4bde:	ff6719e3          	bne	a4,s6,4bd0 <sharedfd+0x14e>
    4be2:	2a85                	addiw	s5,s5,1
    4be4:	b7f5                	j	4bd0 <sharedfd+0x14e>
  close(fd);
    4be6:	855e                	mv	a0,s7
    4be8:	00001097          	auipc	ra,0x1
    4bec:	08a080e7          	jalr	138(ra) # 5c72 <close>
  unlink("sharedfd");
    4bf0:	00003517          	auipc	a0,0x3
    4bf4:	24050513          	addi	a0,a0,576 # 7e30 <malloc+0x1db0>
    4bf8:	00001097          	auipc	ra,0x1
    4bfc:	0a2080e7          	jalr	162(ra) # 5c9a <unlink>
  if (nc == N * SZ && np == N * SZ) {
    4c00:	6789                	lui	a5,0x2
    4c02:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0xfa>
    4c06:	00f99763          	bne	s3,a5,4c14 <sharedfd+0x192>
    4c0a:	6789                	lui	a5,0x2
    4c0c:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0xfa>
    4c10:	02fa8063          	beq	s5,a5,4c30 <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    4c14:	85d2                	mv	a1,s4
    4c16:	00003517          	auipc	a0,0x3
    4c1a:	29a50513          	addi	a0,a0,666 # 7eb0 <malloc+0x1e30>
    4c1e:	00001097          	auipc	ra,0x1
    4c22:	3a4080e7          	jalr	932(ra) # 5fc2 <printf>
    exit(1);
    4c26:	4505                	li	a0,1
    4c28:	00001097          	auipc	ra,0x1
    4c2c:	022080e7          	jalr	34(ra) # 5c4a <exit>
    exit(0);
    4c30:	4501                	li	a0,0
    4c32:	00001097          	auipc	ra,0x1
    4c36:	018080e7          	jalr	24(ra) # 5c4a <exit>

0000000000004c3a <fourfiles>:
void fourfiles(char *s) {
    4c3a:	7171                	addi	sp,sp,-176
    4c3c:	f506                	sd	ra,168(sp)
    4c3e:	f122                	sd	s0,160(sp)
    4c40:	ed26                	sd	s1,152(sp)
    4c42:	e94a                	sd	s2,144(sp)
    4c44:	e54e                	sd	s3,136(sp)
    4c46:	e152                	sd	s4,128(sp)
    4c48:	fcd6                	sd	s5,120(sp)
    4c4a:	f8da                	sd	s6,112(sp)
    4c4c:	f4de                	sd	s7,104(sp)
    4c4e:	f0e2                	sd	s8,96(sp)
    4c50:	ece6                	sd	s9,88(sp)
    4c52:	e8ea                	sd	s10,80(sp)
    4c54:	e4ee                	sd	s11,72(sp)
    4c56:	1900                	addi	s0,sp,176
    4c58:	f4a43c23          	sd	a0,-168(s0)
  char *names[] = {"f0", "f1", "f2", "f3"};
    4c5c:	00001797          	auipc	a5,0x1
    4c60:	51478793          	addi	a5,a5,1300 # 6170 <malloc+0xf0>
    4c64:	f6f43823          	sd	a5,-144(s0)
    4c68:	00001797          	auipc	a5,0x1
    4c6c:	51078793          	addi	a5,a5,1296 # 6178 <malloc+0xf8>
    4c70:	f6f43c23          	sd	a5,-136(s0)
    4c74:	00001797          	auipc	a5,0x1
    4c78:	50c78793          	addi	a5,a5,1292 # 6180 <malloc+0x100>
    4c7c:	f8f43023          	sd	a5,-128(s0)
    4c80:	00001797          	auipc	a5,0x1
    4c84:	50878793          	addi	a5,a5,1288 # 6188 <malloc+0x108>
    4c88:	f8f43423          	sd	a5,-120(s0)
  for (pi = 0; pi < NCHILD; pi++) {
    4c8c:	f7040c13          	addi	s8,s0,-144
  char *names[] = {"f0", "f1", "f2", "f3"};
    4c90:	8962                	mv	s2,s8
  for (pi = 0; pi < NCHILD; pi++) {
    4c92:	4481                	li	s1,0
    4c94:	4a11                	li	s4,4
    fname = names[pi];
    4c96:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4c9a:	854e                	mv	a0,s3
    4c9c:	00001097          	auipc	ra,0x1
    4ca0:	ffe080e7          	jalr	-2(ra) # 5c9a <unlink>
    pid = fork();
    4ca4:	00001097          	auipc	ra,0x1
    4ca8:	f9e080e7          	jalr	-98(ra) # 5c42 <fork>
    if (pid < 0) {
    4cac:	04054463          	bltz	a0,4cf4 <fourfiles+0xba>
    if (pid == 0) {
    4cb0:	c12d                	beqz	a0,4d12 <fourfiles+0xd8>
  for (pi = 0; pi < NCHILD; pi++) {
    4cb2:	2485                	addiw	s1,s1,1
    4cb4:	0921                	addi	s2,s2,8
    4cb6:	ff4490e3          	bne	s1,s4,4c96 <fourfiles+0x5c>
    4cba:	4491                	li	s1,4
    wait(&xstatus);
    4cbc:	f6c40513          	addi	a0,s0,-148
    4cc0:	00001097          	auipc	ra,0x1
    4cc4:	f92080e7          	jalr	-110(ra) # 5c52 <wait>
    if (xstatus != 0) exit(xstatus);
    4cc8:	f6c42b03          	lw	s6,-148(s0)
    4ccc:	0c0b1e63          	bnez	s6,4da8 <fourfiles+0x16e>
  for (pi = 0; pi < NCHILD; pi++) {
    4cd0:	34fd                	addiw	s1,s1,-1
    4cd2:	f4ed                	bnez	s1,4cbc <fourfiles+0x82>
    4cd4:	03000b93          	li	s7,48
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    4cd8:	00008a17          	auipc	s4,0x8
    4cdc:	fa0a0a13          	addi	s4,s4,-96 # cc78 <buf>
    4ce0:	00008a97          	auipc	s5,0x8
    4ce4:	f99a8a93          	addi	s5,s5,-103 # cc79 <buf+0x1>
    if (total != N * SZ) {
    4ce8:	6d85                	lui	s11,0x1
    4cea:	770d8d93          	addi	s11,s11,1904 # 1770 <exectest+0x26>
  for (i = 0; i < NCHILD; i++) {
    4cee:	03400d13          	li	s10,52
    4cf2:	aa1d                	j	4e28 <fourfiles+0x1ee>
      printf("fork failed\n", s);
    4cf4:	f5843583          	ld	a1,-168(s0)
    4cf8:	00002517          	auipc	a0,0x2
    4cfc:	17050513          	addi	a0,a0,368 # 6e68 <malloc+0xde8>
    4d00:	00001097          	auipc	ra,0x1
    4d04:	2c2080e7          	jalr	706(ra) # 5fc2 <printf>
      exit(1);
    4d08:	4505                	li	a0,1
    4d0a:	00001097          	auipc	ra,0x1
    4d0e:	f40080e7          	jalr	-192(ra) # 5c4a <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4d12:	20200593          	li	a1,514
    4d16:	854e                	mv	a0,s3
    4d18:	00001097          	auipc	ra,0x1
    4d1c:	f72080e7          	jalr	-142(ra) # 5c8a <open>
    4d20:	892a                	mv	s2,a0
      if (fd < 0) {
    4d22:	04054763          	bltz	a0,4d70 <fourfiles+0x136>
      memset(buf, '0' + pi, SZ);
    4d26:	1f400613          	li	a2,500
    4d2a:	0304859b          	addiw	a1,s1,48
    4d2e:	00008517          	auipc	a0,0x8
    4d32:	f4a50513          	addi	a0,a0,-182 # cc78 <buf>
    4d36:	00001097          	auipc	ra,0x1
    4d3a:	d18080e7          	jalr	-744(ra) # 5a4e <memset>
    4d3e:	44b1                	li	s1,12
        if ((n = write(fd, buf, SZ)) != SZ) {
    4d40:	00008997          	auipc	s3,0x8
    4d44:	f3898993          	addi	s3,s3,-200 # cc78 <buf>
    4d48:	1f400613          	li	a2,500
    4d4c:	85ce                	mv	a1,s3
    4d4e:	854a                	mv	a0,s2
    4d50:	00001097          	auipc	ra,0x1
    4d54:	f1a080e7          	jalr	-230(ra) # 5c6a <write>
    4d58:	85aa                	mv	a1,a0
    4d5a:	1f400793          	li	a5,500
    4d5e:	02f51863          	bne	a0,a5,4d8e <fourfiles+0x154>
      for (i = 0; i < N; i++) {
    4d62:	34fd                	addiw	s1,s1,-1
    4d64:	f0f5                	bnez	s1,4d48 <fourfiles+0x10e>
      exit(0);
    4d66:	4501                	li	a0,0
    4d68:	00001097          	auipc	ra,0x1
    4d6c:	ee2080e7          	jalr	-286(ra) # 5c4a <exit>
        printf("create failed\n", s);
    4d70:	f5843583          	ld	a1,-168(s0)
    4d74:	00003517          	auipc	a0,0x3
    4d78:	15450513          	addi	a0,a0,340 # 7ec8 <malloc+0x1e48>
    4d7c:	00001097          	auipc	ra,0x1
    4d80:	246080e7          	jalr	582(ra) # 5fc2 <printf>
        exit(1);
    4d84:	4505                	li	a0,1
    4d86:	00001097          	auipc	ra,0x1
    4d8a:	ec4080e7          	jalr	-316(ra) # 5c4a <exit>
          printf("write failed %d\n", n);
    4d8e:	00003517          	auipc	a0,0x3
    4d92:	14a50513          	addi	a0,a0,330 # 7ed8 <malloc+0x1e58>
    4d96:	00001097          	auipc	ra,0x1
    4d9a:	22c080e7          	jalr	556(ra) # 5fc2 <printf>
          exit(1);
    4d9e:	4505                	li	a0,1
    4da0:	00001097          	auipc	ra,0x1
    4da4:	eaa080e7          	jalr	-342(ra) # 5c4a <exit>
    if (xstatus != 0) exit(xstatus);
    4da8:	855a                	mv	a0,s6
    4daa:	00001097          	auipc	ra,0x1
    4dae:	ea0080e7          	jalr	-352(ra) # 5c4a <exit>
          printf("wrong char\n", s);
    4db2:	f5843583          	ld	a1,-168(s0)
    4db6:	00003517          	auipc	a0,0x3
    4dba:	13a50513          	addi	a0,a0,314 # 7ef0 <malloc+0x1e70>
    4dbe:	00001097          	auipc	ra,0x1
    4dc2:	204080e7          	jalr	516(ra) # 5fc2 <printf>
          exit(1);
    4dc6:	4505                	li	a0,1
    4dc8:	00001097          	auipc	ra,0x1
    4dcc:	e82080e7          	jalr	-382(ra) # 5c4a <exit>
      total += n;
    4dd0:	00a9093b          	addw	s2,s2,a0
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    4dd4:	660d                	lui	a2,0x3
    4dd6:	85d2                	mv	a1,s4
    4dd8:	854e                	mv	a0,s3
    4dda:	00001097          	auipc	ra,0x1
    4dde:	e88080e7          	jalr	-376(ra) # 5c62 <read>
    4de2:	02a05363          	blez	a0,4e08 <fourfiles+0x1ce>
    4de6:	00008797          	auipc	a5,0x8
    4dea:	e9278793          	addi	a5,a5,-366 # cc78 <buf>
    4dee:	fff5069b          	addiw	a3,a0,-1
    4df2:	1682                	slli	a3,a3,0x20
    4df4:	9281                	srli	a3,a3,0x20
    4df6:	96d6                	add	a3,a3,s5
        if (buf[j] != '0' + i) {
    4df8:	0007c703          	lbu	a4,0(a5)
    4dfc:	fa971be3          	bne	a4,s1,4db2 <fourfiles+0x178>
      for (j = 0; j < n; j++) {
    4e00:	0785                	addi	a5,a5,1
    4e02:	fed79be3          	bne	a5,a3,4df8 <fourfiles+0x1be>
    4e06:	b7e9                	j	4dd0 <fourfiles+0x196>
    close(fd);
    4e08:	854e                	mv	a0,s3
    4e0a:	00001097          	auipc	ra,0x1
    4e0e:	e68080e7          	jalr	-408(ra) # 5c72 <close>
    if (total != N * SZ) {
    4e12:	03b91863          	bne	s2,s11,4e42 <fourfiles+0x208>
    unlink(fname);
    4e16:	8566                	mv	a0,s9
    4e18:	00001097          	auipc	ra,0x1
    4e1c:	e82080e7          	jalr	-382(ra) # 5c9a <unlink>
  for (i = 0; i < NCHILD; i++) {
    4e20:	0c21                	addi	s8,s8,8
    4e22:	2b85                	addiw	s7,s7,1
    4e24:	03ab8d63          	beq	s7,s10,4e5e <fourfiles+0x224>
    fname = names[i];
    4e28:	000c3c83          	ld	s9,0(s8)
    fd = open(fname, 0);
    4e2c:	4581                	li	a1,0
    4e2e:	8566                	mv	a0,s9
    4e30:	00001097          	auipc	ra,0x1
    4e34:	e5a080e7          	jalr	-422(ra) # 5c8a <open>
    4e38:	89aa                	mv	s3,a0
    total = 0;
    4e3a:	895a                	mv	s2,s6
        if (buf[j] != '0' + i) {
    4e3c:	000b849b          	sext.w	s1,s7
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    4e40:	bf51                	j	4dd4 <fourfiles+0x19a>
      printf("wrong length %d\n", total);
    4e42:	85ca                	mv	a1,s2
    4e44:	00003517          	auipc	a0,0x3
    4e48:	0bc50513          	addi	a0,a0,188 # 7f00 <malloc+0x1e80>
    4e4c:	00001097          	auipc	ra,0x1
    4e50:	176080e7          	jalr	374(ra) # 5fc2 <printf>
      exit(1);
    4e54:	4505                	li	a0,1
    4e56:	00001097          	auipc	ra,0x1
    4e5a:	df4080e7          	jalr	-524(ra) # 5c4a <exit>
}
    4e5e:	70aa                	ld	ra,168(sp)
    4e60:	740a                	ld	s0,160(sp)
    4e62:	64ea                	ld	s1,152(sp)
    4e64:	694a                	ld	s2,144(sp)
    4e66:	69aa                	ld	s3,136(sp)
    4e68:	6a0a                	ld	s4,128(sp)
    4e6a:	7ae6                	ld	s5,120(sp)
    4e6c:	7b46                	ld	s6,112(sp)
    4e6e:	7ba6                	ld	s7,104(sp)
    4e70:	7c06                	ld	s8,96(sp)
    4e72:	6ce6                	ld	s9,88(sp)
    4e74:	6d46                	ld	s10,80(sp)
    4e76:	6da6                	ld	s11,72(sp)
    4e78:	614d                	addi	sp,sp,176
    4e7a:	8082                	ret

0000000000004e7c <concreate>:
void concreate(char *s) {
    4e7c:	7135                	addi	sp,sp,-160
    4e7e:	ed06                	sd	ra,152(sp)
    4e80:	e922                	sd	s0,144(sp)
    4e82:	e526                	sd	s1,136(sp)
    4e84:	e14a                	sd	s2,128(sp)
    4e86:	fcce                	sd	s3,120(sp)
    4e88:	f8d2                	sd	s4,112(sp)
    4e8a:	f4d6                	sd	s5,104(sp)
    4e8c:	f0da                	sd	s6,96(sp)
    4e8e:	ecde                	sd	s7,88(sp)
    4e90:	1100                	addi	s0,sp,160
    4e92:	89aa                	mv	s3,a0
  file[0] = 'C';
    4e94:	04300793          	li	a5,67
    4e98:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    4e9c:	fa040523          	sb	zero,-86(s0)
  for (i = 0; i < N; i++) {
    4ea0:	4901                	li	s2,0
    if (pid && (i % 3) == 1) {
    4ea2:	4b0d                	li	s6,3
    4ea4:	4a85                	li	s5,1
      link("C0", file);
    4ea6:	00003b97          	auipc	s7,0x3
    4eaa:	072b8b93          	addi	s7,s7,114 # 7f18 <malloc+0x1e98>
  for (i = 0; i < N; i++) {
    4eae:	02800a13          	li	s4,40
    4eb2:	acc1                	j	5182 <concreate+0x306>
      link("C0", file);
    4eb4:	fa840593          	addi	a1,s0,-88
    4eb8:	855e                	mv	a0,s7
    4eba:	00001097          	auipc	ra,0x1
    4ebe:	df0080e7          	jalr	-528(ra) # 5caa <link>
    if (pid == 0) {
    4ec2:	a45d                	j	5168 <concreate+0x2ec>
    } else if (pid == 0 && (i % 5) == 1) {
    4ec4:	4795                	li	a5,5
    4ec6:	02f9693b          	remw	s2,s2,a5
    4eca:	4785                	li	a5,1
    4ecc:	02f90b63          	beq	s2,a5,4f02 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4ed0:	20200593          	li	a1,514
    4ed4:	fa840513          	addi	a0,s0,-88
    4ed8:	00001097          	auipc	ra,0x1
    4edc:	db2080e7          	jalr	-590(ra) # 5c8a <open>
      if (fd < 0) {
    4ee0:	26055b63          	bgez	a0,5156 <concreate+0x2da>
        printf("concreate create %s failed\n", file);
    4ee4:	fa840593          	addi	a1,s0,-88
    4ee8:	00003517          	auipc	a0,0x3
    4eec:	03850513          	addi	a0,a0,56 # 7f20 <malloc+0x1ea0>
    4ef0:	00001097          	auipc	ra,0x1
    4ef4:	0d2080e7          	jalr	210(ra) # 5fc2 <printf>
        exit(1);
    4ef8:	4505                	li	a0,1
    4efa:	00001097          	auipc	ra,0x1
    4efe:	d50080e7          	jalr	-688(ra) # 5c4a <exit>
      link("C0", file);
    4f02:	fa840593          	addi	a1,s0,-88
    4f06:	00003517          	auipc	a0,0x3
    4f0a:	01250513          	addi	a0,a0,18 # 7f18 <malloc+0x1e98>
    4f0e:	00001097          	auipc	ra,0x1
    4f12:	d9c080e7          	jalr	-612(ra) # 5caa <link>
      exit(0);
    4f16:	4501                	li	a0,0
    4f18:	00001097          	auipc	ra,0x1
    4f1c:	d32080e7          	jalr	-718(ra) # 5c4a <exit>
      if (xstatus != 0) exit(1);
    4f20:	4505                	li	a0,1
    4f22:	00001097          	auipc	ra,0x1
    4f26:	d28080e7          	jalr	-728(ra) # 5c4a <exit>
  memset(fa, 0, sizeof(fa));
    4f2a:	02800613          	li	a2,40
    4f2e:	4581                	li	a1,0
    4f30:	f8040513          	addi	a0,s0,-128
    4f34:	00001097          	auipc	ra,0x1
    4f38:	b1a080e7          	jalr	-1254(ra) # 5a4e <memset>
  fd = open(".", 0);
    4f3c:	4581                	li	a1,0
    4f3e:	00002517          	auipc	a0,0x2
    4f42:	98250513          	addi	a0,a0,-1662 # 68c0 <malloc+0x840>
    4f46:	00001097          	auipc	ra,0x1
    4f4a:	d44080e7          	jalr	-700(ra) # 5c8a <open>
    4f4e:	892a                	mv	s2,a0
  n = 0;
    4f50:	8aa6                	mv	s5,s1
    if (de.name[0] == 'C' && de.name[2] == '\0') {
    4f52:	04300a13          	li	s4,67
      if (i < 0 || i >= sizeof(fa)) {
    4f56:	02700b13          	li	s6,39
      fa[i] = 1;
    4f5a:	4b85                	li	s7,1
  while (read(fd, &de, sizeof(de)) > 0) {
    4f5c:	4641                	li	a2,16
    4f5e:	f7040593          	addi	a1,s0,-144
    4f62:	854a                	mv	a0,s2
    4f64:	00001097          	auipc	ra,0x1
    4f68:	cfe080e7          	jalr	-770(ra) # 5c62 <read>
    4f6c:	08a05163          	blez	a0,4fee <concreate+0x172>
    if (de.inum == 0) continue;
    4f70:	f7045783          	lhu	a5,-144(s0)
    4f74:	d7e5                	beqz	a5,4f5c <concreate+0xe0>
    if (de.name[0] == 'C' && de.name[2] == '\0') {
    4f76:	f7244783          	lbu	a5,-142(s0)
    4f7a:	ff4791e3          	bne	a5,s4,4f5c <concreate+0xe0>
    4f7e:	f7444783          	lbu	a5,-140(s0)
    4f82:	ffe9                	bnez	a5,4f5c <concreate+0xe0>
      i = de.name[1] - '0';
    4f84:	f7344783          	lbu	a5,-141(s0)
    4f88:	fd07879b          	addiw	a5,a5,-48
    4f8c:	0007871b          	sext.w	a4,a5
      if (i < 0 || i >= sizeof(fa)) {
    4f90:	00eb6f63          	bltu	s6,a4,4fae <concreate+0x132>
      if (fa[i]) {
    4f94:	fb040793          	addi	a5,s0,-80
    4f98:	97ba                	add	a5,a5,a4
    4f9a:	fd07c783          	lbu	a5,-48(a5)
    4f9e:	eb85                	bnez	a5,4fce <concreate+0x152>
      fa[i] = 1;
    4fa0:	fb040793          	addi	a5,s0,-80
    4fa4:	973e                	add	a4,a4,a5
    4fa6:	fd770823          	sb	s7,-48(a4) # fd0 <linktest+0xd2>
      n++;
    4faa:	2a85                	addiw	s5,s5,1
    4fac:	bf45                	j	4f5c <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    4fae:	f7240613          	addi	a2,s0,-142
    4fb2:	85ce                	mv	a1,s3
    4fb4:	00003517          	auipc	a0,0x3
    4fb8:	f8c50513          	addi	a0,a0,-116 # 7f40 <malloc+0x1ec0>
    4fbc:	00001097          	auipc	ra,0x1
    4fc0:	006080e7          	jalr	6(ra) # 5fc2 <printf>
        exit(1);
    4fc4:	4505                	li	a0,1
    4fc6:	00001097          	auipc	ra,0x1
    4fca:	c84080e7          	jalr	-892(ra) # 5c4a <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4fce:	f7240613          	addi	a2,s0,-142
    4fd2:	85ce                	mv	a1,s3
    4fd4:	00003517          	auipc	a0,0x3
    4fd8:	f8c50513          	addi	a0,a0,-116 # 7f60 <malloc+0x1ee0>
    4fdc:	00001097          	auipc	ra,0x1
    4fe0:	fe6080e7          	jalr	-26(ra) # 5fc2 <printf>
        exit(1);
    4fe4:	4505                	li	a0,1
    4fe6:	00001097          	auipc	ra,0x1
    4fea:	c64080e7          	jalr	-924(ra) # 5c4a <exit>
  close(fd);
    4fee:	854a                	mv	a0,s2
    4ff0:	00001097          	auipc	ra,0x1
    4ff4:	c82080e7          	jalr	-894(ra) # 5c72 <close>
  if (n != N) {
    4ff8:	02800793          	li	a5,40
    4ffc:	00fa9763          	bne	s5,a5,500a <concreate+0x18e>
    if (((i % 3) == 0 && pid == 0) || ((i % 3) == 1 && pid != 0)) {
    5000:	4a8d                	li	s5,3
    5002:	4b05                	li	s6,1
  for (i = 0; i < N; i++) {
    5004:	02800a13          	li	s4,40
    5008:	a8c9                	j	50da <concreate+0x25e>
    printf("%s: concreate not enough files in directory listing\n", s);
    500a:	85ce                	mv	a1,s3
    500c:	00003517          	auipc	a0,0x3
    5010:	f7c50513          	addi	a0,a0,-132 # 7f88 <malloc+0x1f08>
    5014:	00001097          	auipc	ra,0x1
    5018:	fae080e7          	jalr	-82(ra) # 5fc2 <printf>
    exit(1);
    501c:	4505                	li	a0,1
    501e:	00001097          	auipc	ra,0x1
    5022:	c2c080e7          	jalr	-980(ra) # 5c4a <exit>
      printf("%s: fork failed\n", s);
    5026:	85ce                	mv	a1,s3
    5028:	00002517          	auipc	a0,0x2
    502c:	a3850513          	addi	a0,a0,-1480 # 6a60 <malloc+0x9e0>
    5030:	00001097          	auipc	ra,0x1
    5034:	f92080e7          	jalr	-110(ra) # 5fc2 <printf>
      exit(1);
    5038:	4505                	li	a0,1
    503a:	00001097          	auipc	ra,0x1
    503e:	c10080e7          	jalr	-1008(ra) # 5c4a <exit>
      close(open(file, 0));
    5042:	4581                	li	a1,0
    5044:	fa840513          	addi	a0,s0,-88
    5048:	00001097          	auipc	ra,0x1
    504c:	c42080e7          	jalr	-958(ra) # 5c8a <open>
    5050:	00001097          	auipc	ra,0x1
    5054:	c22080e7          	jalr	-990(ra) # 5c72 <close>
      close(open(file, 0));
    5058:	4581                	li	a1,0
    505a:	fa840513          	addi	a0,s0,-88
    505e:	00001097          	auipc	ra,0x1
    5062:	c2c080e7          	jalr	-980(ra) # 5c8a <open>
    5066:	00001097          	auipc	ra,0x1
    506a:	c0c080e7          	jalr	-1012(ra) # 5c72 <close>
      close(open(file, 0));
    506e:	4581                	li	a1,0
    5070:	fa840513          	addi	a0,s0,-88
    5074:	00001097          	auipc	ra,0x1
    5078:	c16080e7          	jalr	-1002(ra) # 5c8a <open>
    507c:	00001097          	auipc	ra,0x1
    5080:	bf6080e7          	jalr	-1034(ra) # 5c72 <close>
      close(open(file, 0));
    5084:	4581                	li	a1,0
    5086:	fa840513          	addi	a0,s0,-88
    508a:	00001097          	auipc	ra,0x1
    508e:	c00080e7          	jalr	-1024(ra) # 5c8a <open>
    5092:	00001097          	auipc	ra,0x1
    5096:	be0080e7          	jalr	-1056(ra) # 5c72 <close>
      close(open(file, 0));
    509a:	4581                	li	a1,0
    509c:	fa840513          	addi	a0,s0,-88
    50a0:	00001097          	auipc	ra,0x1
    50a4:	bea080e7          	jalr	-1046(ra) # 5c8a <open>
    50a8:	00001097          	auipc	ra,0x1
    50ac:	bca080e7          	jalr	-1078(ra) # 5c72 <close>
      close(open(file, 0));
    50b0:	4581                	li	a1,0
    50b2:	fa840513          	addi	a0,s0,-88
    50b6:	00001097          	auipc	ra,0x1
    50ba:	bd4080e7          	jalr	-1068(ra) # 5c8a <open>
    50be:	00001097          	auipc	ra,0x1
    50c2:	bb4080e7          	jalr	-1100(ra) # 5c72 <close>
    if (pid == 0)
    50c6:	08090363          	beqz	s2,514c <concreate+0x2d0>
      wait(0);
    50ca:	4501                	li	a0,0
    50cc:	00001097          	auipc	ra,0x1
    50d0:	b86080e7          	jalr	-1146(ra) # 5c52 <wait>
  for (i = 0; i < N; i++) {
    50d4:	2485                	addiw	s1,s1,1
    50d6:	0f448563          	beq	s1,s4,51c0 <concreate+0x344>
    file[1] = '0' + i;
    50da:	0304879b          	addiw	a5,s1,48
    50de:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    50e2:	00001097          	auipc	ra,0x1
    50e6:	b60080e7          	jalr	-1184(ra) # 5c42 <fork>
    50ea:	892a                	mv	s2,a0
    if (pid < 0) {
    50ec:	f2054de3          	bltz	a0,5026 <concreate+0x1aa>
    if (((i % 3) == 0 && pid == 0) || ((i % 3) == 1 && pid != 0)) {
    50f0:	0354e73b          	remw	a4,s1,s5
    50f4:	00a767b3          	or	a5,a4,a0
    50f8:	2781                	sext.w	a5,a5
    50fa:	d7a1                	beqz	a5,5042 <concreate+0x1c6>
    50fc:	01671363          	bne	a4,s6,5102 <concreate+0x286>
    5100:	f129                	bnez	a0,5042 <concreate+0x1c6>
      unlink(file);
    5102:	fa840513          	addi	a0,s0,-88
    5106:	00001097          	auipc	ra,0x1
    510a:	b94080e7          	jalr	-1132(ra) # 5c9a <unlink>
      unlink(file);
    510e:	fa840513          	addi	a0,s0,-88
    5112:	00001097          	auipc	ra,0x1
    5116:	b88080e7          	jalr	-1144(ra) # 5c9a <unlink>
      unlink(file);
    511a:	fa840513          	addi	a0,s0,-88
    511e:	00001097          	auipc	ra,0x1
    5122:	b7c080e7          	jalr	-1156(ra) # 5c9a <unlink>
      unlink(file);
    5126:	fa840513          	addi	a0,s0,-88
    512a:	00001097          	auipc	ra,0x1
    512e:	b70080e7          	jalr	-1168(ra) # 5c9a <unlink>
      unlink(file);
    5132:	fa840513          	addi	a0,s0,-88
    5136:	00001097          	auipc	ra,0x1
    513a:	b64080e7          	jalr	-1180(ra) # 5c9a <unlink>
      unlink(file);
    513e:	fa840513          	addi	a0,s0,-88
    5142:	00001097          	auipc	ra,0x1
    5146:	b58080e7          	jalr	-1192(ra) # 5c9a <unlink>
    514a:	bfb5                	j	50c6 <concreate+0x24a>
      exit(0);
    514c:	4501                	li	a0,0
    514e:	00001097          	auipc	ra,0x1
    5152:	afc080e7          	jalr	-1284(ra) # 5c4a <exit>
      close(fd);
    5156:	00001097          	auipc	ra,0x1
    515a:	b1c080e7          	jalr	-1252(ra) # 5c72 <close>
    if (pid == 0) {
    515e:	bb65                	j	4f16 <concreate+0x9a>
      close(fd);
    5160:	00001097          	auipc	ra,0x1
    5164:	b12080e7          	jalr	-1262(ra) # 5c72 <close>
      wait(&xstatus);
    5168:	f6c40513          	addi	a0,s0,-148
    516c:	00001097          	auipc	ra,0x1
    5170:	ae6080e7          	jalr	-1306(ra) # 5c52 <wait>
      if (xstatus != 0) exit(1);
    5174:	f6c42483          	lw	s1,-148(s0)
    5178:	da0494e3          	bnez	s1,4f20 <concreate+0xa4>
  for (i = 0; i < N; i++) {
    517c:	2905                	addiw	s2,s2,1
    517e:	db4906e3          	beq	s2,s4,4f2a <concreate+0xae>
    file[1] = '0' + i;
    5182:	0309079b          	addiw	a5,s2,48
    5186:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    518a:	fa840513          	addi	a0,s0,-88
    518e:	00001097          	auipc	ra,0x1
    5192:	b0c080e7          	jalr	-1268(ra) # 5c9a <unlink>
    pid = fork();
    5196:	00001097          	auipc	ra,0x1
    519a:	aac080e7          	jalr	-1364(ra) # 5c42 <fork>
    if (pid && (i % 3) == 1) {
    519e:	d20503e3          	beqz	a0,4ec4 <concreate+0x48>
    51a2:	036967bb          	remw	a5,s2,s6
    51a6:	d15787e3          	beq	a5,s5,4eb4 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    51aa:	20200593          	li	a1,514
    51ae:	fa840513          	addi	a0,s0,-88
    51b2:	00001097          	auipc	ra,0x1
    51b6:	ad8080e7          	jalr	-1320(ra) # 5c8a <open>
      if (fd < 0) {
    51ba:	fa0553e3          	bgez	a0,5160 <concreate+0x2e4>
    51be:	b31d                	j	4ee4 <concreate+0x68>
}
    51c0:	60ea                	ld	ra,152(sp)
    51c2:	644a                	ld	s0,144(sp)
    51c4:	64aa                	ld	s1,136(sp)
    51c6:	690a                	ld	s2,128(sp)
    51c8:	79e6                	ld	s3,120(sp)
    51ca:	7a46                	ld	s4,112(sp)
    51cc:	7aa6                	ld	s5,104(sp)
    51ce:	7b06                	ld	s6,96(sp)
    51d0:	6be6                	ld	s7,88(sp)
    51d2:	610d                	addi	sp,sp,160
    51d4:	8082                	ret

00000000000051d6 <bigfile>:
void bigfile(char *s) {
    51d6:	7139                	addi	sp,sp,-64
    51d8:	fc06                	sd	ra,56(sp)
    51da:	f822                	sd	s0,48(sp)
    51dc:	f426                	sd	s1,40(sp)
    51de:	f04a                	sd	s2,32(sp)
    51e0:	ec4e                	sd	s3,24(sp)
    51e2:	e852                	sd	s4,16(sp)
    51e4:	e456                	sd	s5,8(sp)
    51e6:	0080                	addi	s0,sp,64
    51e8:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    51ea:	00003517          	auipc	a0,0x3
    51ee:	dd650513          	addi	a0,a0,-554 # 7fc0 <malloc+0x1f40>
    51f2:	00001097          	auipc	ra,0x1
    51f6:	aa8080e7          	jalr	-1368(ra) # 5c9a <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    51fa:	20200593          	li	a1,514
    51fe:	00003517          	auipc	a0,0x3
    5202:	dc250513          	addi	a0,a0,-574 # 7fc0 <malloc+0x1f40>
    5206:	00001097          	auipc	ra,0x1
    520a:	a84080e7          	jalr	-1404(ra) # 5c8a <open>
    520e:	89aa                	mv	s3,a0
  for (i = 0; i < N; i++) {
    5210:	4481                	li	s1,0
    memset(buf, i, SZ);
    5212:	00008917          	auipc	s2,0x8
    5216:	a6690913          	addi	s2,s2,-1434 # cc78 <buf>
  for (i = 0; i < N; i++) {
    521a:	4a51                	li	s4,20
  if (fd < 0) {
    521c:	0a054063          	bltz	a0,52bc <bigfile+0xe6>
    memset(buf, i, SZ);
    5220:	25800613          	li	a2,600
    5224:	85a6                	mv	a1,s1
    5226:	854a                	mv	a0,s2
    5228:	00001097          	auipc	ra,0x1
    522c:	826080e7          	jalr	-2010(ra) # 5a4e <memset>
    if (write(fd, buf, SZ) != SZ) {
    5230:	25800613          	li	a2,600
    5234:	85ca                	mv	a1,s2
    5236:	854e                	mv	a0,s3
    5238:	00001097          	auipc	ra,0x1
    523c:	a32080e7          	jalr	-1486(ra) # 5c6a <write>
    5240:	25800793          	li	a5,600
    5244:	08f51a63          	bne	a0,a5,52d8 <bigfile+0x102>
  for (i = 0; i < N; i++) {
    5248:	2485                	addiw	s1,s1,1
    524a:	fd449be3          	bne	s1,s4,5220 <bigfile+0x4a>
  close(fd);
    524e:	854e                	mv	a0,s3
    5250:	00001097          	auipc	ra,0x1
    5254:	a22080e7          	jalr	-1502(ra) # 5c72 <close>
  fd = open("bigfile.dat", 0);
    5258:	4581                	li	a1,0
    525a:	00003517          	auipc	a0,0x3
    525e:	d6650513          	addi	a0,a0,-666 # 7fc0 <malloc+0x1f40>
    5262:	00001097          	auipc	ra,0x1
    5266:	a28080e7          	jalr	-1496(ra) # 5c8a <open>
    526a:	8a2a                	mv	s4,a0
  total = 0;
    526c:	4981                	li	s3,0
  for (i = 0;; i++) {
    526e:	4481                	li	s1,0
    cc = read(fd, buf, SZ / 2);
    5270:	00008917          	auipc	s2,0x8
    5274:	a0890913          	addi	s2,s2,-1528 # cc78 <buf>
  if (fd < 0) {
    5278:	06054e63          	bltz	a0,52f4 <bigfile+0x11e>
    cc = read(fd, buf, SZ / 2);
    527c:	12c00613          	li	a2,300
    5280:	85ca                	mv	a1,s2
    5282:	8552                	mv	a0,s4
    5284:	00001097          	auipc	ra,0x1
    5288:	9de080e7          	jalr	-1570(ra) # 5c62 <read>
    if (cc < 0) {
    528c:	08054263          	bltz	a0,5310 <bigfile+0x13a>
    if (cc == 0) break;
    5290:	c971                	beqz	a0,5364 <bigfile+0x18e>
    if (cc != SZ / 2) {
    5292:	12c00793          	li	a5,300
    5296:	08f51b63          	bne	a0,a5,532c <bigfile+0x156>
    if (buf[0] != i / 2 || buf[SZ / 2 - 1] != i / 2) {
    529a:	01f4d79b          	srliw	a5,s1,0x1f
    529e:	9fa5                	addw	a5,a5,s1
    52a0:	4017d79b          	sraiw	a5,a5,0x1
    52a4:	00094703          	lbu	a4,0(s2)
    52a8:	0af71063          	bne	a4,a5,5348 <bigfile+0x172>
    52ac:	12b94703          	lbu	a4,299(s2)
    52b0:	08f71c63          	bne	a4,a5,5348 <bigfile+0x172>
    total += cc;
    52b4:	12c9899b          	addiw	s3,s3,300
  for (i = 0;; i++) {
    52b8:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ / 2);
    52ba:	b7c9                	j	527c <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    52bc:	85d6                	mv	a1,s5
    52be:	00003517          	auipc	a0,0x3
    52c2:	d1250513          	addi	a0,a0,-750 # 7fd0 <malloc+0x1f50>
    52c6:	00001097          	auipc	ra,0x1
    52ca:	cfc080e7          	jalr	-772(ra) # 5fc2 <printf>
    exit(1);
    52ce:	4505                	li	a0,1
    52d0:	00001097          	auipc	ra,0x1
    52d4:	97a080e7          	jalr	-1670(ra) # 5c4a <exit>
      printf("%s: write bigfile failed\n", s);
    52d8:	85d6                	mv	a1,s5
    52da:	00003517          	auipc	a0,0x3
    52de:	d1650513          	addi	a0,a0,-746 # 7ff0 <malloc+0x1f70>
    52e2:	00001097          	auipc	ra,0x1
    52e6:	ce0080e7          	jalr	-800(ra) # 5fc2 <printf>
      exit(1);
    52ea:	4505                	li	a0,1
    52ec:	00001097          	auipc	ra,0x1
    52f0:	95e080e7          	jalr	-1698(ra) # 5c4a <exit>
    printf("%s: cannot open bigfile\n", s);
    52f4:	85d6                	mv	a1,s5
    52f6:	00003517          	auipc	a0,0x3
    52fa:	d1a50513          	addi	a0,a0,-742 # 8010 <malloc+0x1f90>
    52fe:	00001097          	auipc	ra,0x1
    5302:	cc4080e7          	jalr	-828(ra) # 5fc2 <printf>
    exit(1);
    5306:	4505                	li	a0,1
    5308:	00001097          	auipc	ra,0x1
    530c:	942080e7          	jalr	-1726(ra) # 5c4a <exit>
      printf("%s: read bigfile failed\n", s);
    5310:	85d6                	mv	a1,s5
    5312:	00003517          	auipc	a0,0x3
    5316:	d1e50513          	addi	a0,a0,-738 # 8030 <malloc+0x1fb0>
    531a:	00001097          	auipc	ra,0x1
    531e:	ca8080e7          	jalr	-856(ra) # 5fc2 <printf>
      exit(1);
    5322:	4505                	li	a0,1
    5324:	00001097          	auipc	ra,0x1
    5328:	926080e7          	jalr	-1754(ra) # 5c4a <exit>
      printf("%s: short read bigfile\n", s);
    532c:	85d6                	mv	a1,s5
    532e:	00003517          	auipc	a0,0x3
    5332:	d2250513          	addi	a0,a0,-734 # 8050 <malloc+0x1fd0>
    5336:	00001097          	auipc	ra,0x1
    533a:	c8c080e7          	jalr	-884(ra) # 5fc2 <printf>
      exit(1);
    533e:	4505                	li	a0,1
    5340:	00001097          	auipc	ra,0x1
    5344:	90a080e7          	jalr	-1782(ra) # 5c4a <exit>
      printf("%s: read bigfile wrong data\n", s);
    5348:	85d6                	mv	a1,s5
    534a:	00003517          	auipc	a0,0x3
    534e:	d1e50513          	addi	a0,a0,-738 # 8068 <malloc+0x1fe8>
    5352:	00001097          	auipc	ra,0x1
    5356:	c70080e7          	jalr	-912(ra) # 5fc2 <printf>
      exit(1);
    535a:	4505                	li	a0,1
    535c:	00001097          	auipc	ra,0x1
    5360:	8ee080e7          	jalr	-1810(ra) # 5c4a <exit>
  close(fd);
    5364:	8552                	mv	a0,s4
    5366:	00001097          	auipc	ra,0x1
    536a:	90c080e7          	jalr	-1780(ra) # 5c72 <close>
  if (total != N * SZ) {
    536e:	678d                	lui	a5,0x3
    5370:	ee078793          	addi	a5,a5,-288 # 2ee0 <sbrklast+0x80>
    5374:	02f99363          	bne	s3,a5,539a <bigfile+0x1c4>
  unlink("bigfile.dat");
    5378:	00003517          	auipc	a0,0x3
    537c:	c4850513          	addi	a0,a0,-952 # 7fc0 <malloc+0x1f40>
    5380:	00001097          	auipc	ra,0x1
    5384:	91a080e7          	jalr	-1766(ra) # 5c9a <unlink>
}
    5388:	70e2                	ld	ra,56(sp)
    538a:	7442                	ld	s0,48(sp)
    538c:	74a2                	ld	s1,40(sp)
    538e:	7902                	ld	s2,32(sp)
    5390:	69e2                	ld	s3,24(sp)
    5392:	6a42                	ld	s4,16(sp)
    5394:	6aa2                	ld	s5,8(sp)
    5396:	6121                	addi	sp,sp,64
    5398:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    539a:	85d6                	mv	a1,s5
    539c:	00003517          	auipc	a0,0x3
    53a0:	cec50513          	addi	a0,a0,-788 # 8088 <malloc+0x2008>
    53a4:	00001097          	auipc	ra,0x1
    53a8:	c1e080e7          	jalr	-994(ra) # 5fc2 <printf>
    exit(1);
    53ac:	4505                	li	a0,1
    53ae:	00001097          	auipc	ra,0x1
    53b2:	89c080e7          	jalr	-1892(ra) # 5c4a <exit>

00000000000053b6 <fsfull>:
void fsfull() {
    53b6:	7171                	addi	sp,sp,-176
    53b8:	f506                	sd	ra,168(sp)
    53ba:	f122                	sd	s0,160(sp)
    53bc:	ed26                	sd	s1,152(sp)
    53be:	e94a                	sd	s2,144(sp)
    53c0:	e54e                	sd	s3,136(sp)
    53c2:	e152                	sd	s4,128(sp)
    53c4:	fcd6                	sd	s5,120(sp)
    53c6:	f8da                	sd	s6,112(sp)
    53c8:	f4de                	sd	s7,104(sp)
    53ca:	f0e2                	sd	s8,96(sp)
    53cc:	ece6                	sd	s9,88(sp)
    53ce:	e8ea                	sd	s10,80(sp)
    53d0:	e4ee                	sd	s11,72(sp)
    53d2:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    53d4:	00003517          	auipc	a0,0x3
    53d8:	cd450513          	addi	a0,a0,-812 # 80a8 <malloc+0x2028>
    53dc:	00001097          	auipc	ra,0x1
    53e0:	be6080e7          	jalr	-1050(ra) # 5fc2 <printf>
  int fsblocks = 0;
    53e4:	4981                	li	s3,0
  for (nfiles = 0;; nfiles++) {
    53e6:	4481                	li	s1,0
    name[0] = 'f';
    53e8:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    53ec:	3e800c93          	li	s9,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    53f0:	06400c13          	li	s8,100
    name[3] = '0' + (nfiles % 100) / 10;
    53f4:	4ba9                	li	s7,10
    printf("writing %s\n", name);
    53f6:	00003d17          	auipc	s10,0x3
    53fa:	cc2d0d13          	addi	s10,s10,-830 # 80b8 <malloc+0x2038>
      int cc = write(fd, buf, BSIZE);
    53fe:	00008a97          	auipc	s5,0x8
    5402:	87aa8a93          	addi	s5,s5,-1926 # cc78 <buf>
    name[0] = 'f';
    5406:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    540a:	0394c7bb          	divw	a5,s1,s9
    540e:	0307879b          	addiw	a5,a5,48
    5412:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5416:	0394e7bb          	remw	a5,s1,s9
    541a:	0387c7bb          	divw	a5,a5,s8
    541e:	0307879b          	addiw	a5,a5,48
    5422:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5426:	0384e7bb          	remw	a5,s1,s8
    542a:	0377c7bb          	divw	a5,a5,s7
    542e:	0307879b          	addiw	a5,a5,48
    5432:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    5436:	0374e7bb          	remw	a5,s1,s7
    543a:	0307879b          	addiw	a5,a5,48
    543e:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    5442:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    5446:	f5040593          	addi	a1,s0,-176
    544a:	856a                	mv	a0,s10
    544c:	00001097          	auipc	ra,0x1
    5450:	b76080e7          	jalr	-1162(ra) # 5fc2 <printf>
    int fd = open(name, O_CREATE | O_RDWR);
    5454:	20200593          	li	a1,514
    5458:	f5040513          	addi	a0,s0,-176
    545c:	00001097          	auipc	ra,0x1
    5460:	82e080e7          	jalr	-2002(ra) # 5c8a <open>
    5464:	892a                	mv	s2,a0
    if (fd < 0) {
    5466:	0a055663          	bgez	a0,5512 <fsfull+0x15c>
      printf("open %s failed\n", name);
    546a:	f5040593          	addi	a1,s0,-176
    546e:	00003517          	auipc	a0,0x3
    5472:	c5a50513          	addi	a0,a0,-934 # 80c8 <malloc+0x2048>
    5476:	00001097          	auipc	ra,0x1
    547a:	b4c080e7          	jalr	-1204(ra) # 5fc2 <printf>
  while (nfiles >= 0) {
    547e:	0604c363          	bltz	s1,54e4 <fsfull+0x12e>
    name[0] = 'f';
    5482:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    5486:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    548a:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    548e:	4929                	li	s2,10
  while (nfiles >= 0) {
    5490:	5afd                	li	s5,-1
    name[0] = 'f';
    5492:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    5496:	0344c7bb          	divw	a5,s1,s4
    549a:	0307879b          	addiw	a5,a5,48
    549e:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    54a2:	0344e7bb          	remw	a5,s1,s4
    54a6:	0337c7bb          	divw	a5,a5,s3
    54aa:	0307879b          	addiw	a5,a5,48
    54ae:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    54b2:	0334e7bb          	remw	a5,s1,s3
    54b6:	0327c7bb          	divw	a5,a5,s2
    54ba:	0307879b          	addiw	a5,a5,48
    54be:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    54c2:	0324e7bb          	remw	a5,s1,s2
    54c6:	0307879b          	addiw	a5,a5,48
    54ca:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    54ce:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    54d2:	f5040513          	addi	a0,s0,-176
    54d6:	00000097          	auipc	ra,0x0
    54da:	7c4080e7          	jalr	1988(ra) # 5c9a <unlink>
    nfiles--;
    54de:	34fd                	addiw	s1,s1,-1
  while (nfiles >= 0) {
    54e0:	fb5499e3          	bne	s1,s5,5492 <fsfull+0xdc>
  printf("fsfull test finished\n");
    54e4:	00003517          	auipc	a0,0x3
    54e8:	c1450513          	addi	a0,a0,-1004 # 80f8 <malloc+0x2078>
    54ec:	00001097          	auipc	ra,0x1
    54f0:	ad6080e7          	jalr	-1322(ra) # 5fc2 <printf>
}
    54f4:	70aa                	ld	ra,168(sp)
    54f6:	740a                	ld	s0,160(sp)
    54f8:	64ea                	ld	s1,152(sp)
    54fa:	694a                	ld	s2,144(sp)
    54fc:	69aa                	ld	s3,136(sp)
    54fe:	6a0a                	ld	s4,128(sp)
    5500:	7ae6                	ld	s5,120(sp)
    5502:	7b46                	ld	s6,112(sp)
    5504:	7ba6                	ld	s7,104(sp)
    5506:	7c06                	ld	s8,96(sp)
    5508:	6ce6                	ld	s9,88(sp)
    550a:	6d46                	ld	s10,80(sp)
    550c:	6da6                	ld	s11,72(sp)
    550e:	614d                	addi	sp,sp,176
    5510:	8082                	ret
    int total = 0;
    5512:	4a01                	li	s4,0
      if (cc < BSIZE) break;
    5514:	3ff00b13          	li	s6,1023
      int cc = write(fd, buf, BSIZE);
    5518:	40000613          	li	a2,1024
    551c:	85d6                	mv	a1,s5
    551e:	854a                	mv	a0,s2
    5520:	00000097          	auipc	ra,0x0
    5524:	74a080e7          	jalr	1866(ra) # 5c6a <write>
      if (cc < BSIZE) break;
    5528:	00ab5663          	bge	s6,a0,5534 <fsfull+0x17e>
      total += cc;
    552c:	00aa0a3b          	addw	s4,s4,a0
      fsblocks++;
    5530:	2985                	addiw	s3,s3,1
    while (1) {
    5532:	b7dd                	j	5518 <fsfull+0x162>
    printf("wrote %d bytes, %d blocks\n", total, fsblocks);
    5534:	864e                	mv	a2,s3
    5536:	85d2                	mv	a1,s4
    5538:	00003517          	auipc	a0,0x3
    553c:	ba050513          	addi	a0,a0,-1120 # 80d8 <malloc+0x2058>
    5540:	00001097          	auipc	ra,0x1
    5544:	a82080e7          	jalr	-1406(ra) # 5fc2 <printf>
    close(fd);
    5548:	854a                	mv	a0,s2
    554a:	00000097          	auipc	ra,0x0
    554e:	728080e7          	jalr	1832(ra) # 5c72 <close>
    if (total == 0) break;
    5552:	f20a06e3          	beqz	s4,547e <fsfull+0xc8>
  for (nfiles = 0;; nfiles++) {
    5556:	2485                	addiw	s1,s1,1
    5558:	b57d                	j	5406 <fsfull+0x50>

000000000000555a <run>:
// drive tests
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int run(void f(char *), char *s) {
    555a:	7179                	addi	sp,sp,-48
    555c:	f406                	sd	ra,40(sp)
    555e:	f022                	sd	s0,32(sp)
    5560:	ec26                	sd	s1,24(sp)
    5562:	e84a                	sd	s2,16(sp)
    5564:	1800                	addi	s0,sp,48
    5566:	84aa                	mv	s1,a0
    5568:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    556a:	00003517          	auipc	a0,0x3
    556e:	ba650513          	addi	a0,a0,-1114 # 8110 <malloc+0x2090>
    5572:	00001097          	auipc	ra,0x1
    5576:	a50080e7          	jalr	-1456(ra) # 5fc2 <printf>
  if ((pid = fork()) < 0) {
    557a:	00000097          	auipc	ra,0x0
    557e:	6c8080e7          	jalr	1736(ra) # 5c42 <fork>
    5582:	02054e63          	bltz	a0,55be <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if (pid == 0) {
    5586:	c929                	beqz	a0,55d8 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    5588:	fdc40513          	addi	a0,s0,-36
    558c:	00000097          	auipc	ra,0x0
    5590:	6c6080e7          	jalr	1734(ra) # 5c52 <wait>
    if (xstatus != 0)
    5594:	fdc42783          	lw	a5,-36(s0)
    5598:	c7b9                	beqz	a5,55e6 <run+0x8c>
      printf("FAILED\n");
    559a:	00003517          	auipc	a0,0x3
    559e:	b9e50513          	addi	a0,a0,-1122 # 8138 <malloc+0x20b8>
    55a2:	00001097          	auipc	ra,0x1
    55a6:	a20080e7          	jalr	-1504(ra) # 5fc2 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    55aa:	fdc42503          	lw	a0,-36(s0)
  }
}
    55ae:	00153513          	seqz	a0,a0
    55b2:	70a2                	ld	ra,40(sp)
    55b4:	7402                	ld	s0,32(sp)
    55b6:	64e2                	ld	s1,24(sp)
    55b8:	6942                	ld	s2,16(sp)
    55ba:	6145                	addi	sp,sp,48
    55bc:	8082                	ret
    printf("runtest: fork error\n");
    55be:	00003517          	auipc	a0,0x3
    55c2:	b6250513          	addi	a0,a0,-1182 # 8120 <malloc+0x20a0>
    55c6:	00001097          	auipc	ra,0x1
    55ca:	9fc080e7          	jalr	-1540(ra) # 5fc2 <printf>
    exit(1);
    55ce:	4505                	li	a0,1
    55d0:	00000097          	auipc	ra,0x0
    55d4:	67a080e7          	jalr	1658(ra) # 5c4a <exit>
    f(s);
    55d8:	854a                	mv	a0,s2
    55da:	9482                	jalr	s1
    exit(0);
    55dc:	4501                	li	a0,0
    55de:	00000097          	auipc	ra,0x0
    55e2:	66c080e7          	jalr	1644(ra) # 5c4a <exit>
      printf("OK\n");
    55e6:	00003517          	auipc	a0,0x3
    55ea:	b5a50513          	addi	a0,a0,-1190 # 8140 <malloc+0x20c0>
    55ee:	00001097          	auipc	ra,0x1
    55f2:	9d4080e7          	jalr	-1580(ra) # 5fc2 <printf>
    55f6:	bf55                	j	55aa <run+0x50>

00000000000055f8 <runtests>:

int runtests(struct test *tests, char *justone, int continuous) {
    55f8:	7179                	addi	sp,sp,-48
    55fa:	f406                	sd	ra,40(sp)
    55fc:	f022                	sd	s0,32(sp)
    55fe:	ec26                	sd	s1,24(sp)
    5600:	e84a                	sd	s2,16(sp)
    5602:	e44e                	sd	s3,8(sp)
    5604:	e052                	sd	s4,0(sp)
    5606:	1800                	addi	s0,sp,48
    5608:	84aa                	mv	s1,a0
  for (struct test *t = tests; t->s != 0; t++) {
    560a:	6508                	ld	a0,8(a0)
    560c:	c931                	beqz	a0,5660 <runtests+0x68>
    560e:	892e                	mv	s2,a1
    5610:	89b2                	mv	s3,a2
    if ((justone == 0) || strcmp(t->s, justone) == 0) {
      if (!run(t->f, t->s)) {
        if (continuous != 2) {
    5612:	4a09                	li	s4,2
    5614:	a021                	j	561c <runtests+0x24>
  for (struct test *t = tests; t->s != 0; t++) {
    5616:	04c1                	addi	s1,s1,16
    5618:	6488                	ld	a0,8(s1)
    561a:	c91d                	beqz	a0,5650 <runtests+0x58>
    if ((justone == 0) || strcmp(t->s, justone) == 0) {
    561c:	00090863          	beqz	s2,562c <runtests+0x34>
    5620:	85ca                	mv	a1,s2
    5622:	00000097          	auipc	ra,0x0
    5626:	3d6080e7          	jalr	982(ra) # 59f8 <strcmp>
    562a:	f575                	bnez	a0,5616 <runtests+0x1e>
      if (!run(t->f, t->s)) {
    562c:	648c                	ld	a1,8(s1)
    562e:	6088                	ld	a0,0(s1)
    5630:	00000097          	auipc	ra,0x0
    5634:	f2a080e7          	jalr	-214(ra) # 555a <run>
    5638:	fd79                	bnez	a0,5616 <runtests+0x1e>
        if (continuous != 2) {
    563a:	fd498ee3          	beq	s3,s4,5616 <runtests+0x1e>
          printf("SOME TESTS FAILED\n");
    563e:	00003517          	auipc	a0,0x3
    5642:	b0a50513          	addi	a0,a0,-1270 # 8148 <malloc+0x20c8>
    5646:	00001097          	auipc	ra,0x1
    564a:	97c080e7          	jalr	-1668(ra) # 5fc2 <printf>
          return 1;
    564e:	4505                	li	a0,1
        }
      }
    }
  }
  return 0;
}
    5650:	70a2                	ld	ra,40(sp)
    5652:	7402                	ld	s0,32(sp)
    5654:	64e2                	ld	s1,24(sp)
    5656:	6942                	ld	s2,16(sp)
    5658:	69a2                	ld	s3,8(sp)
    565a:	6a02                	ld	s4,0(sp)
    565c:	6145                	addi	sp,sp,48
    565e:	8082                	ret
  return 0;
    5660:	4501                	li	a0,0
    5662:	b7fd                	j	5650 <runtests+0x58>

0000000000005664 <countfree>:
// use sbrk() to count how many free physical memory pages there are.
// touches the pages to force allocation.
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int countfree() {
    5664:	7139                	addi	sp,sp,-64
    5666:	fc06                	sd	ra,56(sp)
    5668:	f822                	sd	s0,48(sp)
    566a:	f426                	sd	s1,40(sp)
    566c:	f04a                	sd	s2,32(sp)
    566e:	ec4e                	sd	s3,24(sp)
    5670:	0080                	addi	s0,sp,64
  int fds[2];

  if (pipe(fds) < 0) {
    5672:	fc840513          	addi	a0,s0,-56
    5676:	00000097          	auipc	ra,0x0
    567a:	5e4080e7          	jalr	1508(ra) # 5c5a <pipe>
    567e:	06054763          	bltz	a0,56ec <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }

  int pid = fork();
    5682:	00000097          	auipc	ra,0x0
    5686:	5c0080e7          	jalr	1472(ra) # 5c42 <fork>

  if (pid < 0) {
    568a:	06054e63          	bltz	a0,5706 <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if (pid == 0) {
    568e:	ed51                	bnez	a0,572a <countfree+0xc6>
    close(fds[0]);
    5690:	fc842503          	lw	a0,-56(s0)
    5694:	00000097          	auipc	ra,0x0
    5698:	5de080e7          	jalr	1502(ra) # 5c72 <close>

    while (1) {
      uint64 a = (uint64)sbrk(4096);
      if (a == 0xffffffffffffffff) {
    569c:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    569e:	4485                	li	s1,1

      // report back one more page.
      if (write(fds[1], "x", 1) != 1) {
    56a0:	00001997          	auipc	s3,0x1
    56a4:	b9898993          	addi	s3,s3,-1128 # 6238 <malloc+0x1b8>
      uint64 a = (uint64)sbrk(4096);
    56a8:	6505                	lui	a0,0x1
    56aa:	00000097          	auipc	ra,0x0
    56ae:	628080e7          	jalr	1576(ra) # 5cd2 <sbrk>
      if (a == 0xffffffffffffffff) {
    56b2:	07250763          	beq	a0,s2,5720 <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    56b6:	6785                	lui	a5,0x1
    56b8:	953e                	add	a0,a0,a5
    56ba:	fe950fa3          	sb	s1,-1(a0) # fff <linktest+0x101>
      if (write(fds[1], "x", 1) != 1) {
    56be:	8626                	mv	a2,s1
    56c0:	85ce                	mv	a1,s3
    56c2:	fcc42503          	lw	a0,-52(s0)
    56c6:	00000097          	auipc	ra,0x0
    56ca:	5a4080e7          	jalr	1444(ra) # 5c6a <write>
    56ce:	fc950de3          	beq	a0,s1,56a8 <countfree+0x44>
        printf("write() failed in countfree()\n");
    56d2:	00003517          	auipc	a0,0x3
    56d6:	ace50513          	addi	a0,a0,-1330 # 81a0 <malloc+0x2120>
    56da:	00001097          	auipc	ra,0x1
    56de:	8e8080e7          	jalr	-1816(ra) # 5fc2 <printf>
        exit(1);
    56e2:	4505                	li	a0,1
    56e4:	00000097          	auipc	ra,0x0
    56e8:	566080e7          	jalr	1382(ra) # 5c4a <exit>
    printf("pipe() failed in countfree()\n");
    56ec:	00003517          	auipc	a0,0x3
    56f0:	a7450513          	addi	a0,a0,-1420 # 8160 <malloc+0x20e0>
    56f4:	00001097          	auipc	ra,0x1
    56f8:	8ce080e7          	jalr	-1842(ra) # 5fc2 <printf>
    exit(1);
    56fc:	4505                	li	a0,1
    56fe:	00000097          	auipc	ra,0x0
    5702:	54c080e7          	jalr	1356(ra) # 5c4a <exit>
    printf("fork failed in countfree()\n");
    5706:	00003517          	auipc	a0,0x3
    570a:	a7a50513          	addi	a0,a0,-1414 # 8180 <malloc+0x2100>
    570e:	00001097          	auipc	ra,0x1
    5712:	8b4080e7          	jalr	-1868(ra) # 5fc2 <printf>
    exit(1);
    5716:	4505                	li	a0,1
    5718:	00000097          	auipc	ra,0x0
    571c:	532080e7          	jalr	1330(ra) # 5c4a <exit>
      }
    }

    exit(0);
    5720:	4501                	li	a0,0
    5722:	00000097          	auipc	ra,0x0
    5726:	528080e7          	jalr	1320(ra) # 5c4a <exit>
  }

  close(fds[1]);
    572a:	fcc42503          	lw	a0,-52(s0)
    572e:	00000097          	auipc	ra,0x0
    5732:	544080e7          	jalr	1348(ra) # 5c72 <close>

  int n = 0;
    5736:	4481                	li	s1,0
  while (1) {
    char c;
    int cc = read(fds[0], &c, 1);
    5738:	4605                	li	a2,1
    573a:	fc740593          	addi	a1,s0,-57
    573e:	fc842503          	lw	a0,-56(s0)
    5742:	00000097          	auipc	ra,0x0
    5746:	520080e7          	jalr	1312(ra) # 5c62 <read>
    if (cc < 0) {
    574a:	00054563          	bltz	a0,5754 <countfree+0xf0>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if (cc == 0) break;
    574e:	c105                	beqz	a0,576e <countfree+0x10a>
    n += 1;
    5750:	2485                	addiw	s1,s1,1
  while (1) {
    5752:	b7dd                	j	5738 <countfree+0xd4>
      printf("read() failed in countfree()\n");
    5754:	00003517          	auipc	a0,0x3
    5758:	a6c50513          	addi	a0,a0,-1428 # 81c0 <malloc+0x2140>
    575c:	00001097          	auipc	ra,0x1
    5760:	866080e7          	jalr	-1946(ra) # 5fc2 <printf>
      exit(1);
    5764:	4505                	li	a0,1
    5766:	00000097          	auipc	ra,0x0
    576a:	4e4080e7          	jalr	1252(ra) # 5c4a <exit>
  }

  close(fds[0]);
    576e:	fc842503          	lw	a0,-56(s0)
    5772:	00000097          	auipc	ra,0x0
    5776:	500080e7          	jalr	1280(ra) # 5c72 <close>
  wait((int *)0);
    577a:	4501                	li	a0,0
    577c:	00000097          	auipc	ra,0x0
    5780:	4d6080e7          	jalr	1238(ra) # 5c52 <wait>

  return n;
}
    5784:	8526                	mv	a0,s1
    5786:	70e2                	ld	ra,56(sp)
    5788:	7442                	ld	s0,48(sp)
    578a:	74a2                	ld	s1,40(sp)
    578c:	7902                	ld	s2,32(sp)
    578e:	69e2                	ld	s3,24(sp)
    5790:	6121                	addi	sp,sp,64
    5792:	8082                	ret

0000000000005794 <drivetests>:

int drivetests(int mode, int continuous, char *justone) {
    5794:	711d                	addi	sp,sp,-96
    5796:	ec86                	sd	ra,88(sp)
    5798:	e8a2                	sd	s0,80(sp)
    579a:	e4a6                	sd	s1,72(sp)
    579c:	e0ca                	sd	s2,64(sp)
    579e:	fc4e                	sd	s3,56(sp)
    57a0:	f852                	sd	s4,48(sp)
    57a2:	f456                	sd	s5,40(sp)
    57a4:	f05a                	sd	s6,32(sp)
    57a6:	ec5e                	sd	s7,24(sp)
    57a8:	e862                	sd	s8,16(sp)
    57aa:	e466                	sd	s9,8(sp)
    57ac:	e06a                	sd	s10,0(sp)
    57ae:	1080                	addi	s0,sp,96
    57b0:	892e                	mv	s2,a1
    57b2:	89b2                	mv	s3,a2
  do {
    printf("usertests starting\n");
    57b4:	00003b17          	auipc	s6,0x3
    57b8:	a2cb0b13          	addi	s6,s6,-1492 # 81e0 <malloc+0x2160>
    int free0 = countfree();
    int free1 = 0;
    if ((mode & 1) == 1) {
    57bc:	00157a93          	andi	s5,a0,1
      if (runtests(quicktests, justone, continuous)) {
    57c0:	00004c97          	auipc	s9,0x4
    57c4:	850c8c93          	addi	s9,s9,-1968 # 9010 <quicktests>
        if (continuous != 2) {
    57c8:	4c09                	li	s8,2
          return 1;
        }
      }
    }
    if ((mode & 2) == 2) {
    57ca:	00257a13          	andi	s4,a0,2
          return 1;
        }
      }
    }
    if ((free1 = countfree()) < free0) {
      printf("Lost some free pages: %d out of %d\n", free1, free0);
    57ce:	00003d17          	auipc	s10,0x3
    57d2:	a4ad0d13          	addi	s10,s10,-1462 # 8218 <malloc+0x2198>
      if (runtests(slowtests, justone, continuous)) {
    57d6:	00004b97          	auipc	s7,0x4
    57da:	c0ab8b93          	addi	s7,s7,-1014 # 93e0 <slowtests>
    57de:	a835                	j	581a <drivetests+0x86>
      if (runtests(quicktests, justone, continuous)) {
    57e0:	864a                	mv	a2,s2
    57e2:	85ce                	mv	a1,s3
    57e4:	8566                	mv	a0,s9
    57e6:	00000097          	auipc	ra,0x0
    57ea:	e12080e7          	jalr	-494(ra) # 55f8 <runtests>
    57ee:	c131                	beqz	a0,5832 <drivetests+0x9e>
        if (continuous != 2) {
    57f0:	05890163          	beq	s2,s8,5832 <drivetests+0x9e>
          return 1;
    57f4:	8956                	mv	s2,s5
    57f6:	a89d                	j	586c <drivetests+0xd8>
      if (justone == 0) printf("usertests slow tests starting\n");
    57f8:	00003517          	auipc	a0,0x3
    57fc:	a0050513          	addi	a0,a0,-1536 # 81f8 <malloc+0x2178>
    5800:	00000097          	auipc	ra,0x0
    5804:	7c2080e7          	jalr	1986(ra) # 5fc2 <printf>
    5808:	a80d                	j	583a <drivetests+0xa6>
    if ((free1 = countfree()) < free0) {
    580a:	00000097          	auipc	ra,0x0
    580e:	e5a080e7          	jalr	-422(ra) # 5664 <countfree>
    5812:	04954463          	blt	a0,s1,585a <drivetests+0xc6>
    }
  } while (continuous);
    5816:	04090b63          	beqz	s2,586c <drivetests+0xd8>
    printf("usertests starting\n");
    581a:	855a                	mv	a0,s6
    581c:	00000097          	auipc	ra,0x0
    5820:	7a6080e7          	jalr	1958(ra) # 5fc2 <printf>
    int free0 = countfree();
    5824:	00000097          	auipc	ra,0x0
    5828:	e40080e7          	jalr	-448(ra) # 5664 <countfree>
    582c:	84aa                	mv	s1,a0
    if ((mode & 1) == 1) {
    582e:	fa0a99e3          	bnez	s5,57e0 <drivetests+0x4c>
    if ((mode & 2) == 2) {
    5832:	fc0a0ce3          	beqz	s4,580a <drivetests+0x76>
      if (justone == 0) printf("usertests slow tests starting\n");
    5836:	fc0981e3          	beqz	s3,57f8 <drivetests+0x64>
      if (runtests(slowtests, justone, continuous)) {
    583a:	864a                	mv	a2,s2
    583c:	85ce                	mv	a1,s3
    583e:	855e                	mv	a0,s7
    5840:	00000097          	auipc	ra,0x0
    5844:	db8080e7          	jalr	-584(ra) # 55f8 <runtests>
    5848:	d169                	beqz	a0,580a <drivetests+0x76>
        if (continuous != 2) {
    584a:	03891063          	bne	s2,s8,586a <drivetests+0xd6>
    if ((free1 = countfree()) < free0) {
    584e:	00000097          	auipc	ra,0x0
    5852:	e16080e7          	jalr	-490(ra) # 5664 <countfree>
    5856:	fc9552e3          	bge	a0,s1,581a <drivetests+0x86>
      printf("Lost some free pages: %d out of %d\n", free1, free0);
    585a:	8626                	mv	a2,s1
    585c:	85aa                	mv	a1,a0
    585e:	856a                	mv	a0,s10
    5860:	00000097          	auipc	ra,0x0
    5864:	762080e7          	jalr	1890(ra) # 5fc2 <printf>
    5868:	b77d                	j	5816 <drivetests+0x82>
          return 1;
    586a:	4905                	li	s2,1
  return 0;
}
    586c:	854a                	mv	a0,s2
    586e:	60e6                	ld	ra,88(sp)
    5870:	6446                	ld	s0,80(sp)
    5872:	64a6                	ld	s1,72(sp)
    5874:	6906                	ld	s2,64(sp)
    5876:	79e2                	ld	s3,56(sp)
    5878:	7a42                	ld	s4,48(sp)
    587a:	7aa2                	ld	s5,40(sp)
    587c:	7b02                	ld	s6,32(sp)
    587e:	6be2                	ld	s7,24(sp)
    5880:	6c42                	ld	s8,16(sp)
    5882:	6ca2                	ld	s9,8(sp)
    5884:	6d02                	ld	s10,0(sp)
    5886:	6125                	addi	sp,sp,96
    5888:	8082                	ret

000000000000588a <main>:

int main(int argc, char *argv[]) {
    588a:	1101                	addi	sp,sp,-32
    588c:	ec06                	sd	ra,24(sp)
    588e:	e822                	sd	s0,16(sp)
    5890:	e426                	sd	s1,8(sp)
    5892:	e04a                	sd	s2,0(sp)
    5894:	1000                	addi	s0,sp,32
    5896:	84aa                	mv	s1,a0
  int continuous = 0;
  int mode = 3;
  char *justone = 0;

  if (argc == 2 && strcmp(argv[1], "-q") == 0) {
    5898:	4789                	li	a5,2
    589a:	02f50363          	beq	a0,a5,58c0 <main+0x36>
    continuous = 2;
  } else if (argc == 2 && strcmp(argv[1], "-s") == 0) {
    mode = 2;
  } else if (argc == 2 && argv[1][0] != '-') {
    justone = argv[1];
  } else if (argc > 1) {
    589e:	4785                	li	a5,1
    58a0:	08a7ca63          	blt	a5,a0,5934 <main+0xaa>
  char *justone = 0;
    58a4:	4601                	li	a2,0
  int mode = 3;
    58a6:	448d                	li	s1,3
  int continuous = 0;
    58a8:	4581                	li	a1,0
    printf(" -C  run tests in a loop forever\n");
    printf(" -q  run only fast tests\n");
    printf(" -s  run only slow tests\n");
    exit(1);
  }
  if (drivetests(mode, continuous, justone)) {
    58aa:	8526                	mv	a0,s1
    58ac:	00000097          	auipc	ra,0x0
    58b0:	ee8080e7          	jalr	-280(ra) # 5794 <drivetests>
    58b4:	c975                	beqz	a0,59a8 <main+0x11e>
    exit(1);
    58b6:	4505                	li	a0,1
    58b8:	00000097          	auipc	ra,0x0
    58bc:	392080e7          	jalr	914(ra) # 5c4a <exit>
    58c0:	892e                	mv	s2,a1
  if (argc == 2 && strcmp(argv[1], "-q") == 0) {
    58c2:	00003597          	auipc	a1,0x3
    58c6:	97e58593          	addi	a1,a1,-1666 # 8240 <malloc+0x21c0>
    58ca:	00893503          	ld	a0,8(s2)
    58ce:	00000097          	auipc	ra,0x0
    58d2:	12a080e7          	jalr	298(ra) # 59f8 <strcmp>
    58d6:	85aa                	mv	a1,a0
    58d8:	c95d                	beqz	a0,598e <main+0x104>
  } else if (argc == 2 && strcmp(argv[1], "-c") == 0) {
    58da:	00003597          	auipc	a1,0x3
    58de:	a6658593          	addi	a1,a1,-1434 # 8340 <malloc+0x22c0>
    58e2:	00893503          	ld	a0,8(s2)
    58e6:	00000097          	auipc	ra,0x0
    58ea:	112080e7          	jalr	274(ra) # 59f8 <strcmp>
    58ee:	c94d                	beqz	a0,59a0 <main+0x116>
  } else if (argc == 2 && strcmp(argv[1], "-C") == 0) {
    58f0:	00003597          	auipc	a1,0x3
    58f4:	a4858593          	addi	a1,a1,-1464 # 8338 <malloc+0x22b8>
    58f8:	00893503          	ld	a0,8(s2)
    58fc:	00000097          	auipc	ra,0x0
    5900:	0fc080e7          	jalr	252(ra) # 59f8 <strcmp>
    5904:	c951                	beqz	a0,5998 <main+0x10e>
  } else if (argc == 2 && strcmp(argv[1], "-s") == 0) {
    5906:	00003597          	auipc	a1,0x3
    590a:	a2a58593          	addi	a1,a1,-1494 # 8330 <malloc+0x22b0>
    590e:	00893503          	ld	a0,8(s2)
    5912:	00000097          	auipc	ra,0x0
    5916:	0e6080e7          	jalr	230(ra) # 59f8 <strcmp>
    591a:	85aa                	mv	a1,a0
    591c:	cd25                	beqz	a0,5994 <main+0x10a>
  } else if (argc == 2 && argv[1][0] != '-') {
    591e:	00893603          	ld	a2,8(s2)
    5922:	00064703          	lbu	a4,0(a2) # 3000 <execout+0x98>
    5926:	02d00793          	li	a5,45
    592a:	00f70563          	beq	a4,a5,5934 <main+0xaa>
  int mode = 3;
    592e:	448d                	li	s1,3
  int continuous = 0;
    5930:	4581                	li	a1,0
    5932:	bfa5                	j	58aa <main+0x20>
    printf("Usage: usertests [-c | -C | -q | -s] [testname]\n");
    5934:	00003517          	auipc	a0,0x3
    5938:	91450513          	addi	a0,a0,-1772 # 8248 <malloc+0x21c8>
    593c:	00000097          	auipc	ra,0x0
    5940:	686080e7          	jalr	1670(ra) # 5fc2 <printf>
    printf(" -c  run tests in a loop until they fail\n");
    5944:	00003517          	auipc	a0,0x3
    5948:	93c50513          	addi	a0,a0,-1732 # 8280 <malloc+0x2200>
    594c:	00000097          	auipc	ra,0x0
    5950:	676080e7          	jalr	1654(ra) # 5fc2 <printf>
    printf(" -C  run tests in a loop forever\n");
    5954:	00003517          	auipc	a0,0x3
    5958:	95c50513          	addi	a0,a0,-1700 # 82b0 <malloc+0x2230>
    595c:	00000097          	auipc	ra,0x0
    5960:	666080e7          	jalr	1638(ra) # 5fc2 <printf>
    printf(" -q  run only fast tests\n");
    5964:	00003517          	auipc	a0,0x3
    5968:	97450513          	addi	a0,a0,-1676 # 82d8 <malloc+0x2258>
    596c:	00000097          	auipc	ra,0x0
    5970:	656080e7          	jalr	1622(ra) # 5fc2 <printf>
    printf(" -s  run only slow tests\n");
    5974:	00003517          	auipc	a0,0x3
    5978:	98450513          	addi	a0,a0,-1660 # 82f8 <malloc+0x2278>
    597c:	00000097          	auipc	ra,0x0
    5980:	646080e7          	jalr	1606(ra) # 5fc2 <printf>
    exit(1);
    5984:	4505                	li	a0,1
    5986:	00000097          	auipc	ra,0x0
    598a:	2c4080e7          	jalr	708(ra) # 5c4a <exit>
  char *justone = 0;
    598e:	4601                	li	a2,0
    mode = 1;
    5990:	4485                	li	s1,1
    5992:	bf21                	j	58aa <main+0x20>
  char *justone = 0;
    5994:	4601                	li	a2,0
    5996:	bf11                	j	58aa <main+0x20>
    continuous = 2;
    5998:	85a6                	mv	a1,s1
  char *justone = 0;
    599a:	4601                	li	a2,0
  int mode = 3;
    599c:	448d                	li	s1,3
    599e:	b731                	j	58aa <main+0x20>
  char *justone = 0;
    59a0:	4601                	li	a2,0
  int mode = 3;
    59a2:	448d                	li	s1,3
    continuous = 1;
    59a4:	4585                	li	a1,1
    59a6:	b711                	j	58aa <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    59a8:	00003517          	auipc	a0,0x3
    59ac:	97050513          	addi	a0,a0,-1680 # 8318 <malloc+0x2298>
    59b0:	00000097          	auipc	ra,0x0
    59b4:	612080e7          	jalr	1554(ra) # 5fc2 <printf>
  exit(0);
    59b8:	4501                	li	a0,0
    59ba:	00000097          	auipc	ra,0x0
    59be:	290080e7          	jalr	656(ra) # 5c4a <exit>

00000000000059c2 <_main>:
#include "user/user.h"

//
// wrapper so that it's OK if main() does not call exit().
//
void _main() {
    59c2:	1141                	addi	sp,sp,-16
    59c4:	e406                	sd	ra,8(sp)
    59c6:	e022                	sd	s0,0(sp)
    59c8:	0800                	addi	s0,sp,16
  extern int main();
  main();
    59ca:	00000097          	auipc	ra,0x0
    59ce:	ec0080e7          	jalr	-320(ra) # 588a <main>
  exit(0);
    59d2:	4501                	li	a0,0
    59d4:	00000097          	auipc	ra,0x0
    59d8:	276080e7          	jalr	630(ra) # 5c4a <exit>

00000000000059dc <strcpy>:
}

char *strcpy(char *s, const char *t) {
    59dc:	1141                	addi	sp,sp,-16
    59de:	e422                	sd	s0,8(sp)
    59e0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
    59e2:	87aa                	mv	a5,a0
    59e4:	0585                	addi	a1,a1,1
    59e6:	0785                	addi	a5,a5,1
    59e8:	fff5c703          	lbu	a4,-1(a1)
    59ec:	fee78fa3          	sb	a4,-1(a5) # fff <linktest+0x101>
    59f0:	fb75                	bnez	a4,59e4 <strcpy+0x8>
    ;
  return os;
}
    59f2:	6422                	ld	s0,8(sp)
    59f4:	0141                	addi	sp,sp,16
    59f6:	8082                	ret

00000000000059f8 <strcmp>:

int strcmp(const char *p, const char *q) {
    59f8:	1141                	addi	sp,sp,-16
    59fa:	e422                	sd	s0,8(sp)
    59fc:	0800                	addi	s0,sp,16
  while (*p && *p == *q) p++, q++;
    59fe:	00054783          	lbu	a5,0(a0)
    5a02:	cb91                	beqz	a5,5a16 <strcmp+0x1e>
    5a04:	0005c703          	lbu	a4,0(a1)
    5a08:	00f71763          	bne	a4,a5,5a16 <strcmp+0x1e>
    5a0c:	0505                	addi	a0,a0,1
    5a0e:	0585                	addi	a1,a1,1
    5a10:	00054783          	lbu	a5,0(a0)
    5a14:	fbe5                	bnez	a5,5a04 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    5a16:	0005c503          	lbu	a0,0(a1)
}
    5a1a:	40a7853b          	subw	a0,a5,a0
    5a1e:	6422                	ld	s0,8(sp)
    5a20:	0141                	addi	sp,sp,16
    5a22:	8082                	ret

0000000000005a24 <strlen>:

uint strlen(const char *s) {
    5a24:	1141                	addi	sp,sp,-16
    5a26:	e422                	sd	s0,8(sp)
    5a28:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
    5a2a:	00054783          	lbu	a5,0(a0)
    5a2e:	cf91                	beqz	a5,5a4a <strlen+0x26>
    5a30:	0505                	addi	a0,a0,1
    5a32:	87aa                	mv	a5,a0
    5a34:	4685                	li	a3,1
    5a36:	9e89                	subw	a3,a3,a0
    5a38:	00f6853b          	addw	a0,a3,a5
    5a3c:	0785                	addi	a5,a5,1
    5a3e:	fff7c703          	lbu	a4,-1(a5)
    5a42:	fb7d                	bnez	a4,5a38 <strlen+0x14>
    ;
  return n;
}
    5a44:	6422                	ld	s0,8(sp)
    5a46:	0141                	addi	sp,sp,16
    5a48:	8082                	ret
  for (n = 0; s[n]; n++)
    5a4a:	4501                	li	a0,0
    5a4c:	bfe5                	j	5a44 <strlen+0x20>

0000000000005a4e <memset>:

void *memset(void *dst, int c, uint n) {
    5a4e:	1141                	addi	sp,sp,-16
    5a50:	e422                	sd	s0,8(sp)
    5a52:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
    5a54:	ca19                	beqz	a2,5a6a <memset+0x1c>
    5a56:	87aa                	mv	a5,a0
    5a58:	1602                	slli	a2,a2,0x20
    5a5a:	9201                	srli	a2,a2,0x20
    5a5c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    5a60:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
    5a64:	0785                	addi	a5,a5,1
    5a66:	fee79de3          	bne	a5,a4,5a60 <memset+0x12>
  }
  return dst;
}
    5a6a:	6422                	ld	s0,8(sp)
    5a6c:	0141                	addi	sp,sp,16
    5a6e:	8082                	ret

0000000000005a70 <strchr>:

char *strchr(const char *s, char c) {
    5a70:	1141                	addi	sp,sp,-16
    5a72:	e422                	sd	s0,8(sp)
    5a74:	0800                	addi	s0,sp,16
  for (; *s; s++)
    5a76:	00054783          	lbu	a5,0(a0)
    5a7a:	cb99                	beqz	a5,5a90 <strchr+0x20>
    if (*s == c) return (char *)s;
    5a7c:	00f58763          	beq	a1,a5,5a8a <strchr+0x1a>
  for (; *s; s++)
    5a80:	0505                	addi	a0,a0,1
    5a82:	00054783          	lbu	a5,0(a0)
    5a86:	fbfd                	bnez	a5,5a7c <strchr+0xc>
  return 0;
    5a88:	4501                	li	a0,0
}
    5a8a:	6422                	ld	s0,8(sp)
    5a8c:	0141                	addi	sp,sp,16
    5a8e:	8082                	ret
  return 0;
    5a90:	4501                	li	a0,0
    5a92:	bfe5                	j	5a8a <strchr+0x1a>

0000000000005a94 <gets>:

char *gets(char *buf, int max) {
    5a94:	711d                	addi	sp,sp,-96
    5a96:	ec86                	sd	ra,88(sp)
    5a98:	e8a2                	sd	s0,80(sp)
    5a9a:	e4a6                	sd	s1,72(sp)
    5a9c:	e0ca                	sd	s2,64(sp)
    5a9e:	fc4e                	sd	s3,56(sp)
    5aa0:	f852                	sd	s4,48(sp)
    5aa2:	f456                	sd	s5,40(sp)
    5aa4:	f05a                	sd	s6,32(sp)
    5aa6:	ec5e                	sd	s7,24(sp)
    5aa8:	1080                	addi	s0,sp,96
    5aaa:	8baa                	mv	s7,a0
    5aac:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
    5aae:	892a                	mv	s2,a0
    5ab0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1) break;
    buf[i++] = c;
    if (c == '\n' || c == '\r') break;
    5ab2:	4aa9                	li	s5,10
    5ab4:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
    5ab6:	89a6                	mv	s3,s1
    5ab8:	2485                	addiw	s1,s1,1
    5aba:	0344d863          	bge	s1,s4,5aea <gets+0x56>
    cc = read(0, &c, 1);
    5abe:	4605                	li	a2,1
    5ac0:	faf40593          	addi	a1,s0,-81
    5ac4:	4501                	li	a0,0
    5ac6:	00000097          	auipc	ra,0x0
    5aca:	19c080e7          	jalr	412(ra) # 5c62 <read>
    if (cc < 1) break;
    5ace:	00a05e63          	blez	a0,5aea <gets+0x56>
    buf[i++] = c;
    5ad2:	faf44783          	lbu	a5,-81(s0)
    5ad6:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r') break;
    5ada:	01578763          	beq	a5,s5,5ae8 <gets+0x54>
    5ade:	0905                	addi	s2,s2,1
    5ae0:	fd679be3          	bne	a5,s6,5ab6 <gets+0x22>
  for (i = 0; i + 1 < max;) {
    5ae4:	89a6                	mv	s3,s1
    5ae6:	a011                	j	5aea <gets+0x56>
    5ae8:	89a6                	mv	s3,s1
  }
  buf[i] = '\0';
    5aea:	99de                	add	s3,s3,s7
    5aec:	00098023          	sb	zero,0(s3)
  return buf;
}
    5af0:	855e                	mv	a0,s7
    5af2:	60e6                	ld	ra,88(sp)
    5af4:	6446                	ld	s0,80(sp)
    5af6:	64a6                	ld	s1,72(sp)
    5af8:	6906                	ld	s2,64(sp)
    5afa:	79e2                	ld	s3,56(sp)
    5afc:	7a42                	ld	s4,48(sp)
    5afe:	7aa2                	ld	s5,40(sp)
    5b00:	7b02                	ld	s6,32(sp)
    5b02:	6be2                	ld	s7,24(sp)
    5b04:	6125                	addi	sp,sp,96
    5b06:	8082                	ret

0000000000005b08 <stat>:

int stat(const char *n, struct stat *st) {
    5b08:	1101                	addi	sp,sp,-32
    5b0a:	ec06                	sd	ra,24(sp)
    5b0c:	e822                	sd	s0,16(sp)
    5b0e:	e426                	sd	s1,8(sp)
    5b10:	e04a                	sd	s2,0(sp)
    5b12:	1000                	addi	s0,sp,32
    5b14:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5b16:	4581                	li	a1,0
    5b18:	00000097          	auipc	ra,0x0
    5b1c:	172080e7          	jalr	370(ra) # 5c8a <open>
  if (fd < 0) return -1;
    5b20:	02054563          	bltz	a0,5b4a <stat+0x42>
    5b24:	84aa                	mv	s1,a0
  r = fstat(fd, st);
    5b26:	85ca                	mv	a1,s2
    5b28:	00000097          	auipc	ra,0x0
    5b2c:	17a080e7          	jalr	378(ra) # 5ca2 <fstat>
    5b30:	892a                	mv	s2,a0
  close(fd);
    5b32:	8526                	mv	a0,s1
    5b34:	00000097          	auipc	ra,0x0
    5b38:	13e080e7          	jalr	318(ra) # 5c72 <close>
  return r;
}
    5b3c:	854a                	mv	a0,s2
    5b3e:	60e2                	ld	ra,24(sp)
    5b40:	6442                	ld	s0,16(sp)
    5b42:	64a2                	ld	s1,8(sp)
    5b44:	6902                	ld	s2,0(sp)
    5b46:	6105                	addi	sp,sp,32
    5b48:	8082                	ret
  if (fd < 0) return -1;
    5b4a:	597d                	li	s2,-1
    5b4c:	bfc5                	j	5b3c <stat+0x34>

0000000000005b4e <atoi>:

int atoi(const char *s) {
    5b4e:	1141                	addi	sp,sp,-16
    5b50:	e422                	sd	s0,8(sp)
    5b52:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
    5b54:	00054603          	lbu	a2,0(a0)
    5b58:	fd06079b          	addiw	a5,a2,-48
    5b5c:	0ff7f793          	andi	a5,a5,255
    5b60:	4725                	li	a4,9
    5b62:	02f76963          	bltu	a4,a5,5b94 <atoi+0x46>
    5b66:	86aa                	mv	a3,a0
  n = 0;
    5b68:	4501                	li	a0,0
  while ('0' <= *s && *s <= '9') n = n * 10 + *s++ - '0';
    5b6a:	45a5                	li	a1,9
    5b6c:	0685                	addi	a3,a3,1
    5b6e:	0025179b          	slliw	a5,a0,0x2
    5b72:	9fa9                	addw	a5,a5,a0
    5b74:	0017979b          	slliw	a5,a5,0x1
    5b78:	9fb1                	addw	a5,a5,a2
    5b7a:	fd07851b          	addiw	a0,a5,-48
    5b7e:	0006c603          	lbu	a2,0(a3)
    5b82:	fd06071b          	addiw	a4,a2,-48
    5b86:	0ff77713          	andi	a4,a4,255
    5b8a:	fee5f1e3          	bgeu	a1,a4,5b6c <atoi+0x1e>
  return n;
}
    5b8e:	6422                	ld	s0,8(sp)
    5b90:	0141                	addi	sp,sp,16
    5b92:	8082                	ret
  n = 0;
    5b94:	4501                	li	a0,0
    5b96:	bfe5                	j	5b8e <atoi+0x40>

0000000000005b98 <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
    5b98:	1141                	addi	sp,sp,-16
    5b9a:	e422                	sd	s0,8(sp)
    5b9c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5b9e:	02b57463          	bgeu	a0,a1,5bc6 <memmove+0x2e>
    while (n-- > 0) *dst++ = *src++;
    5ba2:	00c05f63          	blez	a2,5bc0 <memmove+0x28>
    5ba6:	1602                	slli	a2,a2,0x20
    5ba8:	9201                	srli	a2,a2,0x20
    5baa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    5bae:	872a                	mv	a4,a0
    while (n-- > 0) *dst++ = *src++;
    5bb0:	0585                	addi	a1,a1,1
    5bb2:	0705                	addi	a4,a4,1
    5bb4:	fff5c683          	lbu	a3,-1(a1)
    5bb8:	fed70fa3          	sb	a3,-1(a4)
    5bbc:	fee79ae3          	bne	a5,a4,5bb0 <memmove+0x18>
    dst += n;
    src += n;
    while (n-- > 0) *--dst = *--src;
  }
  return vdst;
}
    5bc0:	6422                	ld	s0,8(sp)
    5bc2:	0141                	addi	sp,sp,16
    5bc4:	8082                	ret
    dst += n;
    5bc6:	00c50733          	add	a4,a0,a2
    src += n;
    5bca:	95b2                	add	a1,a1,a2
    while (n-- > 0) *--dst = *--src;
    5bcc:	fec05ae3          	blez	a2,5bc0 <memmove+0x28>
    5bd0:	fff6079b          	addiw	a5,a2,-1
    5bd4:	1782                	slli	a5,a5,0x20
    5bd6:	9381                	srli	a5,a5,0x20
    5bd8:	fff7c793          	not	a5,a5
    5bdc:	97ba                	add	a5,a5,a4
    5bde:	15fd                	addi	a1,a1,-1
    5be0:	177d                	addi	a4,a4,-1
    5be2:	0005c683          	lbu	a3,0(a1)
    5be6:	00d70023          	sb	a3,0(a4)
    5bea:	fee79ae3          	bne	a5,a4,5bde <memmove+0x46>
    5bee:	bfc9                	j	5bc0 <memmove+0x28>

0000000000005bf0 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
    5bf0:	1141                	addi	sp,sp,-16
    5bf2:	e422                	sd	s0,8(sp)
    5bf4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5bf6:	ca05                	beqz	a2,5c26 <memcmp+0x36>
    5bf8:	fff6069b          	addiw	a3,a2,-1
    5bfc:	1682                	slli	a3,a3,0x20
    5bfe:	9281                	srli	a3,a3,0x20
    5c00:	0685                	addi	a3,a3,1
    5c02:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    5c04:	00054783          	lbu	a5,0(a0)
    5c08:	0005c703          	lbu	a4,0(a1)
    5c0c:	00e79863          	bne	a5,a4,5c1c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    5c10:	0505                	addi	a0,a0,1
    p2++;
    5c12:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    5c14:	fed518e3          	bne	a0,a3,5c04 <memcmp+0x14>
  }
  return 0;
    5c18:	4501                	li	a0,0
    5c1a:	a019                	j	5c20 <memcmp+0x30>
      return *p1 - *p2;
    5c1c:	40e7853b          	subw	a0,a5,a4
}
    5c20:	6422                	ld	s0,8(sp)
    5c22:	0141                	addi	sp,sp,16
    5c24:	8082                	ret
  return 0;
    5c26:	4501                	li	a0,0
    5c28:	bfe5                	j	5c20 <memcmp+0x30>

0000000000005c2a <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
    5c2a:	1141                	addi	sp,sp,-16
    5c2c:	e406                	sd	ra,8(sp)
    5c2e:	e022                	sd	s0,0(sp)
    5c30:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    5c32:	00000097          	auipc	ra,0x0
    5c36:	f66080e7          	jalr	-154(ra) # 5b98 <memmove>
}
    5c3a:	60a2                	ld	ra,8(sp)
    5c3c:	6402                	ld	s0,0(sp)
    5c3e:	0141                	addi	sp,sp,16
    5c40:	8082                	ret

0000000000005c42 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5c42:	4885                	li	a7,1
 ecall
    5c44:	00000073          	ecall
 ret
    5c48:	8082                	ret

0000000000005c4a <exit>:
.global exit
exit:
 li a7, SYS_exit
    5c4a:	4889                	li	a7,2
 ecall
    5c4c:	00000073          	ecall
 ret
    5c50:	8082                	ret

0000000000005c52 <wait>:
.global wait
wait:
 li a7, SYS_wait
    5c52:	488d                	li	a7,3
 ecall
    5c54:	00000073          	ecall
 ret
    5c58:	8082                	ret

0000000000005c5a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5c5a:	4891                	li	a7,4
 ecall
    5c5c:	00000073          	ecall
 ret
    5c60:	8082                	ret

0000000000005c62 <read>:
.global read
read:
 li a7, SYS_read
    5c62:	4895                	li	a7,5
 ecall
    5c64:	00000073          	ecall
 ret
    5c68:	8082                	ret

0000000000005c6a <write>:
.global write
write:
 li a7, SYS_write
    5c6a:	48c1                	li	a7,16
 ecall
    5c6c:	00000073          	ecall
 ret
    5c70:	8082                	ret

0000000000005c72 <close>:
.global close
close:
 li a7, SYS_close
    5c72:	48d5                	li	a7,21
 ecall
    5c74:	00000073          	ecall
 ret
    5c78:	8082                	ret

0000000000005c7a <kill>:
.global kill
kill:
 li a7, SYS_kill
    5c7a:	4899                	li	a7,6
 ecall
    5c7c:	00000073          	ecall
 ret
    5c80:	8082                	ret

0000000000005c82 <exec>:
.global exec
exec:
 li a7, SYS_exec
    5c82:	489d                	li	a7,7
 ecall
    5c84:	00000073          	ecall
 ret
    5c88:	8082                	ret

0000000000005c8a <open>:
.global open
open:
 li a7, SYS_open
    5c8a:	48bd                	li	a7,15
 ecall
    5c8c:	00000073          	ecall
 ret
    5c90:	8082                	ret

0000000000005c92 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5c92:	48c5                	li	a7,17
 ecall
    5c94:	00000073          	ecall
 ret
    5c98:	8082                	ret

0000000000005c9a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5c9a:	48c9                	li	a7,18
 ecall
    5c9c:	00000073          	ecall
 ret
    5ca0:	8082                	ret

0000000000005ca2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5ca2:	48a1                	li	a7,8
 ecall
    5ca4:	00000073          	ecall
 ret
    5ca8:	8082                	ret

0000000000005caa <link>:
.global link
link:
 li a7, SYS_link
    5caa:	48cd                	li	a7,19
 ecall
    5cac:	00000073          	ecall
 ret
    5cb0:	8082                	ret

0000000000005cb2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5cb2:	48d1                	li	a7,20
 ecall
    5cb4:	00000073          	ecall
 ret
    5cb8:	8082                	ret

0000000000005cba <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5cba:	48a5                	li	a7,9
 ecall
    5cbc:	00000073          	ecall
 ret
    5cc0:	8082                	ret

0000000000005cc2 <dup>:
.global dup
dup:
 li a7, SYS_dup
    5cc2:	48a9                	li	a7,10
 ecall
    5cc4:	00000073          	ecall
 ret
    5cc8:	8082                	ret

0000000000005cca <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5cca:	48ad                	li	a7,11
 ecall
    5ccc:	00000073          	ecall
 ret
    5cd0:	8082                	ret

0000000000005cd2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5cd2:	48b1                	li	a7,12
 ecall
    5cd4:	00000073          	ecall
 ret
    5cd8:	8082                	ret

0000000000005cda <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5cda:	48b5                	li	a7,13
 ecall
    5cdc:	00000073          	ecall
 ret
    5ce0:	8082                	ret

0000000000005ce2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5ce2:	48b9                	li	a7,14
 ecall
    5ce4:	00000073          	ecall
 ret
    5ce8:	8082                	ret

0000000000005cea <putc>:
#include "kernel/types.h"
#include "user/user.h"

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
    5cea:	1101                	addi	sp,sp,-32
    5cec:	ec06                	sd	ra,24(sp)
    5cee:	e822                	sd	s0,16(sp)
    5cf0:	1000                	addi	s0,sp,32
    5cf2:	feb407a3          	sb	a1,-17(s0)
    5cf6:	4605                	li	a2,1
    5cf8:	fef40593          	addi	a1,s0,-17
    5cfc:	00000097          	auipc	ra,0x0
    5d00:	f6e080e7          	jalr	-146(ra) # 5c6a <write>
    5d04:	60e2                	ld	ra,24(sp)
    5d06:	6442                	ld	s0,16(sp)
    5d08:	6105                	addi	sp,sp,32
    5d0a:	8082                	ret

0000000000005d0c <printint>:

static void printint(int fd, int xx, int base, int sgn) {
    5d0c:	7139                	addi	sp,sp,-64
    5d0e:	fc06                	sd	ra,56(sp)
    5d10:	f822                	sd	s0,48(sp)
    5d12:	f426                	sd	s1,40(sp)
    5d14:	f04a                	sd	s2,32(sp)
    5d16:	ec4e                	sd	s3,24(sp)
    5d18:	0080                	addi	s0,sp,64
    5d1a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if (sgn && xx < 0) {
    5d1c:	c299                	beqz	a3,5d22 <printint+0x16>
    5d1e:	0805c863          	bltz	a1,5dae <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5d22:	2581                	sext.w	a1,a1
  neg = 0;
    5d24:	4881                	li	a7,0
    5d26:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    5d2a:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    5d2c:	2601                	sext.w	a2,a2
    5d2e:	00003517          	auipc	a0,0x3
    5d32:	98250513          	addi	a0,a0,-1662 # 86b0 <digits>
    5d36:	883a                	mv	a6,a4
    5d38:	2705                	addiw	a4,a4,1
    5d3a:	02c5f7bb          	remuw	a5,a1,a2
    5d3e:	1782                	slli	a5,a5,0x20
    5d40:	9381                	srli	a5,a5,0x20
    5d42:	97aa                	add	a5,a5,a0
    5d44:	0007c783          	lbu	a5,0(a5)
    5d48:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
    5d4c:	0005879b          	sext.w	a5,a1
    5d50:	02c5d5bb          	divuw	a1,a1,a2
    5d54:	0685                	addi	a3,a3,1
    5d56:	fec7f0e3          	bgeu	a5,a2,5d36 <printint+0x2a>
  if (neg) buf[i++] = '-';
    5d5a:	00088b63          	beqz	a7,5d70 <printint+0x64>
    5d5e:	fd040793          	addi	a5,s0,-48
    5d62:	973e                	add	a4,a4,a5
    5d64:	02d00793          	li	a5,45
    5d68:	fef70823          	sb	a5,-16(a4)
    5d6c:	0028071b          	addiw	a4,a6,2

  while (--i >= 0) putc(fd, buf[i]);
    5d70:	02e05863          	blez	a4,5da0 <printint+0x94>
    5d74:	fc040793          	addi	a5,s0,-64
    5d78:	00e78933          	add	s2,a5,a4
    5d7c:	fff78993          	addi	s3,a5,-1
    5d80:	99ba                	add	s3,s3,a4
    5d82:	377d                	addiw	a4,a4,-1
    5d84:	1702                	slli	a4,a4,0x20
    5d86:	9301                	srli	a4,a4,0x20
    5d88:	40e989b3          	sub	s3,s3,a4
    5d8c:	fff94583          	lbu	a1,-1(s2)
    5d90:	8526                	mv	a0,s1
    5d92:	00000097          	auipc	ra,0x0
    5d96:	f58080e7          	jalr	-168(ra) # 5cea <putc>
    5d9a:	197d                	addi	s2,s2,-1
    5d9c:	ff3918e3          	bne	s2,s3,5d8c <printint+0x80>
}
    5da0:	70e2                	ld	ra,56(sp)
    5da2:	7442                	ld	s0,48(sp)
    5da4:	74a2                	ld	s1,40(sp)
    5da6:	7902                	ld	s2,32(sp)
    5da8:	69e2                	ld	s3,24(sp)
    5daa:	6121                	addi	sp,sp,64
    5dac:	8082                	ret
    x = -xx;
    5dae:	40b005bb          	negw	a1,a1
    neg = 1;
    5db2:	4885                	li	a7,1
    x = -xx;
    5db4:	bf8d                	j	5d26 <printint+0x1a>

0000000000005db6 <vprintf>:
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
    5db6:	7119                	addi	sp,sp,-128
    5db8:	fc86                	sd	ra,120(sp)
    5dba:	f8a2                	sd	s0,112(sp)
    5dbc:	f4a6                	sd	s1,104(sp)
    5dbe:	f0ca                	sd	s2,96(sp)
    5dc0:	ecce                	sd	s3,88(sp)
    5dc2:	e8d2                	sd	s4,80(sp)
    5dc4:	e4d6                	sd	s5,72(sp)
    5dc6:	e0da                	sd	s6,64(sp)
    5dc8:	fc5e                	sd	s7,56(sp)
    5dca:	f862                	sd	s8,48(sp)
    5dcc:	f466                	sd	s9,40(sp)
    5dce:	f06a                	sd	s10,32(sp)
    5dd0:	ec6e                	sd	s11,24(sp)
    5dd2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
    5dd4:	0005c903          	lbu	s2,0(a1)
    5dd8:	18090f63          	beqz	s2,5f76 <vprintf+0x1c0>
    5ddc:	8aaa                	mv	s5,a0
    5dde:	8b32                	mv	s6,a2
    5de0:	00158493          	addi	s1,a1,1
  state = 0;
    5de4:	4981                	li	s3,0
      if (c == '%') {
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if (state == '%') {
    5de6:	02500a13          	li	s4,37
      if (c == 'd') {
    5dea:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c == 'l') {
    5dee:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if (c == 'x') {
    5df2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if (c == 'p') {
    5df6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5dfa:	00003b97          	auipc	s7,0x3
    5dfe:	8b6b8b93          	addi	s7,s7,-1866 # 86b0 <digits>
    5e02:	a839                	j	5e20 <vprintf+0x6a>
        putc(fd, c);
    5e04:	85ca                	mv	a1,s2
    5e06:	8556                	mv	a0,s5
    5e08:	00000097          	auipc	ra,0x0
    5e0c:	ee2080e7          	jalr	-286(ra) # 5cea <putc>
    5e10:	a019                	j	5e16 <vprintf+0x60>
    } else if (state == '%') {
    5e12:	01498f63          	beq	s3,s4,5e30 <vprintf+0x7a>
  for (i = 0; fmt[i]; i++) {
    5e16:	0485                	addi	s1,s1,1
    5e18:	fff4c903          	lbu	s2,-1(s1)
    5e1c:	14090d63          	beqz	s2,5f76 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    5e20:	0009079b          	sext.w	a5,s2
    if (state == 0) {
    5e24:	fe0997e3          	bnez	s3,5e12 <vprintf+0x5c>
      if (c == '%') {
    5e28:	fd479ee3          	bne	a5,s4,5e04 <vprintf+0x4e>
        state = '%';
    5e2c:	89be                	mv	s3,a5
    5e2e:	b7e5                	j	5e16 <vprintf+0x60>
      if (c == 'd') {
    5e30:	05878063          	beq	a5,s8,5e70 <vprintf+0xba>
      } else if (c == 'l') {
    5e34:	05978c63          	beq	a5,s9,5e8c <vprintf+0xd6>
      } else if (c == 'x') {
    5e38:	07a78863          	beq	a5,s10,5ea8 <vprintf+0xf2>
      } else if (c == 'p') {
    5e3c:	09b78463          	beq	a5,s11,5ec4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if (c == 's') {
    5e40:	07300713          	li	a4,115
    5e44:	0ce78663          	beq	a5,a4,5f10 <vprintf+0x15a>
        if (s == 0) s = "(null)";
        while (*s != 0) {
          putc(fd, *s);
          s++;
        }
      } else if (c == 'c') {
    5e48:	06300713          	li	a4,99
    5e4c:	0ee78e63          	beq	a5,a4,5f48 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if (c == '%') {
    5e50:	11478863          	beq	a5,s4,5f60 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    5e54:	85d2                	mv	a1,s4
    5e56:	8556                	mv	a0,s5
    5e58:	00000097          	auipc	ra,0x0
    5e5c:	e92080e7          	jalr	-366(ra) # 5cea <putc>
        putc(fd, c);
    5e60:	85ca                	mv	a1,s2
    5e62:	8556                	mv	a0,s5
    5e64:	00000097          	auipc	ra,0x0
    5e68:	e86080e7          	jalr	-378(ra) # 5cea <putc>
      }
      state = 0;
    5e6c:	4981                	li	s3,0
    5e6e:	b765                	j	5e16 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    5e70:	008b0913          	addi	s2,s6,8
    5e74:	4685                	li	a3,1
    5e76:	4629                	li	a2,10
    5e78:	000b2583          	lw	a1,0(s6)
    5e7c:	8556                	mv	a0,s5
    5e7e:	00000097          	auipc	ra,0x0
    5e82:	e8e080e7          	jalr	-370(ra) # 5d0c <printint>
    5e86:	8b4a                	mv	s6,s2
      state = 0;
    5e88:	4981                	li	s3,0
    5e8a:	b771                	j	5e16 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5e8c:	008b0913          	addi	s2,s6,8
    5e90:	4681                	li	a3,0
    5e92:	4629                	li	a2,10
    5e94:	000b2583          	lw	a1,0(s6)
    5e98:	8556                	mv	a0,s5
    5e9a:	00000097          	auipc	ra,0x0
    5e9e:	e72080e7          	jalr	-398(ra) # 5d0c <printint>
    5ea2:	8b4a                	mv	s6,s2
      state = 0;
    5ea4:	4981                	li	s3,0
    5ea6:	bf85                	j	5e16 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    5ea8:	008b0913          	addi	s2,s6,8
    5eac:	4681                	li	a3,0
    5eae:	4641                	li	a2,16
    5eb0:	000b2583          	lw	a1,0(s6)
    5eb4:	8556                	mv	a0,s5
    5eb6:	00000097          	auipc	ra,0x0
    5eba:	e56080e7          	jalr	-426(ra) # 5d0c <printint>
    5ebe:	8b4a                	mv	s6,s2
      state = 0;
    5ec0:	4981                	li	s3,0
    5ec2:	bf91                	j	5e16 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    5ec4:	008b0793          	addi	a5,s6,8
    5ec8:	f8f43423          	sd	a5,-120(s0)
    5ecc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    5ed0:	03000593          	li	a1,48
    5ed4:	8556                	mv	a0,s5
    5ed6:	00000097          	auipc	ra,0x0
    5eda:	e14080e7          	jalr	-492(ra) # 5cea <putc>
  putc(fd, 'x');
    5ede:	85ea                	mv	a1,s10
    5ee0:	8556                	mv	a0,s5
    5ee2:	00000097          	auipc	ra,0x0
    5ee6:	e08080e7          	jalr	-504(ra) # 5cea <putc>
    5eea:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5eec:	03c9d793          	srli	a5,s3,0x3c
    5ef0:	97de                	add	a5,a5,s7
    5ef2:	0007c583          	lbu	a1,0(a5)
    5ef6:	8556                	mv	a0,s5
    5ef8:	00000097          	auipc	ra,0x0
    5efc:	df2080e7          	jalr	-526(ra) # 5cea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5f00:	0992                	slli	s3,s3,0x4
    5f02:	397d                	addiw	s2,s2,-1
    5f04:	fe0914e3          	bnez	s2,5eec <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    5f08:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    5f0c:	4981                	li	s3,0
    5f0e:	b721                	j	5e16 <vprintf+0x60>
        s = va_arg(ap, char *);
    5f10:	008b0993          	addi	s3,s6,8
    5f14:	000b3903          	ld	s2,0(s6)
        if (s == 0) s = "(null)";
    5f18:	02090163          	beqz	s2,5f3a <vprintf+0x184>
        while (*s != 0) {
    5f1c:	00094583          	lbu	a1,0(s2)
    5f20:	c9a1                	beqz	a1,5f70 <vprintf+0x1ba>
          putc(fd, *s);
    5f22:	8556                	mv	a0,s5
    5f24:	00000097          	auipc	ra,0x0
    5f28:	dc6080e7          	jalr	-570(ra) # 5cea <putc>
          s++;
    5f2c:	0905                	addi	s2,s2,1
        while (*s != 0) {
    5f2e:	00094583          	lbu	a1,0(s2)
    5f32:	f9e5                	bnez	a1,5f22 <vprintf+0x16c>
        s = va_arg(ap, char *);
    5f34:	8b4e                	mv	s6,s3
      state = 0;
    5f36:	4981                	li	s3,0
    5f38:	bdf9                	j	5e16 <vprintf+0x60>
        if (s == 0) s = "(null)";
    5f3a:	00002917          	auipc	s2,0x2
    5f3e:	76e90913          	addi	s2,s2,1902 # 86a8 <malloc+0x2628>
        while (*s != 0) {
    5f42:	02800593          	li	a1,40
    5f46:	bff1                	j	5f22 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    5f48:	008b0913          	addi	s2,s6,8
    5f4c:	000b4583          	lbu	a1,0(s6)
    5f50:	8556                	mv	a0,s5
    5f52:	00000097          	auipc	ra,0x0
    5f56:	d98080e7          	jalr	-616(ra) # 5cea <putc>
    5f5a:	8b4a                	mv	s6,s2
      state = 0;
    5f5c:	4981                	li	s3,0
    5f5e:	bd65                	j	5e16 <vprintf+0x60>
        putc(fd, c);
    5f60:	85d2                	mv	a1,s4
    5f62:	8556                	mv	a0,s5
    5f64:	00000097          	auipc	ra,0x0
    5f68:	d86080e7          	jalr	-634(ra) # 5cea <putc>
      state = 0;
    5f6c:	4981                	li	s3,0
    5f6e:	b565                	j	5e16 <vprintf+0x60>
        s = va_arg(ap, char *);
    5f70:	8b4e                	mv	s6,s3
      state = 0;
    5f72:	4981                	li	s3,0
    5f74:	b54d                	j	5e16 <vprintf+0x60>
    }
  }
}
    5f76:	70e6                	ld	ra,120(sp)
    5f78:	7446                	ld	s0,112(sp)
    5f7a:	74a6                	ld	s1,104(sp)
    5f7c:	7906                	ld	s2,96(sp)
    5f7e:	69e6                	ld	s3,88(sp)
    5f80:	6a46                	ld	s4,80(sp)
    5f82:	6aa6                	ld	s5,72(sp)
    5f84:	6b06                	ld	s6,64(sp)
    5f86:	7be2                	ld	s7,56(sp)
    5f88:	7c42                	ld	s8,48(sp)
    5f8a:	7ca2                	ld	s9,40(sp)
    5f8c:	7d02                	ld	s10,32(sp)
    5f8e:	6de2                	ld	s11,24(sp)
    5f90:	6109                	addi	sp,sp,128
    5f92:	8082                	ret

0000000000005f94 <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
    5f94:	715d                	addi	sp,sp,-80
    5f96:	ec06                	sd	ra,24(sp)
    5f98:	e822                	sd	s0,16(sp)
    5f9a:	1000                	addi	s0,sp,32
    5f9c:	e010                	sd	a2,0(s0)
    5f9e:	e414                	sd	a3,8(s0)
    5fa0:	e818                	sd	a4,16(s0)
    5fa2:	ec1c                	sd	a5,24(s0)
    5fa4:	03043023          	sd	a6,32(s0)
    5fa8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5fac:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5fb0:	8622                	mv	a2,s0
    5fb2:	00000097          	auipc	ra,0x0
    5fb6:	e04080e7          	jalr	-508(ra) # 5db6 <vprintf>
}
    5fba:	60e2                	ld	ra,24(sp)
    5fbc:	6442                	ld	s0,16(sp)
    5fbe:	6161                	addi	sp,sp,80
    5fc0:	8082                	ret

0000000000005fc2 <printf>:

void printf(const char *fmt, ...) {
    5fc2:	711d                	addi	sp,sp,-96
    5fc4:	ec06                	sd	ra,24(sp)
    5fc6:	e822                	sd	s0,16(sp)
    5fc8:	1000                	addi	s0,sp,32
    5fca:	e40c                	sd	a1,8(s0)
    5fcc:	e810                	sd	a2,16(s0)
    5fce:	ec14                	sd	a3,24(s0)
    5fd0:	f018                	sd	a4,32(s0)
    5fd2:	f41c                	sd	a5,40(s0)
    5fd4:	03043823          	sd	a6,48(s0)
    5fd8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5fdc:	00840613          	addi	a2,s0,8
    5fe0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5fe4:	85aa                	mv	a1,a0
    5fe6:	4505                	li	a0,1
    5fe8:	00000097          	auipc	ra,0x0
    5fec:	dce080e7          	jalr	-562(ra) # 5db6 <vprintf>
}
    5ff0:	60e2                	ld	ra,24(sp)
    5ff2:	6442                	ld	s0,16(sp)
    5ff4:	6125                	addi	sp,sp,96
    5ff6:	8082                	ret

0000000000005ff8 <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
    5ff8:	1141                	addi	sp,sp,-16
    5ffa:	e422                	sd	s0,8(sp)
    5ffc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
    5ffe:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    6002:	00003797          	auipc	a5,0x3
    6006:	44e7b783          	ld	a5,1102(a5) # 9450 <freep>
    600a:	a805                	j	603a <free+0x42>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
    600c:	4618                	lw	a4,8(a2)
    600e:	9db9                	addw	a1,a1,a4
    6010:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    6014:	6398                	ld	a4,0(a5)
    6016:	6318                	ld	a4,0(a4)
    6018:	fee53823          	sd	a4,-16(a0)
    601c:	a091                	j	6060 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
    601e:	ff852703          	lw	a4,-8(a0)
    6022:	9e39                	addw	a2,a2,a4
    6024:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    6026:	ff053703          	ld	a4,-16(a0)
    602a:	e398                	sd	a4,0(a5)
    602c:	a099                	j	6072 <free+0x7a>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
    602e:	6398                	ld	a4,0(a5)
    6030:	00e7e463          	bltu	a5,a4,6038 <free+0x40>
    6034:	00e6ea63          	bltu	a3,a4,6048 <free+0x50>
void free(void *ap) {
    6038:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    603a:	fed7fae3          	bgeu	a5,a3,602e <free+0x36>
    603e:	6398                	ld	a4,0(a5)
    6040:	00e6e463          	bltu	a3,a4,6048 <free+0x50>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr)) break;
    6044:	fee7eae3          	bltu	a5,a4,6038 <free+0x40>
  if (bp + bp->s.size == p->s.ptr) {
    6048:	ff852583          	lw	a1,-8(a0)
    604c:	6390                	ld	a2,0(a5)
    604e:	02059713          	slli	a4,a1,0x20
    6052:	9301                	srli	a4,a4,0x20
    6054:	0712                	slli	a4,a4,0x4
    6056:	9736                	add	a4,a4,a3
    6058:	fae60ae3          	beq	a2,a4,600c <free+0x14>
    bp->s.ptr = p->s.ptr;
    605c:	fec53823          	sd	a2,-16(a0)
  if (p + p->s.size == bp) {
    6060:	4790                	lw	a2,8(a5)
    6062:	02061713          	slli	a4,a2,0x20
    6066:	9301                	srli	a4,a4,0x20
    6068:	0712                	slli	a4,a4,0x4
    606a:	973e                	add	a4,a4,a5
    606c:	fae689e3          	beq	a3,a4,601e <free+0x26>
  } else
    p->s.ptr = bp;
    6070:	e394                	sd	a3,0(a5)
  freep = p;
    6072:	00003717          	auipc	a4,0x3
    6076:	3cf73f23          	sd	a5,990(a4) # 9450 <freep>
}
    607a:	6422                	ld	s0,8(sp)
    607c:	0141                	addi	sp,sp,16
    607e:	8082                	ret

0000000000006080 <malloc>:
  hp->s.size = nu;
  free((void *)(hp + 1));
  return freep;
}

void *malloc(uint nbytes) {
    6080:	7139                	addi	sp,sp,-64
    6082:	fc06                	sd	ra,56(sp)
    6084:	f822                	sd	s0,48(sp)
    6086:	f426                	sd	s1,40(sp)
    6088:	f04a                	sd	s2,32(sp)
    608a:	ec4e                	sd	s3,24(sp)
    608c:	e852                	sd	s4,16(sp)
    608e:	e456                	sd	s5,8(sp)
    6090:	e05a                	sd	s6,0(sp)
    6092:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    6094:	02051493          	slli	s1,a0,0x20
    6098:	9081                	srli	s1,s1,0x20
    609a:	04bd                	addi	s1,s1,15
    609c:	8091                	srli	s1,s1,0x4
    609e:	0014899b          	addiw	s3,s1,1
    60a2:	0485                	addi	s1,s1,1
  if ((prevp = freep) == 0) {
    60a4:	00003517          	auipc	a0,0x3
    60a8:	3ac53503          	ld	a0,940(a0) # 9450 <freep>
    60ac:	c515                	beqz	a0,60d8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    60ae:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    60b0:	4798                	lw	a4,8(a5)
    60b2:	02977f63          	bgeu	a4,s1,60f0 <malloc+0x70>
    60b6:	8a4e                	mv	s4,s3
    60b8:	0009871b          	sext.w	a4,s3
    60bc:	6685                	lui	a3,0x1
    60be:	00d77363          	bgeu	a4,a3,60c4 <malloc+0x44>
    60c2:	6a05                	lui	s4,0x1
    60c4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    60c8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
    60cc:	00003917          	auipc	s2,0x3
    60d0:	38490913          	addi	s2,s2,900 # 9450 <freep>
  if (p == (char *)-1) return 0;
    60d4:	5afd                	li	s5,-1
    60d6:	a88d                	j	6148 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    60d8:	0000a797          	auipc	a5,0xa
    60dc:	ba078793          	addi	a5,a5,-1120 # fc78 <base>
    60e0:	00003717          	auipc	a4,0x3
    60e4:	36f73823          	sd	a5,880(a4) # 9450 <freep>
    60e8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    60ea:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
    60ee:	b7e1                	j	60b6 <malloc+0x36>
      if (p->s.size == nunits)
    60f0:	02e48b63          	beq	s1,a4,6126 <malloc+0xa6>
        p->s.size -= nunits;
    60f4:	4137073b          	subw	a4,a4,s3
    60f8:	c798                	sw	a4,8(a5)
        p += p->s.size;
    60fa:	1702                	slli	a4,a4,0x20
    60fc:	9301                	srli	a4,a4,0x20
    60fe:	0712                	slli	a4,a4,0x4
    6100:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    6102:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    6106:	00003717          	auipc	a4,0x3
    610a:	34a73523          	sd	a0,842(a4) # 9450 <freep>
      return (void *)(p + 1);
    610e:	01078513          	addi	a0,a5,16
      if ((p = morecore(nunits)) == 0) return 0;
  }
}
    6112:	70e2                	ld	ra,56(sp)
    6114:	7442                	ld	s0,48(sp)
    6116:	74a2                	ld	s1,40(sp)
    6118:	7902                	ld	s2,32(sp)
    611a:	69e2                	ld	s3,24(sp)
    611c:	6a42                	ld	s4,16(sp)
    611e:	6aa2                	ld	s5,8(sp)
    6120:	6b02                	ld	s6,0(sp)
    6122:	6121                	addi	sp,sp,64
    6124:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    6126:	6398                	ld	a4,0(a5)
    6128:	e118                	sd	a4,0(a0)
    612a:	bff1                	j	6106 <malloc+0x86>
  hp->s.size = nu;
    612c:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
    6130:	0541                	addi	a0,a0,16
    6132:	00000097          	auipc	ra,0x0
    6136:	ec6080e7          	jalr	-314(ra) # 5ff8 <free>
  return freep;
    613a:	00093503          	ld	a0,0(s2)
      if ((p = morecore(nunits)) == 0) return 0;
    613e:	d971                	beqz	a0,6112 <malloc+0x92>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    6140:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    6142:	4798                	lw	a4,8(a5)
    6144:	fa9776e3          	bgeu	a4,s1,60f0 <malloc+0x70>
    if (p == freep)
    6148:	00093703          	ld	a4,0(s2)
    614c:	853e                	mv	a0,a5
    614e:	fef719e3          	bne	a4,a5,6140 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    6152:	8552                	mv	a0,s4
    6154:	00000097          	auipc	ra,0x0
    6158:	b7e080e7          	jalr	-1154(ra) # 5cd2 <sbrk>
  if (p == (char *)-1) return 0;
    615c:	fd5518e3          	bne	a0,s5,612c <malloc+0xac>
      if ((p = morecore(nunits)) == 0) return 0;
    6160:	4501                	li	a0,0
    6162:	bf45                	j	6112 <malloc+0x92>
