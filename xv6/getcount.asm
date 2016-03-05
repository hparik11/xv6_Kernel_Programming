
_getcount:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "syscall.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  printf(1, "initial fork count %d\n", getcount(SYS_fork));
   9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10:	e8 e9 03 00 00       	call   3fe <getcount>
  15:	89 44 24 08          	mov    %eax,0x8(%esp)
  19:	c7 44 24 04 da 08 00 	movl   $0x8da,0x4(%esp)
  20:	00 
  21:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  28:	e8 e1 04 00 00       	call   50e <printf>
  if (fork() == 0) {
  2d:	e8 24 03 00 00       	call   356 <fork>
  32:	85 c0                	test   %eax,%eax
  34:	75 4a                	jne    80 <main+0x80>
    printf(1, "child fork count %d\n", getcount(SYS_fork));
  36:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3d:	e8 bc 03 00 00       	call   3fe <getcount>
  42:	89 44 24 08          	mov    %eax,0x8(%esp)
  46:	c7 44 24 04 f1 08 00 	movl   $0x8f1,0x4(%esp)
  4d:	00 
  4e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  55:	e8 b4 04 00 00       	call   50e <printf>
    printf(1, "child write count %d\n", getcount(SYS_write));
  5a:	c7 04 24 10 00 00 00 	movl   $0x10,(%esp)
  61:	e8 98 03 00 00       	call   3fe <getcount>
  66:	89 44 24 08          	mov    %eax,0x8(%esp)
  6a:	c7 44 24 04 06 09 00 	movl   $0x906,0x4(%esp)
  71:	00 
  72:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  79:	e8 90 04 00 00       	call   50e <printf>
  7e:	eb 4d                	jmp    cd <main+0xcd>
  } else {
    wait();
  80:	e8 e1 02 00 00       	call   366 <wait>
    printf(1, "parent fork count %d\n", getcount(SYS_fork));
  85:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  8c:	e8 6d 03 00 00       	call   3fe <getcount>
  91:	89 44 24 08          	mov    %eax,0x8(%esp)
  95:	c7 44 24 04 1c 09 00 	movl   $0x91c,0x4(%esp)
  9c:	00 
  9d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a4:	e8 65 04 00 00       	call   50e <printf>
    printf(1, "parent write count %d\n", getcount(SYS_write));
  a9:	c7 04 24 10 00 00 00 	movl   $0x10,(%esp)
  b0:	e8 49 03 00 00       	call   3fe <getcount>
  b5:	89 44 24 08          	mov    %eax,0x8(%esp)
  b9:	c7 44 24 04 32 09 00 	movl   $0x932,0x4(%esp)
  c0:	00 
  c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c8:	e8 41 04 00 00       	call   50e <printf>
  }
  printf(1, "wait count %d\n", getcount(SYS_wait));
  cd:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  d4:	e8 25 03 00 00       	call   3fe <getcount>
  d9:	89 44 24 08          	mov    %eax,0x8(%esp)
  dd:	c7 44 24 04 49 09 00 	movl   $0x949,0x4(%esp)
  e4:	00 
  e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ec:	e8 1d 04 00 00       	call   50e <printf>
  exit();
  f1:	e8 68 02 00 00       	call   35e <exit>

000000f6 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  f6:	55                   	push   %ebp
  f7:	89 e5                	mov    %esp,%ebp
  f9:	57                   	push   %edi
  fa:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  fe:	8b 55 10             	mov    0x10(%ebp),%edx
 101:	8b 45 0c             	mov    0xc(%ebp),%eax
 104:	89 cb                	mov    %ecx,%ebx
 106:	89 df                	mov    %ebx,%edi
 108:	89 d1                	mov    %edx,%ecx
 10a:	fc                   	cld    
 10b:	f3 aa                	rep stos %al,%es:(%edi)
 10d:	89 ca                	mov    %ecx,%edx
 10f:	89 fb                	mov    %edi,%ebx
 111:	89 5d 08             	mov    %ebx,0x8(%ebp)
 114:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 117:	5b                   	pop    %ebx
 118:	5f                   	pop    %edi
 119:	5d                   	pop    %ebp
 11a:	c3                   	ret    

