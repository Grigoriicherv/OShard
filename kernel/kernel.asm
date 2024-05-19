
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00019117          	auipc	sp,0x19
    80000004:	df010113          	addi	sp,sp,-528 # 80018df0 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	272060ef          	jal	ra,80006288 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kinit>:
#include "types.h"

extern char end[];  // first address after kernel.
                    // defined by kernel.ld.

void kinit() {
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e406                	sd	ra,8(sp)
    80000020:	e022                	sd	s0,0(sp)
    80000022:	0800                	addi	s0,sp,16
  char *p = (char *)PGROUNDUP((uint64)end);
  bd_init(p, (void *)PHYSTOP);
    80000024:	45c5                	li	a1,17
    80000026:	05ee                	slli	a1,a1,0x1b
    80000028:	00022517          	auipc	a0,0x22
    8000002c:	ec750513          	addi	a0,a0,-313 # 80021eef <end+0xfff>
    80000030:	77fd                	lui	a5,0xfffff
    80000032:	8d7d                	and	a0,a0,a5
    80000034:	00006097          	auipc	ra,0x6
    80000038:	ed2080e7          	jalr	-302(ra) # 80005f06 <bd_init>
}
    8000003c:	60a2                	ld	ra,8(sp)
    8000003e:	6402                	ld	s0,0(sp)
    80000040:	0141                	addi	sp,sp,16
    80000042:	8082                	ret

0000000080000044 <kfree>:

// Free the page of physical memory pointed at by pa,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void kfree(void *pa) { bd_free(pa); }
    80000044:	1141                	addi	sp,sp,-16
    80000046:	e406                	sd	ra,8(sp)
    80000048:	e022                	sd	s0,0(sp)
    8000004a:	0800                	addi	s0,sp,16
    8000004c:	00006097          	auipc	ra,0x6
    80000050:	9ec080e7          	jalr	-1556(ra) # 80005a38 <bd_free>
    80000054:	60a2                	ld	ra,8(sp)
    80000056:	6402                	ld	s0,0(sp)
    80000058:	0141                	addi	sp,sp,16
    8000005a:	8082                	ret

000000008000005c <kalloc>:

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *kalloc(void) { return bd_malloc(PGSIZE); }
    8000005c:	1141                	addi	sp,sp,-16
    8000005e:	e406                	sd	ra,8(sp)
    80000060:	e022                	sd	s0,0(sp)
    80000062:	0800                	addi	s0,sp,16
    80000064:	6505                	lui	a0,0x1
    80000066:	00005097          	auipc	ra,0x5
    8000006a:	7d4080e7          	jalr	2004(ra) # 8000583a <bd_malloc>
    8000006e:	60a2                	ld	ra,8(sp)
    80000070:	6402                	ld	s0,0(sp)
    80000072:	0141                	addi	sp,sp,16
    80000074:	8082                	ret

0000000080000076 <memset>:
#include "types.h"

void *memset(void *dst, int c, uint n) {
    80000076:	1141                	addi	sp,sp,-16
    80000078:	e422                	sd	s0,8(sp)
    8000007a:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
    8000007c:	ca19                	beqz	a2,80000092 <memset+0x1c>
    8000007e:	87aa                	mv	a5,a0
    80000080:	1602                	slli	a2,a2,0x20
    80000082:	9201                	srli	a2,a2,0x20
    80000084:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000088:	00b78023          	sb	a1,0(a5) # fffffffffffff000 <end+0xffffffff7ffde110>
  for (i = 0; i < n; i++) {
    8000008c:	0785                	addi	a5,a5,1
    8000008e:	fee79de3          	bne	a5,a4,80000088 <memset+0x12>
  }
  return dst;
}
    80000092:	6422                	ld	s0,8(sp)
    80000094:	0141                	addi	sp,sp,16
    80000096:	8082                	ret

0000000080000098 <memcmp>:

int memcmp(const void *v1, const void *v2, uint n) {
    80000098:	1141                	addi	sp,sp,-16
    8000009a:	e422                	sd	s0,8(sp)
    8000009c:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while (n-- > 0) {
    8000009e:	ca05                	beqz	a2,800000ce <memcmp+0x36>
    800000a0:	fff6069b          	addiw	a3,a2,-1
    800000a4:	1682                	slli	a3,a3,0x20
    800000a6:	9281                	srli	a3,a3,0x20
    800000a8:	0685                	addi	a3,a3,1
    800000aa:	96aa                	add	a3,a3,a0
    if (*s1 != *s2) return *s1 - *s2;
    800000ac:	00054783          	lbu	a5,0(a0) # 1000 <_entry-0x7ffff000>
    800000b0:	0005c703          	lbu	a4,0(a1)
    800000b4:	00e79863          	bne	a5,a4,800000c4 <memcmp+0x2c>
    s1++, s2++;
    800000b8:	0505                	addi	a0,a0,1
    800000ba:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    800000bc:	fed518e3          	bne	a0,a3,800000ac <memcmp+0x14>
  }

  return 0;
    800000c0:	4501                	li	a0,0
    800000c2:	a019                	j	800000c8 <memcmp+0x30>
    if (*s1 != *s2) return *s1 - *s2;
    800000c4:	40e7853b          	subw	a0,a5,a4
}
    800000c8:	6422                	ld	s0,8(sp)
    800000ca:	0141                	addi	sp,sp,16
    800000cc:	8082                	ret
  return 0;
    800000ce:	4501                	li	a0,0
    800000d0:	bfe5                	j	800000c8 <memcmp+0x30>

00000000800000d2 <memmove>:

void *memmove(void *dst, const void *src, uint n) {
    800000d2:	1141                	addi	sp,sp,-16
    800000d4:	e422                	sd	s0,8(sp)
    800000d6:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if (n == 0) return dst;
    800000d8:	c205                	beqz	a2,800000f8 <memmove+0x26>

  s = src;
  d = dst;
  if (s < d && s + n > d) {
    800000da:	02a5e263          	bltu	a1,a0,800000fe <memmove+0x2c>
    s += n;
    d += n;
    while (n-- > 0) *--d = *--s;
  } else
    while (n-- > 0) *d++ = *s++;
    800000de:	1602                	slli	a2,a2,0x20
    800000e0:	9201                	srli	a2,a2,0x20
    800000e2:	00c587b3          	add	a5,a1,a2
void *memmove(void *dst, const void *src, uint n) {
    800000e6:	872a                	mv	a4,a0
    while (n-- > 0) *d++ = *s++;
    800000e8:	0585                	addi	a1,a1,1
    800000ea:	0705                	addi	a4,a4,1
    800000ec:	fff5c683          	lbu	a3,-1(a1)
    800000f0:	fed70fa3          	sb	a3,-1(a4)
    800000f4:	fef59ae3          	bne	a1,a5,800000e8 <memmove+0x16>

  return dst;
}
    800000f8:	6422                	ld	s0,8(sp)
    800000fa:	0141                	addi	sp,sp,16
    800000fc:	8082                	ret
  if (s < d && s + n > d) {
    800000fe:	02061693          	slli	a3,a2,0x20
    80000102:	9281                	srli	a3,a3,0x20
    80000104:	00d58733          	add	a4,a1,a3
    80000108:	fce57be3          	bgeu	a0,a4,800000de <memmove+0xc>
    d += n;
    8000010c:	96aa                	add	a3,a3,a0
    while (n-- > 0) *--d = *--s;
    8000010e:	fff6079b          	addiw	a5,a2,-1
    80000112:	1782                	slli	a5,a5,0x20
    80000114:	9381                	srli	a5,a5,0x20
    80000116:	fff7c793          	not	a5,a5
    8000011a:	97ba                	add	a5,a5,a4
    8000011c:	177d                	addi	a4,a4,-1
    8000011e:	16fd                	addi	a3,a3,-1
    80000120:	00074603          	lbu	a2,0(a4)
    80000124:	00c68023          	sb	a2,0(a3)
    80000128:	fee79ae3          	bne	a5,a4,8000011c <memmove+0x4a>
    8000012c:	b7f1                	j	800000f8 <memmove+0x26>

000000008000012e <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void *memcpy(void *dst, const void *src, uint n) {
    8000012e:	1141                	addi	sp,sp,-16
    80000130:	e406                	sd	ra,8(sp)
    80000132:	e022                	sd	s0,0(sp)
    80000134:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000136:	00000097          	auipc	ra,0x0
    8000013a:	f9c080e7          	jalr	-100(ra) # 800000d2 <memmove>
}
    8000013e:	60a2                	ld	ra,8(sp)
    80000140:	6402                	ld	s0,0(sp)
    80000142:	0141                	addi	sp,sp,16
    80000144:	8082                	ret

0000000080000146 <strncmp>:

int strncmp(const char *p, const char *q, uint n) {
    80000146:	1141                	addi	sp,sp,-16
    80000148:	e422                	sd	s0,8(sp)
    8000014a:	0800                	addi	s0,sp,16
  while (n > 0 && *p && *p == *q) n--, p++, q++;
    8000014c:	ce11                	beqz	a2,80000168 <strncmp+0x22>
    8000014e:	00054783          	lbu	a5,0(a0)
    80000152:	cf89                	beqz	a5,8000016c <strncmp+0x26>
    80000154:	0005c703          	lbu	a4,0(a1)
    80000158:	00f71a63          	bne	a4,a5,8000016c <strncmp+0x26>
    8000015c:	367d                	addiw	a2,a2,-1
    8000015e:	0505                	addi	a0,a0,1
    80000160:	0585                	addi	a1,a1,1
    80000162:	f675                	bnez	a2,8000014e <strncmp+0x8>
  if (n == 0) return 0;
    80000164:	4501                	li	a0,0
    80000166:	a809                	j	80000178 <strncmp+0x32>
    80000168:	4501                	li	a0,0
    8000016a:	a039                	j	80000178 <strncmp+0x32>
    8000016c:	ca09                	beqz	a2,8000017e <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    8000016e:	00054503          	lbu	a0,0(a0)
    80000172:	0005c783          	lbu	a5,0(a1)
    80000176:	9d1d                	subw	a0,a0,a5
}
    80000178:	6422                	ld	s0,8(sp)
    8000017a:	0141                	addi	sp,sp,16
    8000017c:	8082                	ret
  if (n == 0) return 0;
    8000017e:	4501                	li	a0,0
    80000180:	bfe5                	j	80000178 <strncmp+0x32>

0000000080000182 <strncpy>:

char *strncpy(char *s, const char *t, int n) {
    80000182:	1141                	addi	sp,sp,-16
    80000184:	e422                	sd	s0,8(sp)
    80000186:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while (n-- > 0 && (*s++ = *t++) != 0)
    80000188:	872a                	mv	a4,a0
    8000018a:	8832                	mv	a6,a2
    8000018c:	367d                	addiw	a2,a2,-1
    8000018e:	01005963          	blez	a6,800001a0 <strncpy+0x1e>
    80000192:	0705                	addi	a4,a4,1
    80000194:	0005c783          	lbu	a5,0(a1)
    80000198:	fef70fa3          	sb	a5,-1(a4)
    8000019c:	0585                	addi	a1,a1,1
    8000019e:	f7f5                	bnez	a5,8000018a <strncpy+0x8>
    ;
  while (n-- > 0) *s++ = 0;
    800001a0:	86ba                	mv	a3,a4
    800001a2:	00c05c63          	blez	a2,800001ba <strncpy+0x38>
    800001a6:	0685                	addi	a3,a3,1
    800001a8:	fe068fa3          	sb	zero,-1(a3)
    800001ac:	fff6c793          	not	a5,a3
    800001b0:	9fb9                	addw	a5,a5,a4
    800001b2:	010787bb          	addw	a5,a5,a6
    800001b6:	fef048e3          	bgtz	a5,800001a6 <strncpy+0x24>
  return os;
}
    800001ba:	6422                	ld	s0,8(sp)
    800001bc:	0141                	addi	sp,sp,16
    800001be:	8082                	ret

00000000800001c0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char *safestrcpy(char *s, const char *t, int n) {
    800001c0:	1141                	addi	sp,sp,-16
    800001c2:	e422                	sd	s0,8(sp)
    800001c4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if (n <= 0) return os;
    800001c6:	02c05363          	blez	a2,800001ec <safestrcpy+0x2c>
    800001ca:	fff6069b          	addiw	a3,a2,-1
    800001ce:	1682                	slli	a3,a3,0x20
    800001d0:	9281                	srli	a3,a3,0x20
    800001d2:	96ae                	add	a3,a3,a1
    800001d4:	87aa                	mv	a5,a0
  while (--n > 0 && (*s++ = *t++) != 0)
    800001d6:	00d58963          	beq	a1,a3,800001e8 <safestrcpy+0x28>
    800001da:	0585                	addi	a1,a1,1
    800001dc:	0785                	addi	a5,a5,1
    800001de:	fff5c703          	lbu	a4,-1(a1)
    800001e2:	fee78fa3          	sb	a4,-1(a5)
    800001e6:	fb65                	bnez	a4,800001d6 <safestrcpy+0x16>
    ;
  *s = 0;
    800001e8:	00078023          	sb	zero,0(a5)
  return os;
}
    800001ec:	6422                	ld	s0,8(sp)
    800001ee:	0141                	addi	sp,sp,16
    800001f0:	8082                	ret

00000000800001f2 <strlen>:

int strlen(const char *s) {
    800001f2:	1141                	addi	sp,sp,-16
    800001f4:	e422                	sd	s0,8(sp)
    800001f6:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
    800001f8:	00054783          	lbu	a5,0(a0)
    800001fc:	cf91                	beqz	a5,80000218 <strlen+0x26>
    800001fe:	0505                	addi	a0,a0,1
    80000200:	87aa                	mv	a5,a0
    80000202:	4685                	li	a3,1
    80000204:	9e89                	subw	a3,a3,a0
    80000206:	00f6853b          	addw	a0,a3,a5
    8000020a:	0785                	addi	a5,a5,1
    8000020c:	fff7c703          	lbu	a4,-1(a5)
    80000210:	fb7d                	bnez	a4,80000206 <strlen+0x14>
    ;
  return n;
}
    80000212:	6422                	ld	s0,8(sp)
    80000214:	0141                	addi	sp,sp,16
    80000216:	8082                	ret
  for (n = 0; s[n]; n++)
    80000218:	4501                	li	a0,0
    8000021a:	bfe5                	j	80000212 <strlen+0x20>

000000008000021c <main>:
#include "defs.h"

volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void main() {
    8000021c:	1141                	addi	sp,sp,-16
    8000021e:	e406                	sd	ra,8(sp)
    80000220:	e022                	sd	s0,0(sp)
    80000222:	0800                	addi	s0,sp,16
  if (cpuid() == 0) {
    80000224:	00001097          	auipc	ra,0x1
    80000228:	b58080e7          	jalr	-1192(ra) # 80000d7c <cpuid>
    virtio_disk_init();  // emulated hard disk
    userinit();          // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while (started == 0)
    8000022c:	00008717          	auipc	a4,0x8
    80000230:	7c470713          	addi	a4,a4,1988 # 800089f0 <started>
  if (cpuid() == 0) {
    80000234:	c139                	beqz	a0,8000027a <main+0x5e>
    while (started == 0)
    80000236:	431c                	lw	a5,0(a4)
    80000238:	2781                	sext.w	a5,a5
    8000023a:	dff5                	beqz	a5,80000236 <main+0x1a>
      ;
    __sync_synchronize();
    8000023c:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000240:	00001097          	auipc	ra,0x1
    80000244:	b3c080e7          	jalr	-1220(ra) # 80000d7c <cpuid>
    80000248:	85aa                	mv	a1,a0
    8000024a:	00008517          	auipc	a0,0x8
    8000024e:	dde50513          	addi	a0,a0,-546 # 80008028 <etext+0x28>
    80000252:	00006097          	auipc	ra,0x6
    80000256:	530080e7          	jalr	1328(ra) # 80006782 <printf>
    kvminithart();   // turn on paging
    8000025a:	00000097          	auipc	ra,0x0
    8000025e:	0d8080e7          	jalr	216(ra) # 80000332 <kvminithart>
    trapinithart();  // install kernel trap vector
    80000262:	00001097          	auipc	ra,0x1
    80000266:	7e8080e7          	jalr	2024(ra) # 80001a4a <trapinithart>
    plicinithart();  // ask PLIC for device interrupts
    8000026a:	00005097          	auipc	ra,0x5
    8000026e:	d06080e7          	jalr	-762(ra) # 80004f70 <plicinithart>
  }

  scheduler();
    80000272:	00001097          	auipc	ra,0x1
    80000276:	030080e7          	jalr	48(ra) # 800012a2 <scheduler>
    consoleinit();
    8000027a:	00006097          	auipc	ra,0x6
    8000027e:	3d0080e7          	jalr	976(ra) # 8000664a <consoleinit>
    printfinit();
    80000282:	00006097          	auipc	ra,0x6
    80000286:	6e0080e7          	jalr	1760(ra) # 80006962 <printfinit>
    printf("\n");
    8000028a:	00008517          	auipc	a0,0x8
    8000028e:	dae50513          	addi	a0,a0,-594 # 80008038 <etext+0x38>
    80000292:	00006097          	auipc	ra,0x6
    80000296:	4f0080e7          	jalr	1264(ra) # 80006782 <printf>
    printf("xv6 kernel is booting\n");
    8000029a:	00008517          	auipc	a0,0x8
    8000029e:	d7650513          	addi	a0,a0,-650 # 80008010 <etext+0x10>
    800002a2:	00006097          	auipc	ra,0x6
    800002a6:	4e0080e7          	jalr	1248(ra) # 80006782 <printf>
    printf("\n");
    800002aa:	00008517          	auipc	a0,0x8
    800002ae:	d8e50513          	addi	a0,a0,-626 # 80008038 <etext+0x38>
    800002b2:	00006097          	auipc	ra,0x6
    800002b6:	4d0080e7          	jalr	1232(ra) # 80006782 <printf>
    kinit();             // physical page allocator
    800002ba:	00000097          	auipc	ra,0x0
    800002be:	d62080e7          	jalr	-670(ra) # 8000001c <kinit>
    kvminit();           // create kernel page table
    800002c2:	00000097          	auipc	ra,0x0
    800002c6:	34a080e7          	jalr	842(ra) # 8000060c <kvminit>
    kvminithart();       // turn on paging
    800002ca:	00000097          	auipc	ra,0x0
    800002ce:	068080e7          	jalr	104(ra) # 80000332 <kvminithart>
    procinit();          // process table
    800002d2:	00001097          	auipc	ra,0x1
    800002d6:	9f6080e7          	jalr	-1546(ra) # 80000cc8 <procinit>
    trapinit();          // trap vectors
    800002da:	00001097          	auipc	ra,0x1
    800002de:	748080e7          	jalr	1864(ra) # 80001a22 <trapinit>
    trapinithart();      // install kernel trap vector
    800002e2:	00001097          	auipc	ra,0x1
    800002e6:	768080e7          	jalr	1896(ra) # 80001a4a <trapinithart>
    plicinit();          // set up interrupt controller
    800002ea:	00005097          	auipc	ra,0x5
    800002ee:	c70080e7          	jalr	-912(ra) # 80004f5a <plicinit>
    plicinithart();      // ask PLIC for device interrupts
    800002f2:	00005097          	auipc	ra,0x5
    800002f6:	c7e080e7          	jalr	-898(ra) # 80004f70 <plicinithart>
    binit();             // buffer cache
    800002fa:	00002097          	auipc	ra,0x2
    800002fe:	e9a080e7          	jalr	-358(ra) # 80002194 <binit>
    iinit();             // inode table
    80000302:	00002097          	auipc	ra,0x2
    80000306:	53e080e7          	jalr	1342(ra) # 80002840 <iinit>
    fileinit();          // file table
    8000030a:	00003097          	auipc	ra,0x3
    8000030e:	4dc080e7          	jalr	1244(ra) # 800037e6 <fileinit>
    virtio_disk_init();  // emulated hard disk
    80000312:	00005097          	auipc	ra,0x5
    80000316:	d66080e7          	jalr	-666(ra) # 80005078 <virtio_disk_init>
    userinit();          // first user process
    8000031a:	00001097          	auipc	ra,0x1
    8000031e:	d6a080e7          	jalr	-662(ra) # 80001084 <userinit>
    __sync_synchronize();
    80000322:	0ff0000f          	fence
    started = 1;
    80000326:	4785                	li	a5,1
    80000328:	00008717          	auipc	a4,0x8
    8000032c:	6cf72423          	sw	a5,1736(a4) # 800089f0 <started>
    80000330:	b789                	j	80000272 <main+0x56>

0000000080000332 <kvminithart>:
// Initialize the one kernel_pagetable
void kvminit(void) { kernel_pagetable = kvmmake(); }

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void kvminithart() {
    80000332:	1141                	addi	sp,sp,-16
    80000334:	e422                	sd	s0,8(sp)
    80000336:	0800                	addi	s0,sp,16
}

// flush the TLB.
static inline void sfence_vma() {
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000338:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    8000033c:	00008797          	auipc	a5,0x8
    80000340:	6bc7b783          	ld	a5,1724(a5) # 800089f8 <kernel_pagetable>
    80000344:	83b1                	srli	a5,a5,0xc
    80000346:	577d                	li	a4,-1
    80000348:	177e                	slli	a4,a4,0x3f
    8000034a:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r"(x));
    8000034c:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    80000350:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80000354:	6422                	ld	s0,8(sp)
    80000356:	0141                	addi	sp,sp,16
    80000358:	8082                	ret

000000008000035a <walk>:
//   39..63 -- must be zero.
//   30..38 -- 9 bits of level-2 index.
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *walk(pagetable_t pagetable, uint64 va, int alloc) {
    8000035a:	7139                	addi	sp,sp,-64
    8000035c:	fc06                	sd	ra,56(sp)
    8000035e:	f822                	sd	s0,48(sp)
    80000360:	f426                	sd	s1,40(sp)
    80000362:	f04a                	sd	s2,32(sp)
    80000364:	ec4e                	sd	s3,24(sp)
    80000366:	e852                	sd	s4,16(sp)
    80000368:	e456                	sd	s5,8(sp)
    8000036a:	e05a                	sd	s6,0(sp)
    8000036c:	0080                	addi	s0,sp,64
    8000036e:	84aa                	mv	s1,a0
    80000370:	89ae                	mv	s3,a1
    80000372:	8ab2                	mv	s5,a2
  if (va >= MAXVA) panic("walk");
    80000374:	57fd                	li	a5,-1
    80000376:	83e9                	srli	a5,a5,0x1a
    80000378:	4a79                	li	s4,30

  for (int level = 2; level > 0; level--) {
    8000037a:	4b31                	li	s6,12
  if (va >= MAXVA) panic("walk");
    8000037c:	04b7f263          	bgeu	a5,a1,800003c0 <walk+0x66>
    80000380:	00008517          	auipc	a0,0x8
    80000384:	cc050513          	addi	a0,a0,-832 # 80008040 <etext+0x40>
    80000388:	00006097          	auipc	ra,0x6
    8000038c:	3b0080e7          	jalr	944(ra) # 80006738 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if (*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if (!alloc || (pagetable = (pde_t *)kalloc()) == 0) return 0;
    80000390:	060a8663          	beqz	s5,800003fc <walk+0xa2>
    80000394:	00000097          	auipc	ra,0x0
    80000398:	cc8080e7          	jalr	-824(ra) # 8000005c <kalloc>
    8000039c:	84aa                	mv	s1,a0
    8000039e:	c529                	beqz	a0,800003e8 <walk+0x8e>
      memset(pagetable, 0, PGSIZE);
    800003a0:	6605                	lui	a2,0x1
    800003a2:	4581                	li	a1,0
    800003a4:	00000097          	auipc	ra,0x0
    800003a8:	cd2080e7          	jalr	-814(ra) # 80000076 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800003ac:	00c4d793          	srli	a5,s1,0xc
    800003b0:	07aa                	slli	a5,a5,0xa
    800003b2:	0017e793          	ori	a5,a5,1
    800003b6:	00f93023          	sd	a5,0(s2)
  for (int level = 2; level > 0; level--) {
    800003ba:	3a5d                	addiw	s4,s4,-9
    800003bc:	036a0063          	beq	s4,s6,800003dc <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800003c0:	0149d933          	srl	s2,s3,s4
    800003c4:	1ff97913          	andi	s2,s2,511
    800003c8:	090e                	slli	s2,s2,0x3
    800003ca:	9926                	add	s2,s2,s1
    if (*pte & PTE_V) {
    800003cc:	00093483          	ld	s1,0(s2)
    800003d0:	0014f793          	andi	a5,s1,1
    800003d4:	dfd5                	beqz	a5,80000390 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800003d6:	80a9                	srli	s1,s1,0xa
    800003d8:	04b2                	slli	s1,s1,0xc
    800003da:	b7c5                	j	800003ba <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800003dc:	00c9d513          	srli	a0,s3,0xc
    800003e0:	1ff57513          	andi	a0,a0,511
    800003e4:	050e                	slli	a0,a0,0x3
    800003e6:	9526                	add	a0,a0,s1
}
    800003e8:	70e2                	ld	ra,56(sp)
    800003ea:	7442                	ld	s0,48(sp)
    800003ec:	74a2                	ld	s1,40(sp)
    800003ee:	7902                	ld	s2,32(sp)
    800003f0:	69e2                	ld	s3,24(sp)
    800003f2:	6a42                	ld	s4,16(sp)
    800003f4:	6aa2                	ld	s5,8(sp)
    800003f6:	6b02                	ld	s6,0(sp)
    800003f8:	6121                	addi	sp,sp,64
    800003fa:	8082                	ret
      if (!alloc || (pagetable = (pde_t *)kalloc()) == 0) return 0;
    800003fc:	4501                	li	a0,0
    800003fe:	b7ed                	j	800003e8 <walk+0x8e>

0000000080000400 <walkaddr>:
// Can only be used to look up user pages.
uint64 walkaddr(pagetable_t pagetable, uint64 va) {
  pte_t *pte;
  uint64 pa;

  if (va >= MAXVA) return 0;
    80000400:	57fd                	li	a5,-1
    80000402:	83e9                	srli	a5,a5,0x1a
    80000404:	00b7f463          	bgeu	a5,a1,8000040c <walkaddr+0xc>
    80000408:	4501                	li	a0,0
  if (pte == 0) return 0;
  if ((*pte & PTE_V) == 0) return 0;
  if ((*pte & PTE_U) == 0) return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    8000040a:	8082                	ret
uint64 walkaddr(pagetable_t pagetable, uint64 va) {
    8000040c:	1141                	addi	sp,sp,-16
    8000040e:	e406                	sd	ra,8(sp)
    80000410:	e022                	sd	s0,0(sp)
    80000412:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000414:	4601                	li	a2,0
    80000416:	00000097          	auipc	ra,0x0
    8000041a:	f44080e7          	jalr	-188(ra) # 8000035a <walk>
  if (pte == 0) return 0;
    8000041e:	c105                	beqz	a0,8000043e <walkaddr+0x3e>
  if ((*pte & PTE_V) == 0) return 0;
    80000420:	611c                	ld	a5,0(a0)
  if ((*pte & PTE_U) == 0) return 0;
    80000422:	0117f693          	andi	a3,a5,17
    80000426:	4745                	li	a4,17
    80000428:	4501                	li	a0,0
    8000042a:	00e68663          	beq	a3,a4,80000436 <walkaddr+0x36>
}
    8000042e:	60a2                	ld	ra,8(sp)
    80000430:	6402                	ld	s0,0(sp)
    80000432:	0141                	addi	sp,sp,16
    80000434:	8082                	ret
  pa = PTE2PA(*pte);
    80000436:	00a7d513          	srli	a0,a5,0xa
    8000043a:	0532                	slli	a0,a0,0xc
  return pa;
    8000043c:	bfcd                	j	8000042e <walkaddr+0x2e>
  if (pte == 0) return 0;
    8000043e:	4501                	li	a0,0
    80000440:	b7fd                	j	8000042e <walkaddr+0x2e>

0000000080000442 <mappages>:
// physical addresses starting at pa.
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa,
             int perm) {
    80000442:	715d                	addi	sp,sp,-80
    80000444:	e486                	sd	ra,72(sp)
    80000446:	e0a2                	sd	s0,64(sp)
    80000448:	fc26                	sd	s1,56(sp)
    8000044a:	f84a                	sd	s2,48(sp)
    8000044c:	f44e                	sd	s3,40(sp)
    8000044e:	f052                	sd	s4,32(sp)
    80000450:	ec56                	sd	s5,24(sp)
    80000452:	e85a                	sd	s6,16(sp)
    80000454:	e45e                	sd	s7,8(sp)
    80000456:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if ((va % PGSIZE) != 0) panic("mappages: va not aligned");
    80000458:	03459793          	slli	a5,a1,0x34
    8000045c:	e7b9                	bnez	a5,800004aa <mappages+0x68>
    8000045e:	8aaa                	mv	s5,a0
    80000460:	8b3a                	mv	s6,a4

  if ((size % PGSIZE) != 0) panic("mappages: size not aligned");
    80000462:	03461793          	slli	a5,a2,0x34
    80000466:	ebb1                	bnez	a5,800004ba <mappages+0x78>

  if (size == 0) panic("mappages: size");
    80000468:	c22d                	beqz	a2,800004ca <mappages+0x88>

  a = va;
  last = va + size - PGSIZE;
    8000046a:	79fd                	lui	s3,0xfffff
    8000046c:	964e                	add	a2,a2,s3
    8000046e:	00b609b3          	add	s3,a2,a1
  a = va;
    80000472:	892e                	mv	s2,a1
    80000474:	40b68a33          	sub	s4,a3,a1
  for (;;) {
    if ((pte = walk(pagetable, a, 1)) == 0) return -1;
    if (*pte & PTE_V) panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if (a == last) break;
    a += PGSIZE;
    80000478:	6b85                	lui	s7,0x1
    8000047a:	012a04b3          	add	s1,s4,s2
    if ((pte = walk(pagetable, a, 1)) == 0) return -1;
    8000047e:	4605                	li	a2,1
    80000480:	85ca                	mv	a1,s2
    80000482:	8556                	mv	a0,s5
    80000484:	00000097          	auipc	ra,0x0
    80000488:	ed6080e7          	jalr	-298(ra) # 8000035a <walk>
    8000048c:	cd39                	beqz	a0,800004ea <mappages+0xa8>
    if (*pte & PTE_V) panic("mappages: remap");
    8000048e:	611c                	ld	a5,0(a0)
    80000490:	8b85                	andi	a5,a5,1
    80000492:	e7a1                	bnez	a5,800004da <mappages+0x98>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80000494:	80b1                	srli	s1,s1,0xc
    80000496:	04aa                	slli	s1,s1,0xa
    80000498:	0164e4b3          	or	s1,s1,s6
    8000049c:	0014e493          	ori	s1,s1,1
    800004a0:	e104                	sd	s1,0(a0)
    if (a == last) break;
    800004a2:	07390063          	beq	s2,s3,80000502 <mappages+0xc0>
    a += PGSIZE;
    800004a6:	995e                	add	s2,s2,s7
    if ((pte = walk(pagetable, a, 1)) == 0) return -1;
    800004a8:	bfc9                	j	8000047a <mappages+0x38>
  if ((va % PGSIZE) != 0) panic("mappages: va not aligned");
    800004aa:	00008517          	auipc	a0,0x8
    800004ae:	b9e50513          	addi	a0,a0,-1122 # 80008048 <etext+0x48>
    800004b2:	00006097          	auipc	ra,0x6
    800004b6:	286080e7          	jalr	646(ra) # 80006738 <panic>
  if ((size % PGSIZE) != 0) panic("mappages: size not aligned");
    800004ba:	00008517          	auipc	a0,0x8
    800004be:	bae50513          	addi	a0,a0,-1106 # 80008068 <etext+0x68>
    800004c2:	00006097          	auipc	ra,0x6
    800004c6:	276080e7          	jalr	630(ra) # 80006738 <panic>
  if (size == 0) panic("mappages: size");
    800004ca:	00008517          	auipc	a0,0x8
    800004ce:	bbe50513          	addi	a0,a0,-1090 # 80008088 <etext+0x88>
    800004d2:	00006097          	auipc	ra,0x6
    800004d6:	266080e7          	jalr	614(ra) # 80006738 <panic>
    if (*pte & PTE_V) panic("mappages: remap");
    800004da:	00008517          	auipc	a0,0x8
    800004de:	bbe50513          	addi	a0,a0,-1090 # 80008098 <etext+0x98>
    800004e2:	00006097          	auipc	ra,0x6
    800004e6:	256080e7          	jalr	598(ra) # 80006738 <panic>
    if ((pte = walk(pagetable, a, 1)) == 0) return -1;
    800004ea:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    800004ec:	60a6                	ld	ra,72(sp)
    800004ee:	6406                	ld	s0,64(sp)
    800004f0:	74e2                	ld	s1,56(sp)
    800004f2:	7942                	ld	s2,48(sp)
    800004f4:	79a2                	ld	s3,40(sp)
    800004f6:	7a02                	ld	s4,32(sp)
    800004f8:	6ae2                	ld	s5,24(sp)
    800004fa:	6b42                	ld	s6,16(sp)
    800004fc:	6ba2                	ld	s7,8(sp)
    800004fe:	6161                	addi	sp,sp,80
    80000500:	8082                	ret
  return 0;
    80000502:	4501                	li	a0,0
    80000504:	b7e5                	j	800004ec <mappages+0xaa>

0000000080000506 <kvmmap>:
void kvmmap(pagetable_t kpgtbl, uint64 va, uint64 pa, uint64 sz, int perm) {
    80000506:	1141                	addi	sp,sp,-16
    80000508:	e406                	sd	ra,8(sp)
    8000050a:	e022                	sd	s0,0(sp)
    8000050c:	0800                	addi	s0,sp,16
    8000050e:	87b6                	mv	a5,a3
  if (mappages(kpgtbl, va, sz, pa, perm) != 0) panic("kvmmap");
    80000510:	86b2                	mv	a3,a2
    80000512:	863e                	mv	a2,a5
    80000514:	00000097          	auipc	ra,0x0
    80000518:	f2e080e7          	jalr	-210(ra) # 80000442 <mappages>
    8000051c:	e509                	bnez	a0,80000526 <kvmmap+0x20>
}
    8000051e:	60a2                	ld	ra,8(sp)
    80000520:	6402                	ld	s0,0(sp)
    80000522:	0141                	addi	sp,sp,16
    80000524:	8082                	ret
  if (mappages(kpgtbl, va, sz, pa, perm) != 0) panic("kvmmap");
    80000526:	00008517          	auipc	a0,0x8
    8000052a:	b8250513          	addi	a0,a0,-1150 # 800080a8 <etext+0xa8>
    8000052e:	00006097          	auipc	ra,0x6
    80000532:	20a080e7          	jalr	522(ra) # 80006738 <panic>

0000000080000536 <kvmmake>:
pagetable_t kvmmake(void) {
    80000536:	1101                	addi	sp,sp,-32
    80000538:	ec06                	sd	ra,24(sp)
    8000053a:	e822                	sd	s0,16(sp)
    8000053c:	e426                	sd	s1,8(sp)
    8000053e:	e04a                	sd	s2,0(sp)
    80000540:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t)kalloc();
    80000542:	00000097          	auipc	ra,0x0
    80000546:	b1a080e7          	jalr	-1254(ra) # 8000005c <kalloc>
    8000054a:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000054c:	6605                	lui	a2,0x1
    8000054e:	4581                	li	a1,0
    80000550:	00000097          	auipc	ra,0x0
    80000554:	b26080e7          	jalr	-1242(ra) # 80000076 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000558:	4719                	li	a4,6
    8000055a:	6685                	lui	a3,0x1
    8000055c:	10000637          	lui	a2,0x10000
    80000560:	100005b7          	lui	a1,0x10000
    80000564:	8526                	mv	a0,s1
    80000566:	00000097          	auipc	ra,0x0
    8000056a:	fa0080e7          	jalr	-96(ra) # 80000506 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000056e:	4719                	li	a4,6
    80000570:	6685                	lui	a3,0x1
    80000572:	10001637          	lui	a2,0x10001
    80000576:	100015b7          	lui	a1,0x10001
    8000057a:	8526                	mv	a0,s1
    8000057c:	00000097          	auipc	ra,0x0
    80000580:	f8a080e7          	jalr	-118(ra) # 80000506 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000584:	4719                	li	a4,6
    80000586:	004006b7          	lui	a3,0x400
    8000058a:	0c000637          	lui	a2,0xc000
    8000058e:	0c0005b7          	lui	a1,0xc000
    80000592:	8526                	mv	a0,s1
    80000594:	00000097          	auipc	ra,0x0
    80000598:	f72080e7          	jalr	-142(ra) # 80000506 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext - KERNBASE, PTE_R | PTE_X);
    8000059c:	00008917          	auipc	s2,0x8
    800005a0:	a6490913          	addi	s2,s2,-1436 # 80008000 <etext>
    800005a4:	4729                	li	a4,10
    800005a6:	80008697          	auipc	a3,0x80008
    800005aa:	a5a68693          	addi	a3,a3,-1446 # 8000 <_entry-0x7fff8000>
    800005ae:	4605                	li	a2,1
    800005b0:	067e                	slli	a2,a2,0x1f
    800005b2:	85b2                	mv	a1,a2
    800005b4:	8526                	mv	a0,s1
    800005b6:	00000097          	auipc	ra,0x0
    800005ba:	f50080e7          	jalr	-176(ra) # 80000506 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP - (uint64)etext,
    800005be:	4719                	li	a4,6
    800005c0:	46c5                	li	a3,17
    800005c2:	06ee                	slli	a3,a3,0x1b
    800005c4:	412686b3          	sub	a3,a3,s2
    800005c8:	864a                	mv	a2,s2
    800005ca:	85ca                	mv	a1,s2
    800005cc:	8526                	mv	a0,s1
    800005ce:	00000097          	auipc	ra,0x0
    800005d2:	f38080e7          	jalr	-200(ra) # 80000506 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800005d6:	4729                	li	a4,10
    800005d8:	6685                	lui	a3,0x1
    800005da:	00007617          	auipc	a2,0x7
    800005de:	a2660613          	addi	a2,a2,-1498 # 80007000 <_trampoline>
    800005e2:	040005b7          	lui	a1,0x4000
    800005e6:	15fd                	addi	a1,a1,-1
    800005e8:	05b2                	slli	a1,a1,0xc
    800005ea:	8526                	mv	a0,s1
    800005ec:	00000097          	auipc	ra,0x0
    800005f0:	f1a080e7          	jalr	-230(ra) # 80000506 <kvmmap>
  proc_mapstacks(kpgtbl);
    800005f4:	8526                	mv	a0,s1
    800005f6:	00000097          	auipc	ra,0x0
    800005fa:	63c080e7          	jalr	1596(ra) # 80000c32 <proc_mapstacks>
}
    800005fe:	8526                	mv	a0,s1
    80000600:	60e2                	ld	ra,24(sp)
    80000602:	6442                	ld	s0,16(sp)
    80000604:	64a2                	ld	s1,8(sp)
    80000606:	6902                	ld	s2,0(sp)
    80000608:	6105                	addi	sp,sp,32
    8000060a:	8082                	ret

000000008000060c <kvminit>:
void kvminit(void) { kernel_pagetable = kvmmake(); }
    8000060c:	1141                	addi	sp,sp,-16
    8000060e:	e406                	sd	ra,8(sp)
    80000610:	e022                	sd	s0,0(sp)
    80000612:	0800                	addi	s0,sp,16
    80000614:	00000097          	auipc	ra,0x0
    80000618:	f22080e7          	jalr	-222(ra) # 80000536 <kvmmake>
    8000061c:	00008797          	auipc	a5,0x8
    80000620:	3ca7be23          	sd	a0,988(a5) # 800089f8 <kernel_pagetable>
    80000624:	60a2                	ld	ra,8(sp)
    80000626:	6402                	ld	s0,0(sp)
    80000628:	0141                	addi	sp,sp,16
    8000062a:	8082                	ret

000000008000062c <uvmunmap>:

// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free) {
    8000062c:	715d                	addi	sp,sp,-80
    8000062e:	e486                	sd	ra,72(sp)
    80000630:	e0a2                	sd	s0,64(sp)
    80000632:	fc26                	sd	s1,56(sp)
    80000634:	f84a                	sd	s2,48(sp)
    80000636:	f44e                	sd	s3,40(sp)
    80000638:	f052                	sd	s4,32(sp)
    8000063a:	ec56                	sd	s5,24(sp)
    8000063c:	e85a                	sd	s6,16(sp)
    8000063e:	e45e                	sd	s7,8(sp)
    80000640:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if ((va % PGSIZE) != 0) panic("uvmunmap: not aligned");
    80000642:	03459793          	slli	a5,a1,0x34
    80000646:	e795                	bnez	a5,80000672 <uvmunmap+0x46>
    80000648:	8a2a                	mv	s4,a0
    8000064a:	892e                	mv	s2,a1
    8000064c:	8ab6                	mv	s5,a3

  for (a = va; a < va + npages * PGSIZE; a += PGSIZE) {
    8000064e:	0632                	slli	a2,a2,0xc
    80000650:	00b609b3          	add	s3,a2,a1
    if ((pte = walk(pagetable, a, 0)) == 0) panic("uvmunmap: walk");
    if ((*pte & PTE_V) == 0) panic("uvmunmap: not mapped");
    if (PTE_FLAGS(*pte) == PTE_V) panic("uvmunmap: not a leaf");
    80000654:	4b85                	li	s7,1
  for (a = va; a < va + npages * PGSIZE; a += PGSIZE) {
    80000656:	6b05                	lui	s6,0x1
    80000658:	0735e263          	bltu	a1,s3,800006bc <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void *)pa);
    }
    *pte = 0;
  }
}
    8000065c:	60a6                	ld	ra,72(sp)
    8000065e:	6406                	ld	s0,64(sp)
    80000660:	74e2                	ld	s1,56(sp)
    80000662:	7942                	ld	s2,48(sp)
    80000664:	79a2                	ld	s3,40(sp)
    80000666:	7a02                	ld	s4,32(sp)
    80000668:	6ae2                	ld	s5,24(sp)
    8000066a:	6b42                	ld	s6,16(sp)
    8000066c:	6ba2                	ld	s7,8(sp)
    8000066e:	6161                	addi	sp,sp,80
    80000670:	8082                	ret
  if ((va % PGSIZE) != 0) panic("uvmunmap: not aligned");
    80000672:	00008517          	auipc	a0,0x8
    80000676:	a3e50513          	addi	a0,a0,-1474 # 800080b0 <etext+0xb0>
    8000067a:	00006097          	auipc	ra,0x6
    8000067e:	0be080e7          	jalr	190(ra) # 80006738 <panic>
    if ((pte = walk(pagetable, a, 0)) == 0) panic("uvmunmap: walk");
    80000682:	00008517          	auipc	a0,0x8
    80000686:	a4650513          	addi	a0,a0,-1466 # 800080c8 <etext+0xc8>
    8000068a:	00006097          	auipc	ra,0x6
    8000068e:	0ae080e7          	jalr	174(ra) # 80006738 <panic>
    if ((*pte & PTE_V) == 0) panic("uvmunmap: not mapped");
    80000692:	00008517          	auipc	a0,0x8
    80000696:	a4650513          	addi	a0,a0,-1466 # 800080d8 <etext+0xd8>
    8000069a:	00006097          	auipc	ra,0x6
    8000069e:	09e080e7          	jalr	158(ra) # 80006738 <panic>
    if (PTE_FLAGS(*pte) == PTE_V) panic("uvmunmap: not a leaf");
    800006a2:	00008517          	auipc	a0,0x8
    800006a6:	a4e50513          	addi	a0,a0,-1458 # 800080f0 <etext+0xf0>
    800006aa:	00006097          	auipc	ra,0x6
    800006ae:	08e080e7          	jalr	142(ra) # 80006738 <panic>
    *pte = 0;
    800006b2:	0004b023          	sd	zero,0(s1)
  for (a = va; a < va + npages * PGSIZE; a += PGSIZE) {
    800006b6:	995a                	add	s2,s2,s6
    800006b8:	fb3972e3          	bgeu	s2,s3,8000065c <uvmunmap+0x30>
    if ((pte = walk(pagetable, a, 0)) == 0) panic("uvmunmap: walk");
    800006bc:	4601                	li	a2,0
    800006be:	85ca                	mv	a1,s2
    800006c0:	8552                	mv	a0,s4
    800006c2:	00000097          	auipc	ra,0x0
    800006c6:	c98080e7          	jalr	-872(ra) # 8000035a <walk>
    800006ca:	84aa                	mv	s1,a0
    800006cc:	d95d                	beqz	a0,80000682 <uvmunmap+0x56>
    if ((*pte & PTE_V) == 0) panic("uvmunmap: not mapped");
    800006ce:	6108                	ld	a0,0(a0)
    800006d0:	00157793          	andi	a5,a0,1
    800006d4:	dfdd                	beqz	a5,80000692 <uvmunmap+0x66>
    if (PTE_FLAGS(*pte) == PTE_V) panic("uvmunmap: not a leaf");
    800006d6:	3ff57793          	andi	a5,a0,1023
    800006da:	fd7784e3          	beq	a5,s7,800006a2 <uvmunmap+0x76>
    if (do_free) {
    800006de:	fc0a8ae3          	beqz	s5,800006b2 <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    800006e2:	8129                	srli	a0,a0,0xa
      kfree((void *)pa);
    800006e4:	0532                	slli	a0,a0,0xc
    800006e6:	00000097          	auipc	ra,0x0
    800006ea:	95e080e7          	jalr	-1698(ra) # 80000044 <kfree>
    800006ee:	b7d1                	j	800006b2 <uvmunmap+0x86>

00000000800006f0 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t uvmcreate() {
    800006f0:	1101                	addi	sp,sp,-32
    800006f2:	ec06                	sd	ra,24(sp)
    800006f4:	e822                	sd	s0,16(sp)
    800006f6:	e426                	sd	s1,8(sp)
    800006f8:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t)kalloc();
    800006fa:	00000097          	auipc	ra,0x0
    800006fe:	962080e7          	jalr	-1694(ra) # 8000005c <kalloc>
    80000702:	84aa                	mv	s1,a0
  if (pagetable == 0) return 0;
    80000704:	c519                	beqz	a0,80000712 <uvmcreate+0x22>
  memset(pagetable, 0, PGSIZE);
    80000706:	6605                	lui	a2,0x1
    80000708:	4581                	li	a1,0
    8000070a:	00000097          	auipc	ra,0x0
    8000070e:	96c080e7          	jalr	-1684(ra) # 80000076 <memset>
  return pagetable;
}
    80000712:	8526                	mv	a0,s1
    80000714:	60e2                	ld	ra,24(sp)
    80000716:	6442                	ld	s0,16(sp)
    80000718:	64a2                	ld	s1,8(sp)
    8000071a:	6105                	addi	sp,sp,32
    8000071c:	8082                	ret

000000008000071e <uvmfirst>:

// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void uvmfirst(pagetable_t pagetable, uchar *src, uint sz) {
    8000071e:	7179                	addi	sp,sp,-48
    80000720:	f406                	sd	ra,40(sp)
    80000722:	f022                	sd	s0,32(sp)
    80000724:	ec26                	sd	s1,24(sp)
    80000726:	e84a                	sd	s2,16(sp)
    80000728:	e44e                	sd	s3,8(sp)
    8000072a:	e052                	sd	s4,0(sp)
    8000072c:	1800                	addi	s0,sp,48
  char *mem;

  if (sz >= PGSIZE) panic("uvmfirst: more than a page");
    8000072e:	6785                	lui	a5,0x1
    80000730:	04f67863          	bgeu	a2,a5,80000780 <uvmfirst+0x62>
    80000734:	8a2a                	mv	s4,a0
    80000736:	89ae                	mv	s3,a1
    80000738:	84b2                	mv	s1,a2
  mem = kalloc();
    8000073a:	00000097          	auipc	ra,0x0
    8000073e:	922080e7          	jalr	-1758(ra) # 8000005c <kalloc>
    80000742:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000744:	6605                	lui	a2,0x1
    80000746:	4581                	li	a1,0
    80000748:	00000097          	auipc	ra,0x0
    8000074c:	92e080e7          	jalr	-1746(ra) # 80000076 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W | PTE_R | PTE_X | PTE_U);
    80000750:	4779                	li	a4,30
    80000752:	86ca                	mv	a3,s2
    80000754:	6605                	lui	a2,0x1
    80000756:	4581                	li	a1,0
    80000758:	8552                	mv	a0,s4
    8000075a:	00000097          	auipc	ra,0x0
    8000075e:	ce8080e7          	jalr	-792(ra) # 80000442 <mappages>
  memmove(mem, src, sz);
    80000762:	8626                	mv	a2,s1
    80000764:	85ce                	mv	a1,s3
    80000766:	854a                	mv	a0,s2
    80000768:	00000097          	auipc	ra,0x0
    8000076c:	96a080e7          	jalr	-1686(ra) # 800000d2 <memmove>
}
    80000770:	70a2                	ld	ra,40(sp)
    80000772:	7402                	ld	s0,32(sp)
    80000774:	64e2                	ld	s1,24(sp)
    80000776:	6942                	ld	s2,16(sp)
    80000778:	69a2                	ld	s3,8(sp)
    8000077a:	6a02                	ld	s4,0(sp)
    8000077c:	6145                	addi	sp,sp,48
    8000077e:	8082                	ret
  if (sz >= PGSIZE) panic("uvmfirst: more than a page");
    80000780:	00008517          	auipc	a0,0x8
    80000784:	98850513          	addi	a0,a0,-1656 # 80008108 <etext+0x108>
    80000788:	00006097          	auipc	ra,0x6
    8000078c:	fb0080e7          	jalr	-80(ra) # 80006738 <panic>

0000000080000790 <uvmdealloc>:

// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64 uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz) {
    80000790:	1101                	addi	sp,sp,-32
    80000792:	ec06                	sd	ra,24(sp)
    80000794:	e822                	sd	s0,16(sp)
    80000796:	e426                	sd	s1,8(sp)
    80000798:	1000                	addi	s0,sp,32
  if (newsz >= oldsz) return oldsz;
    8000079a:	84ae                	mv	s1,a1
    8000079c:	00b67d63          	bgeu	a2,a1,800007b6 <uvmdealloc+0x26>
    800007a0:	84b2                	mv	s1,a2

  if (PGROUNDUP(newsz) < PGROUNDUP(oldsz)) {
    800007a2:	6785                	lui	a5,0x1
    800007a4:	17fd                	addi	a5,a5,-1
    800007a6:	00f60733          	add	a4,a2,a5
    800007aa:	767d                	lui	a2,0xfffff
    800007ac:	8f71                	and	a4,a4,a2
    800007ae:	97ae                	add	a5,a5,a1
    800007b0:	8ff1                	and	a5,a5,a2
    800007b2:	00f76863          	bltu	a4,a5,800007c2 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800007b6:	8526                	mv	a0,s1
    800007b8:	60e2                	ld	ra,24(sp)
    800007ba:	6442                	ld	s0,16(sp)
    800007bc:	64a2                	ld	s1,8(sp)
    800007be:	6105                	addi	sp,sp,32
    800007c0:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800007c2:	8f99                	sub	a5,a5,a4
    800007c4:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800007c6:	4685                	li	a3,1
    800007c8:	0007861b          	sext.w	a2,a5
    800007cc:	85ba                	mv	a1,a4
    800007ce:	00000097          	auipc	ra,0x0
    800007d2:	e5e080e7          	jalr	-418(ra) # 8000062c <uvmunmap>
    800007d6:	b7c5                	j	800007b6 <uvmdealloc+0x26>

00000000800007d8 <uvmalloc>:
  if (newsz < oldsz) return oldsz;
    800007d8:	0ab66563          	bltu	a2,a1,80000882 <uvmalloc+0xaa>
uint64 uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz, int xperm) {
    800007dc:	7139                	addi	sp,sp,-64
    800007de:	fc06                	sd	ra,56(sp)
    800007e0:	f822                	sd	s0,48(sp)
    800007e2:	f426                	sd	s1,40(sp)
    800007e4:	f04a                	sd	s2,32(sp)
    800007e6:	ec4e                	sd	s3,24(sp)
    800007e8:	e852                	sd	s4,16(sp)
    800007ea:	e456                	sd	s5,8(sp)
    800007ec:	e05a                	sd	s6,0(sp)
    800007ee:	0080                	addi	s0,sp,64
    800007f0:	8aaa                	mv	s5,a0
    800007f2:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800007f4:	6985                	lui	s3,0x1
    800007f6:	19fd                	addi	s3,s3,-1
    800007f8:	95ce                	add	a1,a1,s3
    800007fa:	79fd                	lui	s3,0xfffff
    800007fc:	0135f9b3          	and	s3,a1,s3
  for (a = oldsz; a < newsz; a += PGSIZE) {
    80000800:	08c9f363          	bgeu	s3,a2,80000886 <uvmalloc+0xae>
    80000804:	894e                	mv	s2,s3
    if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R | PTE_U | xperm) !=
    80000806:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    8000080a:	00000097          	auipc	ra,0x0
    8000080e:	852080e7          	jalr	-1966(ra) # 8000005c <kalloc>
    80000812:	84aa                	mv	s1,a0
    if (mem == 0) {
    80000814:	c51d                	beqz	a0,80000842 <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    80000816:	6605                	lui	a2,0x1
    80000818:	4581                	li	a1,0
    8000081a:	00000097          	auipc	ra,0x0
    8000081e:	85c080e7          	jalr	-1956(ra) # 80000076 <memset>
    if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R | PTE_U | xperm) !=
    80000822:	875a                	mv	a4,s6
    80000824:	86a6                	mv	a3,s1
    80000826:	6605                	lui	a2,0x1
    80000828:	85ca                	mv	a1,s2
    8000082a:	8556                	mv	a0,s5
    8000082c:	00000097          	auipc	ra,0x0
    80000830:	c16080e7          	jalr	-1002(ra) # 80000442 <mappages>
    80000834:	e90d                	bnez	a0,80000866 <uvmalloc+0x8e>
  for (a = oldsz; a < newsz; a += PGSIZE) {
    80000836:	6785                	lui	a5,0x1
    80000838:	993e                	add	s2,s2,a5
    8000083a:	fd4968e3          	bltu	s2,s4,8000080a <uvmalloc+0x32>
  return newsz;
    8000083e:	8552                	mv	a0,s4
    80000840:	a809                	j	80000852 <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    80000842:	864e                	mv	a2,s3
    80000844:	85ca                	mv	a1,s2
    80000846:	8556                	mv	a0,s5
    80000848:	00000097          	auipc	ra,0x0
    8000084c:	f48080e7          	jalr	-184(ra) # 80000790 <uvmdealloc>
      return 0;
    80000850:	4501                	li	a0,0
}
    80000852:	70e2                	ld	ra,56(sp)
    80000854:	7442                	ld	s0,48(sp)
    80000856:	74a2                	ld	s1,40(sp)
    80000858:	7902                	ld	s2,32(sp)
    8000085a:	69e2                	ld	s3,24(sp)
    8000085c:	6a42                	ld	s4,16(sp)
    8000085e:	6aa2                	ld	s5,8(sp)
    80000860:	6b02                	ld	s6,0(sp)
    80000862:	6121                	addi	sp,sp,64
    80000864:	8082                	ret
      kfree(mem);
    80000866:	8526                	mv	a0,s1
    80000868:	fffff097          	auipc	ra,0xfffff
    8000086c:	7dc080e7          	jalr	2012(ra) # 80000044 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000870:	864e                	mv	a2,s3
    80000872:	85ca                	mv	a1,s2
    80000874:	8556                	mv	a0,s5
    80000876:	00000097          	auipc	ra,0x0
    8000087a:	f1a080e7          	jalr	-230(ra) # 80000790 <uvmdealloc>
      return 0;
    8000087e:	4501                	li	a0,0
    80000880:	bfc9                	j	80000852 <uvmalloc+0x7a>
  if (newsz < oldsz) return oldsz;
    80000882:	852e                	mv	a0,a1
}
    80000884:	8082                	ret
  return newsz;
    80000886:	8532                	mv	a0,a2
    80000888:	b7e9                	j	80000852 <uvmalloc+0x7a>

000000008000088a <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void freewalk(pagetable_t pagetable) {
    8000088a:	7179                	addi	sp,sp,-48
    8000088c:	f406                	sd	ra,40(sp)
    8000088e:	f022                	sd	s0,32(sp)
    80000890:	ec26                	sd	s1,24(sp)
    80000892:	e84a                	sd	s2,16(sp)
    80000894:	e44e                	sd	s3,8(sp)
    80000896:	e052                	sd	s4,0(sp)
    80000898:	1800                	addi	s0,sp,48
    8000089a:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for (int i = 0; i < 512; i++) {
    8000089c:	84aa                	mv	s1,a0
    8000089e:	6905                	lui	s2,0x1
    800008a0:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0) {
    800008a2:	4985                	li	s3,1
    800008a4:	a821                	j	800008bc <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800008a6:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    800008a8:	0532                	slli	a0,a0,0xc
    800008aa:	00000097          	auipc	ra,0x0
    800008ae:	fe0080e7          	jalr	-32(ra) # 8000088a <freewalk>
      pagetable[i] = 0;
    800008b2:	0004b023          	sd	zero,0(s1)
  for (int i = 0; i < 512; i++) {
    800008b6:	04a1                	addi	s1,s1,8
    800008b8:	03248163          	beq	s1,s2,800008da <freewalk+0x50>
    pte_t pte = pagetable[i];
    800008bc:	6088                	ld	a0,0(s1)
    if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0) {
    800008be:	00f57793          	andi	a5,a0,15
    800008c2:	ff3782e3          	beq	a5,s3,800008a6 <freewalk+0x1c>
    } else if (pte & PTE_V) {
    800008c6:	8905                	andi	a0,a0,1
    800008c8:	d57d                	beqz	a0,800008b6 <freewalk+0x2c>
      panic("freewalk: leaf");
    800008ca:	00008517          	auipc	a0,0x8
    800008ce:	85e50513          	addi	a0,a0,-1954 # 80008128 <etext+0x128>
    800008d2:	00006097          	auipc	ra,0x6
    800008d6:	e66080e7          	jalr	-410(ra) # 80006738 <panic>
    }
  }
  kfree((void *)pagetable);
    800008da:	8552                	mv	a0,s4
    800008dc:	fffff097          	auipc	ra,0xfffff
    800008e0:	768080e7          	jalr	1896(ra) # 80000044 <kfree>
}
    800008e4:	70a2                	ld	ra,40(sp)
    800008e6:	7402                	ld	s0,32(sp)
    800008e8:	64e2                	ld	s1,24(sp)
    800008ea:	6942                	ld	s2,16(sp)
    800008ec:	69a2                	ld	s3,8(sp)
    800008ee:	6a02                	ld	s4,0(sp)
    800008f0:	6145                	addi	sp,sp,48
    800008f2:	8082                	ret

00000000800008f4 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void uvmfree(pagetable_t pagetable, uint64 sz) {
    800008f4:	1101                	addi	sp,sp,-32
    800008f6:	ec06                	sd	ra,24(sp)
    800008f8:	e822                	sd	s0,16(sp)
    800008fa:	e426                	sd	s1,8(sp)
    800008fc:	1000                	addi	s0,sp,32
    800008fe:	84aa                	mv	s1,a0
  if (sz > 0) uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
    80000900:	e999                	bnez	a1,80000916 <uvmfree+0x22>
  freewalk(pagetable);
    80000902:	8526                	mv	a0,s1
    80000904:	00000097          	auipc	ra,0x0
    80000908:	f86080e7          	jalr	-122(ra) # 8000088a <freewalk>
}
    8000090c:	60e2                	ld	ra,24(sp)
    8000090e:	6442                	ld	s0,16(sp)
    80000910:	64a2                	ld	s1,8(sp)
    80000912:	6105                	addi	sp,sp,32
    80000914:	8082                	ret
  if (sz > 0) uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
    80000916:	6605                	lui	a2,0x1
    80000918:	167d                	addi	a2,a2,-1
    8000091a:	962e                	add	a2,a2,a1
    8000091c:	4685                	li	a3,1
    8000091e:	8231                	srli	a2,a2,0xc
    80000920:	4581                	li	a1,0
    80000922:	00000097          	auipc	ra,0x0
    80000926:	d0a080e7          	jalr	-758(ra) # 8000062c <uvmunmap>
    8000092a:	bfe1                	j	80000902 <uvmfree+0xe>

000000008000092c <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for (i = 0; i < sz; i += PGSIZE) {
    8000092c:	c679                	beqz	a2,800009fa <uvmcopy+0xce>
int uvmcopy(pagetable_t old, pagetable_t new, uint64 sz) {
    8000092e:	715d                	addi	sp,sp,-80
    80000930:	e486                	sd	ra,72(sp)
    80000932:	e0a2                	sd	s0,64(sp)
    80000934:	fc26                	sd	s1,56(sp)
    80000936:	f84a                	sd	s2,48(sp)
    80000938:	f44e                	sd	s3,40(sp)
    8000093a:	f052                	sd	s4,32(sp)
    8000093c:	ec56                	sd	s5,24(sp)
    8000093e:	e85a                	sd	s6,16(sp)
    80000940:	e45e                	sd	s7,8(sp)
    80000942:	0880                	addi	s0,sp,80
    80000944:	8b2a                	mv	s6,a0
    80000946:	8aae                	mv	s5,a1
    80000948:	8a32                	mv	s4,a2
  for (i = 0; i < sz; i += PGSIZE) {
    8000094a:	4981                	li	s3,0
    if ((pte = walk(old, i, 0)) == 0) panic("uvmcopy: pte should exist");
    8000094c:	4601                	li	a2,0
    8000094e:	85ce                	mv	a1,s3
    80000950:	855a                	mv	a0,s6
    80000952:	00000097          	auipc	ra,0x0
    80000956:	a08080e7          	jalr	-1528(ra) # 8000035a <walk>
    8000095a:	c531                	beqz	a0,800009a6 <uvmcopy+0x7a>
    if ((*pte & PTE_V) == 0) panic("uvmcopy: page not present");
    8000095c:	6118                	ld	a4,0(a0)
    8000095e:	00177793          	andi	a5,a4,1
    80000962:	cbb1                	beqz	a5,800009b6 <uvmcopy+0x8a>
    pa = PTE2PA(*pte);
    80000964:	00a75593          	srli	a1,a4,0xa
    80000968:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    8000096c:	3ff77493          	andi	s1,a4,1023
    if ((mem = kalloc()) == 0) goto err;
    80000970:	fffff097          	auipc	ra,0xfffff
    80000974:	6ec080e7          	jalr	1772(ra) # 8000005c <kalloc>
    80000978:	892a                	mv	s2,a0
    8000097a:	c939                	beqz	a0,800009d0 <uvmcopy+0xa4>
    memmove(mem, (char *)pa, PGSIZE);
    8000097c:	6605                	lui	a2,0x1
    8000097e:	85de                	mv	a1,s7
    80000980:	fffff097          	auipc	ra,0xfffff
    80000984:	752080e7          	jalr	1874(ra) # 800000d2 <memmove>
    if (mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) {
    80000988:	8726                	mv	a4,s1
    8000098a:	86ca                	mv	a3,s2
    8000098c:	6605                	lui	a2,0x1
    8000098e:	85ce                	mv	a1,s3
    80000990:	8556                	mv	a0,s5
    80000992:	00000097          	auipc	ra,0x0
    80000996:	ab0080e7          	jalr	-1360(ra) # 80000442 <mappages>
    8000099a:	e515                	bnez	a0,800009c6 <uvmcopy+0x9a>
  for (i = 0; i < sz; i += PGSIZE) {
    8000099c:	6785                	lui	a5,0x1
    8000099e:	99be                	add	s3,s3,a5
    800009a0:	fb49e6e3          	bltu	s3,s4,8000094c <uvmcopy+0x20>
    800009a4:	a081                	j	800009e4 <uvmcopy+0xb8>
    if ((pte = walk(old, i, 0)) == 0) panic("uvmcopy: pte should exist");
    800009a6:	00007517          	auipc	a0,0x7
    800009aa:	79250513          	addi	a0,a0,1938 # 80008138 <etext+0x138>
    800009ae:	00006097          	auipc	ra,0x6
    800009b2:	d8a080e7          	jalr	-630(ra) # 80006738 <panic>
    if ((*pte & PTE_V) == 0) panic("uvmcopy: page not present");
    800009b6:	00007517          	auipc	a0,0x7
    800009ba:	7a250513          	addi	a0,a0,1954 # 80008158 <etext+0x158>
    800009be:	00006097          	auipc	ra,0x6
    800009c2:	d7a080e7          	jalr	-646(ra) # 80006738 <panic>
      kfree(mem);
    800009c6:	854a                	mv	a0,s2
    800009c8:	fffff097          	auipc	ra,0xfffff
    800009cc:	67c080e7          	jalr	1660(ra) # 80000044 <kfree>
    }
  }
  return 0;

err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800009d0:	4685                	li	a3,1
    800009d2:	00c9d613          	srli	a2,s3,0xc
    800009d6:	4581                	li	a1,0
    800009d8:	8556                	mv	a0,s5
    800009da:	00000097          	auipc	ra,0x0
    800009de:	c52080e7          	jalr	-942(ra) # 8000062c <uvmunmap>
  return -1;
    800009e2:	557d                	li	a0,-1
}
    800009e4:	60a6                	ld	ra,72(sp)
    800009e6:	6406                	ld	s0,64(sp)
    800009e8:	74e2                	ld	s1,56(sp)
    800009ea:	7942                	ld	s2,48(sp)
    800009ec:	79a2                	ld	s3,40(sp)
    800009ee:	7a02                	ld	s4,32(sp)
    800009f0:	6ae2                	ld	s5,24(sp)
    800009f2:	6b42                	ld	s6,16(sp)
    800009f4:	6ba2                	ld	s7,8(sp)
    800009f6:	6161                	addi	sp,sp,80
    800009f8:	8082                	ret
  return 0;
    800009fa:	4501                	li	a0,0
}
    800009fc:	8082                	ret

00000000800009fe <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void uvmclear(pagetable_t pagetable, uint64 va) {
    800009fe:	1141                	addi	sp,sp,-16
    80000a00:	e406                	sd	ra,8(sp)
    80000a02:	e022                	sd	s0,0(sp)
    80000a04:	0800                	addi	s0,sp,16
  pte_t *pte;

  pte = walk(pagetable, va, 0);
    80000a06:	4601                	li	a2,0
    80000a08:	00000097          	auipc	ra,0x0
    80000a0c:	952080e7          	jalr	-1710(ra) # 8000035a <walk>
  if (pte == 0) panic("uvmclear");
    80000a10:	c901                	beqz	a0,80000a20 <uvmclear+0x22>
  *pte &= ~PTE_U;
    80000a12:	611c                	ld	a5,0(a0)
    80000a14:	9bbd                	andi	a5,a5,-17
    80000a16:	e11c                	sd	a5,0(a0)
}
    80000a18:	60a2                	ld	ra,8(sp)
    80000a1a:	6402                	ld	s0,0(sp)
    80000a1c:	0141                	addi	sp,sp,16
    80000a1e:	8082                	ret
  if (pte == 0) panic("uvmclear");
    80000a20:	00007517          	auipc	a0,0x7
    80000a24:	75850513          	addi	a0,a0,1880 # 80008178 <etext+0x178>
    80000a28:	00006097          	auipc	ra,0x6
    80000a2c:	d10080e7          	jalr	-752(ra) # 80006738 <panic>

0000000080000a30 <copyout>:
// Return 0 on success, -1 on error.
int copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len) {
  uint64 n, va0, pa0;
  pte_t *pte;

  while (len > 0) {
    80000a30:	cac9                	beqz	a3,80000ac2 <copyout+0x92>
int copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len) {
    80000a32:	711d                	addi	sp,sp,-96
    80000a34:	ec86                	sd	ra,88(sp)
    80000a36:	e8a2                	sd	s0,80(sp)
    80000a38:	e4a6                	sd	s1,72(sp)
    80000a3a:	e0ca                	sd	s2,64(sp)
    80000a3c:	fc4e                	sd	s3,56(sp)
    80000a3e:	f852                	sd	s4,48(sp)
    80000a40:	f456                	sd	s5,40(sp)
    80000a42:	f05a                	sd	s6,32(sp)
    80000a44:	ec5e                	sd	s7,24(sp)
    80000a46:	e862                	sd	s8,16(sp)
    80000a48:	e466                	sd	s9,8(sp)
    80000a4a:	e06a                	sd	s10,0(sp)
    80000a4c:	1080                	addi	s0,sp,96
    80000a4e:	8baa                	mv	s7,a0
    80000a50:	8aae                	mv	s5,a1
    80000a52:	8b32                	mv	s6,a2
    80000a54:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000a56:	74fd                	lui	s1,0xfffff
    80000a58:	8ced                	and	s1,s1,a1
    if (va0 >= MAXVA) return -1;
    80000a5a:	57fd                	li	a5,-1
    80000a5c:	83e9                	srli	a5,a5,0x1a
    80000a5e:	0697e463          	bltu	a5,s1,80000ac6 <copyout+0x96>
    pte = walk(pagetable, va0, 0);
    if (pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80000a62:	4cd5                	li	s9,21
    80000a64:	6d05                	lui	s10,0x1
    if (va0 >= MAXVA) return -1;
    80000a66:	8c3e                	mv	s8,a5
    80000a68:	a035                	j	80000a94 <copyout+0x64>
        (*pte & PTE_W) == 0)
      return -1;
    pa0 = PTE2PA(*pte);
    80000a6a:	83a9                	srli	a5,a5,0xa
    80000a6c:	07b2                	slli	a5,a5,0xc
    n = PGSIZE - (dstva - va0);
    if (n > len) n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000a6e:	409a8533          	sub	a0,s5,s1
    80000a72:	0009061b          	sext.w	a2,s2
    80000a76:	85da                	mv	a1,s6
    80000a78:	953e                	add	a0,a0,a5
    80000a7a:	fffff097          	auipc	ra,0xfffff
    80000a7e:	658080e7          	jalr	1624(ra) # 800000d2 <memmove>

    len -= n;
    80000a82:	412989b3          	sub	s3,s3,s2
    src += n;
    80000a86:	9b4a                	add	s6,s6,s2
  while (len > 0) {
    80000a88:	02098b63          	beqz	s3,80000abe <copyout+0x8e>
    if (va0 >= MAXVA) return -1;
    80000a8c:	034c6f63          	bltu	s8,s4,80000aca <copyout+0x9a>
    va0 = PGROUNDDOWN(dstva);
    80000a90:	84d2                	mv	s1,s4
    dstva = va0 + PGSIZE;
    80000a92:	8ad2                	mv	s5,s4
    pte = walk(pagetable, va0, 0);
    80000a94:	4601                	li	a2,0
    80000a96:	85a6                	mv	a1,s1
    80000a98:	855e                	mv	a0,s7
    80000a9a:	00000097          	auipc	ra,0x0
    80000a9e:	8c0080e7          	jalr	-1856(ra) # 8000035a <walk>
    if (pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80000aa2:	c515                	beqz	a0,80000ace <copyout+0x9e>
    80000aa4:	611c                	ld	a5,0(a0)
    80000aa6:	0157f713          	andi	a4,a5,21
    80000aaa:	05971163          	bne	a4,s9,80000aec <copyout+0xbc>
    n = PGSIZE - (dstva - va0);
    80000aae:	01a48a33          	add	s4,s1,s10
    80000ab2:	415a0933          	sub	s2,s4,s5
    if (n > len) n = len;
    80000ab6:	fb29fae3          	bgeu	s3,s2,80000a6a <copyout+0x3a>
    80000aba:	894e                	mv	s2,s3
    80000abc:	b77d                	j	80000a6a <copyout+0x3a>
  }
  return 0;
    80000abe:	4501                	li	a0,0
    80000ac0:	a801                	j	80000ad0 <copyout+0xa0>
    80000ac2:	4501                	li	a0,0
}
    80000ac4:	8082                	ret
    if (va0 >= MAXVA) return -1;
    80000ac6:	557d                	li	a0,-1
    80000ac8:	a021                	j	80000ad0 <copyout+0xa0>
    80000aca:	557d                	li	a0,-1
    80000acc:	a011                	j	80000ad0 <copyout+0xa0>
      return -1;
    80000ace:	557d                	li	a0,-1
}
    80000ad0:	60e6                	ld	ra,88(sp)
    80000ad2:	6446                	ld	s0,80(sp)
    80000ad4:	64a6                	ld	s1,72(sp)
    80000ad6:	6906                	ld	s2,64(sp)
    80000ad8:	79e2                	ld	s3,56(sp)
    80000ada:	7a42                	ld	s4,48(sp)
    80000adc:	7aa2                	ld	s5,40(sp)
    80000ade:	7b02                	ld	s6,32(sp)
    80000ae0:	6be2                	ld	s7,24(sp)
    80000ae2:	6c42                	ld	s8,16(sp)
    80000ae4:	6ca2                	ld	s9,8(sp)
    80000ae6:	6d02                	ld	s10,0(sp)
    80000ae8:	6125                	addi	sp,sp,96
    80000aea:	8082                	ret
      return -1;
    80000aec:	557d                	li	a0,-1
    80000aee:	b7cd                	j	80000ad0 <copyout+0xa0>

0000000080000af0 <copyin>:
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len) {
  uint64 n, va0, pa0;

  while (len > 0) {
    80000af0:	caa5                	beqz	a3,80000b60 <copyin+0x70>
int copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len) {
    80000af2:	715d                	addi	sp,sp,-80
    80000af4:	e486                	sd	ra,72(sp)
    80000af6:	e0a2                	sd	s0,64(sp)
    80000af8:	fc26                	sd	s1,56(sp)
    80000afa:	f84a                	sd	s2,48(sp)
    80000afc:	f44e                	sd	s3,40(sp)
    80000afe:	f052                	sd	s4,32(sp)
    80000b00:	ec56                	sd	s5,24(sp)
    80000b02:	e85a                	sd	s6,16(sp)
    80000b04:	e45e                	sd	s7,8(sp)
    80000b06:	e062                	sd	s8,0(sp)
    80000b08:	0880                	addi	s0,sp,80
    80000b0a:	8b2a                	mv	s6,a0
    80000b0c:	8a2e                	mv	s4,a1
    80000b0e:	8c32                	mv	s8,a2
    80000b10:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000b12:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if (pa0 == 0) return -1;
    n = PGSIZE - (srcva - va0);
    80000b14:	6a85                	lui	s5,0x1
    80000b16:	a01d                	j	80000b3c <copyin+0x4c>
    if (n > len) n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000b18:	018505b3          	add	a1,a0,s8
    80000b1c:	0004861b          	sext.w	a2,s1
    80000b20:	412585b3          	sub	a1,a1,s2
    80000b24:	8552                	mv	a0,s4
    80000b26:	fffff097          	auipc	ra,0xfffff
    80000b2a:	5ac080e7          	jalr	1452(ra) # 800000d2 <memmove>

    len -= n;
    80000b2e:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000b32:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000b34:	01590c33          	add	s8,s2,s5
  while (len > 0) {
    80000b38:	02098263          	beqz	s3,80000b5c <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000b3c:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b40:	85ca                	mv	a1,s2
    80000b42:	855a                	mv	a0,s6
    80000b44:	00000097          	auipc	ra,0x0
    80000b48:	8bc080e7          	jalr	-1860(ra) # 80000400 <walkaddr>
    if (pa0 == 0) return -1;
    80000b4c:	cd01                	beqz	a0,80000b64 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000b4e:	418904b3          	sub	s1,s2,s8
    80000b52:	94d6                	add	s1,s1,s5
    if (n > len) n = len;
    80000b54:	fc99f2e3          	bgeu	s3,s1,80000b18 <copyin+0x28>
    80000b58:	84ce                	mv	s1,s3
    80000b5a:	bf7d                	j	80000b18 <copyin+0x28>
  }
  return 0;
    80000b5c:	4501                	li	a0,0
    80000b5e:	a021                	j	80000b66 <copyin+0x76>
    80000b60:	4501                	li	a0,0
}
    80000b62:	8082                	ret
    if (pa0 == 0) return -1;
    80000b64:	557d                	li	a0,-1
}
    80000b66:	60a6                	ld	ra,72(sp)
    80000b68:	6406                	ld	s0,64(sp)
    80000b6a:	74e2                	ld	s1,56(sp)
    80000b6c:	7942                	ld	s2,48(sp)
    80000b6e:	79a2                	ld	s3,40(sp)
    80000b70:	7a02                	ld	s4,32(sp)
    80000b72:	6ae2                	ld	s5,24(sp)
    80000b74:	6b42                	ld	s6,16(sp)
    80000b76:	6ba2                	ld	s7,8(sp)
    80000b78:	6c02                	ld	s8,0(sp)
    80000b7a:	6161                	addi	sp,sp,80
    80000b7c:	8082                	ret

0000000080000b7e <copyinstr>:
// Return 0 on success, -1 on error.
int copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max) {
  uint64 n, va0, pa0;
  int got_null = 0;

  while (got_null == 0 && max > 0) {
    80000b7e:	c6c5                	beqz	a3,80000c26 <copyinstr+0xa8>
int copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max) {
    80000b80:	715d                	addi	sp,sp,-80
    80000b82:	e486                	sd	ra,72(sp)
    80000b84:	e0a2                	sd	s0,64(sp)
    80000b86:	fc26                	sd	s1,56(sp)
    80000b88:	f84a                	sd	s2,48(sp)
    80000b8a:	f44e                	sd	s3,40(sp)
    80000b8c:	f052                	sd	s4,32(sp)
    80000b8e:	ec56                	sd	s5,24(sp)
    80000b90:	e85a                	sd	s6,16(sp)
    80000b92:	e45e                	sd	s7,8(sp)
    80000b94:	0880                	addi	s0,sp,80
    80000b96:	8a2a                	mv	s4,a0
    80000b98:	8b2e                	mv	s6,a1
    80000b9a:	8bb2                	mv	s7,a2
    80000b9c:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000b9e:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if (pa0 == 0) return -1;
    n = PGSIZE - (srcva - va0);
    80000ba0:	6985                	lui	s3,0x1
    80000ba2:	a035                	j	80000bce <copyinstr+0x50>
    if (n > max) n = max;

    char *p = (char *)(pa0 + (srcva - va0));
    while (n > 0) {
      if (*p == '\0') {
        *dst = '\0';
    80000ba4:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000ba8:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if (got_null) {
    80000baa:	0017b793          	seqz	a5,a5
    80000bae:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000bb2:	60a6                	ld	ra,72(sp)
    80000bb4:	6406                	ld	s0,64(sp)
    80000bb6:	74e2                	ld	s1,56(sp)
    80000bb8:	7942                	ld	s2,48(sp)
    80000bba:	79a2                	ld	s3,40(sp)
    80000bbc:	7a02                	ld	s4,32(sp)
    80000bbe:	6ae2                	ld	s5,24(sp)
    80000bc0:	6b42                	ld	s6,16(sp)
    80000bc2:	6ba2                	ld	s7,8(sp)
    80000bc4:	6161                	addi	sp,sp,80
    80000bc6:	8082                	ret
    srcva = va0 + PGSIZE;
    80000bc8:	01390bb3          	add	s7,s2,s3
  while (got_null == 0 && max > 0) {
    80000bcc:	c8a9                	beqz	s1,80000c1e <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80000bce:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000bd2:	85ca                	mv	a1,s2
    80000bd4:	8552                	mv	a0,s4
    80000bd6:	00000097          	auipc	ra,0x0
    80000bda:	82a080e7          	jalr	-2006(ra) # 80000400 <walkaddr>
    if (pa0 == 0) return -1;
    80000bde:	c131                	beqz	a0,80000c22 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000be0:	41790833          	sub	a6,s2,s7
    80000be4:	984e                	add	a6,a6,s3
    if (n > max) n = max;
    80000be6:	0104f363          	bgeu	s1,a6,80000bec <copyinstr+0x6e>
    80000bea:	8826                	mv	a6,s1
    char *p = (char *)(pa0 + (srcva - va0));
    80000bec:	955e                	add	a0,a0,s7
    80000bee:	41250533          	sub	a0,a0,s2
    while (n > 0) {
    80000bf2:	fc080be3          	beqz	a6,80000bc8 <copyinstr+0x4a>
    80000bf6:	985a                	add	a6,a6,s6
    80000bf8:	87da                	mv	a5,s6
      if (*p == '\0') {
    80000bfa:	41650633          	sub	a2,a0,s6
    80000bfe:	14fd                	addi	s1,s1,-1
    80000c00:	9b26                	add	s6,s6,s1
    80000c02:	00f60733          	add	a4,a2,a5
    80000c06:	00074703          	lbu	a4,0(a4)
    80000c0a:	df49                	beqz	a4,80000ba4 <copyinstr+0x26>
        *dst = *p;
    80000c0c:	00e78023          	sb	a4,0(a5)
      --max;
    80000c10:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80000c14:	0785                	addi	a5,a5,1
    while (n > 0) {
    80000c16:	ff0796e3          	bne	a5,a6,80000c02 <copyinstr+0x84>
      dst++;
    80000c1a:	8b42                	mv	s6,a6
    80000c1c:	b775                	j	80000bc8 <copyinstr+0x4a>
    80000c1e:	4781                	li	a5,0
    80000c20:	b769                	j	80000baa <copyinstr+0x2c>
    if (pa0 == 0) return -1;
    80000c22:	557d                	li	a0,-1
    80000c24:	b779                	j	80000bb2 <copyinstr+0x34>
  int got_null = 0;
    80000c26:	4781                	li	a5,0
  if (got_null) {
    80000c28:	0017b793          	seqz	a5,a5
    80000c2c:	40f00533          	neg	a0,a5
}
    80000c30:	8082                	ret

0000000080000c32 <proc_mapstacks>:
struct spinlock wait_lock;

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void proc_mapstacks(pagetable_t kpgtbl) {
    80000c32:	7139                	addi	sp,sp,-64
    80000c34:	fc06                	sd	ra,56(sp)
    80000c36:	f822                	sd	s0,48(sp)
    80000c38:	f426                	sd	s1,40(sp)
    80000c3a:	f04a                	sd	s2,32(sp)
    80000c3c:	ec4e                	sd	s3,24(sp)
    80000c3e:	e852                	sd	s4,16(sp)
    80000c40:	e456                	sd	s5,8(sp)
    80000c42:	e05a                	sd	s6,0(sp)
    80000c44:	0080                	addi	s0,sp,64
    80000c46:	89aa                	mv	s3,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++) {
    80000c48:	00008497          	auipc	s1,0x8
    80000c4c:	22848493          	addi	s1,s1,552 # 80008e70 <proc>
    char *pa = kalloc();
    if (pa == 0) panic("kalloc");
    uint64 va = KSTACK((int)(p - proc));
    80000c50:	8b26                	mv	s6,s1
    80000c52:	00007a97          	auipc	s5,0x7
    80000c56:	3aea8a93          	addi	s5,s5,942 # 80008000 <etext>
    80000c5a:	04000937          	lui	s2,0x4000
    80000c5e:	197d                	addi	s2,s2,-1
    80000c60:	0932                	slli	s2,s2,0xc
  for (p = proc; p < &proc[NPROC]; p++) {
    80000c62:	0000ea17          	auipc	s4,0xe
    80000c66:	c0ea0a13          	addi	s4,s4,-1010 # 8000e870 <tickslock>
    char *pa = kalloc();
    80000c6a:	fffff097          	auipc	ra,0xfffff
    80000c6e:	3f2080e7          	jalr	1010(ra) # 8000005c <kalloc>
    80000c72:	862a                	mv	a2,a0
    if (pa == 0) panic("kalloc");
    80000c74:	c131                	beqz	a0,80000cb8 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int)(p - proc));
    80000c76:	416485b3          	sub	a1,s1,s6
    80000c7a:	858d                	srai	a1,a1,0x3
    80000c7c:	000ab783          	ld	a5,0(s5)
    80000c80:	02f585b3          	mul	a1,a1,a5
    80000c84:	2585                	addiw	a1,a1,1
    80000c86:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c8a:	4719                	li	a4,6
    80000c8c:	6685                	lui	a3,0x1
    80000c8e:	40b905b3          	sub	a1,s2,a1
    80000c92:	854e                	mv	a0,s3
    80000c94:	00000097          	auipc	ra,0x0
    80000c98:	872080e7          	jalr	-1934(ra) # 80000506 <kvmmap>
  for (p = proc; p < &proc[NPROC]; p++) {
    80000c9c:	16848493          	addi	s1,s1,360
    80000ca0:	fd4495e3          	bne	s1,s4,80000c6a <proc_mapstacks+0x38>
  }
}
    80000ca4:	70e2                	ld	ra,56(sp)
    80000ca6:	7442                	ld	s0,48(sp)
    80000ca8:	74a2                	ld	s1,40(sp)
    80000caa:	7902                	ld	s2,32(sp)
    80000cac:	69e2                	ld	s3,24(sp)
    80000cae:	6a42                	ld	s4,16(sp)
    80000cb0:	6aa2                	ld	s5,8(sp)
    80000cb2:	6b02                	ld	s6,0(sp)
    80000cb4:	6121                	addi	sp,sp,64
    80000cb6:	8082                	ret
    if (pa == 0) panic("kalloc");
    80000cb8:	00007517          	auipc	a0,0x7
    80000cbc:	4d050513          	addi	a0,a0,1232 # 80008188 <etext+0x188>
    80000cc0:	00006097          	auipc	ra,0x6
    80000cc4:	a78080e7          	jalr	-1416(ra) # 80006738 <panic>

0000000080000cc8 <procinit>:

// initialize the proc table.
void procinit(void) {
    80000cc8:	7139                	addi	sp,sp,-64
    80000cca:	fc06                	sd	ra,56(sp)
    80000ccc:	f822                	sd	s0,48(sp)
    80000cce:	f426                	sd	s1,40(sp)
    80000cd0:	f04a                	sd	s2,32(sp)
    80000cd2:	ec4e                	sd	s3,24(sp)
    80000cd4:	e852                	sd	s4,16(sp)
    80000cd6:	e456                	sd	s5,8(sp)
    80000cd8:	e05a                	sd	s6,0(sp)
    80000cda:	0080                	addi	s0,sp,64
  struct proc *p;

  initlock(&pid_lock, "nextpid");
    80000cdc:	00007597          	auipc	a1,0x7
    80000ce0:	4b458593          	addi	a1,a1,1204 # 80008190 <etext+0x190>
    80000ce4:	00008517          	auipc	a0,0x8
    80000ce8:	d5c50513          	addi	a0,a0,-676 # 80008a40 <pid_lock>
    80000cec:	00006097          	auipc	ra,0x6
    80000cf0:	ef8080e7          	jalr	-264(ra) # 80006be4 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000cf4:	00007597          	auipc	a1,0x7
    80000cf8:	4a458593          	addi	a1,a1,1188 # 80008198 <etext+0x198>
    80000cfc:	00008517          	auipc	a0,0x8
    80000d00:	d5c50513          	addi	a0,a0,-676 # 80008a58 <wait_lock>
    80000d04:	00006097          	auipc	ra,0x6
    80000d08:	ee0080e7          	jalr	-288(ra) # 80006be4 <initlock>
  for (p = proc; p < &proc[NPROC]; p++) {
    80000d0c:	00008497          	auipc	s1,0x8
    80000d10:	16448493          	addi	s1,s1,356 # 80008e70 <proc>
    initlock(&p->lock, "proc");
    80000d14:	00007b17          	auipc	s6,0x7
    80000d18:	494b0b13          	addi	s6,s6,1172 # 800081a8 <etext+0x1a8>
    p->state = UNUSED;
    p->kstack = KSTACK((int)(p - proc));
    80000d1c:	8aa6                	mv	s5,s1
    80000d1e:	00007a17          	auipc	s4,0x7
    80000d22:	2e2a0a13          	addi	s4,s4,738 # 80008000 <etext>
    80000d26:	04000937          	lui	s2,0x4000
    80000d2a:	197d                	addi	s2,s2,-1
    80000d2c:	0932                	slli	s2,s2,0xc
  for (p = proc; p < &proc[NPROC]; p++) {
    80000d2e:	0000e997          	auipc	s3,0xe
    80000d32:	b4298993          	addi	s3,s3,-1214 # 8000e870 <tickslock>
    initlock(&p->lock, "proc");
    80000d36:	85da                	mv	a1,s6
    80000d38:	8526                	mv	a0,s1
    80000d3a:	00006097          	auipc	ra,0x6
    80000d3e:	eaa080e7          	jalr	-342(ra) # 80006be4 <initlock>
    p->state = UNUSED;
    80000d42:	0004ac23          	sw	zero,24(s1)
    p->kstack = KSTACK((int)(p - proc));
    80000d46:	415487b3          	sub	a5,s1,s5
    80000d4a:	878d                	srai	a5,a5,0x3
    80000d4c:	000a3703          	ld	a4,0(s4)
    80000d50:	02e787b3          	mul	a5,a5,a4
    80000d54:	2785                	addiw	a5,a5,1
    80000d56:	00d7979b          	slliw	a5,a5,0xd
    80000d5a:	40f907b3          	sub	a5,s2,a5
    80000d5e:	e0bc                	sd	a5,64(s1)
  for (p = proc; p < &proc[NPROC]; p++) {
    80000d60:	16848493          	addi	s1,s1,360
    80000d64:	fd3499e3          	bne	s1,s3,80000d36 <procinit+0x6e>
  }
}
    80000d68:	70e2                	ld	ra,56(sp)
    80000d6a:	7442                	ld	s0,48(sp)
    80000d6c:	74a2                	ld	s1,40(sp)
    80000d6e:	7902                	ld	s2,32(sp)
    80000d70:	69e2                	ld	s3,24(sp)
    80000d72:	6a42                	ld	s4,16(sp)
    80000d74:	6aa2                	ld	s5,8(sp)
    80000d76:	6b02                	ld	s6,0(sp)
    80000d78:	6121                	addi	sp,sp,64
    80000d7a:	8082                	ret

0000000080000d7c <cpuid>:

// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int cpuid() {
    80000d7c:	1141                	addi	sp,sp,-16
    80000d7e:	e422                	sd	s0,8(sp)
    80000d80:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r"(x));
    80000d82:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000d84:	2501                	sext.w	a0,a0
    80000d86:	6422                	ld	s0,8(sp)
    80000d88:	0141                	addi	sp,sp,16
    80000d8a:	8082                	ret

0000000080000d8c <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu *mycpu(void) {
    80000d8c:	1141                	addi	sp,sp,-16
    80000d8e:	e422                	sd	s0,8(sp)
    80000d90:	0800                	addi	s0,sp,16
    80000d92:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000d94:	2781                	sext.w	a5,a5
    80000d96:	079e                	slli	a5,a5,0x7
  return c;
}
    80000d98:	00008517          	auipc	a0,0x8
    80000d9c:	cd850513          	addi	a0,a0,-808 # 80008a70 <cpus>
    80000da0:	953e                	add	a0,a0,a5
    80000da2:	6422                	ld	s0,8(sp)
    80000da4:	0141                	addi	sp,sp,16
    80000da6:	8082                	ret

0000000080000da8 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc *myproc(void) {
    80000da8:	1101                	addi	sp,sp,-32
    80000daa:	ec06                	sd	ra,24(sp)
    80000dac:	e822                	sd	s0,16(sp)
    80000dae:	e426                	sd	s1,8(sp)
    80000db0:	1000                	addi	s0,sp,32
  push_off();
    80000db2:	00006097          	auipc	ra,0x6
    80000db6:	e76080e7          	jalr	-394(ra) # 80006c28 <push_off>
    80000dba:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000dbc:	2781                	sext.w	a5,a5
    80000dbe:	079e                	slli	a5,a5,0x7
    80000dc0:	00008717          	auipc	a4,0x8
    80000dc4:	c8070713          	addi	a4,a4,-896 # 80008a40 <pid_lock>
    80000dc8:	97ba                	add	a5,a5,a4
    80000dca:	7b84                	ld	s1,48(a5)
  pop_off();
    80000dcc:	00006097          	auipc	ra,0x6
    80000dd0:	efc080e7          	jalr	-260(ra) # 80006cc8 <pop_off>
  return p;
}
    80000dd4:	8526                	mv	a0,s1
    80000dd6:	60e2                	ld	ra,24(sp)
    80000dd8:	6442                	ld	s0,16(sp)
    80000dda:	64a2                	ld	s1,8(sp)
    80000ddc:	6105                	addi	sp,sp,32
    80000dde:	8082                	ret

0000000080000de0 <forkret>:
  release(&p->lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void forkret(void) {
    80000de0:	1141                	addi	sp,sp,-16
    80000de2:	e406                	sd	ra,8(sp)
    80000de4:	e022                	sd	s0,0(sp)
    80000de6:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000de8:	00000097          	auipc	ra,0x0
    80000dec:	fc0080e7          	jalr	-64(ra) # 80000da8 <myproc>
    80000df0:	00006097          	auipc	ra,0x6
    80000df4:	f38080e7          	jalr	-200(ra) # 80006d28 <release>

  if (first) {
    80000df8:	00008797          	auipc	a5,0x8
    80000dfc:	ba87a783          	lw	a5,-1112(a5) # 800089a0 <first.1>
    80000e00:	eb89                	bnez	a5,80000e12 <forkret+0x32>
    first = 0;
    // ensure other cores see first=0.
    __sync_synchronize();
  }

  usertrapret();
    80000e02:	00001097          	auipc	ra,0x1
    80000e06:	c60080e7          	jalr	-928(ra) # 80001a62 <usertrapret>
}
    80000e0a:	60a2                	ld	ra,8(sp)
    80000e0c:	6402                	ld	s0,0(sp)
    80000e0e:	0141                	addi	sp,sp,16
    80000e10:	8082                	ret
    fsinit(ROOTDEV);
    80000e12:	4505                	li	a0,1
    80000e14:	00002097          	auipc	ra,0x2
    80000e18:	9ac080e7          	jalr	-1620(ra) # 800027c0 <fsinit>
    first = 0;
    80000e1c:	00008797          	auipc	a5,0x8
    80000e20:	b807a223          	sw	zero,-1148(a5) # 800089a0 <first.1>
    __sync_synchronize();
    80000e24:	0ff0000f          	fence
    80000e28:	bfe9                	j	80000e02 <forkret+0x22>

0000000080000e2a <allocpid>:
int allocpid() {
    80000e2a:	1101                	addi	sp,sp,-32
    80000e2c:	ec06                	sd	ra,24(sp)
    80000e2e:	e822                	sd	s0,16(sp)
    80000e30:	e426                	sd	s1,8(sp)
    80000e32:	e04a                	sd	s2,0(sp)
    80000e34:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000e36:	00008917          	auipc	s2,0x8
    80000e3a:	c0a90913          	addi	s2,s2,-1014 # 80008a40 <pid_lock>
    80000e3e:	854a                	mv	a0,s2
    80000e40:	00006097          	auipc	ra,0x6
    80000e44:	e34080e7          	jalr	-460(ra) # 80006c74 <acquire>
  pid = nextpid;
    80000e48:	00008797          	auipc	a5,0x8
    80000e4c:	b5c78793          	addi	a5,a5,-1188 # 800089a4 <nextpid>
    80000e50:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000e52:	0014871b          	addiw	a4,s1,1
    80000e56:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000e58:	854a                	mv	a0,s2
    80000e5a:	00006097          	auipc	ra,0x6
    80000e5e:	ece080e7          	jalr	-306(ra) # 80006d28 <release>
}
    80000e62:	8526                	mv	a0,s1
    80000e64:	60e2                	ld	ra,24(sp)
    80000e66:	6442                	ld	s0,16(sp)
    80000e68:	64a2                	ld	s1,8(sp)
    80000e6a:	6902                	ld	s2,0(sp)
    80000e6c:	6105                	addi	sp,sp,32
    80000e6e:	8082                	ret

0000000080000e70 <proc_pagetable>:
pagetable_t proc_pagetable(struct proc *p) {
    80000e70:	1101                	addi	sp,sp,-32
    80000e72:	ec06                	sd	ra,24(sp)
    80000e74:	e822                	sd	s0,16(sp)
    80000e76:	e426                	sd	s1,8(sp)
    80000e78:	e04a                	sd	s2,0(sp)
    80000e7a:	1000                	addi	s0,sp,32
    80000e7c:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000e7e:	00000097          	auipc	ra,0x0
    80000e82:	872080e7          	jalr	-1934(ra) # 800006f0 <uvmcreate>
    80000e86:	84aa                	mv	s1,a0
  if (pagetable == 0) return 0;
    80000e88:	c121                	beqz	a0,80000ec8 <proc_pagetable+0x58>
  if (mappages(pagetable, TRAMPOLINE, PGSIZE, (uint64)trampoline,
    80000e8a:	4729                	li	a4,10
    80000e8c:	00006697          	auipc	a3,0x6
    80000e90:	17468693          	addi	a3,a3,372 # 80007000 <_trampoline>
    80000e94:	6605                	lui	a2,0x1
    80000e96:	040005b7          	lui	a1,0x4000
    80000e9a:	15fd                	addi	a1,a1,-1
    80000e9c:	05b2                	slli	a1,a1,0xc
    80000e9e:	fffff097          	auipc	ra,0xfffff
    80000ea2:	5a4080e7          	jalr	1444(ra) # 80000442 <mappages>
    80000ea6:	02054863          	bltz	a0,80000ed6 <proc_pagetable+0x66>
  if (mappages(pagetable, TRAPFRAME, PGSIZE, (uint64)(p->trapframe),
    80000eaa:	4719                	li	a4,6
    80000eac:	05893683          	ld	a3,88(s2)
    80000eb0:	6605                	lui	a2,0x1
    80000eb2:	020005b7          	lui	a1,0x2000
    80000eb6:	15fd                	addi	a1,a1,-1
    80000eb8:	05b6                	slli	a1,a1,0xd
    80000eba:	8526                	mv	a0,s1
    80000ebc:	fffff097          	auipc	ra,0xfffff
    80000ec0:	586080e7          	jalr	1414(ra) # 80000442 <mappages>
    80000ec4:	02054163          	bltz	a0,80000ee6 <proc_pagetable+0x76>
}
    80000ec8:	8526                	mv	a0,s1
    80000eca:	60e2                	ld	ra,24(sp)
    80000ecc:	6442                	ld	s0,16(sp)
    80000ece:	64a2                	ld	s1,8(sp)
    80000ed0:	6902                	ld	s2,0(sp)
    80000ed2:	6105                	addi	sp,sp,32
    80000ed4:	8082                	ret
    uvmfree(pagetable, 0);
    80000ed6:	4581                	li	a1,0
    80000ed8:	8526                	mv	a0,s1
    80000eda:	00000097          	auipc	ra,0x0
    80000ede:	a1a080e7          	jalr	-1510(ra) # 800008f4 <uvmfree>
    return 0;
    80000ee2:	4481                	li	s1,0
    80000ee4:	b7d5                	j	80000ec8 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000ee6:	4681                	li	a3,0
    80000ee8:	4605                	li	a2,1
    80000eea:	040005b7          	lui	a1,0x4000
    80000eee:	15fd                	addi	a1,a1,-1
    80000ef0:	05b2                	slli	a1,a1,0xc
    80000ef2:	8526                	mv	a0,s1
    80000ef4:	fffff097          	auipc	ra,0xfffff
    80000ef8:	738080e7          	jalr	1848(ra) # 8000062c <uvmunmap>
    uvmfree(pagetable, 0);
    80000efc:	4581                	li	a1,0
    80000efe:	8526                	mv	a0,s1
    80000f00:	00000097          	auipc	ra,0x0
    80000f04:	9f4080e7          	jalr	-1548(ra) # 800008f4 <uvmfree>
    return 0;
    80000f08:	4481                	li	s1,0
    80000f0a:	bf7d                	j	80000ec8 <proc_pagetable+0x58>

0000000080000f0c <proc_freepagetable>:
void proc_freepagetable(pagetable_t pagetable, uint64 sz) {
    80000f0c:	1101                	addi	sp,sp,-32
    80000f0e:	ec06                	sd	ra,24(sp)
    80000f10:	e822                	sd	s0,16(sp)
    80000f12:	e426                	sd	s1,8(sp)
    80000f14:	e04a                	sd	s2,0(sp)
    80000f16:	1000                	addi	s0,sp,32
    80000f18:	84aa                	mv	s1,a0
    80000f1a:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000f1c:	4681                	li	a3,0
    80000f1e:	4605                	li	a2,1
    80000f20:	040005b7          	lui	a1,0x4000
    80000f24:	15fd                	addi	a1,a1,-1
    80000f26:	05b2                	slli	a1,a1,0xc
    80000f28:	fffff097          	auipc	ra,0xfffff
    80000f2c:	704080e7          	jalr	1796(ra) # 8000062c <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000f30:	4681                	li	a3,0
    80000f32:	4605                	li	a2,1
    80000f34:	020005b7          	lui	a1,0x2000
    80000f38:	15fd                	addi	a1,a1,-1
    80000f3a:	05b6                	slli	a1,a1,0xd
    80000f3c:	8526                	mv	a0,s1
    80000f3e:	fffff097          	auipc	ra,0xfffff
    80000f42:	6ee080e7          	jalr	1774(ra) # 8000062c <uvmunmap>
  uvmfree(pagetable, sz);
    80000f46:	85ca                	mv	a1,s2
    80000f48:	8526                	mv	a0,s1
    80000f4a:	00000097          	auipc	ra,0x0
    80000f4e:	9aa080e7          	jalr	-1622(ra) # 800008f4 <uvmfree>
}
    80000f52:	60e2                	ld	ra,24(sp)
    80000f54:	6442                	ld	s0,16(sp)
    80000f56:	64a2                	ld	s1,8(sp)
    80000f58:	6902                	ld	s2,0(sp)
    80000f5a:	6105                	addi	sp,sp,32
    80000f5c:	8082                	ret

0000000080000f5e <freeproc>:
static void freeproc(struct proc *p) {
    80000f5e:	1101                	addi	sp,sp,-32
    80000f60:	ec06                	sd	ra,24(sp)
    80000f62:	e822                	sd	s0,16(sp)
    80000f64:	e426                	sd	s1,8(sp)
    80000f66:	1000                	addi	s0,sp,32
    80000f68:	84aa                	mv	s1,a0
  if (p->trapframe) kfree((void *)p->trapframe);
    80000f6a:	6d28                	ld	a0,88(a0)
    80000f6c:	c509                	beqz	a0,80000f76 <freeproc+0x18>
    80000f6e:	fffff097          	auipc	ra,0xfffff
    80000f72:	0d6080e7          	jalr	214(ra) # 80000044 <kfree>
  p->trapframe = 0;
    80000f76:	0404bc23          	sd	zero,88(s1)
  if (p->pagetable) proc_freepagetable(p->pagetable, p->sz);
    80000f7a:	68a8                	ld	a0,80(s1)
    80000f7c:	c511                	beqz	a0,80000f88 <freeproc+0x2a>
    80000f7e:	64ac                	ld	a1,72(s1)
    80000f80:	00000097          	auipc	ra,0x0
    80000f84:	f8c080e7          	jalr	-116(ra) # 80000f0c <proc_freepagetable>
  p->pagetable = 0;
    80000f88:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80000f8c:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80000f90:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80000f94:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80000f98:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80000f9c:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80000fa0:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80000fa4:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80000fa8:	0004ac23          	sw	zero,24(s1)
}
    80000fac:	60e2                	ld	ra,24(sp)
    80000fae:	6442                	ld	s0,16(sp)
    80000fb0:	64a2                	ld	s1,8(sp)
    80000fb2:	6105                	addi	sp,sp,32
    80000fb4:	8082                	ret

0000000080000fb6 <allocproc>:
static struct proc *allocproc(void) {
    80000fb6:	1101                	addi	sp,sp,-32
    80000fb8:	ec06                	sd	ra,24(sp)
    80000fba:	e822                	sd	s0,16(sp)
    80000fbc:	e426                	sd	s1,8(sp)
    80000fbe:	e04a                	sd	s2,0(sp)
    80000fc0:	1000                	addi	s0,sp,32
  for (p = proc; p < &proc[NPROC]; p++) {
    80000fc2:	00008497          	auipc	s1,0x8
    80000fc6:	eae48493          	addi	s1,s1,-338 # 80008e70 <proc>
    80000fca:	0000e917          	auipc	s2,0xe
    80000fce:	8a690913          	addi	s2,s2,-1882 # 8000e870 <tickslock>
    acquire(&p->lock);
    80000fd2:	8526                	mv	a0,s1
    80000fd4:	00006097          	auipc	ra,0x6
    80000fd8:	ca0080e7          	jalr	-864(ra) # 80006c74 <acquire>
    if (p->state == UNUSED) {
    80000fdc:	4c9c                	lw	a5,24(s1)
    80000fde:	cf81                	beqz	a5,80000ff6 <allocproc+0x40>
      release(&p->lock);
    80000fe0:	8526                	mv	a0,s1
    80000fe2:	00006097          	auipc	ra,0x6
    80000fe6:	d46080e7          	jalr	-698(ra) # 80006d28 <release>
  for (p = proc; p < &proc[NPROC]; p++) {
    80000fea:	16848493          	addi	s1,s1,360
    80000fee:	ff2492e3          	bne	s1,s2,80000fd2 <allocproc+0x1c>
  return 0;
    80000ff2:	4481                	li	s1,0
    80000ff4:	a889                	j	80001046 <allocproc+0x90>
  p->pid = allocpid();
    80000ff6:	00000097          	auipc	ra,0x0
    80000ffa:	e34080e7          	jalr	-460(ra) # 80000e2a <allocpid>
    80000ffe:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001000:	4785                	li	a5,1
    80001002:	cc9c                	sw	a5,24(s1)
  if ((p->trapframe = (struct trapframe *)kalloc()) == 0) {
    80001004:	fffff097          	auipc	ra,0xfffff
    80001008:	058080e7          	jalr	88(ra) # 8000005c <kalloc>
    8000100c:	892a                	mv	s2,a0
    8000100e:	eca8                	sd	a0,88(s1)
    80001010:	c131                	beqz	a0,80001054 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    80001012:	8526                	mv	a0,s1
    80001014:	00000097          	auipc	ra,0x0
    80001018:	e5c080e7          	jalr	-420(ra) # 80000e70 <proc_pagetable>
    8000101c:	892a                	mv	s2,a0
    8000101e:	e8a8                	sd	a0,80(s1)
  if (p->pagetable == 0) {
    80001020:	c531                	beqz	a0,8000106c <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    80001022:	07000613          	li	a2,112
    80001026:	4581                	li	a1,0
    80001028:	06048513          	addi	a0,s1,96
    8000102c:	fffff097          	auipc	ra,0xfffff
    80001030:	04a080e7          	jalr	74(ra) # 80000076 <memset>
  p->context.ra = (uint64)forkret;
    80001034:	00000797          	auipc	a5,0x0
    80001038:	dac78793          	addi	a5,a5,-596 # 80000de0 <forkret>
    8000103c:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    8000103e:	60bc                	ld	a5,64(s1)
    80001040:	6705                	lui	a4,0x1
    80001042:	97ba                	add	a5,a5,a4
    80001044:	f4bc                	sd	a5,104(s1)
}
    80001046:	8526                	mv	a0,s1
    80001048:	60e2                	ld	ra,24(sp)
    8000104a:	6442                	ld	s0,16(sp)
    8000104c:	64a2                	ld	s1,8(sp)
    8000104e:	6902                	ld	s2,0(sp)
    80001050:	6105                	addi	sp,sp,32
    80001052:	8082                	ret
    freeproc(p);
    80001054:	8526                	mv	a0,s1
    80001056:	00000097          	auipc	ra,0x0
    8000105a:	f08080e7          	jalr	-248(ra) # 80000f5e <freeproc>
    release(&p->lock);
    8000105e:	8526                	mv	a0,s1
    80001060:	00006097          	auipc	ra,0x6
    80001064:	cc8080e7          	jalr	-824(ra) # 80006d28 <release>
    return 0;
    80001068:	84ca                	mv	s1,s2
    8000106a:	bff1                	j	80001046 <allocproc+0x90>
    freeproc(p);
    8000106c:	8526                	mv	a0,s1
    8000106e:	00000097          	auipc	ra,0x0
    80001072:	ef0080e7          	jalr	-272(ra) # 80000f5e <freeproc>
    release(&p->lock);
    80001076:	8526                	mv	a0,s1
    80001078:	00006097          	auipc	ra,0x6
    8000107c:	cb0080e7          	jalr	-848(ra) # 80006d28 <release>
    return 0;
    80001080:	84ca                	mv	s1,s2
    80001082:	b7d1                	j	80001046 <allocproc+0x90>

0000000080001084 <userinit>:
void userinit(void) {
    80001084:	1101                	addi	sp,sp,-32
    80001086:	ec06                	sd	ra,24(sp)
    80001088:	e822                	sd	s0,16(sp)
    8000108a:	e426                	sd	s1,8(sp)
    8000108c:	1000                	addi	s0,sp,32
  p = allocproc();
    8000108e:	00000097          	auipc	ra,0x0
    80001092:	f28080e7          	jalr	-216(ra) # 80000fb6 <allocproc>
    80001096:	84aa                	mv	s1,a0
  initproc = p;
    80001098:	00008797          	auipc	a5,0x8
    8000109c:	96a7b423          	sd	a0,-1688(a5) # 80008a00 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    800010a0:	03400613          	li	a2,52
    800010a4:	00008597          	auipc	a1,0x8
    800010a8:	90c58593          	addi	a1,a1,-1780 # 800089b0 <initcode>
    800010ac:	6928                	ld	a0,80(a0)
    800010ae:	fffff097          	auipc	ra,0xfffff
    800010b2:	670080e7          	jalr	1648(ra) # 8000071e <uvmfirst>
  p->sz = PGSIZE;
    800010b6:	6785                	lui	a5,0x1
    800010b8:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    800010ba:	6cb8                	ld	a4,88(s1)
    800010bc:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    800010c0:	6cb8                	ld	a4,88(s1)
    800010c2:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    800010c4:	4641                	li	a2,16
    800010c6:	00007597          	auipc	a1,0x7
    800010ca:	0ea58593          	addi	a1,a1,234 # 800081b0 <etext+0x1b0>
    800010ce:	15848513          	addi	a0,s1,344
    800010d2:	fffff097          	auipc	ra,0xfffff
    800010d6:	0ee080e7          	jalr	238(ra) # 800001c0 <safestrcpy>
  p->cwd = namei("/");
    800010da:	00007517          	auipc	a0,0x7
    800010de:	0e650513          	addi	a0,a0,230 # 800081c0 <etext+0x1c0>
    800010e2:	00002097          	auipc	ra,0x2
    800010e6:	100080e7          	jalr	256(ra) # 800031e2 <namei>
    800010ea:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    800010ee:	478d                	li	a5,3
    800010f0:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    800010f2:	8526                	mv	a0,s1
    800010f4:	00006097          	auipc	ra,0x6
    800010f8:	c34080e7          	jalr	-972(ra) # 80006d28 <release>
}
    800010fc:	60e2                	ld	ra,24(sp)
    800010fe:	6442                	ld	s0,16(sp)
    80001100:	64a2                	ld	s1,8(sp)
    80001102:	6105                	addi	sp,sp,32
    80001104:	8082                	ret

0000000080001106 <growproc>:
int growproc(int n) {
    80001106:	1101                	addi	sp,sp,-32
    80001108:	ec06                	sd	ra,24(sp)
    8000110a:	e822                	sd	s0,16(sp)
    8000110c:	e426                	sd	s1,8(sp)
    8000110e:	e04a                	sd	s2,0(sp)
    80001110:	1000                	addi	s0,sp,32
    80001112:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001114:	00000097          	auipc	ra,0x0
    80001118:	c94080e7          	jalr	-876(ra) # 80000da8 <myproc>
    8000111c:	84aa                	mv	s1,a0
  sz = p->sz;
    8000111e:	652c                	ld	a1,72(a0)
  if (n > 0) {
    80001120:	01204c63          	bgtz	s2,80001138 <growproc+0x32>
  } else if (n < 0) {
    80001124:	02094663          	bltz	s2,80001150 <growproc+0x4a>
  p->sz = sz;
    80001128:	e4ac                	sd	a1,72(s1)
  return 0;
    8000112a:	4501                	li	a0,0
}
    8000112c:	60e2                	ld	ra,24(sp)
    8000112e:	6442                	ld	s0,16(sp)
    80001130:	64a2                	ld	s1,8(sp)
    80001132:	6902                	ld	s2,0(sp)
    80001134:	6105                	addi	sp,sp,32
    80001136:	8082                	ret
    if ((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001138:	4691                	li	a3,4
    8000113a:	00b90633          	add	a2,s2,a1
    8000113e:	6928                	ld	a0,80(a0)
    80001140:	fffff097          	auipc	ra,0xfffff
    80001144:	698080e7          	jalr	1688(ra) # 800007d8 <uvmalloc>
    80001148:	85aa                	mv	a1,a0
    8000114a:	fd79                	bnez	a0,80001128 <growproc+0x22>
      return -1;
    8000114c:	557d                	li	a0,-1
    8000114e:	bff9                	j	8000112c <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001150:	00b90633          	add	a2,s2,a1
    80001154:	6928                	ld	a0,80(a0)
    80001156:	fffff097          	auipc	ra,0xfffff
    8000115a:	63a080e7          	jalr	1594(ra) # 80000790 <uvmdealloc>
    8000115e:	85aa                	mv	a1,a0
    80001160:	b7e1                	j	80001128 <growproc+0x22>

0000000080001162 <fork>:
int fork(void) {
    80001162:	7139                	addi	sp,sp,-64
    80001164:	fc06                	sd	ra,56(sp)
    80001166:	f822                	sd	s0,48(sp)
    80001168:	f426                	sd	s1,40(sp)
    8000116a:	f04a                	sd	s2,32(sp)
    8000116c:	ec4e                	sd	s3,24(sp)
    8000116e:	e852                	sd	s4,16(sp)
    80001170:	e456                	sd	s5,8(sp)
    80001172:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001174:	00000097          	auipc	ra,0x0
    80001178:	c34080e7          	jalr	-972(ra) # 80000da8 <myproc>
    8000117c:	8aaa                	mv	s5,a0
  if ((np = allocproc()) == 0) {
    8000117e:	00000097          	auipc	ra,0x0
    80001182:	e38080e7          	jalr	-456(ra) # 80000fb6 <allocproc>
    80001186:	10050c63          	beqz	a0,8000129e <fork+0x13c>
    8000118a:	8a2a                	mv	s4,a0
  if (uvmcopy(p->pagetable, np->pagetable, p->sz) < 0) {
    8000118c:	048ab603          	ld	a2,72(s5)
    80001190:	692c                	ld	a1,80(a0)
    80001192:	050ab503          	ld	a0,80(s5)
    80001196:	fffff097          	auipc	ra,0xfffff
    8000119a:	796080e7          	jalr	1942(ra) # 8000092c <uvmcopy>
    8000119e:	04054863          	bltz	a0,800011ee <fork+0x8c>
  np->sz = p->sz;
    800011a2:	048ab783          	ld	a5,72(s5)
    800011a6:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    800011aa:	058ab683          	ld	a3,88(s5)
    800011ae:	87b6                	mv	a5,a3
    800011b0:	058a3703          	ld	a4,88(s4)
    800011b4:	12068693          	addi	a3,a3,288
    800011b8:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    800011bc:	6788                	ld	a0,8(a5)
    800011be:	6b8c                	ld	a1,16(a5)
    800011c0:	6f90                	ld	a2,24(a5)
    800011c2:	01073023          	sd	a6,0(a4)
    800011c6:	e708                	sd	a0,8(a4)
    800011c8:	eb0c                	sd	a1,16(a4)
    800011ca:	ef10                	sd	a2,24(a4)
    800011cc:	02078793          	addi	a5,a5,32
    800011d0:	02070713          	addi	a4,a4,32
    800011d4:	fed792e3          	bne	a5,a3,800011b8 <fork+0x56>
  np->trapframe->a0 = 0;
    800011d8:	058a3783          	ld	a5,88(s4)
    800011dc:	0607b823          	sd	zero,112(a5)
  for (i = 0; i < NOFILE; i++)
    800011e0:	0d0a8493          	addi	s1,s5,208
    800011e4:	0d0a0913          	addi	s2,s4,208
    800011e8:	150a8993          	addi	s3,s5,336
    800011ec:	a00d                	j	8000120e <fork+0xac>
    freeproc(np);
    800011ee:	8552                	mv	a0,s4
    800011f0:	00000097          	auipc	ra,0x0
    800011f4:	d6e080e7          	jalr	-658(ra) # 80000f5e <freeproc>
    release(&np->lock);
    800011f8:	8552                	mv	a0,s4
    800011fa:	00006097          	auipc	ra,0x6
    800011fe:	b2e080e7          	jalr	-1234(ra) # 80006d28 <release>
    return -1;
    80001202:	597d                	li	s2,-1
    80001204:	a059                	j	8000128a <fork+0x128>
  for (i = 0; i < NOFILE; i++)
    80001206:	04a1                	addi	s1,s1,8
    80001208:	0921                	addi	s2,s2,8
    8000120a:	01348b63          	beq	s1,s3,80001220 <fork+0xbe>
    if (p->ofile[i]) np->ofile[i] = filedup(p->ofile[i]);
    8000120e:	6088                	ld	a0,0(s1)
    80001210:	d97d                	beqz	a0,80001206 <fork+0xa4>
    80001212:	00002097          	auipc	ra,0x2
    80001216:	616080e7          	jalr	1558(ra) # 80003828 <filedup>
    8000121a:	00a93023          	sd	a0,0(s2)
    8000121e:	b7e5                	j	80001206 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001220:	150ab503          	ld	a0,336(s5)
    80001224:	00001097          	auipc	ra,0x1
    80001228:	7da080e7          	jalr	2010(ra) # 800029fe <idup>
    8000122c:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001230:	4641                	li	a2,16
    80001232:	158a8593          	addi	a1,s5,344
    80001236:	158a0513          	addi	a0,s4,344
    8000123a:	fffff097          	auipc	ra,0xfffff
    8000123e:	f86080e7          	jalr	-122(ra) # 800001c0 <safestrcpy>
  pid = np->pid;
    80001242:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001246:	8552                	mv	a0,s4
    80001248:	00006097          	auipc	ra,0x6
    8000124c:	ae0080e7          	jalr	-1312(ra) # 80006d28 <release>
  acquire(&wait_lock);
    80001250:	00008497          	auipc	s1,0x8
    80001254:	80848493          	addi	s1,s1,-2040 # 80008a58 <wait_lock>
    80001258:	8526                	mv	a0,s1
    8000125a:	00006097          	auipc	ra,0x6
    8000125e:	a1a080e7          	jalr	-1510(ra) # 80006c74 <acquire>
  np->parent = p;
    80001262:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001266:	8526                	mv	a0,s1
    80001268:	00006097          	auipc	ra,0x6
    8000126c:	ac0080e7          	jalr	-1344(ra) # 80006d28 <release>
  acquire(&np->lock);
    80001270:	8552                	mv	a0,s4
    80001272:	00006097          	auipc	ra,0x6
    80001276:	a02080e7          	jalr	-1534(ra) # 80006c74 <acquire>
  np->state = RUNNABLE;
    8000127a:	478d                	li	a5,3
    8000127c:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001280:	8552                	mv	a0,s4
    80001282:	00006097          	auipc	ra,0x6
    80001286:	aa6080e7          	jalr	-1370(ra) # 80006d28 <release>
}
    8000128a:	854a                	mv	a0,s2
    8000128c:	70e2                	ld	ra,56(sp)
    8000128e:	7442                	ld	s0,48(sp)
    80001290:	74a2                	ld	s1,40(sp)
    80001292:	7902                	ld	s2,32(sp)
    80001294:	69e2                	ld	s3,24(sp)
    80001296:	6a42                	ld	s4,16(sp)
    80001298:	6aa2                	ld	s5,8(sp)
    8000129a:	6121                	addi	sp,sp,64
    8000129c:	8082                	ret
    return -1;
    8000129e:	597d                	li	s2,-1
    800012a0:	b7ed                	j	8000128a <fork+0x128>

00000000800012a2 <scheduler>:
void scheduler(void) {
    800012a2:	7139                	addi	sp,sp,-64
    800012a4:	fc06                	sd	ra,56(sp)
    800012a6:	f822                	sd	s0,48(sp)
    800012a8:	f426                	sd	s1,40(sp)
    800012aa:	f04a                	sd	s2,32(sp)
    800012ac:	ec4e                	sd	s3,24(sp)
    800012ae:	e852                	sd	s4,16(sp)
    800012b0:	e456                	sd	s5,8(sp)
    800012b2:	e05a                	sd	s6,0(sp)
    800012b4:	0080                	addi	s0,sp,64
    800012b6:	8792                	mv	a5,tp
  int id = r_tp();
    800012b8:	2781                	sext.w	a5,a5
  c->proc = 0;
    800012ba:	00779a93          	slli	s5,a5,0x7
    800012be:	00007717          	auipc	a4,0x7
    800012c2:	78270713          	addi	a4,a4,1922 # 80008a40 <pid_lock>
    800012c6:	9756                	add	a4,a4,s5
    800012c8:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    800012cc:	00007717          	auipc	a4,0x7
    800012d0:	7ac70713          	addi	a4,a4,1964 # 80008a78 <cpus+0x8>
    800012d4:	9aba                	add	s5,s5,a4
      if (p->state == RUNNABLE) {
    800012d6:	498d                	li	s3,3
        p->state = RUNNING;
    800012d8:	4b11                	li	s6,4
        c->proc = p;
    800012da:	079e                	slli	a5,a5,0x7
    800012dc:	00007a17          	auipc	s4,0x7
    800012e0:	764a0a13          	addi	s4,s4,1892 # 80008a40 <pid_lock>
    800012e4:	9a3e                	add	s4,s4,a5
    for (p = proc; p < &proc[NPROC]; p++) {
    800012e6:	0000d917          	auipc	s2,0xd
    800012ea:	58a90913          	addi	s2,s2,1418 # 8000e870 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r"(x));
    800012ee:	100027f3          	csrr	a5,sstatus
static inline void intr_on() { w_sstatus(r_sstatus() | SSTATUS_SIE); }
    800012f2:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r"(x));
    800012f6:	10079073          	csrw	sstatus,a5
    800012fa:	00008497          	auipc	s1,0x8
    800012fe:	b7648493          	addi	s1,s1,-1162 # 80008e70 <proc>
    80001302:	a811                	j	80001316 <scheduler+0x74>
      release(&p->lock);
    80001304:	8526                	mv	a0,s1
    80001306:	00006097          	auipc	ra,0x6
    8000130a:	a22080e7          	jalr	-1502(ra) # 80006d28 <release>
    for (p = proc; p < &proc[NPROC]; p++) {
    8000130e:	16848493          	addi	s1,s1,360
    80001312:	fd248ee3          	beq	s1,s2,800012ee <scheduler+0x4c>
      acquire(&p->lock);
    80001316:	8526                	mv	a0,s1
    80001318:	00006097          	auipc	ra,0x6
    8000131c:	95c080e7          	jalr	-1700(ra) # 80006c74 <acquire>
      if (p->state == RUNNABLE) {
    80001320:	4c9c                	lw	a5,24(s1)
    80001322:	ff3791e3          	bne	a5,s3,80001304 <scheduler+0x62>
        p->state = RUNNING;
    80001326:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    8000132a:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    8000132e:	06048593          	addi	a1,s1,96
    80001332:	8556                	mv	a0,s5
    80001334:	00000097          	auipc	ra,0x0
    80001338:	684080e7          	jalr	1668(ra) # 800019b8 <swtch>
        c->proc = 0;
    8000133c:	020a3823          	sd	zero,48(s4)
    80001340:	b7d1                	j	80001304 <scheduler+0x62>

0000000080001342 <sched>:
void sched(void) {
    80001342:	7179                	addi	sp,sp,-48
    80001344:	f406                	sd	ra,40(sp)
    80001346:	f022                	sd	s0,32(sp)
    80001348:	ec26                	sd	s1,24(sp)
    8000134a:	e84a                	sd	s2,16(sp)
    8000134c:	e44e                	sd	s3,8(sp)
    8000134e:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001350:	00000097          	auipc	ra,0x0
    80001354:	a58080e7          	jalr	-1448(ra) # 80000da8 <myproc>
    80001358:	84aa                	mv	s1,a0
  if (!holding(&p->lock)) panic("sched p->lock");
    8000135a:	00006097          	auipc	ra,0x6
    8000135e:	8a0080e7          	jalr	-1888(ra) # 80006bfa <holding>
    80001362:	c93d                	beqz	a0,800013d8 <sched+0x96>
  asm volatile("mv %0, tp" : "=r"(x));
    80001364:	8792                	mv	a5,tp
  if (mycpu()->noff != 1) panic("sched locks");
    80001366:	2781                	sext.w	a5,a5
    80001368:	079e                	slli	a5,a5,0x7
    8000136a:	00007717          	auipc	a4,0x7
    8000136e:	6d670713          	addi	a4,a4,1750 # 80008a40 <pid_lock>
    80001372:	97ba                	add	a5,a5,a4
    80001374:	0a87a703          	lw	a4,168(a5)
    80001378:	4785                	li	a5,1
    8000137a:	06f71763          	bne	a4,a5,800013e8 <sched+0xa6>
  if (p->state == RUNNING) panic("sched running");
    8000137e:	4c98                	lw	a4,24(s1)
    80001380:	4791                	li	a5,4
    80001382:	06f70b63          	beq	a4,a5,800013f8 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80001386:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000138a:	8b89                	andi	a5,a5,2
  if (intr_get()) panic("sched interruptible");
    8000138c:	efb5                	bnez	a5,80001408 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r"(x));
    8000138e:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001390:	00007917          	auipc	s2,0x7
    80001394:	6b090913          	addi	s2,s2,1712 # 80008a40 <pid_lock>
    80001398:	2781                	sext.w	a5,a5
    8000139a:	079e                	slli	a5,a5,0x7
    8000139c:	97ca                	add	a5,a5,s2
    8000139e:	0ac7a983          	lw	s3,172(a5)
    800013a2:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800013a4:	2781                	sext.w	a5,a5
    800013a6:	079e                	slli	a5,a5,0x7
    800013a8:	00007597          	auipc	a1,0x7
    800013ac:	6d058593          	addi	a1,a1,1744 # 80008a78 <cpus+0x8>
    800013b0:	95be                	add	a1,a1,a5
    800013b2:	06048513          	addi	a0,s1,96
    800013b6:	00000097          	auipc	ra,0x0
    800013ba:	602080e7          	jalr	1538(ra) # 800019b8 <swtch>
    800013be:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800013c0:	2781                	sext.w	a5,a5
    800013c2:	079e                	slli	a5,a5,0x7
    800013c4:	97ca                	add	a5,a5,s2
    800013c6:	0b37a623          	sw	s3,172(a5)
}
    800013ca:	70a2                	ld	ra,40(sp)
    800013cc:	7402                	ld	s0,32(sp)
    800013ce:	64e2                	ld	s1,24(sp)
    800013d0:	6942                	ld	s2,16(sp)
    800013d2:	69a2                	ld	s3,8(sp)
    800013d4:	6145                	addi	sp,sp,48
    800013d6:	8082                	ret
  if (!holding(&p->lock)) panic("sched p->lock");
    800013d8:	00007517          	auipc	a0,0x7
    800013dc:	df050513          	addi	a0,a0,-528 # 800081c8 <etext+0x1c8>
    800013e0:	00005097          	auipc	ra,0x5
    800013e4:	358080e7          	jalr	856(ra) # 80006738 <panic>
  if (mycpu()->noff != 1) panic("sched locks");
    800013e8:	00007517          	auipc	a0,0x7
    800013ec:	df050513          	addi	a0,a0,-528 # 800081d8 <etext+0x1d8>
    800013f0:	00005097          	auipc	ra,0x5
    800013f4:	348080e7          	jalr	840(ra) # 80006738 <panic>
  if (p->state == RUNNING) panic("sched running");
    800013f8:	00007517          	auipc	a0,0x7
    800013fc:	df050513          	addi	a0,a0,-528 # 800081e8 <etext+0x1e8>
    80001400:	00005097          	auipc	ra,0x5
    80001404:	338080e7          	jalr	824(ra) # 80006738 <panic>
  if (intr_get()) panic("sched interruptible");
    80001408:	00007517          	auipc	a0,0x7
    8000140c:	df050513          	addi	a0,a0,-528 # 800081f8 <etext+0x1f8>
    80001410:	00005097          	auipc	ra,0x5
    80001414:	328080e7          	jalr	808(ra) # 80006738 <panic>

0000000080001418 <yield>:
void yield(void) {
    80001418:	1101                	addi	sp,sp,-32
    8000141a:	ec06                	sd	ra,24(sp)
    8000141c:	e822                	sd	s0,16(sp)
    8000141e:	e426                	sd	s1,8(sp)
    80001420:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001422:	00000097          	auipc	ra,0x0
    80001426:	986080e7          	jalr	-1658(ra) # 80000da8 <myproc>
    8000142a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000142c:	00006097          	auipc	ra,0x6
    80001430:	848080e7          	jalr	-1976(ra) # 80006c74 <acquire>
  p->state = RUNNABLE;
    80001434:	478d                	li	a5,3
    80001436:	cc9c                	sw	a5,24(s1)
  sched();
    80001438:	00000097          	auipc	ra,0x0
    8000143c:	f0a080e7          	jalr	-246(ra) # 80001342 <sched>
  release(&p->lock);
    80001440:	8526                	mv	a0,s1
    80001442:	00006097          	auipc	ra,0x6
    80001446:	8e6080e7          	jalr	-1818(ra) # 80006d28 <release>
}
    8000144a:	60e2                	ld	ra,24(sp)
    8000144c:	6442                	ld	s0,16(sp)
    8000144e:	64a2                	ld	s1,8(sp)
    80001450:	6105                	addi	sp,sp,32
    80001452:	8082                	ret

0000000080001454 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk) {
    80001454:	7179                	addi	sp,sp,-48
    80001456:	f406                	sd	ra,40(sp)
    80001458:	f022                	sd	s0,32(sp)
    8000145a:	ec26                	sd	s1,24(sp)
    8000145c:	e84a                	sd	s2,16(sp)
    8000145e:	e44e                	sd	s3,8(sp)
    80001460:	1800                	addi	s0,sp,48
    80001462:	89aa                	mv	s3,a0
    80001464:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001466:	00000097          	auipc	ra,0x0
    8000146a:	942080e7          	jalr	-1726(ra) # 80000da8 <myproc>
    8000146e:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  // DOC: sleeplock1
    80001470:	00006097          	auipc	ra,0x6
    80001474:	804080e7          	jalr	-2044(ra) # 80006c74 <acquire>
  release(lk);
    80001478:	854a                	mv	a0,s2
    8000147a:	00006097          	auipc	ra,0x6
    8000147e:	8ae080e7          	jalr	-1874(ra) # 80006d28 <release>

  // Go to sleep.
  p->chan = chan;
    80001482:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80001486:	4789                	li	a5,2
    80001488:	cc9c                	sw	a5,24(s1)

  sched();
    8000148a:	00000097          	auipc	ra,0x0
    8000148e:	eb8080e7          	jalr	-328(ra) # 80001342 <sched>

  // Tidy up.
  p->chan = 0;
    80001492:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80001496:	8526                	mv	a0,s1
    80001498:	00006097          	auipc	ra,0x6
    8000149c:	890080e7          	jalr	-1904(ra) # 80006d28 <release>
  acquire(lk);
    800014a0:	854a                	mv	a0,s2
    800014a2:	00005097          	auipc	ra,0x5
    800014a6:	7d2080e7          	jalr	2002(ra) # 80006c74 <acquire>
}
    800014aa:	70a2                	ld	ra,40(sp)
    800014ac:	7402                	ld	s0,32(sp)
    800014ae:	64e2                	ld	s1,24(sp)
    800014b0:	6942                	ld	s2,16(sp)
    800014b2:	69a2                	ld	s3,8(sp)
    800014b4:	6145                	addi	sp,sp,48
    800014b6:	8082                	ret

00000000800014b8 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void wakeup(void *chan) {
    800014b8:	7139                	addi	sp,sp,-64
    800014ba:	fc06                	sd	ra,56(sp)
    800014bc:	f822                	sd	s0,48(sp)
    800014be:	f426                	sd	s1,40(sp)
    800014c0:	f04a                	sd	s2,32(sp)
    800014c2:	ec4e                	sd	s3,24(sp)
    800014c4:	e852                	sd	s4,16(sp)
    800014c6:	e456                	sd	s5,8(sp)
    800014c8:	0080                	addi	s0,sp,64
    800014ca:	8a2a                	mv	s4,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++) {
    800014cc:	00008497          	auipc	s1,0x8
    800014d0:	9a448493          	addi	s1,s1,-1628 # 80008e70 <proc>
    if (p != myproc()) {
      acquire(&p->lock);
      if (p->state == SLEEPING && p->chan == chan) {
    800014d4:	4989                	li	s3,2
        p->state = RUNNABLE;
    800014d6:	4a8d                	li	s5,3
  for (p = proc; p < &proc[NPROC]; p++) {
    800014d8:	0000d917          	auipc	s2,0xd
    800014dc:	39890913          	addi	s2,s2,920 # 8000e870 <tickslock>
    800014e0:	a811                	j	800014f4 <wakeup+0x3c>
      }
      release(&p->lock);
    800014e2:	8526                	mv	a0,s1
    800014e4:	00006097          	auipc	ra,0x6
    800014e8:	844080e7          	jalr	-1980(ra) # 80006d28 <release>
  for (p = proc; p < &proc[NPROC]; p++) {
    800014ec:	16848493          	addi	s1,s1,360
    800014f0:	03248663          	beq	s1,s2,8000151c <wakeup+0x64>
    if (p != myproc()) {
    800014f4:	00000097          	auipc	ra,0x0
    800014f8:	8b4080e7          	jalr	-1868(ra) # 80000da8 <myproc>
    800014fc:	fea488e3          	beq	s1,a0,800014ec <wakeup+0x34>
      acquire(&p->lock);
    80001500:	8526                	mv	a0,s1
    80001502:	00005097          	auipc	ra,0x5
    80001506:	772080e7          	jalr	1906(ra) # 80006c74 <acquire>
      if (p->state == SLEEPING && p->chan == chan) {
    8000150a:	4c9c                	lw	a5,24(s1)
    8000150c:	fd379be3          	bne	a5,s3,800014e2 <wakeup+0x2a>
    80001510:	709c                	ld	a5,32(s1)
    80001512:	fd4798e3          	bne	a5,s4,800014e2 <wakeup+0x2a>
        p->state = RUNNABLE;
    80001516:	0154ac23          	sw	s5,24(s1)
    8000151a:	b7e1                	j	800014e2 <wakeup+0x2a>
    }
  }
}
    8000151c:	70e2                	ld	ra,56(sp)
    8000151e:	7442                	ld	s0,48(sp)
    80001520:	74a2                	ld	s1,40(sp)
    80001522:	7902                	ld	s2,32(sp)
    80001524:	69e2                	ld	s3,24(sp)
    80001526:	6a42                	ld	s4,16(sp)
    80001528:	6aa2                	ld	s5,8(sp)
    8000152a:	6121                	addi	sp,sp,64
    8000152c:	8082                	ret

000000008000152e <reparent>:
void reparent(struct proc *p) {
    8000152e:	7179                	addi	sp,sp,-48
    80001530:	f406                	sd	ra,40(sp)
    80001532:	f022                	sd	s0,32(sp)
    80001534:	ec26                	sd	s1,24(sp)
    80001536:	e84a                	sd	s2,16(sp)
    80001538:	e44e                	sd	s3,8(sp)
    8000153a:	e052                	sd	s4,0(sp)
    8000153c:	1800                	addi	s0,sp,48
    8000153e:	892a                	mv	s2,a0
  for (pp = proc; pp < &proc[NPROC]; pp++) {
    80001540:	00008497          	auipc	s1,0x8
    80001544:	93048493          	addi	s1,s1,-1744 # 80008e70 <proc>
      pp->parent = initproc;
    80001548:	00007a17          	auipc	s4,0x7
    8000154c:	4b8a0a13          	addi	s4,s4,1208 # 80008a00 <initproc>
  for (pp = proc; pp < &proc[NPROC]; pp++) {
    80001550:	0000d997          	auipc	s3,0xd
    80001554:	32098993          	addi	s3,s3,800 # 8000e870 <tickslock>
    80001558:	a029                	j	80001562 <reparent+0x34>
    8000155a:	16848493          	addi	s1,s1,360
    8000155e:	01348d63          	beq	s1,s3,80001578 <reparent+0x4a>
    if (pp->parent == p) {
    80001562:	7c9c                	ld	a5,56(s1)
    80001564:	ff279be3          	bne	a5,s2,8000155a <reparent+0x2c>
      pp->parent = initproc;
    80001568:	000a3503          	ld	a0,0(s4)
    8000156c:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    8000156e:	00000097          	auipc	ra,0x0
    80001572:	f4a080e7          	jalr	-182(ra) # 800014b8 <wakeup>
    80001576:	b7d5                	j	8000155a <reparent+0x2c>
}
    80001578:	70a2                	ld	ra,40(sp)
    8000157a:	7402                	ld	s0,32(sp)
    8000157c:	64e2                	ld	s1,24(sp)
    8000157e:	6942                	ld	s2,16(sp)
    80001580:	69a2                	ld	s3,8(sp)
    80001582:	6a02                	ld	s4,0(sp)
    80001584:	6145                	addi	sp,sp,48
    80001586:	8082                	ret

0000000080001588 <exit>:
void exit(int status) {
    80001588:	7179                	addi	sp,sp,-48
    8000158a:	f406                	sd	ra,40(sp)
    8000158c:	f022                	sd	s0,32(sp)
    8000158e:	ec26                	sd	s1,24(sp)
    80001590:	e84a                	sd	s2,16(sp)
    80001592:	e44e                	sd	s3,8(sp)
    80001594:	e052                	sd	s4,0(sp)
    80001596:	1800                	addi	s0,sp,48
    80001598:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    8000159a:	00000097          	auipc	ra,0x0
    8000159e:	80e080e7          	jalr	-2034(ra) # 80000da8 <myproc>
    800015a2:	89aa                	mv	s3,a0
  if (p == initproc) panic("init exiting");
    800015a4:	00007797          	auipc	a5,0x7
    800015a8:	45c7b783          	ld	a5,1116(a5) # 80008a00 <initproc>
    800015ac:	0d050493          	addi	s1,a0,208
    800015b0:	15050913          	addi	s2,a0,336
    800015b4:	02a79363          	bne	a5,a0,800015da <exit+0x52>
    800015b8:	00007517          	auipc	a0,0x7
    800015bc:	c5850513          	addi	a0,a0,-936 # 80008210 <etext+0x210>
    800015c0:	00005097          	auipc	ra,0x5
    800015c4:	178080e7          	jalr	376(ra) # 80006738 <panic>
      fileclose(f);
    800015c8:	00002097          	auipc	ra,0x2
    800015cc:	2ae080e7          	jalr	686(ra) # 80003876 <fileclose>
      p->ofile[fd] = 0;
    800015d0:	0004b023          	sd	zero,0(s1)
  for (int fd = 0; fd < NOFILE; fd++) {
    800015d4:	04a1                	addi	s1,s1,8
    800015d6:	01248563          	beq	s1,s2,800015e0 <exit+0x58>
    if (p->ofile[fd]) {
    800015da:	6088                	ld	a0,0(s1)
    800015dc:	f575                	bnez	a0,800015c8 <exit+0x40>
    800015de:	bfdd                	j	800015d4 <exit+0x4c>
  begin_op();
    800015e0:	00002097          	auipc	ra,0x2
    800015e4:	e1e080e7          	jalr	-482(ra) # 800033fe <begin_op>
  iput(p->cwd);
    800015e8:	1509b503          	ld	a0,336(s3)
    800015ec:	00001097          	auipc	ra,0x1
    800015f0:	60a080e7          	jalr	1546(ra) # 80002bf6 <iput>
  end_op();
    800015f4:	00002097          	auipc	ra,0x2
    800015f8:	e8a080e7          	jalr	-374(ra) # 8000347e <end_op>
  p->cwd = 0;
    800015fc:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80001600:	00007497          	auipc	s1,0x7
    80001604:	45848493          	addi	s1,s1,1112 # 80008a58 <wait_lock>
    80001608:	8526                	mv	a0,s1
    8000160a:	00005097          	auipc	ra,0x5
    8000160e:	66a080e7          	jalr	1642(ra) # 80006c74 <acquire>
  reparent(p);
    80001612:	854e                	mv	a0,s3
    80001614:	00000097          	auipc	ra,0x0
    80001618:	f1a080e7          	jalr	-230(ra) # 8000152e <reparent>
  wakeup(p->parent);
    8000161c:	0389b503          	ld	a0,56(s3)
    80001620:	00000097          	auipc	ra,0x0
    80001624:	e98080e7          	jalr	-360(ra) # 800014b8 <wakeup>
  acquire(&p->lock);
    80001628:	854e                	mv	a0,s3
    8000162a:	00005097          	auipc	ra,0x5
    8000162e:	64a080e7          	jalr	1610(ra) # 80006c74 <acquire>
  p->xstate = status;
    80001632:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001636:	4795                	li	a5,5
    80001638:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    8000163c:	8526                	mv	a0,s1
    8000163e:	00005097          	auipc	ra,0x5
    80001642:	6ea080e7          	jalr	1770(ra) # 80006d28 <release>
  sched();
    80001646:	00000097          	auipc	ra,0x0
    8000164a:	cfc080e7          	jalr	-772(ra) # 80001342 <sched>
  panic("zombie exit");
    8000164e:	00007517          	auipc	a0,0x7
    80001652:	bd250513          	addi	a0,a0,-1070 # 80008220 <etext+0x220>
    80001656:	00005097          	auipc	ra,0x5
    8000165a:	0e2080e7          	jalr	226(ra) # 80006738 <panic>

000000008000165e <kill>:

// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int kill(int pid) {
    8000165e:	7179                	addi	sp,sp,-48
    80001660:	f406                	sd	ra,40(sp)
    80001662:	f022                	sd	s0,32(sp)
    80001664:	ec26                	sd	s1,24(sp)
    80001666:	e84a                	sd	s2,16(sp)
    80001668:	e44e                	sd	s3,8(sp)
    8000166a:	1800                	addi	s0,sp,48
    8000166c:	892a                	mv	s2,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++) {
    8000166e:	00008497          	auipc	s1,0x8
    80001672:	80248493          	addi	s1,s1,-2046 # 80008e70 <proc>
    80001676:	0000d997          	auipc	s3,0xd
    8000167a:	1fa98993          	addi	s3,s3,506 # 8000e870 <tickslock>
    acquire(&p->lock);
    8000167e:	8526                	mv	a0,s1
    80001680:	00005097          	auipc	ra,0x5
    80001684:	5f4080e7          	jalr	1524(ra) # 80006c74 <acquire>
    if (p->pid == pid) {
    80001688:	589c                	lw	a5,48(s1)
    8000168a:	01278d63          	beq	a5,s2,800016a4 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    8000168e:	8526                	mv	a0,s1
    80001690:	00005097          	auipc	ra,0x5
    80001694:	698080e7          	jalr	1688(ra) # 80006d28 <release>
  for (p = proc; p < &proc[NPROC]; p++) {
    80001698:	16848493          	addi	s1,s1,360
    8000169c:	ff3491e3          	bne	s1,s3,8000167e <kill+0x20>
  }
  return -1;
    800016a0:	557d                	li	a0,-1
    800016a2:	a829                	j	800016bc <kill+0x5e>
      p->killed = 1;
    800016a4:	4785                	li	a5,1
    800016a6:	d49c                	sw	a5,40(s1)
      if (p->state == SLEEPING) {
    800016a8:	4c98                	lw	a4,24(s1)
    800016aa:	4789                	li	a5,2
    800016ac:	00f70f63          	beq	a4,a5,800016ca <kill+0x6c>
      release(&p->lock);
    800016b0:	8526                	mv	a0,s1
    800016b2:	00005097          	auipc	ra,0x5
    800016b6:	676080e7          	jalr	1654(ra) # 80006d28 <release>
      return 0;
    800016ba:	4501                	li	a0,0
}
    800016bc:	70a2                	ld	ra,40(sp)
    800016be:	7402                	ld	s0,32(sp)
    800016c0:	64e2                	ld	s1,24(sp)
    800016c2:	6942                	ld	s2,16(sp)
    800016c4:	69a2                	ld	s3,8(sp)
    800016c6:	6145                	addi	sp,sp,48
    800016c8:	8082                	ret
        p->state = RUNNABLE;
    800016ca:	478d                	li	a5,3
    800016cc:	cc9c                	sw	a5,24(s1)
    800016ce:	b7cd                	j	800016b0 <kill+0x52>

00000000800016d0 <setkilled>:

void setkilled(struct proc *p) {
    800016d0:	1101                	addi	sp,sp,-32
    800016d2:	ec06                	sd	ra,24(sp)
    800016d4:	e822                	sd	s0,16(sp)
    800016d6:	e426                	sd	s1,8(sp)
    800016d8:	1000                	addi	s0,sp,32
    800016da:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800016dc:	00005097          	auipc	ra,0x5
    800016e0:	598080e7          	jalr	1432(ra) # 80006c74 <acquire>
  p->killed = 1;
    800016e4:	4785                	li	a5,1
    800016e6:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    800016e8:	8526                	mv	a0,s1
    800016ea:	00005097          	auipc	ra,0x5
    800016ee:	63e080e7          	jalr	1598(ra) # 80006d28 <release>
}
    800016f2:	60e2                	ld	ra,24(sp)
    800016f4:	6442                	ld	s0,16(sp)
    800016f6:	64a2                	ld	s1,8(sp)
    800016f8:	6105                	addi	sp,sp,32
    800016fa:	8082                	ret

00000000800016fc <killed>:

int killed(struct proc *p) {
    800016fc:	1101                	addi	sp,sp,-32
    800016fe:	ec06                	sd	ra,24(sp)
    80001700:	e822                	sd	s0,16(sp)
    80001702:	e426                	sd	s1,8(sp)
    80001704:	e04a                	sd	s2,0(sp)
    80001706:	1000                	addi	s0,sp,32
    80001708:	84aa                	mv	s1,a0
  int k;

  acquire(&p->lock);
    8000170a:	00005097          	auipc	ra,0x5
    8000170e:	56a080e7          	jalr	1386(ra) # 80006c74 <acquire>
  k = p->killed;
    80001712:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    80001716:	8526                	mv	a0,s1
    80001718:	00005097          	auipc	ra,0x5
    8000171c:	610080e7          	jalr	1552(ra) # 80006d28 <release>
  return k;
}
    80001720:	854a                	mv	a0,s2
    80001722:	60e2                	ld	ra,24(sp)
    80001724:	6442                	ld	s0,16(sp)
    80001726:	64a2                	ld	s1,8(sp)
    80001728:	6902                	ld	s2,0(sp)
    8000172a:	6105                	addi	sp,sp,32
    8000172c:	8082                	ret

000000008000172e <wait>:
int wait(uint64 addr) {
    8000172e:	715d                	addi	sp,sp,-80
    80001730:	e486                	sd	ra,72(sp)
    80001732:	e0a2                	sd	s0,64(sp)
    80001734:	fc26                	sd	s1,56(sp)
    80001736:	f84a                	sd	s2,48(sp)
    80001738:	f44e                	sd	s3,40(sp)
    8000173a:	f052                	sd	s4,32(sp)
    8000173c:	ec56                	sd	s5,24(sp)
    8000173e:	e85a                	sd	s6,16(sp)
    80001740:	e45e                	sd	s7,8(sp)
    80001742:	e062                	sd	s8,0(sp)
    80001744:	0880                	addi	s0,sp,80
    80001746:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001748:	fffff097          	auipc	ra,0xfffff
    8000174c:	660080e7          	jalr	1632(ra) # 80000da8 <myproc>
    80001750:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80001752:	00007517          	auipc	a0,0x7
    80001756:	30650513          	addi	a0,a0,774 # 80008a58 <wait_lock>
    8000175a:	00005097          	auipc	ra,0x5
    8000175e:	51a080e7          	jalr	1306(ra) # 80006c74 <acquire>
    havekids = 0;
    80001762:	4b81                	li	s7,0
        if (pp->state == ZOMBIE) {
    80001764:	4a15                	li	s4,5
        havekids = 1;
    80001766:	4a85                	li	s5,1
    for (pp = proc; pp < &proc[NPROC]; pp++) {
    80001768:	0000d997          	auipc	s3,0xd
    8000176c:	10898993          	addi	s3,s3,264 # 8000e870 <tickslock>
    sleep(p, &wait_lock);  // DOC: wait-sleep
    80001770:	00007c17          	auipc	s8,0x7
    80001774:	2e8c0c13          	addi	s8,s8,744 # 80008a58 <wait_lock>
    havekids = 0;
    80001778:	875e                	mv	a4,s7
    for (pp = proc; pp < &proc[NPROC]; pp++) {
    8000177a:	00007497          	auipc	s1,0x7
    8000177e:	6f648493          	addi	s1,s1,1782 # 80008e70 <proc>
    80001782:	a0bd                	j	800017f0 <wait+0xc2>
          pid = pp->pid;
    80001784:	0304a983          	lw	s3,48(s1)
          if (addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80001788:	000b0e63          	beqz	s6,800017a4 <wait+0x76>
    8000178c:	4691                	li	a3,4
    8000178e:	02c48613          	addi	a2,s1,44
    80001792:	85da                	mv	a1,s6
    80001794:	05093503          	ld	a0,80(s2)
    80001798:	fffff097          	auipc	ra,0xfffff
    8000179c:	298080e7          	jalr	664(ra) # 80000a30 <copyout>
    800017a0:	02054563          	bltz	a0,800017ca <wait+0x9c>
          freeproc(pp);
    800017a4:	8526                	mv	a0,s1
    800017a6:	fffff097          	auipc	ra,0xfffff
    800017aa:	7b8080e7          	jalr	1976(ra) # 80000f5e <freeproc>
          release(&pp->lock);
    800017ae:	8526                	mv	a0,s1
    800017b0:	00005097          	auipc	ra,0x5
    800017b4:	578080e7          	jalr	1400(ra) # 80006d28 <release>
          release(&wait_lock);
    800017b8:	00007517          	auipc	a0,0x7
    800017bc:	2a050513          	addi	a0,a0,672 # 80008a58 <wait_lock>
    800017c0:	00005097          	auipc	ra,0x5
    800017c4:	568080e7          	jalr	1384(ra) # 80006d28 <release>
          return pid;
    800017c8:	a0b5                	j	80001834 <wait+0x106>
            release(&pp->lock);
    800017ca:	8526                	mv	a0,s1
    800017cc:	00005097          	auipc	ra,0x5
    800017d0:	55c080e7          	jalr	1372(ra) # 80006d28 <release>
            release(&wait_lock);
    800017d4:	00007517          	auipc	a0,0x7
    800017d8:	28450513          	addi	a0,a0,644 # 80008a58 <wait_lock>
    800017dc:	00005097          	auipc	ra,0x5
    800017e0:	54c080e7          	jalr	1356(ra) # 80006d28 <release>
            return -1;
    800017e4:	59fd                	li	s3,-1
    800017e6:	a0b9                	j	80001834 <wait+0x106>
    for (pp = proc; pp < &proc[NPROC]; pp++) {
    800017e8:	16848493          	addi	s1,s1,360
    800017ec:	03348463          	beq	s1,s3,80001814 <wait+0xe6>
      if (pp->parent == p) {
    800017f0:	7c9c                	ld	a5,56(s1)
    800017f2:	ff279be3          	bne	a5,s2,800017e8 <wait+0xba>
        acquire(&pp->lock);
    800017f6:	8526                	mv	a0,s1
    800017f8:	00005097          	auipc	ra,0x5
    800017fc:	47c080e7          	jalr	1148(ra) # 80006c74 <acquire>
        if (pp->state == ZOMBIE) {
    80001800:	4c9c                	lw	a5,24(s1)
    80001802:	f94781e3          	beq	a5,s4,80001784 <wait+0x56>
        release(&pp->lock);
    80001806:	8526                	mv	a0,s1
    80001808:	00005097          	auipc	ra,0x5
    8000180c:	520080e7          	jalr	1312(ra) # 80006d28 <release>
        havekids = 1;
    80001810:	8756                	mv	a4,s5
    80001812:	bfd9                	j	800017e8 <wait+0xba>
    if (!havekids || killed(p)) {
    80001814:	c719                	beqz	a4,80001822 <wait+0xf4>
    80001816:	854a                	mv	a0,s2
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	ee4080e7          	jalr	-284(ra) # 800016fc <killed>
    80001820:	c51d                	beqz	a0,8000184e <wait+0x120>
      release(&wait_lock);
    80001822:	00007517          	auipc	a0,0x7
    80001826:	23650513          	addi	a0,a0,566 # 80008a58 <wait_lock>
    8000182a:	00005097          	auipc	ra,0x5
    8000182e:	4fe080e7          	jalr	1278(ra) # 80006d28 <release>
      return -1;
    80001832:	59fd                	li	s3,-1
}
    80001834:	854e                	mv	a0,s3
    80001836:	60a6                	ld	ra,72(sp)
    80001838:	6406                	ld	s0,64(sp)
    8000183a:	74e2                	ld	s1,56(sp)
    8000183c:	7942                	ld	s2,48(sp)
    8000183e:	79a2                	ld	s3,40(sp)
    80001840:	7a02                	ld	s4,32(sp)
    80001842:	6ae2                	ld	s5,24(sp)
    80001844:	6b42                	ld	s6,16(sp)
    80001846:	6ba2                	ld	s7,8(sp)
    80001848:	6c02                	ld	s8,0(sp)
    8000184a:	6161                	addi	sp,sp,80
    8000184c:	8082                	ret
    sleep(p, &wait_lock);  // DOC: wait-sleep
    8000184e:	85e2                	mv	a1,s8
    80001850:	854a                	mv	a0,s2
    80001852:	00000097          	auipc	ra,0x0
    80001856:	c02080e7          	jalr	-1022(ra) # 80001454 <sleep>
    havekids = 0;
    8000185a:	bf39                	j	80001778 <wait+0x4a>

000000008000185c <either_copyout>:

// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int either_copyout(int user_dst, uint64 dst, void *src, uint64 len) {
    8000185c:	7179                	addi	sp,sp,-48
    8000185e:	f406                	sd	ra,40(sp)
    80001860:	f022                	sd	s0,32(sp)
    80001862:	ec26                	sd	s1,24(sp)
    80001864:	e84a                	sd	s2,16(sp)
    80001866:	e44e                	sd	s3,8(sp)
    80001868:	e052                	sd	s4,0(sp)
    8000186a:	1800                	addi	s0,sp,48
    8000186c:	84aa                	mv	s1,a0
    8000186e:	892e                	mv	s2,a1
    80001870:	89b2                	mv	s3,a2
    80001872:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001874:	fffff097          	auipc	ra,0xfffff
    80001878:	534080e7          	jalr	1332(ra) # 80000da8 <myproc>
  if (user_dst) {
    8000187c:	c08d                	beqz	s1,8000189e <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    8000187e:	86d2                	mv	a3,s4
    80001880:	864e                	mv	a2,s3
    80001882:	85ca                	mv	a1,s2
    80001884:	6928                	ld	a0,80(a0)
    80001886:	fffff097          	auipc	ra,0xfffff
    8000188a:	1aa080e7          	jalr	426(ra) # 80000a30 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8000188e:	70a2                	ld	ra,40(sp)
    80001890:	7402                	ld	s0,32(sp)
    80001892:	64e2                	ld	s1,24(sp)
    80001894:	6942                	ld	s2,16(sp)
    80001896:	69a2                	ld	s3,8(sp)
    80001898:	6a02                	ld	s4,0(sp)
    8000189a:	6145                	addi	sp,sp,48
    8000189c:	8082                	ret
    memmove((char *)dst, src, len);
    8000189e:	000a061b          	sext.w	a2,s4
    800018a2:	85ce                	mv	a1,s3
    800018a4:	854a                	mv	a0,s2
    800018a6:	fffff097          	auipc	ra,0xfffff
    800018aa:	82c080e7          	jalr	-2004(ra) # 800000d2 <memmove>
    return 0;
    800018ae:	8526                	mv	a0,s1
    800018b0:	bff9                	j	8000188e <either_copyout+0x32>

00000000800018b2 <either_copyin>:

// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int either_copyin(void *dst, int user_src, uint64 src, uint64 len) {
    800018b2:	7179                	addi	sp,sp,-48
    800018b4:	f406                	sd	ra,40(sp)
    800018b6:	f022                	sd	s0,32(sp)
    800018b8:	ec26                	sd	s1,24(sp)
    800018ba:	e84a                	sd	s2,16(sp)
    800018bc:	e44e                	sd	s3,8(sp)
    800018be:	e052                	sd	s4,0(sp)
    800018c0:	1800                	addi	s0,sp,48
    800018c2:	892a                	mv	s2,a0
    800018c4:	84ae                	mv	s1,a1
    800018c6:	89b2                	mv	s3,a2
    800018c8:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800018ca:	fffff097          	auipc	ra,0xfffff
    800018ce:	4de080e7          	jalr	1246(ra) # 80000da8 <myproc>
  if (user_src) {
    800018d2:	c08d                	beqz	s1,800018f4 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    800018d4:	86d2                	mv	a3,s4
    800018d6:	864e                	mv	a2,s3
    800018d8:	85ca                	mv	a1,s2
    800018da:	6928                	ld	a0,80(a0)
    800018dc:	fffff097          	auipc	ra,0xfffff
    800018e0:	214080e7          	jalr	532(ra) # 80000af0 <copyin>
  } else {
    memmove(dst, (char *)src, len);
    return 0;
  }
}
    800018e4:	70a2                	ld	ra,40(sp)
    800018e6:	7402                	ld	s0,32(sp)
    800018e8:	64e2                	ld	s1,24(sp)
    800018ea:	6942                	ld	s2,16(sp)
    800018ec:	69a2                	ld	s3,8(sp)
    800018ee:	6a02                	ld	s4,0(sp)
    800018f0:	6145                	addi	sp,sp,48
    800018f2:	8082                	ret
    memmove(dst, (char *)src, len);
    800018f4:	000a061b          	sext.w	a2,s4
    800018f8:	85ce                	mv	a1,s3
    800018fa:	854a                	mv	a0,s2
    800018fc:	ffffe097          	auipc	ra,0xffffe
    80001900:	7d6080e7          	jalr	2006(ra) # 800000d2 <memmove>
    return 0;
    80001904:	8526                	mv	a0,s1
    80001906:	bff9                	j	800018e4 <either_copyin+0x32>

0000000080001908 <procdump>:

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void procdump(void) {
    80001908:	715d                	addi	sp,sp,-80
    8000190a:	e486                	sd	ra,72(sp)
    8000190c:	e0a2                	sd	s0,64(sp)
    8000190e:	fc26                	sd	s1,56(sp)
    80001910:	f84a                	sd	s2,48(sp)
    80001912:	f44e                	sd	s3,40(sp)
    80001914:	f052                	sd	s4,32(sp)
    80001916:	ec56                	sd	s5,24(sp)
    80001918:	e85a                	sd	s6,16(sp)
    8000191a:	e45e                	sd	s7,8(sp)
    8000191c:	0880                	addi	s0,sp,80
      [UNUSED] = "unused",   [USED] = "used",      [SLEEPING] = "sleep ",
      [RUNNABLE] = "runble", [RUNNING] = "run   ", [ZOMBIE] = "zombie"};
  struct proc *p;
  char *state;

  printf("\n");
    8000191e:	00006517          	auipc	a0,0x6
    80001922:	71a50513          	addi	a0,a0,1818 # 80008038 <etext+0x38>
    80001926:	00005097          	auipc	ra,0x5
    8000192a:	e5c080e7          	jalr	-420(ra) # 80006782 <printf>
  for (p = proc; p < &proc[NPROC]; p++) {
    8000192e:	00007497          	auipc	s1,0x7
    80001932:	54248493          	addi	s1,s1,1346 # 80008e70 <proc>
    if (p->state == UNUSED) continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001936:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001938:	00007997          	auipc	s3,0x7
    8000193c:	8f898993          	addi	s3,s3,-1800 # 80008230 <etext+0x230>
    printf("%p %p %d %s %s", p->parent, p, p->pid, state, p->name);
    80001940:	00007a97          	auipc	s5,0x7
    80001944:	8f8a8a93          	addi	s5,s5,-1800 # 80008238 <etext+0x238>
    printf("\n");
    80001948:	00006a17          	auipc	s4,0x6
    8000194c:	6f0a0a13          	addi	s4,s4,1776 # 80008038 <etext+0x38>
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001950:	00007b97          	auipc	s7,0x7
    80001954:	928b8b93          	addi	s7,s7,-1752 # 80008278 <states.0>
  for (p = proc; p < &proc[NPROC]; p++) {
    80001958:	0000d917          	auipc	s2,0xd
    8000195c:	f1890913          	addi	s2,s2,-232 # 8000e870 <tickslock>
    80001960:	a025                	j	80001988 <procdump+0x80>
    printf("%p %p %d %s %s", p->parent, p, p->pid, state, p->name);
    80001962:	15848793          	addi	a5,s1,344
    80001966:	5894                	lw	a3,48(s1)
    80001968:	8626                	mv	a2,s1
    8000196a:	7c8c                	ld	a1,56(s1)
    8000196c:	8556                	mv	a0,s5
    8000196e:	00005097          	auipc	ra,0x5
    80001972:	e14080e7          	jalr	-492(ra) # 80006782 <printf>
    printf("\n");
    80001976:	8552                	mv	a0,s4
    80001978:	00005097          	auipc	ra,0x5
    8000197c:	e0a080e7          	jalr	-502(ra) # 80006782 <printf>
  for (p = proc; p < &proc[NPROC]; p++) {
    80001980:	16848493          	addi	s1,s1,360
    80001984:	01248f63          	beq	s1,s2,800019a2 <procdump+0x9a>
    if (p->state == UNUSED) continue;
    80001988:	4c9c                	lw	a5,24(s1)
    8000198a:	dbfd                	beqz	a5,80001980 <procdump+0x78>
      state = "???";
    8000198c:	874e                	mv	a4,s3
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000198e:	fcfb6ae3          	bltu	s6,a5,80001962 <procdump+0x5a>
    80001992:	1782                	slli	a5,a5,0x20
    80001994:	9381                	srli	a5,a5,0x20
    80001996:	078e                	slli	a5,a5,0x3
    80001998:	97de                	add	a5,a5,s7
    8000199a:	6398                	ld	a4,0(a5)
    8000199c:	f379                	bnez	a4,80001962 <procdump+0x5a>
      state = "???";
    8000199e:	874e                	mv	a4,s3
    800019a0:	b7c9                	j	80001962 <procdump+0x5a>
  }
}
    800019a2:	60a6                	ld	ra,72(sp)
    800019a4:	6406                	ld	s0,64(sp)
    800019a6:	74e2                	ld	s1,56(sp)
    800019a8:	7942                	ld	s2,48(sp)
    800019aa:	79a2                	ld	s3,40(sp)
    800019ac:	7a02                	ld	s4,32(sp)
    800019ae:	6ae2                	ld	s5,24(sp)
    800019b0:	6b42                	ld	s6,16(sp)
    800019b2:	6ba2                	ld	s7,8(sp)
    800019b4:	6161                	addi	sp,sp,80
    800019b6:	8082                	ret

00000000800019b8 <swtch>:
    800019b8:	00153023          	sd	ra,0(a0)
    800019bc:	00253423          	sd	sp,8(a0)
    800019c0:	e900                	sd	s0,16(a0)
    800019c2:	ed04                	sd	s1,24(a0)
    800019c4:	03253023          	sd	s2,32(a0)
    800019c8:	03353423          	sd	s3,40(a0)
    800019cc:	03453823          	sd	s4,48(a0)
    800019d0:	03553c23          	sd	s5,56(a0)
    800019d4:	05653023          	sd	s6,64(a0)
    800019d8:	05753423          	sd	s7,72(a0)
    800019dc:	05853823          	sd	s8,80(a0)
    800019e0:	05953c23          	sd	s9,88(a0)
    800019e4:	07a53023          	sd	s10,96(a0)
    800019e8:	07b53423          	sd	s11,104(a0)
    800019ec:	0005b083          	ld	ra,0(a1)
    800019f0:	0085b103          	ld	sp,8(a1)
    800019f4:	6980                	ld	s0,16(a1)
    800019f6:	6d84                	ld	s1,24(a1)
    800019f8:	0205b903          	ld	s2,32(a1)
    800019fc:	0285b983          	ld	s3,40(a1)
    80001a00:	0305ba03          	ld	s4,48(a1)
    80001a04:	0385ba83          	ld	s5,56(a1)
    80001a08:	0405bb03          	ld	s6,64(a1)
    80001a0c:	0485bb83          	ld	s7,72(a1)
    80001a10:	0505bc03          	ld	s8,80(a1)
    80001a14:	0585bc83          	ld	s9,88(a1)
    80001a18:	0605bd03          	ld	s10,96(a1)
    80001a1c:	0685bd83          	ld	s11,104(a1)
    80001a20:	8082                	ret

0000000080001a22 <trapinit>:
// in kernelvec.S, calls kerneltrap().
void kernelvec();

extern int devintr();

void trapinit(void) { initlock(&tickslock, "time"); }
    80001a22:	1141                	addi	sp,sp,-16
    80001a24:	e406                	sd	ra,8(sp)
    80001a26:	e022                	sd	s0,0(sp)
    80001a28:	0800                	addi	s0,sp,16
    80001a2a:	00007597          	auipc	a1,0x7
    80001a2e:	87e58593          	addi	a1,a1,-1922 # 800082a8 <states.0+0x30>
    80001a32:	0000d517          	auipc	a0,0xd
    80001a36:	e3e50513          	addi	a0,a0,-450 # 8000e870 <tickslock>
    80001a3a:	00005097          	auipc	ra,0x5
    80001a3e:	1aa080e7          	jalr	426(ra) # 80006be4 <initlock>
    80001a42:	60a2                	ld	ra,8(sp)
    80001a44:	6402                	ld	s0,0(sp)
    80001a46:	0141                	addi	sp,sp,16
    80001a48:	8082                	ret

0000000080001a4a <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void trapinithart(void) { w_stvec((uint64)kernelvec); }
    80001a4a:	1141                	addi	sp,sp,-16
    80001a4c:	e422                	sd	s0,8(sp)
    80001a4e:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r"(x));
    80001a50:	00003797          	auipc	a5,0x3
    80001a54:	45078793          	addi	a5,a5,1104 # 80004ea0 <kernelvec>
    80001a58:	10579073          	csrw	stvec,a5
    80001a5c:	6422                	ld	s0,8(sp)
    80001a5e:	0141                	addi	sp,sp,16
    80001a60:	8082                	ret

0000000080001a62 <usertrapret>:
}

//
// return to user space
//
void usertrapret(void) {
    80001a62:	1141                	addi	sp,sp,-16
    80001a64:	e406                	sd	ra,8(sp)
    80001a66:	e022                	sd	s0,0(sp)
    80001a68:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001a6a:	fffff097          	auipc	ra,0xfffff
    80001a6e:	33e080e7          	jalr	830(ra) # 80000da8 <myproc>
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80001a72:	100027f3          	csrr	a5,sstatus
static inline void intr_off() { w_sstatus(r_sstatus() & ~SSTATUS_SIE); }
    80001a76:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r"(x));
    80001a78:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001a7c:	00005617          	auipc	a2,0x5
    80001a80:	58460613          	addi	a2,a2,1412 # 80007000 <_trampoline>
    80001a84:	00005697          	auipc	a3,0x5
    80001a88:	57c68693          	addi	a3,a3,1404 # 80007000 <_trampoline>
    80001a8c:	8e91                	sub	a3,a3,a2
    80001a8e:	040007b7          	lui	a5,0x4000
    80001a92:	17fd                	addi	a5,a5,-1
    80001a94:	07b2                	slli	a5,a5,0xc
    80001a96:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r"(x));
    80001a98:	10569073          	csrw	stvec,a3
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();          // kernel page table
    80001a9c:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r"(x));
    80001a9e:	180026f3          	csrr	a3,satp
    80001aa2:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE;  // process's kernel stack
    80001aa4:	6d38                	ld	a4,88(a0)
    80001aa6:	6134                	ld	a3,64(a0)
    80001aa8:	6585                	lui	a1,0x1
    80001aaa:	96ae                	add	a3,a3,a1
    80001aac:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001aae:	6d38                	ld	a4,88(a0)
    80001ab0:	00000697          	auipc	a3,0x0
    80001ab4:	13068693          	addi	a3,a3,304 # 80001be0 <usertrap>
    80001ab8:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();  // hartid for cpuid()
    80001aba:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r"(x));
    80001abc:	8692                	mv	a3,tp
    80001abe:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80001ac0:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.

  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP;  // clear SPP to 0 for user mode
    80001ac4:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE;  // enable interrupts in user mode
    80001ac8:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r"(x));
    80001acc:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001ad0:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r"(x));
    80001ad2:	6f18                	ld	a4,24(a4)
    80001ad4:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001ad8:	6928                	ld	a0,80(a0)
    80001ada:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001adc:	00005717          	auipc	a4,0x5
    80001ae0:	5c070713          	addi	a4,a4,1472 # 8000709c <userret>
    80001ae4:	8f11                	sub	a4,a4,a2
    80001ae6:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80001ae8:	577d                	li	a4,-1
    80001aea:	177e                	slli	a4,a4,0x3f
    80001aec:	8d59                	or	a0,a0,a4
    80001aee:	9782                	jalr	a5
}
    80001af0:	60a2                	ld	ra,8(sp)
    80001af2:	6402                	ld	s0,0(sp)
    80001af4:	0141                	addi	sp,sp,16
    80001af6:	8082                	ret

0000000080001af8 <clockintr>:
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
  w_sstatus(sstatus);
}

void clockintr() {
    80001af8:	1101                	addi	sp,sp,-32
    80001afa:	ec06                	sd	ra,24(sp)
    80001afc:	e822                	sd	s0,16(sp)
    80001afe:	e426                	sd	s1,8(sp)
    80001b00:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001b02:	0000d497          	auipc	s1,0xd
    80001b06:	d6e48493          	addi	s1,s1,-658 # 8000e870 <tickslock>
    80001b0a:	8526                	mv	a0,s1
    80001b0c:	00005097          	auipc	ra,0x5
    80001b10:	168080e7          	jalr	360(ra) # 80006c74 <acquire>
  ticks++;
    80001b14:	00007517          	auipc	a0,0x7
    80001b18:	ef450513          	addi	a0,a0,-268 # 80008a08 <ticks>
    80001b1c:	411c                	lw	a5,0(a0)
    80001b1e:	2785                	addiw	a5,a5,1
    80001b20:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001b22:	00000097          	auipc	ra,0x0
    80001b26:	996080e7          	jalr	-1642(ra) # 800014b8 <wakeup>
  release(&tickslock);
    80001b2a:	8526                	mv	a0,s1
    80001b2c:	00005097          	auipc	ra,0x5
    80001b30:	1fc080e7          	jalr	508(ra) # 80006d28 <release>
}
    80001b34:	60e2                	ld	ra,24(sp)
    80001b36:	6442                	ld	s0,16(sp)
    80001b38:	64a2                	ld	s1,8(sp)
    80001b3a:	6105                	addi	sp,sp,32
    80001b3c:	8082                	ret

0000000080001b3e <devintr>:
// check if it's an external interrupt or software interrupt,
// and handle it.
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int devintr() {
    80001b3e:	1101                	addi	sp,sp,-32
    80001b40:	ec06                	sd	ra,24(sp)
    80001b42:	e822                	sd	s0,16(sp)
    80001b44:	e426                	sd	s1,8(sp)
    80001b46:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r"(x));
    80001b48:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if ((scause & 0x8000000000000000L) && (scause & 0xff) == 9) {
    80001b4c:	00074d63          	bltz	a4,80001b66 <devintr+0x28>
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if (irq) plic_complete(irq);

    return 1;
  } else if (scause == 0x8000000000000001L) {
    80001b50:	57fd                	li	a5,-1
    80001b52:	17fe                	slli	a5,a5,0x3f
    80001b54:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001b56:	4501                	li	a0,0
  } else if (scause == 0x8000000000000001L) {
    80001b58:	06f70363          	beq	a4,a5,80001bbe <devintr+0x80>
  }
}
    80001b5c:	60e2                	ld	ra,24(sp)
    80001b5e:	6442                	ld	s0,16(sp)
    80001b60:	64a2                	ld	s1,8(sp)
    80001b62:	6105                	addi	sp,sp,32
    80001b64:	8082                	ret
  if ((scause & 0x8000000000000000L) && (scause & 0xff) == 9) {
    80001b66:	0ff77793          	andi	a5,a4,255
    80001b6a:	46a5                	li	a3,9
    80001b6c:	fed792e3          	bne	a5,a3,80001b50 <devintr+0x12>
    int irq = plic_claim();
    80001b70:	00003097          	auipc	ra,0x3
    80001b74:	438080e7          	jalr	1080(ra) # 80004fa8 <plic_claim>
    80001b78:	84aa                	mv	s1,a0
    if (irq == UART0_IRQ) {
    80001b7a:	47a9                	li	a5,10
    80001b7c:	02f50763          	beq	a0,a5,80001baa <devintr+0x6c>
    } else if (irq == VIRTIO0_IRQ) {
    80001b80:	4785                	li	a5,1
    80001b82:	02f50963          	beq	a0,a5,80001bb4 <devintr+0x76>
    return 1;
    80001b86:	4505                	li	a0,1
    } else if (irq) {
    80001b88:	d8f1                	beqz	s1,80001b5c <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001b8a:	85a6                	mv	a1,s1
    80001b8c:	00006517          	auipc	a0,0x6
    80001b90:	72450513          	addi	a0,a0,1828 # 800082b0 <states.0+0x38>
    80001b94:	00005097          	auipc	ra,0x5
    80001b98:	bee080e7          	jalr	-1042(ra) # 80006782 <printf>
    if (irq) plic_complete(irq);
    80001b9c:	8526                	mv	a0,s1
    80001b9e:	00003097          	auipc	ra,0x3
    80001ba2:	42e080e7          	jalr	1070(ra) # 80004fcc <plic_complete>
    return 1;
    80001ba6:	4505                	li	a0,1
    80001ba8:	bf55                	j	80001b5c <devintr+0x1e>
      uartintr();
    80001baa:	00005097          	auipc	ra,0x5
    80001bae:	fea080e7          	jalr	-22(ra) # 80006b94 <uartintr>
    80001bb2:	b7ed                	j	80001b9c <devintr+0x5e>
      virtio_disk_intr();
    80001bb4:	00004097          	auipc	ra,0x4
    80001bb8:	8e4080e7          	jalr	-1820(ra) # 80005498 <virtio_disk_intr>
    80001bbc:	b7c5                	j	80001b9c <devintr+0x5e>
    if (cpuid() == 0) {
    80001bbe:	fffff097          	auipc	ra,0xfffff
    80001bc2:	1be080e7          	jalr	446(ra) # 80000d7c <cpuid>
    80001bc6:	c901                	beqz	a0,80001bd6 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r"(x));
    80001bc8:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001bcc:	9bf5                	andi	a5,a5,-3
static inline void w_sip(uint64 x) { asm volatile("csrw sip, %0" : : "r"(x)); }
    80001bce:	14479073          	csrw	sip,a5
    return 2;
    80001bd2:	4509                	li	a0,2
    80001bd4:	b761                	j	80001b5c <devintr+0x1e>
      clockintr();
    80001bd6:	00000097          	auipc	ra,0x0
    80001bda:	f22080e7          	jalr	-222(ra) # 80001af8 <clockintr>
    80001bde:	b7ed                	j	80001bc8 <devintr+0x8a>

0000000080001be0 <usertrap>:
void usertrap(void) {
    80001be0:	1101                	addi	sp,sp,-32
    80001be2:	ec06                	sd	ra,24(sp)
    80001be4:	e822                	sd	s0,16(sp)
    80001be6:	e426                	sd	s1,8(sp)
    80001be8:	e04a                	sd	s2,0(sp)
    80001bea:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80001bec:	100027f3          	csrr	a5,sstatus
  if ((r_sstatus() & SSTATUS_SPP) != 0) panic("usertrap: not from user mode");
    80001bf0:	1007f793          	andi	a5,a5,256
    80001bf4:	e3b1                	bnez	a5,80001c38 <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r"(x));
    80001bf6:	00003797          	auipc	a5,0x3
    80001bfa:	2aa78793          	addi	a5,a5,682 # 80004ea0 <kernelvec>
    80001bfe:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001c02:	fffff097          	auipc	ra,0xfffff
    80001c06:	1a6080e7          	jalr	422(ra) # 80000da8 <myproc>
    80001c0a:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001c0c:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r"(x));
    80001c0e:	14102773          	csrr	a4,sepc
    80001c12:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r"(x));
    80001c14:	14202773          	csrr	a4,scause
  if (r_scause() == 8) {
    80001c18:	47a1                	li	a5,8
    80001c1a:	02f70763          	beq	a4,a5,80001c48 <usertrap+0x68>
  } else if ((which_dev = devintr()) != 0) {
    80001c1e:	00000097          	auipc	ra,0x0
    80001c22:	f20080e7          	jalr	-224(ra) # 80001b3e <devintr>
    80001c26:	892a                	mv	s2,a0
    80001c28:	c151                	beqz	a0,80001cac <usertrap+0xcc>
  if (killed(p)) exit(-1);
    80001c2a:	8526                	mv	a0,s1
    80001c2c:	00000097          	auipc	ra,0x0
    80001c30:	ad0080e7          	jalr	-1328(ra) # 800016fc <killed>
    80001c34:	c929                	beqz	a0,80001c86 <usertrap+0xa6>
    80001c36:	a099                	j	80001c7c <usertrap+0x9c>
  if ((r_sstatus() & SSTATUS_SPP) != 0) panic("usertrap: not from user mode");
    80001c38:	00006517          	auipc	a0,0x6
    80001c3c:	69850513          	addi	a0,a0,1688 # 800082d0 <states.0+0x58>
    80001c40:	00005097          	auipc	ra,0x5
    80001c44:	af8080e7          	jalr	-1288(ra) # 80006738 <panic>
    if (killed(p)) exit(-1);
    80001c48:	00000097          	auipc	ra,0x0
    80001c4c:	ab4080e7          	jalr	-1356(ra) # 800016fc <killed>
    80001c50:	e921                	bnez	a0,80001ca0 <usertrap+0xc0>
    p->trapframe->epc += 4;
    80001c52:	6cb8                	ld	a4,88(s1)
    80001c54:	6f1c                	ld	a5,24(a4)
    80001c56:	0791                	addi	a5,a5,4
    80001c58:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80001c5a:	100027f3          	csrr	a5,sstatus
static inline void intr_on() { w_sstatus(r_sstatus() | SSTATUS_SIE); }
    80001c5e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r"(x));
    80001c62:	10079073          	csrw	sstatus,a5
    syscall();
    80001c66:	00000097          	auipc	ra,0x0
    80001c6a:	2d4080e7          	jalr	724(ra) # 80001f3a <syscall>
  if (killed(p)) exit(-1);
    80001c6e:	8526                	mv	a0,s1
    80001c70:	00000097          	auipc	ra,0x0
    80001c74:	a8c080e7          	jalr	-1396(ra) # 800016fc <killed>
    80001c78:	c911                	beqz	a0,80001c8c <usertrap+0xac>
    80001c7a:	4901                	li	s2,0
    80001c7c:	557d                	li	a0,-1
    80001c7e:	00000097          	auipc	ra,0x0
    80001c82:	90a080e7          	jalr	-1782(ra) # 80001588 <exit>
  if (which_dev == 2) yield();
    80001c86:	4789                	li	a5,2
    80001c88:	04f90f63          	beq	s2,a5,80001ce6 <usertrap+0x106>
  usertrapret();
    80001c8c:	00000097          	auipc	ra,0x0
    80001c90:	dd6080e7          	jalr	-554(ra) # 80001a62 <usertrapret>
}
    80001c94:	60e2                	ld	ra,24(sp)
    80001c96:	6442                	ld	s0,16(sp)
    80001c98:	64a2                	ld	s1,8(sp)
    80001c9a:	6902                	ld	s2,0(sp)
    80001c9c:	6105                	addi	sp,sp,32
    80001c9e:	8082                	ret
    if (killed(p)) exit(-1);
    80001ca0:	557d                	li	a0,-1
    80001ca2:	00000097          	auipc	ra,0x0
    80001ca6:	8e6080e7          	jalr	-1818(ra) # 80001588 <exit>
    80001caa:	b765                	j	80001c52 <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r"(x));
    80001cac:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001cb0:	5890                	lw	a2,48(s1)
    80001cb2:	00006517          	auipc	a0,0x6
    80001cb6:	63e50513          	addi	a0,a0,1598 # 800082f0 <states.0+0x78>
    80001cba:	00005097          	auipc	ra,0x5
    80001cbe:	ac8080e7          	jalr	-1336(ra) # 80006782 <printf>
  asm volatile("csrr %0, sepc" : "=r"(x));
    80001cc2:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r"(x));
    80001cc6:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001cca:	00006517          	auipc	a0,0x6
    80001cce:	65650513          	addi	a0,a0,1622 # 80008320 <states.0+0xa8>
    80001cd2:	00005097          	auipc	ra,0x5
    80001cd6:	ab0080e7          	jalr	-1360(ra) # 80006782 <printf>
    setkilled(p);
    80001cda:	8526                	mv	a0,s1
    80001cdc:	00000097          	auipc	ra,0x0
    80001ce0:	9f4080e7          	jalr	-1548(ra) # 800016d0 <setkilled>
    80001ce4:	b769                	j	80001c6e <usertrap+0x8e>
  if (which_dev == 2) yield();
    80001ce6:	fffff097          	auipc	ra,0xfffff
    80001cea:	732080e7          	jalr	1842(ra) # 80001418 <yield>
    80001cee:	bf79                	j	80001c8c <usertrap+0xac>

0000000080001cf0 <kerneltrap>:
void kerneltrap() {
    80001cf0:	7179                	addi	sp,sp,-48
    80001cf2:	f406                	sd	ra,40(sp)
    80001cf4:	f022                	sd	s0,32(sp)
    80001cf6:	ec26                	sd	s1,24(sp)
    80001cf8:	e84a                	sd	s2,16(sp)
    80001cfa:	e44e                	sd	s3,8(sp)
    80001cfc:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r"(x));
    80001cfe:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80001d02:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r"(x));
    80001d06:	142029f3          	csrr	s3,scause
  if ((sstatus & SSTATUS_SPP) == 0)
    80001d0a:	1004f793          	andi	a5,s1,256
    80001d0e:	cb85                	beqz	a5,80001d3e <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80001d10:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001d14:	8b89                	andi	a5,a5,2
  if (intr_get() != 0) panic("kerneltrap: interrupts enabled");
    80001d16:	ef85                	bnez	a5,80001d4e <kerneltrap+0x5e>
  if ((which_dev = devintr()) == 0) {
    80001d18:	00000097          	auipc	ra,0x0
    80001d1c:	e26080e7          	jalr	-474(ra) # 80001b3e <devintr>
    80001d20:	cd1d                	beqz	a0,80001d5e <kerneltrap+0x6e>
  if (which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) yield();
    80001d22:	4789                	li	a5,2
    80001d24:	06f50a63          	beq	a0,a5,80001d98 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r"(x));
    80001d28:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r"(x));
    80001d2c:	10049073          	csrw	sstatus,s1
}
    80001d30:	70a2                	ld	ra,40(sp)
    80001d32:	7402                	ld	s0,32(sp)
    80001d34:	64e2                	ld	s1,24(sp)
    80001d36:	6942                	ld	s2,16(sp)
    80001d38:	69a2                	ld	s3,8(sp)
    80001d3a:	6145                	addi	sp,sp,48
    80001d3c:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001d3e:	00006517          	auipc	a0,0x6
    80001d42:	60250513          	addi	a0,a0,1538 # 80008340 <states.0+0xc8>
    80001d46:	00005097          	auipc	ra,0x5
    80001d4a:	9f2080e7          	jalr	-1550(ra) # 80006738 <panic>
  if (intr_get() != 0) panic("kerneltrap: interrupts enabled");
    80001d4e:	00006517          	auipc	a0,0x6
    80001d52:	61a50513          	addi	a0,a0,1562 # 80008368 <states.0+0xf0>
    80001d56:	00005097          	auipc	ra,0x5
    80001d5a:	9e2080e7          	jalr	-1566(ra) # 80006738 <panic>
    printf("scause %p\n", scause);
    80001d5e:	85ce                	mv	a1,s3
    80001d60:	00006517          	auipc	a0,0x6
    80001d64:	62850513          	addi	a0,a0,1576 # 80008388 <states.0+0x110>
    80001d68:	00005097          	auipc	ra,0x5
    80001d6c:	a1a080e7          	jalr	-1510(ra) # 80006782 <printf>
  asm volatile("csrr %0, sepc" : "=r"(x));
    80001d70:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r"(x));
    80001d74:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001d78:	00006517          	auipc	a0,0x6
    80001d7c:	62050513          	addi	a0,a0,1568 # 80008398 <states.0+0x120>
    80001d80:	00005097          	auipc	ra,0x5
    80001d84:	a02080e7          	jalr	-1534(ra) # 80006782 <printf>
    panic("kerneltrap");
    80001d88:	00006517          	auipc	a0,0x6
    80001d8c:	62850513          	addi	a0,a0,1576 # 800083b0 <states.0+0x138>
    80001d90:	00005097          	auipc	ra,0x5
    80001d94:	9a8080e7          	jalr	-1624(ra) # 80006738 <panic>
  if (which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) yield();
    80001d98:	fffff097          	auipc	ra,0xfffff
    80001d9c:	010080e7          	jalr	16(ra) # 80000da8 <myproc>
    80001da0:	d541                	beqz	a0,80001d28 <kerneltrap+0x38>
    80001da2:	fffff097          	auipc	ra,0xfffff
    80001da6:	006080e7          	jalr	6(ra) # 80000da8 <myproc>
    80001daa:	4d18                	lw	a4,24(a0)
    80001dac:	4791                	li	a5,4
    80001dae:	f6f71de3          	bne	a4,a5,80001d28 <kerneltrap+0x38>
    80001db2:	fffff097          	auipc	ra,0xfffff
    80001db6:	666080e7          	jalr	1638(ra) # 80001418 <yield>
    80001dba:	b7bd                	j	80001d28 <kerneltrap+0x38>

0000000080001dbc <argraw>:
  struct proc *p = myproc();
  if (copyinstr(p->pagetable, buf, addr, max) < 0) return -1;
  return strlen(buf);
}

static uint64 argraw(int n) {
    80001dbc:	1101                	addi	sp,sp,-32
    80001dbe:	ec06                	sd	ra,24(sp)
    80001dc0:	e822                	sd	s0,16(sp)
    80001dc2:	e426                	sd	s1,8(sp)
    80001dc4:	1000                	addi	s0,sp,32
    80001dc6:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001dc8:	fffff097          	auipc	ra,0xfffff
    80001dcc:	fe0080e7          	jalr	-32(ra) # 80000da8 <myproc>
  switch (n) {
    80001dd0:	4795                	li	a5,5
    80001dd2:	0497e163          	bltu	a5,s1,80001e14 <argraw+0x58>
    80001dd6:	048a                	slli	s1,s1,0x2
    80001dd8:	00006717          	auipc	a4,0x6
    80001ddc:	61070713          	addi	a4,a4,1552 # 800083e8 <states.0+0x170>
    80001de0:	94ba                	add	s1,s1,a4
    80001de2:	409c                	lw	a5,0(s1)
    80001de4:	97ba                	add	a5,a5,a4
    80001de6:	8782                	jr	a5
    case 0:
      return p->trapframe->a0;
    80001de8:	6d3c                	ld	a5,88(a0)
    80001dea:	7ba8                	ld	a0,112(a5)
    case 5:
      return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001dec:	60e2                	ld	ra,24(sp)
    80001dee:	6442                	ld	s0,16(sp)
    80001df0:	64a2                	ld	s1,8(sp)
    80001df2:	6105                	addi	sp,sp,32
    80001df4:	8082                	ret
      return p->trapframe->a1;
    80001df6:	6d3c                	ld	a5,88(a0)
    80001df8:	7fa8                	ld	a0,120(a5)
    80001dfa:	bfcd                	j	80001dec <argraw+0x30>
      return p->trapframe->a2;
    80001dfc:	6d3c                	ld	a5,88(a0)
    80001dfe:	63c8                	ld	a0,128(a5)
    80001e00:	b7f5                	j	80001dec <argraw+0x30>
      return p->trapframe->a3;
    80001e02:	6d3c                	ld	a5,88(a0)
    80001e04:	67c8                	ld	a0,136(a5)
    80001e06:	b7dd                	j	80001dec <argraw+0x30>
      return p->trapframe->a4;
    80001e08:	6d3c                	ld	a5,88(a0)
    80001e0a:	6bc8                	ld	a0,144(a5)
    80001e0c:	b7c5                	j	80001dec <argraw+0x30>
      return p->trapframe->a5;
    80001e0e:	6d3c                	ld	a5,88(a0)
    80001e10:	6fc8                	ld	a0,152(a5)
    80001e12:	bfe9                	j	80001dec <argraw+0x30>
  panic("argraw");
    80001e14:	00006517          	auipc	a0,0x6
    80001e18:	5ac50513          	addi	a0,a0,1452 # 800083c0 <states.0+0x148>
    80001e1c:	00005097          	auipc	ra,0x5
    80001e20:	91c080e7          	jalr	-1764(ra) # 80006738 <panic>

0000000080001e24 <fetchaddr>:
int fetchaddr(uint64 addr, uint64 *ip) {
    80001e24:	1101                	addi	sp,sp,-32
    80001e26:	ec06                	sd	ra,24(sp)
    80001e28:	e822                	sd	s0,16(sp)
    80001e2a:	e426                	sd	s1,8(sp)
    80001e2c:	e04a                	sd	s2,0(sp)
    80001e2e:	1000                	addi	s0,sp,32
    80001e30:	84aa                	mv	s1,a0
    80001e32:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001e34:	fffff097          	auipc	ra,0xfffff
    80001e38:	f74080e7          	jalr	-140(ra) # 80000da8 <myproc>
  if (addr >= p->sz ||
    80001e3c:	653c                	ld	a5,72(a0)
    80001e3e:	02f4f863          	bgeu	s1,a5,80001e6e <fetchaddr+0x4a>
      addr + sizeof(uint64) > p->sz)  // both tests needed, in case of overflow
    80001e42:	00848713          	addi	a4,s1,8
  if (addr >= p->sz ||
    80001e46:	02e7e663          	bltu	a5,a4,80001e72 <fetchaddr+0x4e>
  if (copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0) return -1;
    80001e4a:	46a1                	li	a3,8
    80001e4c:	8626                	mv	a2,s1
    80001e4e:	85ca                	mv	a1,s2
    80001e50:	6928                	ld	a0,80(a0)
    80001e52:	fffff097          	auipc	ra,0xfffff
    80001e56:	c9e080e7          	jalr	-866(ra) # 80000af0 <copyin>
    80001e5a:	00a03533          	snez	a0,a0
    80001e5e:	40a00533          	neg	a0,a0
}
    80001e62:	60e2                	ld	ra,24(sp)
    80001e64:	6442                	ld	s0,16(sp)
    80001e66:	64a2                	ld	s1,8(sp)
    80001e68:	6902                	ld	s2,0(sp)
    80001e6a:	6105                	addi	sp,sp,32
    80001e6c:	8082                	ret
    return -1;
    80001e6e:	557d                	li	a0,-1
    80001e70:	bfcd                	j	80001e62 <fetchaddr+0x3e>
    80001e72:	557d                	li	a0,-1
    80001e74:	b7fd                	j	80001e62 <fetchaddr+0x3e>

0000000080001e76 <fetchstr>:
int fetchstr(uint64 addr, char *buf, int max) {
    80001e76:	7179                	addi	sp,sp,-48
    80001e78:	f406                	sd	ra,40(sp)
    80001e7a:	f022                	sd	s0,32(sp)
    80001e7c:	ec26                	sd	s1,24(sp)
    80001e7e:	e84a                	sd	s2,16(sp)
    80001e80:	e44e                	sd	s3,8(sp)
    80001e82:	1800                	addi	s0,sp,48
    80001e84:	892a                	mv	s2,a0
    80001e86:	84ae                	mv	s1,a1
    80001e88:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001e8a:	fffff097          	auipc	ra,0xfffff
    80001e8e:	f1e080e7          	jalr	-226(ra) # 80000da8 <myproc>
  if (copyinstr(p->pagetable, buf, addr, max) < 0) return -1;
    80001e92:	86ce                	mv	a3,s3
    80001e94:	864a                	mv	a2,s2
    80001e96:	85a6                	mv	a1,s1
    80001e98:	6928                	ld	a0,80(a0)
    80001e9a:	fffff097          	auipc	ra,0xfffff
    80001e9e:	ce4080e7          	jalr	-796(ra) # 80000b7e <copyinstr>
    80001ea2:	00054e63          	bltz	a0,80001ebe <fetchstr+0x48>
  return strlen(buf);
    80001ea6:	8526                	mv	a0,s1
    80001ea8:	ffffe097          	auipc	ra,0xffffe
    80001eac:	34a080e7          	jalr	842(ra) # 800001f2 <strlen>
}
    80001eb0:	70a2                	ld	ra,40(sp)
    80001eb2:	7402                	ld	s0,32(sp)
    80001eb4:	64e2                	ld	s1,24(sp)
    80001eb6:	6942                	ld	s2,16(sp)
    80001eb8:	69a2                	ld	s3,8(sp)
    80001eba:	6145                	addi	sp,sp,48
    80001ebc:	8082                	ret
  if (copyinstr(p->pagetable, buf, addr, max) < 0) return -1;
    80001ebe:	557d                	li	a0,-1
    80001ec0:	bfc5                	j	80001eb0 <fetchstr+0x3a>

0000000080001ec2 <argint>:

// Fetch the nth 32-bit system call argument.
void argint(int n, int *ip) { *ip = argraw(n); }
    80001ec2:	1101                	addi	sp,sp,-32
    80001ec4:	ec06                	sd	ra,24(sp)
    80001ec6:	e822                	sd	s0,16(sp)
    80001ec8:	e426                	sd	s1,8(sp)
    80001eca:	1000                	addi	s0,sp,32
    80001ecc:	84ae                	mv	s1,a1
    80001ece:	00000097          	auipc	ra,0x0
    80001ed2:	eee080e7          	jalr	-274(ra) # 80001dbc <argraw>
    80001ed6:	c088                	sw	a0,0(s1)
    80001ed8:	60e2                	ld	ra,24(sp)
    80001eda:	6442                	ld	s0,16(sp)
    80001edc:	64a2                	ld	s1,8(sp)
    80001ede:	6105                	addi	sp,sp,32
    80001ee0:	8082                	ret

0000000080001ee2 <argaddr>:

// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void argaddr(int n, uint64 *ip) { *ip = argraw(n); }
    80001ee2:	1101                	addi	sp,sp,-32
    80001ee4:	ec06                	sd	ra,24(sp)
    80001ee6:	e822                	sd	s0,16(sp)
    80001ee8:	e426                	sd	s1,8(sp)
    80001eea:	1000                	addi	s0,sp,32
    80001eec:	84ae                	mv	s1,a1
    80001eee:	00000097          	auipc	ra,0x0
    80001ef2:	ece080e7          	jalr	-306(ra) # 80001dbc <argraw>
    80001ef6:	e088                	sd	a0,0(s1)
    80001ef8:	60e2                	ld	ra,24(sp)
    80001efa:	6442                	ld	s0,16(sp)
    80001efc:	64a2                	ld	s1,8(sp)
    80001efe:	6105                	addi	sp,sp,32
    80001f00:	8082                	ret

0000000080001f02 <argstr>:

// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int argstr(int n, char *buf, int max) {
    80001f02:	7179                	addi	sp,sp,-48
    80001f04:	f406                	sd	ra,40(sp)
    80001f06:	f022                	sd	s0,32(sp)
    80001f08:	ec26                	sd	s1,24(sp)
    80001f0a:	e84a                	sd	s2,16(sp)
    80001f0c:	1800                	addi	s0,sp,48
    80001f0e:	84ae                	mv	s1,a1
    80001f10:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    80001f12:	fd840593          	addi	a1,s0,-40
    80001f16:	00000097          	auipc	ra,0x0
    80001f1a:	fcc080e7          	jalr	-52(ra) # 80001ee2 <argaddr>
  return fetchstr(addr, buf, max);
    80001f1e:	864a                	mv	a2,s2
    80001f20:	85a6                	mv	a1,s1
    80001f22:	fd843503          	ld	a0,-40(s0)
    80001f26:	00000097          	auipc	ra,0x0
    80001f2a:	f50080e7          	jalr	-176(ra) # 80001e76 <fetchstr>
}
    80001f2e:	70a2                	ld	ra,40(sp)
    80001f30:	7402                	ld	s0,32(sp)
    80001f32:	64e2                	ld	s1,24(sp)
    80001f34:	6942                	ld	s2,16(sp)
    80001f36:	6145                	addi	sp,sp,48
    80001f38:	8082                	ret

0000000080001f3a <syscall>:
    [SYS_mknod] = sys_mknod,   [SYS_unlink] = sys_unlink,
    [SYS_link] = sys_link,     [SYS_mkdir] = sys_mkdir,
    [SYS_close] = sys_close,
};

void syscall(void) {
    80001f3a:	1101                	addi	sp,sp,-32
    80001f3c:	ec06                	sd	ra,24(sp)
    80001f3e:	e822                	sd	s0,16(sp)
    80001f40:	e426                	sd	s1,8(sp)
    80001f42:	e04a                	sd	s2,0(sp)
    80001f44:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80001f46:	fffff097          	auipc	ra,0xfffff
    80001f4a:	e62080e7          	jalr	-414(ra) # 80000da8 <myproc>
    80001f4e:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001f50:	05853903          	ld	s2,88(a0)
    80001f54:	0a893783          	ld	a5,168(s2)
    80001f58:	0007869b          	sext.w	a3,a5
  if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80001f5c:	37fd                	addiw	a5,a5,-1
    80001f5e:	4751                	li	a4,20
    80001f60:	00f76f63          	bltu	a4,a5,80001f7e <syscall+0x44>
    80001f64:	00369713          	slli	a4,a3,0x3
    80001f68:	00006797          	auipc	a5,0x6
    80001f6c:	49878793          	addi	a5,a5,1176 # 80008400 <syscalls>
    80001f70:	97ba                	add	a5,a5,a4
    80001f72:	639c                	ld	a5,0(a5)
    80001f74:	c789                	beqz	a5,80001f7e <syscall+0x44>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80001f76:	9782                	jalr	a5
    80001f78:	06a93823          	sd	a0,112(s2)
    80001f7c:	a839                	j	80001f9a <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n", p->pid, p->name, num);
    80001f7e:	15848613          	addi	a2,s1,344
    80001f82:	588c                	lw	a1,48(s1)
    80001f84:	00006517          	auipc	a0,0x6
    80001f88:	44450513          	addi	a0,a0,1092 # 800083c8 <states.0+0x150>
    80001f8c:	00004097          	auipc	ra,0x4
    80001f90:	7f6080e7          	jalr	2038(ra) # 80006782 <printf>
    p->trapframe->a0 = -1;
    80001f94:	6cbc                	ld	a5,88(s1)
    80001f96:	577d                	li	a4,-1
    80001f98:	fbb8                	sd	a4,112(a5)
  }
}
    80001f9a:	60e2                	ld	ra,24(sp)
    80001f9c:	6442                	ld	s0,16(sp)
    80001f9e:	64a2                	ld	s1,8(sp)
    80001fa0:	6902                	ld	s2,0(sp)
    80001fa2:	6105                	addi	sp,sp,32
    80001fa4:	8082                	ret

0000000080001fa6 <sys_exit>:
#include "defs.h"
#include "proc.h"
#include "types.h"

uint64 sys_exit(void) {
    80001fa6:	1101                	addi	sp,sp,-32
    80001fa8:	ec06                	sd	ra,24(sp)
    80001faa:	e822                	sd	s0,16(sp)
    80001fac:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80001fae:	fec40593          	addi	a1,s0,-20
    80001fb2:	4501                	li	a0,0
    80001fb4:	00000097          	auipc	ra,0x0
    80001fb8:	f0e080e7          	jalr	-242(ra) # 80001ec2 <argint>
  exit(n);
    80001fbc:	fec42503          	lw	a0,-20(s0)
    80001fc0:	fffff097          	auipc	ra,0xfffff
    80001fc4:	5c8080e7          	jalr	1480(ra) # 80001588 <exit>
  return 0;  // not reached
}
    80001fc8:	4501                	li	a0,0
    80001fca:	60e2                	ld	ra,24(sp)
    80001fcc:	6442                	ld	s0,16(sp)
    80001fce:	6105                	addi	sp,sp,32
    80001fd0:	8082                	ret

0000000080001fd2 <sys_getpid>:

uint64 sys_getpid(void) { return myproc()->pid; }
    80001fd2:	1141                	addi	sp,sp,-16
    80001fd4:	e406                	sd	ra,8(sp)
    80001fd6:	e022                	sd	s0,0(sp)
    80001fd8:	0800                	addi	s0,sp,16
    80001fda:	fffff097          	auipc	ra,0xfffff
    80001fde:	dce080e7          	jalr	-562(ra) # 80000da8 <myproc>
    80001fe2:	5908                	lw	a0,48(a0)
    80001fe4:	60a2                	ld	ra,8(sp)
    80001fe6:	6402                	ld	s0,0(sp)
    80001fe8:	0141                	addi	sp,sp,16
    80001fea:	8082                	ret

0000000080001fec <sys_fork>:

uint64 sys_fork(void) { return fork(); }
    80001fec:	1141                	addi	sp,sp,-16
    80001fee:	e406                	sd	ra,8(sp)
    80001ff0:	e022                	sd	s0,0(sp)
    80001ff2:	0800                	addi	s0,sp,16
    80001ff4:	fffff097          	auipc	ra,0xfffff
    80001ff8:	16e080e7          	jalr	366(ra) # 80001162 <fork>
    80001ffc:	60a2                	ld	ra,8(sp)
    80001ffe:	6402                	ld	s0,0(sp)
    80002000:	0141                	addi	sp,sp,16
    80002002:	8082                	ret

0000000080002004 <sys_wait>:

uint64 sys_wait(void) {
    80002004:	1101                	addi	sp,sp,-32
    80002006:	ec06                	sd	ra,24(sp)
    80002008:	e822                	sd	s0,16(sp)
    8000200a:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    8000200c:	fe840593          	addi	a1,s0,-24
    80002010:	4501                	li	a0,0
    80002012:	00000097          	auipc	ra,0x0
    80002016:	ed0080e7          	jalr	-304(ra) # 80001ee2 <argaddr>
  return wait(p);
    8000201a:	fe843503          	ld	a0,-24(s0)
    8000201e:	fffff097          	auipc	ra,0xfffff
    80002022:	710080e7          	jalr	1808(ra) # 8000172e <wait>
}
    80002026:	60e2                	ld	ra,24(sp)
    80002028:	6442                	ld	s0,16(sp)
    8000202a:	6105                	addi	sp,sp,32
    8000202c:	8082                	ret

000000008000202e <sys_sbrk>:

uint64 sys_sbrk(void) {
    8000202e:	7179                	addi	sp,sp,-48
    80002030:	f406                	sd	ra,40(sp)
    80002032:	f022                	sd	s0,32(sp)
    80002034:	ec26                	sd	s1,24(sp)
    80002036:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80002038:	fdc40593          	addi	a1,s0,-36
    8000203c:	4501                	li	a0,0
    8000203e:	00000097          	auipc	ra,0x0
    80002042:	e84080e7          	jalr	-380(ra) # 80001ec2 <argint>
  addr = myproc()->sz;
    80002046:	fffff097          	auipc	ra,0xfffff
    8000204a:	d62080e7          	jalr	-670(ra) # 80000da8 <myproc>
    8000204e:	6524                	ld	s1,72(a0)
  if (growproc(n) < 0) return -1;
    80002050:	fdc42503          	lw	a0,-36(s0)
    80002054:	fffff097          	auipc	ra,0xfffff
    80002058:	0b2080e7          	jalr	178(ra) # 80001106 <growproc>
    8000205c:	00054863          	bltz	a0,8000206c <sys_sbrk+0x3e>
  return addr;
}
    80002060:	8526                	mv	a0,s1
    80002062:	70a2                	ld	ra,40(sp)
    80002064:	7402                	ld	s0,32(sp)
    80002066:	64e2                	ld	s1,24(sp)
    80002068:	6145                	addi	sp,sp,48
    8000206a:	8082                	ret
  if (growproc(n) < 0) return -1;
    8000206c:	54fd                	li	s1,-1
    8000206e:	bfcd                	j	80002060 <sys_sbrk+0x32>

0000000080002070 <sys_sleep>:

uint64 sys_sleep(void) {
    80002070:	7139                	addi	sp,sp,-64
    80002072:	fc06                	sd	ra,56(sp)
    80002074:	f822                	sd	s0,48(sp)
    80002076:	f426                	sd	s1,40(sp)
    80002078:	f04a                	sd	s2,32(sp)
    8000207a:	ec4e                	sd	s3,24(sp)
    8000207c:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    8000207e:	fcc40593          	addi	a1,s0,-52
    80002082:	4501                	li	a0,0
    80002084:	00000097          	auipc	ra,0x0
    80002088:	e3e080e7          	jalr	-450(ra) # 80001ec2 <argint>
  if (n < 0) n = 0;
    8000208c:	fcc42783          	lw	a5,-52(s0)
    80002090:	0607cf63          	bltz	a5,8000210e <sys_sleep+0x9e>
  acquire(&tickslock);
    80002094:	0000c517          	auipc	a0,0xc
    80002098:	7dc50513          	addi	a0,a0,2012 # 8000e870 <tickslock>
    8000209c:	00005097          	auipc	ra,0x5
    800020a0:	bd8080e7          	jalr	-1064(ra) # 80006c74 <acquire>
  ticks0 = ticks;
    800020a4:	00007917          	auipc	s2,0x7
    800020a8:	96492903          	lw	s2,-1692(s2) # 80008a08 <ticks>
  while (ticks - ticks0 < n) {
    800020ac:	fcc42783          	lw	a5,-52(s0)
    800020b0:	cf9d                	beqz	a5,800020ee <sys_sleep+0x7e>
    if (killed(myproc())) {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800020b2:	0000c997          	auipc	s3,0xc
    800020b6:	7be98993          	addi	s3,s3,1982 # 8000e870 <tickslock>
    800020ba:	00007497          	auipc	s1,0x7
    800020be:	94e48493          	addi	s1,s1,-1714 # 80008a08 <ticks>
    if (killed(myproc())) {
    800020c2:	fffff097          	auipc	ra,0xfffff
    800020c6:	ce6080e7          	jalr	-794(ra) # 80000da8 <myproc>
    800020ca:	fffff097          	auipc	ra,0xfffff
    800020ce:	632080e7          	jalr	1586(ra) # 800016fc <killed>
    800020d2:	e129                	bnez	a0,80002114 <sys_sleep+0xa4>
    sleep(&ticks, &tickslock);
    800020d4:	85ce                	mv	a1,s3
    800020d6:	8526                	mv	a0,s1
    800020d8:	fffff097          	auipc	ra,0xfffff
    800020dc:	37c080e7          	jalr	892(ra) # 80001454 <sleep>
  while (ticks - ticks0 < n) {
    800020e0:	409c                	lw	a5,0(s1)
    800020e2:	412787bb          	subw	a5,a5,s2
    800020e6:	fcc42703          	lw	a4,-52(s0)
    800020ea:	fce7ece3          	bltu	a5,a4,800020c2 <sys_sleep+0x52>
  }
  release(&tickslock);
    800020ee:	0000c517          	auipc	a0,0xc
    800020f2:	78250513          	addi	a0,a0,1922 # 8000e870 <tickslock>
    800020f6:	00005097          	auipc	ra,0x5
    800020fa:	c32080e7          	jalr	-974(ra) # 80006d28 <release>
  return 0;
    800020fe:	4501                	li	a0,0
}
    80002100:	70e2                	ld	ra,56(sp)
    80002102:	7442                	ld	s0,48(sp)
    80002104:	74a2                	ld	s1,40(sp)
    80002106:	7902                	ld	s2,32(sp)
    80002108:	69e2                	ld	s3,24(sp)
    8000210a:	6121                	addi	sp,sp,64
    8000210c:	8082                	ret
  if (n < 0) n = 0;
    8000210e:	fc042623          	sw	zero,-52(s0)
    80002112:	b749                	j	80002094 <sys_sleep+0x24>
      release(&tickslock);
    80002114:	0000c517          	auipc	a0,0xc
    80002118:	75c50513          	addi	a0,a0,1884 # 8000e870 <tickslock>
    8000211c:	00005097          	auipc	ra,0x5
    80002120:	c0c080e7          	jalr	-1012(ra) # 80006d28 <release>
      return -1;
    80002124:	557d                	li	a0,-1
    80002126:	bfe9                	j	80002100 <sys_sleep+0x90>

0000000080002128 <sys_kill>:

uint64 sys_kill(void) {
    80002128:	1101                	addi	sp,sp,-32
    8000212a:	ec06                	sd	ra,24(sp)
    8000212c:	e822                	sd	s0,16(sp)
    8000212e:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80002130:	fec40593          	addi	a1,s0,-20
    80002134:	4501                	li	a0,0
    80002136:	00000097          	auipc	ra,0x0
    8000213a:	d8c080e7          	jalr	-628(ra) # 80001ec2 <argint>
  return kill(pid);
    8000213e:	fec42503          	lw	a0,-20(s0)
    80002142:	fffff097          	auipc	ra,0xfffff
    80002146:	51c080e7          	jalr	1308(ra) # 8000165e <kill>
}
    8000214a:	60e2                	ld	ra,24(sp)
    8000214c:	6442                	ld	s0,16(sp)
    8000214e:	6105                	addi	sp,sp,32
    80002150:	8082                	ret

0000000080002152 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64 sys_uptime(void) {
    80002152:	1101                	addi	sp,sp,-32
    80002154:	ec06                	sd	ra,24(sp)
    80002156:	e822                	sd	s0,16(sp)
    80002158:	e426                	sd	s1,8(sp)
    8000215a:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    8000215c:	0000c517          	auipc	a0,0xc
    80002160:	71450513          	addi	a0,a0,1812 # 8000e870 <tickslock>
    80002164:	00005097          	auipc	ra,0x5
    80002168:	b10080e7          	jalr	-1264(ra) # 80006c74 <acquire>
  xticks = ticks;
    8000216c:	00007497          	auipc	s1,0x7
    80002170:	89c4a483          	lw	s1,-1892(s1) # 80008a08 <ticks>
  release(&tickslock);
    80002174:	0000c517          	auipc	a0,0xc
    80002178:	6fc50513          	addi	a0,a0,1788 # 8000e870 <tickslock>
    8000217c:	00005097          	auipc	ra,0x5
    80002180:	bac080e7          	jalr	-1108(ra) # 80006d28 <release>
  return xticks;
}
    80002184:	02049513          	slli	a0,s1,0x20
    80002188:	9101                	srli	a0,a0,0x20
    8000218a:	60e2                	ld	ra,24(sp)
    8000218c:	6442                	ld	s0,16(sp)
    8000218e:	64a2                	ld	s1,8(sp)
    80002190:	6105                	addi	sp,sp,32
    80002192:	8082                	ret

0000000080002194 <binit>:
  // Sorted by how recently the buffer was used.
  // head.next is most recent, head.prev is least.
  struct buf head;
} bcache;

void binit(void) {
    80002194:	7179                	addi	sp,sp,-48
    80002196:	f406                	sd	ra,40(sp)
    80002198:	f022                	sd	s0,32(sp)
    8000219a:	ec26                	sd	s1,24(sp)
    8000219c:	e84a                	sd	s2,16(sp)
    8000219e:	e44e                	sd	s3,8(sp)
    800021a0:	e052                	sd	s4,0(sp)
    800021a2:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    800021a4:	00006597          	auipc	a1,0x6
    800021a8:	30c58593          	addi	a1,a1,780 # 800084b0 <syscalls+0xb0>
    800021ac:	0000c517          	auipc	a0,0xc
    800021b0:	6dc50513          	addi	a0,a0,1756 # 8000e888 <bcache>
    800021b4:	00005097          	auipc	ra,0x5
    800021b8:	a30080e7          	jalr	-1488(ra) # 80006be4 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    800021bc:	00014797          	auipc	a5,0x14
    800021c0:	6cc78793          	addi	a5,a5,1740 # 80016888 <bcache+0x8000>
    800021c4:	00015717          	auipc	a4,0x15
    800021c8:	92c70713          	addi	a4,a4,-1748 # 80016af0 <bcache+0x8268>
    800021cc:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    800021d0:	2ae7bc23          	sd	a4,696(a5)
  for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
    800021d4:	0000c497          	auipc	s1,0xc
    800021d8:	6cc48493          	addi	s1,s1,1740 # 8000e8a0 <bcache+0x18>
    b->next = bcache.head.next;
    800021dc:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    800021de:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    800021e0:	00006a17          	auipc	s4,0x6
    800021e4:	2d8a0a13          	addi	s4,s4,728 # 800084b8 <syscalls+0xb8>
    b->next = bcache.head.next;
    800021e8:	2b893783          	ld	a5,696(s2)
    800021ec:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    800021ee:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    800021f2:	85d2                	mv	a1,s4
    800021f4:	01048513          	addi	a0,s1,16
    800021f8:	00001097          	auipc	ra,0x1
    800021fc:	4c4080e7          	jalr	1220(ra) # 800036bc <initsleeplock>
    bcache.head.next->prev = b;
    80002200:	2b893783          	ld	a5,696(s2)
    80002204:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002206:	2a993c23          	sd	s1,696(s2)
  for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
    8000220a:	45848493          	addi	s1,s1,1112
    8000220e:	fd349de3          	bne	s1,s3,800021e8 <binit+0x54>
  }
}
    80002212:	70a2                	ld	ra,40(sp)
    80002214:	7402                	ld	s0,32(sp)
    80002216:	64e2                	ld	s1,24(sp)
    80002218:	6942                	ld	s2,16(sp)
    8000221a:	69a2                	ld	s3,8(sp)
    8000221c:	6a02                	ld	s4,0(sp)
    8000221e:	6145                	addi	sp,sp,48
    80002220:	8082                	ret

0000000080002222 <bread>:
  }
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf *bread(uint dev, uint blockno) {
    80002222:	7179                	addi	sp,sp,-48
    80002224:	f406                	sd	ra,40(sp)
    80002226:	f022                	sd	s0,32(sp)
    80002228:	ec26                	sd	s1,24(sp)
    8000222a:	e84a                	sd	s2,16(sp)
    8000222c:	e44e                	sd	s3,8(sp)
    8000222e:	1800                	addi	s0,sp,48
    80002230:	892a                	mv	s2,a0
    80002232:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002234:	0000c517          	auipc	a0,0xc
    80002238:	65450513          	addi	a0,a0,1620 # 8000e888 <bcache>
    8000223c:	00005097          	auipc	ra,0x5
    80002240:	a38080e7          	jalr	-1480(ra) # 80006c74 <acquire>
  for (b = bcache.head.next; b != &bcache.head; b = b->next) {
    80002244:	00015497          	auipc	s1,0x15
    80002248:	8fc4b483          	ld	s1,-1796(s1) # 80016b40 <bcache+0x82b8>
    8000224c:	00015797          	auipc	a5,0x15
    80002250:	8a478793          	addi	a5,a5,-1884 # 80016af0 <bcache+0x8268>
    80002254:	02f48f63          	beq	s1,a5,80002292 <bread+0x70>
    80002258:	873e                	mv	a4,a5
    8000225a:	a021                	j	80002262 <bread+0x40>
    8000225c:	68a4                	ld	s1,80(s1)
    8000225e:	02e48a63          	beq	s1,a4,80002292 <bread+0x70>
    if (b->dev == dev && b->blockno == blockno) {
    80002262:	449c                	lw	a5,8(s1)
    80002264:	ff279ce3          	bne	a5,s2,8000225c <bread+0x3a>
    80002268:	44dc                	lw	a5,12(s1)
    8000226a:	ff3799e3          	bne	a5,s3,8000225c <bread+0x3a>
      b->refcnt++;
    8000226e:	40bc                	lw	a5,64(s1)
    80002270:	2785                	addiw	a5,a5,1
    80002272:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002274:	0000c517          	auipc	a0,0xc
    80002278:	61450513          	addi	a0,a0,1556 # 8000e888 <bcache>
    8000227c:	00005097          	auipc	ra,0x5
    80002280:	aac080e7          	jalr	-1364(ra) # 80006d28 <release>
      acquiresleep(&b->lock);
    80002284:	01048513          	addi	a0,s1,16
    80002288:	00001097          	auipc	ra,0x1
    8000228c:	46e080e7          	jalr	1134(ra) # 800036f6 <acquiresleep>
      return b;
    80002290:	a8b9                	j	800022ee <bread+0xcc>
  for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
    80002292:	00015497          	auipc	s1,0x15
    80002296:	8a64b483          	ld	s1,-1882(s1) # 80016b38 <bcache+0x82b0>
    8000229a:	00015797          	auipc	a5,0x15
    8000229e:	85678793          	addi	a5,a5,-1962 # 80016af0 <bcache+0x8268>
    800022a2:	00f48863          	beq	s1,a5,800022b2 <bread+0x90>
    800022a6:	873e                	mv	a4,a5
    if (b->refcnt == 0) {
    800022a8:	40bc                	lw	a5,64(s1)
    800022aa:	cf81                	beqz	a5,800022c2 <bread+0xa0>
  for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
    800022ac:	64a4                	ld	s1,72(s1)
    800022ae:	fee49de3          	bne	s1,a4,800022a8 <bread+0x86>
  panic("bget: no buffers");
    800022b2:	00006517          	auipc	a0,0x6
    800022b6:	20e50513          	addi	a0,a0,526 # 800084c0 <syscalls+0xc0>
    800022ba:	00004097          	auipc	ra,0x4
    800022be:	47e080e7          	jalr	1150(ra) # 80006738 <panic>
      b->dev = dev;
    800022c2:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800022c6:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800022ca:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800022ce:	4785                	li	a5,1
    800022d0:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800022d2:	0000c517          	auipc	a0,0xc
    800022d6:	5b650513          	addi	a0,a0,1462 # 8000e888 <bcache>
    800022da:	00005097          	auipc	ra,0x5
    800022de:	a4e080e7          	jalr	-1458(ra) # 80006d28 <release>
      acquiresleep(&b->lock);
    800022e2:	01048513          	addi	a0,s1,16
    800022e6:	00001097          	auipc	ra,0x1
    800022ea:	410080e7          	jalr	1040(ra) # 800036f6 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if (!b->valid) {
    800022ee:	409c                	lw	a5,0(s1)
    800022f0:	cb89                	beqz	a5,80002302 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    800022f2:	8526                	mv	a0,s1
    800022f4:	70a2                	ld	ra,40(sp)
    800022f6:	7402                	ld	s0,32(sp)
    800022f8:	64e2                	ld	s1,24(sp)
    800022fa:	6942                	ld	s2,16(sp)
    800022fc:	69a2                	ld	s3,8(sp)
    800022fe:	6145                	addi	sp,sp,48
    80002300:	8082                	ret
    virtio_disk_rw(b, 0);
    80002302:	4581                	li	a1,0
    80002304:	8526                	mv	a0,s1
    80002306:	00003097          	auipc	ra,0x3
    8000230a:	f5e080e7          	jalr	-162(ra) # 80005264 <virtio_disk_rw>
    b->valid = 1;
    8000230e:	4785                	li	a5,1
    80002310:	c09c                	sw	a5,0(s1)
  return b;
    80002312:	b7c5                	j	800022f2 <bread+0xd0>

0000000080002314 <bwrite>:

// Write b's contents to disk.  Must be locked.
void bwrite(struct buf *b) {
    80002314:	1101                	addi	sp,sp,-32
    80002316:	ec06                	sd	ra,24(sp)
    80002318:	e822                	sd	s0,16(sp)
    8000231a:	e426                	sd	s1,8(sp)
    8000231c:	1000                	addi	s0,sp,32
    8000231e:	84aa                	mv	s1,a0
  if (!holdingsleep(&b->lock)) panic("bwrite");
    80002320:	0541                	addi	a0,a0,16
    80002322:	00001097          	auipc	ra,0x1
    80002326:	46e080e7          	jalr	1134(ra) # 80003790 <holdingsleep>
    8000232a:	cd01                	beqz	a0,80002342 <bwrite+0x2e>
  virtio_disk_rw(b, 1);
    8000232c:	4585                	li	a1,1
    8000232e:	8526                	mv	a0,s1
    80002330:	00003097          	auipc	ra,0x3
    80002334:	f34080e7          	jalr	-204(ra) # 80005264 <virtio_disk_rw>
}
    80002338:	60e2                	ld	ra,24(sp)
    8000233a:	6442                	ld	s0,16(sp)
    8000233c:	64a2                	ld	s1,8(sp)
    8000233e:	6105                	addi	sp,sp,32
    80002340:	8082                	ret
  if (!holdingsleep(&b->lock)) panic("bwrite");
    80002342:	00006517          	auipc	a0,0x6
    80002346:	19650513          	addi	a0,a0,406 # 800084d8 <syscalls+0xd8>
    8000234a:	00004097          	auipc	ra,0x4
    8000234e:	3ee080e7          	jalr	1006(ra) # 80006738 <panic>

0000000080002352 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void brelse(struct buf *b) {
    80002352:	1101                	addi	sp,sp,-32
    80002354:	ec06                	sd	ra,24(sp)
    80002356:	e822                	sd	s0,16(sp)
    80002358:	e426                	sd	s1,8(sp)
    8000235a:	e04a                	sd	s2,0(sp)
    8000235c:	1000                	addi	s0,sp,32
    8000235e:	84aa                	mv	s1,a0
  if (!holdingsleep(&b->lock)) panic("brelse");
    80002360:	01050913          	addi	s2,a0,16
    80002364:	854a                	mv	a0,s2
    80002366:	00001097          	auipc	ra,0x1
    8000236a:	42a080e7          	jalr	1066(ra) # 80003790 <holdingsleep>
    8000236e:	c92d                	beqz	a0,800023e0 <brelse+0x8e>

  releasesleep(&b->lock);
    80002370:	854a                	mv	a0,s2
    80002372:	00001097          	auipc	ra,0x1
    80002376:	3da080e7          	jalr	986(ra) # 8000374c <releasesleep>

  acquire(&bcache.lock);
    8000237a:	0000c517          	auipc	a0,0xc
    8000237e:	50e50513          	addi	a0,a0,1294 # 8000e888 <bcache>
    80002382:	00005097          	auipc	ra,0x5
    80002386:	8f2080e7          	jalr	-1806(ra) # 80006c74 <acquire>
  b->refcnt--;
    8000238a:	40bc                	lw	a5,64(s1)
    8000238c:	37fd                	addiw	a5,a5,-1
    8000238e:	0007871b          	sext.w	a4,a5
    80002392:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002394:	eb05                	bnez	a4,800023c4 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002396:	68bc                	ld	a5,80(s1)
    80002398:	64b8                	ld	a4,72(s1)
    8000239a:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8000239c:	64bc                	ld	a5,72(s1)
    8000239e:	68b8                	ld	a4,80(s1)
    800023a0:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800023a2:	00014797          	auipc	a5,0x14
    800023a6:	4e678793          	addi	a5,a5,1254 # 80016888 <bcache+0x8000>
    800023aa:	2b87b703          	ld	a4,696(a5)
    800023ae:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800023b0:	00014717          	auipc	a4,0x14
    800023b4:	74070713          	addi	a4,a4,1856 # 80016af0 <bcache+0x8268>
    800023b8:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800023ba:	2b87b703          	ld	a4,696(a5)
    800023be:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800023c0:	2a97bc23          	sd	s1,696(a5)
  }

  release(&bcache.lock);
    800023c4:	0000c517          	auipc	a0,0xc
    800023c8:	4c450513          	addi	a0,a0,1220 # 8000e888 <bcache>
    800023cc:	00005097          	auipc	ra,0x5
    800023d0:	95c080e7          	jalr	-1700(ra) # 80006d28 <release>
}
    800023d4:	60e2                	ld	ra,24(sp)
    800023d6:	6442                	ld	s0,16(sp)
    800023d8:	64a2                	ld	s1,8(sp)
    800023da:	6902                	ld	s2,0(sp)
    800023dc:	6105                	addi	sp,sp,32
    800023de:	8082                	ret
  if (!holdingsleep(&b->lock)) panic("brelse");
    800023e0:	00006517          	auipc	a0,0x6
    800023e4:	10050513          	addi	a0,a0,256 # 800084e0 <syscalls+0xe0>
    800023e8:	00004097          	auipc	ra,0x4
    800023ec:	350080e7          	jalr	848(ra) # 80006738 <panic>

00000000800023f0 <bpin>:

void bpin(struct buf *b) {
    800023f0:	1101                	addi	sp,sp,-32
    800023f2:	ec06                	sd	ra,24(sp)
    800023f4:	e822                	sd	s0,16(sp)
    800023f6:	e426                	sd	s1,8(sp)
    800023f8:	1000                	addi	s0,sp,32
    800023fa:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800023fc:	0000c517          	auipc	a0,0xc
    80002400:	48c50513          	addi	a0,a0,1164 # 8000e888 <bcache>
    80002404:	00005097          	auipc	ra,0x5
    80002408:	870080e7          	jalr	-1936(ra) # 80006c74 <acquire>
  b->refcnt++;
    8000240c:	40bc                	lw	a5,64(s1)
    8000240e:	2785                	addiw	a5,a5,1
    80002410:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002412:	0000c517          	auipc	a0,0xc
    80002416:	47650513          	addi	a0,a0,1142 # 8000e888 <bcache>
    8000241a:	00005097          	auipc	ra,0x5
    8000241e:	90e080e7          	jalr	-1778(ra) # 80006d28 <release>
}
    80002422:	60e2                	ld	ra,24(sp)
    80002424:	6442                	ld	s0,16(sp)
    80002426:	64a2                	ld	s1,8(sp)
    80002428:	6105                	addi	sp,sp,32
    8000242a:	8082                	ret

000000008000242c <bunpin>:

void bunpin(struct buf *b) {
    8000242c:	1101                	addi	sp,sp,-32
    8000242e:	ec06                	sd	ra,24(sp)
    80002430:	e822                	sd	s0,16(sp)
    80002432:	e426                	sd	s1,8(sp)
    80002434:	1000                	addi	s0,sp,32
    80002436:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002438:	0000c517          	auipc	a0,0xc
    8000243c:	45050513          	addi	a0,a0,1104 # 8000e888 <bcache>
    80002440:	00005097          	auipc	ra,0x5
    80002444:	834080e7          	jalr	-1996(ra) # 80006c74 <acquire>
  b->refcnt--;
    80002448:	40bc                	lw	a5,64(s1)
    8000244a:	37fd                	addiw	a5,a5,-1
    8000244c:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000244e:	0000c517          	auipc	a0,0xc
    80002452:	43a50513          	addi	a0,a0,1082 # 8000e888 <bcache>
    80002456:	00005097          	auipc	ra,0x5
    8000245a:	8d2080e7          	jalr	-1838(ra) # 80006d28 <release>
}
    8000245e:	60e2                	ld	ra,24(sp)
    80002460:	6442                	ld	s0,16(sp)
    80002462:	64a2                	ld	s1,8(sp)
    80002464:	6105                	addi	sp,sp,32
    80002466:	8082                	ret

0000000080002468 <bfree>:
  printf("balloc: out of blocks\n");
  return 0;
}

// Free a disk block.
static void bfree(int dev, uint b) {
    80002468:	1101                	addi	sp,sp,-32
    8000246a:	ec06                	sd	ra,24(sp)
    8000246c:	e822                	sd	s0,16(sp)
    8000246e:	e426                	sd	s1,8(sp)
    80002470:	e04a                	sd	s2,0(sp)
    80002472:	1000                	addi	s0,sp,32
    80002474:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002476:	00d5d59b          	srliw	a1,a1,0xd
    8000247a:	00015797          	auipc	a5,0x15
    8000247e:	aea7a783          	lw	a5,-1302(a5) # 80016f64 <sb+0x1c>
    80002482:	9dbd                	addw	a1,a1,a5
    80002484:	00000097          	auipc	ra,0x0
    80002488:	d9e080e7          	jalr	-610(ra) # 80002222 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    8000248c:	0074f713          	andi	a4,s1,7
    80002490:	4785                	li	a5,1
    80002492:	00e797bb          	sllw	a5,a5,a4
  if ((bp->data[bi / 8] & m) == 0) panic("freeing free block");
    80002496:	14ce                	slli	s1,s1,0x33
    80002498:	90d9                	srli	s1,s1,0x36
    8000249a:	00950733          	add	a4,a0,s1
    8000249e:	05874703          	lbu	a4,88(a4)
    800024a2:	00e7f6b3          	and	a3,a5,a4
    800024a6:	c69d                	beqz	a3,800024d4 <bfree+0x6c>
    800024a8:	892a                	mv	s2,a0
  bp->data[bi / 8] &= ~m;
    800024aa:	94aa                	add	s1,s1,a0
    800024ac:	fff7c793          	not	a5,a5
    800024b0:	8ff9                	and	a5,a5,a4
    800024b2:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    800024b6:	00001097          	auipc	ra,0x1
    800024ba:	120080e7          	jalr	288(ra) # 800035d6 <log_write>
  brelse(bp);
    800024be:	854a                	mv	a0,s2
    800024c0:	00000097          	auipc	ra,0x0
    800024c4:	e92080e7          	jalr	-366(ra) # 80002352 <brelse>
}
    800024c8:	60e2                	ld	ra,24(sp)
    800024ca:	6442                	ld	s0,16(sp)
    800024cc:	64a2                	ld	s1,8(sp)
    800024ce:	6902                	ld	s2,0(sp)
    800024d0:	6105                	addi	sp,sp,32
    800024d2:	8082                	ret
  if ((bp->data[bi / 8] & m) == 0) panic("freeing free block");
    800024d4:	00006517          	auipc	a0,0x6
    800024d8:	01450513          	addi	a0,a0,20 # 800084e8 <syscalls+0xe8>
    800024dc:	00004097          	auipc	ra,0x4
    800024e0:	25c080e7          	jalr	604(ra) # 80006738 <panic>

00000000800024e4 <balloc>:
static uint balloc(uint dev) {
    800024e4:	711d                	addi	sp,sp,-96
    800024e6:	ec86                	sd	ra,88(sp)
    800024e8:	e8a2                	sd	s0,80(sp)
    800024ea:	e4a6                	sd	s1,72(sp)
    800024ec:	e0ca                	sd	s2,64(sp)
    800024ee:	fc4e                	sd	s3,56(sp)
    800024f0:	f852                	sd	s4,48(sp)
    800024f2:	f456                	sd	s5,40(sp)
    800024f4:	f05a                	sd	s6,32(sp)
    800024f6:	ec5e                	sd	s7,24(sp)
    800024f8:	e862                	sd	s8,16(sp)
    800024fa:	e466                	sd	s9,8(sp)
    800024fc:	1080                	addi	s0,sp,96
  for (b = 0; b < sb.size; b += BPB) {
    800024fe:	00015797          	auipc	a5,0x15
    80002502:	a4e7a783          	lw	a5,-1458(a5) # 80016f4c <sb+0x4>
    80002506:	10078163          	beqz	a5,80002608 <balloc+0x124>
    8000250a:	8baa                	mv	s7,a0
    8000250c:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    8000250e:	00015b17          	auipc	s6,0x15
    80002512:	a3ab0b13          	addi	s6,s6,-1478 # 80016f48 <sb>
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    80002516:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80002518:	4985                	li	s3,1
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    8000251a:	6a09                	lui	s4,0x2
  for (b = 0; b < sb.size; b += BPB) {
    8000251c:	6c89                	lui	s9,0x2
    8000251e:	a061                	j	800025a6 <balloc+0xc2>
        bp->data[bi / 8] |= m;            // Mark block in use.
    80002520:	974a                	add	a4,a4,s2
    80002522:	8fd5                	or	a5,a5,a3
    80002524:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    80002528:	854a                	mv	a0,s2
    8000252a:	00001097          	auipc	ra,0x1
    8000252e:	0ac080e7          	jalr	172(ra) # 800035d6 <log_write>
        brelse(bp);
    80002532:	854a                	mv	a0,s2
    80002534:	00000097          	auipc	ra,0x0
    80002538:	e1e080e7          	jalr	-482(ra) # 80002352 <brelse>
  bp = bread(dev, bno);
    8000253c:	85a6                	mv	a1,s1
    8000253e:	855e                	mv	a0,s7
    80002540:	00000097          	auipc	ra,0x0
    80002544:	ce2080e7          	jalr	-798(ra) # 80002222 <bread>
    80002548:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    8000254a:	40000613          	li	a2,1024
    8000254e:	4581                	li	a1,0
    80002550:	05850513          	addi	a0,a0,88
    80002554:	ffffe097          	auipc	ra,0xffffe
    80002558:	b22080e7          	jalr	-1246(ra) # 80000076 <memset>
  log_write(bp);
    8000255c:	854a                	mv	a0,s2
    8000255e:	00001097          	auipc	ra,0x1
    80002562:	078080e7          	jalr	120(ra) # 800035d6 <log_write>
  brelse(bp);
    80002566:	854a                	mv	a0,s2
    80002568:	00000097          	auipc	ra,0x0
    8000256c:	dea080e7          	jalr	-534(ra) # 80002352 <brelse>
}
    80002570:	8526                	mv	a0,s1
    80002572:	60e6                	ld	ra,88(sp)
    80002574:	6446                	ld	s0,80(sp)
    80002576:	64a6                	ld	s1,72(sp)
    80002578:	6906                	ld	s2,64(sp)
    8000257a:	79e2                	ld	s3,56(sp)
    8000257c:	7a42                	ld	s4,48(sp)
    8000257e:	7aa2                	ld	s5,40(sp)
    80002580:	7b02                	ld	s6,32(sp)
    80002582:	6be2                	ld	s7,24(sp)
    80002584:	6c42                	ld	s8,16(sp)
    80002586:	6ca2                	ld	s9,8(sp)
    80002588:	6125                	addi	sp,sp,96
    8000258a:	8082                	ret
    brelse(bp);
    8000258c:	854a                	mv	a0,s2
    8000258e:	00000097          	auipc	ra,0x0
    80002592:	dc4080e7          	jalr	-572(ra) # 80002352 <brelse>
  for (b = 0; b < sb.size; b += BPB) {
    80002596:	015c87bb          	addw	a5,s9,s5
    8000259a:	00078a9b          	sext.w	s5,a5
    8000259e:	004b2703          	lw	a4,4(s6)
    800025a2:	06eaf363          	bgeu	s5,a4,80002608 <balloc+0x124>
    bp = bread(dev, BBLOCK(b, sb));
    800025a6:	41fad79b          	sraiw	a5,s5,0x1f
    800025aa:	0137d79b          	srliw	a5,a5,0x13
    800025ae:	015787bb          	addw	a5,a5,s5
    800025b2:	40d7d79b          	sraiw	a5,a5,0xd
    800025b6:	01cb2583          	lw	a1,28(s6)
    800025ba:	9dbd                	addw	a1,a1,a5
    800025bc:	855e                	mv	a0,s7
    800025be:	00000097          	auipc	ra,0x0
    800025c2:	c64080e7          	jalr	-924(ra) # 80002222 <bread>
    800025c6:	892a                	mv	s2,a0
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    800025c8:	004b2503          	lw	a0,4(s6)
    800025cc:	000a849b          	sext.w	s1,s5
    800025d0:	8662                	mv	a2,s8
    800025d2:	faa4fde3          	bgeu	s1,a0,8000258c <balloc+0xa8>
      m = 1 << (bi % 8);
    800025d6:	41f6579b          	sraiw	a5,a2,0x1f
    800025da:	01d7d69b          	srliw	a3,a5,0x1d
    800025de:	00c6873b          	addw	a4,a3,a2
    800025e2:	00777793          	andi	a5,a4,7
    800025e6:	9f95                	subw	a5,a5,a3
    800025e8:	00f997bb          	sllw	a5,s3,a5
      if ((bp->data[bi / 8] & m) == 0) {  // Is block free?
    800025ec:	4037571b          	sraiw	a4,a4,0x3
    800025f0:	00e906b3          	add	a3,s2,a4
    800025f4:	0586c683          	lbu	a3,88(a3)
    800025f8:	00d7f5b3          	and	a1,a5,a3
    800025fc:	d195                	beqz	a1,80002520 <balloc+0x3c>
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    800025fe:	2605                	addiw	a2,a2,1
    80002600:	2485                	addiw	s1,s1,1
    80002602:	fd4618e3          	bne	a2,s4,800025d2 <balloc+0xee>
    80002606:	b759                	j	8000258c <balloc+0xa8>
  printf("balloc: out of blocks\n");
    80002608:	00006517          	auipc	a0,0x6
    8000260c:	ef850513          	addi	a0,a0,-264 # 80008500 <syscalls+0x100>
    80002610:	00004097          	auipc	ra,0x4
    80002614:	172080e7          	jalr	370(ra) # 80006782 <printf>
  return 0;
    80002618:	4481                	li	s1,0
    8000261a:	bf99                	j	80002570 <balloc+0x8c>

000000008000261c <bmap>:
// listed in block ip->addrs[NDIRECT].

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint bmap(struct inode *ip, uint bn) {
    8000261c:	7179                	addi	sp,sp,-48
    8000261e:	f406                	sd	ra,40(sp)
    80002620:	f022                	sd	s0,32(sp)
    80002622:	ec26                	sd	s1,24(sp)
    80002624:	e84a                	sd	s2,16(sp)
    80002626:	e44e                	sd	s3,8(sp)
    80002628:	e052                	sd	s4,0(sp)
    8000262a:	1800                	addi	s0,sp,48
    8000262c:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if (bn < NDIRECT) {
    8000262e:	47ad                	li	a5,11
    80002630:	02b7e763          	bltu	a5,a1,8000265e <bmap+0x42>
    if ((addr = ip->addrs[bn]) == 0) {
    80002634:	02059493          	slli	s1,a1,0x20
    80002638:	9081                	srli	s1,s1,0x20
    8000263a:	048a                	slli	s1,s1,0x2
    8000263c:	94aa                	add	s1,s1,a0
    8000263e:	0504a903          	lw	s2,80(s1)
    80002642:	06091e63          	bnez	s2,800026be <bmap+0xa2>
      addr = balloc(ip->dev);
    80002646:	4108                	lw	a0,0(a0)
    80002648:	00000097          	auipc	ra,0x0
    8000264c:	e9c080e7          	jalr	-356(ra) # 800024e4 <balloc>
    80002650:	0005091b          	sext.w	s2,a0
      if (addr == 0) return 0;
    80002654:	06090563          	beqz	s2,800026be <bmap+0xa2>
      ip->addrs[bn] = addr;
    80002658:	0524a823          	sw	s2,80(s1)
    8000265c:	a08d                	j	800026be <bmap+0xa2>
    }
    return addr;
  }
  bn -= NDIRECT;
    8000265e:	ff45849b          	addiw	s1,a1,-12
    80002662:	0004871b          	sext.w	a4,s1

  if (bn < NINDIRECT) {
    80002666:	0ff00793          	li	a5,255
    8000266a:	08e7e563          	bltu	a5,a4,800026f4 <bmap+0xd8>
    // Load indirect block, allocating if necessary.
    if ((addr = ip->addrs[NDIRECT]) == 0) {
    8000266e:	08052903          	lw	s2,128(a0)
    80002672:	00091d63          	bnez	s2,8000268c <bmap+0x70>
      addr = balloc(ip->dev);
    80002676:	4108                	lw	a0,0(a0)
    80002678:	00000097          	auipc	ra,0x0
    8000267c:	e6c080e7          	jalr	-404(ra) # 800024e4 <balloc>
    80002680:	0005091b          	sext.w	s2,a0
      if (addr == 0) return 0;
    80002684:	02090d63          	beqz	s2,800026be <bmap+0xa2>
      ip->addrs[NDIRECT] = addr;
    80002688:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    8000268c:	85ca                	mv	a1,s2
    8000268e:	0009a503          	lw	a0,0(s3)
    80002692:	00000097          	auipc	ra,0x0
    80002696:	b90080e7          	jalr	-1136(ra) # 80002222 <bread>
    8000269a:	8a2a                	mv	s4,a0
    a = (uint *)bp->data;
    8000269c:	05850793          	addi	a5,a0,88
    if ((addr = a[bn]) == 0) {
    800026a0:	02049593          	slli	a1,s1,0x20
    800026a4:	9181                	srli	a1,a1,0x20
    800026a6:	058a                	slli	a1,a1,0x2
    800026a8:	00b784b3          	add	s1,a5,a1
    800026ac:	0004a903          	lw	s2,0(s1)
    800026b0:	02090063          	beqz	s2,800026d0 <bmap+0xb4>
      if (addr) {
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    800026b4:	8552                	mv	a0,s4
    800026b6:	00000097          	auipc	ra,0x0
    800026ba:	c9c080e7          	jalr	-868(ra) # 80002352 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    800026be:	854a                	mv	a0,s2
    800026c0:	70a2                	ld	ra,40(sp)
    800026c2:	7402                	ld	s0,32(sp)
    800026c4:	64e2                	ld	s1,24(sp)
    800026c6:	6942                	ld	s2,16(sp)
    800026c8:	69a2                	ld	s3,8(sp)
    800026ca:	6a02                	ld	s4,0(sp)
    800026cc:	6145                	addi	sp,sp,48
    800026ce:	8082                	ret
      addr = balloc(ip->dev);
    800026d0:	0009a503          	lw	a0,0(s3)
    800026d4:	00000097          	auipc	ra,0x0
    800026d8:	e10080e7          	jalr	-496(ra) # 800024e4 <balloc>
    800026dc:	0005091b          	sext.w	s2,a0
      if (addr) {
    800026e0:	fc090ae3          	beqz	s2,800026b4 <bmap+0x98>
        a[bn] = addr;
    800026e4:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    800026e8:	8552                	mv	a0,s4
    800026ea:	00001097          	auipc	ra,0x1
    800026ee:	eec080e7          	jalr	-276(ra) # 800035d6 <log_write>
    800026f2:	b7c9                	j	800026b4 <bmap+0x98>
  panic("bmap: out of range");
    800026f4:	00006517          	auipc	a0,0x6
    800026f8:	e2450513          	addi	a0,a0,-476 # 80008518 <syscalls+0x118>
    800026fc:	00004097          	auipc	ra,0x4
    80002700:	03c080e7          	jalr	60(ra) # 80006738 <panic>

0000000080002704 <iget>:
static struct inode *iget(uint dev, uint inum) {
    80002704:	7179                	addi	sp,sp,-48
    80002706:	f406                	sd	ra,40(sp)
    80002708:	f022                	sd	s0,32(sp)
    8000270a:	ec26                	sd	s1,24(sp)
    8000270c:	e84a                	sd	s2,16(sp)
    8000270e:	e44e                	sd	s3,8(sp)
    80002710:	e052                	sd	s4,0(sp)
    80002712:	1800                	addi	s0,sp,48
    80002714:	89aa                	mv	s3,a0
    80002716:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002718:	00015517          	auipc	a0,0x15
    8000271c:	85050513          	addi	a0,a0,-1968 # 80016f68 <itable>
    80002720:	00004097          	auipc	ra,0x4
    80002724:	554080e7          	jalr	1364(ra) # 80006c74 <acquire>
  empty = 0;
    80002728:	4901                	li	s2,0
  for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    8000272a:	00015497          	auipc	s1,0x15
    8000272e:	85648493          	addi	s1,s1,-1962 # 80016f80 <itable+0x18>
    80002732:	00016697          	auipc	a3,0x16
    80002736:	2de68693          	addi	a3,a3,734 # 80018a10 <log>
    8000273a:	a039                	j	80002748 <iget+0x44>
    if (empty == 0 && ip->ref == 0)  // Remember empty slot.
    8000273c:	02090b63          	beqz	s2,80002772 <iget+0x6e>
  for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    80002740:	08848493          	addi	s1,s1,136
    80002744:	02d48a63          	beq	s1,a3,80002778 <iget+0x74>
    if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
    80002748:	449c                	lw	a5,8(s1)
    8000274a:	fef059e3          	blez	a5,8000273c <iget+0x38>
    8000274e:	4098                	lw	a4,0(s1)
    80002750:	ff3716e3          	bne	a4,s3,8000273c <iget+0x38>
    80002754:	40d8                	lw	a4,4(s1)
    80002756:	ff4713e3          	bne	a4,s4,8000273c <iget+0x38>
      ip->ref++;
    8000275a:	2785                	addiw	a5,a5,1
    8000275c:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    8000275e:	00015517          	auipc	a0,0x15
    80002762:	80a50513          	addi	a0,a0,-2038 # 80016f68 <itable>
    80002766:	00004097          	auipc	ra,0x4
    8000276a:	5c2080e7          	jalr	1474(ra) # 80006d28 <release>
      return ip;
    8000276e:	8926                	mv	s2,s1
    80002770:	a03d                	j	8000279e <iget+0x9a>
    if (empty == 0 && ip->ref == 0)  // Remember empty slot.
    80002772:	f7f9                	bnez	a5,80002740 <iget+0x3c>
    80002774:	8926                	mv	s2,s1
    80002776:	b7e9                	j	80002740 <iget+0x3c>
  if (empty == 0) panic("iget: no inodes");
    80002778:	02090c63          	beqz	s2,800027b0 <iget+0xac>
  ip->dev = dev;
    8000277c:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002780:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002784:	4785                	li	a5,1
    80002786:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    8000278a:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    8000278e:	00014517          	auipc	a0,0x14
    80002792:	7da50513          	addi	a0,a0,2010 # 80016f68 <itable>
    80002796:	00004097          	auipc	ra,0x4
    8000279a:	592080e7          	jalr	1426(ra) # 80006d28 <release>
}
    8000279e:	854a                	mv	a0,s2
    800027a0:	70a2                	ld	ra,40(sp)
    800027a2:	7402                	ld	s0,32(sp)
    800027a4:	64e2                	ld	s1,24(sp)
    800027a6:	6942                	ld	s2,16(sp)
    800027a8:	69a2                	ld	s3,8(sp)
    800027aa:	6a02                	ld	s4,0(sp)
    800027ac:	6145                	addi	sp,sp,48
    800027ae:	8082                	ret
  if (empty == 0) panic("iget: no inodes");
    800027b0:	00006517          	auipc	a0,0x6
    800027b4:	d8050513          	addi	a0,a0,-640 # 80008530 <syscalls+0x130>
    800027b8:	00004097          	auipc	ra,0x4
    800027bc:	f80080e7          	jalr	-128(ra) # 80006738 <panic>

00000000800027c0 <fsinit>:
void fsinit(int dev) {
    800027c0:	7179                	addi	sp,sp,-48
    800027c2:	f406                	sd	ra,40(sp)
    800027c4:	f022                	sd	s0,32(sp)
    800027c6:	ec26                	sd	s1,24(sp)
    800027c8:	e84a                	sd	s2,16(sp)
    800027ca:	e44e                	sd	s3,8(sp)
    800027cc:	1800                	addi	s0,sp,48
    800027ce:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800027d0:	4585                	li	a1,1
    800027d2:	00000097          	auipc	ra,0x0
    800027d6:	a50080e7          	jalr	-1456(ra) # 80002222 <bread>
    800027da:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800027dc:	00014997          	auipc	s3,0x14
    800027e0:	76c98993          	addi	s3,s3,1900 # 80016f48 <sb>
    800027e4:	02000613          	li	a2,32
    800027e8:	05850593          	addi	a1,a0,88
    800027ec:	854e                	mv	a0,s3
    800027ee:	ffffe097          	auipc	ra,0xffffe
    800027f2:	8e4080e7          	jalr	-1820(ra) # 800000d2 <memmove>
  brelse(bp);
    800027f6:	8526                	mv	a0,s1
    800027f8:	00000097          	auipc	ra,0x0
    800027fc:	b5a080e7          	jalr	-1190(ra) # 80002352 <brelse>
  if (sb.magic != FSMAGIC) panic("invalid file system");
    80002800:	0009a703          	lw	a4,0(s3)
    80002804:	102037b7          	lui	a5,0x10203
    80002808:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    8000280c:	02f71263          	bne	a4,a5,80002830 <fsinit+0x70>
  initlog(dev, &sb);
    80002810:	00014597          	auipc	a1,0x14
    80002814:	73858593          	addi	a1,a1,1848 # 80016f48 <sb>
    80002818:	854a                	mv	a0,s2
    8000281a:	00001097          	auipc	ra,0x1
    8000281e:	b40080e7          	jalr	-1216(ra) # 8000335a <initlog>
}
    80002822:	70a2                	ld	ra,40(sp)
    80002824:	7402                	ld	s0,32(sp)
    80002826:	64e2                	ld	s1,24(sp)
    80002828:	6942                	ld	s2,16(sp)
    8000282a:	69a2                	ld	s3,8(sp)
    8000282c:	6145                	addi	sp,sp,48
    8000282e:	8082                	ret
  if (sb.magic != FSMAGIC) panic("invalid file system");
    80002830:	00006517          	auipc	a0,0x6
    80002834:	d1050513          	addi	a0,a0,-752 # 80008540 <syscalls+0x140>
    80002838:	00004097          	auipc	ra,0x4
    8000283c:	f00080e7          	jalr	-256(ra) # 80006738 <panic>

0000000080002840 <iinit>:
void iinit() {
    80002840:	7179                	addi	sp,sp,-48
    80002842:	f406                	sd	ra,40(sp)
    80002844:	f022                	sd	s0,32(sp)
    80002846:	ec26                	sd	s1,24(sp)
    80002848:	e84a                	sd	s2,16(sp)
    8000284a:	e44e                	sd	s3,8(sp)
    8000284c:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    8000284e:	00006597          	auipc	a1,0x6
    80002852:	d0a58593          	addi	a1,a1,-758 # 80008558 <syscalls+0x158>
    80002856:	00014517          	auipc	a0,0x14
    8000285a:	71250513          	addi	a0,a0,1810 # 80016f68 <itable>
    8000285e:	00004097          	auipc	ra,0x4
    80002862:	386080e7          	jalr	902(ra) # 80006be4 <initlock>
  for (i = 0; i < NINODE; i++) {
    80002866:	00014497          	auipc	s1,0x14
    8000286a:	72a48493          	addi	s1,s1,1834 # 80016f90 <itable+0x28>
    8000286e:	00016997          	auipc	s3,0x16
    80002872:	1b298993          	addi	s3,s3,434 # 80018a20 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002876:	00006917          	auipc	s2,0x6
    8000287a:	cea90913          	addi	s2,s2,-790 # 80008560 <syscalls+0x160>
    8000287e:	85ca                	mv	a1,s2
    80002880:	8526                	mv	a0,s1
    80002882:	00001097          	auipc	ra,0x1
    80002886:	e3a080e7          	jalr	-454(ra) # 800036bc <initsleeplock>
  for (i = 0; i < NINODE; i++) {
    8000288a:	08848493          	addi	s1,s1,136
    8000288e:	ff3498e3          	bne	s1,s3,8000287e <iinit+0x3e>
}
    80002892:	70a2                	ld	ra,40(sp)
    80002894:	7402                	ld	s0,32(sp)
    80002896:	64e2                	ld	s1,24(sp)
    80002898:	6942                	ld	s2,16(sp)
    8000289a:	69a2                	ld	s3,8(sp)
    8000289c:	6145                	addi	sp,sp,48
    8000289e:	8082                	ret

00000000800028a0 <ialloc>:
struct inode *ialloc(uint dev, short type) {
    800028a0:	715d                	addi	sp,sp,-80
    800028a2:	e486                	sd	ra,72(sp)
    800028a4:	e0a2                	sd	s0,64(sp)
    800028a6:	fc26                	sd	s1,56(sp)
    800028a8:	f84a                	sd	s2,48(sp)
    800028aa:	f44e                	sd	s3,40(sp)
    800028ac:	f052                	sd	s4,32(sp)
    800028ae:	ec56                	sd	s5,24(sp)
    800028b0:	e85a                	sd	s6,16(sp)
    800028b2:	e45e                	sd	s7,8(sp)
    800028b4:	0880                	addi	s0,sp,80
  for (inum = 1; inum < sb.ninodes; inum++) {
    800028b6:	00014717          	auipc	a4,0x14
    800028ba:	69e72703          	lw	a4,1694(a4) # 80016f54 <sb+0xc>
    800028be:	4785                	li	a5,1
    800028c0:	04e7fa63          	bgeu	a5,a4,80002914 <ialloc+0x74>
    800028c4:	8aaa                	mv	s5,a0
    800028c6:	8bae                	mv	s7,a1
    800028c8:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    800028ca:	00014a17          	auipc	s4,0x14
    800028ce:	67ea0a13          	addi	s4,s4,1662 # 80016f48 <sb>
    800028d2:	00048b1b          	sext.w	s6,s1
    800028d6:	0044d793          	srli	a5,s1,0x4
    800028da:	018a2583          	lw	a1,24(s4)
    800028de:	9dbd                	addw	a1,a1,a5
    800028e0:	8556                	mv	a0,s5
    800028e2:	00000097          	auipc	ra,0x0
    800028e6:	940080e7          	jalr	-1728(ra) # 80002222 <bread>
    800028ea:	892a                	mv	s2,a0
    dip = (struct dinode *)bp->data + inum % IPB;
    800028ec:	05850993          	addi	s3,a0,88
    800028f0:	00f4f793          	andi	a5,s1,15
    800028f4:	079a                	slli	a5,a5,0x6
    800028f6:	99be                	add	s3,s3,a5
    if (dip->type == 0) {  // a free inode
    800028f8:	00099783          	lh	a5,0(s3)
    800028fc:	c3a1                	beqz	a5,8000293c <ialloc+0x9c>
    brelse(bp);
    800028fe:	00000097          	auipc	ra,0x0
    80002902:	a54080e7          	jalr	-1452(ra) # 80002352 <brelse>
  for (inum = 1; inum < sb.ninodes; inum++) {
    80002906:	0485                	addi	s1,s1,1
    80002908:	00ca2703          	lw	a4,12(s4)
    8000290c:	0004879b          	sext.w	a5,s1
    80002910:	fce7e1e3          	bltu	a5,a4,800028d2 <ialloc+0x32>
  printf("ialloc: no inodes\n");
    80002914:	00006517          	auipc	a0,0x6
    80002918:	c5450513          	addi	a0,a0,-940 # 80008568 <syscalls+0x168>
    8000291c:	00004097          	auipc	ra,0x4
    80002920:	e66080e7          	jalr	-410(ra) # 80006782 <printf>
  return 0;
    80002924:	4501                	li	a0,0
}
    80002926:	60a6                	ld	ra,72(sp)
    80002928:	6406                	ld	s0,64(sp)
    8000292a:	74e2                	ld	s1,56(sp)
    8000292c:	7942                	ld	s2,48(sp)
    8000292e:	79a2                	ld	s3,40(sp)
    80002930:	7a02                	ld	s4,32(sp)
    80002932:	6ae2                	ld	s5,24(sp)
    80002934:	6b42                	ld	s6,16(sp)
    80002936:	6ba2                	ld	s7,8(sp)
    80002938:	6161                	addi	sp,sp,80
    8000293a:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    8000293c:	04000613          	li	a2,64
    80002940:	4581                	li	a1,0
    80002942:	854e                	mv	a0,s3
    80002944:	ffffd097          	auipc	ra,0xffffd
    80002948:	732080e7          	jalr	1842(ra) # 80000076 <memset>
      dip->type = type;
    8000294c:	01799023          	sh	s7,0(s3)
      log_write(bp);  // mark it allocated on the disk
    80002950:	854a                	mv	a0,s2
    80002952:	00001097          	auipc	ra,0x1
    80002956:	c84080e7          	jalr	-892(ra) # 800035d6 <log_write>
      brelse(bp);
    8000295a:	854a                	mv	a0,s2
    8000295c:	00000097          	auipc	ra,0x0
    80002960:	9f6080e7          	jalr	-1546(ra) # 80002352 <brelse>
      return iget(dev, inum);
    80002964:	85da                	mv	a1,s6
    80002966:	8556                	mv	a0,s5
    80002968:	00000097          	auipc	ra,0x0
    8000296c:	d9c080e7          	jalr	-612(ra) # 80002704 <iget>
    80002970:	bf5d                	j	80002926 <ialloc+0x86>

0000000080002972 <iupdate>:
void iupdate(struct inode *ip) {
    80002972:	1101                	addi	sp,sp,-32
    80002974:	ec06                	sd	ra,24(sp)
    80002976:	e822                	sd	s0,16(sp)
    80002978:	e426                	sd	s1,8(sp)
    8000297a:	e04a                	sd	s2,0(sp)
    8000297c:	1000                	addi	s0,sp,32
    8000297e:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002980:	415c                	lw	a5,4(a0)
    80002982:	0047d79b          	srliw	a5,a5,0x4
    80002986:	00014597          	auipc	a1,0x14
    8000298a:	5da5a583          	lw	a1,1498(a1) # 80016f60 <sb+0x18>
    8000298e:	9dbd                	addw	a1,a1,a5
    80002990:	4108                	lw	a0,0(a0)
    80002992:	00000097          	auipc	ra,0x0
    80002996:	890080e7          	jalr	-1904(ra) # 80002222 <bread>
    8000299a:	892a                	mv	s2,a0
  dip = (struct dinode *)bp->data + ip->inum % IPB;
    8000299c:	05850793          	addi	a5,a0,88
    800029a0:	40c8                	lw	a0,4(s1)
    800029a2:	893d                	andi	a0,a0,15
    800029a4:	051a                	slli	a0,a0,0x6
    800029a6:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    800029a8:	04449703          	lh	a4,68(s1)
    800029ac:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    800029b0:	04649703          	lh	a4,70(s1)
    800029b4:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    800029b8:	04849703          	lh	a4,72(s1)
    800029bc:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    800029c0:	04a49703          	lh	a4,74(s1)
    800029c4:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    800029c8:	44f8                	lw	a4,76(s1)
    800029ca:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800029cc:	03400613          	li	a2,52
    800029d0:	05048593          	addi	a1,s1,80
    800029d4:	0531                	addi	a0,a0,12
    800029d6:	ffffd097          	auipc	ra,0xffffd
    800029da:	6fc080e7          	jalr	1788(ra) # 800000d2 <memmove>
  log_write(bp);
    800029de:	854a                	mv	a0,s2
    800029e0:	00001097          	auipc	ra,0x1
    800029e4:	bf6080e7          	jalr	-1034(ra) # 800035d6 <log_write>
  brelse(bp);
    800029e8:	854a                	mv	a0,s2
    800029ea:	00000097          	auipc	ra,0x0
    800029ee:	968080e7          	jalr	-1688(ra) # 80002352 <brelse>
}
    800029f2:	60e2                	ld	ra,24(sp)
    800029f4:	6442                	ld	s0,16(sp)
    800029f6:	64a2                	ld	s1,8(sp)
    800029f8:	6902                	ld	s2,0(sp)
    800029fa:	6105                	addi	sp,sp,32
    800029fc:	8082                	ret

00000000800029fe <idup>:
struct inode *idup(struct inode *ip) {
    800029fe:	1101                	addi	sp,sp,-32
    80002a00:	ec06                	sd	ra,24(sp)
    80002a02:	e822                	sd	s0,16(sp)
    80002a04:	e426                	sd	s1,8(sp)
    80002a06:	1000                	addi	s0,sp,32
    80002a08:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002a0a:	00014517          	auipc	a0,0x14
    80002a0e:	55e50513          	addi	a0,a0,1374 # 80016f68 <itable>
    80002a12:	00004097          	auipc	ra,0x4
    80002a16:	262080e7          	jalr	610(ra) # 80006c74 <acquire>
  ip->ref++;
    80002a1a:	449c                	lw	a5,8(s1)
    80002a1c:	2785                	addiw	a5,a5,1
    80002a1e:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002a20:	00014517          	auipc	a0,0x14
    80002a24:	54850513          	addi	a0,a0,1352 # 80016f68 <itable>
    80002a28:	00004097          	auipc	ra,0x4
    80002a2c:	300080e7          	jalr	768(ra) # 80006d28 <release>
}
    80002a30:	8526                	mv	a0,s1
    80002a32:	60e2                	ld	ra,24(sp)
    80002a34:	6442                	ld	s0,16(sp)
    80002a36:	64a2                	ld	s1,8(sp)
    80002a38:	6105                	addi	sp,sp,32
    80002a3a:	8082                	ret

0000000080002a3c <ilock>:
void ilock(struct inode *ip) {
    80002a3c:	1101                	addi	sp,sp,-32
    80002a3e:	ec06                	sd	ra,24(sp)
    80002a40:	e822                	sd	s0,16(sp)
    80002a42:	e426                	sd	s1,8(sp)
    80002a44:	e04a                	sd	s2,0(sp)
    80002a46:	1000                	addi	s0,sp,32
  if (ip == 0 || ip->ref < 1) panic("ilock");
    80002a48:	c115                	beqz	a0,80002a6c <ilock+0x30>
    80002a4a:	84aa                	mv	s1,a0
    80002a4c:	451c                	lw	a5,8(a0)
    80002a4e:	00f05f63          	blez	a5,80002a6c <ilock+0x30>
  acquiresleep(&ip->lock);
    80002a52:	0541                	addi	a0,a0,16
    80002a54:	00001097          	auipc	ra,0x1
    80002a58:	ca2080e7          	jalr	-862(ra) # 800036f6 <acquiresleep>
  if (ip->valid == 0) {
    80002a5c:	40bc                	lw	a5,64(s1)
    80002a5e:	cf99                	beqz	a5,80002a7c <ilock+0x40>
}
    80002a60:	60e2                	ld	ra,24(sp)
    80002a62:	6442                	ld	s0,16(sp)
    80002a64:	64a2                	ld	s1,8(sp)
    80002a66:	6902                	ld	s2,0(sp)
    80002a68:	6105                	addi	sp,sp,32
    80002a6a:	8082                	ret
  if (ip == 0 || ip->ref < 1) panic("ilock");
    80002a6c:	00006517          	auipc	a0,0x6
    80002a70:	b1450513          	addi	a0,a0,-1260 # 80008580 <syscalls+0x180>
    80002a74:	00004097          	auipc	ra,0x4
    80002a78:	cc4080e7          	jalr	-828(ra) # 80006738 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002a7c:	40dc                	lw	a5,4(s1)
    80002a7e:	0047d79b          	srliw	a5,a5,0x4
    80002a82:	00014597          	auipc	a1,0x14
    80002a86:	4de5a583          	lw	a1,1246(a1) # 80016f60 <sb+0x18>
    80002a8a:	9dbd                	addw	a1,a1,a5
    80002a8c:	4088                	lw	a0,0(s1)
    80002a8e:	fffff097          	auipc	ra,0xfffff
    80002a92:	794080e7          	jalr	1940(ra) # 80002222 <bread>
    80002a96:	892a                	mv	s2,a0
    dip = (struct dinode *)bp->data + ip->inum % IPB;
    80002a98:	05850593          	addi	a1,a0,88
    80002a9c:	40dc                	lw	a5,4(s1)
    80002a9e:	8bbd                	andi	a5,a5,15
    80002aa0:	079a                	slli	a5,a5,0x6
    80002aa2:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002aa4:	00059783          	lh	a5,0(a1)
    80002aa8:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002aac:	00259783          	lh	a5,2(a1)
    80002ab0:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002ab4:	00459783          	lh	a5,4(a1)
    80002ab8:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002abc:	00659783          	lh	a5,6(a1)
    80002ac0:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002ac4:	459c                	lw	a5,8(a1)
    80002ac6:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002ac8:	03400613          	li	a2,52
    80002acc:	05b1                	addi	a1,a1,12
    80002ace:	05048513          	addi	a0,s1,80
    80002ad2:	ffffd097          	auipc	ra,0xffffd
    80002ad6:	600080e7          	jalr	1536(ra) # 800000d2 <memmove>
    brelse(bp);
    80002ada:	854a                	mv	a0,s2
    80002adc:	00000097          	auipc	ra,0x0
    80002ae0:	876080e7          	jalr	-1930(ra) # 80002352 <brelse>
    ip->valid = 1;
    80002ae4:	4785                	li	a5,1
    80002ae6:	c0bc                	sw	a5,64(s1)
    if (ip->type == 0) panic("ilock: no type");
    80002ae8:	04449783          	lh	a5,68(s1)
    80002aec:	fbb5                	bnez	a5,80002a60 <ilock+0x24>
    80002aee:	00006517          	auipc	a0,0x6
    80002af2:	a9a50513          	addi	a0,a0,-1382 # 80008588 <syscalls+0x188>
    80002af6:	00004097          	auipc	ra,0x4
    80002afa:	c42080e7          	jalr	-958(ra) # 80006738 <panic>

0000000080002afe <iunlock>:
void iunlock(struct inode *ip) {
    80002afe:	1101                	addi	sp,sp,-32
    80002b00:	ec06                	sd	ra,24(sp)
    80002b02:	e822                	sd	s0,16(sp)
    80002b04:	e426                	sd	s1,8(sp)
    80002b06:	e04a                	sd	s2,0(sp)
    80002b08:	1000                	addi	s0,sp,32
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1) panic("iunlock");
    80002b0a:	c905                	beqz	a0,80002b3a <iunlock+0x3c>
    80002b0c:	84aa                	mv	s1,a0
    80002b0e:	01050913          	addi	s2,a0,16
    80002b12:	854a                	mv	a0,s2
    80002b14:	00001097          	auipc	ra,0x1
    80002b18:	c7c080e7          	jalr	-900(ra) # 80003790 <holdingsleep>
    80002b1c:	cd19                	beqz	a0,80002b3a <iunlock+0x3c>
    80002b1e:	449c                	lw	a5,8(s1)
    80002b20:	00f05d63          	blez	a5,80002b3a <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002b24:	854a                	mv	a0,s2
    80002b26:	00001097          	auipc	ra,0x1
    80002b2a:	c26080e7          	jalr	-986(ra) # 8000374c <releasesleep>
}
    80002b2e:	60e2                	ld	ra,24(sp)
    80002b30:	6442                	ld	s0,16(sp)
    80002b32:	64a2                	ld	s1,8(sp)
    80002b34:	6902                	ld	s2,0(sp)
    80002b36:	6105                	addi	sp,sp,32
    80002b38:	8082                	ret
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1) panic("iunlock");
    80002b3a:	00006517          	auipc	a0,0x6
    80002b3e:	a5e50513          	addi	a0,a0,-1442 # 80008598 <syscalls+0x198>
    80002b42:	00004097          	auipc	ra,0x4
    80002b46:	bf6080e7          	jalr	-1034(ra) # 80006738 <panic>

0000000080002b4a <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void itrunc(struct inode *ip) {
    80002b4a:	7179                	addi	sp,sp,-48
    80002b4c:	f406                	sd	ra,40(sp)
    80002b4e:	f022                	sd	s0,32(sp)
    80002b50:	ec26                	sd	s1,24(sp)
    80002b52:	e84a                	sd	s2,16(sp)
    80002b54:	e44e                	sd	s3,8(sp)
    80002b56:	e052                	sd	s4,0(sp)
    80002b58:	1800                	addi	s0,sp,48
    80002b5a:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for (i = 0; i < NDIRECT; i++) {
    80002b5c:	05050493          	addi	s1,a0,80
    80002b60:	08050913          	addi	s2,a0,128
    80002b64:	a021                	j	80002b6c <itrunc+0x22>
    80002b66:	0491                	addi	s1,s1,4
    80002b68:	01248d63          	beq	s1,s2,80002b82 <itrunc+0x38>
    if (ip->addrs[i]) {
    80002b6c:	408c                	lw	a1,0(s1)
    80002b6e:	dde5                	beqz	a1,80002b66 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002b70:	0009a503          	lw	a0,0(s3)
    80002b74:	00000097          	auipc	ra,0x0
    80002b78:	8f4080e7          	jalr	-1804(ra) # 80002468 <bfree>
      ip->addrs[i] = 0;
    80002b7c:	0004a023          	sw	zero,0(s1)
    80002b80:	b7dd                	j	80002b66 <itrunc+0x1c>
    }
  }

  if (ip->addrs[NDIRECT]) {
    80002b82:	0809a583          	lw	a1,128(s3)
    80002b86:	e185                	bnez	a1,80002ba6 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002b88:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002b8c:	854e                	mv	a0,s3
    80002b8e:	00000097          	auipc	ra,0x0
    80002b92:	de4080e7          	jalr	-540(ra) # 80002972 <iupdate>
}
    80002b96:	70a2                	ld	ra,40(sp)
    80002b98:	7402                	ld	s0,32(sp)
    80002b9a:	64e2                	ld	s1,24(sp)
    80002b9c:	6942                	ld	s2,16(sp)
    80002b9e:	69a2                	ld	s3,8(sp)
    80002ba0:	6a02                	ld	s4,0(sp)
    80002ba2:	6145                	addi	sp,sp,48
    80002ba4:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002ba6:	0009a503          	lw	a0,0(s3)
    80002baa:	fffff097          	auipc	ra,0xfffff
    80002bae:	678080e7          	jalr	1656(ra) # 80002222 <bread>
    80002bb2:	8a2a                	mv	s4,a0
    for (j = 0; j < NINDIRECT; j++) {
    80002bb4:	05850493          	addi	s1,a0,88
    80002bb8:	45850913          	addi	s2,a0,1112
    80002bbc:	a021                	j	80002bc4 <itrunc+0x7a>
    80002bbe:	0491                	addi	s1,s1,4
    80002bc0:	01248b63          	beq	s1,s2,80002bd6 <itrunc+0x8c>
      if (a[j]) bfree(ip->dev, a[j]);
    80002bc4:	408c                	lw	a1,0(s1)
    80002bc6:	dde5                	beqz	a1,80002bbe <itrunc+0x74>
    80002bc8:	0009a503          	lw	a0,0(s3)
    80002bcc:	00000097          	auipc	ra,0x0
    80002bd0:	89c080e7          	jalr	-1892(ra) # 80002468 <bfree>
    80002bd4:	b7ed                	j	80002bbe <itrunc+0x74>
    brelse(bp);
    80002bd6:	8552                	mv	a0,s4
    80002bd8:	fffff097          	auipc	ra,0xfffff
    80002bdc:	77a080e7          	jalr	1914(ra) # 80002352 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002be0:	0809a583          	lw	a1,128(s3)
    80002be4:	0009a503          	lw	a0,0(s3)
    80002be8:	00000097          	auipc	ra,0x0
    80002bec:	880080e7          	jalr	-1920(ra) # 80002468 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002bf0:	0809a023          	sw	zero,128(s3)
    80002bf4:	bf51                	j	80002b88 <itrunc+0x3e>

0000000080002bf6 <iput>:
void iput(struct inode *ip) {
    80002bf6:	1101                	addi	sp,sp,-32
    80002bf8:	ec06                	sd	ra,24(sp)
    80002bfa:	e822                	sd	s0,16(sp)
    80002bfc:	e426                	sd	s1,8(sp)
    80002bfe:	e04a                	sd	s2,0(sp)
    80002c00:	1000                	addi	s0,sp,32
    80002c02:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002c04:	00014517          	auipc	a0,0x14
    80002c08:	36450513          	addi	a0,a0,868 # 80016f68 <itable>
    80002c0c:	00004097          	auipc	ra,0x4
    80002c10:	068080e7          	jalr	104(ra) # 80006c74 <acquire>
  if (ip->ref == 1 && ip->valid && ip->nlink == 0) {
    80002c14:	4498                	lw	a4,8(s1)
    80002c16:	4785                	li	a5,1
    80002c18:	02f70363          	beq	a4,a5,80002c3e <iput+0x48>
  ip->ref--;
    80002c1c:	449c                	lw	a5,8(s1)
    80002c1e:	37fd                	addiw	a5,a5,-1
    80002c20:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002c22:	00014517          	auipc	a0,0x14
    80002c26:	34650513          	addi	a0,a0,838 # 80016f68 <itable>
    80002c2a:	00004097          	auipc	ra,0x4
    80002c2e:	0fe080e7          	jalr	254(ra) # 80006d28 <release>
}
    80002c32:	60e2                	ld	ra,24(sp)
    80002c34:	6442                	ld	s0,16(sp)
    80002c36:	64a2                	ld	s1,8(sp)
    80002c38:	6902                	ld	s2,0(sp)
    80002c3a:	6105                	addi	sp,sp,32
    80002c3c:	8082                	ret
  if (ip->ref == 1 && ip->valid && ip->nlink == 0) {
    80002c3e:	40bc                	lw	a5,64(s1)
    80002c40:	dff1                	beqz	a5,80002c1c <iput+0x26>
    80002c42:	04a49783          	lh	a5,74(s1)
    80002c46:	fbf9                	bnez	a5,80002c1c <iput+0x26>
    acquiresleep(&ip->lock);
    80002c48:	01048913          	addi	s2,s1,16
    80002c4c:	854a                	mv	a0,s2
    80002c4e:	00001097          	auipc	ra,0x1
    80002c52:	aa8080e7          	jalr	-1368(ra) # 800036f6 <acquiresleep>
    release(&itable.lock);
    80002c56:	00014517          	auipc	a0,0x14
    80002c5a:	31250513          	addi	a0,a0,786 # 80016f68 <itable>
    80002c5e:	00004097          	auipc	ra,0x4
    80002c62:	0ca080e7          	jalr	202(ra) # 80006d28 <release>
    itrunc(ip);
    80002c66:	8526                	mv	a0,s1
    80002c68:	00000097          	auipc	ra,0x0
    80002c6c:	ee2080e7          	jalr	-286(ra) # 80002b4a <itrunc>
    ip->type = 0;
    80002c70:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002c74:	8526                	mv	a0,s1
    80002c76:	00000097          	auipc	ra,0x0
    80002c7a:	cfc080e7          	jalr	-772(ra) # 80002972 <iupdate>
    ip->valid = 0;
    80002c7e:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002c82:	854a                	mv	a0,s2
    80002c84:	00001097          	auipc	ra,0x1
    80002c88:	ac8080e7          	jalr	-1336(ra) # 8000374c <releasesleep>
    acquire(&itable.lock);
    80002c8c:	00014517          	auipc	a0,0x14
    80002c90:	2dc50513          	addi	a0,a0,732 # 80016f68 <itable>
    80002c94:	00004097          	auipc	ra,0x4
    80002c98:	fe0080e7          	jalr	-32(ra) # 80006c74 <acquire>
    80002c9c:	b741                	j	80002c1c <iput+0x26>

0000000080002c9e <iunlockput>:
void iunlockput(struct inode *ip) {
    80002c9e:	1101                	addi	sp,sp,-32
    80002ca0:	ec06                	sd	ra,24(sp)
    80002ca2:	e822                	sd	s0,16(sp)
    80002ca4:	e426                	sd	s1,8(sp)
    80002ca6:	1000                	addi	s0,sp,32
    80002ca8:	84aa                	mv	s1,a0
  iunlock(ip);
    80002caa:	00000097          	auipc	ra,0x0
    80002cae:	e54080e7          	jalr	-428(ra) # 80002afe <iunlock>
  iput(ip);
    80002cb2:	8526                	mv	a0,s1
    80002cb4:	00000097          	auipc	ra,0x0
    80002cb8:	f42080e7          	jalr	-190(ra) # 80002bf6 <iput>
}
    80002cbc:	60e2                	ld	ra,24(sp)
    80002cbe:	6442                	ld	s0,16(sp)
    80002cc0:	64a2                	ld	s1,8(sp)
    80002cc2:	6105                	addi	sp,sp,32
    80002cc4:	8082                	ret

0000000080002cc6 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void stati(struct inode *ip, struct stat *st) {
    80002cc6:	1141                	addi	sp,sp,-16
    80002cc8:	e422                	sd	s0,8(sp)
    80002cca:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002ccc:	411c                	lw	a5,0(a0)
    80002cce:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002cd0:	415c                	lw	a5,4(a0)
    80002cd2:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002cd4:	04451783          	lh	a5,68(a0)
    80002cd8:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002cdc:	04a51783          	lh	a5,74(a0)
    80002ce0:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002ce4:	04c56783          	lwu	a5,76(a0)
    80002ce8:	e99c                	sd	a5,16(a1)
}
    80002cea:	6422                	ld	s0,8(sp)
    80002cec:	0141                	addi	sp,sp,16
    80002cee:	8082                	ret

0000000080002cf0 <readi>:
// otherwise, dst is a kernel address.
int readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n) {
  uint tot, m;
  struct buf *bp;

  if (off > ip->size || off + n < off) return 0;
    80002cf0:	457c                	lw	a5,76(a0)
    80002cf2:	0ed7e963          	bltu	a5,a3,80002de4 <readi+0xf4>
int readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n) {
    80002cf6:	7159                	addi	sp,sp,-112
    80002cf8:	f486                	sd	ra,104(sp)
    80002cfa:	f0a2                	sd	s0,96(sp)
    80002cfc:	eca6                	sd	s1,88(sp)
    80002cfe:	e8ca                	sd	s2,80(sp)
    80002d00:	e4ce                	sd	s3,72(sp)
    80002d02:	e0d2                	sd	s4,64(sp)
    80002d04:	fc56                	sd	s5,56(sp)
    80002d06:	f85a                	sd	s6,48(sp)
    80002d08:	f45e                	sd	s7,40(sp)
    80002d0a:	f062                	sd	s8,32(sp)
    80002d0c:	ec66                	sd	s9,24(sp)
    80002d0e:	e86a                	sd	s10,16(sp)
    80002d10:	e46e                	sd	s11,8(sp)
    80002d12:	1880                	addi	s0,sp,112
    80002d14:	8b2a                	mv	s6,a0
    80002d16:	8bae                	mv	s7,a1
    80002d18:	8a32                	mv	s4,a2
    80002d1a:	84b6                	mv	s1,a3
    80002d1c:	8aba                	mv	s5,a4
  if (off > ip->size || off + n < off) return 0;
    80002d1e:	9f35                	addw	a4,a4,a3
    80002d20:	4501                	li	a0,0
    80002d22:	0ad76063          	bltu	a4,a3,80002dc2 <readi+0xd2>
  if (off + n > ip->size) n = ip->size - off;
    80002d26:	00e7f463          	bgeu	a5,a4,80002d2e <readi+0x3e>
    80002d2a:	40d78abb          	subw	s5,a5,a3

  for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    80002d2e:	0a0a8963          	beqz	s5,80002de0 <readi+0xf0>
    80002d32:	4981                	li	s3,0
    uint addr = bmap(ip, off / BSIZE);
    if (addr == 0) break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off % BSIZE);
    80002d34:	40000c93          	li	s9,1024
    if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002d38:	5c7d                	li	s8,-1
    80002d3a:	a82d                	j	80002d74 <readi+0x84>
    80002d3c:	020d1d93          	slli	s11,s10,0x20
    80002d40:	020ddd93          	srli	s11,s11,0x20
    80002d44:	05890793          	addi	a5,s2,88
    80002d48:	86ee                	mv	a3,s11
    80002d4a:	963e                	add	a2,a2,a5
    80002d4c:	85d2                	mv	a1,s4
    80002d4e:	855e                	mv	a0,s7
    80002d50:	fffff097          	auipc	ra,0xfffff
    80002d54:	b0c080e7          	jalr	-1268(ra) # 8000185c <either_copyout>
    80002d58:	05850d63          	beq	a0,s8,80002db2 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002d5c:	854a                	mv	a0,s2
    80002d5e:	fffff097          	auipc	ra,0xfffff
    80002d62:	5f4080e7          	jalr	1524(ra) # 80002352 <brelse>
  for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    80002d66:	013d09bb          	addw	s3,s10,s3
    80002d6a:	009d04bb          	addw	s1,s10,s1
    80002d6e:	9a6e                	add	s4,s4,s11
    80002d70:	0559f763          	bgeu	s3,s5,80002dbe <readi+0xce>
    uint addr = bmap(ip, off / BSIZE);
    80002d74:	00a4d59b          	srliw	a1,s1,0xa
    80002d78:	855a                	mv	a0,s6
    80002d7a:	00000097          	auipc	ra,0x0
    80002d7e:	8a2080e7          	jalr	-1886(ra) # 8000261c <bmap>
    80002d82:	0005059b          	sext.w	a1,a0
    if (addr == 0) break;
    80002d86:	cd85                	beqz	a1,80002dbe <readi+0xce>
    bp = bread(ip->dev, addr);
    80002d88:	000b2503          	lw	a0,0(s6)
    80002d8c:	fffff097          	auipc	ra,0xfffff
    80002d90:	496080e7          	jalr	1174(ra) # 80002222 <bread>
    80002d94:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off % BSIZE);
    80002d96:	3ff4f613          	andi	a2,s1,1023
    80002d9a:	40cc87bb          	subw	a5,s9,a2
    80002d9e:	413a873b          	subw	a4,s5,s3
    80002da2:	8d3e                	mv	s10,a5
    80002da4:	2781                	sext.w	a5,a5
    80002da6:	0007069b          	sext.w	a3,a4
    80002daa:	f8f6f9e3          	bgeu	a3,a5,80002d3c <readi+0x4c>
    80002dae:	8d3a                	mv	s10,a4
    80002db0:	b771                	j	80002d3c <readi+0x4c>
      brelse(bp);
    80002db2:	854a                	mv	a0,s2
    80002db4:	fffff097          	auipc	ra,0xfffff
    80002db8:	59e080e7          	jalr	1438(ra) # 80002352 <brelse>
      tot = -1;
    80002dbc:	59fd                	li	s3,-1
  }
  return tot;
    80002dbe:	0009851b          	sext.w	a0,s3
}
    80002dc2:	70a6                	ld	ra,104(sp)
    80002dc4:	7406                	ld	s0,96(sp)
    80002dc6:	64e6                	ld	s1,88(sp)
    80002dc8:	6946                	ld	s2,80(sp)
    80002dca:	69a6                	ld	s3,72(sp)
    80002dcc:	6a06                	ld	s4,64(sp)
    80002dce:	7ae2                	ld	s5,56(sp)
    80002dd0:	7b42                	ld	s6,48(sp)
    80002dd2:	7ba2                	ld	s7,40(sp)
    80002dd4:	7c02                	ld	s8,32(sp)
    80002dd6:	6ce2                	ld	s9,24(sp)
    80002dd8:	6d42                	ld	s10,16(sp)
    80002dda:	6da2                	ld	s11,8(sp)
    80002ddc:	6165                	addi	sp,sp,112
    80002dde:	8082                	ret
  for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    80002de0:	89d6                	mv	s3,s5
    80002de2:	bff1                	j	80002dbe <readi+0xce>
  if (off > ip->size || off + n < off) return 0;
    80002de4:	4501                	li	a0,0
}
    80002de6:	8082                	ret

0000000080002de8 <writei>:
// there was an error of some kind.
int writei(struct inode *ip, int user_src, uint64 src, uint off, uint n) {
  uint tot, m;
  struct buf *bp;

  if (off > ip->size || off + n < off) return -1;
    80002de8:	457c                	lw	a5,76(a0)
    80002dea:	10d7e863          	bltu	a5,a3,80002efa <writei+0x112>
int writei(struct inode *ip, int user_src, uint64 src, uint off, uint n) {
    80002dee:	7159                	addi	sp,sp,-112
    80002df0:	f486                	sd	ra,104(sp)
    80002df2:	f0a2                	sd	s0,96(sp)
    80002df4:	eca6                	sd	s1,88(sp)
    80002df6:	e8ca                	sd	s2,80(sp)
    80002df8:	e4ce                	sd	s3,72(sp)
    80002dfa:	e0d2                	sd	s4,64(sp)
    80002dfc:	fc56                	sd	s5,56(sp)
    80002dfe:	f85a                	sd	s6,48(sp)
    80002e00:	f45e                	sd	s7,40(sp)
    80002e02:	f062                	sd	s8,32(sp)
    80002e04:	ec66                	sd	s9,24(sp)
    80002e06:	e86a                	sd	s10,16(sp)
    80002e08:	e46e                	sd	s11,8(sp)
    80002e0a:	1880                	addi	s0,sp,112
    80002e0c:	8aaa                	mv	s5,a0
    80002e0e:	8bae                	mv	s7,a1
    80002e10:	8a32                	mv	s4,a2
    80002e12:	8936                	mv	s2,a3
    80002e14:	8b3a                	mv	s6,a4
  if (off > ip->size || off + n < off) return -1;
    80002e16:	00e687bb          	addw	a5,a3,a4
    80002e1a:	0ed7e263          	bltu	a5,a3,80002efe <writei+0x116>
  if (off + n > MAXFILE * BSIZE) return -1;
    80002e1e:	00043737          	lui	a4,0x43
    80002e22:	0ef76063          	bltu	a4,a5,80002f02 <writei+0x11a>

  for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80002e26:	0c0b0863          	beqz	s6,80002ef6 <writei+0x10e>
    80002e2a:	4981                	li	s3,0
    uint addr = bmap(ip, off / BSIZE);
    if (addr == 0) break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off % BSIZE);
    80002e2c:	40000c93          	li	s9,1024
    if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002e30:	5c7d                	li	s8,-1
    80002e32:	a091                	j	80002e76 <writei+0x8e>
    80002e34:	020d1d93          	slli	s11,s10,0x20
    80002e38:	020ddd93          	srli	s11,s11,0x20
    80002e3c:	05848793          	addi	a5,s1,88
    80002e40:	86ee                	mv	a3,s11
    80002e42:	8652                	mv	a2,s4
    80002e44:	85de                	mv	a1,s7
    80002e46:	953e                	add	a0,a0,a5
    80002e48:	fffff097          	auipc	ra,0xfffff
    80002e4c:	a6a080e7          	jalr	-1430(ra) # 800018b2 <either_copyin>
    80002e50:	07850263          	beq	a0,s8,80002eb4 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002e54:	8526                	mv	a0,s1
    80002e56:	00000097          	auipc	ra,0x0
    80002e5a:	780080e7          	jalr	1920(ra) # 800035d6 <log_write>
    brelse(bp);
    80002e5e:	8526                	mv	a0,s1
    80002e60:	fffff097          	auipc	ra,0xfffff
    80002e64:	4f2080e7          	jalr	1266(ra) # 80002352 <brelse>
  for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80002e68:	013d09bb          	addw	s3,s10,s3
    80002e6c:	012d093b          	addw	s2,s10,s2
    80002e70:	9a6e                	add	s4,s4,s11
    80002e72:	0569f663          	bgeu	s3,s6,80002ebe <writei+0xd6>
    uint addr = bmap(ip, off / BSIZE);
    80002e76:	00a9559b          	srliw	a1,s2,0xa
    80002e7a:	8556                	mv	a0,s5
    80002e7c:	fffff097          	auipc	ra,0xfffff
    80002e80:	7a0080e7          	jalr	1952(ra) # 8000261c <bmap>
    80002e84:	0005059b          	sext.w	a1,a0
    if (addr == 0) break;
    80002e88:	c99d                	beqz	a1,80002ebe <writei+0xd6>
    bp = bread(ip->dev, addr);
    80002e8a:	000aa503          	lw	a0,0(s5)
    80002e8e:	fffff097          	auipc	ra,0xfffff
    80002e92:	394080e7          	jalr	916(ra) # 80002222 <bread>
    80002e96:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off % BSIZE);
    80002e98:	3ff97513          	andi	a0,s2,1023
    80002e9c:	40ac87bb          	subw	a5,s9,a0
    80002ea0:	413b073b          	subw	a4,s6,s3
    80002ea4:	8d3e                	mv	s10,a5
    80002ea6:	2781                	sext.w	a5,a5
    80002ea8:	0007069b          	sext.w	a3,a4
    80002eac:	f8f6f4e3          	bgeu	a3,a5,80002e34 <writei+0x4c>
    80002eb0:	8d3a                	mv	s10,a4
    80002eb2:	b749                	j	80002e34 <writei+0x4c>
      brelse(bp);
    80002eb4:	8526                	mv	a0,s1
    80002eb6:	fffff097          	auipc	ra,0xfffff
    80002eba:	49c080e7          	jalr	1180(ra) # 80002352 <brelse>
  }

  if (off > ip->size) ip->size = off;
    80002ebe:	04caa783          	lw	a5,76(s5)
    80002ec2:	0127f463          	bgeu	a5,s2,80002eca <writei+0xe2>
    80002ec6:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002eca:	8556                	mv	a0,s5
    80002ecc:	00000097          	auipc	ra,0x0
    80002ed0:	aa6080e7          	jalr	-1370(ra) # 80002972 <iupdate>

  return tot;
    80002ed4:	0009851b          	sext.w	a0,s3
}
    80002ed8:	70a6                	ld	ra,104(sp)
    80002eda:	7406                	ld	s0,96(sp)
    80002edc:	64e6                	ld	s1,88(sp)
    80002ede:	6946                	ld	s2,80(sp)
    80002ee0:	69a6                	ld	s3,72(sp)
    80002ee2:	6a06                	ld	s4,64(sp)
    80002ee4:	7ae2                	ld	s5,56(sp)
    80002ee6:	7b42                	ld	s6,48(sp)
    80002ee8:	7ba2                	ld	s7,40(sp)
    80002eea:	7c02                	ld	s8,32(sp)
    80002eec:	6ce2                	ld	s9,24(sp)
    80002eee:	6d42                	ld	s10,16(sp)
    80002ef0:	6da2                	ld	s11,8(sp)
    80002ef2:	6165                	addi	sp,sp,112
    80002ef4:	8082                	ret
  for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80002ef6:	89da                	mv	s3,s6
    80002ef8:	bfc9                	j	80002eca <writei+0xe2>
  if (off > ip->size || off + n < off) return -1;
    80002efa:	557d                	li	a0,-1
}
    80002efc:	8082                	ret
  if (off > ip->size || off + n < off) return -1;
    80002efe:	557d                	li	a0,-1
    80002f00:	bfe1                	j	80002ed8 <writei+0xf0>
  if (off + n > MAXFILE * BSIZE) return -1;
    80002f02:	557d                	li	a0,-1
    80002f04:	bfd1                	j	80002ed8 <writei+0xf0>

0000000080002f06 <namecmp>:

// Directories

int namecmp(const char *s, const char *t) { return strncmp(s, t, DIRSIZ); }
    80002f06:	1141                	addi	sp,sp,-16
    80002f08:	e406                	sd	ra,8(sp)
    80002f0a:	e022                	sd	s0,0(sp)
    80002f0c:	0800                	addi	s0,sp,16
    80002f0e:	4639                	li	a2,14
    80002f10:	ffffd097          	auipc	ra,0xffffd
    80002f14:	236080e7          	jalr	566(ra) # 80000146 <strncmp>
    80002f18:	60a2                	ld	ra,8(sp)
    80002f1a:	6402                	ld	s0,0(sp)
    80002f1c:	0141                	addi	sp,sp,16
    80002f1e:	8082                	ret

0000000080002f20 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode *dirlookup(struct inode *dp, char *name, uint *poff) {
    80002f20:	7139                	addi	sp,sp,-64
    80002f22:	fc06                	sd	ra,56(sp)
    80002f24:	f822                	sd	s0,48(sp)
    80002f26:	f426                	sd	s1,40(sp)
    80002f28:	f04a                	sd	s2,32(sp)
    80002f2a:	ec4e                	sd	s3,24(sp)
    80002f2c:	e852                	sd	s4,16(sp)
    80002f2e:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if (dp->type != T_DIR) panic("dirlookup not DIR");
    80002f30:	04451703          	lh	a4,68(a0)
    80002f34:	4785                	li	a5,1
    80002f36:	00f71a63          	bne	a4,a5,80002f4a <dirlookup+0x2a>
    80002f3a:	892a                	mv	s2,a0
    80002f3c:	89ae                	mv	s3,a1
    80002f3e:	8a32                	mv	s4,a2

  for (off = 0; off < dp->size; off += sizeof(de)) {
    80002f40:	457c                	lw	a5,76(a0)
    80002f42:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002f44:	4501                	li	a0,0
  for (off = 0; off < dp->size; off += sizeof(de)) {
    80002f46:	e79d                	bnez	a5,80002f74 <dirlookup+0x54>
    80002f48:	a8a5                	j	80002fc0 <dirlookup+0xa0>
  if (dp->type != T_DIR) panic("dirlookup not DIR");
    80002f4a:	00005517          	auipc	a0,0x5
    80002f4e:	65650513          	addi	a0,a0,1622 # 800085a0 <syscalls+0x1a0>
    80002f52:	00003097          	auipc	ra,0x3
    80002f56:	7e6080e7          	jalr	2022(ra) # 80006738 <panic>
      panic("dirlookup read");
    80002f5a:	00005517          	auipc	a0,0x5
    80002f5e:	65e50513          	addi	a0,a0,1630 # 800085b8 <syscalls+0x1b8>
    80002f62:	00003097          	auipc	ra,0x3
    80002f66:	7d6080e7          	jalr	2006(ra) # 80006738 <panic>
  for (off = 0; off < dp->size; off += sizeof(de)) {
    80002f6a:	24c1                	addiw	s1,s1,16
    80002f6c:	04c92783          	lw	a5,76(s2)
    80002f70:	04f4f763          	bgeu	s1,a5,80002fbe <dirlookup+0x9e>
    if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002f74:	4741                	li	a4,16
    80002f76:	86a6                	mv	a3,s1
    80002f78:	fc040613          	addi	a2,s0,-64
    80002f7c:	4581                	li	a1,0
    80002f7e:	854a                	mv	a0,s2
    80002f80:	00000097          	auipc	ra,0x0
    80002f84:	d70080e7          	jalr	-656(ra) # 80002cf0 <readi>
    80002f88:	47c1                	li	a5,16
    80002f8a:	fcf518e3          	bne	a0,a5,80002f5a <dirlookup+0x3a>
    if (de.inum == 0) continue;
    80002f8e:	fc045783          	lhu	a5,-64(s0)
    80002f92:	dfe1                	beqz	a5,80002f6a <dirlookup+0x4a>
    if (namecmp(name, de.name) == 0) {
    80002f94:	fc240593          	addi	a1,s0,-62
    80002f98:	854e                	mv	a0,s3
    80002f9a:	00000097          	auipc	ra,0x0
    80002f9e:	f6c080e7          	jalr	-148(ra) # 80002f06 <namecmp>
    80002fa2:	f561                	bnez	a0,80002f6a <dirlookup+0x4a>
      if (poff) *poff = off;
    80002fa4:	000a0463          	beqz	s4,80002fac <dirlookup+0x8c>
    80002fa8:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80002fac:	fc045583          	lhu	a1,-64(s0)
    80002fb0:	00092503          	lw	a0,0(s2)
    80002fb4:	fffff097          	auipc	ra,0xfffff
    80002fb8:	750080e7          	jalr	1872(ra) # 80002704 <iget>
    80002fbc:	a011                	j	80002fc0 <dirlookup+0xa0>
  return 0;
    80002fbe:	4501                	li	a0,0
}
    80002fc0:	70e2                	ld	ra,56(sp)
    80002fc2:	7442                	ld	s0,48(sp)
    80002fc4:	74a2                	ld	s1,40(sp)
    80002fc6:	7902                	ld	s2,32(sp)
    80002fc8:	69e2                	ld	s3,24(sp)
    80002fca:	6a42                	ld	s4,16(sp)
    80002fcc:	6121                	addi	sp,sp,64
    80002fce:	8082                	ret

0000000080002fd0 <namex>:

// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode *namex(char *path, int nameiparent, char *name) {
    80002fd0:	711d                	addi	sp,sp,-96
    80002fd2:	ec86                	sd	ra,88(sp)
    80002fd4:	e8a2                	sd	s0,80(sp)
    80002fd6:	e4a6                	sd	s1,72(sp)
    80002fd8:	e0ca                	sd	s2,64(sp)
    80002fda:	fc4e                	sd	s3,56(sp)
    80002fdc:	f852                	sd	s4,48(sp)
    80002fde:	f456                	sd	s5,40(sp)
    80002fe0:	f05a                	sd	s6,32(sp)
    80002fe2:	ec5e                	sd	s7,24(sp)
    80002fe4:	e862                	sd	s8,16(sp)
    80002fe6:	e466                	sd	s9,8(sp)
    80002fe8:	1080                	addi	s0,sp,96
    80002fea:	84aa                	mv	s1,a0
    80002fec:	8aae                	mv	s5,a1
    80002fee:	8a32                	mv	s4,a2
  struct inode *ip, *next;

  if (*path == '/')
    80002ff0:	00054703          	lbu	a4,0(a0)
    80002ff4:	02f00793          	li	a5,47
    80002ff8:	02f70363          	beq	a4,a5,8000301e <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80002ffc:	ffffe097          	auipc	ra,0xffffe
    80003000:	dac080e7          	jalr	-596(ra) # 80000da8 <myproc>
    80003004:	15053503          	ld	a0,336(a0)
    80003008:	00000097          	auipc	ra,0x0
    8000300c:	9f6080e7          	jalr	-1546(ra) # 800029fe <idup>
    80003010:	89aa                	mv	s3,a0
  while (*path == '/') path++;
    80003012:	02f00913          	li	s2,47
  len = path - s;
    80003016:	4b01                	li	s6,0
  if (len >= DIRSIZ)
    80003018:	4c35                	li	s8,13

  while ((path = skipelem(path, name)) != 0) {
    ilock(ip);
    if (ip->type != T_DIR) {
    8000301a:	4b85                	li	s7,1
    8000301c:	a865                	j	800030d4 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    8000301e:	4585                	li	a1,1
    80003020:	4505                	li	a0,1
    80003022:	fffff097          	auipc	ra,0xfffff
    80003026:	6e2080e7          	jalr	1762(ra) # 80002704 <iget>
    8000302a:	89aa                	mv	s3,a0
    8000302c:	b7dd                	j	80003012 <namex+0x42>
      iunlockput(ip);
    8000302e:	854e                	mv	a0,s3
    80003030:	00000097          	auipc	ra,0x0
    80003034:	c6e080e7          	jalr	-914(ra) # 80002c9e <iunlockput>
      return 0;
    80003038:	4981                	li	s3,0
  if (nameiparent) {
    iput(ip);
    return 0;
  }
  return ip;
}
    8000303a:	854e                	mv	a0,s3
    8000303c:	60e6                	ld	ra,88(sp)
    8000303e:	6446                	ld	s0,80(sp)
    80003040:	64a6                	ld	s1,72(sp)
    80003042:	6906                	ld	s2,64(sp)
    80003044:	79e2                	ld	s3,56(sp)
    80003046:	7a42                	ld	s4,48(sp)
    80003048:	7aa2                	ld	s5,40(sp)
    8000304a:	7b02                	ld	s6,32(sp)
    8000304c:	6be2                	ld	s7,24(sp)
    8000304e:	6c42                	ld	s8,16(sp)
    80003050:	6ca2                	ld	s9,8(sp)
    80003052:	6125                	addi	sp,sp,96
    80003054:	8082                	ret
      iunlock(ip);
    80003056:	854e                	mv	a0,s3
    80003058:	00000097          	auipc	ra,0x0
    8000305c:	aa6080e7          	jalr	-1370(ra) # 80002afe <iunlock>
      return ip;
    80003060:	bfe9                	j	8000303a <namex+0x6a>
      iunlockput(ip);
    80003062:	854e                	mv	a0,s3
    80003064:	00000097          	auipc	ra,0x0
    80003068:	c3a080e7          	jalr	-966(ra) # 80002c9e <iunlockput>
      return 0;
    8000306c:	89e6                	mv	s3,s9
    8000306e:	b7f1                	j	8000303a <namex+0x6a>
  len = path - s;
    80003070:	40b48633          	sub	a2,s1,a1
    80003074:	00060c9b          	sext.w	s9,a2
  if (len >= DIRSIZ)
    80003078:	099c5463          	bge	s8,s9,80003100 <namex+0x130>
    memmove(name, s, DIRSIZ);
    8000307c:	4639                	li	a2,14
    8000307e:	8552                	mv	a0,s4
    80003080:	ffffd097          	auipc	ra,0xffffd
    80003084:	052080e7          	jalr	82(ra) # 800000d2 <memmove>
  while (*path == '/') path++;
    80003088:	0004c783          	lbu	a5,0(s1)
    8000308c:	01279763          	bne	a5,s2,8000309a <namex+0xca>
    80003090:	0485                	addi	s1,s1,1
    80003092:	0004c783          	lbu	a5,0(s1)
    80003096:	ff278de3          	beq	a5,s2,80003090 <namex+0xc0>
    ilock(ip);
    8000309a:	854e                	mv	a0,s3
    8000309c:	00000097          	auipc	ra,0x0
    800030a0:	9a0080e7          	jalr	-1632(ra) # 80002a3c <ilock>
    if (ip->type != T_DIR) {
    800030a4:	04499783          	lh	a5,68(s3)
    800030a8:	f97793e3          	bne	a5,s7,8000302e <namex+0x5e>
    if (nameiparent && *path == '\0') {
    800030ac:	000a8563          	beqz	s5,800030b6 <namex+0xe6>
    800030b0:	0004c783          	lbu	a5,0(s1)
    800030b4:	d3cd                	beqz	a5,80003056 <namex+0x86>
    if ((next = dirlookup(ip, name, 0)) == 0) {
    800030b6:	865a                	mv	a2,s6
    800030b8:	85d2                	mv	a1,s4
    800030ba:	854e                	mv	a0,s3
    800030bc:	00000097          	auipc	ra,0x0
    800030c0:	e64080e7          	jalr	-412(ra) # 80002f20 <dirlookup>
    800030c4:	8caa                	mv	s9,a0
    800030c6:	dd51                	beqz	a0,80003062 <namex+0x92>
    iunlockput(ip);
    800030c8:	854e                	mv	a0,s3
    800030ca:	00000097          	auipc	ra,0x0
    800030ce:	bd4080e7          	jalr	-1068(ra) # 80002c9e <iunlockput>
    ip = next;
    800030d2:	89e6                	mv	s3,s9
  while (*path == '/') path++;
    800030d4:	0004c783          	lbu	a5,0(s1)
    800030d8:	05279763          	bne	a5,s2,80003126 <namex+0x156>
    800030dc:	0485                	addi	s1,s1,1
    800030de:	0004c783          	lbu	a5,0(s1)
    800030e2:	ff278de3          	beq	a5,s2,800030dc <namex+0x10c>
  if (*path == 0) return 0;
    800030e6:	c79d                	beqz	a5,80003114 <namex+0x144>
  while (*path == '/') path++;
    800030e8:	85a6                	mv	a1,s1
  len = path - s;
    800030ea:	8cda                	mv	s9,s6
    800030ec:	865a                	mv	a2,s6
  while (*path != '/' && *path != 0) path++;
    800030ee:	01278963          	beq	a5,s2,80003100 <namex+0x130>
    800030f2:	dfbd                	beqz	a5,80003070 <namex+0xa0>
    800030f4:	0485                	addi	s1,s1,1
    800030f6:	0004c783          	lbu	a5,0(s1)
    800030fa:	ff279ce3          	bne	a5,s2,800030f2 <namex+0x122>
    800030fe:	bf8d                	j	80003070 <namex+0xa0>
    memmove(name, s, len);
    80003100:	2601                	sext.w	a2,a2
    80003102:	8552                	mv	a0,s4
    80003104:	ffffd097          	auipc	ra,0xffffd
    80003108:	fce080e7          	jalr	-50(ra) # 800000d2 <memmove>
    name[len] = 0;
    8000310c:	9cd2                	add	s9,s9,s4
    8000310e:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80003112:	bf9d                	j	80003088 <namex+0xb8>
  if (nameiparent) {
    80003114:	f20a83e3          	beqz	s5,8000303a <namex+0x6a>
    iput(ip);
    80003118:	854e                	mv	a0,s3
    8000311a:	00000097          	auipc	ra,0x0
    8000311e:	adc080e7          	jalr	-1316(ra) # 80002bf6 <iput>
    return 0;
    80003122:	4981                	li	s3,0
    80003124:	bf19                	j	8000303a <namex+0x6a>
  if (*path == 0) return 0;
    80003126:	d7fd                	beqz	a5,80003114 <namex+0x144>
  while (*path != '/' && *path != 0) path++;
    80003128:	0004c783          	lbu	a5,0(s1)
    8000312c:	85a6                	mv	a1,s1
    8000312e:	b7d1                	j	800030f2 <namex+0x122>

0000000080003130 <dirlink>:
int dirlink(struct inode *dp, char *name, uint inum) {
    80003130:	7139                	addi	sp,sp,-64
    80003132:	fc06                	sd	ra,56(sp)
    80003134:	f822                	sd	s0,48(sp)
    80003136:	f426                	sd	s1,40(sp)
    80003138:	f04a                	sd	s2,32(sp)
    8000313a:	ec4e                	sd	s3,24(sp)
    8000313c:	e852                	sd	s4,16(sp)
    8000313e:	0080                	addi	s0,sp,64
    80003140:	892a                	mv	s2,a0
    80003142:	8a2e                	mv	s4,a1
    80003144:	89b2                	mv	s3,a2
  if ((ip = dirlookup(dp, name, 0)) != 0) {
    80003146:	4601                	li	a2,0
    80003148:	00000097          	auipc	ra,0x0
    8000314c:	dd8080e7          	jalr	-552(ra) # 80002f20 <dirlookup>
    80003150:	e93d                	bnez	a0,800031c6 <dirlink+0x96>
  for (off = 0; off < dp->size; off += sizeof(de)) {
    80003152:	04c92483          	lw	s1,76(s2)
    80003156:	c49d                	beqz	s1,80003184 <dirlink+0x54>
    80003158:	4481                	li	s1,0
    if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000315a:	4741                	li	a4,16
    8000315c:	86a6                	mv	a3,s1
    8000315e:	fc040613          	addi	a2,s0,-64
    80003162:	4581                	li	a1,0
    80003164:	854a                	mv	a0,s2
    80003166:	00000097          	auipc	ra,0x0
    8000316a:	b8a080e7          	jalr	-1142(ra) # 80002cf0 <readi>
    8000316e:	47c1                	li	a5,16
    80003170:	06f51163          	bne	a0,a5,800031d2 <dirlink+0xa2>
    if (de.inum == 0) break;
    80003174:	fc045783          	lhu	a5,-64(s0)
    80003178:	c791                	beqz	a5,80003184 <dirlink+0x54>
  for (off = 0; off < dp->size; off += sizeof(de)) {
    8000317a:	24c1                	addiw	s1,s1,16
    8000317c:	04c92783          	lw	a5,76(s2)
    80003180:	fcf4ede3          	bltu	s1,a5,8000315a <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003184:	4639                	li	a2,14
    80003186:	85d2                	mv	a1,s4
    80003188:	fc240513          	addi	a0,s0,-62
    8000318c:	ffffd097          	auipc	ra,0xffffd
    80003190:	ff6080e7          	jalr	-10(ra) # 80000182 <strncpy>
  de.inum = inum;
    80003194:	fd341023          	sh	s3,-64(s0)
  if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) return -1;
    80003198:	4741                	li	a4,16
    8000319a:	86a6                	mv	a3,s1
    8000319c:	fc040613          	addi	a2,s0,-64
    800031a0:	4581                	li	a1,0
    800031a2:	854a                	mv	a0,s2
    800031a4:	00000097          	auipc	ra,0x0
    800031a8:	c44080e7          	jalr	-956(ra) # 80002de8 <writei>
    800031ac:	1541                	addi	a0,a0,-16
    800031ae:	00a03533          	snez	a0,a0
    800031b2:	40a00533          	neg	a0,a0
}
    800031b6:	70e2                	ld	ra,56(sp)
    800031b8:	7442                	ld	s0,48(sp)
    800031ba:	74a2                	ld	s1,40(sp)
    800031bc:	7902                	ld	s2,32(sp)
    800031be:	69e2                	ld	s3,24(sp)
    800031c0:	6a42                	ld	s4,16(sp)
    800031c2:	6121                	addi	sp,sp,64
    800031c4:	8082                	ret
    iput(ip);
    800031c6:	00000097          	auipc	ra,0x0
    800031ca:	a30080e7          	jalr	-1488(ra) # 80002bf6 <iput>
    return -1;
    800031ce:	557d                	li	a0,-1
    800031d0:	b7dd                	j	800031b6 <dirlink+0x86>
      panic("dirlink read");
    800031d2:	00005517          	auipc	a0,0x5
    800031d6:	3f650513          	addi	a0,a0,1014 # 800085c8 <syscalls+0x1c8>
    800031da:	00003097          	auipc	ra,0x3
    800031de:	55e080e7          	jalr	1374(ra) # 80006738 <panic>

00000000800031e2 <namei>:

struct inode *namei(char *path) {
    800031e2:	1101                	addi	sp,sp,-32
    800031e4:	ec06                	sd	ra,24(sp)
    800031e6:	e822                	sd	s0,16(sp)
    800031e8:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800031ea:	fe040613          	addi	a2,s0,-32
    800031ee:	4581                	li	a1,0
    800031f0:	00000097          	auipc	ra,0x0
    800031f4:	de0080e7          	jalr	-544(ra) # 80002fd0 <namex>
}
    800031f8:	60e2                	ld	ra,24(sp)
    800031fa:	6442                	ld	s0,16(sp)
    800031fc:	6105                	addi	sp,sp,32
    800031fe:	8082                	ret

0000000080003200 <nameiparent>:

struct inode *nameiparent(char *path, char *name) {
    80003200:	1141                	addi	sp,sp,-16
    80003202:	e406                	sd	ra,8(sp)
    80003204:	e022                	sd	s0,0(sp)
    80003206:	0800                	addi	s0,sp,16
    80003208:	862e                	mv	a2,a1
  return namex(path, 1, name);
    8000320a:	4585                	li	a1,1
    8000320c:	00000097          	auipc	ra,0x0
    80003210:	dc4080e7          	jalr	-572(ra) # 80002fd0 <namex>
}
    80003214:	60a2                	ld	ra,8(sp)
    80003216:	6402                	ld	s0,0(sp)
    80003218:	0141                	addi	sp,sp,16
    8000321a:	8082                	ret

000000008000321c <write_head>:
}

// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void write_head(void) {
    8000321c:	1101                	addi	sp,sp,-32
    8000321e:	ec06                	sd	ra,24(sp)
    80003220:	e822                	sd	s0,16(sp)
    80003222:	e426                	sd	s1,8(sp)
    80003224:	e04a                	sd	s2,0(sp)
    80003226:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003228:	00015917          	auipc	s2,0x15
    8000322c:	7e890913          	addi	s2,s2,2024 # 80018a10 <log>
    80003230:	01892583          	lw	a1,24(s2)
    80003234:	02892503          	lw	a0,40(s2)
    80003238:	fffff097          	auipc	ra,0xfffff
    8000323c:	fea080e7          	jalr	-22(ra) # 80002222 <bread>
    80003240:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *)(buf->data);
  int i;
  hb->n = log.lh.n;
    80003242:	02c92683          	lw	a3,44(s2)
    80003246:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003248:	02d05763          	blez	a3,80003276 <write_head+0x5a>
    8000324c:	00015797          	auipc	a5,0x15
    80003250:	7f478793          	addi	a5,a5,2036 # 80018a40 <log+0x30>
    80003254:	05c50713          	addi	a4,a0,92
    80003258:	36fd                	addiw	a3,a3,-1
    8000325a:	1682                	slli	a3,a3,0x20
    8000325c:	9281                	srli	a3,a3,0x20
    8000325e:	068a                	slli	a3,a3,0x2
    80003260:	00015617          	auipc	a2,0x15
    80003264:	7e460613          	addi	a2,a2,2020 # 80018a44 <log+0x34>
    80003268:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    8000326a:	4390                	lw	a2,0(a5)
    8000326c:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000326e:	0791                	addi	a5,a5,4
    80003270:	0711                	addi	a4,a4,4
    80003272:	fed79ce3          	bne	a5,a3,8000326a <write_head+0x4e>
  }
  bwrite(buf);
    80003276:	8526                	mv	a0,s1
    80003278:	fffff097          	auipc	ra,0xfffff
    8000327c:	09c080e7          	jalr	156(ra) # 80002314 <bwrite>
  brelse(buf);
    80003280:	8526                	mv	a0,s1
    80003282:	fffff097          	auipc	ra,0xfffff
    80003286:	0d0080e7          	jalr	208(ra) # 80002352 <brelse>
}
    8000328a:	60e2                	ld	ra,24(sp)
    8000328c:	6442                	ld	s0,16(sp)
    8000328e:	64a2                	ld	s1,8(sp)
    80003290:	6902                	ld	s2,0(sp)
    80003292:	6105                	addi	sp,sp,32
    80003294:	8082                	ret

0000000080003296 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003296:	00015797          	auipc	a5,0x15
    8000329a:	7a67a783          	lw	a5,1958(a5) # 80018a3c <log+0x2c>
    8000329e:	0af05d63          	blez	a5,80003358 <install_trans+0xc2>
static void install_trans(int recovering) {
    800032a2:	7139                	addi	sp,sp,-64
    800032a4:	fc06                	sd	ra,56(sp)
    800032a6:	f822                	sd	s0,48(sp)
    800032a8:	f426                	sd	s1,40(sp)
    800032aa:	f04a                	sd	s2,32(sp)
    800032ac:	ec4e                	sd	s3,24(sp)
    800032ae:	e852                	sd	s4,16(sp)
    800032b0:	e456                	sd	s5,8(sp)
    800032b2:	e05a                	sd	s6,0(sp)
    800032b4:	0080                	addi	s0,sp,64
    800032b6:	8b2a                	mv	s6,a0
    800032b8:	00015a97          	auipc	s5,0x15
    800032bc:	788a8a93          	addi	s5,s5,1928 # 80018a40 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800032c0:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start + tail + 1);  // read log block
    800032c2:	00015997          	auipc	s3,0x15
    800032c6:	74e98993          	addi	s3,s3,1870 # 80018a10 <log>
    800032ca:	a00d                	j	800032ec <install_trans+0x56>
    brelse(lbuf);
    800032cc:	854a                	mv	a0,s2
    800032ce:	fffff097          	auipc	ra,0xfffff
    800032d2:	084080e7          	jalr	132(ra) # 80002352 <brelse>
    brelse(dbuf);
    800032d6:	8526                	mv	a0,s1
    800032d8:	fffff097          	auipc	ra,0xfffff
    800032dc:	07a080e7          	jalr	122(ra) # 80002352 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800032e0:	2a05                	addiw	s4,s4,1
    800032e2:	0a91                	addi	s5,s5,4
    800032e4:	02c9a783          	lw	a5,44(s3)
    800032e8:	04fa5e63          	bge	s4,a5,80003344 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start + tail + 1);  // read log block
    800032ec:	0189a583          	lw	a1,24(s3)
    800032f0:	014585bb          	addw	a1,a1,s4
    800032f4:	2585                	addiw	a1,a1,1
    800032f6:	0289a503          	lw	a0,40(s3)
    800032fa:	fffff097          	auipc	ra,0xfffff
    800032fe:	f28080e7          	jalr	-216(ra) # 80002222 <bread>
    80003302:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]);    // read dst
    80003304:	000aa583          	lw	a1,0(s5)
    80003308:	0289a503          	lw	a0,40(s3)
    8000330c:	fffff097          	auipc	ra,0xfffff
    80003310:	f16080e7          	jalr	-234(ra) # 80002222 <bread>
    80003314:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003316:	40000613          	li	a2,1024
    8000331a:	05890593          	addi	a1,s2,88
    8000331e:	05850513          	addi	a0,a0,88
    80003322:	ffffd097          	auipc	ra,0xffffd
    80003326:	db0080e7          	jalr	-592(ra) # 800000d2 <memmove>
    bwrite(dbuf);                            // write dst to disk
    8000332a:	8526                	mv	a0,s1
    8000332c:	fffff097          	auipc	ra,0xfffff
    80003330:	fe8080e7          	jalr	-24(ra) # 80002314 <bwrite>
    if (recovering == 0) bunpin(dbuf);
    80003334:	f80b1ce3          	bnez	s6,800032cc <install_trans+0x36>
    80003338:	8526                	mv	a0,s1
    8000333a:	fffff097          	auipc	ra,0xfffff
    8000333e:	0f2080e7          	jalr	242(ra) # 8000242c <bunpin>
    80003342:	b769                	j	800032cc <install_trans+0x36>
}
    80003344:	70e2                	ld	ra,56(sp)
    80003346:	7442                	ld	s0,48(sp)
    80003348:	74a2                	ld	s1,40(sp)
    8000334a:	7902                	ld	s2,32(sp)
    8000334c:	69e2                	ld	s3,24(sp)
    8000334e:	6a42                	ld	s4,16(sp)
    80003350:	6aa2                	ld	s5,8(sp)
    80003352:	6b02                	ld	s6,0(sp)
    80003354:	6121                	addi	sp,sp,64
    80003356:	8082                	ret
    80003358:	8082                	ret

000000008000335a <initlog>:
void initlog(int dev, struct superblock *sb) {
    8000335a:	7179                	addi	sp,sp,-48
    8000335c:	f406                	sd	ra,40(sp)
    8000335e:	f022                	sd	s0,32(sp)
    80003360:	ec26                	sd	s1,24(sp)
    80003362:	e84a                	sd	s2,16(sp)
    80003364:	e44e                	sd	s3,8(sp)
    80003366:	1800                	addi	s0,sp,48
    80003368:	892a                	mv	s2,a0
    8000336a:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    8000336c:	00015497          	auipc	s1,0x15
    80003370:	6a448493          	addi	s1,s1,1700 # 80018a10 <log>
    80003374:	00005597          	auipc	a1,0x5
    80003378:	26458593          	addi	a1,a1,612 # 800085d8 <syscalls+0x1d8>
    8000337c:	8526                	mv	a0,s1
    8000337e:	00004097          	auipc	ra,0x4
    80003382:	866080e7          	jalr	-1946(ra) # 80006be4 <initlock>
  log.start = sb->logstart;
    80003386:	0149a583          	lw	a1,20(s3)
    8000338a:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    8000338c:	0109a783          	lw	a5,16(s3)
    80003390:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80003392:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80003396:	854a                	mv	a0,s2
    80003398:	fffff097          	auipc	ra,0xfffff
    8000339c:	e8a080e7          	jalr	-374(ra) # 80002222 <bread>
  log.lh.n = lh->n;
    800033a0:	4d34                	lw	a3,88(a0)
    800033a2:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    800033a4:	02d05563          	blez	a3,800033ce <initlog+0x74>
    800033a8:	05c50793          	addi	a5,a0,92
    800033ac:	00015717          	auipc	a4,0x15
    800033b0:	69470713          	addi	a4,a4,1684 # 80018a40 <log+0x30>
    800033b4:	36fd                	addiw	a3,a3,-1
    800033b6:	1682                	slli	a3,a3,0x20
    800033b8:	9281                	srli	a3,a3,0x20
    800033ba:	068a                	slli	a3,a3,0x2
    800033bc:	06050613          	addi	a2,a0,96
    800033c0:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    800033c2:	4390                	lw	a2,0(a5)
    800033c4:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800033c6:	0791                	addi	a5,a5,4
    800033c8:	0711                	addi	a4,a4,4
    800033ca:	fed79ce3          	bne	a5,a3,800033c2 <initlog+0x68>
  brelse(buf);
    800033ce:	fffff097          	auipc	ra,0xfffff
    800033d2:	f84080e7          	jalr	-124(ra) # 80002352 <brelse>

static void recover_from_log(void) {
  read_head();
  install_trans(1);  // if committed, copy from log to disk
    800033d6:	4505                	li	a0,1
    800033d8:	00000097          	auipc	ra,0x0
    800033dc:	ebe080e7          	jalr	-322(ra) # 80003296 <install_trans>
  log.lh.n = 0;
    800033e0:	00015797          	auipc	a5,0x15
    800033e4:	6407ae23          	sw	zero,1628(a5) # 80018a3c <log+0x2c>
  write_head();  // clear the log
    800033e8:	00000097          	auipc	ra,0x0
    800033ec:	e34080e7          	jalr	-460(ra) # 8000321c <write_head>
}
    800033f0:	70a2                	ld	ra,40(sp)
    800033f2:	7402                	ld	s0,32(sp)
    800033f4:	64e2                	ld	s1,24(sp)
    800033f6:	6942                	ld	s2,16(sp)
    800033f8:	69a2                	ld	s3,8(sp)
    800033fa:	6145                	addi	sp,sp,48
    800033fc:	8082                	ret

00000000800033fe <begin_op>:
}

// called at the start of each FS system call.
void begin_op(void) {
    800033fe:	1101                	addi	sp,sp,-32
    80003400:	ec06                	sd	ra,24(sp)
    80003402:	e822                	sd	s0,16(sp)
    80003404:	e426                	sd	s1,8(sp)
    80003406:	e04a                	sd	s2,0(sp)
    80003408:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    8000340a:	00015517          	auipc	a0,0x15
    8000340e:	60650513          	addi	a0,a0,1542 # 80018a10 <log>
    80003412:	00004097          	auipc	ra,0x4
    80003416:	862080e7          	jalr	-1950(ra) # 80006c74 <acquire>
  while (1) {
    if (log.committing) {
    8000341a:	00015497          	auipc	s1,0x15
    8000341e:	5f648493          	addi	s1,s1,1526 # 80018a10 <log>
      sleep(&log, &log.lock);
    } else if (log.lh.n + (log.outstanding + 1) * MAXOPBLOCKS > LOGSIZE) {
    80003422:	4979                	li	s2,30
    80003424:	a039                	j	80003432 <begin_op+0x34>
      sleep(&log, &log.lock);
    80003426:	85a6                	mv	a1,s1
    80003428:	8526                	mv	a0,s1
    8000342a:	ffffe097          	auipc	ra,0xffffe
    8000342e:	02a080e7          	jalr	42(ra) # 80001454 <sleep>
    if (log.committing) {
    80003432:	50dc                	lw	a5,36(s1)
    80003434:	fbed                	bnez	a5,80003426 <begin_op+0x28>
    } else if (log.lh.n + (log.outstanding + 1) * MAXOPBLOCKS > LOGSIZE) {
    80003436:	509c                	lw	a5,32(s1)
    80003438:	0017871b          	addiw	a4,a5,1
    8000343c:	0007069b          	sext.w	a3,a4
    80003440:	0027179b          	slliw	a5,a4,0x2
    80003444:	9fb9                	addw	a5,a5,a4
    80003446:	0017979b          	slliw	a5,a5,0x1
    8000344a:	54d8                	lw	a4,44(s1)
    8000344c:	9fb9                	addw	a5,a5,a4
    8000344e:	00f95963          	bge	s2,a5,80003460 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003452:	85a6                	mv	a1,s1
    80003454:	8526                	mv	a0,s1
    80003456:	ffffe097          	auipc	ra,0xffffe
    8000345a:	ffe080e7          	jalr	-2(ra) # 80001454 <sleep>
    8000345e:	bfd1                	j	80003432 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80003460:	00015517          	auipc	a0,0x15
    80003464:	5b050513          	addi	a0,a0,1456 # 80018a10 <log>
    80003468:	d114                	sw	a3,32(a0)
      release(&log.lock);
    8000346a:	00004097          	auipc	ra,0x4
    8000346e:	8be080e7          	jalr	-1858(ra) # 80006d28 <release>
      break;
    }
  }
}
    80003472:	60e2                	ld	ra,24(sp)
    80003474:	6442                	ld	s0,16(sp)
    80003476:	64a2                	ld	s1,8(sp)
    80003478:	6902                	ld	s2,0(sp)
    8000347a:	6105                	addi	sp,sp,32
    8000347c:	8082                	ret

000000008000347e <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void end_op(void) {
    8000347e:	7139                	addi	sp,sp,-64
    80003480:	fc06                	sd	ra,56(sp)
    80003482:	f822                	sd	s0,48(sp)
    80003484:	f426                	sd	s1,40(sp)
    80003486:	f04a                	sd	s2,32(sp)
    80003488:	ec4e                	sd	s3,24(sp)
    8000348a:	e852                	sd	s4,16(sp)
    8000348c:	e456                	sd	s5,8(sp)
    8000348e:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003490:	00015497          	auipc	s1,0x15
    80003494:	58048493          	addi	s1,s1,1408 # 80018a10 <log>
    80003498:	8526                	mv	a0,s1
    8000349a:	00003097          	auipc	ra,0x3
    8000349e:	7da080e7          	jalr	2010(ra) # 80006c74 <acquire>
  log.outstanding -= 1;
    800034a2:	509c                	lw	a5,32(s1)
    800034a4:	37fd                	addiw	a5,a5,-1
    800034a6:	0007891b          	sext.w	s2,a5
    800034aa:	d09c                	sw	a5,32(s1)
  if (log.committing) panic("log.committing");
    800034ac:	50dc                	lw	a5,36(s1)
    800034ae:	e7b9                	bnez	a5,800034fc <end_op+0x7e>
  if (log.outstanding == 0) {
    800034b0:	04091e63          	bnez	s2,8000350c <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800034b4:	00015497          	auipc	s1,0x15
    800034b8:	55c48493          	addi	s1,s1,1372 # 80018a10 <log>
    800034bc:	4785                	li	a5,1
    800034be:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800034c0:	8526                	mv	a0,s1
    800034c2:	00004097          	auipc	ra,0x4
    800034c6:	866080e7          	jalr	-1946(ra) # 80006d28 <release>
    brelse(to);
  }
}

static void commit() {
  if (log.lh.n > 0) {
    800034ca:	54dc                	lw	a5,44(s1)
    800034cc:	06f04763          	bgtz	a5,8000353a <end_op+0xbc>
    acquire(&log.lock);
    800034d0:	00015497          	auipc	s1,0x15
    800034d4:	54048493          	addi	s1,s1,1344 # 80018a10 <log>
    800034d8:	8526                	mv	a0,s1
    800034da:	00003097          	auipc	ra,0x3
    800034de:	79a080e7          	jalr	1946(ra) # 80006c74 <acquire>
    log.committing = 0;
    800034e2:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800034e6:	8526                	mv	a0,s1
    800034e8:	ffffe097          	auipc	ra,0xffffe
    800034ec:	fd0080e7          	jalr	-48(ra) # 800014b8 <wakeup>
    release(&log.lock);
    800034f0:	8526                	mv	a0,s1
    800034f2:	00004097          	auipc	ra,0x4
    800034f6:	836080e7          	jalr	-1994(ra) # 80006d28 <release>
}
    800034fa:	a03d                	j	80003528 <end_op+0xaa>
  if (log.committing) panic("log.committing");
    800034fc:	00005517          	auipc	a0,0x5
    80003500:	0e450513          	addi	a0,a0,228 # 800085e0 <syscalls+0x1e0>
    80003504:	00003097          	auipc	ra,0x3
    80003508:	234080e7          	jalr	564(ra) # 80006738 <panic>
    wakeup(&log);
    8000350c:	00015497          	auipc	s1,0x15
    80003510:	50448493          	addi	s1,s1,1284 # 80018a10 <log>
    80003514:	8526                	mv	a0,s1
    80003516:	ffffe097          	auipc	ra,0xffffe
    8000351a:	fa2080e7          	jalr	-94(ra) # 800014b8 <wakeup>
  release(&log.lock);
    8000351e:	8526                	mv	a0,s1
    80003520:	00004097          	auipc	ra,0x4
    80003524:	808080e7          	jalr	-2040(ra) # 80006d28 <release>
}
    80003528:	70e2                	ld	ra,56(sp)
    8000352a:	7442                	ld	s0,48(sp)
    8000352c:	74a2                	ld	s1,40(sp)
    8000352e:	7902                	ld	s2,32(sp)
    80003530:	69e2                	ld	s3,24(sp)
    80003532:	6a42                	ld	s4,16(sp)
    80003534:	6aa2                	ld	s5,8(sp)
    80003536:	6121                	addi	sp,sp,64
    80003538:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    8000353a:	00015a97          	auipc	s5,0x15
    8000353e:	506a8a93          	addi	s5,s5,1286 # 80018a40 <log+0x30>
    struct buf *to = bread(log.dev, log.start + tail + 1);  // log block
    80003542:	00015a17          	auipc	s4,0x15
    80003546:	4cea0a13          	addi	s4,s4,1230 # 80018a10 <log>
    8000354a:	018a2583          	lw	a1,24(s4)
    8000354e:	012585bb          	addw	a1,a1,s2
    80003552:	2585                	addiw	a1,a1,1
    80003554:	028a2503          	lw	a0,40(s4)
    80003558:	fffff097          	auipc	ra,0xfffff
    8000355c:	cca080e7          	jalr	-822(ra) # 80002222 <bread>
    80003560:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]);  // cache block
    80003562:	000aa583          	lw	a1,0(s5)
    80003566:	028a2503          	lw	a0,40(s4)
    8000356a:	fffff097          	auipc	ra,0xfffff
    8000356e:	cb8080e7          	jalr	-840(ra) # 80002222 <bread>
    80003572:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003574:	40000613          	li	a2,1024
    80003578:	05850593          	addi	a1,a0,88
    8000357c:	05848513          	addi	a0,s1,88
    80003580:	ffffd097          	auipc	ra,0xffffd
    80003584:	b52080e7          	jalr	-1198(ra) # 800000d2 <memmove>
    bwrite(to);  // write the log
    80003588:	8526                	mv	a0,s1
    8000358a:	fffff097          	auipc	ra,0xfffff
    8000358e:	d8a080e7          	jalr	-630(ra) # 80002314 <bwrite>
    brelse(from);
    80003592:	854e                	mv	a0,s3
    80003594:	fffff097          	auipc	ra,0xfffff
    80003598:	dbe080e7          	jalr	-578(ra) # 80002352 <brelse>
    brelse(to);
    8000359c:	8526                	mv	a0,s1
    8000359e:	fffff097          	auipc	ra,0xfffff
    800035a2:	db4080e7          	jalr	-588(ra) # 80002352 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800035a6:	2905                	addiw	s2,s2,1
    800035a8:	0a91                	addi	s5,s5,4
    800035aa:	02ca2783          	lw	a5,44(s4)
    800035ae:	f8f94ee3          	blt	s2,a5,8000354a <end_op+0xcc>
    write_log();       // Write modified blocks from cache to log
    write_head();      // Write header to disk -- the real commit
    800035b2:	00000097          	auipc	ra,0x0
    800035b6:	c6a080e7          	jalr	-918(ra) # 8000321c <write_head>
    install_trans(0);  // Now install writes to home locations
    800035ba:	4501                	li	a0,0
    800035bc:	00000097          	auipc	ra,0x0
    800035c0:	cda080e7          	jalr	-806(ra) # 80003296 <install_trans>
    log.lh.n = 0;
    800035c4:	00015797          	auipc	a5,0x15
    800035c8:	4607ac23          	sw	zero,1144(a5) # 80018a3c <log+0x2c>
    write_head();  // Erase the transaction from the log
    800035cc:	00000097          	auipc	ra,0x0
    800035d0:	c50080e7          	jalr	-944(ra) # 8000321c <write_head>
    800035d4:	bdf5                	j	800034d0 <end_op+0x52>

00000000800035d6 <log_write>:
// log_write() replaces bwrite(); a typical use is:
//   bp = bread(...)
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void log_write(struct buf *b) {
    800035d6:	1101                	addi	sp,sp,-32
    800035d8:	ec06                	sd	ra,24(sp)
    800035da:	e822                	sd	s0,16(sp)
    800035dc:	e426                	sd	s1,8(sp)
    800035de:	e04a                	sd	s2,0(sp)
    800035e0:	1000                	addi	s0,sp,32
    800035e2:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800035e4:	00015917          	auipc	s2,0x15
    800035e8:	42c90913          	addi	s2,s2,1068 # 80018a10 <log>
    800035ec:	854a                	mv	a0,s2
    800035ee:	00003097          	auipc	ra,0x3
    800035f2:	686080e7          	jalr	1670(ra) # 80006c74 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800035f6:	02c92603          	lw	a2,44(s2)
    800035fa:	47f5                	li	a5,29
    800035fc:	06c7c563          	blt	a5,a2,80003666 <log_write+0x90>
    80003600:	00015797          	auipc	a5,0x15
    80003604:	42c7a783          	lw	a5,1068(a5) # 80018a2c <log+0x1c>
    80003608:	37fd                	addiw	a5,a5,-1
    8000360a:	04f65e63          	bge	a2,a5,80003666 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1) panic("log_write outside of trans");
    8000360e:	00015797          	auipc	a5,0x15
    80003612:	4227a783          	lw	a5,1058(a5) # 80018a30 <log+0x20>
    80003616:	06f05063          	blez	a5,80003676 <log_write+0xa0>

  for (i = 0; i < log.lh.n; i++) {
    8000361a:	4781                	li	a5,0
    8000361c:	06c05563          	blez	a2,80003686 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)  // log absorption
    80003620:	44cc                	lw	a1,12(s1)
    80003622:	00015717          	auipc	a4,0x15
    80003626:	41e70713          	addi	a4,a4,1054 # 80018a40 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    8000362a:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)  // log absorption
    8000362c:	4314                	lw	a3,0(a4)
    8000362e:	04b68c63          	beq	a3,a1,80003686 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003632:	2785                	addiw	a5,a5,1
    80003634:	0711                	addi	a4,a4,4
    80003636:	fef61be3          	bne	a2,a5,8000362c <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000363a:	0621                	addi	a2,a2,8
    8000363c:	060a                	slli	a2,a2,0x2
    8000363e:	00015797          	auipc	a5,0x15
    80003642:	3d278793          	addi	a5,a5,978 # 80018a10 <log>
    80003646:	963e                	add	a2,a2,a5
    80003648:	44dc                	lw	a5,12(s1)
    8000364a:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000364c:	8526                	mv	a0,s1
    8000364e:	fffff097          	auipc	ra,0xfffff
    80003652:	da2080e7          	jalr	-606(ra) # 800023f0 <bpin>
    log.lh.n++;
    80003656:	00015717          	auipc	a4,0x15
    8000365a:	3ba70713          	addi	a4,a4,954 # 80018a10 <log>
    8000365e:	575c                	lw	a5,44(a4)
    80003660:	2785                	addiw	a5,a5,1
    80003662:	d75c                	sw	a5,44(a4)
    80003664:	a835                	j	800036a0 <log_write+0xca>
    panic("too big a transaction");
    80003666:	00005517          	auipc	a0,0x5
    8000366a:	f8a50513          	addi	a0,a0,-118 # 800085f0 <syscalls+0x1f0>
    8000366e:	00003097          	auipc	ra,0x3
    80003672:	0ca080e7          	jalr	202(ra) # 80006738 <panic>
  if (log.outstanding < 1) panic("log_write outside of trans");
    80003676:	00005517          	auipc	a0,0x5
    8000367a:	f9250513          	addi	a0,a0,-110 # 80008608 <syscalls+0x208>
    8000367e:	00003097          	auipc	ra,0x3
    80003682:	0ba080e7          	jalr	186(ra) # 80006738 <panic>
  log.lh.block[i] = b->blockno;
    80003686:	00878713          	addi	a4,a5,8
    8000368a:	00271693          	slli	a3,a4,0x2
    8000368e:	00015717          	auipc	a4,0x15
    80003692:	38270713          	addi	a4,a4,898 # 80018a10 <log>
    80003696:	9736                	add	a4,a4,a3
    80003698:	44d4                	lw	a3,12(s1)
    8000369a:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    8000369c:	faf608e3          	beq	a2,a5,8000364c <log_write+0x76>
  }
  release(&log.lock);
    800036a0:	00015517          	auipc	a0,0x15
    800036a4:	37050513          	addi	a0,a0,880 # 80018a10 <log>
    800036a8:	00003097          	auipc	ra,0x3
    800036ac:	680080e7          	jalr	1664(ra) # 80006d28 <release>
}
    800036b0:	60e2                	ld	ra,24(sp)
    800036b2:	6442                	ld	s0,16(sp)
    800036b4:	64a2                	ld	s1,8(sp)
    800036b6:	6902                	ld	s2,0(sp)
    800036b8:	6105                	addi	sp,sp,32
    800036ba:	8082                	ret

00000000800036bc <initsleeplock>:
#include "sleeplock.h"

#include "defs.h"
#include "proc.h"

void initsleeplock(struct sleeplock *lk, char *name) {
    800036bc:	1101                	addi	sp,sp,-32
    800036be:	ec06                	sd	ra,24(sp)
    800036c0:	e822                	sd	s0,16(sp)
    800036c2:	e426                	sd	s1,8(sp)
    800036c4:	e04a                	sd	s2,0(sp)
    800036c6:	1000                	addi	s0,sp,32
    800036c8:	84aa                	mv	s1,a0
    800036ca:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800036cc:	00005597          	auipc	a1,0x5
    800036d0:	f5c58593          	addi	a1,a1,-164 # 80008628 <syscalls+0x228>
    800036d4:	0521                	addi	a0,a0,8
    800036d6:	00003097          	auipc	ra,0x3
    800036da:	50e080e7          	jalr	1294(ra) # 80006be4 <initlock>
  lk->name = name;
    800036de:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800036e2:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800036e6:	0204a423          	sw	zero,40(s1)
}
    800036ea:	60e2                	ld	ra,24(sp)
    800036ec:	6442                	ld	s0,16(sp)
    800036ee:	64a2                	ld	s1,8(sp)
    800036f0:	6902                	ld	s2,0(sp)
    800036f2:	6105                	addi	sp,sp,32
    800036f4:	8082                	ret

00000000800036f6 <acquiresleep>:

void acquiresleep(struct sleeplock *lk) {
    800036f6:	1101                	addi	sp,sp,-32
    800036f8:	ec06                	sd	ra,24(sp)
    800036fa:	e822                	sd	s0,16(sp)
    800036fc:	e426                	sd	s1,8(sp)
    800036fe:	e04a                	sd	s2,0(sp)
    80003700:	1000                	addi	s0,sp,32
    80003702:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003704:	00850913          	addi	s2,a0,8
    80003708:	854a                	mv	a0,s2
    8000370a:	00003097          	auipc	ra,0x3
    8000370e:	56a080e7          	jalr	1386(ra) # 80006c74 <acquire>
  while (lk->locked) {
    80003712:	409c                	lw	a5,0(s1)
    80003714:	cb89                	beqz	a5,80003726 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003716:	85ca                	mv	a1,s2
    80003718:	8526                	mv	a0,s1
    8000371a:	ffffe097          	auipc	ra,0xffffe
    8000371e:	d3a080e7          	jalr	-710(ra) # 80001454 <sleep>
  while (lk->locked) {
    80003722:	409c                	lw	a5,0(s1)
    80003724:	fbed                	bnez	a5,80003716 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003726:	4785                	li	a5,1
    80003728:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    8000372a:	ffffd097          	auipc	ra,0xffffd
    8000372e:	67e080e7          	jalr	1662(ra) # 80000da8 <myproc>
    80003732:	591c                	lw	a5,48(a0)
    80003734:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003736:	854a                	mv	a0,s2
    80003738:	00003097          	auipc	ra,0x3
    8000373c:	5f0080e7          	jalr	1520(ra) # 80006d28 <release>
}
    80003740:	60e2                	ld	ra,24(sp)
    80003742:	6442                	ld	s0,16(sp)
    80003744:	64a2                	ld	s1,8(sp)
    80003746:	6902                	ld	s2,0(sp)
    80003748:	6105                	addi	sp,sp,32
    8000374a:	8082                	ret

000000008000374c <releasesleep>:

void releasesleep(struct sleeplock *lk) {
    8000374c:	1101                	addi	sp,sp,-32
    8000374e:	ec06                	sd	ra,24(sp)
    80003750:	e822                	sd	s0,16(sp)
    80003752:	e426                	sd	s1,8(sp)
    80003754:	e04a                	sd	s2,0(sp)
    80003756:	1000                	addi	s0,sp,32
    80003758:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000375a:	00850913          	addi	s2,a0,8
    8000375e:	854a                	mv	a0,s2
    80003760:	00003097          	auipc	ra,0x3
    80003764:	514080e7          	jalr	1300(ra) # 80006c74 <acquire>
  lk->locked = 0;
    80003768:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000376c:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003770:	8526                	mv	a0,s1
    80003772:	ffffe097          	auipc	ra,0xffffe
    80003776:	d46080e7          	jalr	-698(ra) # 800014b8 <wakeup>
  release(&lk->lk);
    8000377a:	854a                	mv	a0,s2
    8000377c:	00003097          	auipc	ra,0x3
    80003780:	5ac080e7          	jalr	1452(ra) # 80006d28 <release>
}
    80003784:	60e2                	ld	ra,24(sp)
    80003786:	6442                	ld	s0,16(sp)
    80003788:	64a2                	ld	s1,8(sp)
    8000378a:	6902                	ld	s2,0(sp)
    8000378c:	6105                	addi	sp,sp,32
    8000378e:	8082                	ret

0000000080003790 <holdingsleep>:

int holdingsleep(struct sleeplock *lk) {
    80003790:	7179                	addi	sp,sp,-48
    80003792:	f406                	sd	ra,40(sp)
    80003794:	f022                	sd	s0,32(sp)
    80003796:	ec26                	sd	s1,24(sp)
    80003798:	e84a                	sd	s2,16(sp)
    8000379a:	e44e                	sd	s3,8(sp)
    8000379c:	1800                	addi	s0,sp,48
    8000379e:	84aa                	mv	s1,a0
  int r;

  acquire(&lk->lk);
    800037a0:	00850913          	addi	s2,a0,8
    800037a4:	854a                	mv	a0,s2
    800037a6:	00003097          	auipc	ra,0x3
    800037aa:	4ce080e7          	jalr	1230(ra) # 80006c74 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800037ae:	409c                	lw	a5,0(s1)
    800037b0:	ef99                	bnez	a5,800037ce <holdingsleep+0x3e>
    800037b2:	4481                	li	s1,0
  release(&lk->lk);
    800037b4:	854a                	mv	a0,s2
    800037b6:	00003097          	auipc	ra,0x3
    800037ba:	572080e7          	jalr	1394(ra) # 80006d28 <release>
  return r;
}
    800037be:	8526                	mv	a0,s1
    800037c0:	70a2                	ld	ra,40(sp)
    800037c2:	7402                	ld	s0,32(sp)
    800037c4:	64e2                	ld	s1,24(sp)
    800037c6:	6942                	ld	s2,16(sp)
    800037c8:	69a2                	ld	s3,8(sp)
    800037ca:	6145                	addi	sp,sp,48
    800037cc:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    800037ce:	0284a983          	lw	s3,40(s1)
    800037d2:	ffffd097          	auipc	ra,0xffffd
    800037d6:	5d6080e7          	jalr	1494(ra) # 80000da8 <myproc>
    800037da:	5904                	lw	s1,48(a0)
    800037dc:	413484b3          	sub	s1,s1,s3
    800037e0:	0014b493          	seqz	s1,s1
    800037e4:	bfc1                	j	800037b4 <holdingsleep+0x24>

00000000800037e6 <fileinit>:
#include "stat.h"
#include "types.h"

struct devsw devsw[NDEV];

void fileinit(void) {}
    800037e6:	1141                	addi	sp,sp,-16
    800037e8:	e422                	sd	s0,8(sp)
    800037ea:	0800                	addi	s0,sp,16
    800037ec:	6422                	ld	s0,8(sp)
    800037ee:	0141                	addi	sp,sp,16
    800037f0:	8082                	ret

00000000800037f2 <filealloc>:

struct file *filealloc(void) {
    800037f2:	1101                	addi	sp,sp,-32
    800037f4:	ec06                	sd	ra,24(sp)
    800037f6:	e822                	sd	s0,16(sp)
    800037f8:	e426                	sd	s1,8(sp)
    800037fa:	1000                	addi	s0,sp,32
  struct file *f = bd_malloc(sizeof(struct file));
    800037fc:	04000513          	li	a0,64
    80003800:	00002097          	auipc	ra,0x2
    80003804:	03a080e7          	jalr	58(ra) # 8000583a <bd_malloc>
    80003808:	84aa                	mv	s1,a0
  memset(f, 0, sizeof(struct file));
    8000380a:	04000613          	li	a2,64
    8000380e:	4581                	li	a1,0
    80003810:	ffffd097          	auipc	ra,0xffffd
    80003814:	866080e7          	jalr	-1946(ra) # 80000076 <memset>
  f->ref = 1;
    80003818:	4785                	li	a5,1
    8000381a:	c0dc                	sw	a5,4(s1)
  return f;
}
    8000381c:	8526                	mv	a0,s1
    8000381e:	60e2                	ld	ra,24(sp)
    80003820:	6442                	ld	s0,16(sp)
    80003822:	64a2                	ld	s1,8(sp)
    80003824:	6105                	addi	sp,sp,32
    80003826:	8082                	ret

0000000080003828 <filedup>:

// Increment ref count for file f.
struct file *filedup(struct file *f) {
    80003828:	1101                	addi	sp,sp,-32
    8000382a:	ec06                	sd	ra,24(sp)
    8000382c:	e822                	sd	s0,16(sp)
    8000382e:	e426                	sd	s1,8(sp)
    80003830:	e04a                	sd	s2,0(sp)
    80003832:	1000                	addi	s0,sp,32
    80003834:	84aa                	mv	s1,a0
  acquire(&f->lock);
    80003836:	02850913          	addi	s2,a0,40
    8000383a:	854a                	mv	a0,s2
    8000383c:	00003097          	auipc	ra,0x3
    80003840:	438080e7          	jalr	1080(ra) # 80006c74 <acquire>
  if (f->ref < 1) panic("filedup");
    80003844:	40dc                	lw	a5,4(s1)
    80003846:	02f05063          	blez	a5,80003866 <filedup+0x3e>
  f->ref++;
    8000384a:	2785                	addiw	a5,a5,1
    8000384c:	c0dc                	sw	a5,4(s1)
  release(&f->lock);
    8000384e:	854a                	mv	a0,s2
    80003850:	00003097          	auipc	ra,0x3
    80003854:	4d8080e7          	jalr	1240(ra) # 80006d28 <release>
  return f;
}
    80003858:	8526                	mv	a0,s1
    8000385a:	60e2                	ld	ra,24(sp)
    8000385c:	6442                	ld	s0,16(sp)
    8000385e:	64a2                	ld	s1,8(sp)
    80003860:	6902                	ld	s2,0(sp)
    80003862:	6105                	addi	sp,sp,32
    80003864:	8082                	ret
  if (f->ref < 1) panic("filedup");
    80003866:	00005517          	auipc	a0,0x5
    8000386a:	dd250513          	addi	a0,a0,-558 # 80008638 <syscalls+0x238>
    8000386e:	00003097          	auipc	ra,0x3
    80003872:	eca080e7          	jalr	-310(ra) # 80006738 <panic>

0000000080003876 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void fileclose(struct file *f) {
    80003876:	1101                	addi	sp,sp,-32
    80003878:	ec06                	sd	ra,24(sp)
    8000387a:	e822                	sd	s0,16(sp)
    8000387c:	e426                	sd	s1,8(sp)
    8000387e:	e04a                	sd	s2,0(sp)
    80003880:	1000                	addi	s0,sp,32
    80003882:	84aa                	mv	s1,a0
  acquire(&f->lock);
    80003884:	02850913          	addi	s2,a0,40
    80003888:	854a                	mv	a0,s2
    8000388a:	00003097          	auipc	ra,0x3
    8000388e:	3ea080e7          	jalr	1002(ra) # 80006c74 <acquire>
  if (f->ref < 1) panic("fileclose");
    80003892:	40dc                	lw	a5,4(s1)
    80003894:	04f05063          	blez	a5,800038d4 <fileclose+0x5e>
  if (--f->ref > 0) {
    80003898:	37fd                	addiw	a5,a5,-1
    8000389a:	0007871b          	sext.w	a4,a5
    8000389e:	c0dc                	sw	a5,4(s1)
    800038a0:	04e04263          	bgtz	a4,800038e4 <fileclose+0x6e>
    release(&f->lock);
    return;
  }
  release(&f->lock);
    800038a4:	854a                	mv	a0,s2
    800038a6:	00003097          	auipc	ra,0x3
    800038aa:	482080e7          	jalr	1154(ra) # 80006d28 <release>
  if (f->type == FD_PIPE) {
    800038ae:	409c                	lw	a5,0(s1)
    800038b0:	4705                	li	a4,1
    800038b2:	02e78f63          	beq	a5,a4,800038f0 <fileclose+0x7a>
    pipeclose(f->pipe, f->writable);
  } else if (f->type == FD_INODE || f->type == FD_DEVICE) {
    800038b6:	37f9                	addiw	a5,a5,-2
    800038b8:	4705                	li	a4,1
    800038ba:	04f77363          	bgeu	a4,a5,80003900 <fileclose+0x8a>
    begin_op();
    iput(f->ip);
    end_op();
  }
  bd_free(f);
    800038be:	8526                	mv	a0,s1
    800038c0:	00002097          	auipc	ra,0x2
    800038c4:	178080e7          	jalr	376(ra) # 80005a38 <bd_free>
}
    800038c8:	60e2                	ld	ra,24(sp)
    800038ca:	6442                	ld	s0,16(sp)
    800038cc:	64a2                	ld	s1,8(sp)
    800038ce:	6902                	ld	s2,0(sp)
    800038d0:	6105                	addi	sp,sp,32
    800038d2:	8082                	ret
  if (f->ref < 1) panic("fileclose");
    800038d4:	00005517          	auipc	a0,0x5
    800038d8:	d6c50513          	addi	a0,a0,-660 # 80008640 <syscalls+0x240>
    800038dc:	00003097          	auipc	ra,0x3
    800038e0:	e5c080e7          	jalr	-420(ra) # 80006738 <panic>
    release(&f->lock);
    800038e4:	854a                	mv	a0,s2
    800038e6:	00003097          	auipc	ra,0x3
    800038ea:	442080e7          	jalr	1090(ra) # 80006d28 <release>
    return;
    800038ee:	bfe9                	j	800038c8 <fileclose+0x52>
    pipeclose(f->pipe, f->writable);
    800038f0:	0094c583          	lbu	a1,9(s1)
    800038f4:	6888                	ld	a0,16(s1)
    800038f6:	00000097          	auipc	ra,0x0
    800038fa:	368080e7          	jalr	872(ra) # 80003c5e <pipeclose>
    800038fe:	b7c1                	j	800038be <fileclose+0x48>
    begin_op();
    80003900:	00000097          	auipc	ra,0x0
    80003904:	afe080e7          	jalr	-1282(ra) # 800033fe <begin_op>
    iput(f->ip);
    80003908:	6c88                	ld	a0,24(s1)
    8000390a:	fffff097          	auipc	ra,0xfffff
    8000390e:	2ec080e7          	jalr	748(ra) # 80002bf6 <iput>
    end_op();
    80003912:	00000097          	auipc	ra,0x0
    80003916:	b6c080e7          	jalr	-1172(ra) # 8000347e <end_op>
    8000391a:	b755                	j	800038be <fileclose+0x48>

000000008000391c <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int filestat(struct file *f, uint64 addr) {
    8000391c:	715d                	addi	sp,sp,-80
    8000391e:	e486                	sd	ra,72(sp)
    80003920:	e0a2                	sd	s0,64(sp)
    80003922:	fc26                	sd	s1,56(sp)
    80003924:	f84a                	sd	s2,48(sp)
    80003926:	f44e                	sd	s3,40(sp)
    80003928:	0880                	addi	s0,sp,80
    8000392a:	84aa                	mv	s1,a0
    8000392c:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    8000392e:	ffffd097          	auipc	ra,0xffffd
    80003932:	47a080e7          	jalr	1146(ra) # 80000da8 <myproc>
  struct stat st;

  if (f->type == FD_INODE || f->type == FD_DEVICE) {
    80003936:	409c                	lw	a5,0(s1)
    80003938:	37f9                	addiw	a5,a5,-2
    8000393a:	4705                	li	a4,1
    8000393c:	04f76763          	bltu	a4,a5,8000398a <filestat+0x6e>
    80003940:	892a                	mv	s2,a0
    ilock(f->ip);
    80003942:	6c88                	ld	a0,24(s1)
    80003944:	fffff097          	auipc	ra,0xfffff
    80003948:	0f8080e7          	jalr	248(ra) # 80002a3c <ilock>
    stati(f->ip, &st);
    8000394c:	fb840593          	addi	a1,s0,-72
    80003950:	6c88                	ld	a0,24(s1)
    80003952:	fffff097          	auipc	ra,0xfffff
    80003956:	374080e7          	jalr	884(ra) # 80002cc6 <stati>
    iunlock(f->ip);
    8000395a:	6c88                	ld	a0,24(s1)
    8000395c:	fffff097          	auipc	ra,0xfffff
    80003960:	1a2080e7          	jalr	418(ra) # 80002afe <iunlock>
    if (copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0) return -1;
    80003964:	46e1                	li	a3,24
    80003966:	fb840613          	addi	a2,s0,-72
    8000396a:	85ce                	mv	a1,s3
    8000396c:	05093503          	ld	a0,80(s2)
    80003970:	ffffd097          	auipc	ra,0xffffd
    80003974:	0c0080e7          	jalr	192(ra) # 80000a30 <copyout>
    80003978:	41f5551b          	sraiw	a0,a0,0x1f
    return 0;
  }
  return -1;
}
    8000397c:	60a6                	ld	ra,72(sp)
    8000397e:	6406                	ld	s0,64(sp)
    80003980:	74e2                	ld	s1,56(sp)
    80003982:	7942                	ld	s2,48(sp)
    80003984:	79a2                	ld	s3,40(sp)
    80003986:	6161                	addi	sp,sp,80
    80003988:	8082                	ret
  return -1;
    8000398a:	557d                	li	a0,-1
    8000398c:	bfc5                	j	8000397c <filestat+0x60>

000000008000398e <fileread>:

// Read from file f.
// addr is a user virtual address.
int fileread(struct file *f, uint64 addr, int n) {
    8000398e:	7179                	addi	sp,sp,-48
    80003990:	f406                	sd	ra,40(sp)
    80003992:	f022                	sd	s0,32(sp)
    80003994:	ec26                	sd	s1,24(sp)
    80003996:	e84a                	sd	s2,16(sp)
    80003998:	e44e                	sd	s3,8(sp)
    8000399a:	1800                	addi	s0,sp,48
  int r = 0;

  if (f->readable == 0) return -1;
    8000399c:	00854783          	lbu	a5,8(a0)
    800039a0:	c3d5                	beqz	a5,80003a44 <fileread+0xb6>
    800039a2:	84aa                	mv	s1,a0
    800039a4:	89ae                	mv	s3,a1
    800039a6:	8932                	mv	s2,a2

  if (f->type == FD_PIPE) {
    800039a8:	411c                	lw	a5,0(a0)
    800039aa:	4705                	li	a4,1
    800039ac:	04e78963          	beq	a5,a4,800039fe <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if (f->type == FD_DEVICE) {
    800039b0:	470d                	li	a4,3
    800039b2:	04e78d63          	beq	a5,a4,80003a0c <fileread+0x7e>
    if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read) return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if (f->type == FD_INODE) {
    800039b6:	4709                	li	a4,2
    800039b8:	06e79e63          	bne	a5,a4,80003a34 <fileread+0xa6>
    ilock(f->ip);
    800039bc:	6d08                	ld	a0,24(a0)
    800039be:	fffff097          	auipc	ra,0xfffff
    800039c2:	07e080e7          	jalr	126(ra) # 80002a3c <ilock>
    if ((r = readi(f->ip, 1, addr, f->off, n)) > 0) f->off += r;
    800039c6:	874a                	mv	a4,s2
    800039c8:	5094                	lw	a3,32(s1)
    800039ca:	864e                	mv	a2,s3
    800039cc:	4585                	li	a1,1
    800039ce:	6c88                	ld	a0,24(s1)
    800039d0:	fffff097          	auipc	ra,0xfffff
    800039d4:	320080e7          	jalr	800(ra) # 80002cf0 <readi>
    800039d8:	892a                	mv	s2,a0
    800039da:	00a05563          	blez	a0,800039e4 <fileread+0x56>
    800039de:	509c                	lw	a5,32(s1)
    800039e0:	9fa9                	addw	a5,a5,a0
    800039e2:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    800039e4:	6c88                	ld	a0,24(s1)
    800039e6:	fffff097          	auipc	ra,0xfffff
    800039ea:	118080e7          	jalr	280(ra) # 80002afe <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    800039ee:	854a                	mv	a0,s2
    800039f0:	70a2                	ld	ra,40(sp)
    800039f2:	7402                	ld	s0,32(sp)
    800039f4:	64e2                	ld	s1,24(sp)
    800039f6:	6942                	ld	s2,16(sp)
    800039f8:	69a2                	ld	s3,8(sp)
    800039fa:	6145                	addi	sp,sp,48
    800039fc:	8082                	ret
    r = piperead(f->pipe, addr, n);
    800039fe:	6908                	ld	a0,16(a0)
    80003a00:	00000097          	auipc	ra,0x0
    80003a04:	3c6080e7          	jalr	966(ra) # 80003dc6 <piperead>
    80003a08:	892a                	mv	s2,a0
    80003a0a:	b7d5                	j	800039ee <fileread+0x60>
    if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read) return -1;
    80003a0c:	02451783          	lh	a5,36(a0)
    80003a10:	03079693          	slli	a3,a5,0x30
    80003a14:	92c1                	srli	a3,a3,0x30
    80003a16:	4725                	li	a4,9
    80003a18:	02d76863          	bltu	a4,a3,80003a48 <fileread+0xba>
    80003a1c:	0792                	slli	a5,a5,0x4
    80003a1e:	00015717          	auipc	a4,0x15
    80003a22:	09a70713          	addi	a4,a4,154 # 80018ab8 <devsw>
    80003a26:	97ba                	add	a5,a5,a4
    80003a28:	639c                	ld	a5,0(a5)
    80003a2a:	c38d                	beqz	a5,80003a4c <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003a2c:	4505                	li	a0,1
    80003a2e:	9782                	jalr	a5
    80003a30:	892a                	mv	s2,a0
    80003a32:	bf75                	j	800039ee <fileread+0x60>
    panic("fileread");
    80003a34:	00005517          	auipc	a0,0x5
    80003a38:	c1c50513          	addi	a0,a0,-996 # 80008650 <syscalls+0x250>
    80003a3c:	00003097          	auipc	ra,0x3
    80003a40:	cfc080e7          	jalr	-772(ra) # 80006738 <panic>
  if (f->readable == 0) return -1;
    80003a44:	597d                	li	s2,-1
    80003a46:	b765                	j	800039ee <fileread+0x60>
    if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read) return -1;
    80003a48:	597d                	li	s2,-1
    80003a4a:	b755                	j	800039ee <fileread+0x60>
    80003a4c:	597d                	li	s2,-1
    80003a4e:	b745                	j	800039ee <fileread+0x60>

0000000080003a50 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int filewrite(struct file *f, uint64 addr, int n) {
    80003a50:	715d                	addi	sp,sp,-80
    80003a52:	e486                	sd	ra,72(sp)
    80003a54:	e0a2                	sd	s0,64(sp)
    80003a56:	fc26                	sd	s1,56(sp)
    80003a58:	f84a                	sd	s2,48(sp)
    80003a5a:	f44e                	sd	s3,40(sp)
    80003a5c:	f052                	sd	s4,32(sp)
    80003a5e:	ec56                	sd	s5,24(sp)
    80003a60:	e85a                	sd	s6,16(sp)
    80003a62:	e45e                	sd	s7,8(sp)
    80003a64:	e062                	sd	s8,0(sp)
    80003a66:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if (f->writable == 0) return -1;
    80003a68:	00954783          	lbu	a5,9(a0)
    80003a6c:	10078663          	beqz	a5,80003b78 <filewrite+0x128>
    80003a70:	892a                	mv	s2,a0
    80003a72:	8aae                	mv	s5,a1
    80003a74:	8a32                	mv	s4,a2

  if (f->type == FD_PIPE) {
    80003a76:	411c                	lw	a5,0(a0)
    80003a78:	4705                	li	a4,1
    80003a7a:	02e78263          	beq	a5,a4,80003a9e <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if (f->type == FD_DEVICE) {
    80003a7e:	470d                	li	a4,3
    80003a80:	02e78663          	beq	a5,a4,80003aac <filewrite+0x5c>
    if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write) return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if (f->type == FD_INODE) {
    80003a84:	4709                	li	a4,2
    80003a86:	0ee79163          	bne	a5,a4,80003b68 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS - 1 - 1 - 2) / 2) * BSIZE;
    int i = 0;
    while (i < n) {
    80003a8a:	0ac05d63          	blez	a2,80003b44 <filewrite+0xf4>
    int i = 0;
    80003a8e:	4981                	li	s3,0
    80003a90:	6b05                	lui	s6,0x1
    80003a92:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80003a96:	6b85                	lui	s7,0x1
    80003a98:	c00b8b9b          	addiw	s7,s7,-1024
    80003a9c:	a861                	j	80003b34 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80003a9e:	6908                	ld	a0,16(a0)
    80003aa0:	00000097          	auipc	ra,0x0
    80003aa4:	22e080e7          	jalr	558(ra) # 80003cce <pipewrite>
    80003aa8:	8a2a                	mv	s4,a0
    80003aaa:	a045                	j	80003b4a <filewrite+0xfa>
    if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write) return -1;
    80003aac:	02451783          	lh	a5,36(a0)
    80003ab0:	03079693          	slli	a3,a5,0x30
    80003ab4:	92c1                	srli	a3,a3,0x30
    80003ab6:	4725                	li	a4,9
    80003ab8:	0cd76263          	bltu	a4,a3,80003b7c <filewrite+0x12c>
    80003abc:	0792                	slli	a5,a5,0x4
    80003abe:	00015717          	auipc	a4,0x15
    80003ac2:	ffa70713          	addi	a4,a4,-6 # 80018ab8 <devsw>
    80003ac6:	97ba                	add	a5,a5,a4
    80003ac8:	679c                	ld	a5,8(a5)
    80003aca:	cbdd                	beqz	a5,80003b80 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80003acc:	4505                	li	a0,1
    80003ace:	9782                	jalr	a5
    80003ad0:	8a2a                	mv	s4,a0
    80003ad2:	a8a5                	j	80003b4a <filewrite+0xfa>
    80003ad4:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if (n1 > max) n1 = max;

      begin_op();
    80003ad8:	00000097          	auipc	ra,0x0
    80003adc:	926080e7          	jalr	-1754(ra) # 800033fe <begin_op>
      ilock(f->ip);
    80003ae0:	01893503          	ld	a0,24(s2)
    80003ae4:	fffff097          	auipc	ra,0xfffff
    80003ae8:	f58080e7          	jalr	-168(ra) # 80002a3c <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0) f->off += r;
    80003aec:	8762                	mv	a4,s8
    80003aee:	02092683          	lw	a3,32(s2)
    80003af2:	01598633          	add	a2,s3,s5
    80003af6:	4585                	li	a1,1
    80003af8:	01893503          	ld	a0,24(s2)
    80003afc:	fffff097          	auipc	ra,0xfffff
    80003b00:	2ec080e7          	jalr	748(ra) # 80002de8 <writei>
    80003b04:	84aa                	mv	s1,a0
    80003b06:	00a05763          	blez	a0,80003b14 <filewrite+0xc4>
    80003b0a:	02092783          	lw	a5,32(s2)
    80003b0e:	9fa9                	addw	a5,a5,a0
    80003b10:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003b14:	01893503          	ld	a0,24(s2)
    80003b18:	fffff097          	auipc	ra,0xfffff
    80003b1c:	fe6080e7          	jalr	-26(ra) # 80002afe <iunlock>
      end_op();
    80003b20:	00000097          	auipc	ra,0x0
    80003b24:	95e080e7          	jalr	-1698(ra) # 8000347e <end_op>

      if (r != n1) {
    80003b28:	009c1f63          	bne	s8,s1,80003b46 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80003b2c:	013489bb          	addw	s3,s1,s3
    while (i < n) {
    80003b30:	0149db63          	bge	s3,s4,80003b46 <filewrite+0xf6>
      int n1 = n - i;
    80003b34:	413a07bb          	subw	a5,s4,s3
      if (n1 > max) n1 = max;
    80003b38:	84be                	mv	s1,a5
    80003b3a:	2781                	sext.w	a5,a5
    80003b3c:	f8fb5ce3          	bge	s6,a5,80003ad4 <filewrite+0x84>
    80003b40:	84de                	mv	s1,s7
    80003b42:	bf49                	j	80003ad4 <filewrite+0x84>
    int i = 0;
    80003b44:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003b46:	013a1f63          	bne	s4,s3,80003b64 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003b4a:	8552                	mv	a0,s4
    80003b4c:	60a6                	ld	ra,72(sp)
    80003b4e:	6406                	ld	s0,64(sp)
    80003b50:	74e2                	ld	s1,56(sp)
    80003b52:	7942                	ld	s2,48(sp)
    80003b54:	79a2                	ld	s3,40(sp)
    80003b56:	7a02                	ld	s4,32(sp)
    80003b58:	6ae2                	ld	s5,24(sp)
    80003b5a:	6b42                	ld	s6,16(sp)
    80003b5c:	6ba2                	ld	s7,8(sp)
    80003b5e:	6c02                	ld	s8,0(sp)
    80003b60:	6161                	addi	sp,sp,80
    80003b62:	8082                	ret
    ret = (i == n ? n : -1);
    80003b64:	5a7d                	li	s4,-1
    80003b66:	b7d5                	j	80003b4a <filewrite+0xfa>
    panic("filewrite");
    80003b68:	00005517          	auipc	a0,0x5
    80003b6c:	af850513          	addi	a0,a0,-1288 # 80008660 <syscalls+0x260>
    80003b70:	00003097          	auipc	ra,0x3
    80003b74:	bc8080e7          	jalr	-1080(ra) # 80006738 <panic>
  if (f->writable == 0) return -1;
    80003b78:	5a7d                	li	s4,-1
    80003b7a:	bfc1                	j	80003b4a <filewrite+0xfa>
    if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write) return -1;
    80003b7c:	5a7d                	li	s4,-1
    80003b7e:	b7f1                	j	80003b4a <filewrite+0xfa>
    80003b80:	5a7d                	li	s4,-1
    80003b82:	b7e1                	j	80003b4a <filewrite+0xfa>

0000000080003b84 <pipealloc>:
  uint nwrite;    // number of bytes written
  int readopen;   // read fd is still open
  int writeopen;  // write fd is still open
};

int pipealloc(struct file **f0, struct file **f1) {
    80003b84:	7179                	addi	sp,sp,-48
    80003b86:	f406                	sd	ra,40(sp)
    80003b88:	f022                	sd	s0,32(sp)
    80003b8a:	ec26                	sd	s1,24(sp)
    80003b8c:	e84a                	sd	s2,16(sp)
    80003b8e:	e44e                	sd	s3,8(sp)
    80003b90:	e052                	sd	s4,0(sp)
    80003b92:	1800                	addi	s0,sp,48
    80003b94:	84aa                	mv	s1,a0
    80003b96:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003b98:	0005b023          	sd	zero,0(a1)
    80003b9c:	00053023          	sd	zero,0(a0)
  if ((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0) goto bad;
    80003ba0:	00000097          	auipc	ra,0x0
    80003ba4:	c52080e7          	jalr	-942(ra) # 800037f2 <filealloc>
    80003ba8:	e088                	sd	a0,0(s1)
    80003baa:	c551                	beqz	a0,80003c36 <pipealloc+0xb2>
    80003bac:	00000097          	auipc	ra,0x0
    80003bb0:	c46080e7          	jalr	-954(ra) # 800037f2 <filealloc>
    80003bb4:	00aa3023          	sd	a0,0(s4)
    80003bb8:	c92d                	beqz	a0,80003c2a <pipealloc+0xa6>
  if ((pi = (struct pipe *)kalloc()) == 0) goto bad;
    80003bba:	ffffc097          	auipc	ra,0xffffc
    80003bbe:	4a2080e7          	jalr	1186(ra) # 8000005c <kalloc>
    80003bc2:	892a                	mv	s2,a0
    80003bc4:	c125                	beqz	a0,80003c24 <pipealloc+0xa0>
  pi->readopen = 1;
    80003bc6:	4985                	li	s3,1
    80003bc8:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003bcc:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003bd0:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003bd4:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003bd8:	00005597          	auipc	a1,0x5
    80003bdc:	a9858593          	addi	a1,a1,-1384 # 80008670 <syscalls+0x270>
    80003be0:	00003097          	auipc	ra,0x3
    80003be4:	004080e7          	jalr	4(ra) # 80006be4 <initlock>
  (*f0)->type = FD_PIPE;
    80003be8:	609c                	ld	a5,0(s1)
    80003bea:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003bee:	609c                	ld	a5,0(s1)
    80003bf0:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003bf4:	609c                	ld	a5,0(s1)
    80003bf6:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003bfa:	609c                	ld	a5,0(s1)
    80003bfc:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003c00:	000a3783          	ld	a5,0(s4)
    80003c04:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003c08:	000a3783          	ld	a5,0(s4)
    80003c0c:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003c10:	000a3783          	ld	a5,0(s4)
    80003c14:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003c18:	000a3783          	ld	a5,0(s4)
    80003c1c:	0127b823          	sd	s2,16(a5)
  return 0;
    80003c20:	4501                	li	a0,0
    80003c22:	a025                	j	80003c4a <pipealloc+0xc6>

bad:
  if (pi) kfree((char *)pi);
  if (*f0) fileclose(*f0);
    80003c24:	6088                	ld	a0,0(s1)
    80003c26:	e501                	bnez	a0,80003c2e <pipealloc+0xaa>
    80003c28:	a039                	j	80003c36 <pipealloc+0xb2>
    80003c2a:	6088                	ld	a0,0(s1)
    80003c2c:	c51d                	beqz	a0,80003c5a <pipealloc+0xd6>
    80003c2e:	00000097          	auipc	ra,0x0
    80003c32:	c48080e7          	jalr	-952(ra) # 80003876 <fileclose>
  if (*f1) fileclose(*f1);
    80003c36:	000a3783          	ld	a5,0(s4)
  return -1;
    80003c3a:	557d                	li	a0,-1
  if (*f1) fileclose(*f1);
    80003c3c:	c799                	beqz	a5,80003c4a <pipealloc+0xc6>
    80003c3e:	853e                	mv	a0,a5
    80003c40:	00000097          	auipc	ra,0x0
    80003c44:	c36080e7          	jalr	-970(ra) # 80003876 <fileclose>
  return -1;
    80003c48:	557d                	li	a0,-1
}
    80003c4a:	70a2                	ld	ra,40(sp)
    80003c4c:	7402                	ld	s0,32(sp)
    80003c4e:	64e2                	ld	s1,24(sp)
    80003c50:	6942                	ld	s2,16(sp)
    80003c52:	69a2                	ld	s3,8(sp)
    80003c54:	6a02                	ld	s4,0(sp)
    80003c56:	6145                	addi	sp,sp,48
    80003c58:	8082                	ret
  return -1;
    80003c5a:	557d                	li	a0,-1
    80003c5c:	b7fd                	j	80003c4a <pipealloc+0xc6>

0000000080003c5e <pipeclose>:

void pipeclose(struct pipe *pi, int writable) {
    80003c5e:	1101                	addi	sp,sp,-32
    80003c60:	ec06                	sd	ra,24(sp)
    80003c62:	e822                	sd	s0,16(sp)
    80003c64:	e426                	sd	s1,8(sp)
    80003c66:	e04a                	sd	s2,0(sp)
    80003c68:	1000                	addi	s0,sp,32
    80003c6a:	84aa                	mv	s1,a0
    80003c6c:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003c6e:	00003097          	auipc	ra,0x3
    80003c72:	006080e7          	jalr	6(ra) # 80006c74 <acquire>
  if (writable) {
    80003c76:	02090d63          	beqz	s2,80003cb0 <pipeclose+0x52>
    pi->writeopen = 0;
    80003c7a:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003c7e:	21848513          	addi	a0,s1,536
    80003c82:	ffffe097          	auipc	ra,0xffffe
    80003c86:	836080e7          	jalr	-1994(ra) # 800014b8 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if (pi->readopen == 0 && pi->writeopen == 0) {
    80003c8a:	2204b783          	ld	a5,544(s1)
    80003c8e:	eb95                	bnez	a5,80003cc2 <pipeclose+0x64>
    release(&pi->lock);
    80003c90:	8526                	mv	a0,s1
    80003c92:	00003097          	auipc	ra,0x3
    80003c96:	096080e7          	jalr	150(ra) # 80006d28 <release>
    kfree((char *)pi);
    80003c9a:	8526                	mv	a0,s1
    80003c9c:	ffffc097          	auipc	ra,0xffffc
    80003ca0:	3a8080e7          	jalr	936(ra) # 80000044 <kfree>
  } else
    release(&pi->lock);
}
    80003ca4:	60e2                	ld	ra,24(sp)
    80003ca6:	6442                	ld	s0,16(sp)
    80003ca8:	64a2                	ld	s1,8(sp)
    80003caa:	6902                	ld	s2,0(sp)
    80003cac:	6105                	addi	sp,sp,32
    80003cae:	8082                	ret
    pi->readopen = 0;
    80003cb0:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003cb4:	21c48513          	addi	a0,s1,540
    80003cb8:	ffffe097          	auipc	ra,0xffffe
    80003cbc:	800080e7          	jalr	-2048(ra) # 800014b8 <wakeup>
    80003cc0:	b7e9                	j	80003c8a <pipeclose+0x2c>
    release(&pi->lock);
    80003cc2:	8526                	mv	a0,s1
    80003cc4:	00003097          	auipc	ra,0x3
    80003cc8:	064080e7          	jalr	100(ra) # 80006d28 <release>
}
    80003ccc:	bfe1                	j	80003ca4 <pipeclose+0x46>

0000000080003cce <pipewrite>:

int pipewrite(struct pipe *pi, uint64 addr, int n) {
    80003cce:	711d                	addi	sp,sp,-96
    80003cd0:	ec86                	sd	ra,88(sp)
    80003cd2:	e8a2                	sd	s0,80(sp)
    80003cd4:	e4a6                	sd	s1,72(sp)
    80003cd6:	e0ca                	sd	s2,64(sp)
    80003cd8:	fc4e                	sd	s3,56(sp)
    80003cda:	f852                	sd	s4,48(sp)
    80003cdc:	f456                	sd	s5,40(sp)
    80003cde:	f05a                	sd	s6,32(sp)
    80003ce0:	ec5e                	sd	s7,24(sp)
    80003ce2:	e862                	sd	s8,16(sp)
    80003ce4:	1080                	addi	s0,sp,96
    80003ce6:	84aa                	mv	s1,a0
    80003ce8:	8aae                	mv	s5,a1
    80003cea:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003cec:	ffffd097          	auipc	ra,0xffffd
    80003cf0:	0bc080e7          	jalr	188(ra) # 80000da8 <myproc>
    80003cf4:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003cf6:	8526                	mv	a0,s1
    80003cf8:	00003097          	auipc	ra,0x3
    80003cfc:	f7c080e7          	jalr	-132(ra) # 80006c74 <acquire>
  while (i < n) {
    80003d00:	0b405663          	blez	s4,80003dac <pipewrite+0xde>
  int i = 0;
    80003d04:	4901                	li	s2,0
    if (pi->nwrite == pi->nread + PIPESIZE) {  // DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if (copyin(pr->pagetable, &ch, addr + i, 1) == -1) break;
    80003d06:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003d08:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003d0c:	21c48b93          	addi	s7,s1,540
    80003d10:	a089                	j	80003d52 <pipewrite+0x84>
      release(&pi->lock);
    80003d12:	8526                	mv	a0,s1
    80003d14:	00003097          	auipc	ra,0x3
    80003d18:	014080e7          	jalr	20(ra) # 80006d28 <release>
      return -1;
    80003d1c:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003d1e:	854a                	mv	a0,s2
    80003d20:	60e6                	ld	ra,88(sp)
    80003d22:	6446                	ld	s0,80(sp)
    80003d24:	64a6                	ld	s1,72(sp)
    80003d26:	6906                	ld	s2,64(sp)
    80003d28:	79e2                	ld	s3,56(sp)
    80003d2a:	7a42                	ld	s4,48(sp)
    80003d2c:	7aa2                	ld	s5,40(sp)
    80003d2e:	7b02                	ld	s6,32(sp)
    80003d30:	6be2                	ld	s7,24(sp)
    80003d32:	6c42                	ld	s8,16(sp)
    80003d34:	6125                	addi	sp,sp,96
    80003d36:	8082                	ret
      wakeup(&pi->nread);
    80003d38:	8562                	mv	a0,s8
    80003d3a:	ffffd097          	auipc	ra,0xffffd
    80003d3e:	77e080e7          	jalr	1918(ra) # 800014b8 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003d42:	85a6                	mv	a1,s1
    80003d44:	855e                	mv	a0,s7
    80003d46:	ffffd097          	auipc	ra,0xffffd
    80003d4a:	70e080e7          	jalr	1806(ra) # 80001454 <sleep>
  while (i < n) {
    80003d4e:	07495063          	bge	s2,s4,80003dae <pipewrite+0xe0>
    if (pi->readopen == 0 || killed(pr)) {
    80003d52:	2204a783          	lw	a5,544(s1)
    80003d56:	dfd5                	beqz	a5,80003d12 <pipewrite+0x44>
    80003d58:	854e                	mv	a0,s3
    80003d5a:	ffffe097          	auipc	ra,0xffffe
    80003d5e:	9a2080e7          	jalr	-1630(ra) # 800016fc <killed>
    80003d62:	f945                	bnez	a0,80003d12 <pipewrite+0x44>
    if (pi->nwrite == pi->nread + PIPESIZE) {  // DOC: pipewrite-full
    80003d64:	2184a783          	lw	a5,536(s1)
    80003d68:	21c4a703          	lw	a4,540(s1)
    80003d6c:	2007879b          	addiw	a5,a5,512
    80003d70:	fcf704e3          	beq	a4,a5,80003d38 <pipewrite+0x6a>
      if (copyin(pr->pagetable, &ch, addr + i, 1) == -1) break;
    80003d74:	4685                	li	a3,1
    80003d76:	01590633          	add	a2,s2,s5
    80003d7a:	faf40593          	addi	a1,s0,-81
    80003d7e:	0509b503          	ld	a0,80(s3)
    80003d82:	ffffd097          	auipc	ra,0xffffd
    80003d86:	d6e080e7          	jalr	-658(ra) # 80000af0 <copyin>
    80003d8a:	03650263          	beq	a0,s6,80003dae <pipewrite+0xe0>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003d8e:	21c4a783          	lw	a5,540(s1)
    80003d92:	0017871b          	addiw	a4,a5,1
    80003d96:	20e4ae23          	sw	a4,540(s1)
    80003d9a:	1ff7f793          	andi	a5,a5,511
    80003d9e:	97a6                	add	a5,a5,s1
    80003da0:	faf44703          	lbu	a4,-81(s0)
    80003da4:	00e78c23          	sb	a4,24(a5)
      i++;
    80003da8:	2905                	addiw	s2,s2,1
    80003daa:	b755                	j	80003d4e <pipewrite+0x80>
  int i = 0;
    80003dac:	4901                	li	s2,0
  wakeup(&pi->nread);
    80003dae:	21848513          	addi	a0,s1,536
    80003db2:	ffffd097          	auipc	ra,0xffffd
    80003db6:	706080e7          	jalr	1798(ra) # 800014b8 <wakeup>
  release(&pi->lock);
    80003dba:	8526                	mv	a0,s1
    80003dbc:	00003097          	auipc	ra,0x3
    80003dc0:	f6c080e7          	jalr	-148(ra) # 80006d28 <release>
  return i;
    80003dc4:	bfa9                	j	80003d1e <pipewrite+0x50>

0000000080003dc6 <piperead>:

int piperead(struct pipe *pi, uint64 addr, int n) {
    80003dc6:	715d                	addi	sp,sp,-80
    80003dc8:	e486                	sd	ra,72(sp)
    80003dca:	e0a2                	sd	s0,64(sp)
    80003dcc:	fc26                	sd	s1,56(sp)
    80003dce:	f84a                	sd	s2,48(sp)
    80003dd0:	f44e                	sd	s3,40(sp)
    80003dd2:	f052                	sd	s4,32(sp)
    80003dd4:	ec56                	sd	s5,24(sp)
    80003dd6:	e85a                	sd	s6,16(sp)
    80003dd8:	0880                	addi	s0,sp,80
    80003dda:	84aa                	mv	s1,a0
    80003ddc:	892e                	mv	s2,a1
    80003dde:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80003de0:	ffffd097          	auipc	ra,0xffffd
    80003de4:	fc8080e7          	jalr	-56(ra) # 80000da8 <myproc>
    80003de8:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003dea:	8526                	mv	a0,s1
    80003dec:	00003097          	auipc	ra,0x3
    80003df0:	e88080e7          	jalr	-376(ra) # 80006c74 <acquire>
  while (pi->nread == pi->nwrite && pi->writeopen) {  // DOC: pipe-empty
    80003df4:	2184a703          	lw	a4,536(s1)
    80003df8:	21c4a783          	lw	a5,540(s1)
    if (killed(pr)) {
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock);  // DOC: piperead-sleep
    80003dfc:	21848993          	addi	s3,s1,536
  while (pi->nread == pi->nwrite && pi->writeopen) {  // DOC: pipe-empty
    80003e00:	02f71763          	bne	a4,a5,80003e2e <piperead+0x68>
    80003e04:	2244a783          	lw	a5,548(s1)
    80003e08:	c39d                	beqz	a5,80003e2e <piperead+0x68>
    if (killed(pr)) {
    80003e0a:	8552                	mv	a0,s4
    80003e0c:	ffffe097          	auipc	ra,0xffffe
    80003e10:	8f0080e7          	jalr	-1808(ra) # 800016fc <killed>
    80003e14:	e941                	bnez	a0,80003ea4 <piperead+0xde>
    sleep(&pi->nread, &pi->lock);  // DOC: piperead-sleep
    80003e16:	85a6                	mv	a1,s1
    80003e18:	854e                	mv	a0,s3
    80003e1a:	ffffd097          	auipc	ra,0xffffd
    80003e1e:	63a080e7          	jalr	1594(ra) # 80001454 <sleep>
  while (pi->nread == pi->nwrite && pi->writeopen) {  // DOC: pipe-empty
    80003e22:	2184a703          	lw	a4,536(s1)
    80003e26:	21c4a783          	lw	a5,540(s1)
    80003e2a:	fcf70de3          	beq	a4,a5,80003e04 <piperead+0x3e>
  }
  for (i = 0; i < n; i++) {  // DOC: piperead-copy
    80003e2e:	4981                	li	s3,0
    if (pi->nread == pi->nwrite) break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if (copyout(pr->pagetable, addr + i, &ch, 1) == -1) break;
    80003e30:	5b7d                	li	s6,-1
  for (i = 0; i < n; i++) {  // DOC: piperead-copy
    80003e32:	05505363          	blez	s5,80003e78 <piperead+0xb2>
    if (pi->nread == pi->nwrite) break;
    80003e36:	2184a783          	lw	a5,536(s1)
    80003e3a:	21c4a703          	lw	a4,540(s1)
    80003e3e:	02f70d63          	beq	a4,a5,80003e78 <piperead+0xb2>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80003e42:	0017871b          	addiw	a4,a5,1
    80003e46:	20e4ac23          	sw	a4,536(s1)
    80003e4a:	1ff7f793          	andi	a5,a5,511
    80003e4e:	97a6                	add	a5,a5,s1
    80003e50:	0187c783          	lbu	a5,24(a5)
    80003e54:	faf40fa3          	sb	a5,-65(s0)
    if (copyout(pr->pagetable, addr + i, &ch, 1) == -1) break;
    80003e58:	4685                	li	a3,1
    80003e5a:	fbf40613          	addi	a2,s0,-65
    80003e5e:	85ca                	mv	a1,s2
    80003e60:	050a3503          	ld	a0,80(s4)
    80003e64:	ffffd097          	auipc	ra,0xffffd
    80003e68:	bcc080e7          	jalr	-1076(ra) # 80000a30 <copyout>
    80003e6c:	01650663          	beq	a0,s6,80003e78 <piperead+0xb2>
  for (i = 0; i < n; i++) {  // DOC: piperead-copy
    80003e70:	2985                	addiw	s3,s3,1
    80003e72:	0905                	addi	s2,s2,1
    80003e74:	fd3a91e3          	bne	s5,s3,80003e36 <piperead+0x70>
  }
  wakeup(&pi->nwrite);  // DOC: piperead-wakeup
    80003e78:	21c48513          	addi	a0,s1,540
    80003e7c:	ffffd097          	auipc	ra,0xffffd
    80003e80:	63c080e7          	jalr	1596(ra) # 800014b8 <wakeup>
  release(&pi->lock);
    80003e84:	8526                	mv	a0,s1
    80003e86:	00003097          	auipc	ra,0x3
    80003e8a:	ea2080e7          	jalr	-350(ra) # 80006d28 <release>
  return i;
}
    80003e8e:	854e                	mv	a0,s3
    80003e90:	60a6                	ld	ra,72(sp)
    80003e92:	6406                	ld	s0,64(sp)
    80003e94:	74e2                	ld	s1,56(sp)
    80003e96:	7942                	ld	s2,48(sp)
    80003e98:	79a2                	ld	s3,40(sp)
    80003e9a:	7a02                	ld	s4,32(sp)
    80003e9c:	6ae2                	ld	s5,24(sp)
    80003e9e:	6b42                	ld	s6,16(sp)
    80003ea0:	6161                	addi	sp,sp,80
    80003ea2:	8082                	ret
      release(&pi->lock);
    80003ea4:	8526                	mv	a0,s1
    80003ea6:	00003097          	auipc	ra,0x3
    80003eaa:	e82080e7          	jalr	-382(ra) # 80006d28 <release>
      return -1;
    80003eae:	59fd                	li	s3,-1
    80003eb0:	bff9                	j	80003e8e <piperead+0xc8>

0000000080003eb2 <flags2perm>:
#include "riscv.h"
#include "types.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags) {
    80003eb2:	1141                	addi	sp,sp,-16
    80003eb4:	e422                	sd	s0,8(sp)
    80003eb6:	0800                	addi	s0,sp,16
    80003eb8:	87aa                	mv	a5,a0
  int perm = 0;
  if (flags & 0x1) perm = PTE_X;
    80003eba:	8905                	andi	a0,a0,1
    80003ebc:	c111                	beqz	a0,80003ec0 <flags2perm+0xe>
    80003ebe:	4521                	li	a0,8
  if (flags & 0x2) perm |= PTE_W;
    80003ec0:	8b89                	andi	a5,a5,2
    80003ec2:	c399                	beqz	a5,80003ec8 <flags2perm+0x16>
    80003ec4:	00456513          	ori	a0,a0,4
  return perm;
}
    80003ec8:	6422                	ld	s0,8(sp)
    80003eca:	0141                	addi	sp,sp,16
    80003ecc:	8082                	ret

0000000080003ece <exec>:

int exec(char *path, char **argv) {
    80003ece:	de010113          	addi	sp,sp,-544
    80003ed2:	20113c23          	sd	ra,536(sp)
    80003ed6:	20813823          	sd	s0,528(sp)
    80003eda:	20913423          	sd	s1,520(sp)
    80003ede:	21213023          	sd	s2,512(sp)
    80003ee2:	ffce                	sd	s3,504(sp)
    80003ee4:	fbd2                	sd	s4,496(sp)
    80003ee6:	f7d6                	sd	s5,488(sp)
    80003ee8:	f3da                	sd	s6,480(sp)
    80003eea:	efde                	sd	s7,472(sp)
    80003eec:	ebe2                	sd	s8,464(sp)
    80003eee:	e7e6                	sd	s9,456(sp)
    80003ef0:	e3ea                	sd	s10,448(sp)
    80003ef2:	ff6e                	sd	s11,440(sp)
    80003ef4:	1400                	addi	s0,sp,544
    80003ef6:	892a                	mv	s2,a0
    80003ef8:	dea43423          	sd	a0,-536(s0)
    80003efc:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80003f00:	ffffd097          	auipc	ra,0xffffd
    80003f04:	ea8080e7          	jalr	-344(ra) # 80000da8 <myproc>
    80003f08:	84aa                	mv	s1,a0

  begin_op();
    80003f0a:	fffff097          	auipc	ra,0xfffff
    80003f0e:	4f4080e7          	jalr	1268(ra) # 800033fe <begin_op>

  if ((ip = namei(path)) == 0) {
    80003f12:	854a                	mv	a0,s2
    80003f14:	fffff097          	auipc	ra,0xfffff
    80003f18:	2ce080e7          	jalr	718(ra) # 800031e2 <namei>
    80003f1c:	c93d                	beqz	a0,80003f92 <exec+0xc4>
    80003f1e:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80003f20:	fffff097          	auipc	ra,0xfffff
    80003f24:	b1c080e7          	jalr	-1252(ra) # 80002a3c <ilock>

  // Check ELF header
  if (readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf)) goto bad;
    80003f28:	04000713          	li	a4,64
    80003f2c:	4681                	li	a3,0
    80003f2e:	e5040613          	addi	a2,s0,-432
    80003f32:	4581                	li	a1,0
    80003f34:	8556                	mv	a0,s5
    80003f36:	fffff097          	auipc	ra,0xfffff
    80003f3a:	dba080e7          	jalr	-582(ra) # 80002cf0 <readi>
    80003f3e:	04000793          	li	a5,64
    80003f42:	00f51a63          	bne	a0,a5,80003f56 <exec+0x88>

  if (elf.magic != ELF_MAGIC) goto bad;
    80003f46:	e5042703          	lw	a4,-432(s0)
    80003f4a:	464c47b7          	lui	a5,0x464c4
    80003f4e:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80003f52:	04f70663          	beq	a4,a5,80003f9e <exec+0xd0>
  return argc;  // this ends up in a0, the first argument to main(argc, argv)

bad:
  if (pagetable) proc_freepagetable(pagetable, sz);
  if (ip) {
    iunlockput(ip);
    80003f56:	8556                	mv	a0,s5
    80003f58:	fffff097          	auipc	ra,0xfffff
    80003f5c:	d46080e7          	jalr	-698(ra) # 80002c9e <iunlockput>
    end_op();
    80003f60:	fffff097          	auipc	ra,0xfffff
    80003f64:	51e080e7          	jalr	1310(ra) # 8000347e <end_op>
  }
  return -1;
    80003f68:	557d                	li	a0,-1
}
    80003f6a:	21813083          	ld	ra,536(sp)
    80003f6e:	21013403          	ld	s0,528(sp)
    80003f72:	20813483          	ld	s1,520(sp)
    80003f76:	20013903          	ld	s2,512(sp)
    80003f7a:	79fe                	ld	s3,504(sp)
    80003f7c:	7a5e                	ld	s4,496(sp)
    80003f7e:	7abe                	ld	s5,488(sp)
    80003f80:	7b1e                	ld	s6,480(sp)
    80003f82:	6bfe                	ld	s7,472(sp)
    80003f84:	6c5e                	ld	s8,464(sp)
    80003f86:	6cbe                	ld	s9,456(sp)
    80003f88:	6d1e                	ld	s10,448(sp)
    80003f8a:	7dfa                	ld	s11,440(sp)
    80003f8c:	22010113          	addi	sp,sp,544
    80003f90:	8082                	ret
    end_op();
    80003f92:	fffff097          	auipc	ra,0xfffff
    80003f96:	4ec080e7          	jalr	1260(ra) # 8000347e <end_op>
    return -1;
    80003f9a:	557d                	li	a0,-1
    80003f9c:	b7f9                	j	80003f6a <exec+0x9c>
  if ((pagetable = proc_pagetable(p)) == 0) goto bad;
    80003f9e:	8526                	mv	a0,s1
    80003fa0:	ffffd097          	auipc	ra,0xffffd
    80003fa4:	ed0080e7          	jalr	-304(ra) # 80000e70 <proc_pagetable>
    80003fa8:	8b2a                	mv	s6,a0
    80003faa:	d555                	beqz	a0,80003f56 <exec+0x88>
  for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    80003fac:	e7042783          	lw	a5,-400(s0)
    80003fb0:	e8845703          	lhu	a4,-376(s0)
    80003fb4:	c735                	beqz	a4,80004020 <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003fb6:	4901                	li	s2,0
  for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    80003fb8:	e0043423          	sd	zero,-504(s0)
    if (ph.vaddr % PGSIZE != 0) goto bad;
    80003fbc:	6a05                	lui	s4,0x1
    80003fbe:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80003fc2:	dee43023          	sd	a4,-544(s0)
static int loadseg(pagetable_t pagetable, uint64 va, struct inode *ip,
                   uint offset, uint sz) {
  uint i, n;
  uint64 pa;

  for (i = 0; i < sz; i += PGSIZE) {
    80003fc6:	6d85                	lui	s11,0x1
    80003fc8:	7d7d                	lui	s10,0xfffff
    80003fca:	a481                	j	8000420a <exec+0x33c>
    pa = walkaddr(pagetable, va + i);
    if (pa == 0) panic("loadseg: address should exist");
    80003fcc:	00004517          	auipc	a0,0x4
    80003fd0:	6ac50513          	addi	a0,a0,1708 # 80008678 <syscalls+0x278>
    80003fd4:	00002097          	auipc	ra,0x2
    80003fd8:	764080e7          	jalr	1892(ra) # 80006738 <panic>
    if (sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if (readi(ip, 0, (uint64)pa, offset + i, n) != n) return -1;
    80003fdc:	874a                	mv	a4,s2
    80003fde:	009c86bb          	addw	a3,s9,s1
    80003fe2:	4581                	li	a1,0
    80003fe4:	8556                	mv	a0,s5
    80003fe6:	fffff097          	auipc	ra,0xfffff
    80003fea:	d0a080e7          	jalr	-758(ra) # 80002cf0 <readi>
    80003fee:	2501                	sext.w	a0,a0
    80003ff0:	1aa91a63          	bne	s2,a0,800041a4 <exec+0x2d6>
  for (i = 0; i < sz; i += PGSIZE) {
    80003ff4:	009d84bb          	addw	s1,s11,s1
    80003ff8:	013d09bb          	addw	s3,s10,s3
    80003ffc:	1f74f763          	bgeu	s1,s7,800041ea <exec+0x31c>
    pa = walkaddr(pagetable, va + i);
    80004000:	02049593          	slli	a1,s1,0x20
    80004004:	9181                	srli	a1,a1,0x20
    80004006:	95e2                	add	a1,a1,s8
    80004008:	855a                	mv	a0,s6
    8000400a:	ffffc097          	auipc	ra,0xffffc
    8000400e:	3f6080e7          	jalr	1014(ra) # 80000400 <walkaddr>
    80004012:	862a                	mv	a2,a0
    if (pa == 0) panic("loadseg: address should exist");
    80004014:	dd45                	beqz	a0,80003fcc <exec+0xfe>
      n = PGSIZE;
    80004016:	8952                	mv	s2,s4
    if (sz - i < PGSIZE)
    80004018:	fd49f2e3          	bgeu	s3,s4,80003fdc <exec+0x10e>
      n = sz - i;
    8000401c:	894e                	mv	s2,s3
    8000401e:	bf7d                	j	80003fdc <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004020:	4901                	li	s2,0
  iunlockput(ip);
    80004022:	8556                	mv	a0,s5
    80004024:	fffff097          	auipc	ra,0xfffff
    80004028:	c7a080e7          	jalr	-902(ra) # 80002c9e <iunlockput>
  end_op();
    8000402c:	fffff097          	auipc	ra,0xfffff
    80004030:	452080e7          	jalr	1106(ra) # 8000347e <end_op>
  p = myproc();
    80004034:	ffffd097          	auipc	ra,0xffffd
    80004038:	d74080e7          	jalr	-652(ra) # 80000da8 <myproc>
    8000403c:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    8000403e:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004042:	6785                	lui	a5,0x1
    80004044:	17fd                	addi	a5,a5,-1
    80004046:	993e                	add	s2,s2,a5
    80004048:	77fd                	lui	a5,0xfffff
    8000404a:	00f977b3          	and	a5,s2,a5
    8000404e:	def43c23          	sd	a5,-520(s0)
  if ((sz1 = uvmalloc(pagetable, sz, sz + 2 * PGSIZE, PTE_W)) == 0) goto bad;
    80004052:	4691                	li	a3,4
    80004054:	6609                	lui	a2,0x2
    80004056:	963e                	add	a2,a2,a5
    80004058:	85be                	mv	a1,a5
    8000405a:	855a                	mv	a0,s6
    8000405c:	ffffc097          	auipc	ra,0xffffc
    80004060:	77c080e7          	jalr	1916(ra) # 800007d8 <uvmalloc>
    80004064:	8c2a                	mv	s8,a0
  ip = 0;
    80004066:	4a81                	li	s5,0
  if ((sz1 = uvmalloc(pagetable, sz, sz + 2 * PGSIZE, PTE_W)) == 0) goto bad;
    80004068:	12050e63          	beqz	a0,800041a4 <exec+0x2d6>
  uvmclear(pagetable, sz - 2 * PGSIZE);
    8000406c:	75f9                	lui	a1,0xffffe
    8000406e:	95aa                	add	a1,a1,a0
    80004070:	855a                	mv	a0,s6
    80004072:	ffffd097          	auipc	ra,0xffffd
    80004076:	98c080e7          	jalr	-1652(ra) # 800009fe <uvmclear>
  stackbase = sp - PGSIZE;
    8000407a:	7afd                	lui	s5,0xfffff
    8000407c:	9ae2                	add	s5,s5,s8
  for (argc = 0; argv[argc]; argc++) {
    8000407e:	df043783          	ld	a5,-528(s0)
    80004082:	6388                	ld	a0,0(a5)
    80004084:	c925                	beqz	a0,800040f4 <exec+0x226>
    80004086:	e9040993          	addi	s3,s0,-368
    8000408a:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    8000408e:	8962                	mv	s2,s8
  for (argc = 0; argv[argc]; argc++) {
    80004090:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80004092:	ffffc097          	auipc	ra,0xffffc
    80004096:	160080e7          	jalr	352(ra) # 800001f2 <strlen>
    8000409a:	0015079b          	addiw	a5,a0,1
    8000409e:	40f90933          	sub	s2,s2,a5
    sp -= sp % 16;  // riscv sp must be 16-byte aligned
    800040a2:	ff097913          	andi	s2,s2,-16
    if (sp < stackbase) goto bad;
    800040a6:	13596663          	bltu	s2,s5,800041d2 <exec+0x304>
    if (copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800040aa:	df043d83          	ld	s11,-528(s0)
    800040ae:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    800040b2:	8552                	mv	a0,s4
    800040b4:	ffffc097          	auipc	ra,0xffffc
    800040b8:	13e080e7          	jalr	318(ra) # 800001f2 <strlen>
    800040bc:	0015069b          	addiw	a3,a0,1
    800040c0:	8652                	mv	a2,s4
    800040c2:	85ca                	mv	a1,s2
    800040c4:	855a                	mv	a0,s6
    800040c6:	ffffd097          	auipc	ra,0xffffd
    800040ca:	96a080e7          	jalr	-1686(ra) # 80000a30 <copyout>
    800040ce:	10054663          	bltz	a0,800041da <exec+0x30c>
    ustack[argc] = sp;
    800040d2:	0129b023          	sd	s2,0(s3)
  for (argc = 0; argv[argc]; argc++) {
    800040d6:	0485                	addi	s1,s1,1
    800040d8:	008d8793          	addi	a5,s11,8
    800040dc:	def43823          	sd	a5,-528(s0)
    800040e0:	008db503          	ld	a0,8(s11)
    800040e4:	c911                	beqz	a0,800040f8 <exec+0x22a>
    if (argc >= MAXARG) goto bad;
    800040e6:	09a1                	addi	s3,s3,8
    800040e8:	fb3c95e3          	bne	s9,s3,80004092 <exec+0x1c4>
  sz = sz1;
    800040ec:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    800040f0:	4a81                	li	s5,0
    800040f2:	a84d                	j	800041a4 <exec+0x2d6>
  sp = sz;
    800040f4:	8962                	mv	s2,s8
  for (argc = 0; argv[argc]; argc++) {
    800040f6:	4481                	li	s1,0
  ustack[argc] = 0;
    800040f8:	00349793          	slli	a5,s1,0x3
    800040fc:	f9040713          	addi	a4,s0,-112
    80004100:	97ba                	add	a5,a5,a4
    80004102:	f007b023          	sd	zero,-256(a5) # ffffffffffffef00 <end+0xffffffff7ffde010>
  sp -= (argc + 1) * sizeof(uint64);
    80004106:	00148693          	addi	a3,s1,1
    8000410a:	068e                	slli	a3,a3,0x3
    8000410c:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004110:	ff097913          	andi	s2,s2,-16
  if (sp < stackbase) goto bad;
    80004114:	01597663          	bgeu	s2,s5,80004120 <exec+0x252>
  sz = sz1;
    80004118:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000411c:	4a81                	li	s5,0
    8000411e:	a059                	j	800041a4 <exec+0x2d6>
  if (copyout(pagetable, sp, (char *)ustack, (argc + 1) * sizeof(uint64)) < 0)
    80004120:	e9040613          	addi	a2,s0,-368
    80004124:	85ca                	mv	a1,s2
    80004126:	855a                	mv	a0,s6
    80004128:	ffffd097          	auipc	ra,0xffffd
    8000412c:	908080e7          	jalr	-1784(ra) # 80000a30 <copyout>
    80004130:	0a054963          	bltz	a0,800041e2 <exec+0x314>
  p->trapframe->a1 = sp;
    80004134:	058bb783          	ld	a5,88(s7) # 1058 <_entry-0x7fffefa8>
    80004138:	0727bc23          	sd	s2,120(a5)
  for (last = s = path; *s; s++)
    8000413c:	de843783          	ld	a5,-536(s0)
    80004140:	0007c703          	lbu	a4,0(a5)
    80004144:	cf11                	beqz	a4,80004160 <exec+0x292>
    80004146:	0785                	addi	a5,a5,1
    if (*s == '/') last = s + 1;
    80004148:	02f00693          	li	a3,47
    8000414c:	a039                	j	8000415a <exec+0x28c>
    8000414e:	def43423          	sd	a5,-536(s0)
  for (last = s = path; *s; s++)
    80004152:	0785                	addi	a5,a5,1
    80004154:	fff7c703          	lbu	a4,-1(a5)
    80004158:	c701                	beqz	a4,80004160 <exec+0x292>
    if (*s == '/') last = s + 1;
    8000415a:	fed71ce3          	bne	a4,a3,80004152 <exec+0x284>
    8000415e:	bfc5                	j	8000414e <exec+0x280>
  safestrcpy(p->name, last, sizeof(p->name));
    80004160:	4641                	li	a2,16
    80004162:	de843583          	ld	a1,-536(s0)
    80004166:	158b8513          	addi	a0,s7,344
    8000416a:	ffffc097          	auipc	ra,0xffffc
    8000416e:	056080e7          	jalr	86(ra) # 800001c0 <safestrcpy>
  oldpagetable = p->pagetable;
    80004172:	050bb503          	ld	a0,80(s7)
  p->pagetable = pagetable;
    80004176:	056bb823          	sd	s6,80(s7)
  p->sz = sz;
    8000417a:	058bb423          	sd	s8,72(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    8000417e:	058bb783          	ld	a5,88(s7)
    80004182:	e6843703          	ld	a4,-408(s0)
    80004186:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp;          // initial stack pointer
    80004188:	058bb783          	ld	a5,88(s7)
    8000418c:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004190:	85ea                	mv	a1,s10
    80004192:	ffffd097          	auipc	ra,0xffffd
    80004196:	d7a080e7          	jalr	-646(ra) # 80000f0c <proc_freepagetable>
  return argc;  // this ends up in a0, the first argument to main(argc, argv)
    8000419a:	0004851b          	sext.w	a0,s1
    8000419e:	b3f1                	j	80003f6a <exec+0x9c>
    800041a0:	df243c23          	sd	s2,-520(s0)
  if (pagetable) proc_freepagetable(pagetable, sz);
    800041a4:	df843583          	ld	a1,-520(s0)
    800041a8:	855a                	mv	a0,s6
    800041aa:	ffffd097          	auipc	ra,0xffffd
    800041ae:	d62080e7          	jalr	-670(ra) # 80000f0c <proc_freepagetable>
  if (ip) {
    800041b2:	da0a92e3          	bnez	s5,80003f56 <exec+0x88>
  return -1;
    800041b6:	557d                	li	a0,-1
    800041b8:	bb4d                	j	80003f6a <exec+0x9c>
    800041ba:	df243c23          	sd	s2,-520(s0)
    800041be:	b7dd                	j	800041a4 <exec+0x2d6>
    800041c0:	df243c23          	sd	s2,-520(s0)
    800041c4:	b7c5                	j	800041a4 <exec+0x2d6>
    800041c6:	df243c23          	sd	s2,-520(s0)
    800041ca:	bfe9                	j	800041a4 <exec+0x2d6>
    800041cc:	df243c23          	sd	s2,-520(s0)
    800041d0:	bfd1                	j	800041a4 <exec+0x2d6>
  sz = sz1;
    800041d2:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    800041d6:	4a81                	li	s5,0
    800041d8:	b7f1                	j	800041a4 <exec+0x2d6>
  sz = sz1;
    800041da:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    800041de:	4a81                	li	s5,0
    800041e0:	b7d1                	j	800041a4 <exec+0x2d6>
  sz = sz1;
    800041e2:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    800041e6:	4a81                	li	s5,0
    800041e8:	bf75                	j	800041a4 <exec+0x2d6>
    if ((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz,
    800041ea:	df843903          	ld	s2,-520(s0)
  for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    800041ee:	e0843783          	ld	a5,-504(s0)
    800041f2:	0017869b          	addiw	a3,a5,1
    800041f6:	e0d43423          	sd	a3,-504(s0)
    800041fa:	e0043783          	ld	a5,-512(s0)
    800041fe:	0387879b          	addiw	a5,a5,56
    80004202:	e8845703          	lhu	a4,-376(s0)
    80004206:	e0e6dee3          	bge	a3,a4,80004022 <exec+0x154>
    if (readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph)) goto bad;
    8000420a:	2781                	sext.w	a5,a5
    8000420c:	e0f43023          	sd	a5,-512(s0)
    80004210:	03800713          	li	a4,56
    80004214:	86be                	mv	a3,a5
    80004216:	e1840613          	addi	a2,s0,-488
    8000421a:	4581                	li	a1,0
    8000421c:	8556                	mv	a0,s5
    8000421e:	fffff097          	auipc	ra,0xfffff
    80004222:	ad2080e7          	jalr	-1326(ra) # 80002cf0 <readi>
    80004226:	03800793          	li	a5,56
    8000422a:	f6f51be3          	bne	a0,a5,800041a0 <exec+0x2d2>
    if (ph.type != ELF_PROG_LOAD) continue;
    8000422e:	e1842783          	lw	a5,-488(s0)
    80004232:	4705                	li	a4,1
    80004234:	fae79de3          	bne	a5,a4,800041ee <exec+0x320>
    if (ph.memsz < ph.filesz) goto bad;
    80004238:	e4043483          	ld	s1,-448(s0)
    8000423c:	e3843783          	ld	a5,-456(s0)
    80004240:	f6f4ede3          	bltu	s1,a5,800041ba <exec+0x2ec>
    if (ph.vaddr + ph.memsz < ph.vaddr) goto bad;
    80004244:	e2843783          	ld	a5,-472(s0)
    80004248:	94be                	add	s1,s1,a5
    8000424a:	f6f4ebe3          	bltu	s1,a5,800041c0 <exec+0x2f2>
    if (ph.vaddr % PGSIZE != 0) goto bad;
    8000424e:	de043703          	ld	a4,-544(s0)
    80004252:	8ff9                	and	a5,a5,a4
    80004254:	fbad                	bnez	a5,800041c6 <exec+0x2f8>
    if ((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz,
    80004256:	e1c42503          	lw	a0,-484(s0)
    8000425a:	00000097          	auipc	ra,0x0
    8000425e:	c58080e7          	jalr	-936(ra) # 80003eb2 <flags2perm>
    80004262:	86aa                	mv	a3,a0
    80004264:	8626                	mv	a2,s1
    80004266:	85ca                	mv	a1,s2
    80004268:	855a                	mv	a0,s6
    8000426a:	ffffc097          	auipc	ra,0xffffc
    8000426e:	56e080e7          	jalr	1390(ra) # 800007d8 <uvmalloc>
    80004272:	dea43c23          	sd	a0,-520(s0)
    80004276:	d939                	beqz	a0,800041cc <exec+0x2fe>
    if (loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0) goto bad;
    80004278:	e2843c03          	ld	s8,-472(s0)
    8000427c:	e2042c83          	lw	s9,-480(s0)
    80004280:	e3842b83          	lw	s7,-456(s0)
  for (i = 0; i < sz; i += PGSIZE) {
    80004284:	f60b83e3          	beqz	s7,800041ea <exec+0x31c>
    80004288:	89de                	mv	s3,s7
    8000428a:	4481                	li	s1,0
    8000428c:	bb95                	j	80004000 <exec+0x132>

000000008000428e <argfd>:
#include "stat.h"
#include "types.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int argfd(int n, int *pfd, struct file **pf) {
    8000428e:	7179                	addi	sp,sp,-48
    80004290:	f406                	sd	ra,40(sp)
    80004292:	f022                	sd	s0,32(sp)
    80004294:	ec26                	sd	s1,24(sp)
    80004296:	e84a                	sd	s2,16(sp)
    80004298:	1800                	addi	s0,sp,48
    8000429a:	892e                	mv	s2,a1
    8000429c:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    8000429e:	fdc40593          	addi	a1,s0,-36
    800042a2:	ffffe097          	auipc	ra,0xffffe
    800042a6:	c20080e7          	jalr	-992(ra) # 80001ec2 <argint>
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0) return -1;
    800042aa:	fdc42703          	lw	a4,-36(s0)
    800042ae:	47bd                	li	a5,15
    800042b0:	02e7eb63          	bltu	a5,a4,800042e6 <argfd+0x58>
    800042b4:	ffffd097          	auipc	ra,0xffffd
    800042b8:	af4080e7          	jalr	-1292(ra) # 80000da8 <myproc>
    800042bc:	fdc42703          	lw	a4,-36(s0)
    800042c0:	01a70793          	addi	a5,a4,26
    800042c4:	078e                	slli	a5,a5,0x3
    800042c6:	953e                	add	a0,a0,a5
    800042c8:	611c                	ld	a5,0(a0)
    800042ca:	c385                	beqz	a5,800042ea <argfd+0x5c>
  if (pfd) *pfd = fd;
    800042cc:	00090463          	beqz	s2,800042d4 <argfd+0x46>
    800042d0:	00e92023          	sw	a4,0(s2)
  if (pf) *pf = f;
  return 0;
    800042d4:	4501                	li	a0,0
  if (pf) *pf = f;
    800042d6:	c091                	beqz	s1,800042da <argfd+0x4c>
    800042d8:	e09c                	sd	a5,0(s1)
}
    800042da:	70a2                	ld	ra,40(sp)
    800042dc:	7402                	ld	s0,32(sp)
    800042de:	64e2                	ld	s1,24(sp)
    800042e0:	6942                	ld	s2,16(sp)
    800042e2:	6145                	addi	sp,sp,48
    800042e4:	8082                	ret
  if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0) return -1;
    800042e6:	557d                	li	a0,-1
    800042e8:	bfcd                	j	800042da <argfd+0x4c>
    800042ea:	557d                	li	a0,-1
    800042ec:	b7fd                	j	800042da <argfd+0x4c>

00000000800042ee <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int fdalloc(struct file *f) {
    800042ee:	1101                	addi	sp,sp,-32
    800042f0:	ec06                	sd	ra,24(sp)
    800042f2:	e822                	sd	s0,16(sp)
    800042f4:	e426                	sd	s1,8(sp)
    800042f6:	1000                	addi	s0,sp,32
    800042f8:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800042fa:	ffffd097          	auipc	ra,0xffffd
    800042fe:	aae080e7          	jalr	-1362(ra) # 80000da8 <myproc>
    80004302:	862a                	mv	a2,a0

  for (fd = 0; fd < NOFILE; fd++) {
    80004304:	0d050793          	addi	a5,a0,208
    80004308:	4501                	li	a0,0
    8000430a:	46c1                	li	a3,16
    if (p->ofile[fd] == 0) {
    8000430c:	6398                	ld	a4,0(a5)
    8000430e:	cb19                	beqz	a4,80004324 <fdalloc+0x36>
  for (fd = 0; fd < NOFILE; fd++) {
    80004310:	2505                	addiw	a0,a0,1
    80004312:	07a1                	addi	a5,a5,8
    80004314:	fed51ce3          	bne	a0,a3,8000430c <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004318:	557d                	li	a0,-1
}
    8000431a:	60e2                	ld	ra,24(sp)
    8000431c:	6442                	ld	s0,16(sp)
    8000431e:	64a2                	ld	s1,8(sp)
    80004320:	6105                	addi	sp,sp,32
    80004322:	8082                	ret
      p->ofile[fd] = f;
    80004324:	01a50793          	addi	a5,a0,26
    80004328:	078e                	slli	a5,a5,0x3
    8000432a:	963e                	add	a2,a2,a5
    8000432c:	e204                	sd	s1,0(a2)
      return fd;
    8000432e:	b7f5                	j	8000431a <fdalloc+0x2c>

0000000080004330 <create>:
  iunlockput(dp);
  end_op();
  return -1;
}

static struct inode *create(char *path, short type, short major, short minor) {
    80004330:	715d                	addi	sp,sp,-80
    80004332:	e486                	sd	ra,72(sp)
    80004334:	e0a2                	sd	s0,64(sp)
    80004336:	fc26                	sd	s1,56(sp)
    80004338:	f84a                	sd	s2,48(sp)
    8000433a:	f44e                	sd	s3,40(sp)
    8000433c:	f052                	sd	s4,32(sp)
    8000433e:	ec56                	sd	s5,24(sp)
    80004340:	e85a                	sd	s6,16(sp)
    80004342:	0880                	addi	s0,sp,80
    80004344:	8b2e                	mv	s6,a1
    80004346:	89b2                	mv	s3,a2
    80004348:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if ((dp = nameiparent(path, name)) == 0) return 0;
    8000434a:	fb040593          	addi	a1,s0,-80
    8000434e:	fffff097          	auipc	ra,0xfffff
    80004352:	eb2080e7          	jalr	-334(ra) # 80003200 <nameiparent>
    80004356:	84aa                	mv	s1,a0
    80004358:	14050f63          	beqz	a0,800044b6 <create+0x186>

  ilock(dp);
    8000435c:	ffffe097          	auipc	ra,0xffffe
    80004360:	6e0080e7          	jalr	1760(ra) # 80002a3c <ilock>

  if ((ip = dirlookup(dp, name, 0)) != 0) {
    80004364:	4601                	li	a2,0
    80004366:	fb040593          	addi	a1,s0,-80
    8000436a:	8526                	mv	a0,s1
    8000436c:	fffff097          	auipc	ra,0xfffff
    80004370:	bb4080e7          	jalr	-1100(ra) # 80002f20 <dirlookup>
    80004374:	8aaa                	mv	s5,a0
    80004376:	c931                	beqz	a0,800043ca <create+0x9a>
    iunlockput(dp);
    80004378:	8526                	mv	a0,s1
    8000437a:	fffff097          	auipc	ra,0xfffff
    8000437e:	924080e7          	jalr	-1756(ra) # 80002c9e <iunlockput>
    ilock(ip);
    80004382:	8556                	mv	a0,s5
    80004384:	ffffe097          	auipc	ra,0xffffe
    80004388:	6b8080e7          	jalr	1720(ra) # 80002a3c <ilock>
    if (type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    8000438c:	000b059b          	sext.w	a1,s6
    80004390:	4789                	li	a5,2
    80004392:	02f59563          	bne	a1,a5,800043bc <create+0x8c>
    80004396:	044ad783          	lhu	a5,68(s5) # fffffffffffff044 <end+0xffffffff7ffde154>
    8000439a:	37f9                	addiw	a5,a5,-2
    8000439c:	17c2                	slli	a5,a5,0x30
    8000439e:	93c1                	srli	a5,a5,0x30
    800043a0:	4705                	li	a4,1
    800043a2:	00f76d63          	bltu	a4,a5,800043bc <create+0x8c>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    800043a6:	8556                	mv	a0,s5
    800043a8:	60a6                	ld	ra,72(sp)
    800043aa:	6406                	ld	s0,64(sp)
    800043ac:	74e2                	ld	s1,56(sp)
    800043ae:	7942                	ld	s2,48(sp)
    800043b0:	79a2                	ld	s3,40(sp)
    800043b2:	7a02                	ld	s4,32(sp)
    800043b4:	6ae2                	ld	s5,24(sp)
    800043b6:	6b42                	ld	s6,16(sp)
    800043b8:	6161                	addi	sp,sp,80
    800043ba:	8082                	ret
    iunlockput(ip);
    800043bc:	8556                	mv	a0,s5
    800043be:	fffff097          	auipc	ra,0xfffff
    800043c2:	8e0080e7          	jalr	-1824(ra) # 80002c9e <iunlockput>
    return 0;
    800043c6:	4a81                	li	s5,0
    800043c8:	bff9                	j	800043a6 <create+0x76>
  if ((ip = ialloc(dp->dev, type)) == 0) {
    800043ca:	85da                	mv	a1,s6
    800043cc:	4088                	lw	a0,0(s1)
    800043ce:	ffffe097          	auipc	ra,0xffffe
    800043d2:	4d2080e7          	jalr	1234(ra) # 800028a0 <ialloc>
    800043d6:	8a2a                	mv	s4,a0
    800043d8:	c539                	beqz	a0,80004426 <create+0xf6>
  ilock(ip);
    800043da:	ffffe097          	auipc	ra,0xffffe
    800043de:	662080e7          	jalr	1634(ra) # 80002a3c <ilock>
  ip->major = major;
    800043e2:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    800043e6:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    800043ea:	4905                	li	s2,1
    800043ec:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    800043f0:	8552                	mv	a0,s4
    800043f2:	ffffe097          	auipc	ra,0xffffe
    800043f6:	580080e7          	jalr	1408(ra) # 80002972 <iupdate>
  if (type == T_DIR) {  // Create . and .. entries.
    800043fa:	000b059b          	sext.w	a1,s6
    800043fe:	03258b63          	beq	a1,s2,80004434 <create+0x104>
  if (dirlink(dp, name, ip->inum) < 0) goto fail;
    80004402:	004a2603          	lw	a2,4(s4)
    80004406:	fb040593          	addi	a1,s0,-80
    8000440a:	8526                	mv	a0,s1
    8000440c:	fffff097          	auipc	ra,0xfffff
    80004410:	d24080e7          	jalr	-732(ra) # 80003130 <dirlink>
    80004414:	06054f63          	bltz	a0,80004492 <create+0x162>
  iunlockput(dp);
    80004418:	8526                	mv	a0,s1
    8000441a:	fffff097          	auipc	ra,0xfffff
    8000441e:	884080e7          	jalr	-1916(ra) # 80002c9e <iunlockput>
  return ip;
    80004422:	8ad2                	mv	s5,s4
    80004424:	b749                	j	800043a6 <create+0x76>
    iunlockput(dp);
    80004426:	8526                	mv	a0,s1
    80004428:	fffff097          	auipc	ra,0xfffff
    8000442c:	876080e7          	jalr	-1930(ra) # 80002c9e <iunlockput>
    return 0;
    80004430:	8ad2                	mv	s5,s4
    80004432:	bf95                	j	800043a6 <create+0x76>
    if (dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004434:	004a2603          	lw	a2,4(s4)
    80004438:	00004597          	auipc	a1,0x4
    8000443c:	26058593          	addi	a1,a1,608 # 80008698 <syscalls+0x298>
    80004440:	8552                	mv	a0,s4
    80004442:	fffff097          	auipc	ra,0xfffff
    80004446:	cee080e7          	jalr	-786(ra) # 80003130 <dirlink>
    8000444a:	04054463          	bltz	a0,80004492 <create+0x162>
    8000444e:	40d0                	lw	a2,4(s1)
    80004450:	00004597          	auipc	a1,0x4
    80004454:	25058593          	addi	a1,a1,592 # 800086a0 <syscalls+0x2a0>
    80004458:	8552                	mv	a0,s4
    8000445a:	fffff097          	auipc	ra,0xfffff
    8000445e:	cd6080e7          	jalr	-810(ra) # 80003130 <dirlink>
    80004462:	02054863          	bltz	a0,80004492 <create+0x162>
  if (dirlink(dp, name, ip->inum) < 0) goto fail;
    80004466:	004a2603          	lw	a2,4(s4)
    8000446a:	fb040593          	addi	a1,s0,-80
    8000446e:	8526                	mv	a0,s1
    80004470:	fffff097          	auipc	ra,0xfffff
    80004474:	cc0080e7          	jalr	-832(ra) # 80003130 <dirlink>
    80004478:	00054d63          	bltz	a0,80004492 <create+0x162>
    dp->nlink++;  // for ".."
    8000447c:	04a4d783          	lhu	a5,74(s1)
    80004480:	2785                	addiw	a5,a5,1
    80004482:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004486:	8526                	mv	a0,s1
    80004488:	ffffe097          	auipc	ra,0xffffe
    8000448c:	4ea080e7          	jalr	1258(ra) # 80002972 <iupdate>
    80004490:	b761                	j	80004418 <create+0xe8>
  ip->nlink = 0;
    80004492:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80004496:	8552                	mv	a0,s4
    80004498:	ffffe097          	auipc	ra,0xffffe
    8000449c:	4da080e7          	jalr	1242(ra) # 80002972 <iupdate>
  iunlockput(ip);
    800044a0:	8552                	mv	a0,s4
    800044a2:	ffffe097          	auipc	ra,0xffffe
    800044a6:	7fc080e7          	jalr	2044(ra) # 80002c9e <iunlockput>
  iunlockput(dp);
    800044aa:	8526                	mv	a0,s1
    800044ac:	ffffe097          	auipc	ra,0xffffe
    800044b0:	7f2080e7          	jalr	2034(ra) # 80002c9e <iunlockput>
  return 0;
    800044b4:	bdcd                	j	800043a6 <create+0x76>
  if ((dp = nameiparent(path, name)) == 0) return 0;
    800044b6:	8aaa                	mv	s5,a0
    800044b8:	b5fd                	j	800043a6 <create+0x76>

00000000800044ba <sys_dup>:
uint64 sys_dup(void) {
    800044ba:	7179                	addi	sp,sp,-48
    800044bc:	f406                	sd	ra,40(sp)
    800044be:	f022                	sd	s0,32(sp)
    800044c0:	ec26                	sd	s1,24(sp)
    800044c2:	1800                	addi	s0,sp,48
  if (argfd(0, 0, &f) < 0) return -1;
    800044c4:	fd840613          	addi	a2,s0,-40
    800044c8:	4581                	li	a1,0
    800044ca:	4501                	li	a0,0
    800044cc:	00000097          	auipc	ra,0x0
    800044d0:	dc2080e7          	jalr	-574(ra) # 8000428e <argfd>
    800044d4:	57fd                	li	a5,-1
    800044d6:	02054363          	bltz	a0,800044fc <sys_dup+0x42>
  if ((fd = fdalloc(f)) < 0) return -1;
    800044da:	fd843503          	ld	a0,-40(s0)
    800044de:	00000097          	auipc	ra,0x0
    800044e2:	e10080e7          	jalr	-496(ra) # 800042ee <fdalloc>
    800044e6:	84aa                	mv	s1,a0
    800044e8:	57fd                	li	a5,-1
    800044ea:	00054963          	bltz	a0,800044fc <sys_dup+0x42>
  filedup(f);
    800044ee:	fd843503          	ld	a0,-40(s0)
    800044f2:	fffff097          	auipc	ra,0xfffff
    800044f6:	336080e7          	jalr	822(ra) # 80003828 <filedup>
  return fd;
    800044fa:	87a6                	mv	a5,s1
}
    800044fc:	853e                	mv	a0,a5
    800044fe:	70a2                	ld	ra,40(sp)
    80004500:	7402                	ld	s0,32(sp)
    80004502:	64e2                	ld	s1,24(sp)
    80004504:	6145                	addi	sp,sp,48
    80004506:	8082                	ret

0000000080004508 <sys_read>:
uint64 sys_read(void) {
    80004508:	7179                	addi	sp,sp,-48
    8000450a:	f406                	sd	ra,40(sp)
    8000450c:	f022                	sd	s0,32(sp)
    8000450e:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004510:	fd840593          	addi	a1,s0,-40
    80004514:	4505                	li	a0,1
    80004516:	ffffe097          	auipc	ra,0xffffe
    8000451a:	9cc080e7          	jalr	-1588(ra) # 80001ee2 <argaddr>
  argint(2, &n);
    8000451e:	fe440593          	addi	a1,s0,-28
    80004522:	4509                	li	a0,2
    80004524:	ffffe097          	auipc	ra,0xffffe
    80004528:	99e080e7          	jalr	-1634(ra) # 80001ec2 <argint>
  if (argfd(0, 0, &f) < 0) return -1;
    8000452c:	fe840613          	addi	a2,s0,-24
    80004530:	4581                	li	a1,0
    80004532:	4501                	li	a0,0
    80004534:	00000097          	auipc	ra,0x0
    80004538:	d5a080e7          	jalr	-678(ra) # 8000428e <argfd>
    8000453c:	87aa                	mv	a5,a0
    8000453e:	557d                	li	a0,-1
    80004540:	0007cc63          	bltz	a5,80004558 <sys_read+0x50>
  return fileread(f, p, n);
    80004544:	fe442603          	lw	a2,-28(s0)
    80004548:	fd843583          	ld	a1,-40(s0)
    8000454c:	fe843503          	ld	a0,-24(s0)
    80004550:	fffff097          	auipc	ra,0xfffff
    80004554:	43e080e7          	jalr	1086(ra) # 8000398e <fileread>
}
    80004558:	70a2                	ld	ra,40(sp)
    8000455a:	7402                	ld	s0,32(sp)
    8000455c:	6145                	addi	sp,sp,48
    8000455e:	8082                	ret

0000000080004560 <sys_write>:
uint64 sys_write(void) {
    80004560:	7179                	addi	sp,sp,-48
    80004562:	f406                	sd	ra,40(sp)
    80004564:	f022                	sd	s0,32(sp)
    80004566:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004568:	fd840593          	addi	a1,s0,-40
    8000456c:	4505                	li	a0,1
    8000456e:	ffffe097          	auipc	ra,0xffffe
    80004572:	974080e7          	jalr	-1676(ra) # 80001ee2 <argaddr>
  argint(2, &n);
    80004576:	fe440593          	addi	a1,s0,-28
    8000457a:	4509                	li	a0,2
    8000457c:	ffffe097          	auipc	ra,0xffffe
    80004580:	946080e7          	jalr	-1722(ra) # 80001ec2 <argint>
  if (argfd(0, 0, &f) < 0) return -1;
    80004584:	fe840613          	addi	a2,s0,-24
    80004588:	4581                	li	a1,0
    8000458a:	4501                	li	a0,0
    8000458c:	00000097          	auipc	ra,0x0
    80004590:	d02080e7          	jalr	-766(ra) # 8000428e <argfd>
    80004594:	87aa                	mv	a5,a0
    80004596:	557d                	li	a0,-1
    80004598:	0007cc63          	bltz	a5,800045b0 <sys_write+0x50>
  return filewrite(f, p, n);
    8000459c:	fe442603          	lw	a2,-28(s0)
    800045a0:	fd843583          	ld	a1,-40(s0)
    800045a4:	fe843503          	ld	a0,-24(s0)
    800045a8:	fffff097          	auipc	ra,0xfffff
    800045ac:	4a8080e7          	jalr	1192(ra) # 80003a50 <filewrite>
}
    800045b0:	70a2                	ld	ra,40(sp)
    800045b2:	7402                	ld	s0,32(sp)
    800045b4:	6145                	addi	sp,sp,48
    800045b6:	8082                	ret

00000000800045b8 <sys_close>:
uint64 sys_close(void) {
    800045b8:	1101                	addi	sp,sp,-32
    800045ba:	ec06                	sd	ra,24(sp)
    800045bc:	e822                	sd	s0,16(sp)
    800045be:	1000                	addi	s0,sp,32
  if (argfd(0, &fd, &f) < 0) return -1;
    800045c0:	fe040613          	addi	a2,s0,-32
    800045c4:	fec40593          	addi	a1,s0,-20
    800045c8:	4501                	li	a0,0
    800045ca:	00000097          	auipc	ra,0x0
    800045ce:	cc4080e7          	jalr	-828(ra) # 8000428e <argfd>
    800045d2:	57fd                	li	a5,-1
    800045d4:	02054463          	bltz	a0,800045fc <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800045d8:	ffffc097          	auipc	ra,0xffffc
    800045dc:	7d0080e7          	jalr	2000(ra) # 80000da8 <myproc>
    800045e0:	fec42783          	lw	a5,-20(s0)
    800045e4:	07e9                	addi	a5,a5,26
    800045e6:	078e                	slli	a5,a5,0x3
    800045e8:	97aa                	add	a5,a5,a0
    800045ea:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    800045ee:	fe043503          	ld	a0,-32(s0)
    800045f2:	fffff097          	auipc	ra,0xfffff
    800045f6:	284080e7          	jalr	644(ra) # 80003876 <fileclose>
  return 0;
    800045fa:	4781                	li	a5,0
}
    800045fc:	853e                	mv	a0,a5
    800045fe:	60e2                	ld	ra,24(sp)
    80004600:	6442                	ld	s0,16(sp)
    80004602:	6105                	addi	sp,sp,32
    80004604:	8082                	ret

0000000080004606 <sys_fstat>:
uint64 sys_fstat(void) {
    80004606:	1101                	addi	sp,sp,-32
    80004608:	ec06                	sd	ra,24(sp)
    8000460a:	e822                	sd	s0,16(sp)
    8000460c:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    8000460e:	fe040593          	addi	a1,s0,-32
    80004612:	4505                	li	a0,1
    80004614:	ffffe097          	auipc	ra,0xffffe
    80004618:	8ce080e7          	jalr	-1842(ra) # 80001ee2 <argaddr>
  if (argfd(0, 0, &f) < 0) return -1;
    8000461c:	fe840613          	addi	a2,s0,-24
    80004620:	4581                	li	a1,0
    80004622:	4501                	li	a0,0
    80004624:	00000097          	auipc	ra,0x0
    80004628:	c6a080e7          	jalr	-918(ra) # 8000428e <argfd>
    8000462c:	87aa                	mv	a5,a0
    8000462e:	557d                	li	a0,-1
    80004630:	0007ca63          	bltz	a5,80004644 <sys_fstat+0x3e>
  return filestat(f, st);
    80004634:	fe043583          	ld	a1,-32(s0)
    80004638:	fe843503          	ld	a0,-24(s0)
    8000463c:	fffff097          	auipc	ra,0xfffff
    80004640:	2e0080e7          	jalr	736(ra) # 8000391c <filestat>
}
    80004644:	60e2                	ld	ra,24(sp)
    80004646:	6442                	ld	s0,16(sp)
    80004648:	6105                	addi	sp,sp,32
    8000464a:	8082                	ret

000000008000464c <sys_link>:
uint64 sys_link(void) {
    8000464c:	7169                	addi	sp,sp,-304
    8000464e:	f606                	sd	ra,296(sp)
    80004650:	f222                	sd	s0,288(sp)
    80004652:	ee26                	sd	s1,280(sp)
    80004654:	ea4a                	sd	s2,272(sp)
    80004656:	1a00                	addi	s0,sp,304
  if (argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0) return -1;
    80004658:	08000613          	li	a2,128
    8000465c:	ed040593          	addi	a1,s0,-304
    80004660:	4501                	li	a0,0
    80004662:	ffffe097          	auipc	ra,0xffffe
    80004666:	8a0080e7          	jalr	-1888(ra) # 80001f02 <argstr>
    8000466a:	57fd                	li	a5,-1
    8000466c:	10054e63          	bltz	a0,80004788 <sys_link+0x13c>
    80004670:	08000613          	li	a2,128
    80004674:	f5040593          	addi	a1,s0,-176
    80004678:	4505                	li	a0,1
    8000467a:	ffffe097          	auipc	ra,0xffffe
    8000467e:	888080e7          	jalr	-1912(ra) # 80001f02 <argstr>
    80004682:	57fd                	li	a5,-1
    80004684:	10054263          	bltz	a0,80004788 <sys_link+0x13c>
  begin_op();
    80004688:	fffff097          	auipc	ra,0xfffff
    8000468c:	d76080e7          	jalr	-650(ra) # 800033fe <begin_op>
  if ((ip = namei(old)) == 0) {
    80004690:	ed040513          	addi	a0,s0,-304
    80004694:	fffff097          	auipc	ra,0xfffff
    80004698:	b4e080e7          	jalr	-1202(ra) # 800031e2 <namei>
    8000469c:	84aa                	mv	s1,a0
    8000469e:	c551                	beqz	a0,8000472a <sys_link+0xde>
  ilock(ip);
    800046a0:	ffffe097          	auipc	ra,0xffffe
    800046a4:	39c080e7          	jalr	924(ra) # 80002a3c <ilock>
  if (ip->type == T_DIR) {
    800046a8:	04449703          	lh	a4,68(s1)
    800046ac:	4785                	li	a5,1
    800046ae:	08f70463          	beq	a4,a5,80004736 <sys_link+0xea>
  ip->nlink++;
    800046b2:	04a4d783          	lhu	a5,74(s1)
    800046b6:	2785                	addiw	a5,a5,1
    800046b8:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800046bc:	8526                	mv	a0,s1
    800046be:	ffffe097          	auipc	ra,0xffffe
    800046c2:	2b4080e7          	jalr	692(ra) # 80002972 <iupdate>
  iunlock(ip);
    800046c6:	8526                	mv	a0,s1
    800046c8:	ffffe097          	auipc	ra,0xffffe
    800046cc:	436080e7          	jalr	1078(ra) # 80002afe <iunlock>
  if ((dp = nameiparent(new, name)) == 0) goto bad;
    800046d0:	fd040593          	addi	a1,s0,-48
    800046d4:	f5040513          	addi	a0,s0,-176
    800046d8:	fffff097          	auipc	ra,0xfffff
    800046dc:	b28080e7          	jalr	-1240(ra) # 80003200 <nameiparent>
    800046e0:	892a                	mv	s2,a0
    800046e2:	c935                	beqz	a0,80004756 <sys_link+0x10a>
  ilock(dp);
    800046e4:	ffffe097          	auipc	ra,0xffffe
    800046e8:	358080e7          	jalr	856(ra) # 80002a3c <ilock>
  if (dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0) {
    800046ec:	00092703          	lw	a4,0(s2)
    800046f0:	409c                	lw	a5,0(s1)
    800046f2:	04f71d63          	bne	a4,a5,8000474c <sys_link+0x100>
    800046f6:	40d0                	lw	a2,4(s1)
    800046f8:	fd040593          	addi	a1,s0,-48
    800046fc:	854a                	mv	a0,s2
    800046fe:	fffff097          	auipc	ra,0xfffff
    80004702:	a32080e7          	jalr	-1486(ra) # 80003130 <dirlink>
    80004706:	04054363          	bltz	a0,8000474c <sys_link+0x100>
  iunlockput(dp);
    8000470a:	854a                	mv	a0,s2
    8000470c:	ffffe097          	auipc	ra,0xffffe
    80004710:	592080e7          	jalr	1426(ra) # 80002c9e <iunlockput>
  iput(ip);
    80004714:	8526                	mv	a0,s1
    80004716:	ffffe097          	auipc	ra,0xffffe
    8000471a:	4e0080e7          	jalr	1248(ra) # 80002bf6 <iput>
  end_op();
    8000471e:	fffff097          	auipc	ra,0xfffff
    80004722:	d60080e7          	jalr	-672(ra) # 8000347e <end_op>
  return 0;
    80004726:	4781                	li	a5,0
    80004728:	a085                	j	80004788 <sys_link+0x13c>
    end_op();
    8000472a:	fffff097          	auipc	ra,0xfffff
    8000472e:	d54080e7          	jalr	-684(ra) # 8000347e <end_op>
    return -1;
    80004732:	57fd                	li	a5,-1
    80004734:	a891                	j	80004788 <sys_link+0x13c>
    iunlockput(ip);
    80004736:	8526                	mv	a0,s1
    80004738:	ffffe097          	auipc	ra,0xffffe
    8000473c:	566080e7          	jalr	1382(ra) # 80002c9e <iunlockput>
    end_op();
    80004740:	fffff097          	auipc	ra,0xfffff
    80004744:	d3e080e7          	jalr	-706(ra) # 8000347e <end_op>
    return -1;
    80004748:	57fd                	li	a5,-1
    8000474a:	a83d                	j	80004788 <sys_link+0x13c>
    iunlockput(dp);
    8000474c:	854a                	mv	a0,s2
    8000474e:	ffffe097          	auipc	ra,0xffffe
    80004752:	550080e7          	jalr	1360(ra) # 80002c9e <iunlockput>
  ilock(ip);
    80004756:	8526                	mv	a0,s1
    80004758:	ffffe097          	auipc	ra,0xffffe
    8000475c:	2e4080e7          	jalr	740(ra) # 80002a3c <ilock>
  ip->nlink--;
    80004760:	04a4d783          	lhu	a5,74(s1)
    80004764:	37fd                	addiw	a5,a5,-1
    80004766:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000476a:	8526                	mv	a0,s1
    8000476c:	ffffe097          	auipc	ra,0xffffe
    80004770:	206080e7          	jalr	518(ra) # 80002972 <iupdate>
  iunlockput(ip);
    80004774:	8526                	mv	a0,s1
    80004776:	ffffe097          	auipc	ra,0xffffe
    8000477a:	528080e7          	jalr	1320(ra) # 80002c9e <iunlockput>
  end_op();
    8000477e:	fffff097          	auipc	ra,0xfffff
    80004782:	d00080e7          	jalr	-768(ra) # 8000347e <end_op>
  return -1;
    80004786:	57fd                	li	a5,-1
}
    80004788:	853e                	mv	a0,a5
    8000478a:	70b2                	ld	ra,296(sp)
    8000478c:	7412                	ld	s0,288(sp)
    8000478e:	64f2                	ld	s1,280(sp)
    80004790:	6952                	ld	s2,272(sp)
    80004792:	6155                	addi	sp,sp,304
    80004794:	8082                	ret

0000000080004796 <sys_unlink>:
uint64 sys_unlink(void) {
    80004796:	7151                	addi	sp,sp,-240
    80004798:	f586                	sd	ra,232(sp)
    8000479a:	f1a2                	sd	s0,224(sp)
    8000479c:	eda6                	sd	s1,216(sp)
    8000479e:	e9ca                	sd	s2,208(sp)
    800047a0:	e5ce                	sd	s3,200(sp)
    800047a2:	1980                	addi	s0,sp,240
  if (argstr(0, path, MAXPATH) < 0) return -1;
    800047a4:	08000613          	li	a2,128
    800047a8:	f3040593          	addi	a1,s0,-208
    800047ac:	4501                	li	a0,0
    800047ae:	ffffd097          	auipc	ra,0xffffd
    800047b2:	754080e7          	jalr	1876(ra) # 80001f02 <argstr>
    800047b6:	18054163          	bltz	a0,80004938 <sys_unlink+0x1a2>
  begin_op();
    800047ba:	fffff097          	auipc	ra,0xfffff
    800047be:	c44080e7          	jalr	-956(ra) # 800033fe <begin_op>
  if ((dp = nameiparent(path, name)) == 0) {
    800047c2:	fb040593          	addi	a1,s0,-80
    800047c6:	f3040513          	addi	a0,s0,-208
    800047ca:	fffff097          	auipc	ra,0xfffff
    800047ce:	a36080e7          	jalr	-1482(ra) # 80003200 <nameiparent>
    800047d2:	84aa                	mv	s1,a0
    800047d4:	c979                	beqz	a0,800048aa <sys_unlink+0x114>
  ilock(dp);
    800047d6:	ffffe097          	auipc	ra,0xffffe
    800047da:	266080e7          	jalr	614(ra) # 80002a3c <ilock>
  if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0) goto bad;
    800047de:	00004597          	auipc	a1,0x4
    800047e2:	eba58593          	addi	a1,a1,-326 # 80008698 <syscalls+0x298>
    800047e6:	fb040513          	addi	a0,s0,-80
    800047ea:	ffffe097          	auipc	ra,0xffffe
    800047ee:	71c080e7          	jalr	1820(ra) # 80002f06 <namecmp>
    800047f2:	14050a63          	beqz	a0,80004946 <sys_unlink+0x1b0>
    800047f6:	00004597          	auipc	a1,0x4
    800047fa:	eaa58593          	addi	a1,a1,-342 # 800086a0 <syscalls+0x2a0>
    800047fe:	fb040513          	addi	a0,s0,-80
    80004802:	ffffe097          	auipc	ra,0xffffe
    80004806:	704080e7          	jalr	1796(ra) # 80002f06 <namecmp>
    8000480a:	12050e63          	beqz	a0,80004946 <sys_unlink+0x1b0>
  if ((ip = dirlookup(dp, name, &off)) == 0) goto bad;
    8000480e:	f2c40613          	addi	a2,s0,-212
    80004812:	fb040593          	addi	a1,s0,-80
    80004816:	8526                	mv	a0,s1
    80004818:	ffffe097          	auipc	ra,0xffffe
    8000481c:	708080e7          	jalr	1800(ra) # 80002f20 <dirlookup>
    80004820:	892a                	mv	s2,a0
    80004822:	12050263          	beqz	a0,80004946 <sys_unlink+0x1b0>
  ilock(ip);
    80004826:	ffffe097          	auipc	ra,0xffffe
    8000482a:	216080e7          	jalr	534(ra) # 80002a3c <ilock>
  if (ip->nlink < 1) panic("unlink: nlink < 1");
    8000482e:	04a91783          	lh	a5,74(s2)
    80004832:	08f05263          	blez	a5,800048b6 <sys_unlink+0x120>
  if (ip->type == T_DIR && !isdirempty(ip)) {
    80004836:	04491703          	lh	a4,68(s2)
    8000483a:	4785                	li	a5,1
    8000483c:	08f70563          	beq	a4,a5,800048c6 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004840:	4641                	li	a2,16
    80004842:	4581                	li	a1,0
    80004844:	fc040513          	addi	a0,s0,-64
    80004848:	ffffc097          	auipc	ra,0xffffc
    8000484c:	82e080e7          	jalr	-2002(ra) # 80000076 <memset>
  if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004850:	4741                	li	a4,16
    80004852:	f2c42683          	lw	a3,-212(s0)
    80004856:	fc040613          	addi	a2,s0,-64
    8000485a:	4581                	li	a1,0
    8000485c:	8526                	mv	a0,s1
    8000485e:	ffffe097          	auipc	ra,0xffffe
    80004862:	58a080e7          	jalr	1418(ra) # 80002de8 <writei>
    80004866:	47c1                	li	a5,16
    80004868:	0af51563          	bne	a0,a5,80004912 <sys_unlink+0x17c>
  if (ip->type == T_DIR) {
    8000486c:	04491703          	lh	a4,68(s2)
    80004870:	4785                	li	a5,1
    80004872:	0af70863          	beq	a4,a5,80004922 <sys_unlink+0x18c>
  iunlockput(dp);
    80004876:	8526                	mv	a0,s1
    80004878:	ffffe097          	auipc	ra,0xffffe
    8000487c:	426080e7          	jalr	1062(ra) # 80002c9e <iunlockput>
  ip->nlink--;
    80004880:	04a95783          	lhu	a5,74(s2)
    80004884:	37fd                	addiw	a5,a5,-1
    80004886:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    8000488a:	854a                	mv	a0,s2
    8000488c:	ffffe097          	auipc	ra,0xffffe
    80004890:	0e6080e7          	jalr	230(ra) # 80002972 <iupdate>
  iunlockput(ip);
    80004894:	854a                	mv	a0,s2
    80004896:	ffffe097          	auipc	ra,0xffffe
    8000489a:	408080e7          	jalr	1032(ra) # 80002c9e <iunlockput>
  end_op();
    8000489e:	fffff097          	auipc	ra,0xfffff
    800048a2:	be0080e7          	jalr	-1056(ra) # 8000347e <end_op>
  return 0;
    800048a6:	4501                	li	a0,0
    800048a8:	a84d                	j	8000495a <sys_unlink+0x1c4>
    end_op();
    800048aa:	fffff097          	auipc	ra,0xfffff
    800048ae:	bd4080e7          	jalr	-1068(ra) # 8000347e <end_op>
    return -1;
    800048b2:	557d                	li	a0,-1
    800048b4:	a05d                	j	8000495a <sys_unlink+0x1c4>
  if (ip->nlink < 1) panic("unlink: nlink < 1");
    800048b6:	00004517          	auipc	a0,0x4
    800048ba:	df250513          	addi	a0,a0,-526 # 800086a8 <syscalls+0x2a8>
    800048be:	00002097          	auipc	ra,0x2
    800048c2:	e7a080e7          	jalr	-390(ra) # 80006738 <panic>
  for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
    800048c6:	04c92703          	lw	a4,76(s2)
    800048ca:	02000793          	li	a5,32
    800048ce:	f6e7f9e3          	bgeu	a5,a4,80004840 <sys_unlink+0xaa>
    800048d2:	02000993          	li	s3,32
    if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800048d6:	4741                	li	a4,16
    800048d8:	86ce                	mv	a3,s3
    800048da:	f1840613          	addi	a2,s0,-232
    800048de:	4581                	li	a1,0
    800048e0:	854a                	mv	a0,s2
    800048e2:	ffffe097          	auipc	ra,0xffffe
    800048e6:	40e080e7          	jalr	1038(ra) # 80002cf0 <readi>
    800048ea:	47c1                	li	a5,16
    800048ec:	00f51b63          	bne	a0,a5,80004902 <sys_unlink+0x16c>
    if (de.inum != 0) return 0;
    800048f0:	f1845783          	lhu	a5,-232(s0)
    800048f4:	e7a1                	bnez	a5,8000493c <sys_unlink+0x1a6>
  for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
    800048f6:	29c1                	addiw	s3,s3,16
    800048f8:	04c92783          	lw	a5,76(s2)
    800048fc:	fcf9ede3          	bltu	s3,a5,800048d6 <sys_unlink+0x140>
    80004900:	b781                	j	80004840 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004902:	00004517          	auipc	a0,0x4
    80004906:	dbe50513          	addi	a0,a0,-578 # 800086c0 <syscalls+0x2c0>
    8000490a:	00002097          	auipc	ra,0x2
    8000490e:	e2e080e7          	jalr	-466(ra) # 80006738 <panic>
    panic("unlink: writei");
    80004912:	00004517          	auipc	a0,0x4
    80004916:	dc650513          	addi	a0,a0,-570 # 800086d8 <syscalls+0x2d8>
    8000491a:	00002097          	auipc	ra,0x2
    8000491e:	e1e080e7          	jalr	-482(ra) # 80006738 <panic>
    dp->nlink--;
    80004922:	04a4d783          	lhu	a5,74(s1)
    80004926:	37fd                	addiw	a5,a5,-1
    80004928:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    8000492c:	8526                	mv	a0,s1
    8000492e:	ffffe097          	auipc	ra,0xffffe
    80004932:	044080e7          	jalr	68(ra) # 80002972 <iupdate>
    80004936:	b781                	j	80004876 <sys_unlink+0xe0>
  if (argstr(0, path, MAXPATH) < 0) return -1;
    80004938:	557d                	li	a0,-1
    8000493a:	a005                	j	8000495a <sys_unlink+0x1c4>
    iunlockput(ip);
    8000493c:	854a                	mv	a0,s2
    8000493e:	ffffe097          	auipc	ra,0xffffe
    80004942:	360080e7          	jalr	864(ra) # 80002c9e <iunlockput>
  iunlockput(dp);
    80004946:	8526                	mv	a0,s1
    80004948:	ffffe097          	auipc	ra,0xffffe
    8000494c:	356080e7          	jalr	854(ra) # 80002c9e <iunlockput>
  end_op();
    80004950:	fffff097          	auipc	ra,0xfffff
    80004954:	b2e080e7          	jalr	-1234(ra) # 8000347e <end_op>
  return -1;
    80004958:	557d                	li	a0,-1
}
    8000495a:	70ae                	ld	ra,232(sp)
    8000495c:	740e                	ld	s0,224(sp)
    8000495e:	64ee                	ld	s1,216(sp)
    80004960:	694e                	ld	s2,208(sp)
    80004962:	69ae                	ld	s3,200(sp)
    80004964:	616d                	addi	sp,sp,240
    80004966:	8082                	ret

0000000080004968 <sys_open>:

uint64 sys_open(void) {
    80004968:	7131                	addi	sp,sp,-192
    8000496a:	fd06                	sd	ra,184(sp)
    8000496c:	f922                	sd	s0,176(sp)
    8000496e:	f526                	sd	s1,168(sp)
    80004970:	f14a                	sd	s2,160(sp)
    80004972:	ed4e                	sd	s3,152(sp)
    80004974:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004976:	f4c40593          	addi	a1,s0,-180
    8000497a:	4505                	li	a0,1
    8000497c:	ffffd097          	auipc	ra,0xffffd
    80004980:	546080e7          	jalr	1350(ra) # 80001ec2 <argint>
  if ((n = argstr(0, path, MAXPATH)) < 0) return -1;
    80004984:	08000613          	li	a2,128
    80004988:	f5040593          	addi	a1,s0,-176
    8000498c:	4501                	li	a0,0
    8000498e:	ffffd097          	auipc	ra,0xffffd
    80004992:	574080e7          	jalr	1396(ra) # 80001f02 <argstr>
    80004996:	87aa                	mv	a5,a0
    80004998:	557d                	li	a0,-1
    8000499a:	0a07c963          	bltz	a5,80004a4c <sys_open+0xe4>

  begin_op();
    8000499e:	fffff097          	auipc	ra,0xfffff
    800049a2:	a60080e7          	jalr	-1440(ra) # 800033fe <begin_op>

  if (omode & O_CREATE) {
    800049a6:	f4c42783          	lw	a5,-180(s0)
    800049aa:	2007f793          	andi	a5,a5,512
    800049ae:	cfc5                	beqz	a5,80004a66 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    800049b0:	4681                	li	a3,0
    800049b2:	4601                	li	a2,0
    800049b4:	4589                	li	a1,2
    800049b6:	f5040513          	addi	a0,s0,-176
    800049ba:	00000097          	auipc	ra,0x0
    800049be:	976080e7          	jalr	-1674(ra) # 80004330 <create>
    800049c2:	84aa                	mv	s1,a0
    if (ip == 0) {
    800049c4:	c959                	beqz	a0,80004a5a <sys_open+0xf2>
      end_op();
      return -1;
    }
  }

  if (ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)) {
    800049c6:	04449703          	lh	a4,68(s1)
    800049ca:	478d                	li	a5,3
    800049cc:	00f71763          	bne	a4,a5,800049da <sys_open+0x72>
    800049d0:	0464d703          	lhu	a4,70(s1)
    800049d4:	47a5                	li	a5,9
    800049d6:	0ce7ed63          	bltu	a5,a4,80004ab0 <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if ((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0) {
    800049da:	fffff097          	auipc	ra,0xfffff
    800049de:	e18080e7          	jalr	-488(ra) # 800037f2 <filealloc>
    800049e2:	89aa                	mv	s3,a0
    800049e4:	10050363          	beqz	a0,80004aea <sys_open+0x182>
    800049e8:	00000097          	auipc	ra,0x0
    800049ec:	906080e7          	jalr	-1786(ra) # 800042ee <fdalloc>
    800049f0:	892a                	mv	s2,a0
    800049f2:	0e054763          	bltz	a0,80004ae0 <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if (ip->type == T_DEVICE) {
    800049f6:	04449703          	lh	a4,68(s1)
    800049fa:	478d                	li	a5,3
    800049fc:	0cf70563          	beq	a4,a5,80004ac6 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004a00:	4789                	li	a5,2
    80004a02:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004a06:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004a0a:	0099bc23          	sd	s1,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004a0e:	f4c42783          	lw	a5,-180(s0)
    80004a12:	0017c713          	xori	a4,a5,1
    80004a16:	8b05                	andi	a4,a4,1
    80004a18:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004a1c:	0037f713          	andi	a4,a5,3
    80004a20:	00e03733          	snez	a4,a4
    80004a24:	00e984a3          	sb	a4,9(s3)

  if ((omode & O_TRUNC) && ip->type == T_FILE) {
    80004a28:	4007f793          	andi	a5,a5,1024
    80004a2c:	c791                	beqz	a5,80004a38 <sys_open+0xd0>
    80004a2e:	04449703          	lh	a4,68(s1)
    80004a32:	4789                	li	a5,2
    80004a34:	0af70063          	beq	a4,a5,80004ad4 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80004a38:	8526                	mv	a0,s1
    80004a3a:	ffffe097          	auipc	ra,0xffffe
    80004a3e:	0c4080e7          	jalr	196(ra) # 80002afe <iunlock>
  end_op();
    80004a42:	fffff097          	auipc	ra,0xfffff
    80004a46:	a3c080e7          	jalr	-1476(ra) # 8000347e <end_op>

  return fd;
    80004a4a:	854a                	mv	a0,s2
}
    80004a4c:	70ea                	ld	ra,184(sp)
    80004a4e:	744a                	ld	s0,176(sp)
    80004a50:	74aa                	ld	s1,168(sp)
    80004a52:	790a                	ld	s2,160(sp)
    80004a54:	69ea                	ld	s3,152(sp)
    80004a56:	6129                	addi	sp,sp,192
    80004a58:	8082                	ret
      end_op();
    80004a5a:	fffff097          	auipc	ra,0xfffff
    80004a5e:	a24080e7          	jalr	-1500(ra) # 8000347e <end_op>
      return -1;
    80004a62:	557d                	li	a0,-1
    80004a64:	b7e5                	j	80004a4c <sys_open+0xe4>
    if ((ip = namei(path)) == 0) {
    80004a66:	f5040513          	addi	a0,s0,-176
    80004a6a:	ffffe097          	auipc	ra,0xffffe
    80004a6e:	778080e7          	jalr	1912(ra) # 800031e2 <namei>
    80004a72:	84aa                	mv	s1,a0
    80004a74:	c905                	beqz	a0,80004aa4 <sys_open+0x13c>
    ilock(ip);
    80004a76:	ffffe097          	auipc	ra,0xffffe
    80004a7a:	fc6080e7          	jalr	-58(ra) # 80002a3c <ilock>
    if (ip->type == T_DIR && omode != O_RDONLY) {
    80004a7e:	04449703          	lh	a4,68(s1)
    80004a82:	4785                	li	a5,1
    80004a84:	f4f711e3          	bne	a4,a5,800049c6 <sys_open+0x5e>
    80004a88:	f4c42783          	lw	a5,-180(s0)
    80004a8c:	d7b9                	beqz	a5,800049da <sys_open+0x72>
      iunlockput(ip);
    80004a8e:	8526                	mv	a0,s1
    80004a90:	ffffe097          	auipc	ra,0xffffe
    80004a94:	20e080e7          	jalr	526(ra) # 80002c9e <iunlockput>
      end_op();
    80004a98:	fffff097          	auipc	ra,0xfffff
    80004a9c:	9e6080e7          	jalr	-1562(ra) # 8000347e <end_op>
      return -1;
    80004aa0:	557d                	li	a0,-1
    80004aa2:	b76d                	j	80004a4c <sys_open+0xe4>
      end_op();
    80004aa4:	fffff097          	auipc	ra,0xfffff
    80004aa8:	9da080e7          	jalr	-1574(ra) # 8000347e <end_op>
      return -1;
    80004aac:	557d                	li	a0,-1
    80004aae:	bf79                	j	80004a4c <sys_open+0xe4>
    iunlockput(ip);
    80004ab0:	8526                	mv	a0,s1
    80004ab2:	ffffe097          	auipc	ra,0xffffe
    80004ab6:	1ec080e7          	jalr	492(ra) # 80002c9e <iunlockput>
    end_op();
    80004aba:	fffff097          	auipc	ra,0xfffff
    80004abe:	9c4080e7          	jalr	-1596(ra) # 8000347e <end_op>
    return -1;
    80004ac2:	557d                	li	a0,-1
    80004ac4:	b761                	j	80004a4c <sys_open+0xe4>
    f->type = FD_DEVICE;
    80004ac6:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004aca:	04649783          	lh	a5,70(s1)
    80004ace:	02f99223          	sh	a5,36(s3)
    80004ad2:	bf25                	j	80004a0a <sys_open+0xa2>
    itrunc(ip);
    80004ad4:	8526                	mv	a0,s1
    80004ad6:	ffffe097          	auipc	ra,0xffffe
    80004ada:	074080e7          	jalr	116(ra) # 80002b4a <itrunc>
    80004ade:	bfa9                	j	80004a38 <sys_open+0xd0>
    if (f) fileclose(f);
    80004ae0:	854e                	mv	a0,s3
    80004ae2:	fffff097          	auipc	ra,0xfffff
    80004ae6:	d94080e7          	jalr	-620(ra) # 80003876 <fileclose>
    iunlockput(ip);
    80004aea:	8526                	mv	a0,s1
    80004aec:	ffffe097          	auipc	ra,0xffffe
    80004af0:	1b2080e7          	jalr	434(ra) # 80002c9e <iunlockput>
    end_op();
    80004af4:	fffff097          	auipc	ra,0xfffff
    80004af8:	98a080e7          	jalr	-1654(ra) # 8000347e <end_op>
    return -1;
    80004afc:	557d                	li	a0,-1
    80004afe:	b7b9                	j	80004a4c <sys_open+0xe4>

0000000080004b00 <sys_mkdir>:

uint64 sys_mkdir(void) {
    80004b00:	7175                	addi	sp,sp,-144
    80004b02:	e506                	sd	ra,136(sp)
    80004b04:	e122                	sd	s0,128(sp)
    80004b06:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004b08:	fffff097          	auipc	ra,0xfffff
    80004b0c:	8f6080e7          	jalr	-1802(ra) # 800033fe <begin_op>
  if (argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0) {
    80004b10:	08000613          	li	a2,128
    80004b14:	f7040593          	addi	a1,s0,-144
    80004b18:	4501                	li	a0,0
    80004b1a:	ffffd097          	auipc	ra,0xffffd
    80004b1e:	3e8080e7          	jalr	1000(ra) # 80001f02 <argstr>
    80004b22:	02054963          	bltz	a0,80004b54 <sys_mkdir+0x54>
    80004b26:	4681                	li	a3,0
    80004b28:	4601                	li	a2,0
    80004b2a:	4585                	li	a1,1
    80004b2c:	f7040513          	addi	a0,s0,-144
    80004b30:	00000097          	auipc	ra,0x0
    80004b34:	800080e7          	jalr	-2048(ra) # 80004330 <create>
    80004b38:	cd11                	beqz	a0,80004b54 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004b3a:	ffffe097          	auipc	ra,0xffffe
    80004b3e:	164080e7          	jalr	356(ra) # 80002c9e <iunlockput>
  end_op();
    80004b42:	fffff097          	auipc	ra,0xfffff
    80004b46:	93c080e7          	jalr	-1732(ra) # 8000347e <end_op>
  return 0;
    80004b4a:	4501                	li	a0,0
}
    80004b4c:	60aa                	ld	ra,136(sp)
    80004b4e:	640a                	ld	s0,128(sp)
    80004b50:	6149                	addi	sp,sp,144
    80004b52:	8082                	ret
    end_op();
    80004b54:	fffff097          	auipc	ra,0xfffff
    80004b58:	92a080e7          	jalr	-1750(ra) # 8000347e <end_op>
    return -1;
    80004b5c:	557d                	li	a0,-1
    80004b5e:	b7fd                	j	80004b4c <sys_mkdir+0x4c>

0000000080004b60 <sys_mknod>:

uint64 sys_mknod(void) {
    80004b60:	7135                	addi	sp,sp,-160
    80004b62:	ed06                	sd	ra,152(sp)
    80004b64:	e922                	sd	s0,144(sp)
    80004b66:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004b68:	fffff097          	auipc	ra,0xfffff
    80004b6c:	896080e7          	jalr	-1898(ra) # 800033fe <begin_op>
  argint(1, &major);
    80004b70:	f6c40593          	addi	a1,s0,-148
    80004b74:	4505                	li	a0,1
    80004b76:	ffffd097          	auipc	ra,0xffffd
    80004b7a:	34c080e7          	jalr	844(ra) # 80001ec2 <argint>
  argint(2, &minor);
    80004b7e:	f6840593          	addi	a1,s0,-152
    80004b82:	4509                	li	a0,2
    80004b84:	ffffd097          	auipc	ra,0xffffd
    80004b88:	33e080e7          	jalr	830(ra) # 80001ec2 <argint>
  if ((argstr(0, path, MAXPATH)) < 0 ||
    80004b8c:	08000613          	li	a2,128
    80004b90:	f7040593          	addi	a1,s0,-144
    80004b94:	4501                	li	a0,0
    80004b96:	ffffd097          	auipc	ra,0xffffd
    80004b9a:	36c080e7          	jalr	876(ra) # 80001f02 <argstr>
    80004b9e:	02054b63          	bltz	a0,80004bd4 <sys_mknod+0x74>
      (ip = create(path, T_DEVICE, major, minor)) == 0) {
    80004ba2:	f6841683          	lh	a3,-152(s0)
    80004ba6:	f6c41603          	lh	a2,-148(s0)
    80004baa:	458d                	li	a1,3
    80004bac:	f7040513          	addi	a0,s0,-144
    80004bb0:	fffff097          	auipc	ra,0xfffff
    80004bb4:	780080e7          	jalr	1920(ra) # 80004330 <create>
  if ((argstr(0, path, MAXPATH)) < 0 ||
    80004bb8:	cd11                	beqz	a0,80004bd4 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004bba:	ffffe097          	auipc	ra,0xffffe
    80004bbe:	0e4080e7          	jalr	228(ra) # 80002c9e <iunlockput>
  end_op();
    80004bc2:	fffff097          	auipc	ra,0xfffff
    80004bc6:	8bc080e7          	jalr	-1860(ra) # 8000347e <end_op>
  return 0;
    80004bca:	4501                	li	a0,0
}
    80004bcc:	60ea                	ld	ra,152(sp)
    80004bce:	644a                	ld	s0,144(sp)
    80004bd0:	610d                	addi	sp,sp,160
    80004bd2:	8082                	ret
    end_op();
    80004bd4:	fffff097          	auipc	ra,0xfffff
    80004bd8:	8aa080e7          	jalr	-1878(ra) # 8000347e <end_op>
    return -1;
    80004bdc:	557d                	li	a0,-1
    80004bde:	b7fd                	j	80004bcc <sys_mknod+0x6c>

0000000080004be0 <sys_chdir>:

uint64 sys_chdir(void) {
    80004be0:	7135                	addi	sp,sp,-160
    80004be2:	ed06                	sd	ra,152(sp)
    80004be4:	e922                	sd	s0,144(sp)
    80004be6:	e526                	sd	s1,136(sp)
    80004be8:	e14a                	sd	s2,128(sp)
    80004bea:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004bec:	ffffc097          	auipc	ra,0xffffc
    80004bf0:	1bc080e7          	jalr	444(ra) # 80000da8 <myproc>
    80004bf4:	892a                	mv	s2,a0

  begin_op();
    80004bf6:	fffff097          	auipc	ra,0xfffff
    80004bfa:	808080e7          	jalr	-2040(ra) # 800033fe <begin_op>
  if (argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0) {
    80004bfe:	08000613          	li	a2,128
    80004c02:	f6040593          	addi	a1,s0,-160
    80004c06:	4501                	li	a0,0
    80004c08:	ffffd097          	auipc	ra,0xffffd
    80004c0c:	2fa080e7          	jalr	762(ra) # 80001f02 <argstr>
    80004c10:	04054b63          	bltz	a0,80004c66 <sys_chdir+0x86>
    80004c14:	f6040513          	addi	a0,s0,-160
    80004c18:	ffffe097          	auipc	ra,0xffffe
    80004c1c:	5ca080e7          	jalr	1482(ra) # 800031e2 <namei>
    80004c20:	84aa                	mv	s1,a0
    80004c22:	c131                	beqz	a0,80004c66 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004c24:	ffffe097          	auipc	ra,0xffffe
    80004c28:	e18080e7          	jalr	-488(ra) # 80002a3c <ilock>
  if (ip->type != T_DIR) {
    80004c2c:	04449703          	lh	a4,68(s1)
    80004c30:	4785                	li	a5,1
    80004c32:	04f71063          	bne	a4,a5,80004c72 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004c36:	8526                	mv	a0,s1
    80004c38:	ffffe097          	auipc	ra,0xffffe
    80004c3c:	ec6080e7          	jalr	-314(ra) # 80002afe <iunlock>
  iput(p->cwd);
    80004c40:	15093503          	ld	a0,336(s2)
    80004c44:	ffffe097          	auipc	ra,0xffffe
    80004c48:	fb2080e7          	jalr	-78(ra) # 80002bf6 <iput>
  end_op();
    80004c4c:	fffff097          	auipc	ra,0xfffff
    80004c50:	832080e7          	jalr	-1998(ra) # 8000347e <end_op>
  p->cwd = ip;
    80004c54:	14993823          	sd	s1,336(s2)
  return 0;
    80004c58:	4501                	li	a0,0
}
    80004c5a:	60ea                	ld	ra,152(sp)
    80004c5c:	644a                	ld	s0,144(sp)
    80004c5e:	64aa                	ld	s1,136(sp)
    80004c60:	690a                	ld	s2,128(sp)
    80004c62:	610d                	addi	sp,sp,160
    80004c64:	8082                	ret
    end_op();
    80004c66:	fffff097          	auipc	ra,0xfffff
    80004c6a:	818080e7          	jalr	-2024(ra) # 8000347e <end_op>
    return -1;
    80004c6e:	557d                	li	a0,-1
    80004c70:	b7ed                	j	80004c5a <sys_chdir+0x7a>
    iunlockput(ip);
    80004c72:	8526                	mv	a0,s1
    80004c74:	ffffe097          	auipc	ra,0xffffe
    80004c78:	02a080e7          	jalr	42(ra) # 80002c9e <iunlockput>
    end_op();
    80004c7c:	fffff097          	auipc	ra,0xfffff
    80004c80:	802080e7          	jalr	-2046(ra) # 8000347e <end_op>
    return -1;
    80004c84:	557d                	li	a0,-1
    80004c86:	bfd1                	j	80004c5a <sys_chdir+0x7a>

0000000080004c88 <sys_exec>:

uint64 sys_exec(void) {
    80004c88:	7145                	addi	sp,sp,-464
    80004c8a:	e786                	sd	ra,456(sp)
    80004c8c:	e3a2                	sd	s0,448(sp)
    80004c8e:	ff26                	sd	s1,440(sp)
    80004c90:	fb4a                	sd	s2,432(sp)
    80004c92:	f74e                	sd	s3,424(sp)
    80004c94:	f352                	sd	s4,416(sp)
    80004c96:	ef56                	sd	s5,408(sp)
    80004c98:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80004c9a:	e3840593          	addi	a1,s0,-456
    80004c9e:	4505                	li	a0,1
    80004ca0:	ffffd097          	auipc	ra,0xffffd
    80004ca4:	242080e7          	jalr	578(ra) # 80001ee2 <argaddr>
  if (argstr(0, path, MAXPATH) < 0) {
    80004ca8:	08000613          	li	a2,128
    80004cac:	f4040593          	addi	a1,s0,-192
    80004cb0:	4501                	li	a0,0
    80004cb2:	ffffd097          	auipc	ra,0xffffd
    80004cb6:	250080e7          	jalr	592(ra) # 80001f02 <argstr>
    80004cba:	87aa                	mv	a5,a0
    return -1;
    80004cbc:	557d                	li	a0,-1
  if (argstr(0, path, MAXPATH) < 0) {
    80004cbe:	0c07c263          	bltz	a5,80004d82 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80004cc2:	10000613          	li	a2,256
    80004cc6:	4581                	li	a1,0
    80004cc8:	e4040513          	addi	a0,s0,-448
    80004ccc:	ffffb097          	auipc	ra,0xffffb
    80004cd0:	3aa080e7          	jalr	938(ra) # 80000076 <memset>
  for (i = 0;; i++) {
    if (i >= NELEM(argv)) {
    80004cd4:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80004cd8:	89a6                	mv	s3,s1
    80004cda:	4901                	li	s2,0
    if (i >= NELEM(argv)) {
    80004cdc:	02000a13          	li	s4,32
    80004ce0:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if (fetchaddr(uargv + sizeof(uint64) * i, (uint64 *)&uarg) < 0) {
    80004ce4:	00391793          	slli	a5,s2,0x3
    80004ce8:	e3040593          	addi	a1,s0,-464
    80004cec:	e3843503          	ld	a0,-456(s0)
    80004cf0:	953e                	add	a0,a0,a5
    80004cf2:	ffffd097          	auipc	ra,0xffffd
    80004cf6:	132080e7          	jalr	306(ra) # 80001e24 <fetchaddr>
    80004cfa:	02054a63          	bltz	a0,80004d2e <sys_exec+0xa6>
      goto bad;
    }
    if (uarg == 0) {
    80004cfe:	e3043783          	ld	a5,-464(s0)
    80004d02:	c3b9                	beqz	a5,80004d48 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80004d04:	ffffb097          	auipc	ra,0xffffb
    80004d08:	358080e7          	jalr	856(ra) # 8000005c <kalloc>
    80004d0c:	85aa                	mv	a1,a0
    80004d0e:	00a9b023          	sd	a0,0(s3)
    if (argv[i] == 0) goto bad;
    80004d12:	cd11                	beqz	a0,80004d2e <sys_exec+0xa6>
    if (fetchstr(uarg, argv[i], PGSIZE) < 0) goto bad;
    80004d14:	6605                	lui	a2,0x1
    80004d16:	e3043503          	ld	a0,-464(s0)
    80004d1a:	ffffd097          	auipc	ra,0xffffd
    80004d1e:	15c080e7          	jalr	348(ra) # 80001e76 <fetchstr>
    80004d22:	00054663          	bltz	a0,80004d2e <sys_exec+0xa6>
    if (i >= NELEM(argv)) {
    80004d26:	0905                	addi	s2,s2,1
    80004d28:	09a1                	addi	s3,s3,8
    80004d2a:	fb491be3          	bne	s2,s4,80004ce0 <sys_exec+0x58>
  for (i = 0; i < NELEM(argv) && argv[i] != 0; i++) kfree(argv[i]);

  return ret;

bad:
  for (i = 0; i < NELEM(argv) && argv[i] != 0; i++) kfree(argv[i]);
    80004d2e:	10048913          	addi	s2,s1,256
    80004d32:	6088                	ld	a0,0(s1)
    80004d34:	c531                	beqz	a0,80004d80 <sys_exec+0xf8>
    80004d36:	ffffb097          	auipc	ra,0xffffb
    80004d3a:	30e080e7          	jalr	782(ra) # 80000044 <kfree>
    80004d3e:	04a1                	addi	s1,s1,8
    80004d40:	ff2499e3          	bne	s1,s2,80004d32 <sys_exec+0xaa>
  return -1;
    80004d44:	557d                	li	a0,-1
    80004d46:	a835                	j	80004d82 <sys_exec+0xfa>
      argv[i] = 0;
    80004d48:	0a8e                	slli	s5,s5,0x3
    80004d4a:	fc040793          	addi	a5,s0,-64
    80004d4e:	9abe                	add	s5,s5,a5
    80004d50:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80004d54:	e4040593          	addi	a1,s0,-448
    80004d58:	f4040513          	addi	a0,s0,-192
    80004d5c:	fffff097          	auipc	ra,0xfffff
    80004d60:	172080e7          	jalr	370(ra) # 80003ece <exec>
    80004d64:	892a                	mv	s2,a0
  for (i = 0; i < NELEM(argv) && argv[i] != 0; i++) kfree(argv[i]);
    80004d66:	10048993          	addi	s3,s1,256
    80004d6a:	6088                	ld	a0,0(s1)
    80004d6c:	c901                	beqz	a0,80004d7c <sys_exec+0xf4>
    80004d6e:	ffffb097          	auipc	ra,0xffffb
    80004d72:	2d6080e7          	jalr	726(ra) # 80000044 <kfree>
    80004d76:	04a1                	addi	s1,s1,8
    80004d78:	ff3499e3          	bne	s1,s3,80004d6a <sys_exec+0xe2>
  return ret;
    80004d7c:	854a                	mv	a0,s2
    80004d7e:	a011                	j	80004d82 <sys_exec+0xfa>
  return -1;
    80004d80:	557d                	li	a0,-1
}
    80004d82:	60be                	ld	ra,456(sp)
    80004d84:	641e                	ld	s0,448(sp)
    80004d86:	74fa                	ld	s1,440(sp)
    80004d88:	795a                	ld	s2,432(sp)
    80004d8a:	79ba                	ld	s3,424(sp)
    80004d8c:	7a1a                	ld	s4,416(sp)
    80004d8e:	6afa                	ld	s5,408(sp)
    80004d90:	6179                	addi	sp,sp,464
    80004d92:	8082                	ret

0000000080004d94 <sys_pipe>:

uint64 sys_pipe(void) {
    80004d94:	7139                	addi	sp,sp,-64
    80004d96:	fc06                	sd	ra,56(sp)
    80004d98:	f822                	sd	s0,48(sp)
    80004d9a:	f426                	sd	s1,40(sp)
    80004d9c:	0080                	addi	s0,sp,64
  uint64 fdarray;  // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80004d9e:	ffffc097          	auipc	ra,0xffffc
    80004da2:	00a080e7          	jalr	10(ra) # 80000da8 <myproc>
    80004da6:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80004da8:	fd840593          	addi	a1,s0,-40
    80004dac:	4501                	li	a0,0
    80004dae:	ffffd097          	auipc	ra,0xffffd
    80004db2:	134080e7          	jalr	308(ra) # 80001ee2 <argaddr>
  if (pipealloc(&rf, &wf) < 0) return -1;
    80004db6:	fc840593          	addi	a1,s0,-56
    80004dba:	fd040513          	addi	a0,s0,-48
    80004dbe:	fffff097          	auipc	ra,0xfffff
    80004dc2:	dc6080e7          	jalr	-570(ra) # 80003b84 <pipealloc>
    80004dc6:	57fd                	li	a5,-1
    80004dc8:	0c054463          	bltz	a0,80004e90 <sys_pipe+0xfc>
  fd0 = -1;
    80004dcc:	fcf42223          	sw	a5,-60(s0)
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0) {
    80004dd0:	fd043503          	ld	a0,-48(s0)
    80004dd4:	fffff097          	auipc	ra,0xfffff
    80004dd8:	51a080e7          	jalr	1306(ra) # 800042ee <fdalloc>
    80004ddc:	fca42223          	sw	a0,-60(s0)
    80004de0:	08054b63          	bltz	a0,80004e76 <sys_pipe+0xe2>
    80004de4:	fc843503          	ld	a0,-56(s0)
    80004de8:	fffff097          	auipc	ra,0xfffff
    80004dec:	506080e7          	jalr	1286(ra) # 800042ee <fdalloc>
    80004df0:	fca42023          	sw	a0,-64(s0)
    80004df4:	06054863          	bltz	a0,80004e64 <sys_pipe+0xd0>
    if (fd0 >= 0) p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if (copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(fd0)) < 0 ||
    80004df8:	4691                	li	a3,4
    80004dfa:	fc440613          	addi	a2,s0,-60
    80004dfe:	fd843583          	ld	a1,-40(s0)
    80004e02:	68a8                	ld	a0,80(s1)
    80004e04:	ffffc097          	auipc	ra,0xffffc
    80004e08:	c2c080e7          	jalr	-980(ra) # 80000a30 <copyout>
    80004e0c:	02054063          	bltz	a0,80004e2c <sys_pipe+0x98>
      copyout(p->pagetable, fdarray + sizeof(fd0), (char *)&fd1, sizeof(fd1)) <
    80004e10:	4691                	li	a3,4
    80004e12:	fc040613          	addi	a2,s0,-64
    80004e16:	fd843583          	ld	a1,-40(s0)
    80004e1a:	0591                	addi	a1,a1,4
    80004e1c:	68a8                	ld	a0,80(s1)
    80004e1e:	ffffc097          	auipc	ra,0xffffc
    80004e22:	c12080e7          	jalr	-1006(ra) # 80000a30 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80004e26:	4781                	li	a5,0
  if (copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(fd0)) < 0 ||
    80004e28:	06055463          	bgez	a0,80004e90 <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    80004e2c:	fc442783          	lw	a5,-60(s0)
    80004e30:	07e9                	addi	a5,a5,26
    80004e32:	078e                	slli	a5,a5,0x3
    80004e34:	97a6                	add	a5,a5,s1
    80004e36:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80004e3a:	fc042503          	lw	a0,-64(s0)
    80004e3e:	0569                	addi	a0,a0,26
    80004e40:	050e                	slli	a0,a0,0x3
    80004e42:	94aa                	add	s1,s1,a0
    80004e44:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80004e48:	fd043503          	ld	a0,-48(s0)
    80004e4c:	fffff097          	auipc	ra,0xfffff
    80004e50:	a2a080e7          	jalr	-1494(ra) # 80003876 <fileclose>
    fileclose(wf);
    80004e54:	fc843503          	ld	a0,-56(s0)
    80004e58:	fffff097          	auipc	ra,0xfffff
    80004e5c:	a1e080e7          	jalr	-1506(ra) # 80003876 <fileclose>
    return -1;
    80004e60:	57fd                	li	a5,-1
    80004e62:	a03d                	j	80004e90 <sys_pipe+0xfc>
    if (fd0 >= 0) p->ofile[fd0] = 0;
    80004e64:	fc442783          	lw	a5,-60(s0)
    80004e68:	0007c763          	bltz	a5,80004e76 <sys_pipe+0xe2>
    80004e6c:	07e9                	addi	a5,a5,26
    80004e6e:	078e                	slli	a5,a5,0x3
    80004e70:	94be                	add	s1,s1,a5
    80004e72:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80004e76:	fd043503          	ld	a0,-48(s0)
    80004e7a:	fffff097          	auipc	ra,0xfffff
    80004e7e:	9fc080e7          	jalr	-1540(ra) # 80003876 <fileclose>
    fileclose(wf);
    80004e82:	fc843503          	ld	a0,-56(s0)
    80004e86:	fffff097          	auipc	ra,0xfffff
    80004e8a:	9f0080e7          	jalr	-1552(ra) # 80003876 <fileclose>
    return -1;
    80004e8e:	57fd                	li	a5,-1
}
    80004e90:	853e                	mv	a0,a5
    80004e92:	70e2                	ld	ra,56(sp)
    80004e94:	7442                	ld	s0,48(sp)
    80004e96:	74a2                	ld	s1,40(sp)
    80004e98:	6121                	addi	sp,sp,64
    80004e9a:	8082                	ret
    80004e9c:	0000                	unimp
	...

0000000080004ea0 <kernelvec>:
    80004ea0:	7111                	addi	sp,sp,-256
    80004ea2:	e006                	sd	ra,0(sp)
    80004ea4:	e40a                	sd	sp,8(sp)
    80004ea6:	e80e                	sd	gp,16(sp)
    80004ea8:	ec12                	sd	tp,24(sp)
    80004eaa:	f016                	sd	t0,32(sp)
    80004eac:	f41a                	sd	t1,40(sp)
    80004eae:	f81e                	sd	t2,48(sp)
    80004eb0:	fc22                	sd	s0,56(sp)
    80004eb2:	e0a6                	sd	s1,64(sp)
    80004eb4:	e4aa                	sd	a0,72(sp)
    80004eb6:	e8ae                	sd	a1,80(sp)
    80004eb8:	ecb2                	sd	a2,88(sp)
    80004eba:	f0b6                	sd	a3,96(sp)
    80004ebc:	f4ba                	sd	a4,104(sp)
    80004ebe:	f8be                	sd	a5,112(sp)
    80004ec0:	fcc2                	sd	a6,120(sp)
    80004ec2:	e146                	sd	a7,128(sp)
    80004ec4:	e54a                	sd	s2,136(sp)
    80004ec6:	e94e                	sd	s3,144(sp)
    80004ec8:	ed52                	sd	s4,152(sp)
    80004eca:	f156                	sd	s5,160(sp)
    80004ecc:	f55a                	sd	s6,168(sp)
    80004ece:	f95e                	sd	s7,176(sp)
    80004ed0:	fd62                	sd	s8,184(sp)
    80004ed2:	e1e6                	sd	s9,192(sp)
    80004ed4:	e5ea                	sd	s10,200(sp)
    80004ed6:	e9ee                	sd	s11,208(sp)
    80004ed8:	edf2                	sd	t3,216(sp)
    80004eda:	f1f6                	sd	t4,224(sp)
    80004edc:	f5fa                	sd	t5,232(sp)
    80004ede:	f9fe                	sd	t6,240(sp)
    80004ee0:	e11fc0ef          	jal	ra,80001cf0 <kerneltrap>
    80004ee4:	6082                	ld	ra,0(sp)
    80004ee6:	6122                	ld	sp,8(sp)
    80004ee8:	61c2                	ld	gp,16(sp)
    80004eea:	7282                	ld	t0,32(sp)
    80004eec:	7322                	ld	t1,40(sp)
    80004eee:	73c2                	ld	t2,48(sp)
    80004ef0:	7462                	ld	s0,56(sp)
    80004ef2:	6486                	ld	s1,64(sp)
    80004ef4:	6526                	ld	a0,72(sp)
    80004ef6:	65c6                	ld	a1,80(sp)
    80004ef8:	6666                	ld	a2,88(sp)
    80004efa:	7686                	ld	a3,96(sp)
    80004efc:	7726                	ld	a4,104(sp)
    80004efe:	77c6                	ld	a5,112(sp)
    80004f00:	7866                	ld	a6,120(sp)
    80004f02:	688a                	ld	a7,128(sp)
    80004f04:	692a                	ld	s2,136(sp)
    80004f06:	69ca                	ld	s3,144(sp)
    80004f08:	6a6a                	ld	s4,152(sp)
    80004f0a:	7a8a                	ld	s5,160(sp)
    80004f0c:	7b2a                	ld	s6,168(sp)
    80004f0e:	7bca                	ld	s7,176(sp)
    80004f10:	7c6a                	ld	s8,184(sp)
    80004f12:	6c8e                	ld	s9,192(sp)
    80004f14:	6d2e                	ld	s10,200(sp)
    80004f16:	6dce                	ld	s11,208(sp)
    80004f18:	6e6e                	ld	t3,216(sp)
    80004f1a:	7e8e                	ld	t4,224(sp)
    80004f1c:	7f2e                	ld	t5,232(sp)
    80004f1e:	7fce                	ld	t6,240(sp)
    80004f20:	6111                	addi	sp,sp,256
    80004f22:	10200073          	sret
    80004f26:	00000013          	nop
    80004f2a:	00000013          	nop
    80004f2e:	0001                	nop

0000000080004f30 <timervec>:
    80004f30:	34051573          	csrrw	a0,mscratch,a0
    80004f34:	e10c                	sd	a1,0(a0)
    80004f36:	e510                	sd	a2,8(a0)
    80004f38:	e914                	sd	a3,16(a0)
    80004f3a:	6d0c                	ld	a1,24(a0)
    80004f3c:	7110                	ld	a2,32(a0)
    80004f3e:	6194                	ld	a3,0(a1)
    80004f40:	96b2                	add	a3,a3,a2
    80004f42:	e194                	sd	a3,0(a1)
    80004f44:	4589                	li	a1,2
    80004f46:	14459073          	csrw	sip,a1
    80004f4a:	6914                	ld	a3,16(a0)
    80004f4c:	6510                	ld	a2,8(a0)
    80004f4e:	610c                	ld	a1,0(a0)
    80004f50:	34051573          	csrrw	a0,mscratch,a0
    80004f54:	30200073          	mret
	...

0000000080004f5a <plicinit>:

//
// the riscv Platform Level Interrupt Controller (PLIC).
//

void plicinit(void) {
    80004f5a:	1141                	addi	sp,sp,-16
    80004f5c:	e422                	sd	s0,8(sp)
    80004f5e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ * 4) = 1;
    80004f60:	0c0007b7          	lui	a5,0xc000
    80004f64:	4705                	li	a4,1
    80004f66:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ * 4) = 1;
    80004f68:	c3d8                	sw	a4,4(a5)
}
    80004f6a:	6422                	ld	s0,8(sp)
    80004f6c:	0141                	addi	sp,sp,16
    80004f6e:	8082                	ret

0000000080004f70 <plicinithart>:

void plicinithart(void) {
    80004f70:	1141                	addi	sp,sp,-16
    80004f72:	e406                	sd	ra,8(sp)
    80004f74:	e022                	sd	s0,0(sp)
    80004f76:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80004f78:	ffffc097          	auipc	ra,0xffffc
    80004f7c:	e04080e7          	jalr	-508(ra) # 80000d7c <cpuid>

  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80004f80:	0085171b          	slliw	a4,a0,0x8
    80004f84:	0c0027b7          	lui	a5,0xc002
    80004f88:	97ba                	add	a5,a5,a4
    80004f8a:	40200713          	li	a4,1026
    80004f8e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80004f92:	00d5151b          	slliw	a0,a0,0xd
    80004f96:	0c2017b7          	lui	a5,0xc201
    80004f9a:	953e                	add	a0,a0,a5
    80004f9c:	00052023          	sw	zero,0(a0)
}
    80004fa0:	60a2                	ld	ra,8(sp)
    80004fa2:	6402                	ld	s0,0(sp)
    80004fa4:	0141                	addi	sp,sp,16
    80004fa6:	8082                	ret

0000000080004fa8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int plic_claim(void) {
    80004fa8:	1141                	addi	sp,sp,-16
    80004faa:	e406                	sd	ra,8(sp)
    80004fac:	e022                	sd	s0,0(sp)
    80004fae:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80004fb0:	ffffc097          	auipc	ra,0xffffc
    80004fb4:	dcc080e7          	jalr	-564(ra) # 80000d7c <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80004fb8:	00d5179b          	slliw	a5,a0,0xd
    80004fbc:	0c201537          	lui	a0,0xc201
    80004fc0:	953e                	add	a0,a0,a5
  return irq;
}
    80004fc2:	4148                	lw	a0,4(a0)
    80004fc4:	60a2                	ld	ra,8(sp)
    80004fc6:	6402                	ld	s0,0(sp)
    80004fc8:	0141                	addi	sp,sp,16
    80004fca:	8082                	ret

0000000080004fcc <plic_complete>:

// tell the PLIC we've served this IRQ.
void plic_complete(int irq) {
    80004fcc:	1101                	addi	sp,sp,-32
    80004fce:	ec06                	sd	ra,24(sp)
    80004fd0:	e822                	sd	s0,16(sp)
    80004fd2:	e426                	sd	s1,8(sp)
    80004fd4:	1000                	addi	s0,sp,32
    80004fd6:	84aa                	mv	s1,a0
  int hart = cpuid();
    80004fd8:	ffffc097          	auipc	ra,0xffffc
    80004fdc:	da4080e7          	jalr	-604(ra) # 80000d7c <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80004fe0:	00d5151b          	slliw	a0,a0,0xd
    80004fe4:	0c2017b7          	lui	a5,0xc201
    80004fe8:	97aa                	add	a5,a5,a0
    80004fea:	c3c4                	sw	s1,4(a5)
}
    80004fec:	60e2                	ld	ra,24(sp)
    80004fee:	6442                	ld	s0,16(sp)
    80004ff0:	64a2                	ld	s1,8(sp)
    80004ff2:	6105                	addi	sp,sp,32
    80004ff4:	8082                	ret

0000000080004ff6 <free_desc>:
  }
  return -1;
}

// mark a descriptor as free.
static void free_desc(int i) {
    80004ff6:	1141                	addi	sp,sp,-16
    80004ff8:	e406                	sd	ra,8(sp)
    80004ffa:	e022                	sd	s0,0(sp)
    80004ffc:	0800                	addi	s0,sp,16
  if (i >= NUM) panic("free_desc 1");
    80004ffe:	479d                	li	a5,7
    80005000:	04a7cc63          	blt	a5,a0,80005058 <free_desc+0x62>
  if (disk.free[i]) panic("free_desc 2");
    80005004:	00014797          	auipc	a5,0x14
    80005008:	b5478793          	addi	a5,a5,-1196 # 80018b58 <disk>
    8000500c:	97aa                	add	a5,a5,a0
    8000500e:	0187c783          	lbu	a5,24(a5)
    80005012:	ebb9                	bnez	a5,80005068 <free_desc+0x72>
  disk.desc[i].addr = 0;
    80005014:	00451613          	slli	a2,a0,0x4
    80005018:	00014797          	auipc	a5,0x14
    8000501c:	b4078793          	addi	a5,a5,-1216 # 80018b58 <disk>
    80005020:	6394                	ld	a3,0(a5)
    80005022:	96b2                	add	a3,a3,a2
    80005024:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005028:	6398                	ld	a4,0(a5)
    8000502a:	9732                	add	a4,a4,a2
    8000502c:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80005030:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80005034:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80005038:	953e                	add	a0,a0,a5
    8000503a:	4785                	li	a5,1
    8000503c:	00f50c23          	sb	a5,24(a0) # c201018 <_entry-0x73dfefe8>
  wakeup(&disk.free[0]);
    80005040:	00014517          	auipc	a0,0x14
    80005044:	b3050513          	addi	a0,a0,-1232 # 80018b70 <disk+0x18>
    80005048:	ffffc097          	auipc	ra,0xffffc
    8000504c:	470080e7          	jalr	1136(ra) # 800014b8 <wakeup>
}
    80005050:	60a2                	ld	ra,8(sp)
    80005052:	6402                	ld	s0,0(sp)
    80005054:	0141                	addi	sp,sp,16
    80005056:	8082                	ret
  if (i >= NUM) panic("free_desc 1");
    80005058:	00003517          	auipc	a0,0x3
    8000505c:	69050513          	addi	a0,a0,1680 # 800086e8 <syscalls+0x2e8>
    80005060:	00001097          	auipc	ra,0x1
    80005064:	6d8080e7          	jalr	1752(ra) # 80006738 <panic>
  if (disk.free[i]) panic("free_desc 2");
    80005068:	00003517          	auipc	a0,0x3
    8000506c:	69050513          	addi	a0,a0,1680 # 800086f8 <syscalls+0x2f8>
    80005070:	00001097          	auipc	ra,0x1
    80005074:	6c8080e7          	jalr	1736(ra) # 80006738 <panic>

0000000080005078 <virtio_disk_init>:
void virtio_disk_init(void) {
    80005078:	1101                	addi	sp,sp,-32
    8000507a:	ec06                	sd	ra,24(sp)
    8000507c:	e822                	sd	s0,16(sp)
    8000507e:	e426                	sd	s1,8(sp)
    80005080:	e04a                	sd	s2,0(sp)
    80005082:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005084:	00003597          	auipc	a1,0x3
    80005088:	68458593          	addi	a1,a1,1668 # 80008708 <syscalls+0x308>
    8000508c:	00014517          	auipc	a0,0x14
    80005090:	bf450513          	addi	a0,a0,-1036 # 80018c80 <disk+0x128>
    80005094:	00002097          	auipc	ra,0x2
    80005098:	b50080e7          	jalr	-1200(ra) # 80006be4 <initlock>
  if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000509c:	100017b7          	lui	a5,0x10001
    800050a0:	4398                	lw	a4,0(a5)
    800050a2:	2701                	sext.w	a4,a4
    800050a4:	747277b7          	lui	a5,0x74727
    800050a8:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800050ac:	14f71c63          	bne	a4,a5,80005204 <virtio_disk_init+0x18c>
      *R(VIRTIO_MMIO_VERSION) != 2 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800050b0:	100017b7          	lui	a5,0x10001
    800050b4:	43dc                	lw	a5,4(a5)
    800050b6:	2781                	sext.w	a5,a5
  if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800050b8:	4709                	li	a4,2
    800050ba:	14e79563          	bne	a5,a4,80005204 <virtio_disk_init+0x18c>
      *R(VIRTIO_MMIO_VERSION) != 2 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800050be:	100017b7          	lui	a5,0x10001
    800050c2:	479c                	lw	a5,8(a5)
    800050c4:	2781                	sext.w	a5,a5
    800050c6:	12e79f63          	bne	a5,a4,80005204 <virtio_disk_init+0x18c>
      *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551) {
    800050ca:	100017b7          	lui	a5,0x10001
    800050ce:	47d8                	lw	a4,12(a5)
    800050d0:	2701                	sext.w	a4,a4
      *R(VIRTIO_MMIO_VERSION) != 2 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800050d2:	554d47b7          	lui	a5,0x554d4
    800050d6:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800050da:	12f71563          	bne	a4,a5,80005204 <virtio_disk_init+0x18c>
  *R(VIRTIO_MMIO_STATUS) = status;
    800050de:	100017b7          	lui	a5,0x10001
    800050e2:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    800050e6:	4705                	li	a4,1
    800050e8:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800050ea:	470d                	li	a4,3
    800050ec:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800050ee:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800050f0:	c7ffe737          	lui	a4,0xc7ffe
    800050f4:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fdd86f>
    800050f8:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800050fa:	2701                	sext.w	a4,a4
    800050fc:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800050fe:	472d                	li	a4,11
    80005100:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80005102:	5bbc                	lw	a5,112(a5)
    80005104:	0007891b          	sext.w	s2,a5
  if (!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80005108:	8ba1                	andi	a5,a5,8
    8000510a:	10078563          	beqz	a5,80005214 <virtio_disk_init+0x19c>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    8000510e:	100017b7          	lui	a5,0x10001
    80005112:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if (*R(VIRTIO_MMIO_QUEUE_READY)) panic("virtio disk should not be ready");
    80005116:	43fc                	lw	a5,68(a5)
    80005118:	2781                	sext.w	a5,a5
    8000511a:	10079563          	bnez	a5,80005224 <virtio_disk_init+0x1ac>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    8000511e:	100017b7          	lui	a5,0x10001
    80005122:	5bdc                	lw	a5,52(a5)
    80005124:	2781                	sext.w	a5,a5
  if (max == 0) panic("virtio disk has no queue 0");
    80005126:	10078763          	beqz	a5,80005234 <virtio_disk_init+0x1bc>
  if (max < NUM) panic("virtio disk max queue too short");
    8000512a:	471d                	li	a4,7
    8000512c:	10f77c63          	bgeu	a4,a5,80005244 <virtio_disk_init+0x1cc>
  disk.desc = kalloc();
    80005130:	ffffb097          	auipc	ra,0xffffb
    80005134:	f2c080e7          	jalr	-212(ra) # 8000005c <kalloc>
    80005138:	00014497          	auipc	s1,0x14
    8000513c:	a2048493          	addi	s1,s1,-1504 # 80018b58 <disk>
    80005140:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80005142:	ffffb097          	auipc	ra,0xffffb
    80005146:	f1a080e7          	jalr	-230(ra) # 8000005c <kalloc>
    8000514a:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    8000514c:	ffffb097          	auipc	ra,0xffffb
    80005150:	f10080e7          	jalr	-240(ra) # 8000005c <kalloc>
    80005154:	87aa                	mv	a5,a0
    80005156:	e888                	sd	a0,16(s1)
  if (!disk.desc || !disk.avail || !disk.used) panic("virtio disk kalloc");
    80005158:	6088                	ld	a0,0(s1)
    8000515a:	cd6d                	beqz	a0,80005254 <virtio_disk_init+0x1dc>
    8000515c:	00014717          	auipc	a4,0x14
    80005160:	a0473703          	ld	a4,-1532(a4) # 80018b60 <disk+0x8>
    80005164:	cb65                	beqz	a4,80005254 <virtio_disk_init+0x1dc>
    80005166:	c7fd                	beqz	a5,80005254 <virtio_disk_init+0x1dc>
  memset(disk.desc, 0, PGSIZE);
    80005168:	6605                	lui	a2,0x1
    8000516a:	4581                	li	a1,0
    8000516c:	ffffb097          	auipc	ra,0xffffb
    80005170:	f0a080e7          	jalr	-246(ra) # 80000076 <memset>
  memset(disk.avail, 0, PGSIZE);
    80005174:	00014497          	auipc	s1,0x14
    80005178:	9e448493          	addi	s1,s1,-1564 # 80018b58 <disk>
    8000517c:	6605                	lui	a2,0x1
    8000517e:	4581                	li	a1,0
    80005180:	6488                	ld	a0,8(s1)
    80005182:	ffffb097          	auipc	ra,0xffffb
    80005186:	ef4080e7          	jalr	-268(ra) # 80000076 <memset>
  memset(disk.used, 0, PGSIZE);
    8000518a:	6605                	lui	a2,0x1
    8000518c:	4581                	li	a1,0
    8000518e:	6888                	ld	a0,16(s1)
    80005190:	ffffb097          	auipc	ra,0xffffb
    80005194:	ee6080e7          	jalr	-282(ra) # 80000076 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005198:	100017b7          	lui	a5,0x10001
    8000519c:	4721                	li	a4,8
    8000519e:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    800051a0:	4098                	lw	a4,0(s1)
    800051a2:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    800051a6:	40d8                	lw	a4,4(s1)
    800051a8:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    800051ac:	6498                	ld	a4,8(s1)
    800051ae:	0007069b          	sext.w	a3,a4
    800051b2:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    800051b6:	9701                	srai	a4,a4,0x20
    800051b8:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    800051bc:	6898                	ld	a4,16(s1)
    800051be:	0007069b          	sext.w	a3,a4
    800051c2:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    800051c6:	9701                	srai	a4,a4,0x20
    800051c8:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    800051cc:	4705                	li	a4,1
    800051ce:	c3f8                	sw	a4,68(a5)
  for (int i = 0; i < NUM; i++) disk.free[i] = 1;
    800051d0:	00e48c23          	sb	a4,24(s1)
    800051d4:	00e48ca3          	sb	a4,25(s1)
    800051d8:	00e48d23          	sb	a4,26(s1)
    800051dc:	00e48da3          	sb	a4,27(s1)
    800051e0:	00e48e23          	sb	a4,28(s1)
    800051e4:	00e48ea3          	sb	a4,29(s1)
    800051e8:	00e48f23          	sb	a4,30(s1)
    800051ec:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    800051f0:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    800051f4:	0727a823          	sw	s2,112(a5)
}
    800051f8:	60e2                	ld	ra,24(sp)
    800051fa:	6442                	ld	s0,16(sp)
    800051fc:	64a2                	ld	s1,8(sp)
    800051fe:	6902                	ld	s2,0(sp)
    80005200:	6105                	addi	sp,sp,32
    80005202:	8082                	ret
    panic("could not find virtio disk");
    80005204:	00003517          	auipc	a0,0x3
    80005208:	51450513          	addi	a0,a0,1300 # 80008718 <syscalls+0x318>
    8000520c:	00001097          	auipc	ra,0x1
    80005210:	52c080e7          	jalr	1324(ra) # 80006738 <panic>
    panic("virtio disk FEATURES_OK unset");
    80005214:	00003517          	auipc	a0,0x3
    80005218:	52450513          	addi	a0,a0,1316 # 80008738 <syscalls+0x338>
    8000521c:	00001097          	auipc	ra,0x1
    80005220:	51c080e7          	jalr	1308(ra) # 80006738 <panic>
  if (*R(VIRTIO_MMIO_QUEUE_READY)) panic("virtio disk should not be ready");
    80005224:	00003517          	auipc	a0,0x3
    80005228:	53450513          	addi	a0,a0,1332 # 80008758 <syscalls+0x358>
    8000522c:	00001097          	auipc	ra,0x1
    80005230:	50c080e7          	jalr	1292(ra) # 80006738 <panic>
  if (max == 0) panic("virtio disk has no queue 0");
    80005234:	00003517          	auipc	a0,0x3
    80005238:	54450513          	addi	a0,a0,1348 # 80008778 <syscalls+0x378>
    8000523c:	00001097          	auipc	ra,0x1
    80005240:	4fc080e7          	jalr	1276(ra) # 80006738 <panic>
  if (max < NUM) panic("virtio disk max queue too short");
    80005244:	00003517          	auipc	a0,0x3
    80005248:	55450513          	addi	a0,a0,1364 # 80008798 <syscalls+0x398>
    8000524c:	00001097          	auipc	ra,0x1
    80005250:	4ec080e7          	jalr	1260(ra) # 80006738 <panic>
  if (!disk.desc || !disk.avail || !disk.used) panic("virtio disk kalloc");
    80005254:	00003517          	auipc	a0,0x3
    80005258:	56450513          	addi	a0,a0,1380 # 800087b8 <syscalls+0x3b8>
    8000525c:	00001097          	auipc	ra,0x1
    80005260:	4dc080e7          	jalr	1244(ra) # 80006738 <panic>

0000000080005264 <virtio_disk_rw>:
    }
  }
  return 0;
}

void virtio_disk_rw(struct buf *b, int write) {
    80005264:	7119                	addi	sp,sp,-128
    80005266:	fc86                	sd	ra,120(sp)
    80005268:	f8a2                	sd	s0,112(sp)
    8000526a:	f4a6                	sd	s1,104(sp)
    8000526c:	f0ca                	sd	s2,96(sp)
    8000526e:	ecce                	sd	s3,88(sp)
    80005270:	e8d2                	sd	s4,80(sp)
    80005272:	e4d6                	sd	s5,72(sp)
    80005274:	e0da                	sd	s6,64(sp)
    80005276:	fc5e                	sd	s7,56(sp)
    80005278:	f862                	sd	s8,48(sp)
    8000527a:	f466                	sd	s9,40(sp)
    8000527c:	f06a                	sd	s10,32(sp)
    8000527e:	ec6e                	sd	s11,24(sp)
    80005280:	0100                	addi	s0,sp,128
    80005282:	8aaa                	mv	s5,a0
    80005284:	8c2e                	mv	s8,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005286:	00c52d03          	lw	s10,12(a0)
    8000528a:	001d1d1b          	slliw	s10,s10,0x1
    8000528e:	1d02                	slli	s10,s10,0x20
    80005290:	020d5d13          	srli	s10,s10,0x20

  acquire(&disk.vdisk_lock);
    80005294:	00014517          	auipc	a0,0x14
    80005298:	9ec50513          	addi	a0,a0,-1556 # 80018c80 <disk+0x128>
    8000529c:	00002097          	auipc	ra,0x2
    800052a0:	9d8080e7          	jalr	-1576(ra) # 80006c74 <acquire>
  for (int i = 0; i < 3; i++) {
    800052a4:	4981                	li	s3,0
  for (int i = 0; i < NUM; i++) {
    800052a6:	44a1                	li	s1,8
      disk.free[i] = 0;
    800052a8:	00014b97          	auipc	s7,0x14
    800052ac:	8b0b8b93          	addi	s7,s7,-1872 # 80018b58 <disk>
  for (int i = 0; i < 3; i++) {
    800052b0:	4b0d                	li	s6,3
  int idx[3];
  while (1) {
    if (alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800052b2:	00014c97          	auipc	s9,0x14
    800052b6:	9cec8c93          	addi	s9,s9,-1586 # 80018c80 <disk+0x128>
    800052ba:	a08d                	j	8000531c <virtio_disk_rw+0xb8>
      disk.free[i] = 0;
    800052bc:	00fb8733          	add	a4,s7,a5
    800052c0:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    800052c4:	c19c                	sw	a5,0(a1)
    if (idx[i] < 0) {
    800052c6:	0207c563          	bltz	a5,800052f0 <virtio_disk_rw+0x8c>
  for (int i = 0; i < 3; i++) {
    800052ca:	2905                	addiw	s2,s2,1
    800052cc:	0611                	addi	a2,a2,4
    800052ce:	05690c63          	beq	s2,s6,80005326 <virtio_disk_rw+0xc2>
    idx[i] = alloc_desc();
    800052d2:	85b2                	mv	a1,a2
  for (int i = 0; i < NUM; i++) {
    800052d4:	00014717          	auipc	a4,0x14
    800052d8:	88470713          	addi	a4,a4,-1916 # 80018b58 <disk>
    800052dc:	87ce                	mv	a5,s3
    if (disk.free[i]) {
    800052de:	01874683          	lbu	a3,24(a4)
    800052e2:	fee9                	bnez	a3,800052bc <virtio_disk_rw+0x58>
  for (int i = 0; i < NUM; i++) {
    800052e4:	2785                	addiw	a5,a5,1
    800052e6:	0705                	addi	a4,a4,1
    800052e8:	fe979be3          	bne	a5,s1,800052de <virtio_disk_rw+0x7a>
    idx[i] = alloc_desc();
    800052ec:	57fd                	li	a5,-1
    800052ee:	c19c                	sw	a5,0(a1)
      for (int j = 0; j < i; j++) free_desc(idx[j]);
    800052f0:	01205d63          	blez	s2,8000530a <virtio_disk_rw+0xa6>
    800052f4:	8dce                	mv	s11,s3
    800052f6:	000a2503          	lw	a0,0(s4)
    800052fa:	00000097          	auipc	ra,0x0
    800052fe:	cfc080e7          	jalr	-772(ra) # 80004ff6 <free_desc>
    80005302:	2d85                	addiw	s11,s11,1
    80005304:	0a11                	addi	s4,s4,4
    80005306:	ffb918e3          	bne	s2,s11,800052f6 <virtio_disk_rw+0x92>
    sleep(&disk.free[0], &disk.vdisk_lock);
    8000530a:	85e6                	mv	a1,s9
    8000530c:	00014517          	auipc	a0,0x14
    80005310:	86450513          	addi	a0,a0,-1948 # 80018b70 <disk+0x18>
    80005314:	ffffc097          	auipc	ra,0xffffc
    80005318:	140080e7          	jalr	320(ra) # 80001454 <sleep>
  for (int i = 0; i < 3; i++) {
    8000531c:	f8040a13          	addi	s4,s0,-128
void virtio_disk_rw(struct buf *b, int write) {
    80005320:	8652                	mv	a2,s4
  for (int i = 0; i < 3; i++) {
    80005322:	894e                	mv	s2,s3
    80005324:	b77d                	j	800052d2 <virtio_disk_rw+0x6e>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005326:	f8042583          	lw	a1,-128(s0)
    8000532a:	00a58793          	addi	a5,a1,10
    8000532e:	0792                	slli	a5,a5,0x4

  if (write)
    80005330:	00014617          	auipc	a2,0x14
    80005334:	82860613          	addi	a2,a2,-2008 # 80018b58 <disk>
    80005338:	00f60733          	add	a4,a2,a5
    8000533c:	018036b3          	snez	a3,s8
    80005340:	c714                	sw	a3,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT;  // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN;  // read the disk
  buf0->reserved = 0;
    80005342:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80005346:	01a73823          	sd	s10,16(a4)

  disk.desc[idx[0]].addr = (uint64)buf0;
    8000534a:	f6078693          	addi	a3,a5,-160
    8000534e:	6218                	ld	a4,0(a2)
    80005350:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005352:	00878513          	addi	a0,a5,8
    80005356:	9532                	add	a0,a0,a2
  disk.desc[idx[0]].addr = (uint64)buf0;
    80005358:	e308                	sd	a0,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000535a:	6208                	ld	a0,0(a2)
    8000535c:	96aa                	add	a3,a3,a0
    8000535e:	4741                	li	a4,16
    80005360:	c698                	sw	a4,8(a3)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005362:	4705                	li	a4,1
    80005364:	00e69623          	sh	a4,12(a3)
  disk.desc[idx[0]].next = idx[1];
    80005368:	f8442703          	lw	a4,-124(s0)
    8000536c:	00e69723          	sh	a4,14(a3)

  disk.desc[idx[1]].addr = (uint64)b->data;
    80005370:	0712                	slli	a4,a4,0x4
    80005372:	953a                	add	a0,a0,a4
    80005374:	058a8693          	addi	a3,s5,88
    80005378:	e114                	sd	a3,0(a0)
  disk.desc[idx[1]].len = BSIZE;
    8000537a:	6208                	ld	a0,0(a2)
    8000537c:	972a                	add	a4,a4,a0
    8000537e:	40000693          	li	a3,1024
    80005382:	c714                	sw	a3,8(a4)
  if (write)
    disk.desc[idx[1]].flags = 0;  // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE;  // device writes b->data
    80005384:	001c3c13          	seqz	s8,s8
    80005388:	0c06                	slli	s8,s8,0x1
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000538a:	001c6c13          	ori	s8,s8,1
    8000538e:	01871623          	sh	s8,12(a4)
  disk.desc[idx[1]].next = idx[2];
    80005392:	f8842603          	lw	a2,-120(s0)
    80005396:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff;  // device writes 0 on success
    8000539a:	00013697          	auipc	a3,0x13
    8000539e:	7be68693          	addi	a3,a3,1982 # 80018b58 <disk>
    800053a2:	00258713          	addi	a4,a1,2
    800053a6:	0712                	slli	a4,a4,0x4
    800053a8:	9736                	add	a4,a4,a3
    800053aa:	587d                	li	a6,-1
    800053ac:	01070823          	sb	a6,16(a4)
  disk.desc[idx[2]].addr = (uint64)&disk.info[idx[0]].status;
    800053b0:	0612                	slli	a2,a2,0x4
    800053b2:	9532                	add	a0,a0,a2
    800053b4:	f9078793          	addi	a5,a5,-112
    800053b8:	97b6                	add	a5,a5,a3
    800053ba:	e11c                	sd	a5,0(a0)
  disk.desc[idx[2]].len = 1;
    800053bc:	629c                	ld	a5,0(a3)
    800053be:	97b2                	add	a5,a5,a2
    800053c0:	4605                	li	a2,1
    800053c2:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE;  // device writes the status
    800053c4:	4509                	li	a0,2
    800053c6:	00a79623          	sh	a0,12(a5)
  disk.desc[idx[2]].next = 0;
    800053ca:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800053ce:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    800053d2:	01573423          	sd	s5,8(a4)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800053d6:	6698                	ld	a4,8(a3)
    800053d8:	00275783          	lhu	a5,2(a4)
    800053dc:	8b9d                	andi	a5,a5,7
    800053de:	0786                	slli	a5,a5,0x1
    800053e0:	97ba                	add	a5,a5,a4
    800053e2:	00b79223          	sh	a1,4(a5)

  __sync_synchronize();
    800053e6:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1;  // not % NUM ...
    800053ea:	6698                	ld	a4,8(a3)
    800053ec:	00275783          	lhu	a5,2(a4)
    800053f0:	2785                	addiw	a5,a5,1
    800053f2:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    800053f6:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0;  // value is queue number
    800053fa:	100017b7          	lui	a5,0x10001
    800053fe:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while (b->disk == 1) {
    80005402:	004aa783          	lw	a5,4(s5)
    80005406:	02c79163          	bne	a5,a2,80005428 <virtio_disk_rw+0x1c4>
    sleep(b, &disk.vdisk_lock);
    8000540a:	00014917          	auipc	s2,0x14
    8000540e:	87690913          	addi	s2,s2,-1930 # 80018c80 <disk+0x128>
  while (b->disk == 1) {
    80005412:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80005414:	85ca                	mv	a1,s2
    80005416:	8556                	mv	a0,s5
    80005418:	ffffc097          	auipc	ra,0xffffc
    8000541c:	03c080e7          	jalr	60(ra) # 80001454 <sleep>
  while (b->disk == 1) {
    80005420:	004aa783          	lw	a5,4(s5)
    80005424:	fe9788e3          	beq	a5,s1,80005414 <virtio_disk_rw+0x1b0>
  }

  disk.info[idx[0]].b = 0;
    80005428:	f8042903          	lw	s2,-128(s0)
    8000542c:	00290793          	addi	a5,s2,2
    80005430:	00479713          	slli	a4,a5,0x4
    80005434:	00013797          	auipc	a5,0x13
    80005438:	72478793          	addi	a5,a5,1828 # 80018b58 <disk>
    8000543c:	97ba                	add	a5,a5,a4
    8000543e:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80005442:	00013997          	auipc	s3,0x13
    80005446:	71698993          	addi	s3,s3,1814 # 80018b58 <disk>
    8000544a:	00491713          	slli	a4,s2,0x4
    8000544e:	0009b783          	ld	a5,0(s3)
    80005452:	97ba                	add	a5,a5,a4
    80005454:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005458:	854a                	mv	a0,s2
    8000545a:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    8000545e:	00000097          	auipc	ra,0x0
    80005462:	b98080e7          	jalr	-1128(ra) # 80004ff6 <free_desc>
    if (flag & VRING_DESC_F_NEXT)
    80005466:	8885                	andi	s1,s1,1
    80005468:	f0ed                	bnez	s1,8000544a <virtio_disk_rw+0x1e6>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    8000546a:	00014517          	auipc	a0,0x14
    8000546e:	81650513          	addi	a0,a0,-2026 # 80018c80 <disk+0x128>
    80005472:	00002097          	auipc	ra,0x2
    80005476:	8b6080e7          	jalr	-1866(ra) # 80006d28 <release>
}
    8000547a:	70e6                	ld	ra,120(sp)
    8000547c:	7446                	ld	s0,112(sp)
    8000547e:	74a6                	ld	s1,104(sp)
    80005480:	7906                	ld	s2,96(sp)
    80005482:	69e6                	ld	s3,88(sp)
    80005484:	6a46                	ld	s4,80(sp)
    80005486:	6aa6                	ld	s5,72(sp)
    80005488:	6b06                	ld	s6,64(sp)
    8000548a:	7be2                	ld	s7,56(sp)
    8000548c:	7c42                	ld	s8,48(sp)
    8000548e:	7ca2                	ld	s9,40(sp)
    80005490:	7d02                	ld	s10,32(sp)
    80005492:	6de2                	ld	s11,24(sp)
    80005494:	6109                	addi	sp,sp,128
    80005496:	8082                	ret

0000000080005498 <virtio_disk_intr>:

void virtio_disk_intr() {
    80005498:	1101                	addi	sp,sp,-32
    8000549a:	ec06                	sd	ra,24(sp)
    8000549c:	e822                	sd	s0,16(sp)
    8000549e:	e426                	sd	s1,8(sp)
    800054a0:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800054a2:	00013497          	auipc	s1,0x13
    800054a6:	6b648493          	addi	s1,s1,1718 # 80018b58 <disk>
    800054aa:	00013517          	auipc	a0,0x13
    800054ae:	7d650513          	addi	a0,a0,2006 # 80018c80 <disk+0x128>
    800054b2:	00001097          	auipc	ra,0x1
    800054b6:	7c2080e7          	jalr	1986(ra) # 80006c74 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800054ba:	10001737          	lui	a4,0x10001
    800054be:	533c                	lw	a5,96(a4)
    800054c0:	8b8d                	andi	a5,a5,3
    800054c2:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800054c4:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while (disk.used_idx != disk.used->idx) {
    800054c8:	689c                	ld	a5,16(s1)
    800054ca:	0204d703          	lhu	a4,32(s1)
    800054ce:	0027d783          	lhu	a5,2(a5)
    800054d2:	04f70863          	beq	a4,a5,80005522 <virtio_disk_intr+0x8a>
    __sync_synchronize();
    800054d6:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800054da:	6898                	ld	a4,16(s1)
    800054dc:	0204d783          	lhu	a5,32(s1)
    800054e0:	8b9d                	andi	a5,a5,7
    800054e2:	078e                	slli	a5,a5,0x3
    800054e4:	97ba                	add	a5,a5,a4
    800054e6:	43dc                	lw	a5,4(a5)

    if (disk.info[id].status != 0) panic("virtio_disk_intr status");
    800054e8:	00278713          	addi	a4,a5,2
    800054ec:	0712                	slli	a4,a4,0x4
    800054ee:	9726                	add	a4,a4,s1
    800054f0:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    800054f4:	e721                	bnez	a4,8000553c <virtio_disk_intr+0xa4>

    struct buf *b = disk.info[id].b;
    800054f6:	0789                	addi	a5,a5,2
    800054f8:	0792                	slli	a5,a5,0x4
    800054fa:	97a6                	add	a5,a5,s1
    800054fc:	6788                	ld	a0,8(a5)
    b->disk = 0;  // disk is done with buf
    800054fe:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005502:	ffffc097          	auipc	ra,0xffffc
    80005506:	fb6080e7          	jalr	-74(ra) # 800014b8 <wakeup>

    disk.used_idx += 1;
    8000550a:	0204d783          	lhu	a5,32(s1)
    8000550e:	2785                	addiw	a5,a5,1
    80005510:	17c2                	slli	a5,a5,0x30
    80005512:	93c1                	srli	a5,a5,0x30
    80005514:	02f49023          	sh	a5,32(s1)
  while (disk.used_idx != disk.used->idx) {
    80005518:	6898                	ld	a4,16(s1)
    8000551a:	00275703          	lhu	a4,2(a4)
    8000551e:	faf71ce3          	bne	a4,a5,800054d6 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80005522:	00013517          	auipc	a0,0x13
    80005526:	75e50513          	addi	a0,a0,1886 # 80018c80 <disk+0x128>
    8000552a:	00001097          	auipc	ra,0x1
    8000552e:	7fe080e7          	jalr	2046(ra) # 80006d28 <release>
}
    80005532:	60e2                	ld	ra,24(sp)
    80005534:	6442                	ld	s0,16(sp)
    80005536:	64a2                	ld	s1,8(sp)
    80005538:	6105                	addi	sp,sp,32
    8000553a:	8082                	ret
    if (disk.info[id].status != 0) panic("virtio_disk_intr status");
    8000553c:	00003517          	auipc	a0,0x3
    80005540:	29450513          	addi	a0,a0,660 # 800087d0 <syscalls+0x3d0>
    80005544:	00001097          	auipc	ra,0x1
    80005548:	1f4080e7          	jalr	500(ra) # 80006738 <panic>

000000008000554c <bit_isset>:
static Sz_info *bd_sizes;
static void *bd_base;  // start address of memory managed by the buddy allocator
static struct spinlock lock;

// Return 1 if bit at position index in array is set to 1
int bit_isset(char *array, int index) {
    8000554c:	1141                	addi	sp,sp,-16
    8000554e:	e422                	sd	s0,8(sp)
    80005550:	0800                	addi	s0,sp,16
  char b = array[index / 8];
  char m = (1 << (index % 8));
    80005552:	41f5d79b          	sraiw	a5,a1,0x1f
    80005556:	01d7d79b          	srliw	a5,a5,0x1d
    8000555a:	9dbd                	addw	a1,a1,a5
    8000555c:	0075f713          	andi	a4,a1,7
    80005560:	9f1d                	subw	a4,a4,a5
    80005562:	4785                	li	a5,1
    80005564:	00e797bb          	sllw	a5,a5,a4
    80005568:	0ff7f793          	andi	a5,a5,255
  char b = array[index / 8];
    8000556c:	4035d59b          	sraiw	a1,a1,0x3
    80005570:	95aa                	add	a1,a1,a0
  return (b & m) == m;
    80005572:	0005c503          	lbu	a0,0(a1)
    80005576:	8d7d                	and	a0,a0,a5
    80005578:	8d1d                	sub	a0,a0,a5
}
    8000557a:	00153513          	seqz	a0,a0
    8000557e:	6422                	ld	s0,8(sp)
    80005580:	0141                	addi	sp,sp,16
    80005582:	8082                	ret

0000000080005584 <bit_set>:

// Set bit at position index in array to 1
void bit_set(char *array, int index) {
    80005584:	1141                	addi	sp,sp,-16
    80005586:	e422                	sd	s0,8(sp)
    80005588:	0800                	addi	s0,sp,16
  char b = array[index / 8];
    8000558a:	41f5d79b          	sraiw	a5,a1,0x1f
    8000558e:	01d7d79b          	srliw	a5,a5,0x1d
    80005592:	9dbd                	addw	a1,a1,a5
    80005594:	4035d71b          	sraiw	a4,a1,0x3
    80005598:	953a                	add	a0,a0,a4
  char m = (1 << (index % 8));
    8000559a:	899d                	andi	a1,a1,7
    8000559c:	9d9d                	subw	a1,a1,a5
    8000559e:	4785                	li	a5,1
    800055a0:	00b795bb          	sllw	a1,a5,a1
  array[index / 8] = (b | m);
    800055a4:	00054783          	lbu	a5,0(a0)
    800055a8:	8ddd                	or	a1,a1,a5
    800055aa:	00b50023          	sb	a1,0(a0)
}
    800055ae:	6422                	ld	s0,8(sp)
    800055b0:	0141                	addi	sp,sp,16
    800055b2:	8082                	ret

00000000800055b4 <bit_clear>:

// Clear bit at position index in array
void bit_clear(char *array, int index) {
    800055b4:	1141                	addi	sp,sp,-16
    800055b6:	e422                	sd	s0,8(sp)
    800055b8:	0800                	addi	s0,sp,16
  char b = array[index / 8];
    800055ba:	41f5d79b          	sraiw	a5,a1,0x1f
    800055be:	01d7d79b          	srliw	a5,a5,0x1d
    800055c2:	9dbd                	addw	a1,a1,a5
    800055c4:	4035d71b          	sraiw	a4,a1,0x3
    800055c8:	953a                	add	a0,a0,a4
  char m = (1 << (index % 8));
    800055ca:	899d                	andi	a1,a1,7
    800055cc:	9d9d                	subw	a1,a1,a5
    800055ce:	4785                	li	a5,1
    800055d0:	00b795bb          	sllw	a1,a5,a1
  array[index / 8] = (b & ~m);
    800055d4:	fff5c593          	not	a1,a1
    800055d8:	00054783          	lbu	a5,0(a0)
    800055dc:	8dfd                	and	a1,a1,a5
    800055de:	00b50023          	sb	a1,0(a0)
}
    800055e2:	6422                	ld	s0,8(sp)
    800055e4:	0141                	addi	sp,sp,16
    800055e6:	8082                	ret

00000000800055e8 <bit_invert>:

void bit_invert(char *array, int index) {
    800055e8:	1141                	addi	sp,sp,-16
    800055ea:	e422                	sd	s0,8(sp)
    800055ec:	0800                	addi	s0,sp,16
  char b = array[index / 8];
    800055ee:	41f5d79b          	sraiw	a5,a1,0x1f
    800055f2:	01d7d79b          	srliw	a5,a5,0x1d
    800055f6:	9dbd                	addw	a1,a1,a5
    800055f8:	4035d71b          	sraiw	a4,a1,0x3
    800055fc:	953a                	add	a0,a0,a4
  char m = (1 << (index % 8));
    800055fe:	899d                	andi	a1,a1,7
    80005600:	9d9d                	subw	a1,a1,a5
    80005602:	4785                	li	a5,1
    80005604:	00b795bb          	sllw	a1,a5,a1
  array[index / 8] = (b ^ m);
    80005608:	00054783          	lbu	a5,0(a0)
    8000560c:	8dbd                	xor	a1,a1,a5
    8000560e:	00b50023          	sb	a1,0(a0)
}
    80005612:	6422                	ld	s0,8(sp)
    80005614:	0141                	addi	sp,sp,16
    80005616:	8082                	ret

0000000080005618 <bd_print_vector>:

// Print a bit vector as a list of ranges of 1 bits
void bd_print_vector(char *vector, int len) {
    80005618:	715d                	addi	sp,sp,-80
    8000561a:	e486                	sd	ra,72(sp)
    8000561c:	e0a2                	sd	s0,64(sp)
    8000561e:	fc26                	sd	s1,56(sp)
    80005620:	f84a                	sd	s2,48(sp)
    80005622:	f44e                	sd	s3,40(sp)
    80005624:	f052                	sd	s4,32(sp)
    80005626:	ec56                	sd	s5,24(sp)
    80005628:	e85a                	sd	s6,16(sp)
    8000562a:	e45e                	sd	s7,8(sp)
    8000562c:	0880                	addi	s0,sp,80
    8000562e:	8a2e                	mv	s4,a1
  int last, lb;

  last = 1;
  lb = 0;
  for (int b = 0; b < len; b++) {
    80005630:	08b05b63          	blez	a1,800056c6 <bd_print_vector+0xae>
    80005634:	89aa                	mv	s3,a0
    80005636:	4481                	li	s1,0
  lb = 0;
    80005638:	4a81                	li	s5,0
  last = 1;
    8000563a:	4905                	li	s2,1
    if (last == bit_isset(vector, b)) continue;
    if (last == 1) printf(" [%d, %d)", lb, b);
    8000563c:	4b05                	li	s6,1
    8000563e:	00003b97          	auipc	s7,0x3
    80005642:	1aab8b93          	addi	s7,s7,426 # 800087e8 <syscalls+0x3e8>
    80005646:	a821                	j	8000565e <bd_print_vector+0x46>
    lb = b;
    last = bit_isset(vector, b);
    80005648:	85a6                	mv	a1,s1
    8000564a:	854e                	mv	a0,s3
    8000564c:	00000097          	auipc	ra,0x0
    80005650:	f00080e7          	jalr	-256(ra) # 8000554c <bit_isset>
    80005654:	892a                	mv	s2,a0
    80005656:	8aa6                	mv	s5,s1
  for (int b = 0; b < len; b++) {
    80005658:	2485                	addiw	s1,s1,1
    8000565a:	029a0463          	beq	s4,s1,80005682 <bd_print_vector+0x6a>
    if (last == bit_isset(vector, b)) continue;
    8000565e:	85a6                	mv	a1,s1
    80005660:	854e                	mv	a0,s3
    80005662:	00000097          	auipc	ra,0x0
    80005666:	eea080e7          	jalr	-278(ra) # 8000554c <bit_isset>
    8000566a:	ff2507e3          	beq	a0,s2,80005658 <bd_print_vector+0x40>
    if (last == 1) printf(" [%d, %d)", lb, b);
    8000566e:	fd691de3          	bne	s2,s6,80005648 <bd_print_vector+0x30>
    80005672:	8626                	mv	a2,s1
    80005674:	85d6                	mv	a1,s5
    80005676:	855e                	mv	a0,s7
    80005678:	00001097          	auipc	ra,0x1
    8000567c:	10a080e7          	jalr	266(ra) # 80006782 <printf>
    80005680:	b7e1                	j	80005648 <bd_print_vector+0x30>
  }
  if (lb == 0 || last == 1) {
    80005682:	000a8563          	beqz	s5,8000568c <bd_print_vector+0x74>
    80005686:	4785                	li	a5,1
    80005688:	00f91c63          	bne	s2,a5,800056a0 <bd_print_vector+0x88>
    printf(" [%d, %d)", lb, len);
    8000568c:	8652                	mv	a2,s4
    8000568e:	85d6                	mv	a1,s5
    80005690:	00003517          	auipc	a0,0x3
    80005694:	15850513          	addi	a0,a0,344 # 800087e8 <syscalls+0x3e8>
    80005698:	00001097          	auipc	ra,0x1
    8000569c:	0ea080e7          	jalr	234(ra) # 80006782 <printf>
  }
  printf("\n");
    800056a0:	00003517          	auipc	a0,0x3
    800056a4:	99850513          	addi	a0,a0,-1640 # 80008038 <etext+0x38>
    800056a8:	00001097          	auipc	ra,0x1
    800056ac:	0da080e7          	jalr	218(ra) # 80006782 <printf>
}
    800056b0:	60a6                	ld	ra,72(sp)
    800056b2:	6406                	ld	s0,64(sp)
    800056b4:	74e2                	ld	s1,56(sp)
    800056b6:	7942                	ld	s2,48(sp)
    800056b8:	79a2                	ld	s3,40(sp)
    800056ba:	7a02                	ld	s4,32(sp)
    800056bc:	6ae2                	ld	s5,24(sp)
    800056be:	6b42                	ld	s6,16(sp)
    800056c0:	6ba2                	ld	s7,8(sp)
    800056c2:	6161                	addi	sp,sp,80
    800056c4:	8082                	ret
  lb = 0;
    800056c6:	4a81                	li	s5,0
    800056c8:	b7d1                	j	8000568c <bd_print_vector+0x74>

00000000800056ca <bd_print>:

// Print buddy's data structures
void bd_print() {
  for (int k = 0; k < nsizes; k++) {
    800056ca:	00003697          	auipc	a3,0x3
    800056ce:	3566a683          	lw	a3,854(a3) # 80008a20 <nsizes>
    800056d2:	10d05063          	blez	a3,800057d2 <bd_print+0x108>
void bd_print() {
    800056d6:	711d                	addi	sp,sp,-96
    800056d8:	ec86                	sd	ra,88(sp)
    800056da:	e8a2                	sd	s0,80(sp)
    800056dc:	e4a6                	sd	s1,72(sp)
    800056de:	e0ca                	sd	s2,64(sp)
    800056e0:	fc4e                	sd	s3,56(sp)
    800056e2:	f852                	sd	s4,48(sp)
    800056e4:	f456                	sd	s5,40(sp)
    800056e6:	f05a                	sd	s6,32(sp)
    800056e8:	ec5e                	sd	s7,24(sp)
    800056ea:	e862                	sd	s8,16(sp)
    800056ec:	e466                	sd	s9,8(sp)
    800056ee:	e06a                	sd	s10,0(sp)
    800056f0:	1080                	addi	s0,sp,96
  for (int k = 0; k < nsizes; k++) {
    800056f2:	4481                	li	s1,0
    printf("size %d (blksz %d nblk %d): free list: ", k, BLK_SIZE(k), NBLK(k));
    800056f4:	4a85                	li	s5,1
    800056f6:	4c41                	li	s8,16
    800056f8:	00003b97          	auipc	s7,0x3
    800056fc:	100b8b93          	addi	s7,s7,256 # 800087f8 <syscalls+0x3f8>
    lst_print(&bd_sizes[k].free);
    80005700:	00003a17          	auipc	s4,0x3
    80005704:	318a0a13          	addi	s4,s4,792 # 80008a18 <bd_sizes>
    printf("  alloc:");
    80005708:	00003b17          	auipc	s6,0x3
    8000570c:	118b0b13          	addi	s6,s6,280 # 80008820 <syscalls+0x420>
    bd_print_vector(bd_sizes[k].alloc, NBLK(k));
    80005710:	00003997          	auipc	s3,0x3
    80005714:	31098993          	addi	s3,s3,784 # 80008a20 <nsizes>
    if (k > 0) {
      printf("  split:");
    80005718:	00003c97          	auipc	s9,0x3
    8000571c:	118c8c93          	addi	s9,s9,280 # 80008830 <syscalls+0x430>
    80005720:	a801                	j	80005730 <bd_print+0x66>
  for (int k = 0; k < nsizes; k++) {
    80005722:	0009a683          	lw	a3,0(s3)
    80005726:	0485                	addi	s1,s1,1
    80005728:	0004879b          	sext.w	a5,s1
    8000572c:	08d7d563          	bge	a5,a3,800057b6 <bd_print+0xec>
    80005730:	0004891b          	sext.w	s2,s1
    printf("size %d (blksz %d nblk %d): free list: ", k, BLK_SIZE(k), NBLK(k));
    80005734:	36fd                	addiw	a3,a3,-1
    80005736:	9e85                	subw	a3,a3,s1
    80005738:	00da96bb          	sllw	a3,s5,a3
    8000573c:	009c1633          	sll	a2,s8,s1
    80005740:	85ca                	mv	a1,s2
    80005742:	855e                	mv	a0,s7
    80005744:	00001097          	auipc	ra,0x1
    80005748:	03e080e7          	jalr	62(ra) # 80006782 <printf>
    lst_print(&bd_sizes[k].free);
    8000574c:	00549d13          	slli	s10,s1,0x5
    80005750:	000a3503          	ld	a0,0(s4)
    80005754:	956a                	add	a0,a0,s10
    80005756:	00001097          	auipc	ra,0x1
    8000575a:	a72080e7          	jalr	-1422(ra) # 800061c8 <lst_print>
    printf("  alloc:");
    8000575e:	855a                	mv	a0,s6
    80005760:	00001097          	auipc	ra,0x1
    80005764:	022080e7          	jalr	34(ra) # 80006782 <printf>
    bd_print_vector(bd_sizes[k].alloc, NBLK(k));
    80005768:	0009a583          	lw	a1,0(s3)
    8000576c:	35fd                	addiw	a1,a1,-1
    8000576e:	412585bb          	subw	a1,a1,s2
    80005772:	000a3783          	ld	a5,0(s4)
    80005776:	97ea                	add	a5,a5,s10
    80005778:	00ba95bb          	sllw	a1,s5,a1
    8000577c:	6b88                	ld	a0,16(a5)
    8000577e:	00000097          	auipc	ra,0x0
    80005782:	e9a080e7          	jalr	-358(ra) # 80005618 <bd_print_vector>
    if (k > 0) {
    80005786:	f9205ee3          	blez	s2,80005722 <bd_print+0x58>
      printf("  split:");
    8000578a:	8566                	mv	a0,s9
    8000578c:	00001097          	auipc	ra,0x1
    80005790:	ff6080e7          	jalr	-10(ra) # 80006782 <printf>
      bd_print_vector(bd_sizes[k].split, NBLK(k));
    80005794:	0009a583          	lw	a1,0(s3)
    80005798:	35fd                	addiw	a1,a1,-1
    8000579a:	412585bb          	subw	a1,a1,s2
    8000579e:	000a3783          	ld	a5,0(s4)
    800057a2:	9d3e                	add	s10,s10,a5
    800057a4:	00ba95bb          	sllw	a1,s5,a1
    800057a8:	018d3503          	ld	a0,24(s10) # fffffffffffff018 <end+0xffffffff7ffde128>
    800057ac:	00000097          	auipc	ra,0x0
    800057b0:	e6c080e7          	jalr	-404(ra) # 80005618 <bd_print_vector>
    800057b4:	b7bd                	j	80005722 <bd_print+0x58>
    }
  }
}
    800057b6:	60e6                	ld	ra,88(sp)
    800057b8:	6446                	ld	s0,80(sp)
    800057ba:	64a6                	ld	s1,72(sp)
    800057bc:	6906                	ld	s2,64(sp)
    800057be:	79e2                	ld	s3,56(sp)
    800057c0:	7a42                	ld	s4,48(sp)
    800057c2:	7aa2                	ld	s5,40(sp)
    800057c4:	7b02                	ld	s6,32(sp)
    800057c6:	6be2                	ld	s7,24(sp)
    800057c8:	6c42                	ld	s8,16(sp)
    800057ca:	6ca2                	ld	s9,8(sp)
    800057cc:	6d02                	ld	s10,0(sp)
    800057ce:	6125                	addi	sp,sp,96
    800057d0:	8082                	ret
    800057d2:	8082                	ret

00000000800057d4 <firstk>:

// What is the first k such that 2^k >= n?
int firstk(uint64 n) {
    800057d4:	1141                	addi	sp,sp,-16
    800057d6:	e422                	sd	s0,8(sp)
    800057d8:	0800                	addi	s0,sp,16
  int k = 0;
  uint64 size = LEAF_SIZE;

  while (size < n) {
    800057da:	47c1                	li	a5,16
    800057dc:	00a7fb63          	bgeu	a5,a0,800057f2 <firstk+0x1e>
    800057e0:	872a                	mv	a4,a0
  int k = 0;
    800057e2:	4501                	li	a0,0
    k++;
    800057e4:	2505                	addiw	a0,a0,1
    size *= 2;
    800057e6:	0786                	slli	a5,a5,0x1
  while (size < n) {
    800057e8:	fee7eee3          	bltu	a5,a4,800057e4 <firstk+0x10>
  }
  return k;
}
    800057ec:	6422                	ld	s0,8(sp)
    800057ee:	0141                	addi	sp,sp,16
    800057f0:	8082                	ret
  int k = 0;
    800057f2:	4501                	li	a0,0
    800057f4:	bfe5                	j	800057ec <firstk+0x18>

00000000800057f6 <blk_index>:

// Compute the block index for address p at size k
int blk_index(int k, char *p) {
    800057f6:	1141                	addi	sp,sp,-16
    800057f8:	e422                	sd	s0,8(sp)
    800057fa:	0800                	addi	s0,sp,16
  int n = p - (char *)bd_base;
  return n / BLK_SIZE(k);
    800057fc:	00003797          	auipc	a5,0x3
    80005800:	2147b783          	ld	a5,532(a5) # 80008a10 <bd_base>
    80005804:	9d9d                	subw	a1,a1,a5
    80005806:	47c1                	li	a5,16
    80005808:	00a797b3          	sll	a5,a5,a0
    8000580c:	02f5c5b3          	div	a1,a1,a5
}
    80005810:	0005851b          	sext.w	a0,a1
    80005814:	6422                	ld	s0,8(sp)
    80005816:	0141                	addi	sp,sp,16
    80005818:	8082                	ret

000000008000581a <addr>:

// Convert a block index at size k back into an address
void *addr(int k, int bi) {
    8000581a:	1141                	addi	sp,sp,-16
    8000581c:	e422                	sd	s0,8(sp)
    8000581e:	0800                	addi	s0,sp,16
  int n = bi * BLK_SIZE(k);
    80005820:	47c1                	li	a5,16
    80005822:	00a797b3          	sll	a5,a5,a0
  return (char *)bd_base + n;
    80005826:	02b787bb          	mulw	a5,a5,a1
}
    8000582a:	00003517          	auipc	a0,0x3
    8000582e:	1e653503          	ld	a0,486(a0) # 80008a10 <bd_base>
    80005832:	953e                	add	a0,a0,a5
    80005834:	6422                	ld	s0,8(sp)
    80005836:	0141                	addi	sp,sp,16
    80005838:	8082                	ret

000000008000583a <bd_malloc>:

// allocate nbytes, but malloc won't return anything smaller than LEAF_SIZE
void *bd_malloc(uint64 nbytes) {
    8000583a:	7159                	addi	sp,sp,-112
    8000583c:	f486                	sd	ra,104(sp)
    8000583e:	f0a2                	sd	s0,96(sp)
    80005840:	eca6                	sd	s1,88(sp)
    80005842:	e8ca                	sd	s2,80(sp)
    80005844:	e4ce                	sd	s3,72(sp)
    80005846:	e0d2                	sd	s4,64(sp)
    80005848:	fc56                	sd	s5,56(sp)
    8000584a:	f85a                	sd	s6,48(sp)
    8000584c:	f45e                	sd	s7,40(sp)
    8000584e:	f062                	sd	s8,32(sp)
    80005850:	ec66                	sd	s9,24(sp)
    80005852:	e86a                	sd	s10,16(sp)
    80005854:	e46e                	sd	s11,8(sp)
    80005856:	1880                	addi	s0,sp,112
    80005858:	84aa                	mv	s1,a0
  int fk, k;

  acquire(&lock);
    8000585a:	00013517          	auipc	a0,0x13
    8000585e:	43e50513          	addi	a0,a0,1086 # 80018c98 <lock>
    80005862:	00001097          	auipc	ra,0x1
    80005866:	412080e7          	jalr	1042(ra) # 80006c74 <acquire>

  // Find a free block >= nbytes, starting with smallest k possible
  fk = firstk(nbytes);
    8000586a:	8526                	mv	a0,s1
    8000586c:	00000097          	auipc	ra,0x0
    80005870:	f68080e7          	jalr	-152(ra) # 800057d4 <firstk>
  for (k = fk; k < nsizes; k++) {
    80005874:	00003797          	auipc	a5,0x3
    80005878:	1ac7a783          	lw	a5,428(a5) # 80008a20 <nsizes>
    8000587c:	02f55d63          	bge	a0,a5,800058b6 <bd_malloc+0x7c>
    80005880:	8baa                	mv	s7,a0
    80005882:	00551913          	slli	s2,a0,0x5
    80005886:	84aa                	mv	s1,a0
    if (!lst_empty(&bd_sizes[k].free)) break;
    80005888:	00003997          	auipc	s3,0x3
    8000588c:	19098993          	addi	s3,s3,400 # 80008a18 <bd_sizes>
  for (k = fk; k < nsizes; k++) {
    80005890:	00003a17          	auipc	s4,0x3
    80005894:	190a0a13          	addi	s4,s4,400 # 80008a20 <nsizes>
    if (!lst_empty(&bd_sizes[k].free)) break;
    80005898:	0009b503          	ld	a0,0(s3)
    8000589c:	954a                	add	a0,a0,s2
    8000589e:	00001097          	auipc	ra,0x1
    800058a2:	8b0080e7          	jalr	-1872(ra) # 8000614e <lst_empty>
    800058a6:	c115                	beqz	a0,800058ca <bd_malloc+0x90>
  for (k = fk; k < nsizes; k++) {
    800058a8:	2485                	addiw	s1,s1,1
    800058aa:	02090913          	addi	s2,s2,32
    800058ae:	000a2783          	lw	a5,0(s4)
    800058b2:	fef4c3e3          	blt	s1,a5,80005898 <bd_malloc+0x5e>
  }
  if (k >= nsizes) {  // No free blocks?
    release(&lock);
    800058b6:	00013517          	auipc	a0,0x13
    800058ba:	3e250513          	addi	a0,a0,994 # 80018c98 <lock>
    800058be:	00001097          	auipc	ra,0x1
    800058c2:	46a080e7          	jalr	1130(ra) # 80006d28 <release>
    return 0;
    800058c6:	4a81                	li	s5,0
    800058c8:	a8e9                	j	800059a2 <bd_malloc+0x168>
  if (k >= nsizes) {  // No free blocks?
    800058ca:	00003797          	auipc	a5,0x3
    800058ce:	1567a783          	lw	a5,342(a5) # 80008a20 <nsizes>
    800058d2:	fef4d2e3          	bge	s1,a5,800058b6 <bd_malloc+0x7c>
  }

  // Found a block; pop it and potentially split it.
  char *p = lst_pop(&bd_sizes[k].free);
    800058d6:	00549993          	slli	s3,s1,0x5
    800058da:	00003917          	auipc	s2,0x3
    800058de:	13e90913          	addi	s2,s2,318 # 80008a18 <bd_sizes>
    800058e2:	00093503          	ld	a0,0(s2)
    800058e6:	954e                	add	a0,a0,s3
    800058e8:	00001097          	auipc	ra,0x1
    800058ec:	892080e7          	jalr	-1902(ra) # 8000617a <lst_pop>
    800058f0:	8aaa                	mv	s5,a0
  return n / BLK_SIZE(k);
    800058f2:	00003597          	auipc	a1,0x3
    800058f6:	11e5b583          	ld	a1,286(a1) # 80008a10 <bd_base>
    800058fa:	40b505bb          	subw	a1,a0,a1
    800058fe:	47c1                	li	a5,16
    80005900:	009797b3          	sll	a5,a5,s1
    80005904:	02f5c5b3          	div	a1,a1,a5
  // bit_set(bd_sizes[k].alloc, blk_index(k, p));
  bit_invert(bd_sizes[k].alloc, blk_index(k, p) / 2);
    80005908:	01f5d79b          	srliw	a5,a1,0x1f
    8000590c:	9dbd                	addw	a1,a1,a5
    8000590e:	00093783          	ld	a5,0(s2)
    80005912:	97ce                	add	a5,a5,s3
    80005914:	4015d59b          	sraiw	a1,a1,0x1
    80005918:	6b88                	ld	a0,16(a5)
    8000591a:	00000097          	auipc	ra,0x0
    8000591e:	cce080e7          	jalr	-818(ra) # 800055e8 <bit_invert>
  for (; k > fk; k--) {
    80005922:	069bd863          	bge	s7,s1,80005992 <bd_malloc+0x158>
    // split a block at size k and mark one half allocated at size k-1
    // and put the buddy on the free list at size k-1
    char *q = p + BLK_SIZE(k - 1);  // p's buddy
    80005926:	4b41                	li	s6,16
    bit_set(bd_sizes[k].split, blk_index(k, p));
    80005928:	8d4a                	mv	s10,s2
  int n = p - (char *)bd_base;
    8000592a:	00003c97          	auipc	s9,0x3
    8000592e:	0e6c8c93          	addi	s9,s9,230 # 80008a10 <bd_base>
    char *q = p + BLK_SIZE(k - 1);  // p's buddy
    80005932:	85a6                	mv	a1,s1
    80005934:	34fd                	addiw	s1,s1,-1
    80005936:	009b1db3          	sll	s11,s6,s1
    8000593a:	01ba8c33          	add	s8,s5,s11
    bit_set(bd_sizes[k].split, blk_index(k, p));
    8000593e:	000d3a03          	ld	s4,0(s10)
  int n = p - (char *)bd_base;
    80005942:	000cb903          	ld	s2,0(s9)
  return n / BLK_SIZE(k);
    80005946:	412a893b          	subw	s2,s5,s2
    8000594a:	00bb15b3          	sll	a1,s6,a1
    8000594e:	02b945b3          	div	a1,s2,a1
    bit_set(bd_sizes[k].split, blk_index(k, p));
    80005952:	013a07b3          	add	a5,s4,s3
    80005956:	2581                	sext.w	a1,a1
    80005958:	6f88                	ld	a0,24(a5)
    8000595a:	00000097          	auipc	ra,0x0
    8000595e:	c2a080e7          	jalr	-982(ra) # 80005584 <bit_set>
    bit_invert(bd_sizes[k - 1].alloc, blk_index(k - 1, p) / 2);
    80005962:	1981                	addi	s3,s3,-32
    80005964:	9a4e                	add	s4,s4,s3
  return n / BLK_SIZE(k);
    80005966:	03b94933          	div	s2,s2,s11
    bit_invert(bd_sizes[k - 1].alloc, blk_index(k - 1, p) / 2);
    8000596a:	01f9559b          	srliw	a1,s2,0x1f
    8000596e:	012585bb          	addw	a1,a1,s2
    80005972:	4015d59b          	sraiw	a1,a1,0x1
    80005976:	010a3503          	ld	a0,16(s4)
    8000597a:	00000097          	auipc	ra,0x0
    8000597e:	c6e080e7          	jalr	-914(ra) # 800055e8 <bit_invert>
    lst_push(&bd_sizes[k - 1].free, q);
    80005982:	85e2                	mv	a1,s8
    80005984:	8552                	mv	a0,s4
    80005986:	00001097          	auipc	ra,0x1
    8000598a:	82a080e7          	jalr	-2006(ra) # 800061b0 <lst_push>
  for (; k > fk; k--) {
    8000598e:	fb7492e3          	bne	s1,s7,80005932 <bd_malloc+0xf8>
  }
  release(&lock);
    80005992:	00013517          	auipc	a0,0x13
    80005996:	30650513          	addi	a0,a0,774 # 80018c98 <lock>
    8000599a:	00001097          	auipc	ra,0x1
    8000599e:	38e080e7          	jalr	910(ra) # 80006d28 <release>

  return p;
}
    800059a2:	8556                	mv	a0,s5
    800059a4:	70a6                	ld	ra,104(sp)
    800059a6:	7406                	ld	s0,96(sp)
    800059a8:	64e6                	ld	s1,88(sp)
    800059aa:	6946                	ld	s2,80(sp)
    800059ac:	69a6                	ld	s3,72(sp)
    800059ae:	6a06                	ld	s4,64(sp)
    800059b0:	7ae2                	ld	s5,56(sp)
    800059b2:	7b42                	ld	s6,48(sp)
    800059b4:	7ba2                	ld	s7,40(sp)
    800059b6:	7c02                	ld	s8,32(sp)
    800059b8:	6ce2                	ld	s9,24(sp)
    800059ba:	6d42                	ld	s10,16(sp)
    800059bc:	6da2                	ld	s11,8(sp)
    800059be:	6165                	addi	sp,sp,112
    800059c0:	8082                	ret

00000000800059c2 <size>:

// Find the size of the block that p points to.
int size(char *p) {
    800059c2:	7139                	addi	sp,sp,-64
    800059c4:	fc06                	sd	ra,56(sp)
    800059c6:	f822                	sd	s0,48(sp)
    800059c8:	f426                	sd	s1,40(sp)
    800059ca:	f04a                	sd	s2,32(sp)
    800059cc:	ec4e                	sd	s3,24(sp)
    800059ce:	e852                	sd	s4,16(sp)
    800059d0:	e456                	sd	s5,8(sp)
    800059d2:	e05a                	sd	s6,0(sp)
    800059d4:	0080                	addi	s0,sp,64
  for (int k = 0; k < nsizes; k++) {
    800059d6:	00003a97          	auipc	s5,0x3
    800059da:	04aaaa83          	lw	s5,74(s5) # 80008a20 <nsizes>
  return n / BLK_SIZE(k);
    800059de:	00003a17          	auipc	s4,0x3
    800059e2:	032a3a03          	ld	s4,50(s4) # 80008a10 <bd_base>
    800059e6:	41450a3b          	subw	s4,a0,s4
    800059ea:	00003497          	auipc	s1,0x3
    800059ee:	02e4b483          	ld	s1,46(s1) # 80008a18 <bd_sizes>
    800059f2:	03848493          	addi	s1,s1,56
  for (int k = 0; k < nsizes; k++) {
    800059f6:	4901                	li	s2,0
  return n / BLK_SIZE(k);
    800059f8:	4b41                	li	s6,16
  for (int k = 0; k < nsizes; k++) {
    800059fa:	03595363          	bge	s2,s5,80005a20 <size+0x5e>
    if (bit_isset(bd_sizes[k + 1].split, blk_index(k + 1, p))) {
    800059fe:	0019099b          	addiw	s3,s2,1
  return n / BLK_SIZE(k);
    80005a02:	013b15b3          	sll	a1,s6,s3
    80005a06:	02ba45b3          	div	a1,s4,a1
    if (bit_isset(bd_sizes[k + 1].split, blk_index(k + 1, p))) {
    80005a0a:	2581                	sext.w	a1,a1
    80005a0c:	6088                	ld	a0,0(s1)
    80005a0e:	00000097          	auipc	ra,0x0
    80005a12:	b3e080e7          	jalr	-1218(ra) # 8000554c <bit_isset>
    80005a16:	02048493          	addi	s1,s1,32
    80005a1a:	e501                	bnez	a0,80005a22 <size+0x60>
  for (int k = 0; k < nsizes; k++) {
    80005a1c:	894e                	mv	s2,s3
    80005a1e:	bff1                	j	800059fa <size+0x38>
      return k;
    }
  }
  return 0;
    80005a20:	4901                	li	s2,0
}
    80005a22:	854a                	mv	a0,s2
    80005a24:	70e2                	ld	ra,56(sp)
    80005a26:	7442                	ld	s0,48(sp)
    80005a28:	74a2                	ld	s1,40(sp)
    80005a2a:	7902                	ld	s2,32(sp)
    80005a2c:	69e2                	ld	s3,24(sp)
    80005a2e:	6a42                	ld	s4,16(sp)
    80005a30:	6aa2                	ld	s5,8(sp)
    80005a32:	6b02                	ld	s6,0(sp)
    80005a34:	6121                	addi	sp,sp,64
    80005a36:	8082                	ret

0000000080005a38 <bd_free>:

// Free memory pointed to by p, which was earlier allocated using
// bd_malloc.
void bd_free(void *p) {
    80005a38:	7159                	addi	sp,sp,-112
    80005a3a:	f486                	sd	ra,104(sp)
    80005a3c:	f0a2                	sd	s0,96(sp)
    80005a3e:	eca6                	sd	s1,88(sp)
    80005a40:	e8ca                	sd	s2,80(sp)
    80005a42:	e4ce                	sd	s3,72(sp)
    80005a44:	e0d2                	sd	s4,64(sp)
    80005a46:	fc56                	sd	s5,56(sp)
    80005a48:	f85a                	sd	s6,48(sp)
    80005a4a:	f45e                	sd	s7,40(sp)
    80005a4c:	f062                	sd	s8,32(sp)
    80005a4e:	ec66                	sd	s9,24(sp)
    80005a50:	e86a                	sd	s10,16(sp)
    80005a52:	e46e                	sd	s11,8(sp)
    80005a54:	1880                	addi	s0,sp,112
    80005a56:	8c2a                	mv	s8,a0
  void *q;
  int k;

  acquire(&lock);
    80005a58:	00013517          	auipc	a0,0x13
    80005a5c:	24050513          	addi	a0,a0,576 # 80018c98 <lock>
    80005a60:	00001097          	auipc	ra,0x1
    80005a64:	214080e7          	jalr	532(ra) # 80006c74 <acquire>
  for (k = size(p); k < MAXSIZE; k++) {
    80005a68:	8562                	mv	a0,s8
    80005a6a:	00000097          	auipc	ra,0x0
    80005a6e:	f58080e7          	jalr	-168(ra) # 800059c2 <size>
    80005a72:	89aa                	mv	s3,a0
    80005a74:	00003797          	auipc	a5,0x3
    80005a78:	fac7a783          	lw	a5,-84(a5) # 80008a20 <nsizes>
    80005a7c:	37fd                	addiw	a5,a5,-1
    80005a7e:	0cf55263          	bge	a0,a5,80005b42 <bd_free+0x10a>
    80005a82:	00150b93          	addi	s7,a0,1
    80005a86:	0b96                	slli	s7,s7,0x5
  int n = p - (char *)bd_base;
    80005a88:	00003d97          	auipc	s11,0x3
    80005a8c:	f88d8d93          	addi	s11,s11,-120 # 80008a10 <bd_base>
  return n / BLK_SIZE(k);
    80005a90:	4d41                	li	s10,16
    int bi = blk_index(k, p);
    int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    bit_invert(bd_sizes[k].alloc, buddy / 2);
    80005a92:	00003c97          	auipc	s9,0x3
    80005a96:	f86c8c93          	addi	s9,s9,-122 # 80008a18 <bd_sizes>
    80005a9a:	a83d                	j	80005ad8 <bd_free+0xa0>
    int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    80005a9c:	397d                	addiw	s2,s2,-1
    80005a9e:	a891                	j	80005af2 <bd_free+0xba>
    if (buddy % 2 == 0) {
      p = q;
    }
    // at size k+1, mark that the merged buddy pair isn't split
    // anymore
    bit_clear(bd_sizes[k + 1].split, blk_index(k + 1, p));
    80005aa0:	2985                	addiw	s3,s3,1
  int n = p - (char *)bd_base;
    80005aa2:	000db583          	ld	a1,0(s11)
  return n / BLK_SIZE(k);
    80005aa6:	40bc05bb          	subw	a1,s8,a1
    80005aaa:	013d17b3          	sll	a5,s10,s3
    80005aae:	02f5c5b3          	div	a1,a1,a5
    bit_clear(bd_sizes[k + 1].split, blk_index(k + 1, p));
    80005ab2:	000cb783          	ld	a5,0(s9)
    80005ab6:	97de                	add	a5,a5,s7
    80005ab8:	2581                	sext.w	a1,a1
    80005aba:	6f88                	ld	a0,24(a5)
    80005abc:	00000097          	auipc	ra,0x0
    80005ac0:	af8080e7          	jalr	-1288(ra) # 800055b4 <bit_clear>
  for (k = size(p); k < MAXSIZE; k++) {
    80005ac4:	020b8b93          	addi	s7,s7,32
    80005ac8:	00003797          	auipc	a5,0x3
    80005acc:	f5878793          	addi	a5,a5,-168 # 80008a20 <nsizes>
    80005ad0:	439c                	lw	a5,0(a5)
    80005ad2:	37fd                	addiw	a5,a5,-1
    80005ad4:	06f9d763          	bge	s3,a5,80005b42 <bd_free+0x10a>
  int n = p - (char *)bd_base;
    80005ad8:	000dba03          	ld	s4,0(s11)
  return n / BLK_SIZE(k);
    80005adc:	013d1b33          	sll	s6,s10,s3
    80005ae0:	414c07bb          	subw	a5,s8,s4
    80005ae4:	0367c7b3          	div	a5,a5,s6
    80005ae8:	0007891b          	sext.w	s2,a5
    int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    80005aec:	8b85                	andi	a5,a5,1
    80005aee:	f7dd                	bnez	a5,80005a9c <bd_free+0x64>
    80005af0:	2905                	addiw	s2,s2,1
    bit_invert(bd_sizes[k].alloc, buddy / 2);
    80005af2:	fe0b8a93          	addi	s5,s7,-32
    80005af6:	000cb783          	ld	a5,0(s9)
    80005afa:	9abe                	add	s5,s5,a5
    80005afc:	01f9549b          	srliw	s1,s2,0x1f
    80005b00:	012484bb          	addw	s1,s1,s2
    80005b04:	4014d49b          	sraiw	s1,s1,0x1
    80005b08:	85a6                	mv	a1,s1
    80005b0a:	010ab503          	ld	a0,16(s5)
    80005b0e:	00000097          	auipc	ra,0x0
    80005b12:	ada080e7          	jalr	-1318(ra) # 800055e8 <bit_invert>
    if (bit_isset(bd_sizes[k].alloc, buddy / 2)) {  // is buddy allocated?
    80005b16:	85a6                	mv	a1,s1
    80005b18:	010ab503          	ld	a0,16(s5)
    80005b1c:	00000097          	auipc	ra,0x0
    80005b20:	a30080e7          	jalr	-1488(ra) # 8000554c <bit_isset>
    80005b24:	ed19                	bnez	a0,80005b42 <bd_free+0x10a>
  int n = bi * BLK_SIZE(k);
    80005b26:	0009049b          	sext.w	s1,s2
  return (char *)bd_base + n;
    80005b2a:	032b093b          	mulw	s2,s6,s2
    80005b2e:	9a4a                	add	s4,s4,s2
    lst_remove(q);  // remove buddy from free list
    80005b30:	8552                	mv	a0,s4
    80005b32:	00000097          	auipc	ra,0x0
    80005b36:	632080e7          	jalr	1586(ra) # 80006164 <lst_remove>
    if (buddy % 2 == 0) {
    80005b3a:	8885                	andi	s1,s1,1
    80005b3c:	f0b5                	bnez	s1,80005aa0 <bd_free+0x68>
      p = q;
    80005b3e:	8c52                	mv	s8,s4
    80005b40:	b785                	j	80005aa0 <bd_free+0x68>
  }
  lst_push(&bd_sizes[k].free, p);
    80005b42:	0996                	slli	s3,s3,0x5
    80005b44:	85e2                	mv	a1,s8
    80005b46:	00003517          	auipc	a0,0x3
    80005b4a:	ed253503          	ld	a0,-302(a0) # 80008a18 <bd_sizes>
    80005b4e:	954e                	add	a0,a0,s3
    80005b50:	00000097          	auipc	ra,0x0
    80005b54:	660080e7          	jalr	1632(ra) # 800061b0 <lst_push>
  release(&lock);
    80005b58:	00013517          	auipc	a0,0x13
    80005b5c:	14050513          	addi	a0,a0,320 # 80018c98 <lock>
    80005b60:	00001097          	auipc	ra,0x1
    80005b64:	1c8080e7          	jalr	456(ra) # 80006d28 <release>
}
    80005b68:	70a6                	ld	ra,104(sp)
    80005b6a:	7406                	ld	s0,96(sp)
    80005b6c:	64e6                	ld	s1,88(sp)
    80005b6e:	6946                	ld	s2,80(sp)
    80005b70:	69a6                	ld	s3,72(sp)
    80005b72:	6a06                	ld	s4,64(sp)
    80005b74:	7ae2                	ld	s5,56(sp)
    80005b76:	7b42                	ld	s6,48(sp)
    80005b78:	7ba2                	ld	s7,40(sp)
    80005b7a:	7c02                	ld	s8,32(sp)
    80005b7c:	6ce2                	ld	s9,24(sp)
    80005b7e:	6d42                	ld	s10,16(sp)
    80005b80:	6da2                	ld	s11,8(sp)
    80005b82:	6165                	addi	sp,sp,112
    80005b84:	8082                	ret

0000000080005b86 <blk_index_next>:

// Compute the first block at size k that doesn't contain p
int blk_index_next(int k, char *p) {
    80005b86:	1141                	addi	sp,sp,-16
    80005b88:	e422                	sd	s0,8(sp)
    80005b8a:	0800                	addi	s0,sp,16
  int n = (p - (char *)bd_base) / BLK_SIZE(k);
    80005b8c:	00003797          	auipc	a5,0x3
    80005b90:	e847b783          	ld	a5,-380(a5) # 80008a10 <bd_base>
    80005b94:	8d9d                	sub	a1,a1,a5
    80005b96:	47c1                	li	a5,16
    80005b98:	00a797b3          	sll	a5,a5,a0
    80005b9c:	02f5c533          	div	a0,a1,a5
    80005ba0:	2501                	sext.w	a0,a0
  if ((p - (char *)bd_base) % BLK_SIZE(k) != 0) n++;
    80005ba2:	02f5e5b3          	rem	a1,a1,a5
    80005ba6:	c191                	beqz	a1,80005baa <blk_index_next+0x24>
    80005ba8:	2505                	addiw	a0,a0,1
  return n;
}
    80005baa:	6422                	ld	s0,8(sp)
    80005bac:	0141                	addi	sp,sp,16
    80005bae:	8082                	ret

0000000080005bb0 <log2>:

int log2(uint64 n) {
    80005bb0:	1141                	addi	sp,sp,-16
    80005bb2:	e422                	sd	s0,8(sp)
    80005bb4:	0800                	addi	s0,sp,16
  int k = 0;
  while (n > 1) {
    80005bb6:	4705                	li	a4,1
    80005bb8:	00a77b63          	bgeu	a4,a0,80005bce <log2+0x1e>
    80005bbc:	87aa                	mv	a5,a0
  int k = 0;
    80005bbe:	4501                	li	a0,0
    k++;
    80005bc0:	2505                	addiw	a0,a0,1
    n = n >> 1;
    80005bc2:	8385                	srli	a5,a5,0x1
  while (n > 1) {
    80005bc4:	fef76ee3          	bltu	a4,a5,80005bc0 <log2+0x10>
  }
  return k;
}
    80005bc8:	6422                	ld	s0,8(sp)
    80005bca:	0141                	addi	sp,sp,16
    80005bcc:	8082                	ret
  int k = 0;
    80005bce:	4501                	li	a0,0
    80005bd0:	bfe5                	j	80005bc8 <log2+0x18>

0000000080005bd2 <bd_mark>:

// Mark memory from [start, stop), starting at size 0, as allocated.
void bd_mark(void *start, void *stop) {
    80005bd2:	711d                	addi	sp,sp,-96
    80005bd4:	ec86                	sd	ra,88(sp)
    80005bd6:	e8a2                	sd	s0,80(sp)
    80005bd8:	e4a6                	sd	s1,72(sp)
    80005bda:	e0ca                	sd	s2,64(sp)
    80005bdc:	fc4e                	sd	s3,56(sp)
    80005bde:	f852                	sd	s4,48(sp)
    80005be0:	f456                	sd	s5,40(sp)
    80005be2:	f05a                	sd	s6,32(sp)
    80005be4:	ec5e                	sd	s7,24(sp)
    80005be6:	e862                	sd	s8,16(sp)
    80005be8:	e466                	sd	s9,8(sp)
    80005bea:	e06a                	sd	s10,0(sp)
    80005bec:	1080                	addi	s0,sp,96
  int bi, bj;

  if (((uint64)start % LEAF_SIZE != 0) || ((uint64)stop % LEAF_SIZE != 0))
    80005bee:	00b56933          	or	s2,a0,a1
    80005bf2:	00f97913          	andi	s2,s2,15
    80005bf6:	04091263          	bnez	s2,80005c3a <bd_mark+0x68>
    80005bfa:	8b2a                	mv	s6,a0
    80005bfc:	8bae                	mv	s7,a1
    panic("bd_mark");

  for (int k = 0; k < nsizes; k++) {
    80005bfe:	00003c17          	auipc	s8,0x3
    80005c02:	e22c2c03          	lw	s8,-478(s8) # 80008a20 <nsizes>
    80005c06:	4981                	li	s3,0
  int n = p - (char *)bd_base;
    80005c08:	00003d17          	auipc	s10,0x3
    80005c0c:	e08d0d13          	addi	s10,s10,-504 # 80008a10 <bd_base>
  return n / BLK_SIZE(k);
    80005c10:	4cc1                	li	s9,16
    bi = blk_index(k, start);
    bj = blk_index_next(k, stop);
    for (; bi < bj; bi++) {
      if (k > 0) {
        // if a block is allocated at size k, mark it as split too.
        bit_set(bd_sizes[k].split, bi);
    80005c12:	00003a97          	auipc	s5,0x3
    80005c16:	e06a8a93          	addi	s5,s5,-506 # 80008a18 <bd_sizes>
  for (int k = 0; k < nsizes; k++) {
    80005c1a:	07804963          	bgtz	s8,80005c8c <bd_mark+0xba>
      }
      bit_invert(bd_sizes[k].alloc, bi / 2);
    }
  }
}
    80005c1e:	60e6                	ld	ra,88(sp)
    80005c20:	6446                	ld	s0,80(sp)
    80005c22:	64a6                	ld	s1,72(sp)
    80005c24:	6906                	ld	s2,64(sp)
    80005c26:	79e2                	ld	s3,56(sp)
    80005c28:	7a42                	ld	s4,48(sp)
    80005c2a:	7aa2                	ld	s5,40(sp)
    80005c2c:	7b02                	ld	s6,32(sp)
    80005c2e:	6be2                	ld	s7,24(sp)
    80005c30:	6c42                	ld	s8,16(sp)
    80005c32:	6ca2                	ld	s9,8(sp)
    80005c34:	6d02                	ld	s10,0(sp)
    80005c36:	6125                	addi	sp,sp,96
    80005c38:	8082                	ret
    panic("bd_mark");
    80005c3a:	00003517          	auipc	a0,0x3
    80005c3e:	c0650513          	addi	a0,a0,-1018 # 80008840 <syscalls+0x440>
    80005c42:	00001097          	auipc	ra,0x1
    80005c46:	af6080e7          	jalr	-1290(ra) # 80006738 <panic>
      bit_invert(bd_sizes[k].alloc, bi / 2);
    80005c4a:	01f4d59b          	srliw	a1,s1,0x1f
    80005c4e:	9da5                	addw	a1,a1,s1
    80005c50:	000ab783          	ld	a5,0(s5)
    80005c54:	97ca                	add	a5,a5,s2
    80005c56:	4015d59b          	sraiw	a1,a1,0x1
    80005c5a:	6b88                	ld	a0,16(a5)
    80005c5c:	00000097          	auipc	ra,0x0
    80005c60:	98c080e7          	jalr	-1652(ra) # 800055e8 <bit_invert>
    for (; bi < bj; bi++) {
    80005c64:	2485                	addiw	s1,s1,1
    80005c66:	009a0e63          	beq	s4,s1,80005c82 <bd_mark+0xb0>
      if (k > 0) {
    80005c6a:	ff3050e3          	blez	s3,80005c4a <bd_mark+0x78>
        bit_set(bd_sizes[k].split, bi);
    80005c6e:	000ab783          	ld	a5,0(s5)
    80005c72:	97ca                	add	a5,a5,s2
    80005c74:	85a6                	mv	a1,s1
    80005c76:	6f88                	ld	a0,24(a5)
    80005c78:	00000097          	auipc	ra,0x0
    80005c7c:	90c080e7          	jalr	-1780(ra) # 80005584 <bit_set>
    80005c80:	b7e9                	j	80005c4a <bd_mark+0x78>
  for (int k = 0; k < nsizes; k++) {
    80005c82:	2985                	addiw	s3,s3,1
    80005c84:	02090913          	addi	s2,s2,32
    80005c88:	f9898be3          	beq	s3,s8,80005c1e <bd_mark+0x4c>
  int n = p - (char *)bd_base;
    80005c8c:	000d3483          	ld	s1,0(s10)
  return n / BLK_SIZE(k);
    80005c90:	409b04bb          	subw	s1,s6,s1
    80005c94:	013c97b3          	sll	a5,s9,s3
    80005c98:	02f4c4b3          	div	s1,s1,a5
    80005c9c:	2481                	sext.w	s1,s1
    bj = blk_index_next(k, stop);
    80005c9e:	85de                	mv	a1,s7
    80005ca0:	854e                	mv	a0,s3
    80005ca2:	00000097          	auipc	ra,0x0
    80005ca6:	ee4080e7          	jalr	-284(ra) # 80005b86 <blk_index_next>
    80005caa:	8a2a                	mv	s4,a0
    for (; bi < bj; bi++) {
    80005cac:	faa4cfe3          	blt	s1,a0,80005c6a <bd_mark+0x98>
    80005cb0:	bfc9                	j	80005c82 <bd_mark+0xb0>

0000000080005cb2 <bd_initfree_pair>:

// If a block is marked as allocated and the buddy is free, put the
// buddy on the free list at size k.
int bd_initfree_pair(int k, int bi, int is_right) {
    80005cb2:	7139                	addi	sp,sp,-64
    80005cb4:	fc06                	sd	ra,56(sp)
    80005cb6:	f822                	sd	s0,48(sp)
    80005cb8:	f426                	sd	s1,40(sp)
    80005cba:	f04a                	sd	s2,32(sp)
    80005cbc:	ec4e                	sd	s3,24(sp)
    80005cbe:	e852                	sd	s4,16(sp)
    80005cc0:	e456                	sd	s5,8(sp)
    80005cc2:	e05a                	sd	s6,0(sp)
    80005cc4:	0080                	addi	s0,sp,64
    80005cc6:	89aa                	mv	s3,a0
    80005cc8:	8a32                	mv	s4,a2
  int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    80005cca:	00058a9b          	sext.w	s5,a1
    80005cce:	0015f793          	andi	a5,a1,1
    80005cd2:	e7ad                	bnez	a5,80005d3c <bd_initfree_pair+0x8a>
    80005cd4:	00158b1b          	addiw	s6,a1,1
  int free = 0;
  if (bit_isset(bd_sizes[k].alloc, bi / 2)) {
    80005cd8:	00599913          	slli	s2,s3,0x5
    80005cdc:	00003797          	auipc	a5,0x3
    80005ce0:	d3c7b783          	ld	a5,-708(a5) # 80008a18 <bd_sizes>
    80005ce4:	993e                	add	s2,s2,a5
    80005ce6:	01f5d79b          	srliw	a5,a1,0x1f
    80005cea:	9dbd                	addw	a1,a1,a5
    80005cec:	4015d59b          	sraiw	a1,a1,0x1
    80005cf0:	01093503          	ld	a0,16(s2)
    80005cf4:	00000097          	auipc	ra,0x0
    80005cf8:	858080e7          	jalr	-1960(ra) # 8000554c <bit_isset>
    80005cfc:	84aa                	mv	s1,a0
    80005cfe:	c505                	beqz	a0,80005d26 <bd_initfree_pair+0x74>
    // one of the pair is free
    free = BLK_SIZE(k);
    80005d00:	45c1                	li	a1,16
    80005d02:	013599b3          	sll	s3,a1,s3
    80005d06:	0009849b          	sext.w	s1,s3
    if (is_right)
    80005d0a:	020a0c63          	beqz	s4,80005d42 <bd_initfree_pair+0x90>
  return (char *)bd_base + n;
    80005d0e:	036989bb          	mulw	s3,s3,s6
      lst_push(&bd_sizes[k].free, addr(k, buddy));  // put buddy on free list
    80005d12:	00003597          	auipc	a1,0x3
    80005d16:	cfe5b583          	ld	a1,-770(a1) # 80008a10 <bd_base>
    80005d1a:	95ce                	add	a1,a1,s3
    80005d1c:	854a                	mv	a0,s2
    80005d1e:	00000097          	auipc	ra,0x0
    80005d22:	492080e7          	jalr	1170(ra) # 800061b0 <lst_push>
    else
      lst_push(&bd_sizes[k].free, addr(k, bi));  // put bi on free list
  }
  return free;
}
    80005d26:	8526                	mv	a0,s1
    80005d28:	70e2                	ld	ra,56(sp)
    80005d2a:	7442                	ld	s0,48(sp)
    80005d2c:	74a2                	ld	s1,40(sp)
    80005d2e:	7902                	ld	s2,32(sp)
    80005d30:	69e2                	ld	s3,24(sp)
    80005d32:	6a42                	ld	s4,16(sp)
    80005d34:	6aa2                	ld	s5,8(sp)
    80005d36:	6b02                	ld	s6,0(sp)
    80005d38:	6121                	addi	sp,sp,64
    80005d3a:	8082                	ret
  int buddy = (bi % 2 == 0) ? bi + 1 : bi - 1;
    80005d3c:	fff58b1b          	addiw	s6,a1,-1
    80005d40:	bf61                	j	80005cd8 <bd_initfree_pair+0x26>
  return (char *)bd_base + n;
    80005d42:	035989bb          	mulw	s3,s3,s5
      lst_push(&bd_sizes[k].free, addr(k, bi));  // put bi on free list
    80005d46:	00003597          	auipc	a1,0x3
    80005d4a:	cca5b583          	ld	a1,-822(a1) # 80008a10 <bd_base>
    80005d4e:	95ce                	add	a1,a1,s3
    80005d50:	854a                	mv	a0,s2
    80005d52:	00000097          	auipc	ra,0x0
    80005d56:	45e080e7          	jalr	1118(ra) # 800061b0 <lst_push>
    80005d5a:	b7f1                	j	80005d26 <bd_initfree_pair+0x74>

0000000080005d5c <bd_initfree>:

// Initialize the free lists for each size k.  For each size k, there
// are only two pairs that may have a buddy that should be on free list:
// bd_left and bd_right.
int bd_initfree(void *bd_left, void *bd_right) {
    80005d5c:	711d                	addi	sp,sp,-96
    80005d5e:	ec86                	sd	ra,88(sp)
    80005d60:	e8a2                	sd	s0,80(sp)
    80005d62:	e4a6                	sd	s1,72(sp)
    80005d64:	e0ca                	sd	s2,64(sp)
    80005d66:	fc4e                	sd	s3,56(sp)
    80005d68:	f852                	sd	s4,48(sp)
    80005d6a:	f456                	sd	s5,40(sp)
    80005d6c:	f05a                	sd	s6,32(sp)
    80005d6e:	ec5e                	sd	s7,24(sp)
    80005d70:	e862                	sd	s8,16(sp)
    80005d72:	e466                	sd	s9,8(sp)
    80005d74:	e06a                	sd	s10,0(sp)
    80005d76:	1080                	addi	s0,sp,96
  int free = 0;

  for (int k = 0; k < MAXSIZE; k++) {  // skip max size
    80005d78:	00003717          	auipc	a4,0x3
    80005d7c:	ca872703          	lw	a4,-856(a4) # 80008a20 <nsizes>
    80005d80:	4785                	li	a5,1
    80005d82:	06e7dd63          	bge	a5,a4,80005dfc <bd_initfree+0xa0>
    80005d86:	8aaa                	mv	s5,a0
    80005d88:	8b2e                	mv	s6,a1
    80005d8a:	4901                	li	s2,0
  int free = 0;
    80005d8c:	4a01                	li	s4,0
  int n = p - (char *)bd_base;
    80005d8e:	00003c97          	auipc	s9,0x3
    80005d92:	c82c8c93          	addi	s9,s9,-894 # 80008a10 <bd_base>
  return n / BLK_SIZE(k);
    80005d96:	4c41                	li	s8,16
  for (int k = 0; k < MAXSIZE; k++) {  // skip max size
    80005d98:	00003b97          	auipc	s7,0x3
    80005d9c:	c88b8b93          	addi	s7,s7,-888 # 80008a20 <nsizes>
    80005da0:	a039                	j	80005dae <bd_initfree+0x52>
    80005da2:	2905                	addiw	s2,s2,1
    80005da4:	000ba783          	lw	a5,0(s7)
    80005da8:	37fd                	addiw	a5,a5,-1
    80005daa:	04f95a63          	bge	s2,a5,80005dfe <bd_initfree+0xa2>
    int left = blk_index_next(k, bd_left);
    80005dae:	85d6                	mv	a1,s5
    80005db0:	854a                	mv	a0,s2
    80005db2:	00000097          	auipc	ra,0x0
    80005db6:	dd4080e7          	jalr	-556(ra) # 80005b86 <blk_index_next>
    80005dba:	89aa                	mv	s3,a0
  int n = p - (char *)bd_base;
    80005dbc:	000cb483          	ld	s1,0(s9)
  return n / BLK_SIZE(k);
    80005dc0:	409b04bb          	subw	s1,s6,s1
    80005dc4:	012c17b3          	sll	a5,s8,s2
    80005dc8:	02f4c4b3          	div	s1,s1,a5
    80005dcc:	2481                	sext.w	s1,s1
    int right = blk_index(k, bd_right);
    free += bd_initfree_pair(k, left, 0);
    80005dce:	4601                	li	a2,0
    80005dd0:	85aa                	mv	a1,a0
    80005dd2:	854a                	mv	a0,s2
    80005dd4:	00000097          	auipc	ra,0x0
    80005dd8:	ede080e7          	jalr	-290(ra) # 80005cb2 <bd_initfree_pair>
    80005ddc:	01450d3b          	addw	s10,a0,s4
    80005de0:	000d0a1b          	sext.w	s4,s10
    if (right <= left) continue;
    80005de4:	fa99dfe3          	bge	s3,s1,80005da2 <bd_initfree+0x46>
    free += bd_initfree_pair(k, right, 1);
    80005de8:	4605                	li	a2,1
    80005dea:	85a6                	mv	a1,s1
    80005dec:	854a                	mv	a0,s2
    80005dee:	00000097          	auipc	ra,0x0
    80005df2:	ec4080e7          	jalr	-316(ra) # 80005cb2 <bd_initfree_pair>
    80005df6:	00ad0a3b          	addw	s4,s10,a0
    80005dfa:	b765                	j	80005da2 <bd_initfree+0x46>
  int free = 0;
    80005dfc:	4a01                	li	s4,0
  }
  return free;
}
    80005dfe:	8552                	mv	a0,s4
    80005e00:	60e6                	ld	ra,88(sp)
    80005e02:	6446                	ld	s0,80(sp)
    80005e04:	64a6                	ld	s1,72(sp)
    80005e06:	6906                	ld	s2,64(sp)
    80005e08:	79e2                	ld	s3,56(sp)
    80005e0a:	7a42                	ld	s4,48(sp)
    80005e0c:	7aa2                	ld	s5,40(sp)
    80005e0e:	7b02                	ld	s6,32(sp)
    80005e10:	6be2                	ld	s7,24(sp)
    80005e12:	6c42                	ld	s8,16(sp)
    80005e14:	6ca2                	ld	s9,8(sp)
    80005e16:	6d02                	ld	s10,0(sp)
    80005e18:	6125                	addi	sp,sp,96
    80005e1a:	8082                	ret

0000000080005e1c <bd_mark_data_structures>:

// Mark the range [bd_base,p) as allocated
int bd_mark_data_structures(char *p) {
    80005e1c:	7179                	addi	sp,sp,-48
    80005e1e:	f406                	sd	ra,40(sp)
    80005e20:	f022                	sd	s0,32(sp)
    80005e22:	ec26                	sd	s1,24(sp)
    80005e24:	e84a                	sd	s2,16(sp)
    80005e26:	e44e                	sd	s3,8(sp)
    80005e28:	1800                	addi	s0,sp,48
    80005e2a:	892a                	mv	s2,a0
  int meta = p - (char *)bd_base;
    80005e2c:	00003997          	auipc	s3,0x3
    80005e30:	be498993          	addi	s3,s3,-1052 # 80008a10 <bd_base>
    80005e34:	0009b483          	ld	s1,0(s3)
    80005e38:	409504bb          	subw	s1,a0,s1
  printf("bd: %d meta bytes for managing %d bytes of memory\n", meta,
         BLK_SIZE(MAXSIZE));
    80005e3c:	00003797          	auipc	a5,0x3
    80005e40:	be47a783          	lw	a5,-1052(a5) # 80008a20 <nsizes>
    80005e44:	37fd                	addiw	a5,a5,-1
  printf("bd: %d meta bytes for managing %d bytes of memory\n", meta,
    80005e46:	4641                	li	a2,16
    80005e48:	00f61633          	sll	a2,a2,a5
    80005e4c:	85a6                	mv	a1,s1
    80005e4e:	00003517          	auipc	a0,0x3
    80005e52:	9fa50513          	addi	a0,a0,-1542 # 80008848 <syscalls+0x448>
    80005e56:	00001097          	auipc	ra,0x1
    80005e5a:	92c080e7          	jalr	-1748(ra) # 80006782 <printf>
  bd_mark(bd_base, p);
    80005e5e:	85ca                	mv	a1,s2
    80005e60:	0009b503          	ld	a0,0(s3)
    80005e64:	00000097          	auipc	ra,0x0
    80005e68:	d6e080e7          	jalr	-658(ra) # 80005bd2 <bd_mark>
  return meta;
}
    80005e6c:	8526                	mv	a0,s1
    80005e6e:	70a2                	ld	ra,40(sp)
    80005e70:	7402                	ld	s0,32(sp)
    80005e72:	64e2                	ld	s1,24(sp)
    80005e74:	6942                	ld	s2,16(sp)
    80005e76:	69a2                	ld	s3,8(sp)
    80005e78:	6145                	addi	sp,sp,48
    80005e7a:	8082                	ret

0000000080005e7c <bd_mark_unavailable>:

// Mark the range [end, HEAPSIZE) as allocated
int bd_mark_unavailable(void *end, void *left) {
    80005e7c:	1101                	addi	sp,sp,-32
    80005e7e:	ec06                	sd	ra,24(sp)
    80005e80:	e822                	sd	s0,16(sp)
    80005e82:	e426                	sd	s1,8(sp)
    80005e84:	1000                	addi	s0,sp,32
  int unavailable = BLK_SIZE(MAXSIZE) - (end - bd_base);
    80005e86:	00003497          	auipc	s1,0x3
    80005e8a:	b9a4a483          	lw	s1,-1126(s1) # 80008a20 <nsizes>
    80005e8e:	fff4879b          	addiw	a5,s1,-1
    80005e92:	44c1                	li	s1,16
    80005e94:	00f494b3          	sll	s1,s1,a5
    80005e98:	00003797          	auipc	a5,0x3
    80005e9c:	b787b783          	ld	a5,-1160(a5) # 80008a10 <bd_base>
    80005ea0:	8d1d                	sub	a0,a0,a5
    80005ea2:	40a4853b          	subw	a0,s1,a0
    80005ea6:	0005049b          	sext.w	s1,a0
  if (unavailable > 0) unavailable = ROUNDUP(unavailable, LEAF_SIZE);
    80005eaa:	00905a63          	blez	s1,80005ebe <bd_mark_unavailable+0x42>
    80005eae:	357d                	addiw	a0,a0,-1
    80005eb0:	41f5549b          	sraiw	s1,a0,0x1f
    80005eb4:	01c4d49b          	srliw	s1,s1,0x1c
    80005eb8:	9ca9                	addw	s1,s1,a0
    80005eba:	98c1                	andi	s1,s1,-16
    80005ebc:	24c1                	addiw	s1,s1,16
  printf("bd: 0x%x bytes unavailable\n", unavailable);
    80005ebe:	85a6                	mv	a1,s1
    80005ec0:	00003517          	auipc	a0,0x3
    80005ec4:	9c050513          	addi	a0,a0,-1600 # 80008880 <syscalls+0x480>
    80005ec8:	00001097          	auipc	ra,0x1
    80005ecc:	8ba080e7          	jalr	-1862(ra) # 80006782 <printf>

  void *bd_end = bd_base + BLK_SIZE(MAXSIZE) - unavailable;
    80005ed0:	00003717          	auipc	a4,0x3
    80005ed4:	b4073703          	ld	a4,-1216(a4) # 80008a10 <bd_base>
    80005ed8:	00003597          	auipc	a1,0x3
    80005edc:	b485a583          	lw	a1,-1208(a1) # 80008a20 <nsizes>
    80005ee0:	fff5879b          	addiw	a5,a1,-1
    80005ee4:	45c1                	li	a1,16
    80005ee6:	00f595b3          	sll	a1,a1,a5
    80005eea:	40958533          	sub	a0,a1,s1
  bd_mark(bd_end, bd_base + BLK_SIZE(MAXSIZE));
    80005eee:	95ba                	add	a1,a1,a4
    80005ef0:	953a                	add	a0,a0,a4
    80005ef2:	00000097          	auipc	ra,0x0
    80005ef6:	ce0080e7          	jalr	-800(ra) # 80005bd2 <bd_mark>
  return unavailable;
}
    80005efa:	8526                	mv	a0,s1
    80005efc:	60e2                	ld	ra,24(sp)
    80005efe:	6442                	ld	s0,16(sp)
    80005f00:	64a2                	ld	s1,8(sp)
    80005f02:	6105                	addi	sp,sp,32
    80005f04:	8082                	ret

0000000080005f06 <bd_init>:

// Initialize the buddy allocator: it manages memory from [base, end).
void bd_init(void *base, void *end) {
    80005f06:	715d                	addi	sp,sp,-80
    80005f08:	e486                	sd	ra,72(sp)
    80005f0a:	e0a2                	sd	s0,64(sp)
    80005f0c:	fc26                	sd	s1,56(sp)
    80005f0e:	f84a                	sd	s2,48(sp)
    80005f10:	f44e                	sd	s3,40(sp)
    80005f12:	f052                	sd	s4,32(sp)
    80005f14:	ec56                	sd	s5,24(sp)
    80005f16:	e85a                	sd	s6,16(sp)
    80005f18:	e45e                	sd	s7,8(sp)
    80005f1a:	e062                	sd	s8,0(sp)
    80005f1c:	0880                	addi	s0,sp,80
    80005f1e:	8c2e                	mv	s8,a1
  char *p = (char *)ROUNDUP((uint64)base, LEAF_SIZE);
    80005f20:	fff50493          	addi	s1,a0,-1
    80005f24:	98c1                	andi	s1,s1,-16
    80005f26:	04c1                	addi	s1,s1,16
  int sz;

  initlock(&lock, "buddy");
    80005f28:	00003597          	auipc	a1,0x3
    80005f2c:	97858593          	addi	a1,a1,-1672 # 800088a0 <syscalls+0x4a0>
    80005f30:	00013517          	auipc	a0,0x13
    80005f34:	d6850513          	addi	a0,a0,-664 # 80018c98 <lock>
    80005f38:	00001097          	auipc	ra,0x1
    80005f3c:	cac080e7          	jalr	-852(ra) # 80006be4 <initlock>
  bd_base = (void *)p;
    80005f40:	00003797          	auipc	a5,0x3
    80005f44:	ac97b823          	sd	s1,-1328(a5) # 80008a10 <bd_base>

  // compute the number of sizes we need to manage [base, end)
  nsizes = log2(((char *)end - p) / LEAF_SIZE) + 1;
    80005f48:	409c0933          	sub	s2,s8,s1
    80005f4c:	43f95513          	srai	a0,s2,0x3f
    80005f50:	893d                	andi	a0,a0,15
    80005f52:	954a                	add	a0,a0,s2
    80005f54:	8511                	srai	a0,a0,0x4
    80005f56:	00000097          	auipc	ra,0x0
    80005f5a:	c5a080e7          	jalr	-934(ra) # 80005bb0 <log2>
  if ((char *)end - p > BLK_SIZE(MAXSIZE)) {
    80005f5e:	47c1                	li	a5,16
    80005f60:	00a797b3          	sll	a5,a5,a0
    80005f64:	1b27c663          	blt	a5,s2,80006110 <bd_init+0x20a>
  nsizes = log2(((char *)end - p) / LEAF_SIZE) + 1;
    80005f68:	2505                	addiw	a0,a0,1
    80005f6a:	00003797          	auipc	a5,0x3
    80005f6e:	aaa7ab23          	sw	a0,-1354(a5) # 80008a20 <nsizes>
    nsizes++;  // round up to the next power of 2
  }

  printf("bd: memory sz is %d bytes; allocate an size array of length %d\n",
    80005f72:	00003997          	auipc	s3,0x3
    80005f76:	aae98993          	addi	s3,s3,-1362 # 80008a20 <nsizes>
    80005f7a:	0009a603          	lw	a2,0(s3)
    80005f7e:	85ca                	mv	a1,s2
    80005f80:	00003517          	auipc	a0,0x3
    80005f84:	92850513          	addi	a0,a0,-1752 # 800088a8 <syscalls+0x4a8>
    80005f88:	00000097          	auipc	ra,0x0
    80005f8c:	7fa080e7          	jalr	2042(ra) # 80006782 <printf>
         (char *)end - p, nsizes);

  // allocate bd_sizes array
  bd_sizes = (Sz_info *)p;
    80005f90:	00003797          	auipc	a5,0x3
    80005f94:	a897b423          	sd	s1,-1400(a5) # 80008a18 <bd_sizes>
  p += sizeof(Sz_info) * nsizes;
    80005f98:	0009a603          	lw	a2,0(s3)
    80005f9c:	00561913          	slli	s2,a2,0x5
    80005fa0:	9926                	add	s2,s2,s1
  memset(bd_sizes, 0, sizeof(Sz_info) * nsizes);
    80005fa2:	0056161b          	slliw	a2,a2,0x5
    80005fa6:	4581                	li	a1,0
    80005fa8:	8526                	mv	a0,s1
    80005faa:	ffffa097          	auipc	ra,0xffffa
    80005fae:	0cc080e7          	jalr	204(ra) # 80000076 <memset>

  // initialize free list and allocate the alloc array for each size k
  for (int k = 0; k < nsizes; k++) {
    80005fb2:	0009a783          	lw	a5,0(s3)
    80005fb6:	06f05a63          	blez	a5,8000602a <bd_init+0x124>
    80005fba:	4981                	li	s3,0
    lst_init(&bd_sizes[k].free);
    80005fbc:	00003a97          	auipc	s5,0x3
    80005fc0:	a5ca8a93          	addi	s5,s5,-1444 # 80008a18 <bd_sizes>
    sz = sizeof(char) * ROUNDUP(NBLK(k), 16) / 16;
    80005fc4:	00003a17          	auipc	s4,0x3
    80005fc8:	a5ca0a13          	addi	s4,s4,-1444 # 80008a20 <nsizes>
    80005fcc:	4b05                	li	s6,1
    lst_init(&bd_sizes[k].free);
    80005fce:	00599b93          	slli	s7,s3,0x5
    80005fd2:	000ab503          	ld	a0,0(s5)
    80005fd6:	955e                	add	a0,a0,s7
    80005fd8:	00000097          	auipc	ra,0x0
    80005fdc:	166080e7          	jalr	358(ra) # 8000613e <lst_init>
    sz = sizeof(char) * ROUNDUP(NBLK(k), 16) / 16;
    80005fe0:	000a2483          	lw	s1,0(s4)
    80005fe4:	34fd                	addiw	s1,s1,-1
    80005fe6:	413484bb          	subw	s1,s1,s3
    80005fea:	009b14bb          	sllw	s1,s6,s1
    80005fee:	fff4879b          	addiw	a5,s1,-1
    80005ff2:	41f7d49b          	sraiw	s1,a5,0x1f
    80005ff6:	01c4d49b          	srliw	s1,s1,0x1c
    80005ffa:	9cbd                	addw	s1,s1,a5
    80005ffc:	98c1                	andi	s1,s1,-16
    80005ffe:	24c1                	addiw	s1,s1,16
    bd_sizes[k].alloc = p;
    80006000:	000ab783          	ld	a5,0(s5)
    80006004:	9bbe                	add	s7,s7,a5
    80006006:	012bb823          	sd	s2,16(s7)
    memset(bd_sizes[k].alloc, 0, sz);
    8000600a:	8491                	srai	s1,s1,0x4
    8000600c:	8626                	mv	a2,s1
    8000600e:	4581                	li	a1,0
    80006010:	854a                	mv	a0,s2
    80006012:	ffffa097          	auipc	ra,0xffffa
    80006016:	064080e7          	jalr	100(ra) # 80000076 <memset>
    p += sz;
    8000601a:	9926                	add	s2,s2,s1
  for (int k = 0; k < nsizes; k++) {
    8000601c:	0985                	addi	s3,s3,1
    8000601e:	000a2703          	lw	a4,0(s4)
    80006022:	0009879b          	sext.w	a5,s3
    80006026:	fae7c4e3          	blt	a5,a4,80005fce <bd_init+0xc8>
  }

  // allocate the split array for each size k, except for k = 0, since
  // we will not split blocks of size k = 0, the smallest size.
  for (int k = 1; k < nsizes; k++) {
    8000602a:	00003797          	auipc	a5,0x3
    8000602e:	9f67a783          	lw	a5,-1546(a5) # 80008a20 <nsizes>
    80006032:	4705                	li	a4,1
    80006034:	06f75163          	bge	a4,a5,80006096 <bd_init+0x190>
    80006038:	02000a13          	li	s4,32
    8000603c:	4985                	li	s3,1
    sz = sizeof(char) * (ROUNDUP(NBLK(k), 8)) / 8;
    8000603e:	4b85                	li	s7,1
    bd_sizes[k].split = p;
    80006040:	00003b17          	auipc	s6,0x3
    80006044:	9d8b0b13          	addi	s6,s6,-1576 # 80008a18 <bd_sizes>
  for (int k = 1; k < nsizes; k++) {
    80006048:	00003a97          	auipc	s5,0x3
    8000604c:	9d8a8a93          	addi	s5,s5,-1576 # 80008a20 <nsizes>
    sz = sizeof(char) * (ROUNDUP(NBLK(k), 8)) / 8;
    80006050:	37fd                	addiw	a5,a5,-1
    80006052:	413787bb          	subw	a5,a5,s3
    80006056:	00fb94bb          	sllw	s1,s7,a5
    8000605a:	fff4879b          	addiw	a5,s1,-1
    8000605e:	41f7d49b          	sraiw	s1,a5,0x1f
    80006062:	01d4d49b          	srliw	s1,s1,0x1d
    80006066:	9cbd                	addw	s1,s1,a5
    80006068:	98e1                	andi	s1,s1,-8
    8000606a:	24a1                	addiw	s1,s1,8
    bd_sizes[k].split = p;
    8000606c:	000b3783          	ld	a5,0(s6)
    80006070:	97d2                	add	a5,a5,s4
    80006072:	0127bc23          	sd	s2,24(a5)
    memset(bd_sizes[k].split, 0, sz);
    80006076:	848d                	srai	s1,s1,0x3
    80006078:	8626                	mv	a2,s1
    8000607a:	4581                	li	a1,0
    8000607c:	854a                	mv	a0,s2
    8000607e:	ffffa097          	auipc	ra,0xffffa
    80006082:	ff8080e7          	jalr	-8(ra) # 80000076 <memset>
    p += sz;
    80006086:	9926                	add	s2,s2,s1
  for (int k = 1; k < nsizes; k++) {
    80006088:	2985                	addiw	s3,s3,1
    8000608a:	000aa783          	lw	a5,0(s5)
    8000608e:	020a0a13          	addi	s4,s4,32
    80006092:	faf9cfe3          	blt	s3,a5,80006050 <bd_init+0x14a>
  }
  p = (char *)ROUNDUP((uint64)p, LEAF_SIZE);
    80006096:	197d                	addi	s2,s2,-1
    80006098:	ff097913          	andi	s2,s2,-16
    8000609c:	0941                	addi	s2,s2,16

  // done allocating; mark the memory range [base, p) as allocated, so
  // that buddy will not hand out that memory.
  int meta = bd_mark_data_structures(p);
    8000609e:	854a                	mv	a0,s2
    800060a0:	00000097          	auipc	ra,0x0
    800060a4:	d7c080e7          	jalr	-644(ra) # 80005e1c <bd_mark_data_structures>
    800060a8:	8a2a                	mv	s4,a0

  // mark the unavailable memory range [end, HEAP_SIZE) as allocated,
  // so that buddy will not hand out that memory.
  int unavailable = bd_mark_unavailable(end, p);
    800060aa:	85ca                	mv	a1,s2
    800060ac:	8562                	mv	a0,s8
    800060ae:	00000097          	auipc	ra,0x0
    800060b2:	dce080e7          	jalr	-562(ra) # 80005e7c <bd_mark_unavailable>
    800060b6:	89aa                	mv	s3,a0
  void *bd_end = bd_base + BLK_SIZE(MAXSIZE) - unavailable;
    800060b8:	00003a97          	auipc	s5,0x3
    800060bc:	968a8a93          	addi	s5,s5,-1688 # 80008a20 <nsizes>
    800060c0:	000aa783          	lw	a5,0(s5)
    800060c4:	37fd                	addiw	a5,a5,-1
    800060c6:	44c1                	li	s1,16
    800060c8:	00f497b3          	sll	a5,s1,a5
    800060cc:	8f89                	sub	a5,a5,a0

  // initialize free lists for each size k
  int free = bd_initfree(p, bd_end);
    800060ce:	00003597          	auipc	a1,0x3
    800060d2:	9425b583          	ld	a1,-1726(a1) # 80008a10 <bd_base>
    800060d6:	95be                	add	a1,a1,a5
    800060d8:	854a                	mv	a0,s2
    800060da:	00000097          	auipc	ra,0x0
    800060de:	c82080e7          	jalr	-894(ra) # 80005d5c <bd_initfree>

  // check if the amount that is free is what we expect
  if (free != BLK_SIZE(MAXSIZE) - meta - unavailable) {
    800060e2:	000aa603          	lw	a2,0(s5)
    800060e6:	367d                	addiw	a2,a2,-1
    800060e8:	00c49633          	sll	a2,s1,a2
    800060ec:	41460633          	sub	a2,a2,s4
    800060f0:	41360633          	sub	a2,a2,s3
    800060f4:	02c51463          	bne	a0,a2,8000611c <bd_init+0x216>
    printf("free %d %d\n", free, BLK_SIZE(MAXSIZE) - meta - unavailable);
    panic("bd_init: free mem");
  }
    800060f8:	60a6                	ld	ra,72(sp)
    800060fa:	6406                	ld	s0,64(sp)
    800060fc:	74e2                	ld	s1,56(sp)
    800060fe:	7942                	ld	s2,48(sp)
    80006100:	79a2                	ld	s3,40(sp)
    80006102:	7a02                	ld	s4,32(sp)
    80006104:	6ae2                	ld	s5,24(sp)
    80006106:	6b42                	ld	s6,16(sp)
    80006108:	6ba2                	ld	s7,8(sp)
    8000610a:	6c02                	ld	s8,0(sp)
    8000610c:	6161                	addi	sp,sp,80
    8000610e:	8082                	ret
    nsizes++;  // round up to the next power of 2
    80006110:	2509                	addiw	a0,a0,2
    80006112:	00003797          	auipc	a5,0x3
    80006116:	90a7a723          	sw	a0,-1778(a5) # 80008a20 <nsizes>
    8000611a:	bda1                	j	80005f72 <bd_init+0x6c>
    printf("free %d %d\n", free, BLK_SIZE(MAXSIZE) - meta - unavailable);
    8000611c:	85aa                	mv	a1,a0
    8000611e:	00002517          	auipc	a0,0x2
    80006122:	7ca50513          	addi	a0,a0,1994 # 800088e8 <syscalls+0x4e8>
    80006126:	00000097          	auipc	ra,0x0
    8000612a:	65c080e7          	jalr	1628(ra) # 80006782 <printf>
    panic("bd_init: free mem");
    8000612e:	00002517          	auipc	a0,0x2
    80006132:	7ca50513          	addi	a0,a0,1994 # 800088f8 <syscalls+0x4f8>
    80006136:	00000097          	auipc	ra,0x0
    8000613a:	602080e7          	jalr	1538(ra) # 80006738 <panic>

000000008000613e <lst_init>:

// double-linked, circular list. double-linked makes remove
// fast. circular simplifies code, because don't have to check for
// empty list in insert and remove.

void lst_init(struct list *lst) {
    8000613e:	1141                	addi	sp,sp,-16
    80006140:	e422                	sd	s0,8(sp)
    80006142:	0800                	addi	s0,sp,16
  lst->next = lst;
    80006144:	e108                	sd	a0,0(a0)
  lst->prev = lst;
    80006146:	e508                	sd	a0,8(a0)
}
    80006148:	6422                	ld	s0,8(sp)
    8000614a:	0141                	addi	sp,sp,16
    8000614c:	8082                	ret

000000008000614e <lst_empty>:

int lst_empty(struct list *lst) { return lst->next == lst; }
    8000614e:	1141                	addi	sp,sp,-16
    80006150:	e422                	sd	s0,8(sp)
    80006152:	0800                	addi	s0,sp,16
    80006154:	611c                	ld	a5,0(a0)
    80006156:	40a78533          	sub	a0,a5,a0
    8000615a:	00153513          	seqz	a0,a0
    8000615e:	6422                	ld	s0,8(sp)
    80006160:	0141                	addi	sp,sp,16
    80006162:	8082                	ret

0000000080006164 <lst_remove>:

void lst_remove(struct list *e) {
    80006164:	1141                	addi	sp,sp,-16
    80006166:	e422                	sd	s0,8(sp)
    80006168:	0800                	addi	s0,sp,16
  e->prev->next = e->next;
    8000616a:	6518                	ld	a4,8(a0)
    8000616c:	611c                	ld	a5,0(a0)
    8000616e:	e31c                	sd	a5,0(a4)
  e->next->prev = e->prev;
    80006170:	6518                	ld	a4,8(a0)
    80006172:	e798                	sd	a4,8(a5)
}
    80006174:	6422                	ld	s0,8(sp)
    80006176:	0141                	addi	sp,sp,16
    80006178:	8082                	ret

000000008000617a <lst_pop>:

void *lst_pop(struct list *lst) {
    8000617a:	1101                	addi	sp,sp,-32
    8000617c:	ec06                	sd	ra,24(sp)
    8000617e:	e822                	sd	s0,16(sp)
    80006180:	e426                	sd	s1,8(sp)
    80006182:	1000                	addi	s0,sp,32
  if (lst->next == lst) panic("lst_pop");
    80006184:	6104                	ld	s1,0(a0)
    80006186:	00a48d63          	beq	s1,a0,800061a0 <lst_pop+0x26>
  struct list *p = lst->next;
  lst_remove(p);
    8000618a:	8526                	mv	a0,s1
    8000618c:	00000097          	auipc	ra,0x0
    80006190:	fd8080e7          	jalr	-40(ra) # 80006164 <lst_remove>
  return (void *)p;
}
    80006194:	8526                	mv	a0,s1
    80006196:	60e2                	ld	ra,24(sp)
    80006198:	6442                	ld	s0,16(sp)
    8000619a:	64a2                	ld	s1,8(sp)
    8000619c:	6105                	addi	sp,sp,32
    8000619e:	8082                	ret
  if (lst->next == lst) panic("lst_pop");
    800061a0:	00002517          	auipc	a0,0x2
    800061a4:	77050513          	addi	a0,a0,1904 # 80008910 <syscalls+0x510>
    800061a8:	00000097          	auipc	ra,0x0
    800061ac:	590080e7          	jalr	1424(ra) # 80006738 <panic>

00000000800061b0 <lst_push>:

void lst_push(struct list *lst, void *p) {
    800061b0:	1141                	addi	sp,sp,-16
    800061b2:	e422                	sd	s0,8(sp)
    800061b4:	0800                	addi	s0,sp,16
  struct list *e = (struct list *)p;
  e->next = lst->next;
    800061b6:	611c                	ld	a5,0(a0)
    800061b8:	e19c                	sd	a5,0(a1)
  e->prev = lst;
    800061ba:	e588                	sd	a0,8(a1)
  lst->next->prev = p;
    800061bc:	611c                	ld	a5,0(a0)
    800061be:	e78c                	sd	a1,8(a5)
  lst->next = e;
    800061c0:	e10c                	sd	a1,0(a0)
}
    800061c2:	6422                	ld	s0,8(sp)
    800061c4:	0141                	addi	sp,sp,16
    800061c6:	8082                	ret

00000000800061c8 <lst_print>:

void lst_print(struct list *lst) {
    800061c8:	7179                	addi	sp,sp,-48
    800061ca:	f406                	sd	ra,40(sp)
    800061cc:	f022                	sd	s0,32(sp)
    800061ce:	ec26                	sd	s1,24(sp)
    800061d0:	e84a                	sd	s2,16(sp)
    800061d2:	e44e                	sd	s3,8(sp)
    800061d4:	1800                	addi	s0,sp,48
  for (struct list *p = lst->next; p != lst; p = p->next) {
    800061d6:	6104                	ld	s1,0(a0)
    800061d8:	02950063          	beq	a0,s1,800061f8 <lst_print+0x30>
    800061dc:	892a                	mv	s2,a0
    printf(" %p", p);
    800061de:	00002997          	auipc	s3,0x2
    800061e2:	73a98993          	addi	s3,s3,1850 # 80008918 <syscalls+0x518>
    800061e6:	85a6                	mv	a1,s1
    800061e8:	854e                	mv	a0,s3
    800061ea:	00000097          	auipc	ra,0x0
    800061ee:	598080e7          	jalr	1432(ra) # 80006782 <printf>
  for (struct list *p = lst->next; p != lst; p = p->next) {
    800061f2:	6084                	ld	s1,0(s1)
    800061f4:	fe9919e3          	bne	s2,s1,800061e6 <lst_print+0x1e>
  }
  printf("\n");
    800061f8:	00002517          	auipc	a0,0x2
    800061fc:	e4050513          	addi	a0,a0,-448 # 80008038 <etext+0x38>
    80006200:	00000097          	auipc	ra,0x0
    80006204:	582080e7          	jalr	1410(ra) # 80006782 <printf>
}
    80006208:	70a2                	ld	ra,40(sp)
    8000620a:	7402                	ld	s0,32(sp)
    8000620c:	64e2                	ld	s1,24(sp)
    8000620e:	6942                	ld	s2,16(sp)
    80006210:	69a2                	ld	s3,8(sp)
    80006212:	6145                	addi	sp,sp,48
    80006214:	8082                	ret

0000000080006216 <timerinit>:
// arrange to receive timer interrupts.
// they will arrive in machine mode at
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void timerinit() {
    80006216:	1141                	addi	sp,sp,-16
    80006218:	e422                	sd	s0,8(sp)
    8000621a:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r"(x));
    8000621c:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80006220:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000;  // cycles; about 1/10th second in qemu.
  *(uint64 *)CLINT_MTIMECMP(id) = *(uint64 *)CLINT_MTIME + interval;
    80006224:	0037979b          	slliw	a5,a5,0x3
    80006228:	02004737          	lui	a4,0x2004
    8000622c:	97ba                	add	a5,a5,a4
    8000622e:	0200c737          	lui	a4,0x200c
    80006232:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006236:	000f4637          	lui	a2,0xf4
    8000623a:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000623e:	95b2                	add	a1,a1,a2
    80006240:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80006242:	00269713          	slli	a4,a3,0x2
    80006246:	9736                	add	a4,a4,a3
    80006248:	00371693          	slli	a3,a4,0x3
    8000624c:	00013717          	auipc	a4,0x13
    80006250:	a6470713          	addi	a4,a4,-1436 # 80018cb0 <timer_scratch>
    80006254:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80006256:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80006258:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r"(x));
    8000625a:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r"(x));
    8000625e:	fffff797          	auipc	a5,0xfffff
    80006262:	cd278793          	addi	a5,a5,-814 # 80004f30 <timervec>
    80006266:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r"(x));
    8000626a:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    8000626e:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r"(x));
    80006272:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r"(x));
    80006276:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    8000627a:	0807e793          	ori	a5,a5,128
static inline void w_mie(uint64 x) { asm volatile("csrw mie, %0" : : "r"(x)); }
    8000627e:	30479073          	csrw	mie,a5
}
    80006282:	6422                	ld	s0,8(sp)
    80006284:	0141                	addi	sp,sp,16
    80006286:	8082                	ret

0000000080006288 <start>:
void start() {
    80006288:	1141                	addi	sp,sp,-16
    8000628a:	e406                	sd	ra,8(sp)
    8000628c:	e022                	sd	s0,0(sp)
    8000628e:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r"(x));
    80006290:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80006294:	7779                	lui	a4,0xffffe
    80006296:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdd90f>
    8000629a:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    8000629c:	6705                	lui	a4,0x1
    8000629e:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800062a2:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r"(x));
    800062a4:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r"(x));
    800062a8:	ffffa797          	auipc	a5,0xffffa
    800062ac:	f7478793          	addi	a5,a5,-140 # 8000021c <main>
    800062b0:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r"(x));
    800062b4:	4781                	li	a5,0
    800062b6:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r"(x));
    800062ba:	67c1                	lui	a5,0x10
    800062bc:	17fd                	addi	a5,a5,-1
    800062be:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r"(x));
    800062c2:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r"(x));
    800062c6:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800062ca:	2227e793          	ori	a5,a5,546
static inline void w_sie(uint64 x) { asm volatile("csrw sie, %0" : : "r"(x)); }
    800062ce:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r"(x));
    800062d2:	57fd                	li	a5,-1
    800062d4:	83a9                	srli	a5,a5,0xa
    800062d6:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r"(x));
    800062da:	47bd                	li	a5,15
    800062dc:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800062e0:	00000097          	auipc	ra,0x0
    800062e4:	f36080e7          	jalr	-202(ra) # 80006216 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r"(x));
    800062e8:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800062ec:	2781                	sext.w	a5,a5
static inline void w_tp(uint64 x) { asm volatile("mv tp, %0" : : "r"(x)); }
    800062ee:	823e                	mv	tp,a5
  asm volatile("mret");
    800062f0:	30200073          	mret
}
    800062f4:	60a2                	ld	ra,8(sp)
    800062f6:	6402                	ld	s0,0(sp)
    800062f8:	0141                	addi	sp,sp,16
    800062fa:	8082                	ret

00000000800062fc <consolewrite>:
} cons;

//
// user write()s to the console go here.
//
int consolewrite(int user_src, uint64 src, int n) {
    800062fc:	715d                	addi	sp,sp,-80
    800062fe:	e486                	sd	ra,72(sp)
    80006300:	e0a2                	sd	s0,64(sp)
    80006302:	fc26                	sd	s1,56(sp)
    80006304:	f84a                	sd	s2,48(sp)
    80006306:	f44e                	sd	s3,40(sp)
    80006308:	f052                	sd	s4,32(sp)
    8000630a:	ec56                	sd	s5,24(sp)
    8000630c:	0880                	addi	s0,sp,80
  int i;

  for (i = 0; i < n; i++) {
    8000630e:	04c05663          	blez	a2,8000635a <consolewrite+0x5e>
    80006312:	8a2a                	mv	s4,a0
    80006314:	84ae                	mv	s1,a1
    80006316:	89b2                	mv	s3,a2
    80006318:	4901                	li	s2,0
    char c;
    if (either_copyin(&c, user_src, src + i, 1) == -1) break;
    8000631a:	5afd                	li	s5,-1
    8000631c:	4685                	li	a3,1
    8000631e:	8626                	mv	a2,s1
    80006320:	85d2                	mv	a1,s4
    80006322:	fbf40513          	addi	a0,s0,-65
    80006326:	ffffb097          	auipc	ra,0xffffb
    8000632a:	58c080e7          	jalr	1420(ra) # 800018b2 <either_copyin>
    8000632e:	01550c63          	beq	a0,s5,80006346 <consolewrite+0x4a>
    uartputc(c);
    80006332:	fbf44503          	lbu	a0,-65(s0)
    80006336:	00000097          	auipc	ra,0x0
    8000633a:	780080e7          	jalr	1920(ra) # 80006ab6 <uartputc>
  for (i = 0; i < n; i++) {
    8000633e:	2905                	addiw	s2,s2,1
    80006340:	0485                	addi	s1,s1,1
    80006342:	fd299de3          	bne	s3,s2,8000631c <consolewrite+0x20>
  }

  return i;
}
    80006346:	854a                	mv	a0,s2
    80006348:	60a6                	ld	ra,72(sp)
    8000634a:	6406                	ld	s0,64(sp)
    8000634c:	74e2                	ld	s1,56(sp)
    8000634e:	7942                	ld	s2,48(sp)
    80006350:	79a2                	ld	s3,40(sp)
    80006352:	7a02                	ld	s4,32(sp)
    80006354:	6ae2                	ld	s5,24(sp)
    80006356:	6161                	addi	sp,sp,80
    80006358:	8082                	ret
  for (i = 0; i < n; i++) {
    8000635a:	4901                	li	s2,0
    8000635c:	b7ed                	j	80006346 <consolewrite+0x4a>

000000008000635e <consoleread>:
// user read()s from the console go here.
// copy (up to) a whole input line to dst.
// user_dist indicates whether dst is a user
// or kernel address.
//
int consoleread(int user_dst, uint64 dst, int n) {
    8000635e:	7159                	addi	sp,sp,-112
    80006360:	f486                	sd	ra,104(sp)
    80006362:	f0a2                	sd	s0,96(sp)
    80006364:	eca6                	sd	s1,88(sp)
    80006366:	e8ca                	sd	s2,80(sp)
    80006368:	e4ce                	sd	s3,72(sp)
    8000636a:	e0d2                	sd	s4,64(sp)
    8000636c:	fc56                	sd	s5,56(sp)
    8000636e:	f85a                	sd	s6,48(sp)
    80006370:	f45e                	sd	s7,40(sp)
    80006372:	f062                	sd	s8,32(sp)
    80006374:	ec66                	sd	s9,24(sp)
    80006376:	e86a                	sd	s10,16(sp)
    80006378:	1880                	addi	s0,sp,112
    8000637a:	8aaa                	mv	s5,a0
    8000637c:	8a2e                	mv	s4,a1
    8000637e:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80006380:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80006384:	0001b517          	auipc	a0,0x1b
    80006388:	a6c50513          	addi	a0,a0,-1428 # 80020df0 <cons>
    8000638c:	00001097          	auipc	ra,0x1
    80006390:	8e8080e7          	jalr	-1816(ra) # 80006c74 <acquire>
  while (n > 0) {
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while (cons.r == cons.w) {
    80006394:	0001b497          	auipc	s1,0x1b
    80006398:	a5c48493          	addi	s1,s1,-1444 # 80020df0 <cons>
      if (killed(myproc())) {
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    8000639c:	0001b917          	auipc	s2,0x1b
    800063a0:	aec90913          	addi	s2,s2,-1300 # 80020e88 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

    if (c == C('D')) {  // end-of-file
    800063a4:	4b91                	li	s7,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if (either_copyout(user_dst, dst, &cbuf, 1) == -1) break;
    800063a6:	5c7d                	li	s8,-1

    dst++;
    --n;

    if (c == '\n') {
    800063a8:	4ca9                	li	s9,10
  while (n > 0) {
    800063aa:	07305b63          	blez	s3,80006420 <consoleread+0xc2>
    while (cons.r == cons.w) {
    800063ae:	0984a783          	lw	a5,152(s1)
    800063b2:	09c4a703          	lw	a4,156(s1)
    800063b6:	02f71763          	bne	a4,a5,800063e4 <consoleread+0x86>
      if (killed(myproc())) {
    800063ba:	ffffb097          	auipc	ra,0xffffb
    800063be:	9ee080e7          	jalr	-1554(ra) # 80000da8 <myproc>
    800063c2:	ffffb097          	auipc	ra,0xffffb
    800063c6:	33a080e7          	jalr	826(ra) # 800016fc <killed>
    800063ca:	e535                	bnez	a0,80006436 <consoleread+0xd8>
      sleep(&cons.r, &cons.lock);
    800063cc:	85a6                	mv	a1,s1
    800063ce:	854a                	mv	a0,s2
    800063d0:	ffffb097          	auipc	ra,0xffffb
    800063d4:	084080e7          	jalr	132(ra) # 80001454 <sleep>
    while (cons.r == cons.w) {
    800063d8:	0984a783          	lw	a5,152(s1)
    800063dc:	09c4a703          	lw	a4,156(s1)
    800063e0:	fcf70de3          	beq	a4,a5,800063ba <consoleread+0x5c>
    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800063e4:	0017871b          	addiw	a4,a5,1
    800063e8:	08e4ac23          	sw	a4,152(s1)
    800063ec:	07f7f713          	andi	a4,a5,127
    800063f0:	9726                	add	a4,a4,s1
    800063f2:	01874703          	lbu	a4,24(a4)
    800063f6:	00070d1b          	sext.w	s10,a4
    if (c == C('D')) {  // end-of-file
    800063fa:	077d0563          	beq	s10,s7,80006464 <consoleread+0x106>
    cbuf = c;
    800063fe:	f8e40fa3          	sb	a4,-97(s0)
    if (either_copyout(user_dst, dst, &cbuf, 1) == -1) break;
    80006402:	4685                	li	a3,1
    80006404:	f9f40613          	addi	a2,s0,-97
    80006408:	85d2                	mv	a1,s4
    8000640a:	8556                	mv	a0,s5
    8000640c:	ffffb097          	auipc	ra,0xffffb
    80006410:	450080e7          	jalr	1104(ra) # 8000185c <either_copyout>
    80006414:	01850663          	beq	a0,s8,80006420 <consoleread+0xc2>
    dst++;
    80006418:	0a05                	addi	s4,s4,1
    --n;
    8000641a:	39fd                	addiw	s3,s3,-1
    if (c == '\n') {
    8000641c:	f99d17e3          	bne	s10,s9,800063aa <consoleread+0x4c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80006420:	0001b517          	auipc	a0,0x1b
    80006424:	9d050513          	addi	a0,a0,-1584 # 80020df0 <cons>
    80006428:	00001097          	auipc	ra,0x1
    8000642c:	900080e7          	jalr	-1792(ra) # 80006d28 <release>

  return target - n;
    80006430:	413b053b          	subw	a0,s6,s3
    80006434:	a811                	j	80006448 <consoleread+0xea>
        release(&cons.lock);
    80006436:	0001b517          	auipc	a0,0x1b
    8000643a:	9ba50513          	addi	a0,a0,-1606 # 80020df0 <cons>
    8000643e:	00001097          	auipc	ra,0x1
    80006442:	8ea080e7          	jalr	-1814(ra) # 80006d28 <release>
        return -1;
    80006446:	557d                	li	a0,-1
}
    80006448:	70a6                	ld	ra,104(sp)
    8000644a:	7406                	ld	s0,96(sp)
    8000644c:	64e6                	ld	s1,88(sp)
    8000644e:	6946                	ld	s2,80(sp)
    80006450:	69a6                	ld	s3,72(sp)
    80006452:	6a06                	ld	s4,64(sp)
    80006454:	7ae2                	ld	s5,56(sp)
    80006456:	7b42                	ld	s6,48(sp)
    80006458:	7ba2                	ld	s7,40(sp)
    8000645a:	7c02                	ld	s8,32(sp)
    8000645c:	6ce2                	ld	s9,24(sp)
    8000645e:	6d42                	ld	s10,16(sp)
    80006460:	6165                	addi	sp,sp,112
    80006462:	8082                	ret
      if (n < target) {
    80006464:	0009871b          	sext.w	a4,s3
    80006468:	fb677ce3          	bgeu	a4,s6,80006420 <consoleread+0xc2>
        cons.r--;
    8000646c:	0001b717          	auipc	a4,0x1b
    80006470:	a0f72e23          	sw	a5,-1508(a4) # 80020e88 <cons+0x98>
    80006474:	b775                	j	80006420 <consoleread+0xc2>

0000000080006476 <consputc>:
void consputc(int c) {
    80006476:	1141                	addi	sp,sp,-16
    80006478:	e406                	sd	ra,8(sp)
    8000647a:	e022                	sd	s0,0(sp)
    8000647c:	0800                	addi	s0,sp,16
  if (c == BACKSPACE) {
    8000647e:	10000793          	li	a5,256
    80006482:	00f50a63          	beq	a0,a5,80006496 <consputc+0x20>
    uartputc_sync(c);
    80006486:	00000097          	auipc	ra,0x0
    8000648a:	55e080e7          	jalr	1374(ra) # 800069e4 <uartputc_sync>
}
    8000648e:	60a2                	ld	ra,8(sp)
    80006490:	6402                	ld	s0,0(sp)
    80006492:	0141                	addi	sp,sp,16
    80006494:	8082                	ret
    uartputc_sync('\b');
    80006496:	4521                	li	a0,8
    80006498:	00000097          	auipc	ra,0x0
    8000649c:	54c080e7          	jalr	1356(ra) # 800069e4 <uartputc_sync>
    uartputc_sync(' ');
    800064a0:	02000513          	li	a0,32
    800064a4:	00000097          	auipc	ra,0x0
    800064a8:	540080e7          	jalr	1344(ra) # 800069e4 <uartputc_sync>
    uartputc_sync('\b');
    800064ac:	4521                	li	a0,8
    800064ae:	00000097          	auipc	ra,0x0
    800064b2:	536080e7          	jalr	1334(ra) # 800069e4 <uartputc_sync>
    800064b6:	bfe1                	j	8000648e <consputc+0x18>

00000000800064b8 <consoleintr>:
// the console input interrupt handler.
// uartintr() calls this for input character.
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void consoleintr(int c) {
    800064b8:	1101                	addi	sp,sp,-32
    800064ba:	ec06                	sd	ra,24(sp)
    800064bc:	e822                	sd	s0,16(sp)
    800064be:	e426                	sd	s1,8(sp)
    800064c0:	e04a                	sd	s2,0(sp)
    800064c2:	1000                	addi	s0,sp,32
    800064c4:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800064c6:	0001b517          	auipc	a0,0x1b
    800064ca:	92a50513          	addi	a0,a0,-1750 # 80020df0 <cons>
    800064ce:	00000097          	auipc	ra,0x0
    800064d2:	7a6080e7          	jalr	1958(ra) # 80006c74 <acquire>

  switch (c) {
    800064d6:	47d5                	li	a5,21
    800064d8:	0af48663          	beq	s1,a5,80006584 <consoleintr+0xcc>
    800064dc:	0297ca63          	blt	a5,s1,80006510 <consoleintr+0x58>
    800064e0:	47a1                	li	a5,8
    800064e2:	0ef48763          	beq	s1,a5,800065d0 <consoleintr+0x118>
    800064e6:	47c1                	li	a5,16
    800064e8:	10f49a63          	bne	s1,a5,800065fc <consoleintr+0x144>
    case C('P'):  // Print process list.
      procdump();
    800064ec:	ffffb097          	auipc	ra,0xffffb
    800064f0:	41c080e7          	jalr	1052(ra) # 80001908 <procdump>
        }
      }
      break;
  }

  release(&cons.lock);
    800064f4:	0001b517          	auipc	a0,0x1b
    800064f8:	8fc50513          	addi	a0,a0,-1796 # 80020df0 <cons>
    800064fc:	00001097          	auipc	ra,0x1
    80006500:	82c080e7          	jalr	-2004(ra) # 80006d28 <release>
}
    80006504:	60e2                	ld	ra,24(sp)
    80006506:	6442                	ld	s0,16(sp)
    80006508:	64a2                	ld	s1,8(sp)
    8000650a:	6902                	ld	s2,0(sp)
    8000650c:	6105                	addi	sp,sp,32
    8000650e:	8082                	ret
  switch (c) {
    80006510:	07f00793          	li	a5,127
    80006514:	0af48e63          	beq	s1,a5,800065d0 <consoleintr+0x118>
      if (c != 0 && cons.e - cons.r < INPUT_BUF_SIZE) {
    80006518:	0001b717          	auipc	a4,0x1b
    8000651c:	8d870713          	addi	a4,a4,-1832 # 80020df0 <cons>
    80006520:	0a072783          	lw	a5,160(a4)
    80006524:	09872703          	lw	a4,152(a4)
    80006528:	9f99                	subw	a5,a5,a4
    8000652a:	07f00713          	li	a4,127
    8000652e:	fcf763e3          	bltu	a4,a5,800064f4 <consoleintr+0x3c>
        c = (c == '\r') ? '\n' : c;
    80006532:	47b5                	li	a5,13
    80006534:	0cf48763          	beq	s1,a5,80006602 <consoleintr+0x14a>
        consputc(c);
    80006538:	8526                	mv	a0,s1
    8000653a:	00000097          	auipc	ra,0x0
    8000653e:	f3c080e7          	jalr	-196(ra) # 80006476 <consputc>
        cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80006542:	0001b797          	auipc	a5,0x1b
    80006546:	8ae78793          	addi	a5,a5,-1874 # 80020df0 <cons>
    8000654a:	0a07a683          	lw	a3,160(a5)
    8000654e:	0016871b          	addiw	a4,a3,1
    80006552:	0007061b          	sext.w	a2,a4
    80006556:	0ae7a023          	sw	a4,160(a5)
    8000655a:	07f6f693          	andi	a3,a3,127
    8000655e:	97b6                	add	a5,a5,a3
    80006560:	00978c23          	sb	s1,24(a5)
        if (c == '\n' || c == C('D') || cons.e - cons.r == INPUT_BUF_SIZE) {
    80006564:	47a9                	li	a5,10
    80006566:	0cf48563          	beq	s1,a5,80006630 <consoleintr+0x178>
    8000656a:	4791                	li	a5,4
    8000656c:	0cf48263          	beq	s1,a5,80006630 <consoleintr+0x178>
    80006570:	0001b797          	auipc	a5,0x1b
    80006574:	9187a783          	lw	a5,-1768(a5) # 80020e88 <cons+0x98>
    80006578:	9f1d                	subw	a4,a4,a5
    8000657a:	08000793          	li	a5,128
    8000657e:	f6f71be3          	bne	a4,a5,800064f4 <consoleintr+0x3c>
    80006582:	a07d                	j	80006630 <consoleintr+0x178>
      while (cons.e != cons.w &&
    80006584:	0001b717          	auipc	a4,0x1b
    80006588:	86c70713          	addi	a4,a4,-1940 # 80020df0 <cons>
    8000658c:	0a072783          	lw	a5,160(a4)
    80006590:	09c72703          	lw	a4,156(a4)
             cons.buf[(cons.e - 1) % INPUT_BUF_SIZE] != '\n') {
    80006594:	0001b497          	auipc	s1,0x1b
    80006598:	85c48493          	addi	s1,s1,-1956 # 80020df0 <cons>
      while (cons.e != cons.w &&
    8000659c:	4929                	li	s2,10
    8000659e:	f4f70be3          	beq	a4,a5,800064f4 <consoleintr+0x3c>
             cons.buf[(cons.e - 1) % INPUT_BUF_SIZE] != '\n') {
    800065a2:	37fd                	addiw	a5,a5,-1
    800065a4:	07f7f713          	andi	a4,a5,127
    800065a8:	9726                	add	a4,a4,s1
      while (cons.e != cons.w &&
    800065aa:	01874703          	lbu	a4,24(a4)
    800065ae:	f52703e3          	beq	a4,s2,800064f4 <consoleintr+0x3c>
        cons.e--;
    800065b2:	0af4a023          	sw	a5,160(s1)
        consputc(BACKSPACE);
    800065b6:	10000513          	li	a0,256
    800065ba:	00000097          	auipc	ra,0x0
    800065be:	ebc080e7          	jalr	-324(ra) # 80006476 <consputc>
      while (cons.e != cons.w &&
    800065c2:	0a04a783          	lw	a5,160(s1)
    800065c6:	09c4a703          	lw	a4,156(s1)
    800065ca:	fcf71ce3          	bne	a4,a5,800065a2 <consoleintr+0xea>
    800065ce:	b71d                	j	800064f4 <consoleintr+0x3c>
      if (cons.e != cons.w) {
    800065d0:	0001b717          	auipc	a4,0x1b
    800065d4:	82070713          	addi	a4,a4,-2016 # 80020df0 <cons>
    800065d8:	0a072783          	lw	a5,160(a4)
    800065dc:	09c72703          	lw	a4,156(a4)
    800065e0:	f0f70ae3          	beq	a4,a5,800064f4 <consoleintr+0x3c>
        cons.e--;
    800065e4:	37fd                	addiw	a5,a5,-1
    800065e6:	0001b717          	auipc	a4,0x1b
    800065ea:	8af72523          	sw	a5,-1878(a4) # 80020e90 <cons+0xa0>
        consputc(BACKSPACE);
    800065ee:	10000513          	li	a0,256
    800065f2:	00000097          	auipc	ra,0x0
    800065f6:	e84080e7          	jalr	-380(ra) # 80006476 <consputc>
    800065fa:	bded                	j	800064f4 <consoleintr+0x3c>
      if (c != 0 && cons.e - cons.r < INPUT_BUF_SIZE) {
    800065fc:	ee048ce3          	beqz	s1,800064f4 <consoleintr+0x3c>
    80006600:	bf21                	j	80006518 <consoleintr+0x60>
        consputc(c);
    80006602:	4529                	li	a0,10
    80006604:	00000097          	auipc	ra,0x0
    80006608:	e72080e7          	jalr	-398(ra) # 80006476 <consputc>
        cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    8000660c:	0001a797          	auipc	a5,0x1a
    80006610:	7e478793          	addi	a5,a5,2020 # 80020df0 <cons>
    80006614:	0a07a703          	lw	a4,160(a5)
    80006618:	0017069b          	addiw	a3,a4,1
    8000661c:	0006861b          	sext.w	a2,a3
    80006620:	0ad7a023          	sw	a3,160(a5)
    80006624:	07f77713          	andi	a4,a4,127
    80006628:	97ba                	add	a5,a5,a4
    8000662a:	4729                	li	a4,10
    8000662c:	00e78c23          	sb	a4,24(a5)
          cons.w = cons.e;
    80006630:	0001b797          	auipc	a5,0x1b
    80006634:	84c7ae23          	sw	a2,-1956(a5) # 80020e8c <cons+0x9c>
          wakeup(&cons.r);
    80006638:	0001b517          	auipc	a0,0x1b
    8000663c:	85050513          	addi	a0,a0,-1968 # 80020e88 <cons+0x98>
    80006640:	ffffb097          	auipc	ra,0xffffb
    80006644:	e78080e7          	jalr	-392(ra) # 800014b8 <wakeup>
    80006648:	b575                	j	800064f4 <consoleintr+0x3c>

000000008000664a <consoleinit>:

void consoleinit(void) {
    8000664a:	1141                	addi	sp,sp,-16
    8000664c:	e406                	sd	ra,8(sp)
    8000664e:	e022                	sd	s0,0(sp)
    80006650:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80006652:	00002597          	auipc	a1,0x2
    80006656:	2ce58593          	addi	a1,a1,718 # 80008920 <syscalls+0x520>
    8000665a:	0001a517          	auipc	a0,0x1a
    8000665e:	79650513          	addi	a0,a0,1942 # 80020df0 <cons>
    80006662:	00000097          	auipc	ra,0x0
    80006666:	582080e7          	jalr	1410(ra) # 80006be4 <initlock>

  uartinit();
    8000666a:	00000097          	auipc	ra,0x0
    8000666e:	32a080e7          	jalr	810(ra) # 80006994 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80006672:	00012797          	auipc	a5,0x12
    80006676:	44678793          	addi	a5,a5,1094 # 80018ab8 <devsw>
    8000667a:	00000717          	auipc	a4,0x0
    8000667e:	ce470713          	addi	a4,a4,-796 # 8000635e <consoleread>
    80006682:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80006684:	00000717          	auipc	a4,0x0
    80006688:	c7870713          	addi	a4,a4,-904 # 800062fc <consolewrite>
    8000668c:	ef98                	sd	a4,24(a5)
}
    8000668e:	60a2                	ld	ra,8(sp)
    80006690:	6402                	ld	s0,0(sp)
    80006692:	0141                	addi	sp,sp,16
    80006694:	8082                	ret

0000000080006696 <printint>:
  int locking;
} pr;

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign) {
    80006696:	7179                	addi	sp,sp,-48
    80006698:	f406                	sd	ra,40(sp)
    8000669a:	f022                	sd	s0,32(sp)
    8000669c:	ec26                	sd	s1,24(sp)
    8000669e:	e84a                	sd	s2,16(sp)
    800066a0:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if (sign && (sign = xx < 0))
    800066a2:	c219                	beqz	a2,800066a8 <printint+0x12>
    800066a4:	08054663          	bltz	a0,80006730 <printint+0x9a>
    x = -xx;
  else
    x = xx;
    800066a8:	2501                	sext.w	a0,a0
    800066aa:	4881                	li	a7,0
    800066ac:	fd040693          	addi	a3,s0,-48

  i = 0;
    800066b0:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800066b2:	2581                	sext.w	a1,a1
    800066b4:	00002617          	auipc	a2,0x2
    800066b8:	29c60613          	addi	a2,a2,668 # 80008950 <digits>
    800066bc:	883a                	mv	a6,a4
    800066be:	2705                	addiw	a4,a4,1
    800066c0:	02b577bb          	remuw	a5,a0,a1
    800066c4:	1782                	slli	a5,a5,0x20
    800066c6:	9381                	srli	a5,a5,0x20
    800066c8:	97b2                	add	a5,a5,a2
    800066ca:	0007c783          	lbu	a5,0(a5)
    800066ce:	00f68023          	sb	a5,0(a3)
  } while ((x /= base) != 0);
    800066d2:	0005079b          	sext.w	a5,a0
    800066d6:	02b5553b          	divuw	a0,a0,a1
    800066da:	0685                	addi	a3,a3,1
    800066dc:	feb7f0e3          	bgeu	a5,a1,800066bc <printint+0x26>

  if (sign) buf[i++] = '-';
    800066e0:	00088b63          	beqz	a7,800066f6 <printint+0x60>
    800066e4:	fe040793          	addi	a5,s0,-32
    800066e8:	973e                	add	a4,a4,a5
    800066ea:	02d00793          	li	a5,45
    800066ee:	fef70823          	sb	a5,-16(a4)
    800066f2:	0028071b          	addiw	a4,a6,2

  while (--i >= 0) consputc(buf[i]);
    800066f6:	02e05763          	blez	a4,80006724 <printint+0x8e>
    800066fa:	fd040793          	addi	a5,s0,-48
    800066fe:	00e784b3          	add	s1,a5,a4
    80006702:	fff78913          	addi	s2,a5,-1
    80006706:	993a                	add	s2,s2,a4
    80006708:	377d                	addiw	a4,a4,-1
    8000670a:	1702                	slli	a4,a4,0x20
    8000670c:	9301                	srli	a4,a4,0x20
    8000670e:	40e90933          	sub	s2,s2,a4
    80006712:	fff4c503          	lbu	a0,-1(s1)
    80006716:	00000097          	auipc	ra,0x0
    8000671a:	d60080e7          	jalr	-672(ra) # 80006476 <consputc>
    8000671e:	14fd                	addi	s1,s1,-1
    80006720:	ff2499e3          	bne	s1,s2,80006712 <printint+0x7c>
}
    80006724:	70a2                	ld	ra,40(sp)
    80006726:	7402                	ld	s0,32(sp)
    80006728:	64e2                	ld	s1,24(sp)
    8000672a:	6942                	ld	s2,16(sp)
    8000672c:	6145                	addi	sp,sp,48
    8000672e:	8082                	ret
    x = -xx;
    80006730:	40a0053b          	negw	a0,a0
  if (sign && (sign = xx < 0))
    80006734:	4885                	li	a7,1
    x = -xx;
    80006736:	bf9d                	j	800066ac <printint+0x16>

0000000080006738 <panic>:
  va_end(ap);

  if (locking) release(&pr.lock);
}

void panic(char *s) {
    80006738:	1101                	addi	sp,sp,-32
    8000673a:	ec06                	sd	ra,24(sp)
    8000673c:	e822                	sd	s0,16(sp)
    8000673e:	e426                	sd	s1,8(sp)
    80006740:	1000                	addi	s0,sp,32
    80006742:	84aa                	mv	s1,a0
  pr.locking = 0;
    80006744:	0001a797          	auipc	a5,0x1a
    80006748:	7607a623          	sw	zero,1900(a5) # 80020eb0 <pr+0x18>
  printf("panic: ");
    8000674c:	00002517          	auipc	a0,0x2
    80006750:	1dc50513          	addi	a0,a0,476 # 80008928 <syscalls+0x528>
    80006754:	00000097          	auipc	ra,0x0
    80006758:	02e080e7          	jalr	46(ra) # 80006782 <printf>
  printf(s);
    8000675c:	8526                	mv	a0,s1
    8000675e:	00000097          	auipc	ra,0x0
    80006762:	024080e7          	jalr	36(ra) # 80006782 <printf>
  printf("\n");
    80006766:	00002517          	auipc	a0,0x2
    8000676a:	8d250513          	addi	a0,a0,-1838 # 80008038 <etext+0x38>
    8000676e:	00000097          	auipc	ra,0x0
    80006772:	014080e7          	jalr	20(ra) # 80006782 <printf>
  panicked = 1;  // freeze uart output from other CPUs
    80006776:	4785                	li	a5,1
    80006778:	00002717          	auipc	a4,0x2
    8000677c:	2af72623          	sw	a5,684(a4) # 80008a24 <panicked>
  for (;;)
    80006780:	a001                	j	80006780 <panic+0x48>

0000000080006782 <printf>:
void printf(char *fmt, ...) {
    80006782:	7131                	addi	sp,sp,-192
    80006784:	fc86                	sd	ra,120(sp)
    80006786:	f8a2                	sd	s0,112(sp)
    80006788:	f4a6                	sd	s1,104(sp)
    8000678a:	f0ca                	sd	s2,96(sp)
    8000678c:	ecce                	sd	s3,88(sp)
    8000678e:	e8d2                	sd	s4,80(sp)
    80006790:	e4d6                	sd	s5,72(sp)
    80006792:	e0da                	sd	s6,64(sp)
    80006794:	fc5e                	sd	s7,56(sp)
    80006796:	f862                	sd	s8,48(sp)
    80006798:	f466                	sd	s9,40(sp)
    8000679a:	f06a                	sd	s10,32(sp)
    8000679c:	ec6e                	sd	s11,24(sp)
    8000679e:	0100                	addi	s0,sp,128
    800067a0:	8a2a                	mv	s4,a0
    800067a2:	e40c                	sd	a1,8(s0)
    800067a4:	e810                	sd	a2,16(s0)
    800067a6:	ec14                	sd	a3,24(s0)
    800067a8:	f018                	sd	a4,32(s0)
    800067aa:	f41c                	sd	a5,40(s0)
    800067ac:	03043823          	sd	a6,48(s0)
    800067b0:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800067b4:	0001ad97          	auipc	s11,0x1a
    800067b8:	6fcdad83          	lw	s11,1788(s11) # 80020eb0 <pr+0x18>
  if (locking) acquire(&pr.lock);
    800067bc:	020d9b63          	bnez	s11,800067f2 <printf+0x70>
  if (fmt == 0) panic("null fmt");
    800067c0:	040a0263          	beqz	s4,80006804 <printf+0x82>
  va_start(ap, fmt);
    800067c4:	00840793          	addi	a5,s0,8
    800067c8:	f8f43423          	sd	a5,-120(s0)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    800067cc:	000a4503          	lbu	a0,0(s4)
    800067d0:	14050f63          	beqz	a0,8000692e <printf+0x1ac>
    800067d4:	4981                	li	s3,0
    if (c != '%') {
    800067d6:	02500a93          	li	s5,37
    switch (c) {
    800067da:	07000b93          	li	s7,112
  consputc('x');
    800067de:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800067e0:	00002b17          	auipc	s6,0x2
    800067e4:	170b0b13          	addi	s6,s6,368 # 80008950 <digits>
    switch (c) {
    800067e8:	07300c93          	li	s9,115
    800067ec:	06400c13          	li	s8,100
    800067f0:	a82d                	j	8000682a <printf+0xa8>
  if (locking) acquire(&pr.lock);
    800067f2:	0001a517          	auipc	a0,0x1a
    800067f6:	6a650513          	addi	a0,a0,1702 # 80020e98 <pr>
    800067fa:	00000097          	auipc	ra,0x0
    800067fe:	47a080e7          	jalr	1146(ra) # 80006c74 <acquire>
    80006802:	bf7d                	j	800067c0 <printf+0x3e>
  if (fmt == 0) panic("null fmt");
    80006804:	00002517          	auipc	a0,0x2
    80006808:	13450513          	addi	a0,a0,308 # 80008938 <syscalls+0x538>
    8000680c:	00000097          	auipc	ra,0x0
    80006810:	f2c080e7          	jalr	-212(ra) # 80006738 <panic>
      consputc(c);
    80006814:	00000097          	auipc	ra,0x0
    80006818:	c62080e7          	jalr	-926(ra) # 80006476 <consputc>
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    8000681c:	2985                	addiw	s3,s3,1
    8000681e:	013a07b3          	add	a5,s4,s3
    80006822:	0007c503          	lbu	a0,0(a5)
    80006826:	10050463          	beqz	a0,8000692e <printf+0x1ac>
    if (c != '%') {
    8000682a:	ff5515e3          	bne	a0,s5,80006814 <printf+0x92>
    c = fmt[++i] & 0xff;
    8000682e:	2985                	addiw	s3,s3,1
    80006830:	013a07b3          	add	a5,s4,s3
    80006834:	0007c783          	lbu	a5,0(a5)
    80006838:	0007849b          	sext.w	s1,a5
    if (c == 0) break;
    8000683c:	cbed                	beqz	a5,8000692e <printf+0x1ac>
    switch (c) {
    8000683e:	05778a63          	beq	a5,s7,80006892 <printf+0x110>
    80006842:	02fbf663          	bgeu	s7,a5,8000686e <printf+0xec>
    80006846:	09978863          	beq	a5,s9,800068d6 <printf+0x154>
    8000684a:	07800713          	li	a4,120
    8000684e:	0ce79563          	bne	a5,a4,80006918 <printf+0x196>
        printint(va_arg(ap, int), 16, 1);
    80006852:	f8843783          	ld	a5,-120(s0)
    80006856:	00878713          	addi	a4,a5,8
    8000685a:	f8e43423          	sd	a4,-120(s0)
    8000685e:	4605                	li	a2,1
    80006860:	85ea                	mv	a1,s10
    80006862:	4388                	lw	a0,0(a5)
    80006864:	00000097          	auipc	ra,0x0
    80006868:	e32080e7          	jalr	-462(ra) # 80006696 <printint>
        break;
    8000686c:	bf45                	j	8000681c <printf+0x9a>
    switch (c) {
    8000686e:	09578f63          	beq	a5,s5,8000690c <printf+0x18a>
    80006872:	0b879363          	bne	a5,s8,80006918 <printf+0x196>
        printint(va_arg(ap, int), 10, 1);
    80006876:	f8843783          	ld	a5,-120(s0)
    8000687a:	00878713          	addi	a4,a5,8
    8000687e:	f8e43423          	sd	a4,-120(s0)
    80006882:	4605                	li	a2,1
    80006884:	45a9                	li	a1,10
    80006886:	4388                	lw	a0,0(a5)
    80006888:	00000097          	auipc	ra,0x0
    8000688c:	e0e080e7          	jalr	-498(ra) # 80006696 <printint>
        break;
    80006890:	b771                	j	8000681c <printf+0x9a>
        printptr(va_arg(ap, uint64));
    80006892:	f8843783          	ld	a5,-120(s0)
    80006896:	00878713          	addi	a4,a5,8
    8000689a:	f8e43423          	sd	a4,-120(s0)
    8000689e:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800068a2:	03000513          	li	a0,48
    800068a6:	00000097          	auipc	ra,0x0
    800068aa:	bd0080e7          	jalr	-1072(ra) # 80006476 <consputc>
  consputc('x');
    800068ae:	07800513          	li	a0,120
    800068b2:	00000097          	auipc	ra,0x0
    800068b6:	bc4080e7          	jalr	-1084(ra) # 80006476 <consputc>
    800068ba:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800068bc:	03c95793          	srli	a5,s2,0x3c
    800068c0:	97da                	add	a5,a5,s6
    800068c2:	0007c503          	lbu	a0,0(a5)
    800068c6:	00000097          	auipc	ra,0x0
    800068ca:	bb0080e7          	jalr	-1104(ra) # 80006476 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800068ce:	0912                	slli	s2,s2,0x4
    800068d0:	34fd                	addiw	s1,s1,-1
    800068d2:	f4ed                	bnez	s1,800068bc <printf+0x13a>
    800068d4:	b7a1                	j	8000681c <printf+0x9a>
        if ((s = va_arg(ap, char *)) == 0) s = "(null)";
    800068d6:	f8843783          	ld	a5,-120(s0)
    800068da:	00878713          	addi	a4,a5,8
    800068de:	f8e43423          	sd	a4,-120(s0)
    800068e2:	6384                	ld	s1,0(a5)
    800068e4:	cc89                	beqz	s1,800068fe <printf+0x17c>
        for (; *s; s++) consputc(*s);
    800068e6:	0004c503          	lbu	a0,0(s1)
    800068ea:	d90d                	beqz	a0,8000681c <printf+0x9a>
    800068ec:	00000097          	auipc	ra,0x0
    800068f0:	b8a080e7          	jalr	-1142(ra) # 80006476 <consputc>
    800068f4:	0485                	addi	s1,s1,1
    800068f6:	0004c503          	lbu	a0,0(s1)
    800068fa:	f96d                	bnez	a0,800068ec <printf+0x16a>
    800068fc:	b705                	j	8000681c <printf+0x9a>
        if ((s = va_arg(ap, char *)) == 0) s = "(null)";
    800068fe:	00002497          	auipc	s1,0x2
    80006902:	03248493          	addi	s1,s1,50 # 80008930 <syscalls+0x530>
        for (; *s; s++) consputc(*s);
    80006906:	02800513          	li	a0,40
    8000690a:	b7cd                	j	800068ec <printf+0x16a>
        consputc('%');
    8000690c:	8556                	mv	a0,s5
    8000690e:	00000097          	auipc	ra,0x0
    80006912:	b68080e7          	jalr	-1176(ra) # 80006476 <consputc>
        break;
    80006916:	b719                	j	8000681c <printf+0x9a>
        consputc('%');
    80006918:	8556                	mv	a0,s5
    8000691a:	00000097          	auipc	ra,0x0
    8000691e:	b5c080e7          	jalr	-1188(ra) # 80006476 <consputc>
        consputc(c);
    80006922:	8526                	mv	a0,s1
    80006924:	00000097          	auipc	ra,0x0
    80006928:	b52080e7          	jalr	-1198(ra) # 80006476 <consputc>
        break;
    8000692c:	bdc5                	j	8000681c <printf+0x9a>
  if (locking) release(&pr.lock);
    8000692e:	020d9163          	bnez	s11,80006950 <printf+0x1ce>
}
    80006932:	70e6                	ld	ra,120(sp)
    80006934:	7446                	ld	s0,112(sp)
    80006936:	74a6                	ld	s1,104(sp)
    80006938:	7906                	ld	s2,96(sp)
    8000693a:	69e6                	ld	s3,88(sp)
    8000693c:	6a46                	ld	s4,80(sp)
    8000693e:	6aa6                	ld	s5,72(sp)
    80006940:	6b06                	ld	s6,64(sp)
    80006942:	7be2                	ld	s7,56(sp)
    80006944:	7c42                	ld	s8,48(sp)
    80006946:	7ca2                	ld	s9,40(sp)
    80006948:	7d02                	ld	s10,32(sp)
    8000694a:	6de2                	ld	s11,24(sp)
    8000694c:	6129                	addi	sp,sp,192
    8000694e:	8082                	ret
  if (locking) release(&pr.lock);
    80006950:	0001a517          	auipc	a0,0x1a
    80006954:	54850513          	addi	a0,a0,1352 # 80020e98 <pr>
    80006958:	00000097          	auipc	ra,0x0
    8000695c:	3d0080e7          	jalr	976(ra) # 80006d28 <release>
}
    80006960:	bfc9                	j	80006932 <printf+0x1b0>

0000000080006962 <printfinit>:
    ;
}

void printfinit(void) {
    80006962:	1101                	addi	sp,sp,-32
    80006964:	ec06                	sd	ra,24(sp)
    80006966:	e822                	sd	s0,16(sp)
    80006968:	e426                	sd	s1,8(sp)
    8000696a:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    8000696c:	0001a497          	auipc	s1,0x1a
    80006970:	52c48493          	addi	s1,s1,1324 # 80020e98 <pr>
    80006974:	00002597          	auipc	a1,0x2
    80006978:	fd458593          	addi	a1,a1,-44 # 80008948 <syscalls+0x548>
    8000697c:	8526                	mv	a0,s1
    8000697e:	00000097          	auipc	ra,0x0
    80006982:	266080e7          	jalr	614(ra) # 80006be4 <initlock>
  pr.locking = 1;
    80006986:	4785                	li	a5,1
    80006988:	cc9c                	sw	a5,24(s1)
}
    8000698a:	60e2                	ld	ra,24(sp)
    8000698c:	6442                	ld	s0,16(sp)
    8000698e:	64a2                	ld	s1,8(sp)
    80006990:	6105                	addi	sp,sp,32
    80006992:	8082                	ret

0000000080006994 <uartinit>:

extern volatile int panicked;  // from printf.c

void uartstart();

void uartinit(void) {
    80006994:	1141                	addi	sp,sp,-16
    80006996:	e406                	sd	ra,8(sp)
    80006998:	e022                	sd	s0,0(sp)
    8000699a:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000699c:	100007b7          	lui	a5,0x10000
    800069a0:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800069a4:	f8000713          	li	a4,-128
    800069a8:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800069ac:	470d                	li	a4,3
    800069ae:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800069b2:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800069b6:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800069ba:	469d                	li	a3,7
    800069bc:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800069c0:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800069c4:	00002597          	auipc	a1,0x2
    800069c8:	fa458593          	addi	a1,a1,-92 # 80008968 <digits+0x18>
    800069cc:	0001a517          	auipc	a0,0x1a
    800069d0:	4ec50513          	addi	a0,a0,1260 # 80020eb8 <uart_tx_lock>
    800069d4:	00000097          	auipc	ra,0x0
    800069d8:	210080e7          	jalr	528(ra) # 80006be4 <initlock>
}
    800069dc:	60a2                	ld	ra,8(sp)
    800069de:	6402                	ld	s0,0(sp)
    800069e0:	0141                	addi	sp,sp,16
    800069e2:	8082                	ret

00000000800069e4 <uartputc_sync>:

// alternate version of uartputc() that doesn't
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void uartputc_sync(int c) {
    800069e4:	1101                	addi	sp,sp,-32
    800069e6:	ec06                	sd	ra,24(sp)
    800069e8:	e822                	sd	s0,16(sp)
    800069ea:	e426                	sd	s1,8(sp)
    800069ec:	1000                	addi	s0,sp,32
    800069ee:	84aa                	mv	s1,a0
  push_off();
    800069f0:	00000097          	auipc	ra,0x0
    800069f4:	238080e7          	jalr	568(ra) # 80006c28 <push_off>

  if (panicked) {
    800069f8:	00002797          	auipc	a5,0x2
    800069fc:	02c7a783          	lw	a5,44(a5) # 80008a24 <panicked>
    for (;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while ((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006a00:	10000737          	lui	a4,0x10000
  if (panicked) {
    80006a04:	c391                	beqz	a5,80006a08 <uartputc_sync+0x24>
    for (;;)
    80006a06:	a001                	j	80006a06 <uartputc_sync+0x22>
  while ((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006a08:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80006a0c:	0207f793          	andi	a5,a5,32
    80006a10:	dfe5                	beqz	a5,80006a08 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80006a12:	0ff4f513          	andi	a0,s1,255
    80006a16:	100007b7          	lui	a5,0x10000
    80006a1a:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80006a1e:	00000097          	auipc	ra,0x0
    80006a22:	2aa080e7          	jalr	682(ra) # 80006cc8 <pop_off>
}
    80006a26:	60e2                	ld	ra,24(sp)
    80006a28:	6442                	ld	s0,16(sp)
    80006a2a:	64a2                	ld	s1,8(sp)
    80006a2c:	6105                	addi	sp,sp,32
    80006a2e:	8082                	ret

0000000080006a30 <uartstart>:
// in the transmit buffer, send it.
// caller must hold uart_tx_lock.
// called from both the top- and bottom-half.
void uartstart() {
  while (1) {
    if (uart_tx_w == uart_tx_r) {
    80006a30:	00002797          	auipc	a5,0x2
    80006a34:	ff87b783          	ld	a5,-8(a5) # 80008a28 <uart_tx_r>
    80006a38:	00002717          	auipc	a4,0x2
    80006a3c:	ff873703          	ld	a4,-8(a4) # 80008a30 <uart_tx_w>
    80006a40:	06f70a63          	beq	a4,a5,80006ab4 <uartstart+0x84>
void uartstart() {
    80006a44:	7139                	addi	sp,sp,-64
    80006a46:	fc06                	sd	ra,56(sp)
    80006a48:	f822                	sd	s0,48(sp)
    80006a4a:	f426                	sd	s1,40(sp)
    80006a4c:	f04a                	sd	s2,32(sp)
    80006a4e:	ec4e                	sd	s3,24(sp)
    80006a50:	e852                	sd	s4,16(sp)
    80006a52:	e456                	sd	s5,8(sp)
    80006a54:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }

    if ((ReadReg(LSR) & LSR_TX_IDLE) == 0) {
    80006a56:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }

    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006a5a:	0001aa17          	auipc	s4,0x1a
    80006a5e:	45ea0a13          	addi	s4,s4,1118 # 80020eb8 <uart_tx_lock>
    uart_tx_r += 1;
    80006a62:	00002497          	auipc	s1,0x2
    80006a66:	fc648493          	addi	s1,s1,-58 # 80008a28 <uart_tx_r>
    if (uart_tx_w == uart_tx_r) {
    80006a6a:	00002997          	auipc	s3,0x2
    80006a6e:	fc698993          	addi	s3,s3,-58 # 80008a30 <uart_tx_w>
    if ((ReadReg(LSR) & LSR_TX_IDLE) == 0) {
    80006a72:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    80006a76:	02077713          	andi	a4,a4,32
    80006a7a:	c705                	beqz	a4,80006aa2 <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006a7c:	01f7f713          	andi	a4,a5,31
    80006a80:	9752                	add	a4,a4,s4
    80006a82:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    80006a86:	0785                	addi	a5,a5,1
    80006a88:	e09c                	sd	a5,0(s1)

    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80006a8a:	8526                	mv	a0,s1
    80006a8c:	ffffb097          	auipc	ra,0xffffb
    80006a90:	a2c080e7          	jalr	-1492(ra) # 800014b8 <wakeup>

    WriteReg(THR, c);
    80006a94:	01590023          	sb	s5,0(s2)
    if (uart_tx_w == uart_tx_r) {
    80006a98:	609c                	ld	a5,0(s1)
    80006a9a:	0009b703          	ld	a4,0(s3)
    80006a9e:	fcf71ae3          	bne	a4,a5,80006a72 <uartstart+0x42>
  }
}
    80006aa2:	70e2                	ld	ra,56(sp)
    80006aa4:	7442                	ld	s0,48(sp)
    80006aa6:	74a2                	ld	s1,40(sp)
    80006aa8:	7902                	ld	s2,32(sp)
    80006aaa:	69e2                	ld	s3,24(sp)
    80006aac:	6a42                	ld	s4,16(sp)
    80006aae:	6aa2                	ld	s5,8(sp)
    80006ab0:	6121                	addi	sp,sp,64
    80006ab2:	8082                	ret
    80006ab4:	8082                	ret

0000000080006ab6 <uartputc>:
void uartputc(int c) {
    80006ab6:	7179                	addi	sp,sp,-48
    80006ab8:	f406                	sd	ra,40(sp)
    80006aba:	f022                	sd	s0,32(sp)
    80006abc:	ec26                	sd	s1,24(sp)
    80006abe:	e84a                	sd	s2,16(sp)
    80006ac0:	e44e                	sd	s3,8(sp)
    80006ac2:	e052                	sd	s4,0(sp)
    80006ac4:	1800                	addi	s0,sp,48
    80006ac6:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80006ac8:	0001a517          	auipc	a0,0x1a
    80006acc:	3f050513          	addi	a0,a0,1008 # 80020eb8 <uart_tx_lock>
    80006ad0:	00000097          	auipc	ra,0x0
    80006ad4:	1a4080e7          	jalr	420(ra) # 80006c74 <acquire>
  if (panicked) {
    80006ad8:	00002797          	auipc	a5,0x2
    80006adc:	f4c7a783          	lw	a5,-180(a5) # 80008a24 <panicked>
    80006ae0:	e7c9                	bnez	a5,80006b6a <uartputc+0xb4>
  while (uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE) {
    80006ae2:	00002717          	auipc	a4,0x2
    80006ae6:	f4e73703          	ld	a4,-178(a4) # 80008a30 <uart_tx_w>
    80006aea:	00002797          	auipc	a5,0x2
    80006aee:	f3e7b783          	ld	a5,-194(a5) # 80008a28 <uart_tx_r>
    80006af2:	02078793          	addi	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    80006af6:	0001a997          	auipc	s3,0x1a
    80006afa:	3c298993          	addi	s3,s3,962 # 80020eb8 <uart_tx_lock>
    80006afe:	00002497          	auipc	s1,0x2
    80006b02:	f2a48493          	addi	s1,s1,-214 # 80008a28 <uart_tx_r>
  while (uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE) {
    80006b06:	00002917          	auipc	s2,0x2
    80006b0a:	f2a90913          	addi	s2,s2,-214 # 80008a30 <uart_tx_w>
    80006b0e:	00e79f63          	bne	a5,a4,80006b2c <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    80006b12:	85ce                	mv	a1,s3
    80006b14:	8526                	mv	a0,s1
    80006b16:	ffffb097          	auipc	ra,0xffffb
    80006b1a:	93e080e7          	jalr	-1730(ra) # 80001454 <sleep>
  while (uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE) {
    80006b1e:	00093703          	ld	a4,0(s2)
    80006b22:	609c                	ld	a5,0(s1)
    80006b24:	02078793          	addi	a5,a5,32
    80006b28:	fee785e3          	beq	a5,a4,80006b12 <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80006b2c:	0001a497          	auipc	s1,0x1a
    80006b30:	38c48493          	addi	s1,s1,908 # 80020eb8 <uart_tx_lock>
    80006b34:	01f77793          	andi	a5,a4,31
    80006b38:	97a6                	add	a5,a5,s1
    80006b3a:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    80006b3e:	0705                	addi	a4,a4,1
    80006b40:	00002797          	auipc	a5,0x2
    80006b44:	eee7b823          	sd	a4,-272(a5) # 80008a30 <uart_tx_w>
  uartstart();
    80006b48:	00000097          	auipc	ra,0x0
    80006b4c:	ee8080e7          	jalr	-280(ra) # 80006a30 <uartstart>
  release(&uart_tx_lock);
    80006b50:	8526                	mv	a0,s1
    80006b52:	00000097          	auipc	ra,0x0
    80006b56:	1d6080e7          	jalr	470(ra) # 80006d28 <release>
}
    80006b5a:	70a2                	ld	ra,40(sp)
    80006b5c:	7402                	ld	s0,32(sp)
    80006b5e:	64e2                	ld	s1,24(sp)
    80006b60:	6942                	ld	s2,16(sp)
    80006b62:	69a2                	ld	s3,8(sp)
    80006b64:	6a02                	ld	s4,0(sp)
    80006b66:	6145                	addi	sp,sp,48
    80006b68:	8082                	ret
    for (;;)
    80006b6a:	a001                	j	80006b6a <uartputc+0xb4>

0000000080006b6c <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int uartgetc(void) {
    80006b6c:	1141                	addi	sp,sp,-16
    80006b6e:	e422                	sd	s0,8(sp)
    80006b70:	0800                	addi	s0,sp,16
  if (ReadReg(LSR) & 0x01) {
    80006b72:	100007b7          	lui	a5,0x10000
    80006b76:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006b7a:	8b85                	andi	a5,a5,1
    80006b7c:	cb91                	beqz	a5,80006b90 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80006b7e:	100007b7          	lui	a5,0x10000
    80006b82:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    80006b86:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    80006b8a:	6422                	ld	s0,8(sp)
    80006b8c:	0141                	addi	sp,sp,16
    80006b8e:	8082                	ret
    return -1;
    80006b90:	557d                	li	a0,-1
    80006b92:	bfe5                	j	80006b8a <uartgetc+0x1e>

0000000080006b94 <uartintr>:

// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void uartintr(void) {
    80006b94:	1101                	addi	sp,sp,-32
    80006b96:	ec06                	sd	ra,24(sp)
    80006b98:	e822                	sd	s0,16(sp)
    80006b9a:	e426                	sd	s1,8(sp)
    80006b9c:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while (1) {
    int c = uartgetc();
    if (c == -1) break;
    80006b9e:	54fd                	li	s1,-1
    80006ba0:	a029                	j	80006baa <uartintr+0x16>
    consoleintr(c);
    80006ba2:	00000097          	auipc	ra,0x0
    80006ba6:	916080e7          	jalr	-1770(ra) # 800064b8 <consoleintr>
    int c = uartgetc();
    80006baa:	00000097          	auipc	ra,0x0
    80006bae:	fc2080e7          	jalr	-62(ra) # 80006b6c <uartgetc>
    if (c == -1) break;
    80006bb2:	fe9518e3          	bne	a0,s1,80006ba2 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80006bb6:	0001a497          	auipc	s1,0x1a
    80006bba:	30248493          	addi	s1,s1,770 # 80020eb8 <uart_tx_lock>
    80006bbe:	8526                	mv	a0,s1
    80006bc0:	00000097          	auipc	ra,0x0
    80006bc4:	0b4080e7          	jalr	180(ra) # 80006c74 <acquire>
  uartstart();
    80006bc8:	00000097          	auipc	ra,0x0
    80006bcc:	e68080e7          	jalr	-408(ra) # 80006a30 <uartstart>
  release(&uart_tx_lock);
    80006bd0:	8526                	mv	a0,s1
    80006bd2:	00000097          	auipc	ra,0x0
    80006bd6:	156080e7          	jalr	342(ra) # 80006d28 <release>
}
    80006bda:	60e2                	ld	ra,24(sp)
    80006bdc:	6442                	ld	s0,16(sp)
    80006bde:	64a2                	ld	s1,8(sp)
    80006be0:	6105                	addi	sp,sp,32
    80006be2:	8082                	ret

0000000080006be4 <initlock>:

#include "defs.h"
#include "proc.h"
#include "riscv.h"

void initlock(struct spinlock *lk, char *name) {
    80006be4:	1141                	addi	sp,sp,-16
    80006be6:	e422                	sd	s0,8(sp)
    80006be8:	0800                	addi	s0,sp,16
  lk->name = name;
    80006bea:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006bec:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006bf0:	00053823          	sd	zero,16(a0)
}
    80006bf4:	6422                	ld	s0,8(sp)
    80006bf6:	0141                	addi	sp,sp,16
    80006bf8:	8082                	ret

0000000080006bfa <holding>:

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int holding(struct spinlock *lk) {
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80006bfa:	411c                	lw	a5,0(a0)
    80006bfc:	e399                	bnez	a5,80006c02 <holding+0x8>
    80006bfe:	4501                	li	a0,0
  return r;
}
    80006c00:	8082                	ret
int holding(struct spinlock *lk) {
    80006c02:	1101                	addi	sp,sp,-32
    80006c04:	ec06                	sd	ra,24(sp)
    80006c06:	e822                	sd	s0,16(sp)
    80006c08:	e426                	sd	s1,8(sp)
    80006c0a:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80006c0c:	6904                	ld	s1,16(a0)
    80006c0e:	ffffa097          	auipc	ra,0xffffa
    80006c12:	17e080e7          	jalr	382(ra) # 80000d8c <mycpu>
    80006c16:	40a48533          	sub	a0,s1,a0
    80006c1a:	00153513          	seqz	a0,a0
}
    80006c1e:	60e2                	ld	ra,24(sp)
    80006c20:	6442                	ld	s0,16(sp)
    80006c22:	64a2                	ld	s1,8(sp)
    80006c24:	6105                	addi	sp,sp,32
    80006c26:	8082                	ret

0000000080006c28 <push_off>:

// push_off/pop_off are like intr_off()/intr_on() except that they are matched:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void push_off(void) {
    80006c28:	1101                	addi	sp,sp,-32
    80006c2a:	ec06                	sd	ra,24(sp)
    80006c2c:	e822                	sd	s0,16(sp)
    80006c2e:	e426                	sd	s1,8(sp)
    80006c30:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80006c32:	100024f3          	csrr	s1,sstatus
    80006c36:	100027f3          	csrr	a5,sstatus
static inline void intr_off() { w_sstatus(r_sstatus() & ~SSTATUS_SIE); }
    80006c3a:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r"(x));
    80006c3c:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if (mycpu()->noff == 0) mycpu()->intena = old;
    80006c40:	ffffa097          	auipc	ra,0xffffa
    80006c44:	14c080e7          	jalr	332(ra) # 80000d8c <mycpu>
    80006c48:	5d3c                	lw	a5,120(a0)
    80006c4a:	cf89                	beqz	a5,80006c64 <push_off+0x3c>
  mycpu()->noff += 1;
    80006c4c:	ffffa097          	auipc	ra,0xffffa
    80006c50:	140080e7          	jalr	320(ra) # 80000d8c <mycpu>
    80006c54:	5d3c                	lw	a5,120(a0)
    80006c56:	2785                	addiw	a5,a5,1
    80006c58:	dd3c                	sw	a5,120(a0)
}
    80006c5a:	60e2                	ld	ra,24(sp)
    80006c5c:	6442                	ld	s0,16(sp)
    80006c5e:	64a2                	ld	s1,8(sp)
    80006c60:	6105                	addi	sp,sp,32
    80006c62:	8082                	ret
  if (mycpu()->noff == 0) mycpu()->intena = old;
    80006c64:	ffffa097          	auipc	ra,0xffffa
    80006c68:	128080e7          	jalr	296(ra) # 80000d8c <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006c6c:	8085                	srli	s1,s1,0x1
    80006c6e:	8885                	andi	s1,s1,1
    80006c70:	dd64                	sw	s1,124(a0)
    80006c72:	bfe9                	j	80006c4c <push_off+0x24>

0000000080006c74 <acquire>:
void acquire(struct spinlock *lk) {
    80006c74:	1101                	addi	sp,sp,-32
    80006c76:	ec06                	sd	ra,24(sp)
    80006c78:	e822                	sd	s0,16(sp)
    80006c7a:	e426                	sd	s1,8(sp)
    80006c7c:	1000                	addi	s0,sp,32
    80006c7e:	84aa                	mv	s1,a0
  push_off();  // disable interrupts to avoid deadlock.
    80006c80:	00000097          	auipc	ra,0x0
    80006c84:	fa8080e7          	jalr	-88(ra) # 80006c28 <push_off>
  if (holding(lk)) panic("acquire");
    80006c88:	8526                	mv	a0,s1
    80006c8a:	00000097          	auipc	ra,0x0
    80006c8e:	f70080e7          	jalr	-144(ra) # 80006bfa <holding>
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006c92:	4705                	li	a4,1
  if (holding(lk)) panic("acquire");
    80006c94:	e115                	bnez	a0,80006cb8 <acquire+0x44>
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006c96:	87ba                	mv	a5,a4
    80006c98:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006c9c:	2781                	sext.w	a5,a5
    80006c9e:	ffe5                	bnez	a5,80006c96 <acquire+0x22>
  __sync_synchronize();
    80006ca0:	0ff0000f          	fence
  lk->cpu = mycpu();
    80006ca4:	ffffa097          	auipc	ra,0xffffa
    80006ca8:	0e8080e7          	jalr	232(ra) # 80000d8c <mycpu>
    80006cac:	e888                	sd	a0,16(s1)
}
    80006cae:	60e2                	ld	ra,24(sp)
    80006cb0:	6442                	ld	s0,16(sp)
    80006cb2:	64a2                	ld	s1,8(sp)
    80006cb4:	6105                	addi	sp,sp,32
    80006cb6:	8082                	ret
  if (holding(lk)) panic("acquire");
    80006cb8:	00002517          	auipc	a0,0x2
    80006cbc:	cb850513          	addi	a0,a0,-840 # 80008970 <digits+0x20>
    80006cc0:	00000097          	auipc	ra,0x0
    80006cc4:	a78080e7          	jalr	-1416(ra) # 80006738 <panic>

0000000080006cc8 <pop_off>:

void pop_off(void) {
    80006cc8:	1141                	addi	sp,sp,-16
    80006cca:	e406                	sd	ra,8(sp)
    80006ccc:	e022                	sd	s0,0(sp)
    80006cce:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80006cd0:	ffffa097          	auipc	ra,0xffffa
    80006cd4:	0bc080e7          	jalr	188(ra) # 80000d8c <mycpu>
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80006cd8:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80006cdc:	8b89                	andi	a5,a5,2
  if (intr_get()) panic("pop_off - interruptible");
    80006cde:	e78d                	bnez	a5,80006d08 <pop_off+0x40>
  if (c->noff < 1) panic("pop_off");
    80006ce0:	5d3c                	lw	a5,120(a0)
    80006ce2:	02f05b63          	blez	a5,80006d18 <pop_off+0x50>
  c->noff -= 1;
    80006ce6:	37fd                	addiw	a5,a5,-1
    80006ce8:	0007871b          	sext.w	a4,a5
    80006cec:	dd3c                	sw	a5,120(a0)
  if (c->noff == 0 && c->intena) intr_on();
    80006cee:	eb09                	bnez	a4,80006d00 <pop_off+0x38>
    80006cf0:	5d7c                	lw	a5,124(a0)
    80006cf2:	c799                	beqz	a5,80006d00 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r"(x));
    80006cf4:	100027f3          	csrr	a5,sstatus
static inline void intr_on() { w_sstatus(r_sstatus() | SSTATUS_SIE); }
    80006cf8:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r"(x));
    80006cfc:	10079073          	csrw	sstatus,a5
}
    80006d00:	60a2                	ld	ra,8(sp)
    80006d02:	6402                	ld	s0,0(sp)
    80006d04:	0141                	addi	sp,sp,16
    80006d06:	8082                	ret
  if (intr_get()) panic("pop_off - interruptible");
    80006d08:	00002517          	auipc	a0,0x2
    80006d0c:	c7050513          	addi	a0,a0,-912 # 80008978 <digits+0x28>
    80006d10:	00000097          	auipc	ra,0x0
    80006d14:	a28080e7          	jalr	-1496(ra) # 80006738 <panic>
  if (c->noff < 1) panic("pop_off");
    80006d18:	00002517          	auipc	a0,0x2
    80006d1c:	c7850513          	addi	a0,a0,-904 # 80008990 <digits+0x40>
    80006d20:	00000097          	auipc	ra,0x0
    80006d24:	a18080e7          	jalr	-1512(ra) # 80006738 <panic>

0000000080006d28 <release>:
void release(struct spinlock *lk) {
    80006d28:	1101                	addi	sp,sp,-32
    80006d2a:	ec06                	sd	ra,24(sp)
    80006d2c:	e822                	sd	s0,16(sp)
    80006d2e:	e426                	sd	s1,8(sp)
    80006d30:	1000                	addi	s0,sp,32
    80006d32:	84aa                	mv	s1,a0
  if (!holding(lk)) panic("release");
    80006d34:	00000097          	auipc	ra,0x0
    80006d38:	ec6080e7          	jalr	-314(ra) # 80006bfa <holding>
    80006d3c:	c115                	beqz	a0,80006d60 <release+0x38>
  lk->cpu = 0;
    80006d3e:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80006d42:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80006d46:	0f50000f          	fence	iorw,ow
    80006d4a:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80006d4e:	00000097          	auipc	ra,0x0
    80006d52:	f7a080e7          	jalr	-134(ra) # 80006cc8 <pop_off>
}
    80006d56:	60e2                	ld	ra,24(sp)
    80006d58:	6442                	ld	s0,16(sp)
    80006d5a:	64a2                	ld	s1,8(sp)
    80006d5c:	6105                	addi	sp,sp,32
    80006d5e:	8082                	ret
  if (!holding(lk)) panic("release");
    80006d60:	00002517          	auipc	a0,0x2
    80006d64:	c3850513          	addi	a0,a0,-968 # 80008998 <digits+0x48>
    80006d68:	00000097          	auipc	ra,0x0
    80006d6c:	9d0080e7          	jalr	-1584(ra) # 80006738 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addiw	a0,a0,-1
    800070ae:	0536                	slli	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
