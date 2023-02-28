
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t *heap_bottom;
uint8_t *stack_bottom;



void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();
    srand(p);
  10000d:	89 c7                	mov    %eax,%edi
  10000f:	e8 11 05 00 00       	call   100525 <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100014:	b8 1f 30 10 00       	mov    $0x10301f,%eax
  100019:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001f:	48 89 05 ea 1f 00 00 	mov    %rax,0x1fea(%rip)        # 102010 <heap_top>
  100026:	48 89 05 db 1f 00 00 	mov    %rax,0x1fdb(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10002d:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100030:	48 83 e8 01          	sub    $0x1,%rax
  100034:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10003a:	48 89 05 bf 1f 00 00 	mov    %rax,0x1fbf(%rip)        # 102000 <stack_bottom>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100041:	bf 00 10 00 00       	mov    $0x1000,%edi
  100046:	cd 3a                	int    $0x3a
  100048:	48 89 05 c9 1f 00 00 	mov    %rax,0x1fc9(%rip)        # 102018 <result.0>

    while(heap_top < heap_bottom + 1024*1024) {

        void * ret = sbrk(PAGESIZE);
        assert(ret != (void *)-1);
  10004f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100053:	74 38                	je     10008d <process_main+0x8d>

        *heap_top = p;      /* check we have write access to new page */
  100055:	48 8b 15 b4 1f 00 00 	mov    0x1fb4(%rip),%rdx        # 102010 <heap_top>
  10005c:	88 1a                	mov    %bl,(%rdx)
        heap_top = (uint8_t *)ret + PAGESIZE;
  10005e:	48 05 00 10 00 00    	add    $0x1000,%rax
  100064:	48 89 05 a5 1f 00 00 	mov    %rax,0x1fa5(%rip)        # 102010 <heap_top>
    while(heap_top < heap_bottom + 1024*1024) {
  10006b:	48 8b 0d 96 1f 00 00 	mov    0x1f96(%rip),%rcx        # 102008 <heap_bottom>
  100072:	48 8d 91 00 00 10 00 	lea    0x100000(%rcx),%rdx
  100079:	48 39 d0             	cmp    %rdx,%rax
  10007c:	72 c8                	jb     100046 <process_main+0x46>
    }

    TEST_PASS();
  10007e:	bf a2 12 10 00       	mov    $0x1012a2,%edi
  100083:	b8 00 00 00 00       	mov    $0x0,%eax
  100088:	e8 a4 00 00 00       	call   100131 <kernel_panic>
        assert(ret != (void *)-1);
  10008d:	ba 80 12 10 00       	mov    $0x101280,%edx
  100092:	be 18 00 00 00       	mov    $0x18,%esi
  100097:	bf 92 12 10 00       	mov    $0x101292,%edi
  10009c:	e8 5e 01 00 00       	call   1001ff <assert_fail>

00000000001000a1 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1000a1:	55                   	push   %rbp
  1000a2:	48 89 e5             	mov    %rsp,%rbp
  1000a5:	48 83 ec 50          	sub    $0x50,%rsp
  1000a9:	49 89 f2             	mov    %rsi,%r10
  1000ac:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1000b0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1000b4:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1000b8:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1000bc:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1000c1:	85 ff                	test   %edi,%edi
  1000c3:	78 2e                	js     1000f3 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1000c5:	48 63 ff             	movslq %edi,%rdi
  1000c8:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1000cf:	cc cc cc 
  1000d2:	48 89 f8             	mov    %rdi,%rax
  1000d5:	48 f7 e2             	mul    %rdx
  1000d8:	48 89 d0             	mov    %rdx,%rax
  1000db:	48 c1 e8 02          	shr    $0x2,%rax
  1000df:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1000e3:	48 01 c2             	add    %rax,%rdx
  1000e6:	48 29 d7             	sub    %rdx,%rdi
  1000e9:	0f b6 b7 f5 12 10 00 	movzbl 0x1012f5(%rdi),%esi
  1000f0:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1000f3:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1000fa:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1000fe:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100102:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100106:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  10010a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10010e:	4c 89 d2             	mov    %r10,%rdx
  100111:	8b 3d e5 8e fb ff    	mov    -0x4711b(%rip),%edi        # b8ffc <cursorpos>
  100117:	e8 5b 0f 00 00       	call   101077 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  10011c:	3d 30 07 00 00       	cmp    $0x730,%eax
  100121:	ba 00 00 00 00       	mov    $0x0,%edx
  100126:	0f 4d c2             	cmovge %edx,%eax
  100129:	89 05 cd 8e fb ff    	mov    %eax,-0x47133(%rip)        # b8ffc <cursorpos>
    }
}
  10012f:	c9                   	leave  
  100130:	c3                   	ret    