0000011b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 11b:	55                   	push   %ebp
 11c:	89 e5                	mov    %esp,%ebp
 11e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 121:	8b 45 08             	mov    0x8(%ebp),%eax
 124:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 127:	90                   	nop
 128:	8b 45 08             	mov    0x8(%ebp),%eax
 12b:	8d 50 01             	lea    0x1(%eax),%edx
 12e:	89 55 08             	mov    %edx,0x8(%ebp)
 131:	8b 55 0c             	mov    0xc(%ebp),%edx
 134:	8d 4a 01             	lea    0x1(%edx),%ecx
 137:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 13a:	0f b6 12             	movzbl (%edx),%edx
 13d:	88 10                	mov    %dl,(%eax)
 13f:	0f b6 00             	movzbl (%eax),%eax
 142:	84 c0                	test   %al,%al
 144:	75 e2                	jne    128 <strcpy+0xd>
    ;
  return os;
 146:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 149:	c9                   	leave  
 14a:	c3                   	ret    

0000014b <strcmp>:

int
strcmp(const char *p, const char *q)
{
 14b:	55                   	push   %ebp
 14c:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 14e:	eb 08                	jmp    158 <strcmp+0xd>
    p++, q++;
 150:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 154:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	0f b6 00             	movzbl (%eax),%eax
 15e:	84 c0                	test   %al,%al
 160:	74 10                	je     172 <strcmp+0x27>
 162:	8b 45 08             	mov    0x8(%ebp),%eax
 165:	0f b6 10             	movzbl (%eax),%edx
 168:	8b 45 0c             	mov    0xc(%ebp),%eax
 16b:	0f b6 00             	movzbl (%eax),%eax
 16e:	38 c2                	cmp    %al,%dl
 170:	74 de                	je     150 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 172:	8b 45 08             	mov    0x8(%ebp),%eax
 175:	0f b6 00             	movzbl (%eax),%eax
 178:	0f b6 d0             	movzbl %al,%edx
 17b:	8b 45 0c             	mov    0xc(%ebp),%eax
 17e:	0f b6 00             	movzbl (%eax),%eax
 181:	0f b6 c0             	movzbl %al,%eax
 184:	29 c2                	sub    %eax,%edx
 186:	89 d0                	mov    %edx,%eax
}
 188:	5d                   	pop    %ebp
 189:	c3                   	ret    

0000018a <strlen>:

uint
strlen(char *s)
{
 18a:	55                   	push   %ebp
 18b:	89 e5                	mov    %esp,%ebp
 18d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 190:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 197:	eb 04                	jmp    19d <strlen+0x13>
 199:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 19d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
 1a3:	01 d0                	add    %edx,%eax
 1a5:	0f b6 00             	movzbl (%eax),%eax
 1a8:	84 c0                	test   %al,%al
 1aa:	75 ed                	jne    199 <strlen+0xf>
    ;
  return n;
 1ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1af:	c9                   	leave  
 1b0:	c3                   	ret    

000001b1 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b1:	55                   	push   %ebp
 1b2:	89 e5                	mov    %esp,%ebp
 1b4:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1b7:	8b 45 10             	mov    0x10(%ebp),%eax
 1ba:	89 44 24 08          	mov    %eax,0x8(%esp)
 1be:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c1:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c5:	8b 45 08             	mov    0x8(%ebp),%eax
 1c8:	89 04 24             	mov    %eax,(%esp)
 1cb:	e8 26 ff ff ff       	call   f6 <stosb>
  return dst;
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d3:	c9                   	leave  
 1d4:	c3                   	ret    

000001d5 <strchr>:

char*
strchr(const char *s, char c)
{
 1d5:	55                   	push   %ebp
 1d6:	89 e5                	mov    %esp,%ebp
 1d8:	83 ec 04             	sub    $0x4,%esp
 1db:	8b 45 0c             	mov    0xc(%ebp),%eax
 1de:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1e1:	eb 14                	jmp    1f7 <strchr+0x22>
    if(*s == c)
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 00             	movzbl (%eax),%eax
 1e9:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1ec:	75 05                	jne    1f3 <strchr+0x1e>
      return (char*)s;
 1ee:	8b 45 08             	mov    0x8(%ebp),%eax
 1f1:	eb 13                	jmp    206 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1f3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	0f b6 00             	movzbl (%eax),%eax
 1fd:	84 c0                	test   %al,%al
 1ff:	75 e2                	jne    1e3 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 201:	b8 00 00 00 00       	mov    $0x0,%eax
}
 206:	c9                   	leave  
 207:	c3                   	ret    

00000208 <gets>:

char*
gets(char *buf, int max)
{
 208:	55                   	push   %ebp
 209:	89 e5                	mov    %esp,%ebp
 20b:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 215:	eb 4c                	jmp    263 <gets+0x5b>
    cc = read(0, &c, 1);
 217:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 21e:	00 
 21f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 222:	89 44 24 04          	mov    %eax,0x4(%esp)
 226:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 22d:	e8 44 01 00 00       	call   376 <read>
 232:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 235:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 239:	7f 02                	jg     23d <gets+0x35>
      break;
 23b:	eb 31                	jmp    26e <gets+0x66>
    buf[i++] = c;
 23d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 240:	8d 50 01             	lea    0x1(%eax),%edx
 243:	89 55 f4             	mov    %edx,-0xc(%ebp)
 246:	89 c2                	mov    %eax,%edx
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	01 c2                	add    %eax,%edx
 24d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 251:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 257:	3c 0a                	cmp    $0xa,%al
 259:	74 13                	je     26e <gets+0x66>
 25b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25f:	3c 0d                	cmp    $0xd,%al
 261:	74 0b                	je     26e <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 263:	8b 45 f4             	mov    -0xc(%ebp),%eax
 266:	83 c0 01             	add    $0x1,%eax
 269:	3b 45 0c             	cmp    0xc(%ebp),%eax
 26c:	7c a9                	jl     217 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 26e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 271:	8b 45 08             	mov    0x8(%ebp),%eax
 274:	01 d0                	add    %edx,%eax
 276:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 279:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27c:	c9                   	leave  
 27d:	c3                   	ret    

0000027e <stat>:

int
stat(char *n, struct stat *st)
{
 27e:	55                   	push   %ebp
 27f:	89 e5                	mov    %esp,%ebp
 281:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 284:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 28b:	00 
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	89 04 24             	mov    %eax,(%esp)
 292:	e8 07 01 00 00       	call   39e <open>
 297:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 29a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 29e:	79 07                	jns    2a7 <stat+0x29>
    return -1;
 2a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a5:	eb 23                	jmp    2ca <stat+0x4c>
  r = fstat(fd, st);
 2a7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2aa:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2b1:	89 04 24             	mov    %eax,(%esp)
 2b4:	e8 fd 00 00 00       	call   3b6 <fstat>
 2b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2bf:	89 04 24             	mov    %eax,(%esp)
 2c2:	e8 bf 00 00 00       	call   386 <close>
  return r;
 2c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2ca:	c9                   	leave  
 2cb:	c3                   	ret    

000002cc <atoi>:

int
atoi(const char *s)
{
 2cc:	55                   	push   %ebp
 2cd:	89 e5                	mov    %esp,%ebp
 2cf:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2d9:	eb 25                	jmp    300 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2db:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2de:	89 d0                	mov    %edx,%eax
 2e0:	c1 e0 02             	shl    $0x2,%eax
 2e3:	01 d0                	add    %edx,%eax
 2e5:	01 c0                	add    %eax,%eax
 2e7:	89 c1                	mov    %eax,%ecx
 2e9:	8b 45 08             	mov    0x8(%ebp),%eax
 2ec:	8d 50 01             	lea    0x1(%eax),%edx
 2ef:	89 55 08             	mov    %edx,0x8(%ebp)
 2f2:	0f b6 00             	movzbl (%eax),%eax
 2f5:	0f be c0             	movsbl %al,%eax
 2f8:	01 c8                	add    %ecx,%eax
 2fa:	83 e8 30             	sub    $0x30,%eax
 2fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 300:	8b 45 08             	mov    0x8(%ebp),%eax
 303:	0f b6 00             	movzbl (%eax),%eax
 306:	3c 2f                	cmp    $0x2f,%al
 308:	7e 0a                	jle    314 <atoi+0x48>
 30a:	8b 45 08             	mov    0x8(%ebp),%eax
 30d:	0f b6 00             	movzbl (%eax),%eax
 310:	3c 39                	cmp    $0x39,%al
 312:	7e c7                	jle    2db <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 314:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 317:	c9                   	leave  
 318:	c3                   	ret    

00000319 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 319:	55                   	push   %ebp
 31a:	89 e5                	mov    %esp,%ebp
 31c:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 31f:	8b 45 08             	mov    0x8(%ebp),%eax
 322:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 325:	8b 45 0c             	mov    0xc(%ebp),%eax
 328:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 32b:	eb 17                	jmp    344 <memmove+0x2b>
    *dst++ = *src++;
 32d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 330:	8d 50 01             	lea    0x1(%eax),%edx
 333:	89 55 fc             	mov    %edx,-0x4(%ebp)
 336:	8b 55 f8             	mov    -0x8(%ebp),%edx
 339:	8d 4a 01             	lea    0x1(%edx),%ecx
 33c:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 33f:	0f b6 12             	movzbl (%edx),%edx
 342:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 344:	8b 45 10             	mov    0x10(%ebp),%eax
 347:	8d 50 ff             	lea    -0x1(%eax),%edx
 34a:	89 55 10             	mov    %edx,0x10(%ebp)
 34d:	85 c0                	test   %eax,%eax
 34f:	7f dc                	jg     32d <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 351:	8b 45 08             	mov    0x8(%ebp),%eax
}
 354:	c9                   	leave  
 355:	c3                   	ret    

00000356 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 356:	b8 01 00 00 00       	mov    $0x1,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <exit>:
SYSCALL(exit)
 35e:	b8 02 00 00 00       	mov    $0x2,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <wait>:
SYSCALL(wait)
 366:	b8 03 00 00 00       	mov    $0x3,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <pipe>:
SYSCALL(pipe)
 36e:	b8 04 00 00 00       	mov    $0x4,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <read>:
SYSCALL(read)
 376:	b8 05 00 00 00       	mov    $0x5,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <write>:
SYSCALL(write)
 37e:	b8 10 00 00 00       	mov    $0x10,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <close>:
SYSCALL(close)
 386:	b8 15 00 00 00       	mov    $0x15,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <kill>:
SYSCALL(kill)
 38e:	b8 06 00 00 00       	mov    $0x6,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <exec>:
SYSCALL(exec)
 396:	b8 07 00 00 00       	mov    $0x7,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret    

0000039e <open>:
SYSCALL(open)
 39e:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret    

000003a6 <mknod>:
SYSCALL(mknod)
 3a6:	b8 11 00 00 00       	mov    $0x11,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret    

000003ae <unlink>:
SYSCALL(unlink)
 3ae:	b8 12 00 00 00       	mov    $0x12,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret    

000003b6 <fstat>:
SYSCALL(fstat)
 3b6:	b8 08 00 00 00       	mov    $0x8,%eax
 3bb:	cd 40                	int    $0x40
 3bd:	c3                   	ret    

000003be <link>:
SYSCALL(link)
 3be:	b8 13 00 00 00       	mov    $0x13,%eax
 3c3:	cd 40                	int    $0x40
 3c5:	c3                   	ret    

000003c6 <mkdir>:
SYSCALL(mkdir)
 3c6:	b8 14 00 00 00       	mov    $0x14,%eax
 3cb:	cd 40                	int    $0x40
 3cd:	c3                   	ret    

000003ce <chdir>:
SYSCALL(chdir)
 3ce:	b8 09 00 00 00       	mov    $0x9,%eax
 3d3:	cd 40                	int    $0x40
 3d5:	c3                   	ret    

000003d6 <dup>:
SYSCALL(dup)
 3d6:	b8 0a 00 00 00       	mov    $0xa,%eax
 3db:	cd 40                	int    $0x40
 3dd:	c3                   	ret    

000003de <getpid>:
SYSCALL(getpid)
 3de:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e3:	cd 40                	int    $0x40
 3e5:	c3                   	ret    

000003e6 <sbrk>:
SYSCALL(sbrk)
 3e6:	b8 0c 00 00 00       	mov    $0xc,%eax
 3eb:	cd 40                	int    $0x40
 3ed:	c3                   	ret    

000003ee <sleep>:
SYSCALL(sleep)
 3ee:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f3:	cd 40                	int    $0x40
 3f5:	c3                   	ret    

000003f6 <uptime>:
SYSCALL(uptime)
 3f6:	b8 0e 00 00 00       	mov    $0xe,%eax
 3fb:	cd 40                	int    $0x40
 3fd:	c3                   	ret    

000003fe <getcount>:
SYSCALL(getcount)
 3fe:	b8 16 00 00 00       	mov    $0x16,%eax
 403:	cd 40                	int    $0x40
 405:	c3                   	ret    

00000406 <thread_create>:
SYSCALL(thread_create)
 406:	b8 18 00 00 00       	mov    $0x18,%eax
 40b:	cd 40                	int    $0x40
 40d:	c3                   	ret    

0000040e <thread_join>:
SYSCALL(thread_join)
 40e:	b8 19 00 00 00       	mov    $0x19,%eax
 413:	cd 40                	int    $0x40
 415:	c3                   	ret    

00000416 <mtx_create>:
SYSCALL(mtx_create)
 416:	b8 1a 00 00 00       	mov    $0x1a,%eax
 41b:	cd 40                	int    $0x40
 41d:	c3                   	ret    

0000041e <mtx_lock>:
SYSCALL(mtx_lock)
 41e:	b8 1b 00 00 00       	mov    $0x1b,%eax
 423:	cd 40                	int    $0x40
 425:	c3                   	ret    

00000426 <mtx_unlock>:
SYSCALL(mtx_unlock)
 426:	b8 1c 00 00 00       	mov    $0x1c,%eax
 42b:	cd 40                	int    $0x40
 42d:	c3                   	ret    

0000042e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 42e:	55                   	push   %ebp
 42f:	89 e5                	mov    %esp,%ebp
 431:	83 ec 18             	sub    $0x18,%esp
 434:	8b 45 0c             	mov    0xc(%ebp),%eax
 437:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 43a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 441:	00 
 442:	8d 45 f4             	lea    -0xc(%ebp),%eax
 445:	89 44 24 04          	mov    %eax,0x4(%esp)
 449:	8b 45 08             	mov    0x8(%ebp),%eax
 44c:	89 04 24             	mov    %eax,(%esp)
 44f:	e8 2a ff ff ff       	call   37e <write>
}
 454:	c9                   	leave  
 455:	c3                   	ret    

00000456 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 456:	55                   	push   %ebp
 457:	89 e5                	mov    %esp,%ebp
 459:	56                   	push   %esi
 45a:	53                   	push   %ebx
 45b:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 45e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 465:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 469:	74 17                	je     482 <printint+0x2c>
 46b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 46f:	79 11                	jns    482 <printint+0x2c>
    neg = 1;
 471:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 478:	8b 45 0c             	mov    0xc(%ebp),%eax
 47b:	f7 d8                	neg    %eax
 47d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 480:	eb 06                	jmp    488 <printint+0x32>
  } else {
    x = xx;
 482:	8b 45 0c             	mov    0xc(%ebp),%eax
 485:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 488:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 48f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 492:	8d 41 01             	lea    0x1(%ecx),%eax
 495:	89 45 f4             	mov    %eax,-0xc(%ebp)
 498:	8b 5d 10             	mov    0x10(%ebp),%ebx
 49b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 49e:	ba 00 00 00 00       	mov    $0x0,%edx
 4a3:	f7 f3                	div    %ebx
 4a5:	89 d0                	mov    %edx,%eax
 4a7:	0f b6 80 a4 0b 00 00 	movzbl 0xba4(%eax),%eax
 4ae:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4b2:	8b 75 10             	mov    0x10(%ebp),%esi
 4b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4b8:	ba 00 00 00 00       	mov    $0x0,%edx
 4bd:	f7 f6                	div    %esi
 4bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4c2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4c6:	75 c7                	jne    48f <printint+0x39>
  if(neg)
 4c8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4cc:	74 10                	je     4de <printint+0x88>
    buf[i++] = '-';
 4ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4d1:	8d 50 01             	lea    0x1(%eax),%edx
 4d4:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4d7:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4dc:	eb 1f                	jmp    4fd <printint+0xa7>
 4de:	eb 1d                	jmp    4fd <printint+0xa7>
    putc(fd, buf[i]);
 4e0:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4e6:	01 d0                	add    %edx,%eax
 4e8:	0f b6 00             	movzbl (%eax),%eax
 4eb:	0f be c0             	movsbl %al,%eax
 4ee:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f2:	8b 45 08             	mov    0x8(%ebp),%eax
 4f5:	89 04 24             	mov    %eax,(%esp)
 4f8:	e8 31 ff ff ff       	call   42e <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4fd:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 501:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 505:	79 d9                	jns    4e0 <printint+0x8a>
    putc(fd, buf[i]);
}
 507:	83 c4 30             	add    $0x30,%esp
 50a:	5b                   	pop    %ebx
 50b:	5e                   	pop    %esi
 50c:	5d                   	pop    %ebp
 50d:	c3                   	ret    

0000050e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 50e:	55                   	push   %ebp
 50f:	89 e5                	mov    %esp,%ebp
 511:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 514:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 51b:	8d 45 0c             	lea    0xc(%ebp),%eax
 51e:	83 c0 04             	add    $0x4,%eax
 521:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 524:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 52b:	e9 7c 01 00 00       	jmp    6ac <printf+0x19e>
    c = fmt[i] & 0xff;
 530:	8b 55 0c             	mov    0xc(%ebp),%edx
 533:	8b 45 f0             	mov    -0x10(%ebp),%eax
 536:	01 d0                	add    %edx,%eax
 538:	0f b6 00             	movzbl (%eax),%eax
 53b:	0f be c0             	movsbl %al,%eax
 53e:	25 ff 00 00 00       	and    $0xff,%eax
 543:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 546:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 54a:	75 2c                	jne    578 <printf+0x6a>
      if(c == '%'){
 54c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 550:	75 0c                	jne    55e <printf+0x50>
        state = '%';
 552:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 559:	e9 4a 01 00 00       	jmp    6a8 <printf+0x19a>
      } else {
        putc(fd, c);
 55e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 561:	0f be c0             	movsbl %al,%eax
 564:	89 44 24 04          	mov    %eax,0x4(%esp)
 568:	8b 45 08             	mov    0x8(%ebp),%eax
 56b:	89 04 24             	mov    %eax,(%esp)
 56e:	e8 bb fe ff ff       	call   42e <putc>
 573:	e9 30 01 00 00       	jmp    6a8 <printf+0x19a>
      }
    } else if(state == '%'){
 578:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 57c:	0f 85 26 01 00 00    	jne    6a8 <printf+0x19a>
      if(c == 'd'){
 582:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 586:	75 2d                	jne    5b5 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 588:	8b 45 e8             	mov    -0x18(%ebp),%eax
 58b:	8b 00                	mov    (%eax),%eax
 58d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 594:	00 
 595:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 59c:	00 
 59d:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a1:	8b 45 08             	mov    0x8(%ebp),%eax
 5a4:	89 04 24             	mov    %eax,(%esp)
 5a7:	e8 aa fe ff ff       	call   456 <printint>
        ap++;
 5ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b0:	e9 ec 00 00 00       	jmp    6a1 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 5b5:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5b9:	74 06                	je     5c1 <printf+0xb3>
 5bb:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5bf:	75 2d                	jne    5ee <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c4:	8b 00                	mov    (%eax),%eax
 5c6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5cd:	00 
 5ce:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5d5:	00 
 5d6:	89 44 24 04          	mov    %eax,0x4(%esp)
 5da:	8b 45 08             	mov    0x8(%ebp),%eax
 5dd:	89 04 24             	mov    %eax,(%esp)
 5e0:	e8 71 fe ff ff       	call   456 <printint>
        ap++;
 5e5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e9:	e9 b3 00 00 00       	jmp    6a1 <printf+0x193>
      } else if(c == 's'){
 5ee:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5f2:	75 45                	jne    639 <printf+0x12b>
        s = (char*)*ap;
 5f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f7:	8b 00                	mov    (%eax),%eax
 5f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5fc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 600:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 604:	75 09                	jne    60f <printf+0x101>
          s = "(null)";
 606:	c7 45 f4 58 09 00 00 	movl   $0x958,-0xc(%ebp)
        while(*s != 0){
 60d:	eb 1e                	jmp    62d <printf+0x11f>
 60f:	eb 1c                	jmp    62d <printf+0x11f>
          putc(fd, *s);
 611:	8b 45 f4             	mov    -0xc(%ebp),%eax
 614:	0f b6 00             	movzbl (%eax),%eax
 617:	0f be c0             	movsbl %al,%eax
 61a:	89 44 24 04          	mov    %eax,0x4(%esp)
 61e:	8b 45 08             	mov    0x8(%ebp),%eax
 621:	89 04 24             	mov    %eax,(%esp)
 624:	e8 05 fe ff ff       	call   42e <putc>
          s++;
 629:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 62d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 630:	0f b6 00             	movzbl (%eax),%eax
 633:	84 c0                	test   %al,%al
 635:	75 da                	jne    611 <printf+0x103>
 637:	eb 68                	jmp    6a1 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 639:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 63d:	75 1d                	jne    65c <printf+0x14e>
        putc(fd, *ap);
 63f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 642:	8b 00                	mov    (%eax),%eax
 644:	0f be c0             	movsbl %al,%eax
 647:	89 44 24 04          	mov    %eax,0x4(%esp)
 64b:	8b 45 08             	mov    0x8(%ebp),%eax
 64e:	89 04 24             	mov    %eax,(%esp)
 651:	e8 d8 fd ff ff       	call   42e <putc>
        ap++;
 656:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 65a:	eb 45                	jmp    6a1 <printf+0x193>
      } else if(c == '%'){
 65c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 660:	75 17                	jne    679 <printf+0x16b>
        putc(fd, c);
 662:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 665:	0f be c0             	movsbl %al,%eax
 668:	89 44 24 04          	mov    %eax,0x4(%esp)
 66c:	8b 45 08             	mov    0x8(%ebp),%eax
 66f:	89 04 24             	mov    %eax,(%esp)
 672:	e8 b7 fd ff ff       	call   42e <putc>
 677:	eb 28                	jmp    6a1 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 679:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 680:	00 
 681:	8b 45 08             	mov    0x8(%ebp),%eax
 684:	89 04 24             	mov    %eax,(%esp)
 687:	e8 a2 fd ff ff       	call   42e <putc>
        putc(fd, c);
 68c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 68f:	0f be c0             	movsbl %al,%eax
 692:	89 44 24 04          	mov    %eax,0x4(%esp)
 696:	8b 45 08             	mov    0x8(%ebp),%eax
 699:	89 04 24             	mov    %eax,(%esp)
 69c:	e8 8d fd ff ff       	call   42e <putc>
      }
      state = 0;
 6a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6ac:	8b 55 0c             	mov    0xc(%ebp),%edx
 6af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b2:	01 d0                	add    %edx,%eax
 6b4:	0f b6 00             	movzbl (%eax),%eax
 6b7:	84 c0                	test   %al,%al
 6b9:	0f 85 71 fe ff ff    	jne    530 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6bf:	c9                   	leave  
 6c0:	c3                   	ret    

000006c1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c1:	55                   	push   %ebp
 6c2:	89 e5                	mov    %esp,%ebp
 6c4:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6c7:	8b 45 08             	mov    0x8(%ebp),%eax
 6ca:	83 e8 08             	sub    $0x8,%eax
 6cd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d0:	a1 c0 0b 00 00       	mov    0xbc0,%eax
 6d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6d8:	eb 24                	jmp    6fe <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dd:	8b 00                	mov    (%eax),%eax
 6df:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6e2:	77 12                	ja     6f6 <free+0x35>
 6e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ea:	77 24                	ja     710 <free+0x4f>
 6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ef:	8b 00                	mov    (%eax),%eax
 6f1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6f4:	77 1a                	ja     710 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f9:	8b 00                	mov    (%eax),%eax
 6fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 701:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 704:	76 d4                	jbe    6da <free+0x19>
 706:	8b 45 fc             	mov    -0x4(%ebp),%eax
 709:	8b 00                	mov    (%eax),%eax
 70b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 70e:	76 ca                	jbe    6da <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 710:	8b 45 f8             	mov    -0x8(%ebp),%eax
 713:	8b 40 04             	mov    0x4(%eax),%eax
 716:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 71d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 720:	01 c2                	add    %eax,%edx
 722:	8b 45 fc             	mov    -0x4(%ebp),%eax
 725:	8b 00                	mov    (%eax),%eax
 727:	39 c2                	cmp    %eax,%edx
 729:	75 24                	jne    74f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 72b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72e:	8b 50 04             	mov    0x4(%eax),%edx
 731:	8b 45 fc             	mov    -0x4(%ebp),%eax
 734:	8b 00                	mov    (%eax),%eax
 736:	8b 40 04             	mov    0x4(%eax),%eax
 739:	01 c2                	add    %eax,%edx
 73b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 741:	8b 45 fc             	mov    -0x4(%ebp),%eax
 744:	8b 00                	mov    (%eax),%eax
 746:	8b 10                	mov    (%eax),%edx
 748:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74b:	89 10                	mov    %edx,(%eax)
 74d:	eb 0a                	jmp    759 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 74f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 752:	8b 10                	mov    (%eax),%edx
 754:	8b 45 f8             	mov    -0x8(%ebp),%eax
 757:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 759:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75c:	8b 40 04             	mov    0x4(%eax),%eax
 75f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 766:	8b 45 fc             	mov    -0x4(%ebp),%eax
 769:	01 d0                	add    %edx,%eax
 76b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 76e:	75 20                	jne    790 <free+0xcf>
    p->s.size += bp->s.size;
 770:	8b 45 fc             	mov    -0x4(%ebp),%eax
 773:	8b 50 04             	mov    0x4(%eax),%edx
 776:	8b 45 f8             	mov    -0x8(%ebp),%eax
 779:	8b 40 04             	mov    0x4(%eax),%eax
 77c:	01 c2                	add    %eax,%edx
 77e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 781:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 784:	8b 45 f8             	mov    -0x8(%ebp),%eax
 787:	8b 10                	mov    (%eax),%edx
 789:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78c:	89 10                	mov    %edx,(%eax)
 78e:	eb 08                	jmp    798 <free+0xd7>
  } else
    p->s.ptr = bp;
 790:	8b 45 fc             	mov    -0x4(%ebp),%eax
 793:	8b 55 f8             	mov    -0x8(%ebp),%edx
 796:	89 10                	mov    %edx,(%eax)
  freep = p;
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	a3 c0 0b 00 00       	mov    %eax,0xbc0
}
 7a0:	c9                   	leave  
 7a1:	c3                   	ret    

000007a2 <morecore>:

static Header*
morecore(uint nu)
{
 7a2:	55                   	push   %ebp
 7a3:	89 e5                	mov    %esp,%ebp
 7a5:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7a8:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7af:	77 07                	ja     7b8 <morecore+0x16>
    nu = 4096;
 7b1:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7b8:	8b 45 08             	mov    0x8(%ebp),%eax
 7bb:	c1 e0 03             	shl    $0x3,%eax
 7be:	89 04 24             	mov    %eax,(%esp)
 7c1:	e8 20 fc ff ff       	call   3e6 <sbrk>
 7c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7c9:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7cd:	75 07                	jne    7d6 <morecore+0x34>
    return 0;
 7cf:	b8 00 00 00 00       	mov    $0x0,%eax
 7d4:	eb 22                	jmp    7f8 <morecore+0x56>
  hp = (Header*)p;
 7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7df:	8b 55 08             	mov    0x8(%ebp),%edx
 7e2:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e8:	83 c0 08             	add    $0x8,%eax
 7eb:	89 04 24             	mov    %eax,(%esp)
 7ee:	e8 ce fe ff ff       	call   6c1 <free>
  return freep;
 7f3:	a1 c0 0b 00 00       	mov    0xbc0,%eax
}
 7f8:	c9                   	leave  
 7f9:	c3                   	ret    