0000000000100131 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100131:	55                   	push   %rbp
  100132:	48 89 e5             	mov    %rsp,%rbp
  100135:	53                   	push   %rbx
  100136:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  10013d:	48 89 fb             	mov    %rdi,%rbx
  100140:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100144:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100148:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  10014c:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100150:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100154:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  10015b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10015f:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100163:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100167:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10016b:	ba 07 00 00 00       	mov    $0x7,%edx
  100170:	be bd 12 10 00       	mov    $0x1012bd,%esi
  100175:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  10017c:	e8 ad 00 00 00       	call   10022e <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100181:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100185:	48 89 da             	mov    %rbx,%rdx
  100188:	be 99 00 00 00       	mov    $0x99,%esi
  10018d:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100194:	e8 ea 0f 00 00       	call   101183 <vsnprintf>
  100199:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  10019c:	85 d2                	test   %edx,%edx
  10019e:	7e 0f                	jle    1001af <kernel_panic+0x7e>
  1001a0:	83 c0 06             	add    $0x6,%eax
  1001a3:	48 98                	cltq   
  1001a5:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1001ac:	0a 
  1001ad:	75 2a                	jne    1001d9 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1001af:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1001b6:	48 89 d9             	mov    %rbx,%rcx
  1001b9:	ba c7 12 10 00       	mov    $0x1012c7,%edx
  1001be:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001c3:	bf 30 07 00 00       	mov    $0x730,%edi
  1001c8:	b8 00 00 00 00       	mov    $0x0,%eax
  1001cd:	e8 11 0f 00 00       	call   1010e3 <console_printf>
    asm volatile ("int %0" : /* no result */
  1001d2:	48 89 df             	mov    %rbx,%rdi
  1001d5:	cd 30                	int    $0x30
 loop: goto loop;
  1001d7:	eb fe                	jmp    1001d7 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1001d9:	48 63 c2             	movslq %edx,%rax
  1001dc:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1001e2:	0f 94 c2             	sete   %dl
  1001e5:	0f b6 d2             	movzbl %dl,%edx
  1001e8:	48 29 d0             	sub    %rdx,%rax
  1001eb:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1001f2:	ff 
  1001f3:	be c5 12 10 00       	mov    $0x1012c5,%esi
  1001f8:	e8 de 01 00 00       	call   1003db <strcpy>
  1001fd:	eb b0                	jmp    1001af <kernel_panic+0x7e>

00000000001001ff <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1001ff:	55                   	push   %rbp
  100200:	48 89 e5             	mov    %rsp,%rbp
  100203:	48 89 f9             	mov    %rdi,%rcx
  100206:	41 89 f0             	mov    %esi,%r8d
  100209:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  10020c:	ba d0 12 10 00       	mov    $0x1012d0,%edx
  100211:	be 00 c0 00 00       	mov    $0xc000,%esi
  100216:	bf 30 07 00 00       	mov    $0x730,%edi
  10021b:	b8 00 00 00 00       	mov    $0x0,%eax
  100220:	e8 be 0e 00 00       	call   1010e3 <console_printf>
    asm volatile ("int %0" : /* no result */
  100225:	bf 00 00 00 00       	mov    $0x0,%edi
  10022a:	cd 30                	int    $0x30
 loop: goto loop;
  10022c:	eb fe                	jmp    10022c <assert_fail+0x2d>

000000000010022e <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10022e:	55                   	push   %rbp
  10022f:	48 89 e5             	mov    %rsp,%rbp
  100232:	48 83 ec 28          	sub    $0x28,%rsp
  100236:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10023a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10023e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100242:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100246:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10024a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10024e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100252:	eb 1c                	jmp    100270 <memcpy+0x42>
        *d = *s;
  100254:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100258:	0f b6 10             	movzbl (%rax),%edx
  10025b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10025f:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100261:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100266:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10026b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100270:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100275:	75 dd                	jne    100254 <memcpy+0x26>
    }
    return dst;
  100277:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10027b:	c9                   	leave  
  10027c:	c3                   	ret    

000000000010027d <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10027d:	55                   	push   %rbp
  10027e:	48 89 e5             	mov    %rsp,%rbp
  100281:	48 83 ec 28          	sub    $0x28,%rsp
  100285:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100289:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10028d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100291:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100295:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100299:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10029d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1002a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002a5:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1002a9:	73 6a                	jae    100315 <memmove+0x98>
  1002ab:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1002af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002b3:	48 01 d0             	add    %rdx,%rax
  1002b6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1002ba:	73 59                	jae    100315 <memmove+0x98>
        s += n, d += n;
  1002bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002c0:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1002c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002c8:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1002cc:	eb 17                	jmp    1002e5 <memmove+0x68>
            *--d = *--s;
  1002ce:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1002d3:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1002d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002dc:	0f b6 10             	movzbl (%rax),%edx
  1002df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002e3:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1002e5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002e9:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1002ed:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1002f1:	48 85 c0             	test   %rax,%rax
  1002f4:	75 d8                	jne    1002ce <memmove+0x51>
    if (s < d && s + n > d) {
  1002f6:	eb 2e                	jmp    100326 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1002f8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1002fc:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100300:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100304:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100308:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10030c:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100310:	0f b6 12             	movzbl (%rdx),%edx
  100313:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100315:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100319:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10031d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100321:	48 85 c0             	test   %rax,%rax
  100324:	75 d2                	jne    1002f8 <memmove+0x7b>
        }
    }
    return dst;
  100326:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10032a:	c9                   	leave  
  10032b:	c3                   	ret    

000000000010032c <memset>:

void* memset(void* v, int c, size_t n) {
  10032c:	55                   	push   %rbp
  10032d:	48 89 e5             	mov    %rsp,%rbp
  100330:	48 83 ec 28          	sub    $0x28,%rsp
  100334:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100338:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  10033b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10033f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100343:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100347:	eb 15                	jmp    10035e <memset+0x32>
        *p = c;
  100349:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10034c:	89 c2                	mov    %eax,%edx
  10034e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100352:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100354:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100359:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10035e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100363:	75 e4                	jne    100349 <memset+0x1d>
    }
    return v;
  100365:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100369:	c9                   	leave  
  10036a:	c3                   	ret    

000000000010036b <strlen>:

size_t strlen(const char* s) {
  10036b:	55                   	push   %rbp
  10036c:	48 89 e5             	mov    %rsp,%rbp
  10036f:	48 83 ec 18          	sub    $0x18,%rsp
  100373:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100377:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10037e:	00 
  10037f:	eb 0a                	jmp    10038b <strlen+0x20>
        ++n;
  100381:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100386:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10038b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10038f:	0f b6 00             	movzbl (%rax),%eax
  100392:	84 c0                	test   %al,%al
  100394:	75 eb                	jne    100381 <strlen+0x16>
    }
    return n;
  100396:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10039a:	c9                   	leave  
  10039b:	c3                   	ret    

000000000010039c <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  10039c:	55                   	push   %rbp
  10039d:	48 89 e5             	mov    %rsp,%rbp
  1003a0:	48 83 ec 20          	sub    $0x20,%rsp
  1003a4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003a8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1003ac:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1003b3:	00 
  1003b4:	eb 0a                	jmp    1003c0 <strnlen+0x24>
        ++n;
  1003b6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1003bb:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1003c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003c4:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1003c8:	74 0b                	je     1003d5 <strnlen+0x39>
  1003ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003ce:	0f b6 00             	movzbl (%rax),%eax
  1003d1:	84 c0                	test   %al,%al
  1003d3:	75 e1                	jne    1003b6 <strnlen+0x1a>
    }
    return n;
  1003d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1003d9:	c9                   	leave  
  1003da:	c3                   	ret    

00000000001003db <strcpy>:

char* strcpy(char* dst, const char* src) {
  1003db:	55                   	push   %rbp
  1003dc:	48 89 e5             	mov    %rsp,%rbp
  1003df:	48 83 ec 20          	sub    $0x20,%rsp
  1003e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003e7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1003eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003ef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1003f3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1003f7:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003fb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1003ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100403:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100407:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  10040b:	0f b6 12             	movzbl (%rdx),%edx
  10040e:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100410:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100414:	48 83 e8 01          	sub    $0x1,%rax
  100418:	0f b6 00             	movzbl (%rax),%eax
  10041b:	84 c0                	test   %al,%al
  10041d:	75 d4                	jne    1003f3 <strcpy+0x18>
    return dst;
  10041f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100423:	c9                   	leave  
  100424:	c3                   	ret    

0000000000100425 <strcmp>:

int strcmp(const char* a, const char* b) {
  100425:	55                   	push   %rbp
  100426:	48 89 e5             	mov    %rsp,%rbp
  100429:	48 83 ec 10          	sub    $0x10,%rsp
  10042d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100431:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100435:	eb 0a                	jmp    100441 <strcmp+0x1c>
        ++a, ++b;
  100437:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10043c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100441:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100445:	0f b6 00             	movzbl (%rax),%eax
  100448:	84 c0                	test   %al,%al
  10044a:	74 1d                	je     100469 <strcmp+0x44>
  10044c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100450:	0f b6 00             	movzbl (%rax),%eax
  100453:	84 c0                	test   %al,%al
  100455:	74 12                	je     100469 <strcmp+0x44>
  100457:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10045b:	0f b6 10             	movzbl (%rax),%edx
  10045e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100462:	0f b6 00             	movzbl (%rax),%eax
  100465:	38 c2                	cmp    %al,%dl
  100467:	74 ce                	je     100437 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100469:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10046d:	0f b6 00             	movzbl (%rax),%eax
  100470:	89 c2                	mov    %eax,%edx
  100472:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100476:	0f b6 00             	movzbl (%rax),%eax
  100479:	38 d0                	cmp    %dl,%al
  10047b:	0f 92 c0             	setb   %al
  10047e:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100481:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100485:	0f b6 00             	movzbl (%rax),%eax
  100488:	89 c1                	mov    %eax,%ecx
  10048a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10048e:	0f b6 00             	movzbl (%rax),%eax
  100491:	38 c1                	cmp    %al,%cl
  100493:	0f 92 c0             	setb   %al
  100496:	0f b6 c0             	movzbl %al,%eax
  100499:	29 c2                	sub    %eax,%edx
  10049b:	89 d0                	mov    %edx,%eax
}
  10049d:	c9                   	leave  
  10049e:	c3                   	ret    

000000000010049f <strchr>:

char* strchr(const char* s, int c) {
  10049f:	55                   	push   %rbp
  1004a0:	48 89 e5             	mov    %rsp,%rbp
  1004a3:	48 83 ec 10          	sub    $0x10,%rsp
  1004a7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004ab:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1004ae:	eb 05                	jmp    1004b5 <strchr+0x16>
        ++s;
  1004b0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1004b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004b9:	0f b6 00             	movzbl (%rax),%eax
  1004bc:	84 c0                	test   %al,%al
  1004be:	74 0e                	je     1004ce <strchr+0x2f>
  1004c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004c4:	0f b6 00             	movzbl (%rax),%eax
  1004c7:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1004ca:	38 d0                	cmp    %dl,%al
  1004cc:	75 e2                	jne    1004b0 <strchr+0x11>
    }
    if (*s == (char) c) {
  1004ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004d2:	0f b6 00             	movzbl (%rax),%eax
  1004d5:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1004d8:	38 d0                	cmp    %dl,%al
  1004da:	75 06                	jne    1004e2 <strchr+0x43>
        return (char*) s;
  1004dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004e0:	eb 05                	jmp    1004e7 <strchr+0x48>
    } else {
        return NULL;
  1004e2:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1004e7:	c9                   	leave  
  1004e8:	c3                   	ret    

00000000001004e9 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1004e9:	55                   	push   %rbp
  1004ea:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1004ed:	8b 05 45 1b 00 00    	mov    0x1b45(%rip),%eax        # 102038 <rand_seed_set>
  1004f3:	85 c0                	test   %eax,%eax
  1004f5:	75 0a                	jne    100501 <rand+0x18>
        srand(819234718U);
  1004f7:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1004fc:	e8 24 00 00 00       	call   100525 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100501:	8b 05 35 1b 00 00    	mov    0x1b35(%rip),%eax        # 10203c <rand_seed>
  100507:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10050d:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100512:	89 05 24 1b 00 00    	mov    %eax,0x1b24(%rip)        # 10203c <rand_seed>
    return rand_seed & RAND_MAX;
  100518:	8b 05 1e 1b 00 00    	mov    0x1b1e(%rip),%eax        # 10203c <rand_seed>
  10051e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100523:	5d                   	pop    %rbp
  100524:	c3                   	ret    

0000000000100525 <srand>:

void srand(unsigned seed) {
  100525:	55                   	push   %rbp
  100526:	48 89 e5             	mov    %rsp,%rbp
  100529:	48 83 ec 08          	sub    $0x8,%rsp
  10052d:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100530:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100533:	89 05 03 1b 00 00    	mov    %eax,0x1b03(%rip)        # 10203c <rand_seed>
    rand_seed_set = 1;
  100539:	c7 05 f5 1a 00 00 01 	movl   $0x1,0x1af5(%rip)        # 102038 <rand_seed_set>
  100540:	00 00 00 
}
  100543:	90                   	nop
  100544:	c9                   	leave  
  100545:	c3                   	ret    

0000000000100546 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100546:	55                   	push   %rbp
  100547:	48 89 e5             	mov    %rsp,%rbp
  10054a:	48 83 ec 28          	sub    $0x28,%rsp
  10054e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100552:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100556:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100559:	48 c7 45 f8 e0 14 10 	movq   $0x1014e0,-0x8(%rbp)
  100560:	00 
    if (base < 0) {
  100561:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100565:	79 0b                	jns    100572 <fill_numbuf+0x2c>
        digits = lower_digits;
  100567:	48 c7 45 f8 00 15 10 	movq   $0x101500,-0x8(%rbp)
  10056e:	00 
        base = -base;
  10056f:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100572:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100577:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10057b:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  10057e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100581:	48 63 c8             	movslq %eax,%rcx
  100584:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100588:	ba 00 00 00 00       	mov    $0x0,%edx
  10058d:	48 f7 f1             	div    %rcx
  100590:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100594:	48 01 d0             	add    %rdx,%rax
  100597:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10059c:	0f b6 10             	movzbl (%rax),%edx
  10059f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005a3:	88 10                	mov    %dl,(%rax)
        val /= base;
  1005a5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1005a8:	48 63 f0             	movslq %eax,%rsi
  1005ab:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1005af:	ba 00 00 00 00       	mov    $0x0,%edx
  1005b4:	48 f7 f6             	div    %rsi
  1005b7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1005bb:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1005c0:	75 bc                	jne    10057e <fill_numbuf+0x38>
    return numbuf_end;
  1005c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1005c6:	c9                   	leave  
  1005c7:	c3                   	ret    

00000000001005c8 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1005c8:	55                   	push   %rbp
  1005c9:	48 89 e5             	mov    %rsp,%rbp
  1005cc:	53                   	push   %rbx
  1005cd:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1005d4:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1005db:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1005e1:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1005e8:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1005ef:	e9 8a 09 00 00       	jmp    100f7e <printer_vprintf+0x9b6>
        if (*format != '%') {
  1005f4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005fb:	0f b6 00             	movzbl (%rax),%eax
  1005fe:	3c 25                	cmp    $0x25,%al
  100600:	74 31                	je     100633 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100602:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100609:	4c 8b 00             	mov    (%rax),%r8
  10060c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100613:	0f b6 00             	movzbl (%rax),%eax
  100616:	0f b6 c8             	movzbl %al,%ecx
  100619:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10061f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100626:	89 ce                	mov    %ecx,%esi
  100628:	48 89 c7             	mov    %rax,%rdi
  10062b:	41 ff d0             	call   *%r8
            continue;
  10062e:	e9 43 09 00 00       	jmp    100f76 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100633:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  10063a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100641:	01 
  100642:	eb 44                	jmp    100688 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100644:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10064b:	0f b6 00             	movzbl (%rax),%eax
  10064e:	0f be c0             	movsbl %al,%eax
  100651:	89 c6                	mov    %eax,%esi
  100653:	bf 00 13 10 00       	mov    $0x101300,%edi
  100658:	e8 42 fe ff ff       	call   10049f <strchr>
  10065d:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100661:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100666:	74 30                	je     100698 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100668:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  10066c:	48 2d 00 13 10 00    	sub    $0x101300,%rax
  100672:	ba 01 00 00 00       	mov    $0x1,%edx
  100677:	89 c1                	mov    %eax,%ecx
  100679:	d3 e2                	shl    %cl,%edx
  10067b:	89 d0                	mov    %edx,%eax
  10067d:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100680:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100687:	01 
  100688:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10068f:	0f b6 00             	movzbl (%rax),%eax
  100692:	84 c0                	test   %al,%al
  100694:	75 ae                	jne    100644 <printer_vprintf+0x7c>
  100696:	eb 01                	jmp    100699 <printer_vprintf+0xd1>
            } else {
                break;
  100698:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100699:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1006a0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006a7:	0f b6 00             	movzbl (%rax),%eax
  1006aa:	3c 30                	cmp    $0x30,%al
  1006ac:	7e 67                	jle    100715 <printer_vprintf+0x14d>
  1006ae:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006b5:	0f b6 00             	movzbl (%rax),%eax
  1006b8:	3c 39                	cmp    $0x39,%al
  1006ba:	7f 59                	jg     100715 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1006bc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1006c3:	eb 2e                	jmp    1006f3 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  1006c5:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1006c8:	89 d0                	mov    %edx,%eax
  1006ca:	c1 e0 02             	shl    $0x2,%eax
  1006cd:	01 d0                	add    %edx,%eax
  1006cf:	01 c0                	add    %eax,%eax
  1006d1:	89 c1                	mov    %eax,%ecx
  1006d3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006da:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1006de:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006e5:	0f b6 00             	movzbl (%rax),%eax
  1006e8:	0f be c0             	movsbl %al,%eax
  1006eb:	01 c8                	add    %ecx,%eax
  1006ed:	83 e8 30             	sub    $0x30,%eax
  1006f0:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1006f3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006fa:	0f b6 00             	movzbl (%rax),%eax
  1006fd:	3c 2f                	cmp    $0x2f,%al
  1006ff:	0f 8e 85 00 00 00    	jle    10078a <printer_vprintf+0x1c2>
  100705:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10070c:	0f b6 00             	movzbl (%rax),%eax
  10070f:	3c 39                	cmp    $0x39,%al
  100711:	7e b2                	jle    1006c5 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100713:	eb 75                	jmp    10078a <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100715:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10071c:	0f b6 00             	movzbl (%rax),%eax
  10071f:	3c 2a                	cmp    $0x2a,%al
  100721:	75 68                	jne    10078b <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100723:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10072a:	8b 00                	mov    (%rax),%eax
  10072c:	83 f8 2f             	cmp    $0x2f,%eax
  10072f:	77 30                	ja     100761 <printer_vprintf+0x199>
  100731:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100738:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10073c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100743:	8b 00                	mov    (%rax),%eax
  100745:	89 c0                	mov    %eax,%eax
  100747:	48 01 d0             	add    %rdx,%rax
  10074a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100751:	8b 12                	mov    (%rdx),%edx
  100753:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100756:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10075d:	89 0a                	mov    %ecx,(%rdx)
  10075f:	eb 1a                	jmp    10077b <printer_vprintf+0x1b3>
  100761:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100768:	48 8b 40 08          	mov    0x8(%rax),%rax
  10076c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100770:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100777:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10077b:	8b 00                	mov    (%rax),%eax
  10077d:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100780:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100787:	01 
  100788:	eb 01                	jmp    10078b <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  10078a:	90                   	nop
        }

        // process precision
        int precision = -1;
  10078b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100792:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100799:	0f b6 00             	movzbl (%rax),%eax
  10079c:	3c 2e                	cmp    $0x2e,%al
  10079e:	0f 85 00 01 00 00    	jne    1008a4 <printer_vprintf+0x2dc>
            ++format;
  1007a4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007ab:	01 
            if (*format >= '0' && *format <= '9') {
  1007ac:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007b3:	0f b6 00             	movzbl (%rax),%eax
  1007b6:	3c 2f                	cmp    $0x2f,%al
  1007b8:	7e 67                	jle    100821 <printer_vprintf+0x259>
  1007ba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007c1:	0f b6 00             	movzbl (%rax),%eax
  1007c4:	3c 39                	cmp    $0x39,%al
  1007c6:	7f 59                	jg     100821 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1007c8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1007cf:	eb 2e                	jmp    1007ff <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  1007d1:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1007d4:	89 d0                	mov    %edx,%eax
  1007d6:	c1 e0 02             	shl    $0x2,%eax
  1007d9:	01 d0                	add    %edx,%eax
  1007db:	01 c0                	add    %eax,%eax
  1007dd:	89 c1                	mov    %eax,%ecx
  1007df:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007e6:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1007ea:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007f1:	0f b6 00             	movzbl (%rax),%eax
  1007f4:	0f be c0             	movsbl %al,%eax
  1007f7:	01 c8                	add    %ecx,%eax
  1007f9:	83 e8 30             	sub    $0x30,%eax
  1007fc:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1007ff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100806:	0f b6 00             	movzbl (%rax),%eax
  100809:	3c 2f                	cmp    $0x2f,%al
  10080b:	0f 8e 85 00 00 00    	jle    100896 <printer_vprintf+0x2ce>
  100811:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100818:	0f b6 00             	movzbl (%rax),%eax
  10081b:	3c 39                	cmp    $0x39,%al
  10081d:	7e b2                	jle    1007d1 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  10081f:	eb 75                	jmp    100896 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100821:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100828:	0f b6 00             	movzbl (%rax),%eax
  10082b:	3c 2a                	cmp    $0x2a,%al
  10082d:	75 68                	jne    100897 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  10082f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100836:	8b 00                	mov    (%rax),%eax
  100838:	83 f8 2f             	cmp    $0x2f,%eax
  10083b:	77 30                	ja     10086d <printer_vprintf+0x2a5>
  10083d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100844:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100848:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10084f:	8b 00                	mov    (%rax),%eax
  100851:	89 c0                	mov    %eax,%eax
  100853:	48 01 d0             	add    %rdx,%rax
  100856:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10085d:	8b 12                	mov    (%rdx),%edx
  10085f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100862:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100869:	89 0a                	mov    %ecx,(%rdx)
  10086b:	eb 1a                	jmp    100887 <printer_vprintf+0x2bf>
  10086d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100874:	48 8b 40 08          	mov    0x8(%rax),%rax
  100878:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10087c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100883:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100887:	8b 00                	mov    (%rax),%eax
  100889:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  10088c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100893:	01 
  100894:	eb 01                	jmp    100897 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100896:	90                   	nop
            }
            if (precision < 0) {
  100897:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10089b:	79 07                	jns    1008a4 <printer_vprintf+0x2dc>
                precision = 0;
  10089d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  1008a4:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  1008ab:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  1008b2:	00 
        int length = 0;
  1008b3:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  1008ba:	48 c7 45 c8 06 13 10 	movq   $0x101306,-0x38(%rbp)
  1008c1:	00 
    again:
        switch (*format) {
  1008c2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008c9:	0f b6 00             	movzbl (%rax),%eax
  1008cc:	0f be c0             	movsbl %al,%eax
  1008cf:	83 e8 43             	sub    $0x43,%eax
  1008d2:	83 f8 37             	cmp    $0x37,%eax
  1008d5:	0f 87 9f 03 00 00    	ja     100c7a <printer_vprintf+0x6b2>
  1008db:	89 c0                	mov    %eax,%eax
  1008dd:	48 8b 04 c5 18 13 10 	mov    0x101318(,%rax,8),%rax
  1008e4:	00 
  1008e5:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  1008e7:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1008ee:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008f5:	01 
            goto again;
  1008f6:	eb ca                	jmp    1008c2 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1008f8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1008fc:	74 5d                	je     10095b <printer_vprintf+0x393>
  1008fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100905:	8b 00                	mov    (%rax),%eax
  100907:	83 f8 2f             	cmp    $0x2f,%eax
  10090a:	77 30                	ja     10093c <printer_vprintf+0x374>
  10090c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100913:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100917:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10091e:	8b 00                	mov    (%rax),%eax
  100920:	89 c0                	mov    %eax,%eax
  100922:	48 01 d0             	add    %rdx,%rax
  100925:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10092c:	8b 12                	mov    (%rdx),%edx
  10092e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100931:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100938:	89 0a                	mov    %ecx,(%rdx)
  10093a:	eb 1a                	jmp    100956 <printer_vprintf+0x38e>
  10093c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100943:	48 8b 40 08          	mov    0x8(%rax),%rax
  100947:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10094b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100952:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100956:	48 8b 00             	mov    (%rax),%rax
  100959:	eb 5c                	jmp    1009b7 <printer_vprintf+0x3ef>
  10095b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100962:	8b 00                	mov    (%rax),%eax
  100964:	83 f8 2f             	cmp    $0x2f,%eax
  100967:	77 30                	ja     100999 <printer_vprintf+0x3d1>
  100969:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100970:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100974:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10097b:	8b 00                	mov    (%rax),%eax
  10097d:	89 c0                	mov    %eax,%eax
  10097f:	48 01 d0             	add    %rdx,%rax
  100982:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100989:	8b 12                	mov    (%rdx),%edx
  10098b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10098e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100995:	89 0a                	mov    %ecx,(%rdx)
  100997:	eb 1a                	jmp    1009b3 <printer_vprintf+0x3eb>
  100999:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009a0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009a4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009a8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009af:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009b3:	8b 00                	mov    (%rax),%eax
  1009b5:	48 98                	cltq   
  1009b7:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1009bb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1009bf:	48 c1 f8 38          	sar    $0x38,%rax
  1009c3:	25 80 00 00 00       	and    $0x80,%eax
  1009c8:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  1009cb:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  1009cf:	74 09                	je     1009da <printer_vprintf+0x412>
  1009d1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1009d5:	48 f7 d8             	neg    %rax
  1009d8:	eb 04                	jmp    1009de <printer_vprintf+0x416>
  1009da:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1009de:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1009e2:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  1009e5:	83 c8 60             	or     $0x60,%eax
  1009e8:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1009eb:	e9 cf 02 00 00       	jmp    100cbf <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1009f0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1009f4:	74 5d                	je     100a53 <printer_vprintf+0x48b>
  1009f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009fd:	8b 00                	mov    (%rax),%eax
  1009ff:	83 f8 2f             	cmp    $0x2f,%eax
  100a02:	77 30                	ja     100a34 <printer_vprintf+0x46c>
  100a04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a0b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a16:	8b 00                	mov    (%rax),%eax
  100a18:	89 c0                	mov    %eax,%eax
  100a1a:	48 01 d0             	add    %rdx,%rax
  100a1d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a24:	8b 12                	mov    (%rdx),%edx
  100a26:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a30:	89 0a                	mov    %ecx,(%rdx)
  100a32:	eb 1a                	jmp    100a4e <printer_vprintf+0x486>
  100a34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a3b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a3f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a43:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a4a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a4e:	48 8b 00             	mov    (%rax),%rax
  100a51:	eb 5c                	jmp    100aaf <printer_vprintf+0x4e7>
  100a53:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5a:	8b 00                	mov    (%rax),%eax
  100a5c:	83 f8 2f             	cmp    $0x2f,%eax
  100a5f:	77 30                	ja     100a91 <printer_vprintf+0x4c9>
  100a61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a68:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a73:	8b 00                	mov    (%rax),%eax
  100a75:	89 c0                	mov    %eax,%eax
  100a77:	48 01 d0             	add    %rdx,%rax
  100a7a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a81:	8b 12                	mov    (%rdx),%edx
  100a83:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a86:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a8d:	89 0a                	mov    %ecx,(%rdx)
  100a8f:	eb 1a                	jmp    100aab <printer_vprintf+0x4e3>
  100a91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a98:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a9c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100aa0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aa7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aab:	8b 00                	mov    (%rax),%eax
  100aad:	89 c0                	mov    %eax,%eax
  100aaf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100ab3:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100ab7:	e9 03 02 00 00       	jmp    100cbf <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100abc:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100ac3:	e9 28 ff ff ff       	jmp    1009f0 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100ac8:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100acf:	e9 1c ff ff ff       	jmp    1009f0 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100ad4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100adb:	8b 00                	mov    (%rax),%eax
  100add:	83 f8 2f             	cmp    $0x2f,%eax
  100ae0:	77 30                	ja     100b12 <printer_vprintf+0x54a>
  100ae2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ae9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100aed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af4:	8b 00                	mov    (%rax),%eax
  100af6:	89 c0                	mov    %eax,%eax
  100af8:	48 01 d0             	add    %rdx,%rax
  100afb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b02:	8b 12                	mov    (%rdx),%edx
  100b04:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b0e:	89 0a                	mov    %ecx,(%rdx)
  100b10:	eb 1a                	jmp    100b2c <printer_vprintf+0x564>
  100b12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b19:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b1d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b28:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b2c:	48 8b 00             	mov    (%rax),%rax
  100b2f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100b33:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100b3a:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100b41:	e9 79 01 00 00       	jmp    100cbf <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100b46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b4d:	8b 00                	mov    (%rax),%eax
  100b4f:	83 f8 2f             	cmp    $0x2f,%eax
  100b52:	77 30                	ja     100b84 <printer_vprintf+0x5bc>
  100b54:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b5b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b5f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b66:	8b 00                	mov    (%rax),%eax
  100b68:	89 c0                	mov    %eax,%eax
  100b6a:	48 01 d0             	add    %rdx,%rax
  100b6d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b74:	8b 12                	mov    (%rdx),%edx
  100b76:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b80:	89 0a                	mov    %ecx,(%rdx)
  100b82:	eb 1a                	jmp    100b9e <printer_vprintf+0x5d6>
  100b84:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b8b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b8f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b9a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b9e:	48 8b 00             	mov    (%rax),%rax
  100ba1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100ba5:	e9 15 01 00 00       	jmp    100cbf <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100baa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bb1:	8b 00                	mov    (%rax),%eax
  100bb3:	83 f8 2f             	cmp    $0x2f,%eax
  100bb6:	77 30                	ja     100be8 <printer_vprintf+0x620>
  100bb8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bbf:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bc3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bca:	8b 00                	mov    (%rax),%eax
  100bcc:	89 c0                	mov    %eax,%eax
  100bce:	48 01 d0             	add    %rdx,%rax
  100bd1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bd8:	8b 12                	mov    (%rdx),%edx
  100bda:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bdd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100be4:	89 0a                	mov    %ecx,(%rdx)
  100be6:	eb 1a                	jmp    100c02 <printer_vprintf+0x63a>
  100be8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bef:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bf3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bf7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bfe:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c02:	8b 00                	mov    (%rax),%eax
  100c04:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100c0a:	e9 67 03 00 00       	jmp    100f76 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100c0f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c13:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100c17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c1e:	8b 00                	mov    (%rax),%eax
  100c20:	83 f8 2f             	cmp    $0x2f,%eax
  100c23:	77 30                	ja     100c55 <printer_vprintf+0x68d>
  100c25:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c30:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c37:	8b 00                	mov    (%rax),%eax
  100c39:	89 c0                	mov    %eax,%eax
  100c3b:	48 01 d0             	add    %rdx,%rax
  100c3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c45:	8b 12                	mov    (%rdx),%edx
  100c47:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c4a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c51:	89 0a                	mov    %ecx,(%rdx)
  100c53:	eb 1a                	jmp    100c6f <printer_vprintf+0x6a7>
  100c55:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c5c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c60:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c64:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c6b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c6f:	8b 00                	mov    (%rax),%eax
  100c71:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100c74:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100c78:	eb 45                	jmp    100cbf <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100c7a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c7e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100c82:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c89:	0f b6 00             	movzbl (%rax),%eax
  100c8c:	84 c0                	test   %al,%al
  100c8e:	74 0c                	je     100c9c <printer_vprintf+0x6d4>
  100c90:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c97:	0f b6 00             	movzbl (%rax),%eax
  100c9a:	eb 05                	jmp    100ca1 <printer_vprintf+0x6d9>
  100c9c:	b8 25 00 00 00       	mov    $0x25,%eax
  100ca1:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100ca4:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100ca8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100caf:	0f b6 00             	movzbl (%rax),%eax
  100cb2:	84 c0                	test   %al,%al
  100cb4:	75 08                	jne    100cbe <printer_vprintf+0x6f6>
                format--;
  100cb6:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100cbd:	01 
            }
            break;
  100cbe:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100cbf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cc2:	83 e0 20             	and    $0x20,%eax
  100cc5:	85 c0                	test   %eax,%eax
  100cc7:	74 1e                	je     100ce7 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100cc9:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100ccd:	48 83 c0 18          	add    $0x18,%rax
  100cd1:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100cd4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100cd8:	48 89 ce             	mov    %rcx,%rsi
  100cdb:	48 89 c7             	mov    %rax,%rdi
  100cde:	e8 63 f8 ff ff       	call   100546 <fill_numbuf>
  100ce3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100ce7:	48 c7 45 c0 06 13 10 	movq   $0x101306,-0x40(%rbp)
  100cee:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100cef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cf2:	83 e0 20             	and    $0x20,%eax
  100cf5:	85 c0                	test   %eax,%eax
  100cf7:	74 48                	je     100d41 <printer_vprintf+0x779>
  100cf9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cfc:	83 e0 40             	and    $0x40,%eax
  100cff:	85 c0                	test   %eax,%eax
  100d01:	74 3e                	je     100d41 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100d03:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d06:	25 80 00 00 00       	and    $0x80,%eax
  100d0b:	85 c0                	test   %eax,%eax
  100d0d:	74 0a                	je     100d19 <printer_vprintf+0x751>
                prefix = "-";
  100d0f:	48 c7 45 c0 07 13 10 	movq   $0x101307,-0x40(%rbp)
  100d16:	00 
            if (flags & FLAG_NEGATIVE) {
  100d17:	eb 73                	jmp    100d8c <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100d19:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d1c:	83 e0 10             	and    $0x10,%eax
  100d1f:	85 c0                	test   %eax,%eax
  100d21:	74 0a                	je     100d2d <printer_vprintf+0x765>
                prefix = "+";
  100d23:	48 c7 45 c0 09 13 10 	movq   $0x101309,-0x40(%rbp)
  100d2a:	00 
            if (flags & FLAG_NEGATIVE) {
  100d2b:	eb 5f                	jmp    100d8c <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100d2d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d30:	83 e0 08             	and    $0x8,%eax
  100d33:	85 c0                	test   %eax,%eax
  100d35:	74 55                	je     100d8c <printer_vprintf+0x7c4>
                prefix = " ";
  100d37:	48 c7 45 c0 0b 13 10 	movq   $0x10130b,-0x40(%rbp)
  100d3e:	00 
            if (flags & FLAG_NEGATIVE) {
  100d3f:	eb 4b                	jmp    100d8c <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100d41:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d44:	83 e0 20             	and    $0x20,%eax
  100d47:	85 c0                	test   %eax,%eax
  100d49:	74 42                	je     100d8d <printer_vprintf+0x7c5>
  100d4b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d4e:	83 e0 01             	and    $0x1,%eax
  100d51:	85 c0                	test   %eax,%eax
  100d53:	74 38                	je     100d8d <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  100d55:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100d59:	74 06                	je     100d61 <printer_vprintf+0x799>
  100d5b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100d5f:	75 2c                	jne    100d8d <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  100d61:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100d66:	75 0c                	jne    100d74 <printer_vprintf+0x7ac>
  100d68:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d6b:	25 00 01 00 00       	and    $0x100,%eax
  100d70:	85 c0                	test   %eax,%eax
  100d72:	74 19                	je     100d8d <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  100d74:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100d78:	75 07                	jne    100d81 <printer_vprintf+0x7b9>
  100d7a:	b8 0d 13 10 00       	mov    $0x10130d,%eax
  100d7f:	eb 05                	jmp    100d86 <printer_vprintf+0x7be>
  100d81:	b8 10 13 10 00       	mov    $0x101310,%eax
  100d86:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100d8a:	eb 01                	jmp    100d8d <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  100d8c:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100d8d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d91:	78 24                	js     100db7 <printer_vprintf+0x7ef>
  100d93:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d96:	83 e0 20             	and    $0x20,%eax
  100d99:	85 c0                	test   %eax,%eax
  100d9b:	75 1a                	jne    100db7 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  100d9d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100da0:	48 63 d0             	movslq %eax,%rdx
  100da3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100da7:	48 89 d6             	mov    %rdx,%rsi
  100daa:	48 89 c7             	mov    %rax,%rdi
  100dad:	e8 ea f5 ff ff       	call   10039c <strnlen>
  100db2:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100db5:	eb 0f                	jmp    100dc6 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  100db7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100dbb:	48 89 c7             	mov    %rax,%rdi
  100dbe:	e8 a8 f5 ff ff       	call   10036b <strlen>
  100dc3:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100dc6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dc9:	83 e0 20             	and    $0x20,%eax
  100dcc:	85 c0                	test   %eax,%eax
  100dce:	74 20                	je     100df0 <printer_vprintf+0x828>
  100dd0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100dd4:	78 1a                	js     100df0 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  100dd6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100dd9:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100ddc:	7e 08                	jle    100de6 <printer_vprintf+0x81e>
  100dde:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100de1:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100de4:	eb 05                	jmp    100deb <printer_vprintf+0x823>
  100de6:	b8 00 00 00 00       	mov    $0x0,%eax
  100deb:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100dee:	eb 5c                	jmp    100e4c <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100df0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100df3:	83 e0 20             	and    $0x20,%eax
  100df6:	85 c0                	test   %eax,%eax
  100df8:	74 4b                	je     100e45 <printer_vprintf+0x87d>
  100dfa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dfd:	83 e0 02             	and    $0x2,%eax
  100e00:	85 c0                	test   %eax,%eax
  100e02:	74 41                	je     100e45 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100e04:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e07:	83 e0 04             	and    $0x4,%eax
  100e0a:	85 c0                	test   %eax,%eax
  100e0c:	75 37                	jne    100e45 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  100e0e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e12:	48 89 c7             	mov    %rax,%rdi
  100e15:	e8 51 f5 ff ff       	call   10036b <strlen>
  100e1a:	89 c2                	mov    %eax,%edx
  100e1c:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100e1f:	01 d0                	add    %edx,%eax
  100e21:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100e24:	7e 1f                	jle    100e45 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  100e26:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100e29:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e2c:	89 c3                	mov    %eax,%ebx
  100e2e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e32:	48 89 c7             	mov    %rax,%rdi
  100e35:	e8 31 f5 ff ff       	call   10036b <strlen>
  100e3a:	89 c2                	mov    %eax,%edx
  100e3c:	89 d8                	mov    %ebx,%eax
  100e3e:	29 d0                	sub    %edx,%eax
  100e40:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100e43:	eb 07                	jmp    100e4c <printer_vprintf+0x884>
        } else {
            zeros = 0;
  100e45:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100e4c:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100e4f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100e52:	01 d0                	add    %edx,%eax
  100e54:	48 63 d8             	movslq %eax,%rbx
  100e57:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e5b:	48 89 c7             	mov    %rax,%rdi
  100e5e:	e8 08 f5 ff ff       	call   10036b <strlen>
  100e63:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100e67:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100e6a:	29 d0                	sub    %edx,%eax
  100e6c:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100e6f:	eb 25                	jmp    100e96 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  100e71:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e78:	48 8b 08             	mov    (%rax),%rcx
  100e7b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e81:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e88:	be 20 00 00 00       	mov    $0x20,%esi
  100e8d:	48 89 c7             	mov    %rax,%rdi
  100e90:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100e92:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100e96:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e99:	83 e0 04             	and    $0x4,%eax
  100e9c:	85 c0                	test   %eax,%eax
  100e9e:	75 36                	jne    100ed6 <printer_vprintf+0x90e>
  100ea0:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100ea4:	7f cb                	jg     100e71 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  100ea6:	eb 2e                	jmp    100ed6 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  100ea8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100eaf:	4c 8b 00             	mov    (%rax),%r8
  100eb2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100eb6:	0f b6 00             	movzbl (%rax),%eax
  100eb9:	0f b6 c8             	movzbl %al,%ecx
  100ebc:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ec2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ec9:	89 ce                	mov    %ecx,%esi
  100ecb:	48 89 c7             	mov    %rax,%rdi
  100ece:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100ed1:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100ed6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100eda:	0f b6 00             	movzbl (%rax),%eax
  100edd:	84 c0                	test   %al,%al
  100edf:	75 c7                	jne    100ea8 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  100ee1:	eb 25                	jmp    100f08 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  100ee3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100eea:	48 8b 08             	mov    (%rax),%rcx
  100eed:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ef3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100efa:	be 30 00 00 00       	mov    $0x30,%esi
  100eff:	48 89 c7             	mov    %rax,%rdi
  100f02:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100f04:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100f08:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100f0c:	7f d5                	jg     100ee3 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  100f0e:	eb 32                	jmp    100f42 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  100f10:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f17:	4c 8b 00             	mov    (%rax),%r8
  100f1a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f1e:	0f b6 00             	movzbl (%rax),%eax
  100f21:	0f b6 c8             	movzbl %al,%ecx
  100f24:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f2a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f31:	89 ce                	mov    %ecx,%esi
  100f33:	48 89 c7             	mov    %rax,%rdi
  100f36:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100f39:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100f3e:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100f42:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100f46:	7f c8                	jg     100f10 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  100f48:	eb 25                	jmp    100f6f <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  100f4a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f51:	48 8b 08             	mov    (%rax),%rcx
  100f54:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f5a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f61:	be 20 00 00 00       	mov    $0x20,%esi
  100f66:	48 89 c7             	mov    %rax,%rdi
  100f69:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100f6b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f6f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f73:	7f d5                	jg     100f4a <printer_vprintf+0x982>
        }
    done: ;
  100f75:	90                   	nop
    for (; *format; ++format) {
  100f76:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f7d:	01 
  100f7e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f85:	0f b6 00             	movzbl (%rax),%eax
  100f88:	84 c0                	test   %al,%al
  100f8a:	0f 85 64 f6 ff ff    	jne    1005f4 <printer_vprintf+0x2c>
    }
}
  100f90:	90                   	nop
  100f91:	90                   	nop
  100f92:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100f96:	c9                   	leave  
  100f97:	c3                   	ret    

0000000000100f98 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100f98:	55                   	push   %rbp
  100f99:	48 89 e5             	mov    %rsp,%rbp
  100f9c:	48 83 ec 20          	sub    $0x20,%rsp
  100fa0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100fa4:	89 f0                	mov    %esi,%eax
  100fa6:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100fa9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  100fac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100fb0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100fb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fb8:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fbc:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  100fc1:	48 39 d0             	cmp    %rdx,%rax
  100fc4:	72 0c                	jb     100fd2 <console_putc+0x3a>
        cp->cursor = console;
  100fc6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fca:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  100fd1:	00 
    }
    if (c == '\n') {
  100fd2:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  100fd6:	75 78                	jne    101050 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  100fd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fdc:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fe0:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100fe6:	48 d1 f8             	sar    %rax
  100fe9:	48 89 c1             	mov    %rax,%rcx
  100fec:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100ff3:	66 66 66 
  100ff6:	48 89 c8             	mov    %rcx,%rax
  100ff9:	48 f7 ea             	imul   %rdx
  100ffc:	48 c1 fa 05          	sar    $0x5,%rdx
  101000:	48 89 c8             	mov    %rcx,%rax
  101003:	48 c1 f8 3f          	sar    $0x3f,%rax
  101007:	48 29 c2             	sub    %rax,%rdx
  10100a:	48 89 d0             	mov    %rdx,%rax
  10100d:	48 c1 e0 02          	shl    $0x2,%rax
  101011:	48 01 d0             	add    %rdx,%rax
  101014:	48 c1 e0 04          	shl    $0x4,%rax
  101018:	48 29 c1             	sub    %rax,%rcx
  10101b:	48 89 ca             	mov    %rcx,%rdx
  10101e:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101021:	eb 25                	jmp    101048 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101023:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101026:	83 c8 20             	or     $0x20,%eax
  101029:	89 c6                	mov    %eax,%esi
  10102b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10102f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101033:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101037:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10103b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10103f:	89 f2                	mov    %esi,%edx
  101041:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101044:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101048:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  10104c:	75 d5                	jne    101023 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  10104e:	eb 24                	jmp    101074 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101050:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101054:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101057:	09 d0                	or     %edx,%eax
  101059:	89 c6                	mov    %eax,%esi
  10105b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10105f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101063:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101067:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10106b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10106f:	89 f2                	mov    %esi,%edx
  101071:	66 89 10             	mov    %dx,(%rax)
}
  101074:	90                   	nop
  101075:	c9                   	leave  
  101076:	c3                   	ret    

0000000000101077 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101077:	55                   	push   %rbp
  101078:	48 89 e5             	mov    %rsp,%rbp
  10107b:	48 83 ec 30          	sub    $0x30,%rsp
  10107f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101082:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101085:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101089:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  10108d:	48 c7 45 f0 98 0f 10 	movq   $0x100f98,-0x10(%rbp)
  101094:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101095:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101099:	78 09                	js     1010a4 <console_vprintf+0x2d>
  10109b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1010a2:	7e 07                	jle    1010ab <console_vprintf+0x34>
        cpos = 0;
  1010a4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1010ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010ae:	48 98                	cltq   
  1010b0:	48 01 c0             	add    %rax,%rax
  1010b3:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1010b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1010bd:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1010c1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1010c5:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1010c8:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1010cc:	48 89 c7             	mov    %rax,%rdi
  1010cf:	e8 f4 f4 ff ff       	call   1005c8 <printer_vprintf>
    return cp.cursor - console;
  1010d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1010d8:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1010de:	48 d1 f8             	sar    %rax
}
  1010e1:	c9                   	leave  
  1010e2:	c3                   	ret    

00000000001010e3 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1010e3:	55                   	push   %rbp
  1010e4:	48 89 e5             	mov    %rsp,%rbp
  1010e7:	48 83 ec 60          	sub    $0x60,%rsp
  1010eb:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1010ee:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1010f1:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1010f5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1010f9:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1010fd:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101101:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101108:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10110c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101110:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101114:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101118:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10111c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101120:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101123:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101126:	89 c7                	mov    %eax,%edi
  101128:	e8 4a ff ff ff       	call   101077 <console_vprintf>
  10112d:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101130:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101133:	c9                   	leave  
  101134:	c3                   	ret    

0000000000101135 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101135:	55                   	push   %rbp
  101136:	48 89 e5             	mov    %rsp,%rbp
  101139:	48 83 ec 20          	sub    $0x20,%rsp
  10113d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101141:	89 f0                	mov    %esi,%eax
  101143:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101146:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101149:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10114d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101151:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101155:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101159:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10115d:	48 8b 40 10          	mov    0x10(%rax),%rax
  101161:	48 39 c2             	cmp    %rax,%rdx
  101164:	73 1a                	jae    101180 <string_putc+0x4b>
        *sp->s++ = c;
  101166:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10116a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10116e:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101172:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101176:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10117a:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10117e:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101180:	90                   	nop
  101181:	c9                   	leave  
  101182:	c3                   	ret    

0000000000101183 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101183:	55                   	push   %rbp
  101184:	48 89 e5             	mov    %rsp,%rbp
  101187:	48 83 ec 40          	sub    $0x40,%rsp
  10118b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  10118f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101193:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101197:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10119b:	48 c7 45 e8 35 11 10 	movq   $0x101135,-0x18(%rbp)
  1011a2:	00 
    sp.s = s;
  1011a3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1011a7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1011ab:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1011b0:	74 33                	je     1011e5 <vsnprintf+0x62>
        sp.end = s + size - 1;
  1011b2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1011b6:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1011ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1011be:	48 01 d0             	add    %rdx,%rax
  1011c1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1011c5:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1011c9:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1011cd:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1011d1:	be 00 00 00 00       	mov    $0x0,%esi
  1011d6:	48 89 c7             	mov    %rax,%rdi
  1011d9:	e8 ea f3 ff ff       	call   1005c8 <printer_vprintf>
        *sp.s = 0;
  1011de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011e2:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1011e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011e9:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1011ed:	c9                   	leave  
  1011ee:	c3                   	ret    

00000000001011ef <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1011ef:	55                   	push   %rbp
  1011f0:	48 89 e5             	mov    %rsp,%rbp
  1011f3:	48 83 ec 70          	sub    $0x70,%rsp
  1011f7:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1011fb:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1011ff:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101203:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101207:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10120b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10120f:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101216:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10121a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10121e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101222:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101226:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  10122a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10122e:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101232:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101236:	48 89 c7             	mov    %rax,%rdi
  101239:	e8 45 ff ff ff       	call   101183 <vsnprintf>
  10123e:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101241:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101244:	c9                   	leave  
  101245:	c3                   	ret    

0000000000101246 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101246:	55                   	push   %rbp
  101247:	48 89 e5             	mov    %rsp,%rbp
  10124a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10124e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101255:	eb 13                	jmp    10126a <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  101257:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10125a:	48 98                	cltq   
  10125c:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101263:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101266:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10126a:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101271:	7e e4                	jle    101257 <console_clear+0x11>
    }
    cursorpos = 0;
  101273:	c7 05 7f 7d fb ff 00 	movl   $0x0,-0x48281(%rip)        # b8ffc <cursorpos>
  10127a:	00 00 00 
}
  10127d:	90                   	nop
  10127e:	c9                   	leave  
  10127f:	c3                   	ret    