000007fa <malloc>:

void*
malloc(uint nbytes)
{
 7fa:	55                   	push   %ebp
 7fb:	89 e5                	mov    %esp,%ebp
 7fd:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 800:	8b 45 08             	mov    0x8(%ebp),%eax
 803:	83 c0 07             	add    $0x7,%eax
 806:	c1 e8 03             	shr    $0x3,%eax
 809:	83 c0 01             	add    $0x1,%eax
 80c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 80f:	a1 c0 0b 00 00       	mov    0xbc0,%eax
 814:	89 45 f0             	mov    %eax,-0x10(%ebp)
 817:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 81b:	75 23                	jne    840 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 81d:	c7 45 f0 b8 0b 00 00 	movl   $0xbb8,-0x10(%ebp)
 824:	8b 45 f0             	mov    -0x10(%ebp),%eax
 827:	a3 c0 0b 00 00       	mov    %eax,0xbc0
 82c:	a1 c0 0b 00 00       	mov    0xbc0,%eax
 831:	a3 b8 0b 00 00       	mov    %eax,0xbb8
    base.s.size = 0;
 836:	c7 05 bc 0b 00 00 00 	movl   $0x0,0xbbc
 83d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 840:	8b 45 f0             	mov    -0x10(%ebp),%eax
 843:	8b 00                	mov    (%eax),%eax
 845:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 848:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84b:	8b 40 04             	mov    0x4(%eax),%eax
 84e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 851:	72 4d                	jb     8a0 <malloc+0xa6>
      if(p->s.size == nunits)
 853:	8b 45 f4             	mov    -0xc(%ebp),%eax
 856:	8b 40 04             	mov    0x4(%eax),%eax
 859:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 85c:	75 0c                	jne    86a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 85e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 861:	8b 10                	mov    (%eax),%edx
 863:	8b 45 f0             	mov    -0x10(%ebp),%eax
 866:	89 10                	mov    %edx,(%eax)
 868:	eb 26                	jmp    890 <malloc+0x96>
      else {
        p->s.size -= nunits;
 86a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86d:	8b 40 04             	mov    0x4(%eax),%eax
 870:	2b 45 ec             	sub    -0x14(%ebp),%eax
 873:	89 c2                	mov    %eax,%edx
 875:	8b 45 f4             	mov    -0xc(%ebp),%eax
 878:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 87b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87e:	8b 40 04             	mov    0x4(%eax),%eax
 881:	c1 e0 03             	shl    $0x3,%eax
 884:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 887:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88a:	8b 55 ec             	mov    -0x14(%ebp),%edx
 88d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 890:	8b 45 f0             	mov    -0x10(%ebp),%eax
 893:	a3 c0 0b 00 00       	mov    %eax,0xbc0
      return (void*)(p + 1);
 898:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89b:	83 c0 08             	add    $0x8,%eax
 89e:	eb 38                	jmp    8d8 <malloc+0xde>
    }
    if(p == freep)
 8a0:	a1 c0 0b 00 00       	mov    0xbc0,%eax
 8a5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8a8:	75 1b                	jne    8c5 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8ad:	89 04 24             	mov    %eax,(%esp)
 8b0:	e8 ed fe ff ff       	call   7a2 <morecore>
 8b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8bc:	75 07                	jne    8c5 <malloc+0xcb>
        return 0;
 8be:	b8 00 00 00 00       	mov    $0x0,%eax
 8c3:	eb 13                	jmp    8d8 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ce:	8b 00                	mov    (%eax),%eax
 8d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8d3:	e9 70 ff ff ff       	jmp    848 <malloc+0x4e>
}
 8d8:	c9                   	leave  
 8d9:	c3                   	ret    
