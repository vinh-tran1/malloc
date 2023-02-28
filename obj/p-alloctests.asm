
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 56                	push   %r14
  2c0006:	41 55                	push   %r13
  2c0008:	41 54                	push   %r12
  2c000a:	53                   	push   %rbx
  2c000b:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c000f:	cd 31                	int    $0x31
  2c0011:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0014:	89 c7                	mov    %eax,%edi
  2c0016:	e8 83 0a 00 00       	call   2c0a9e <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 e0 04 00 00       	call   2c0505 <malloc>
  2c0025:	48 89 c7             	mov    %rax,%rdi
  2c0028:	ba 00 00 00 00       	mov    $0x0,%edx
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c002d:	89 14 97             	mov    %edx,(%rdi,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  2c0030:	48 83 c2 01          	add    $0x1,%rdx
  2c0034:	48 83 fa 0a          	cmp    $0xa,%rdx
  2c0038:	75 f3                	jne    2c002d <process_main+0x2d>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c003a:	be 50 00 00 00       	mov    $0x50,%esi
  2c003f:	e8 c5 05 00 00       	call   2c0609 <realloc>
  2c0044:	49 89 c5             	mov    %rax,%r13
  2c0047:	b8 00 00 00 00       	mov    $0x0,%eax

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c004c:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0051:	75 64                	jne    2c00b7 <process_main+0xb7>
    for(int i = 0 ; i < 10 ; i++){
  2c0053:	48 83 c0 01          	add    $0x1,%rax
  2c0057:	48 83 f8 0a          	cmp    $0xa,%rax
  2c005b:	75 ef                	jne    2c004c <process_main+0x4c>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c005d:	be 04 00 00 00       	mov    $0x4,%esi
  2c0062:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c0067:	e8 3c 05 00 00       	call   2c05a8 <calloc>
  2c006c:	49 89 c6             	mov    %rax,%r14

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c006f:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c0073:	8b 18                	mov    (%rax),%ebx
  2c0075:	85 db                	test   %ebx,%ebx
  2c0077:	75 52                	jne    2c00cb <process_main+0xcb>
    for(int i = 0 ; i < 30; i++){
  2c0079:	48 83 c0 04          	add    $0x4,%rax
  2c007d:	48 39 d0             	cmp    %rdx,%rax
  2c0080:	75 f1                	jne    2c0073 <process_main+0x73>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c0082:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  2c0086:	e8 27 06 00 00       	call   2c06b2 <heap_info>
  2c008b:	85 c0                	test   %eax,%eax
  2c008d:	75 64                	jne    2c00f3 <process_main+0xf3>
	// check if allocations are in sorted order
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c008f:	8b 55 c0             	mov    -0x40(%rbp),%edx
  2c0092:	83 fa 01             	cmp    $0x1,%edx
  2c0095:	7e 70                	jle    2c0107 <process_main+0x107>
  2c0097:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c009b:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c009e:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00a3:	48 8b 30             	mov    (%rax),%rsi
  2c00a6:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c00aa:	7d 33                	jge    2c00df <process_main+0xdf>
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00ac:	48 83 c0 08          	add    $0x8,%rax
  2c00b0:	48 39 d0             	cmp    %rdx,%rax
  2c00b3:	75 ee                	jne    2c00a3 <process_main+0xa3>
  2c00b5:	eb 50                	jmp    2c0107 <process_main+0x107>
	assert(array[i] == i);
  2c00b7:	ba 00 18 2c 00       	mov    $0x2c1800,%edx
  2c00bc:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c1:	bf 0e 18 2c 00       	mov    $0x2c180e,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 24 18 2c 00       	mov    $0x2c1824,%edx
  2c00d0:	be 21 00 00 00       	mov    $0x21,%esi
  2c00d5:	bf 0e 18 2c 00       	mov    $0x2c180e,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba 48 18 2c 00       	mov    $0x2c1848,%edx
  2c00e4:	be 28 00 00 00       	mov    $0x28,%esi
  2c00e9:	bf 0e 18 2c 00       	mov    $0x2c180e,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be 33 18 2c 00       	mov    $0x2c1833,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 ed 04 00 00       	call   2c05fc <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 e5 04 00 00       	call   2c05fc <free>

    uint64_t total_time = 0;
  2c0117:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c011d:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c011f:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0123:	89 c0                	mov    %eax,%eax
  2c0125:	48 09 c2             	or     %rax,%rdx
  2c0128:	49 89 d6             	mov    %rdx,%r14
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c012b:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c0130:	e8 d0 03 00 00       	call   2c0505 <malloc>
  2c0135:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c0138:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c013a:	48 c1 e2 20          	shl    $0x20,%rdx
  2c013e:	89 c0                	mov    %eax,%eax
  2c0140:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c0143:	4c 29 f2             	sub    %r14,%rdx
  2c0146:	49 01 d5             	add    %rdx,%r13
	if(ptr == NULL)
  2c0149:	48 85 c9             	test   %rcx,%rcx
  2c014c:	74 08                	je     2c0156 <process_main+0x156>
	    break;
	total_pages++;
  2c014e:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c0151:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c0154:	eb c7                	jmp    2c011d <process_main+0x11d>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c0156:	48 63 db             	movslq %ebx,%rbx
  2c0159:	4c 89 e8             	mov    %r13,%rax
  2c015c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0161:	48 f7 f3             	div    %rbx
  2c0164:	48 89 c1             	mov    %rax,%rcx
  2c0167:	4c 89 ea             	mov    %r13,%rdx
  2c016a:	be 78 18 2c 00       	mov    $0x2c1878,%esi
  2c016f:	44 89 e7             	mov    %r12d,%edi
  2c0172:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0177:	e8 04 00 00 00       	call   2c0180 <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c017c:	cd 32                	int    $0x32
  2c017e:	eb fc                	jmp    2c017c <process_main+0x17c>

00000000002c0180 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c0180:	55                   	push   %rbp
  2c0181:	48 89 e5             	mov    %rsp,%rbp
  2c0184:	48 83 ec 50          	sub    $0x50,%rsp
  2c0188:	49 89 f2             	mov    %rsi,%r10
  2c018b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c018f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0193:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0197:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c019b:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c01a0:	85 ff                	test   %edi,%edi
  2c01a2:	78 2e                	js     2c01d2 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c01a4:	48 63 ff             	movslq %edi,%rdi
  2c01a7:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c01ae:	cc cc cc 
  2c01b1:	48 89 f8             	mov    %rdi,%rax
  2c01b4:	48 f7 e2             	mul    %rdx
  2c01b7:	48 89 d0             	mov    %rdx,%rax
  2c01ba:	48 c1 e8 02          	shr    $0x2,%rax
  2c01be:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c01c2:	48 01 c2             	add    %rax,%rdx
  2c01c5:	48 29 d7             	sub    %rdx,%rdi
  2c01c8:	0f b6 b7 dd 18 2c 00 	movzbl 0x2c18dd(%rdi),%esi
  2c01cf:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c01d2:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c01d9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c01dd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c01e1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c01e5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c01e9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c01ed:	4c 89 d2             	mov    %r10,%rdx
  2c01f0:	8b 3d 06 8e df ff    	mov    -0x2071fa(%rip),%edi        # b8ffc <cursorpos>
  2c01f6:	e8 f5 13 00 00       	call   2c15f0 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c01fb:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c0200:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0205:	0f 4d c2             	cmovge %edx,%eax
  2c0208:	89 05 ee 8d df ff    	mov    %eax,-0x207212(%rip)        # b8ffc <cursorpos>
    }
}
  2c020e:	c9                   	leave  
  2c020f:	c3                   	ret    

00000000002c0210 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c0210:	55                   	push   %rbp
  2c0211:	48 89 e5             	mov    %rsp,%rbp
  2c0214:	53                   	push   %rbx
  2c0215:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c021c:	48 89 fb             	mov    %rdi,%rbx
  2c021f:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c0223:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c0227:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c022b:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c022f:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c0233:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c023a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c023e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c0242:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c0246:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c024a:	ba 07 00 00 00       	mov    $0x7,%edx
  2c024f:	be a8 18 2c 00       	mov    $0x2c18a8,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 47 05 00 00       	call   2c07a7 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 84 14 00 00       	call   2c16fc <vsnprintf>
  2c0278:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c027b:	85 d2                	test   %edx,%edx
  2c027d:	7e 0f                	jle    2c028e <kernel_panic+0x7e>
  2c027f:	83 c0 06             	add    $0x6,%eax
  2c0282:	48 98                	cltq   
  2c0284:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c028b:	0a 
  2c028c:	75 2a                	jne    2c02b8 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c028e:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c0295:	48 89 d9             	mov    %rbx,%rcx
  2c0298:	ba b0 18 2c 00       	mov    $0x2c18b0,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 ab 13 00 00       	call   2c165c <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  2c02b1:	48 89 df             	mov    %rbx,%rdi
  2c02b4:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  2c02b6:	eb fe                	jmp    2c02b6 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c02b8:	48 63 c2             	movslq %edx,%rax
  2c02bb:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c02c1:	0f 94 c2             	sete   %dl
  2c02c4:	0f b6 d2             	movzbl %dl,%edx
  2c02c7:	48 29 d0             	sub    %rdx,%rax
  2c02ca:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c02d1:	ff 
  2c02d2:	be 43 18 2c 00       	mov    $0x2c1843,%esi
  2c02d7:	e8 78 06 00 00       	call   2c0954 <strcpy>
  2c02dc:	eb b0                	jmp    2c028e <kernel_panic+0x7e>

00000000002c02de <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c02de:	55                   	push   %rbp
  2c02df:	48 89 e5             	mov    %rsp,%rbp
  2c02e2:	48 89 f9             	mov    %rdi,%rcx
  2c02e5:	41 89 f0             	mov    %esi,%r8d
  2c02e8:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c02eb:	ba b8 18 2c 00       	mov    $0x2c18b8,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 58 13 00 00       	call   2c165c <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0304:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0309:	cd 30                	int    $0x30
 loop: goto loop;
  2c030b:	eb fe                	jmp    2c030b <assert_fail+0x2d>

00000000002c030d <init_node>:
//====================================================//

//-----------helper functions------------------//
void init_node(bh* ptr, int allocated, size_t size)
{
    ptr->allocated = allocated;
  2c030d:	89 37                	mov    %esi,(%rdi)
    ptr->size = size;
  2c030f:	48 89 57 08          	mov    %rdx,0x8(%rdi)
    ptr->block_payload = GET_PAYLOAD(ptr);
  2c0313:	48 8d 47 20          	lea    0x20(%rdi),%rax
  2c0317:	48 89 47 18          	mov    %rax,0x18(%rdi)
}
  2c031b:	c3                   	ret    

00000000002c031c <addToHeap>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c031c:	cd 3a                	int    $0x3a
  2c031e:	48 89 05 eb 1c 00 00 	mov    %rax,0x1ceb(%rip)        # 2c2010 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c0325:	48 89 c2             	mov    %rax,%rdx

bh* addToHeap(uint64_t alignedbytes)
{
    void *newbp = sbrk(alignedbytes);
    if (newbp == (void*)-1) 
  2c0328:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c032c:	74 1e                	je     2c034c <addToHeap+0x30>
    ptr->allocated = allocated;
  2c032e:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
    ptr->size = size;
  2c0334:	48 89 78 08          	mov    %rdi,0x8(%rax)
    ptr->block_payload = GET_PAYLOAD(ptr);
  2c0338:	48 8d 48 20          	lea    0x20(%rax),%rcx
  2c033c:	48 89 48 18          	mov    %rcx,0x18(%rax)
        return NULL;
        
    bh *newhead = (bh*)newbp;
    init_node(newbp, 1, alignedbytes);

    newhead->next = NULL;  
  2c0340:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  2c0347:	00 

    return newhead;
}
  2c0348:	48 89 d0             	mov    %rdx,%rax
  2c034b:	c3                   	ret    
        return NULL;
  2c034c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0351:	eb f5                	jmp    2c0348 <addToHeap+0x2c>

00000000002c0353 <splitBlock>:

void splitBlock(uint64_t alignedbytes, bh* b)
{
    bh *new = NEXT_HEADER(b, alignedbytes); //new now points to end of curr's payload
  2c0353:	48 8d 04 3e          	lea    (%rsi,%rdi,1),%rax
    init_node(new, 0, b->size - alignedbytes); //set struct values
  2c0357:	48 8b 56 08          	mov    0x8(%rsi),%rdx
  2c035b:	48 29 fa             	sub    %rdi,%rdx
    ptr->allocated = allocated;
  2c035e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    ptr->size = size;
  2c0364:	48 89 50 08          	mov    %rdx,0x8(%rax)
    ptr->block_payload = GET_PAYLOAD(ptr);
  2c0368:	48 8d 50 20          	lea    0x20(%rax),%rdx
  2c036c:	48 89 50 18          	mov    %rdx,0x18(%rax)

    if (b->next == NULL)//set new end pointer if b points to end (i.e. now new is end)        
  2c0370:	48 8b 56 10          	mov    0x10(%rsi),%rdx
  2c0374:	48 85 d2             	test   %rdx,%rdx
  2c0377:	74 0d                	je     2c0386 <splitBlock+0x33>
        end = new;
    
    new->next = b->next; 
  2c0379:	48 89 50 10          	mov    %rdx,0x10(%rax)
    b->next = new;
  2c037d:	48 89 46 10          	mov    %rax,0x10(%rsi)
    b->size = alignedbytes;
  2c0381:	48 89 7e 08          	mov    %rdi,0x8(%rsi)
}
  2c0385:	c3                   	ret    
        end = new;
  2c0386:	48 89 05 73 1c 00 00 	mov    %rax,0x1c73(%rip)        # 2c2000 <end>
  2c038d:	eb ea                	jmp    2c0379 <splitBlock+0x26>

00000000002c038f <setFreeAndAlloc>:
    int freeSpace = 0; //size of free space
    int largestFreeChunk = 0; //size of the largest free chunk

    //===========================================//
    //initial loop to get data for number of allocs and frees
    bh* curr = head;
  2c038f:	48 8b 05 72 1c 00 00 	mov    0x1c72(%rip),%rax        # 2c2008 <head>
    while (curr != NULL)
  2c0396:	48 85 c0             	test   %rax,%rax
  2c0399:	74 35                	je     2c03d0 <setFreeAndAlloc+0x41>
    int largestFreeChunk = 0; //size of the largest free chunk
  2c039b:	b9 00 00 00 00       	mov    $0x0,%ecx
    int freeSpace = 0; //size of free space
  2c03a0:	be 00 00 00 00       	mov    $0x0,%esi
    int numAllocs = 0; //store current number of allocations
  2c03a5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  2c03ab:	eb 0d                	jmp    2c03ba <setFreeAndAlloc+0x2b>
    {
        if (curr->allocated == 1)
            numAllocs++;
  2c03ad:	41 83 c1 01          	add    $0x1,%r9d
        else {
            freeSpace += curr->size;
            if (curr->size > (uint64_t)largestFreeChunk) //basic algorithm for finding max
                largestFreeChunk = curr->size;
        }
        curr = curr->next;
  2c03b1:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (curr != NULL)
  2c03b5:	48 85 c0             	test   %rax,%rax
  2c03b8:	74 26                	je     2c03e0 <setFreeAndAlloc+0x51>
        if (curr->allocated == 1)
  2c03ba:	83 38 01             	cmpl   $0x1,(%rax)
  2c03bd:	74 ee                	je     2c03ad <setFreeAndAlloc+0x1e>
            freeSpace += curr->size;
  2c03bf:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c03c3:	01 d6                	add    %edx,%esi
            if (curr->size > (uint64_t)largestFreeChunk) //basic algorithm for finding max
  2c03c5:	4c 63 c1             	movslq %ecx,%r8
                largestFreeChunk = curr->size;
  2c03c8:	49 39 d0             	cmp    %rdx,%r8
  2c03cb:	0f 42 ca             	cmovb  %edx,%ecx
  2c03ce:	eb e1                	jmp    2c03b1 <setFreeAndAlloc+0x22>
    int largestFreeChunk = 0; //size of the largest free chunk
  2c03d0:	b9 00 00 00 00       	mov    $0x0,%ecx
    int freeSpace = 0; //size of free space
  2c03d5:	be 00 00 00 00       	mov    $0x0,%esi
    int numAllocs = 0; //store current number of allocations
  2c03da:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    }
    //===========================================//
    //set the 3 fields from previous while loop in the info struct
    info->free_space = freeSpace;
  2c03e0:	89 77 18             	mov    %esi,0x18(%rdi)
    info->largest_free_chunk = largestFreeChunk;
  2c03e3:	89 4f 1c             	mov    %ecx,0x1c(%rdi)
    info->num_allocs = numAllocs;
  2c03e6:	44 89 0f             	mov    %r9d,(%rdi)
    //===========================================//
}
  2c03e9:	c3                   	ret    

00000000002c03ea <swapSize>:
//qsort helpers via programiz.com
//===========================================//

// function to swap elements of type long
void swapSize(long *a, long *b) {
  long temp = *a;
  2c03ea:	48 8b 07             	mov    (%rdi),%rax
  *a = *b;
  2c03ed:	48 8b 16             	mov    (%rsi),%rdx
  2c03f0:	48 89 17             	mov    %rdx,(%rdi)
  *b = temp;
  2c03f3:	48 89 06             	mov    %rax,(%rsi)
}
  2c03f6:	c3                   	ret    

00000000002c03f7 <swapPtr>:

//function to swap elemnts of type void*
void swapPtr(void **a, void **b) {
  void *temp = *a;
  2c03f7:	48 8b 07             	mov    (%rdi),%rax
  *a = *b;
  2c03fa:	48 8b 16             	mov    (%rsi),%rdx
  2c03fd:	48 89 17             	mov    %rdx,(%rdi)
  *b = temp;
  2c0400:	48 89 06             	mov    %rax,(%rsi)
}
  2c0403:	c3                   	ret    

00000000002c0404 <partition>:

//function to partition the array on the basis of pivot element
int partition(long *sizeArray, void **ptrArray, int low, int high)
{
  2c0404:	55                   	push   %rbp
  2c0405:	48 89 e5             	mov    %rsp,%rbp
  2c0408:	41 55                	push   %r13
  2c040a:	41 54                	push   %r12
  2c040c:	53                   	push   %rbx
  2c040d:	49 89 f8             	mov    %rdi,%r8
  2c0410:	49 89 f1             	mov    %rsi,%r9
  2c0413:	41 89 ca             	mov    %ecx,%r10d
    // select the rightmost element as pivot
    long pivot = sizeArray[high];
  2c0416:	48 63 c9             	movslq %ecx,%rcx
  2c0419:	4c 8d 1c cd 00 00 00 	lea    0x0(,%rcx,8),%r11
  2c0420:	00 
  2c0421:	4a 8d 1c 1f          	lea    (%rdi,%r11,1),%rbx
  2c0425:	4c 8b 23             	mov    (%rbx),%r12
    // index of smaller element
    int i = low - 1;
  2c0428:	8d 42 ff             	lea    -0x1(%rdx),%eax
    // traverse each element of the array and compare them with the pivot
    for (int j = low; j < high; j++) 
  2c042b:	41 39 d2             	cmp    %edx,%r10d
  2c042e:	7e 42                	jle    2c0472 <partition+0x6e>
  2c0430:	48 63 d2             	movslq %edx,%rdx
  2c0433:	eb 09                	jmp    2c043e <partition+0x3a>
  2c0435:	48 83 c2 01          	add    $0x1,%rdx
  2c0439:	41 39 d2             	cmp    %edx,%r10d
  2c043c:	7e 34                	jle    2c0472 <partition+0x6e>
    {
        if (sizeArray[j] > pivot) 
  2c043e:	49 8b 34 d0          	mov    (%r8,%rdx,8),%rsi
  2c0442:	4c 39 e6             	cmp    %r12,%rsi
  2c0445:	7e ee                	jle    2c0435 <partition+0x31>
        {
            i++; //if element smaller than pivot is found swap it with the greater element pointed by i
  2c0447:	83 c0 01             	add    $0x1,%eax
            swapSize(&sizeArray[i], &sizeArray[j]); // swap element at i with element at j
  2c044a:	48 63 c8             	movslq %eax,%rcx
  2c044d:	48 c1 e1 03          	shl    $0x3,%rcx
  2c0451:	49 8d 3c 08          	lea    (%r8,%rcx,1),%rdi
  long temp = *a;
  2c0455:	4c 8b 2f             	mov    (%rdi),%r13
  *a = *b;
  2c0458:	48 89 37             	mov    %rsi,(%rdi)
  *b = temp;
  2c045b:	4d 89 2c d0          	mov    %r13,(%r8,%rdx,8)
            swapPtr(&ptrArray[i], &ptrArray[j]); // do the same but now with ptr array
  2c045f:	4c 01 c9             	add    %r9,%rcx
  void *temp = *a;
  2c0462:	48 8b 31             	mov    (%rcx),%rsi
  *a = *b;
  2c0465:	49 8b 3c d1          	mov    (%r9,%rdx,8),%rdi
  2c0469:	48 89 39             	mov    %rdi,(%rcx)
  *b = temp;
  2c046c:	49 89 34 d1          	mov    %rsi,(%r9,%rdx,8)
}
  2c0470:	eb c3                	jmp    2c0435 <partition+0x31>
        }
    }
    swapSize(&sizeArray[i+1], &sizeArray[high]); //swap the pivot element with the greater element at i
  2c0472:	48 63 d0             	movslq %eax,%rdx
  2c0475:	48 8d 34 d5 08 00 00 	lea    0x8(,%rdx,8),%rsi
  2c047c:	00 
  2c047d:	49 8d 14 30          	lea    (%r8,%rsi,1),%rdx
  long temp = *a;
  2c0481:	48 8b 0a             	mov    (%rdx),%rcx
  *a = *b;
  2c0484:	48 8b 3b             	mov    (%rbx),%rdi
  2c0487:	48 89 3a             	mov    %rdi,(%rdx)
  *b = temp;
  2c048a:	48 89 0b             	mov    %rcx,(%rbx)
    swapPtr(&ptrArray[i+1], &ptrArray[high]); //do the same ordering with with pointer array
  2c048d:	4b 8d 0c 19          	lea    (%r9,%r11,1),%rcx
  2c0491:	49 8d 14 31          	lea    (%r9,%rsi,1),%rdx
  void *temp = *a;
  2c0495:	48 8b 32             	mov    (%rdx),%rsi
  *a = *b;
  2c0498:	48 8b 39             	mov    (%rcx),%rdi
  2c049b:	48 89 3a             	mov    %rdi,(%rdx)
  *b = temp;
  2c049e:	48 89 31             	mov    %rsi,(%rcx)
    
    return (i + 1); // return the partition point
  2c04a1:	83 c0 01             	add    $0x1,%eax
}
  2c04a4:	5b                   	pop    %rbx
  2c04a5:	41 5c                	pop    %r12
  2c04a7:	41 5d                	pop    %r13
  2c04a9:	5d                   	pop    %rbp
  2c04aa:	c3                   	ret    

00000000002c04ab <quickSort>:

//this will sort both size and ptr array because we have 2 swap functions we can call
//we will order the ptr array in the same order of the size array by using size array pivot points and mirroring that to ptr array
void quickSort(long *sizeArray, void **ptrArray, int low, int high) 
{
  if (low < high) 
  2c04ab:	39 ca                	cmp    %ecx,%edx
  2c04ad:	7c 01                	jl     2c04b0 <quickSort+0x5>
  2c04af:	c3                   	ret    
{
  2c04b0:	55                   	push   %rbp
  2c04b1:	48 89 e5             	mov    %rsp,%rbp
  2c04b4:	41 57                	push   %r15
  2c04b6:	41 56                	push   %r14
  2c04b8:	41 55                	push   %r13
  2c04ba:	41 54                	push   %r12
  2c04bc:	53                   	push   %rbx
  2c04bd:	48 83 ec 08          	sub    $0x8,%rsp
  2c04c1:	49 89 fd             	mov    %rdi,%r13
  2c04c4:	49 89 f6             	mov    %rsi,%r14
  2c04c7:	41 89 d4             	mov    %edx,%r12d
  2c04ca:	89 cb                	mov    %ecx,%ebx
  {
    // find the pivot element such that elements smaller than pivot are on left of pivot elements greater than pivot are on right of pivot
    int pi = partition(sizeArray, ptrArray, low, high);
  2c04cc:	e8 33 ff ff ff       	call   2c0404 <partition>
  2c04d1:	41 89 c7             	mov    %eax,%r15d
    
    // recursive call on the left of pivot
    quickSort(sizeArray, ptrArray, low, pi - 1);
  2c04d4:	8d 48 ff             	lea    -0x1(%rax),%ecx
  2c04d7:	44 89 e2             	mov    %r12d,%edx
  2c04da:	4c 89 f6             	mov    %r14,%rsi
  2c04dd:	4c 89 ef             	mov    %r13,%rdi
  2c04e0:	e8 c6 ff ff ff       	call   2c04ab <quickSort>
    
    // recursive call on the right of pivot
    quickSort(sizeArray, ptrArray, pi + 1, high);
  2c04e5:	41 8d 57 01          	lea    0x1(%r15),%edx
  2c04e9:	89 d9                	mov    %ebx,%ecx
  2c04eb:	4c 89 f6             	mov    %r14,%rsi
  2c04ee:	4c 89 ef             	mov    %r13,%rdi
  2c04f1:	e8 b5 ff ff ff       	call   2c04ab <quickSort>
  }
}
  2c04f6:	48 83 c4 08          	add    $0x8,%rsp
  2c04fa:	5b                   	pop    %rbx
  2c04fb:	41 5c                	pop    %r12
  2c04fd:	41 5d                	pop    %r13
  2c04ff:	41 5e                	pop    %r14
  2c0501:	41 5f                	pop    %r15
  2c0503:	5d                   	pop    %rbp
  2c0504:	c3                   	ret    

00000000002c0505 <malloc>:

//===========================================//
//begin malloc functions
//===========================================//
void *malloc(uint64_t numbytes) {
  2c0505:	55                   	push   %rbp
  2c0506:	48 89 e5             	mov    %rsp,%rbp
  2c0509:	53                   	push   %rbx
  2c050a:	48 83 ec 08          	sub    $0x8,%rsp
  2c050e:	48 89 f8             	mov    %rdi,%rax
    uint64_t alignedbytes = ALIGN_8(numbytes + HEADER_SIZE);
  2c0511:	48 8d 7f 27          	lea    0x27(%rdi),%rdi
  2c0515:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
    bh *curr = head;
  2c0519:	48 8b 1d e8 1a 00 00 	mov    0x1ae8(%rip),%rbx        # 2c2008 <head>

    //out of bounds
    if ((numbytes == 0) || ((numbytes + (uint64_t)HEADER_SIZE) > UINTMAX))
  2c0520:	48 85 c0             	test   %rax,%rax
  2c0523:	74 7c                	je     2c05a1 <malloc+0x9c>
        return NULL;

    //traverse linked list
    while (curr != NULL)
  2c0525:	48 85 db             	test   %rbx,%rbx
  2c0528:	75 4b                	jne    2c0575 <malloc+0x70>
        }
        curr = curr->next;
    }

    //else, curr == NULL means we are at end of heap, sbrk more mem for header, insert node at end
    curr = addToHeap(alignedbytes);
  2c052a:	e8 ed fd ff ff       	call   2c031c <addToHeap>
    if (curr == NULL) return NULL;
  2c052f:	48 85 c0             	test   %rax,%rax
  2c0532:	74 28                	je     2c055c <malloc+0x57>
    //first iteration of malloc
    if (head == NULL){
  2c0534:	48 83 3d cc 1a 00 00 	cmpq   $0x0,0x1acc(%rip)        # 2c2008 <head>
  2c053b:	00 
  2c053c:	74 5a                	je     2c0598 <malloc+0x93>
        head = curr;
        end = curr;
    }
    //end pointer is used to link the new node at end to previous one, end is set to last non null node
    else{ 
        end->next = curr;
  2c053e:	48 8b 15 bb 1a 00 00 	mov    0x1abb(%rip),%rdx        # 2c2000 <end>
  2c0545:	48 89 42 10          	mov    %rax,0x10(%rdx)
        end = curr;
  2c0549:	48 89 05 b0 1a 00 00 	mov    %rax,0x1ab0(%rip)        # 2c2000 <end>
        end = curr;
    }

    curr->next = NULL;  
  2c0550:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  2c0557:	00 

    return curr->block_payload; 
  2c0558:	48 8b 40 18          	mov    0x18(%rax),%rax
}
  2c055c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0560:	c9                   	leave  
  2c0561:	c3                   	ret    
                splitBlock(alignedbytes, curr);
  2c0562:	48 89 de             	mov    %rbx,%rsi
  2c0565:	e8 e9 fd ff ff       	call   2c0353 <splitBlock>
  2c056a:	eb 26                	jmp    2c0592 <malloc+0x8d>
        curr = curr->next;
  2c056c:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    while (curr != NULL)
  2c0570:	48 85 db             	test   %rbx,%rbx
  2c0573:	74 b5                	je     2c052a <malloc+0x25>
        if ((curr->allocated == 0) && (curr->size >= alignedbytes))
  2c0575:	83 3b 00             	cmpl   $0x0,(%rbx)
  2c0578:	75 f2                	jne    2c056c <malloc+0x67>
  2c057a:	48 8b 43 08          	mov    0x8(%rbx),%rax
  2c057e:	48 39 f8             	cmp    %rdi,%rax
  2c0581:	72 e9                	jb     2c056c <malloc+0x67>
            curr->allocated = 1; //set to allocated 
  2c0583:	c7 03 01 00 00 00    	movl   $0x1,(%rbx)
            if (HEADER_SIZE <= (curr->size - alignedbytes)) //if there's left over room after inserting header and payload, then split current block into 2
  2c0589:	48 29 f8             	sub    %rdi,%rax
  2c058c:	48 83 f8 1f          	cmp    $0x1f,%rax
  2c0590:	77 d0                	ja     2c0562 <malloc+0x5d>
            return curr->block_payload; 
  2c0592:	48 8b 43 18          	mov    0x18(%rbx),%rax
  2c0596:	eb c4                	jmp    2c055c <malloc+0x57>
        head = curr;
  2c0598:	48 89 05 69 1a 00 00 	mov    %rax,0x1a69(%rip)        # 2c2008 <head>
        end = curr;
  2c059f:	eb a8                	jmp    2c0549 <malloc+0x44>
        return NULL;
  2c05a1:	b8 00 00 00 00       	mov    $0x0,%eax
  2c05a6:	eb b4                	jmp    2c055c <malloc+0x57>

00000000002c05a8 <calloc>:

void * calloc(uint64_t num, uint64_t sz) {
  2c05a8:	55                   	push   %rbp
  2c05a9:	48 89 e5             	mov    %rsp,%rbp
  2c05ac:	41 54                	push   %r12
  2c05ae:	53                   	push   %rbx
    //out of bounds
    if (num == 0 || sz == 0)
  2c05af:	48 85 ff             	test   %rdi,%rdi
  2c05b2:	74 40                	je     2c05f4 <calloc+0x4c>
  2c05b4:	48 85 f6             	test   %rsi,%rsi
  2c05b7:	74 3b                	je     2c05f4 <calloc+0x4c>
        return NULL;
    
    //out of bounds
    uint64_t size = num*sz;
  2c05b9:	48 89 fb             	mov    %rdi,%rbx
  2c05bc:	48 0f af de          	imul   %rsi,%rbx
    if (size > (UINTMAX - HEADER_SIZE))
        return NULL;
  2c05c0:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if (size > (UINTMAX - HEADER_SIZE))
  2c05c6:	48 83 fb df          	cmp    $0xffffffffffffffdf,%rbx
  2c05ca:	77 20                	ja     2c05ec <calloc+0x44>

    void *array = malloc(size);
  2c05cc:	48 89 df             	mov    %rbx,%rdi
  2c05cf:	e8 31 ff ff ff       	call   2c0505 <malloc>
  2c05d4:	49 89 c4             	mov    %rax,%r12
    if (array != NULL)
  2c05d7:	48 85 c0             	test   %rax,%rax
  2c05da:	74 10                	je     2c05ec <calloc+0x44>
        memset(array, 0, size);
  2c05dc:	48 89 da             	mov    %rbx,%rdx
  2c05df:	be 00 00 00 00       	mov    $0x0,%esi
  2c05e4:	48 89 c7             	mov    %rax,%rdi
  2c05e7:	e8 b9 02 00 00       	call   2c08a5 <memset>
    return array;
}
  2c05ec:	4c 89 e0             	mov    %r12,%rax
  2c05ef:	5b                   	pop    %rbx
  2c05f0:	41 5c                	pop    %r12
  2c05f2:	5d                   	pop    %rbp
  2c05f3:	c3                   	ret    
        return NULL;
  2c05f4:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c05fa:	eb f0                	jmp    2c05ec <calloc+0x44>

00000000002c05fc <free>:

void free(void *firstbyte) {
    if (firstbyte == NULL) 
  2c05fc:	48 85 ff             	test   %rdi,%rdi
  2c05ff:	74 07                	je     2c0608 <free+0xc>
        return;
    //given a block payload, move back to header struct
    bh* curr = GET_HEADER(firstbyte);
    curr->allocated = 0;
  2c0601:	c7 47 e0 00 00 00 00 	movl   $0x0,-0x20(%rdi)
    return;
}
  2c0608:	c3                   	ret    

00000000002c0609 <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  2c0609:	55                   	push   %rbp
  2c060a:	48 89 e5             	mov    %rsp,%rbp
  2c060d:	41 55                	push   %r13
  2c060f:	41 54                	push   %r12
  2c0611:	53                   	push   %rbx
  2c0612:	48 83 ec 08          	sub    $0x8,%rsp
    //out of bounds
    if (sz > (UINTMAX - HEADER_SIZE))
  2c0616:	48 83 fe df          	cmp    $0xffffffffffffffdf,%rsi
  2c061a:	77 55                	ja     2c0671 <realloc+0x68>
  2c061c:	49 89 fc             	mov    %rdi,%r12
  2c061f:	48 89 f3             	mov    %rsi,%rbx
        return NULL;
     // if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
    if (ptr == NULL)
  2c0622:	48 85 ff             	test   %rdi,%rdi
  2c0625:	74 39                	je     2c0660 <realloc+0x57>
        malloc(sz);
    // if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr) 
    //unless ptr is NULL, it must have been returned by an earlier call to malloc(), or realloc().
    if (sz == 0 && ptr != NULL)
  2c0627:	48 85 f6             	test   %rsi,%rsi
  2c062a:	74 3e                	je     2c066a <realloc+0x61>
        free(ptr);
    
    // if the area pointed to was moved, a free(ptr) is done.
    void *re = malloc(sz);
  2c062c:	48 89 df             	mov    %rbx,%rdi
  2c062f:	e8 d1 fe ff ff       	call   2c0505 <malloc>
  2c0634:	49 89 c5             	mov    %rax,%r13
    if (re != NULL)
  2c0637:	48 85 c0             	test   %rax,%rax
  2c063a:	74 16                	je     2c0652 <realloc+0x49>
    {
         memcpy(re, ptr, sz);
  2c063c:	48 89 da             	mov    %rbx,%rdx
  2c063f:	4c 89 e6             	mov    %r12,%rsi
  2c0642:	48 89 c7             	mov    %rax,%rdi
  2c0645:	e8 5d 01 00 00       	call   2c07a7 <memcpy>
         free(ptr);
  2c064a:	4c 89 e7             	mov    %r12,%rdi
  2c064d:	e8 aa ff ff ff       	call   2c05fc <free>
    }
       
    return re;
}
  2c0652:	4c 89 e8             	mov    %r13,%rax
  2c0655:	48 83 c4 08          	add    $0x8,%rsp
  2c0659:	5b                   	pop    %rbx
  2c065a:	41 5c                	pop    %r12
  2c065c:	41 5d                	pop    %r13
  2c065e:	5d                   	pop    %rbp
  2c065f:	c3                   	ret    
        malloc(sz);
  2c0660:	48 89 f7             	mov    %rsi,%rdi
  2c0663:	e8 9d fe ff ff       	call   2c0505 <malloc>
    if (sz == 0 && ptr != NULL)
  2c0668:	eb c2                	jmp    2c062c <realloc+0x23>
        free(ptr);
  2c066a:	e8 8d ff ff ff       	call   2c05fc <free>
  2c066f:	eb bb                	jmp    2c062c <realloc+0x23>
        return NULL;
  2c0671:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  2c0677:	eb d9                	jmp    2c0652 <realloc+0x49>

00000000002c0679 <defrag>:

//just loop through list and combine adjacent free blocks and update the size of the first one
void defrag() {
    bh *curr = head; 
  2c0679:	48 8b 15 88 19 00 00 	mov    0x1988(%rip),%rdx        # 2c2008 <head>
    while(curr != NULL && curr->next != NULL)
  2c0680:	48 85 d2             	test   %rdx,%rdx
  2c0683:	75 04                	jne    2c0689 <defrag+0x10>
  2c0685:	c3                   	ret    
    {
        if (curr->allocated == 0 && curr->next->allocated == 0)
        {
            curr->size = curr->size + curr->next->size;
            curr->next = curr->next->next;
  2c0686:	48 89 c2             	mov    %rax,%rdx
    while(curr != NULL && curr->next != NULL)
  2c0689:	48 8b 42 10          	mov    0x10(%rdx),%rax
  2c068d:	48 85 c0             	test   %rax,%rax
  2c0690:	74 1f                	je     2c06b1 <defrag+0x38>
        if (curr->allocated == 0 && curr->next->allocated == 0)
  2c0692:	83 3a 00             	cmpl   $0x0,(%rdx)
  2c0695:	75 ef                	jne    2c0686 <defrag+0xd>
  2c0697:	83 38 00             	cmpl   $0x0,(%rax)
  2c069a:	75 ea                	jne    2c0686 <defrag+0xd>
            curr->size = curr->size + curr->next->size;
  2c069c:	48 8b 48 08          	mov    0x8(%rax),%rcx
  2c06a0:	48 01 4a 08          	add    %rcx,0x8(%rdx)
            curr->next = curr->next->next;
  2c06a4:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c06a8:	48 89 42 10          	mov    %rax,0x10(%rdx)
  2c06ac:	48 89 d0             	mov    %rdx,%rax
  2c06af:	eb d5                	jmp    2c0686 <defrag+0xd>
        }
        else
            curr = curr->next;
    }
}
  2c06b1:	c3                   	ret    

00000000002c06b2 <heap_info>:

int heap_info(heap_info_struct * info) {
  2c06b2:	55                   	push   %rbp
  2c06b3:	48 89 e5             	mov    %rsp,%rbp
  2c06b6:	41 56                	push   %r14
  2c06b8:	41 55                	push   %r13
  2c06ba:	41 54                	push   %r12
  2c06bc:	53                   	push   %rbx
  2c06bd:	48 89 fb             	mov    %rdi,%rbx
    void **ptrArray = NULL; //pointer to an array of pointers of each allocation
    long *sizeArray = NULL; //pointer to an array of size of each allocation

    //===========================================//
    setFreeAndAlloc(info); //sets num_allocs, free_space, and largest_free_chunk
  2c06c0:	e8 ca fc ff ff       	call   2c038f <setFreeAndAlloc>
    if (info->num_allocs == 0) //if no size, just set arrays in struct to NULL
  2c06c5:	8b 03                	mov    (%rbx),%eax
  2c06c7:	85 c0                	test   %eax,%eax
  2c06c9:	75 19                	jne    2c06e4 <heap_info+0x32>
    {
        info->size_array = sizeArray;
  2c06cb:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  2c06d2:	00 
        info->ptr_array = ptrArray;
  2c06d3:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  2c06da:	00 
    info->size_array = sizeArray;
    info->ptr_array = ptrArray;
    //===========================================//

    return 0;
}
  2c06db:	5b                   	pop    %rbx
  2c06dc:	41 5c                	pop    %r12
  2c06de:	41 5d                	pop    %r13
  2c06e0:	41 5e                	pop    %r14
  2c06e2:	5d                   	pop    %rbp
  2c06e3:	c3                   	ret    
    uint64_t sizeLong = (uint64_t)info->num_allocs * sizeof(long); 
  2c06e4:	48 98                	cltq   
  2c06e6:	4c 8d 24 c5 00 00 00 	lea    0x0(,%rax,8),%r12
  2c06ed:	00 
    sizeArray = malloc(sizeLong);
  2c06ee:	4c 89 e7             	mov    %r12,%rdi
  2c06f1:	e8 0f fe ff ff       	call   2c0505 <malloc>
  2c06f6:	49 89 c5             	mov    %rax,%r13
    ptrArray = malloc(sizeUint);
  2c06f9:	4c 89 e7             	mov    %r12,%rdi
  2c06fc:	e8 04 fe ff ff       	call   2c0505 <malloc>
  2c0701:	49 89 c4             	mov    %rax,%r12
    if (sizeArray == NULL || ptrArray == NULL)
  2c0704:	4d 85 ed             	test   %r13,%r13
  2c0707:	74 18                	je     2c0721 <heap_info+0x6f>
  2c0709:	48 85 c0             	test   %rax,%rax
  2c070c:	74 13                	je     2c0721 <heap_info+0x6f>
    bh *curr = head; int i = 0;
  2c070e:	48 8b 05 f3 18 00 00 	mov    0x18f3(%rip),%rax        # 2c2008 <head>
    while(curr != NULL)
  2c0715:	48 85 c0             	test   %rax,%rax
  2c0718:	74 66                	je     2c0780 <heap_info+0xce>
    bh *curr = head; int i = 0;
  2c071a:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c071f:	eb 3d                	jmp    2c075e <heap_info+0xac>
        for (int j = 0; j < info->num_allocs; j++)
  2c0721:	83 3b 00             	cmpl   $0x0,(%rbx)
  2c0724:	7e 18                	jle    2c073e <heap_info+0x8c>
  2c0726:	41 be 00 00 00 00    	mov    $0x0,%r14d
            free(ptrArray[j]);
  2c072c:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
  2c0730:	e8 c7 fe ff ff       	call   2c05fc <free>
        for (int j = 0; j < info->num_allocs; j++)
  2c0735:	49 83 c6 01          	add    $0x1,%r14
  2c0739:	44 39 33             	cmp    %r14d,(%rbx)
  2c073c:	7f ee                	jg     2c072c <heap_info+0x7a>
        free(sizeArray);
  2c073e:	4c 89 ef             	mov    %r13,%rdi
  2c0741:	e8 b6 fe ff ff       	call   2c05fc <free>
        free(ptrArray);
  2c0746:	4c 89 e7             	mov    %r12,%rdi
  2c0749:	e8 ae fe ff ff       	call   2c05fc <free>
        return -1;
  2c074e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0753:	eb 86                	jmp    2c06db <heap_info+0x29>
        curr = curr->next;
  2c0755:	48 8b 40 10          	mov    0x10(%rax),%rax
    while(curr != NULL)
  2c0759:	48 85 c0             	test   %rax,%rax
  2c075c:	74 22                	je     2c0780 <heap_info+0xce>
        if (curr->allocated == 1) //load in allocated chunks
  2c075e:	83 38 01             	cmpl   $0x1,(%rax)
  2c0761:	75 f2                	jne    2c0755 <heap_info+0xa3>
            sizeArray[i] = curr->size - HEADER_SIZE; //gets size of allocated requested from malloc i.e. payload
  2c0763:	48 63 f1             	movslq %ecx,%rsi
  2c0766:	48 8b 78 08          	mov    0x8(%rax),%rdi
  2c076a:	48 8d 57 e0          	lea    -0x20(%rdi),%rdx
  2c076e:	49 89 54 f5 00       	mov    %rdx,0x0(%r13,%rsi,8)
            ptrArray[i] = curr->block_payload; //pointer to payload allocations
  2c0773:	48 8b 50 18          	mov    0x18(%rax),%rdx
  2c0777:	49 89 14 f4          	mov    %rdx,(%r12,%rsi,8)
            i++;
  2c077b:	83 c1 01             	add    $0x1,%ecx
  2c077e:	eb d5                	jmp    2c0755 <heap_info+0xa3>
    quickSort(sizeArray, ptrArray, 0, info->num_allocs-1);
  2c0780:	8b 03                	mov    (%rbx),%eax
  2c0782:	8d 48 ff             	lea    -0x1(%rax),%ecx
  2c0785:	ba 00 00 00 00       	mov    $0x0,%edx
  2c078a:	4c 89 e6             	mov    %r12,%rsi
  2c078d:	4c 89 ef             	mov    %r13,%rdi
  2c0790:	e8 16 fd ff ff       	call   2c04ab <quickSort>
    info->size_array = sizeArray;
  2c0795:	4c 89 6b 08          	mov    %r13,0x8(%rbx)
    info->ptr_array = ptrArray;
  2c0799:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    return 0;
  2c079d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c07a2:	e9 34 ff ff ff       	jmp    2c06db <heap_info+0x29>

00000000002c07a7 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c07a7:	55                   	push   %rbp
  2c07a8:	48 89 e5             	mov    %rsp,%rbp
  2c07ab:	48 83 ec 28          	sub    $0x28,%rsp
  2c07af:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c07b3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c07b7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c07bb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c07bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c07c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c07c7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c07cb:	eb 1c                	jmp    2c07e9 <memcpy+0x42>
        *d = *s;
  2c07cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07d1:	0f b6 10             	movzbl (%rax),%edx
  2c07d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c07d8:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c07da:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c07df:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c07e4:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c07e9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c07ee:	75 dd                	jne    2c07cd <memcpy+0x26>
    }
    return dst;
  2c07f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c07f4:	c9                   	leave  
  2c07f5:	c3                   	ret    

00000000002c07f6 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c07f6:	55                   	push   %rbp
  2c07f7:	48 89 e5             	mov    %rsp,%rbp
  2c07fa:	48 83 ec 28          	sub    $0x28,%rsp
  2c07fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0802:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0806:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c080a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c080e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0812:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0816:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c081a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c081e:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0822:	73 6a                	jae    2c088e <memmove+0x98>
  2c0824:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0828:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c082c:	48 01 d0             	add    %rdx,%rax
  2c082f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0833:	73 59                	jae    2c088e <memmove+0x98>
        s += n, d += n;
  2c0835:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0839:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c083d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0841:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0845:	eb 17                	jmp    2c085e <memmove+0x68>
            *--d = *--s;
  2c0847:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c084c:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0851:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0855:	0f b6 10             	movzbl (%rax),%edx
  2c0858:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c085c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c085e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0862:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0866:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c086a:	48 85 c0             	test   %rax,%rax
  2c086d:	75 d8                	jne    2c0847 <memmove+0x51>
    if (s < d && s + n > d) {
  2c086f:	eb 2e                	jmp    2c089f <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0871:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0875:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0879:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c087d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0881:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0885:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0889:	0f b6 12             	movzbl (%rdx),%edx
  2c088c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c088e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0892:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0896:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c089a:	48 85 c0             	test   %rax,%rax
  2c089d:	75 d2                	jne    2c0871 <memmove+0x7b>
        }
    }
    return dst;
  2c089f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c08a3:	c9                   	leave  
  2c08a4:	c3                   	ret    

00000000002c08a5 <memset>:

void* memset(void* v, int c, size_t n) {
  2c08a5:	55                   	push   %rbp
  2c08a6:	48 89 e5             	mov    %rsp,%rbp
  2c08a9:	48 83 ec 28          	sub    $0x28,%rsp
  2c08ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c08b1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c08b4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c08b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c08bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c08c0:	eb 15                	jmp    2c08d7 <memset+0x32>
        *p = c;
  2c08c2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c08c5:	89 c2                	mov    %eax,%edx
  2c08c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08cb:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c08cd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c08d2:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c08d7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c08dc:	75 e4                	jne    2c08c2 <memset+0x1d>
    }
    return v;
  2c08de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c08e2:	c9                   	leave  
  2c08e3:	c3                   	ret    

00000000002c08e4 <strlen>:

size_t strlen(const char* s) {
  2c08e4:	55                   	push   %rbp
  2c08e5:	48 89 e5             	mov    %rsp,%rbp
  2c08e8:	48 83 ec 18          	sub    $0x18,%rsp
  2c08ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c08f0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c08f7:	00 
  2c08f8:	eb 0a                	jmp    2c0904 <strlen+0x20>
        ++n;
  2c08fa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c08ff:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0904:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0908:	0f b6 00             	movzbl (%rax),%eax
  2c090b:	84 c0                	test   %al,%al
  2c090d:	75 eb                	jne    2c08fa <strlen+0x16>
    }
    return n;
  2c090f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0913:	c9                   	leave  
  2c0914:	c3                   	ret    

00000000002c0915 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0915:	55                   	push   %rbp
  2c0916:	48 89 e5             	mov    %rsp,%rbp
  2c0919:	48 83 ec 20          	sub    $0x20,%rsp
  2c091d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0921:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0925:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c092c:	00 
  2c092d:	eb 0a                	jmp    2c0939 <strnlen+0x24>
        ++n;
  2c092f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0934:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0939:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c093d:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0941:	74 0b                	je     2c094e <strnlen+0x39>
  2c0943:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0947:	0f b6 00             	movzbl (%rax),%eax
  2c094a:	84 c0                	test   %al,%al
  2c094c:	75 e1                	jne    2c092f <strnlen+0x1a>
    }
    return n;
  2c094e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0952:	c9                   	leave  
  2c0953:	c3                   	ret    

00000000002c0954 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0954:	55                   	push   %rbp
  2c0955:	48 89 e5             	mov    %rsp,%rbp
  2c0958:	48 83 ec 20          	sub    $0x20,%rsp
  2c095c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0960:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0964:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0968:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c096c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0970:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0974:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0978:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c097c:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0980:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0984:	0f b6 12             	movzbl (%rdx),%edx
  2c0987:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0989:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c098d:	48 83 e8 01          	sub    $0x1,%rax
  2c0991:	0f b6 00             	movzbl (%rax),%eax
  2c0994:	84 c0                	test   %al,%al
  2c0996:	75 d4                	jne    2c096c <strcpy+0x18>
    return dst;
  2c0998:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c099c:	c9                   	leave  
  2c099d:	c3                   	ret    

00000000002c099e <strcmp>:

int strcmp(const char* a, const char* b) {
  2c099e:	55                   	push   %rbp
  2c099f:	48 89 e5             	mov    %rsp,%rbp
  2c09a2:	48 83 ec 10          	sub    $0x10,%rsp
  2c09a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c09aa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c09ae:	eb 0a                	jmp    2c09ba <strcmp+0x1c>
        ++a, ++b;
  2c09b0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c09b5:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c09ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09be:	0f b6 00             	movzbl (%rax),%eax
  2c09c1:	84 c0                	test   %al,%al
  2c09c3:	74 1d                	je     2c09e2 <strcmp+0x44>
  2c09c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c09c9:	0f b6 00             	movzbl (%rax),%eax
  2c09cc:	84 c0                	test   %al,%al
  2c09ce:	74 12                	je     2c09e2 <strcmp+0x44>
  2c09d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09d4:	0f b6 10             	movzbl (%rax),%edx
  2c09d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c09db:	0f b6 00             	movzbl (%rax),%eax
  2c09de:	38 c2                	cmp    %al,%dl
  2c09e0:	74 ce                	je     2c09b0 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c09e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09e6:	0f b6 00             	movzbl (%rax),%eax
  2c09e9:	89 c2                	mov    %eax,%edx
  2c09eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c09ef:	0f b6 00             	movzbl (%rax),%eax
  2c09f2:	38 d0                	cmp    %dl,%al
  2c09f4:	0f 92 c0             	setb   %al
  2c09f7:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c09fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09fe:	0f b6 00             	movzbl (%rax),%eax
  2c0a01:	89 c1                	mov    %eax,%ecx
  2c0a03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0a07:	0f b6 00             	movzbl (%rax),%eax
  2c0a0a:	38 c1                	cmp    %al,%cl
  2c0a0c:	0f 92 c0             	setb   %al
  2c0a0f:	0f b6 c0             	movzbl %al,%eax
  2c0a12:	29 c2                	sub    %eax,%edx
  2c0a14:	89 d0                	mov    %edx,%eax
}
  2c0a16:	c9                   	leave  
  2c0a17:	c3                   	ret    

00000000002c0a18 <strchr>:

char* strchr(const char* s, int c) {
  2c0a18:	55                   	push   %rbp
  2c0a19:	48 89 e5             	mov    %rsp,%rbp
  2c0a1c:	48 83 ec 10          	sub    $0x10,%rsp
  2c0a20:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0a24:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0a27:	eb 05                	jmp    2c0a2e <strchr+0x16>
        ++s;
  2c0a29:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0a2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a32:	0f b6 00             	movzbl (%rax),%eax
  2c0a35:	84 c0                	test   %al,%al
  2c0a37:	74 0e                	je     2c0a47 <strchr+0x2f>
  2c0a39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a3d:	0f b6 00             	movzbl (%rax),%eax
  2c0a40:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0a43:	38 d0                	cmp    %dl,%al
  2c0a45:	75 e2                	jne    2c0a29 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c0a47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a4b:	0f b6 00             	movzbl (%rax),%eax
  2c0a4e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0a51:	38 d0                	cmp    %dl,%al
  2c0a53:	75 06                	jne    2c0a5b <strchr+0x43>
        return (char*) s;
  2c0a55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a59:	eb 05                	jmp    2c0a60 <strchr+0x48>
    } else {
        return NULL;
  2c0a5b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0a60:	c9                   	leave  
  2c0a61:	c3                   	ret    

00000000002c0a62 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0a62:	55                   	push   %rbp
  2c0a63:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0a66:	8b 05 ac 15 00 00    	mov    0x15ac(%rip),%eax        # 2c2018 <rand_seed_set>
  2c0a6c:	85 c0                	test   %eax,%eax
  2c0a6e:	75 0a                	jne    2c0a7a <rand+0x18>
        srand(819234718U);
  2c0a70:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0a75:	e8 24 00 00 00       	call   2c0a9e <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0a7a:	8b 05 9c 15 00 00    	mov    0x159c(%rip),%eax        # 2c201c <rand_seed>
  2c0a80:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0a86:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0a8b:	89 05 8b 15 00 00    	mov    %eax,0x158b(%rip)        # 2c201c <rand_seed>
    return rand_seed & RAND_MAX;
  2c0a91:	8b 05 85 15 00 00    	mov    0x1585(%rip),%eax        # 2c201c <rand_seed>
  2c0a97:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0a9c:	5d                   	pop    %rbp
  2c0a9d:	c3                   	ret    

00000000002c0a9e <srand>:

void srand(unsigned seed) {
  2c0a9e:	55                   	push   %rbp
  2c0a9f:	48 89 e5             	mov    %rsp,%rbp
  2c0aa2:	48 83 ec 08          	sub    $0x8,%rsp
  2c0aa6:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0aa9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0aac:	89 05 6a 15 00 00    	mov    %eax,0x156a(%rip)        # 2c201c <rand_seed>
    rand_seed_set = 1;
  2c0ab2:	c7 05 5c 15 00 00 01 	movl   $0x1,0x155c(%rip)        # 2c2018 <rand_seed_set>
  2c0ab9:	00 00 00 
}
  2c0abc:	90                   	nop
  2c0abd:	c9                   	leave  
  2c0abe:	c3                   	ret    

00000000002c0abf <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0abf:	55                   	push   %rbp
  2c0ac0:	48 89 e5             	mov    %rsp,%rbp
  2c0ac3:	48 83 ec 28          	sub    $0x28,%rsp
  2c0ac7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0acb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0acf:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0ad2:	48 c7 45 f8 d0 1a 2c 	movq   $0x2c1ad0,-0x8(%rbp)
  2c0ad9:	00 
    if (base < 0) {
  2c0ada:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0ade:	79 0b                	jns    2c0aeb <fill_numbuf+0x2c>
        digits = lower_digits;
  2c0ae0:	48 c7 45 f8 f0 1a 2c 	movq   $0x2c1af0,-0x8(%rbp)
  2c0ae7:	00 
        base = -base;
  2c0ae8:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0aeb:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0af0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0af4:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0af7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0afa:	48 63 c8             	movslq %eax,%rcx
  2c0afd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0b01:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0b06:	48 f7 f1             	div    %rcx
  2c0b09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b0d:	48 01 d0             	add    %rdx,%rax
  2c0b10:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0b15:	0f b6 10             	movzbl (%rax),%edx
  2c0b18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0b1c:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0b1e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0b21:	48 63 f0             	movslq %eax,%rsi
  2c0b24:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0b28:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0b2d:	48 f7 f6             	div    %rsi
  2c0b30:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0b34:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0b39:	75 bc                	jne    2c0af7 <fill_numbuf+0x38>
    return numbuf_end;
  2c0b3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0b3f:	c9                   	leave  
  2c0b40:	c3                   	ret    

00000000002c0b41 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0b41:	55                   	push   %rbp
  2c0b42:	48 89 e5             	mov    %rsp,%rbp
  2c0b45:	53                   	push   %rbx
  2c0b46:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0b4d:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0b54:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0b5a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0b61:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0b68:	e9 8a 09 00 00       	jmp    2c14f7 <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0b6d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b74:	0f b6 00             	movzbl (%rax),%eax
  2c0b77:	3c 25                	cmp    $0x25,%al
  2c0b79:	74 31                	je     2c0bac <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0b7b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0b82:	4c 8b 00             	mov    (%rax),%r8
  2c0b85:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b8c:	0f b6 00             	movzbl (%rax),%eax
  2c0b8f:	0f b6 c8             	movzbl %al,%ecx
  2c0b92:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0b98:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0b9f:	89 ce                	mov    %ecx,%esi
  2c0ba1:	48 89 c7             	mov    %rax,%rdi
  2c0ba4:	41 ff d0             	call   *%r8
            continue;
  2c0ba7:	e9 43 09 00 00       	jmp    2c14ef <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0bac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0bb3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0bba:	01 
  2c0bbb:	eb 44                	jmp    2c0c01 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0bbd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0bc4:	0f b6 00             	movzbl (%rax),%eax
  2c0bc7:	0f be c0             	movsbl %al,%eax
  2c0bca:	89 c6                	mov    %eax,%esi
  2c0bcc:	bf f0 18 2c 00       	mov    $0x2c18f0,%edi
  2c0bd1:	e8 42 fe ff ff       	call   2c0a18 <strchr>
  2c0bd6:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0bda:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0bdf:	74 30                	je     2c0c11 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0be1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0be5:	48 2d f0 18 2c 00    	sub    $0x2c18f0,%rax
  2c0beb:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0bf0:	89 c1                	mov    %eax,%ecx
  2c0bf2:	d3 e2                	shl    %cl,%edx
  2c0bf4:	89 d0                	mov    %edx,%eax
  2c0bf6:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0bf9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0c00:	01 
  2c0c01:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c08:	0f b6 00             	movzbl (%rax),%eax
  2c0c0b:	84 c0                	test   %al,%al
  2c0c0d:	75 ae                	jne    2c0bbd <printer_vprintf+0x7c>
  2c0c0f:	eb 01                	jmp    2c0c12 <printer_vprintf+0xd1>
            } else {
                break;
  2c0c11:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0c12:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0c19:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c20:	0f b6 00             	movzbl (%rax),%eax
  2c0c23:	3c 30                	cmp    $0x30,%al
  2c0c25:	7e 67                	jle    2c0c8e <printer_vprintf+0x14d>
  2c0c27:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c2e:	0f b6 00             	movzbl (%rax),%eax
  2c0c31:	3c 39                	cmp    $0x39,%al
  2c0c33:	7f 59                	jg     2c0c8e <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0c35:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0c3c:	eb 2e                	jmp    2c0c6c <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0c3e:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0c41:	89 d0                	mov    %edx,%eax
  2c0c43:	c1 e0 02             	shl    $0x2,%eax
  2c0c46:	01 d0                	add    %edx,%eax
  2c0c48:	01 c0                	add    %eax,%eax
  2c0c4a:	89 c1                	mov    %eax,%ecx
  2c0c4c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c53:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0c57:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0c5e:	0f b6 00             	movzbl (%rax),%eax
  2c0c61:	0f be c0             	movsbl %al,%eax
  2c0c64:	01 c8                	add    %ecx,%eax
  2c0c66:	83 e8 30             	sub    $0x30,%eax
  2c0c69:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0c6c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c73:	0f b6 00             	movzbl (%rax),%eax
  2c0c76:	3c 2f                	cmp    $0x2f,%al
  2c0c78:	0f 8e 85 00 00 00    	jle    2c0d03 <printer_vprintf+0x1c2>
  2c0c7e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c85:	0f b6 00             	movzbl (%rax),%eax
  2c0c88:	3c 39                	cmp    $0x39,%al
  2c0c8a:	7e b2                	jle    2c0c3e <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0c8c:	eb 75                	jmp    2c0d03 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0c8e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c95:	0f b6 00             	movzbl (%rax),%eax
  2c0c98:	3c 2a                	cmp    $0x2a,%al
  2c0c9a:	75 68                	jne    2c0d04 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0c9c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ca3:	8b 00                	mov    (%rax),%eax
  2c0ca5:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ca8:	77 30                	ja     2c0cda <printer_vprintf+0x199>
  2c0caa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cb1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0cb5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cbc:	8b 00                	mov    (%rax),%eax
  2c0cbe:	89 c0                	mov    %eax,%eax
  2c0cc0:	48 01 d0             	add    %rdx,%rax
  2c0cc3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cca:	8b 12                	mov    (%rdx),%edx
  2c0ccc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ccf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cd6:	89 0a                	mov    %ecx,(%rdx)
  2c0cd8:	eb 1a                	jmp    2c0cf4 <printer_vprintf+0x1b3>
  2c0cda:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ce1:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ce5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ce9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cf0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0cf4:	8b 00                	mov    (%rax),%eax
  2c0cf6:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0cf9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0d00:	01 
  2c0d01:	eb 01                	jmp    2c0d04 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0d03:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0d04:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0d0b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d12:	0f b6 00             	movzbl (%rax),%eax
  2c0d15:	3c 2e                	cmp    $0x2e,%al
  2c0d17:	0f 85 00 01 00 00    	jne    2c0e1d <printer_vprintf+0x2dc>
            ++format;
  2c0d1d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0d24:	01 
            if (*format >= '0' && *format <= '9') {
  2c0d25:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d2c:	0f b6 00             	movzbl (%rax),%eax
  2c0d2f:	3c 2f                	cmp    $0x2f,%al
  2c0d31:	7e 67                	jle    2c0d9a <printer_vprintf+0x259>
  2c0d33:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d3a:	0f b6 00             	movzbl (%rax),%eax
  2c0d3d:	3c 39                	cmp    $0x39,%al
  2c0d3f:	7f 59                	jg     2c0d9a <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0d41:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0d48:	eb 2e                	jmp    2c0d78 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0d4a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0d4d:	89 d0                	mov    %edx,%eax
  2c0d4f:	c1 e0 02             	shl    $0x2,%eax
  2c0d52:	01 d0                	add    %edx,%eax
  2c0d54:	01 c0                	add    %eax,%eax
  2c0d56:	89 c1                	mov    %eax,%ecx
  2c0d58:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d5f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0d63:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0d6a:	0f b6 00             	movzbl (%rax),%eax
  2c0d6d:	0f be c0             	movsbl %al,%eax
  2c0d70:	01 c8                	add    %ecx,%eax
  2c0d72:	83 e8 30             	sub    $0x30,%eax
  2c0d75:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0d78:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d7f:	0f b6 00             	movzbl (%rax),%eax
  2c0d82:	3c 2f                	cmp    $0x2f,%al
  2c0d84:	0f 8e 85 00 00 00    	jle    2c0e0f <printer_vprintf+0x2ce>
  2c0d8a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d91:	0f b6 00             	movzbl (%rax),%eax
  2c0d94:	3c 39                	cmp    $0x39,%al
  2c0d96:	7e b2                	jle    2c0d4a <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0d98:	eb 75                	jmp    2c0e0f <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0d9a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0da1:	0f b6 00             	movzbl (%rax),%eax
  2c0da4:	3c 2a                	cmp    $0x2a,%al
  2c0da6:	75 68                	jne    2c0e10 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0da8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0daf:	8b 00                	mov    (%rax),%eax
  2c0db1:	83 f8 2f             	cmp    $0x2f,%eax
  2c0db4:	77 30                	ja     2c0de6 <printer_vprintf+0x2a5>
  2c0db6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dbd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0dc1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dc8:	8b 00                	mov    (%rax),%eax
  2c0dca:	89 c0                	mov    %eax,%eax
  2c0dcc:	48 01 d0             	add    %rdx,%rax
  2c0dcf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dd6:	8b 12                	mov    (%rdx),%edx
  2c0dd8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ddb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0de2:	89 0a                	mov    %ecx,(%rdx)
  2c0de4:	eb 1a                	jmp    2c0e00 <printer_vprintf+0x2bf>
  2c0de6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ded:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0df1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0df5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dfc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e00:	8b 00                	mov    (%rax),%eax
  2c0e02:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0e05:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e0c:	01 
  2c0e0d:	eb 01                	jmp    2c0e10 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c0e0f:	90                   	nop
            }
            if (precision < 0) {
  2c0e10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0e14:	79 07                	jns    2c0e1d <printer_vprintf+0x2dc>
                precision = 0;
  2c0e16:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0e1d:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0e24:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0e2b:	00 
        int length = 0;
  2c0e2c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0e33:	48 c7 45 c8 f6 18 2c 	movq   $0x2c18f6,-0x38(%rbp)
  2c0e3a:	00 
    again:
        switch (*format) {
  2c0e3b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e42:	0f b6 00             	movzbl (%rax),%eax
  2c0e45:	0f be c0             	movsbl %al,%eax
  2c0e48:	83 e8 43             	sub    $0x43,%eax
  2c0e4b:	83 f8 37             	cmp    $0x37,%eax
  2c0e4e:	0f 87 9f 03 00 00    	ja     2c11f3 <printer_vprintf+0x6b2>
  2c0e54:	89 c0                	mov    %eax,%eax
  2c0e56:	48 8b 04 c5 08 19 2c 	mov    0x2c1908(,%rax,8),%rax
  2c0e5d:	00 
  2c0e5e:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0e60:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0e67:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e6e:	01 
            goto again;
  2c0e6f:	eb ca                	jmp    2c0e3b <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0e71:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0e75:	74 5d                	je     2c0ed4 <printer_vprintf+0x393>
  2c0e77:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e7e:	8b 00                	mov    (%rax),%eax
  2c0e80:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e83:	77 30                	ja     2c0eb5 <printer_vprintf+0x374>
  2c0e85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e8c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e90:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e97:	8b 00                	mov    (%rax),%eax
  2c0e99:	89 c0                	mov    %eax,%eax
  2c0e9b:	48 01 d0             	add    %rdx,%rax
  2c0e9e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ea5:	8b 12                	mov    (%rdx),%edx
  2c0ea7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0eaa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0eb1:	89 0a                	mov    %ecx,(%rdx)
  2c0eb3:	eb 1a                	jmp    2c0ecf <printer_vprintf+0x38e>
  2c0eb5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ebc:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ec0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ec4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ecb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ecf:	48 8b 00             	mov    (%rax),%rax
  2c0ed2:	eb 5c                	jmp    2c0f30 <printer_vprintf+0x3ef>
  2c0ed4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0edb:	8b 00                	mov    (%rax),%eax
  2c0edd:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ee0:	77 30                	ja     2c0f12 <printer_vprintf+0x3d1>
  2c0ee2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ee9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0eed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ef4:	8b 00                	mov    (%rax),%eax
  2c0ef6:	89 c0                	mov    %eax,%eax
  2c0ef8:	48 01 d0             	add    %rdx,%rax
  2c0efb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f02:	8b 12                	mov    (%rdx),%edx
  2c0f04:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f0e:	89 0a                	mov    %ecx,(%rdx)
  2c0f10:	eb 1a                	jmp    2c0f2c <printer_vprintf+0x3eb>
  2c0f12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f19:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f1d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f28:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f2c:	8b 00                	mov    (%rax),%eax
  2c0f2e:	48 98                	cltq   
  2c0f30:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0f34:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0f38:	48 c1 f8 38          	sar    $0x38,%rax
  2c0f3c:	25 80 00 00 00       	and    $0x80,%eax
  2c0f41:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0f44:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0f48:	74 09                	je     2c0f53 <printer_vprintf+0x412>
  2c0f4a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0f4e:	48 f7 d8             	neg    %rax
  2c0f51:	eb 04                	jmp    2c0f57 <printer_vprintf+0x416>
  2c0f53:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0f57:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0f5b:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0f5e:	83 c8 60             	or     $0x60,%eax
  2c0f61:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0f64:	e9 cf 02 00 00       	jmp    2c1238 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0f69:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0f6d:	74 5d                	je     2c0fcc <printer_vprintf+0x48b>
  2c0f6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f76:	8b 00                	mov    (%rax),%eax
  2c0f78:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f7b:	77 30                	ja     2c0fad <printer_vprintf+0x46c>
  2c0f7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f84:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f88:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f8f:	8b 00                	mov    (%rax),%eax
  2c0f91:	89 c0                	mov    %eax,%eax
  2c0f93:	48 01 d0             	add    %rdx,%rax
  2c0f96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f9d:	8b 12                	mov    (%rdx),%edx
  2c0f9f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0fa2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fa9:	89 0a                	mov    %ecx,(%rdx)
  2c0fab:	eb 1a                	jmp    2c0fc7 <printer_vprintf+0x486>
  2c0fad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fb4:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0fb8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0fbc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fc3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0fc7:	48 8b 00             	mov    (%rax),%rax
  2c0fca:	eb 5c                	jmp    2c1028 <printer_vprintf+0x4e7>
  2c0fcc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fd3:	8b 00                	mov    (%rax),%eax
  2c0fd5:	83 f8 2f             	cmp    $0x2f,%eax
  2c0fd8:	77 30                	ja     2c100a <printer_vprintf+0x4c9>
  2c0fda:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fe1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0fe5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fec:	8b 00                	mov    (%rax),%eax
  2c0fee:	89 c0                	mov    %eax,%eax
  2c0ff0:	48 01 d0             	add    %rdx,%rax
  2c0ff3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ffa:	8b 12                	mov    (%rdx),%edx
  2c0ffc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0fff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1006:	89 0a                	mov    %ecx,(%rdx)
  2c1008:	eb 1a                	jmp    2c1024 <printer_vprintf+0x4e3>
  2c100a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1011:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1015:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1019:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1020:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1024:	8b 00                	mov    (%rax),%eax
  2c1026:	89 c0                	mov    %eax,%eax
  2c1028:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c102c:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c1030:	e9 03 02 00 00       	jmp    2c1238 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c1035:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c103c:	e9 28 ff ff ff       	jmp    2c0f69 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c1041:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c1048:	e9 1c ff ff ff       	jmp    2c0f69 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c104d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1054:	8b 00                	mov    (%rax),%eax
  2c1056:	83 f8 2f             	cmp    $0x2f,%eax
  2c1059:	77 30                	ja     2c108b <printer_vprintf+0x54a>
  2c105b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1062:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1066:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c106d:	8b 00                	mov    (%rax),%eax
  2c106f:	89 c0                	mov    %eax,%eax
  2c1071:	48 01 d0             	add    %rdx,%rax
  2c1074:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c107b:	8b 12                	mov    (%rdx),%edx
  2c107d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1080:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1087:	89 0a                	mov    %ecx,(%rdx)
  2c1089:	eb 1a                	jmp    2c10a5 <printer_vprintf+0x564>
  2c108b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1092:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1096:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c109a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10a1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c10a5:	48 8b 00             	mov    (%rax),%rax
  2c10a8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c10ac:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c10b3:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c10ba:	e9 79 01 00 00       	jmp    2c1238 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c10bf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10c6:	8b 00                	mov    (%rax),%eax
  2c10c8:	83 f8 2f             	cmp    $0x2f,%eax
  2c10cb:	77 30                	ja     2c10fd <printer_vprintf+0x5bc>
  2c10cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10d4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c10d8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10df:	8b 00                	mov    (%rax),%eax
  2c10e1:	89 c0                	mov    %eax,%eax
  2c10e3:	48 01 d0             	add    %rdx,%rax
  2c10e6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10ed:	8b 12                	mov    (%rdx),%edx
  2c10ef:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c10f2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10f9:	89 0a                	mov    %ecx,(%rdx)
  2c10fb:	eb 1a                	jmp    2c1117 <printer_vprintf+0x5d6>
  2c10fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1104:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1108:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c110c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1113:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1117:	48 8b 00             	mov    (%rax),%rax
  2c111a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c111e:	e9 15 01 00 00       	jmp    2c1238 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c1123:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c112a:	8b 00                	mov    (%rax),%eax
  2c112c:	83 f8 2f             	cmp    $0x2f,%eax
  2c112f:	77 30                	ja     2c1161 <printer_vprintf+0x620>
  2c1131:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1138:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c113c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1143:	8b 00                	mov    (%rax),%eax
  2c1145:	89 c0                	mov    %eax,%eax
  2c1147:	48 01 d0             	add    %rdx,%rax
  2c114a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1151:	8b 12                	mov    (%rdx),%edx
  2c1153:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1156:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c115d:	89 0a                	mov    %ecx,(%rdx)
  2c115f:	eb 1a                	jmp    2c117b <printer_vprintf+0x63a>
  2c1161:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1168:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c116c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1170:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1177:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c117b:	8b 00                	mov    (%rax),%eax
  2c117d:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c1183:	e9 67 03 00 00       	jmp    2c14ef <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c1188:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c118c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c1190:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1197:	8b 00                	mov    (%rax),%eax
  2c1199:	83 f8 2f             	cmp    $0x2f,%eax
  2c119c:	77 30                	ja     2c11ce <printer_vprintf+0x68d>
  2c119e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11a5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c11a9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11b0:	8b 00                	mov    (%rax),%eax
  2c11b2:	89 c0                	mov    %eax,%eax
  2c11b4:	48 01 d0             	add    %rdx,%rax
  2c11b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11be:	8b 12                	mov    (%rdx),%edx
  2c11c0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c11c3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11ca:	89 0a                	mov    %ecx,(%rdx)
  2c11cc:	eb 1a                	jmp    2c11e8 <printer_vprintf+0x6a7>
  2c11ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11d5:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c11d9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c11dd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11e4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c11e8:	8b 00                	mov    (%rax),%eax
  2c11ea:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c11ed:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c11f1:	eb 45                	jmp    2c1238 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c11f3:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c11f7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c11fb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1202:	0f b6 00             	movzbl (%rax),%eax
  2c1205:	84 c0                	test   %al,%al
  2c1207:	74 0c                	je     2c1215 <printer_vprintf+0x6d4>
  2c1209:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1210:	0f b6 00             	movzbl (%rax),%eax
  2c1213:	eb 05                	jmp    2c121a <printer_vprintf+0x6d9>
  2c1215:	b8 25 00 00 00       	mov    $0x25,%eax
  2c121a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c121d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c1221:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1228:	0f b6 00             	movzbl (%rax),%eax
  2c122b:	84 c0                	test   %al,%al
  2c122d:	75 08                	jne    2c1237 <printer_vprintf+0x6f6>
                format--;
  2c122f:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c1236:	01 
            }
            break;
  2c1237:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c1238:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c123b:	83 e0 20             	and    $0x20,%eax
  2c123e:	85 c0                	test   %eax,%eax
  2c1240:	74 1e                	je     2c1260 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c1242:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1246:	48 83 c0 18          	add    $0x18,%rax
  2c124a:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c124d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1251:	48 89 ce             	mov    %rcx,%rsi
  2c1254:	48 89 c7             	mov    %rax,%rdi
  2c1257:	e8 63 f8 ff ff       	call   2c0abf <fill_numbuf>
  2c125c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c1260:	48 c7 45 c0 f6 18 2c 	movq   $0x2c18f6,-0x40(%rbp)
  2c1267:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c1268:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c126b:	83 e0 20             	and    $0x20,%eax
  2c126e:	85 c0                	test   %eax,%eax
  2c1270:	74 48                	je     2c12ba <printer_vprintf+0x779>
  2c1272:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1275:	83 e0 40             	and    $0x40,%eax
  2c1278:	85 c0                	test   %eax,%eax
  2c127a:	74 3e                	je     2c12ba <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c127c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c127f:	25 80 00 00 00       	and    $0x80,%eax
  2c1284:	85 c0                	test   %eax,%eax
  2c1286:	74 0a                	je     2c1292 <printer_vprintf+0x751>
                prefix = "-";
  2c1288:	48 c7 45 c0 f7 18 2c 	movq   $0x2c18f7,-0x40(%rbp)
  2c128f:	00 
            if (flags & FLAG_NEGATIVE) {
  2c1290:	eb 73                	jmp    2c1305 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c1292:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1295:	83 e0 10             	and    $0x10,%eax
  2c1298:	85 c0                	test   %eax,%eax
  2c129a:	74 0a                	je     2c12a6 <printer_vprintf+0x765>
                prefix = "+";
  2c129c:	48 c7 45 c0 f9 18 2c 	movq   $0x2c18f9,-0x40(%rbp)
  2c12a3:	00 
            if (flags & FLAG_NEGATIVE) {
  2c12a4:	eb 5f                	jmp    2c1305 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c12a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c12a9:	83 e0 08             	and    $0x8,%eax
  2c12ac:	85 c0                	test   %eax,%eax
  2c12ae:	74 55                	je     2c1305 <printer_vprintf+0x7c4>
                prefix = " ";
  2c12b0:	48 c7 45 c0 fb 18 2c 	movq   $0x2c18fb,-0x40(%rbp)
  2c12b7:	00 
            if (flags & FLAG_NEGATIVE) {
  2c12b8:	eb 4b                	jmp    2c1305 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c12ba:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c12bd:	83 e0 20             	and    $0x20,%eax
  2c12c0:	85 c0                	test   %eax,%eax
  2c12c2:	74 42                	je     2c1306 <printer_vprintf+0x7c5>
  2c12c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c12c7:	83 e0 01             	and    $0x1,%eax
  2c12ca:	85 c0                	test   %eax,%eax
  2c12cc:	74 38                	je     2c1306 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c12ce:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c12d2:	74 06                	je     2c12da <printer_vprintf+0x799>
  2c12d4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c12d8:	75 2c                	jne    2c1306 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c12da:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c12df:	75 0c                	jne    2c12ed <printer_vprintf+0x7ac>
  2c12e1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c12e4:	25 00 01 00 00       	and    $0x100,%eax
  2c12e9:	85 c0                	test   %eax,%eax
  2c12eb:	74 19                	je     2c1306 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c12ed:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c12f1:	75 07                	jne    2c12fa <printer_vprintf+0x7b9>
  2c12f3:	b8 fd 18 2c 00       	mov    $0x2c18fd,%eax
  2c12f8:	eb 05                	jmp    2c12ff <printer_vprintf+0x7be>
  2c12fa:	b8 00 19 2c 00       	mov    $0x2c1900,%eax
  2c12ff:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1303:	eb 01                	jmp    2c1306 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c1305:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c1306:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c130a:	78 24                	js     2c1330 <printer_vprintf+0x7ef>
  2c130c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c130f:	83 e0 20             	and    $0x20,%eax
  2c1312:	85 c0                	test   %eax,%eax
  2c1314:	75 1a                	jne    2c1330 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c1316:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1319:	48 63 d0             	movslq %eax,%rdx
  2c131c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1320:	48 89 d6             	mov    %rdx,%rsi
  2c1323:	48 89 c7             	mov    %rax,%rdi
  2c1326:	e8 ea f5 ff ff       	call   2c0915 <strnlen>
  2c132b:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c132e:	eb 0f                	jmp    2c133f <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c1330:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1334:	48 89 c7             	mov    %rax,%rdi
  2c1337:	e8 a8 f5 ff ff       	call   2c08e4 <strlen>
  2c133c:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c133f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1342:	83 e0 20             	and    $0x20,%eax
  2c1345:	85 c0                	test   %eax,%eax
  2c1347:	74 20                	je     2c1369 <printer_vprintf+0x828>
  2c1349:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c134d:	78 1a                	js     2c1369 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c134f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1352:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c1355:	7e 08                	jle    2c135f <printer_vprintf+0x81e>
  2c1357:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c135a:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c135d:	eb 05                	jmp    2c1364 <printer_vprintf+0x823>
  2c135f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c1364:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1367:	eb 5c                	jmp    2c13c5 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1369:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c136c:	83 e0 20             	and    $0x20,%eax
  2c136f:	85 c0                	test   %eax,%eax
  2c1371:	74 4b                	je     2c13be <printer_vprintf+0x87d>
  2c1373:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1376:	83 e0 02             	and    $0x2,%eax
  2c1379:	85 c0                	test   %eax,%eax
  2c137b:	74 41                	je     2c13be <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c137d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1380:	83 e0 04             	and    $0x4,%eax
  2c1383:	85 c0                	test   %eax,%eax
  2c1385:	75 37                	jne    2c13be <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c1387:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c138b:	48 89 c7             	mov    %rax,%rdi
  2c138e:	e8 51 f5 ff ff       	call   2c08e4 <strlen>
  2c1393:	89 c2                	mov    %eax,%edx
  2c1395:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c1398:	01 d0                	add    %edx,%eax
  2c139a:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c139d:	7e 1f                	jle    2c13be <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c139f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c13a2:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c13a5:	89 c3                	mov    %eax,%ebx
  2c13a7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c13ab:	48 89 c7             	mov    %rax,%rdi
  2c13ae:	e8 31 f5 ff ff       	call   2c08e4 <strlen>
  2c13b3:	89 c2                	mov    %eax,%edx
  2c13b5:	89 d8                	mov    %ebx,%eax
  2c13b7:	29 d0                	sub    %edx,%eax
  2c13b9:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c13bc:	eb 07                	jmp    2c13c5 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c13be:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c13c5:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c13c8:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c13cb:	01 d0                	add    %edx,%eax
  2c13cd:	48 63 d8             	movslq %eax,%rbx
  2c13d0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c13d4:	48 89 c7             	mov    %rax,%rdi
  2c13d7:	e8 08 f5 ff ff       	call   2c08e4 <strlen>
  2c13dc:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c13e0:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c13e3:	29 d0                	sub    %edx,%eax
  2c13e5:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c13e8:	eb 25                	jmp    2c140f <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c13ea:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13f1:	48 8b 08             	mov    (%rax),%rcx
  2c13f4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c13fa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1401:	be 20 00 00 00       	mov    $0x20,%esi
  2c1406:	48 89 c7             	mov    %rax,%rdi
  2c1409:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c140b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c140f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1412:	83 e0 04             	and    $0x4,%eax
  2c1415:	85 c0                	test   %eax,%eax
  2c1417:	75 36                	jne    2c144f <printer_vprintf+0x90e>
  2c1419:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c141d:	7f cb                	jg     2c13ea <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c141f:	eb 2e                	jmp    2c144f <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c1421:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1428:	4c 8b 00             	mov    (%rax),%r8
  2c142b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c142f:	0f b6 00             	movzbl (%rax),%eax
  2c1432:	0f b6 c8             	movzbl %al,%ecx
  2c1435:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c143b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1442:	89 ce                	mov    %ecx,%esi
  2c1444:	48 89 c7             	mov    %rax,%rdi
  2c1447:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c144a:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c144f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1453:	0f b6 00             	movzbl (%rax),%eax
  2c1456:	84 c0                	test   %al,%al
  2c1458:	75 c7                	jne    2c1421 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c145a:	eb 25                	jmp    2c1481 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c145c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1463:	48 8b 08             	mov    (%rax),%rcx
  2c1466:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c146c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1473:	be 30 00 00 00       	mov    $0x30,%esi
  2c1478:	48 89 c7             	mov    %rax,%rdi
  2c147b:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c147d:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c1481:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c1485:	7f d5                	jg     2c145c <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c1487:	eb 32                	jmp    2c14bb <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c1489:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1490:	4c 8b 00             	mov    (%rax),%r8
  2c1493:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1497:	0f b6 00             	movzbl (%rax),%eax
  2c149a:	0f b6 c8             	movzbl %al,%ecx
  2c149d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c14a3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c14aa:	89 ce                	mov    %ecx,%esi
  2c14ac:	48 89 c7             	mov    %rax,%rdi
  2c14af:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c14b2:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c14b7:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c14bb:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c14bf:	7f c8                	jg     2c1489 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c14c1:	eb 25                	jmp    2c14e8 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c14c3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c14ca:	48 8b 08             	mov    (%rax),%rcx
  2c14cd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c14d3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c14da:	be 20 00 00 00       	mov    $0x20,%esi
  2c14df:	48 89 c7             	mov    %rax,%rdi
  2c14e2:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c14e4:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c14e8:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c14ec:	7f d5                	jg     2c14c3 <printer_vprintf+0x982>
        }
    done: ;
  2c14ee:	90                   	nop
    for (; *format; ++format) {
  2c14ef:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c14f6:	01 
  2c14f7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c14fe:	0f b6 00             	movzbl (%rax),%eax
  2c1501:	84 c0                	test   %al,%al
  2c1503:	0f 85 64 f6 ff ff    	jne    2c0b6d <printer_vprintf+0x2c>
    }
}
  2c1509:	90                   	nop
  2c150a:	90                   	nop
  2c150b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c150f:	c9                   	leave  
  2c1510:	c3                   	ret    

00000000002c1511 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1511:	55                   	push   %rbp
  2c1512:	48 89 e5             	mov    %rsp,%rbp
  2c1515:	48 83 ec 20          	sub    $0x20,%rsp
  2c1519:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c151d:	89 f0                	mov    %esi,%eax
  2c151f:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1522:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1525:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1529:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c152d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1531:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1535:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c153a:	48 39 d0             	cmp    %rdx,%rax
  2c153d:	72 0c                	jb     2c154b <console_putc+0x3a>
        cp->cursor = console;
  2c153f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1543:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c154a:	00 
    }
    if (c == '\n') {
  2c154b:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c154f:	75 78                	jne    2c15c9 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c1551:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1555:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1559:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c155f:	48 d1 f8             	sar    %rax
  2c1562:	48 89 c1             	mov    %rax,%rcx
  2c1565:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c156c:	66 66 66 
  2c156f:	48 89 c8             	mov    %rcx,%rax
  2c1572:	48 f7 ea             	imul   %rdx
  2c1575:	48 c1 fa 05          	sar    $0x5,%rdx
  2c1579:	48 89 c8             	mov    %rcx,%rax
  2c157c:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c1580:	48 29 c2             	sub    %rax,%rdx
  2c1583:	48 89 d0             	mov    %rdx,%rax
  2c1586:	48 c1 e0 02          	shl    $0x2,%rax
  2c158a:	48 01 d0             	add    %rdx,%rax
  2c158d:	48 c1 e0 04          	shl    $0x4,%rax
  2c1591:	48 29 c1             	sub    %rax,%rcx
  2c1594:	48 89 ca             	mov    %rcx,%rdx
  2c1597:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c159a:	eb 25                	jmp    2c15c1 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c159c:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c159f:	83 c8 20             	or     $0x20,%eax
  2c15a2:	89 c6                	mov    %eax,%esi
  2c15a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c15a8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c15ac:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c15b0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c15b4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c15b8:	89 f2                	mov    %esi,%edx
  2c15ba:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c15bd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c15c1:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c15c5:	75 d5                	jne    2c159c <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c15c7:	eb 24                	jmp    2c15ed <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c15c9:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c15cd:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c15d0:	09 d0                	or     %edx,%eax
  2c15d2:	89 c6                	mov    %eax,%esi
  2c15d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c15d8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c15dc:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c15e0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c15e4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c15e8:	89 f2                	mov    %esi,%edx
  2c15ea:	66 89 10             	mov    %dx,(%rax)
}
  2c15ed:	90                   	nop
  2c15ee:	c9                   	leave  
  2c15ef:	c3                   	ret    

00000000002c15f0 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c15f0:	55                   	push   %rbp
  2c15f1:	48 89 e5             	mov    %rsp,%rbp
  2c15f4:	48 83 ec 30          	sub    $0x30,%rsp
  2c15f8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c15fb:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c15fe:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1602:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1606:	48 c7 45 f0 11 15 2c 	movq   $0x2c1511,-0x10(%rbp)
  2c160d:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c160e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1612:	78 09                	js     2c161d <console_vprintf+0x2d>
  2c1614:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c161b:	7e 07                	jle    2c1624 <console_vprintf+0x34>
        cpos = 0;
  2c161d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c1624:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1627:	48 98                	cltq   
  2c1629:	48 01 c0             	add    %rax,%rax
  2c162c:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c1632:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1636:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c163a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c163e:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c1641:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1645:	48 89 c7             	mov    %rax,%rdi
  2c1648:	e8 f4 f4 ff ff       	call   2c0b41 <printer_vprintf>
    return cp.cursor - console;
  2c164d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1651:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1657:	48 d1 f8             	sar    %rax
}
  2c165a:	c9                   	leave  
  2c165b:	c3                   	ret    

00000000002c165c <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c165c:	55                   	push   %rbp
  2c165d:	48 89 e5             	mov    %rsp,%rbp
  2c1660:	48 83 ec 60          	sub    $0x60,%rsp
  2c1664:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c1667:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c166a:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c166e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1672:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1676:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c167a:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1681:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1685:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1689:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c168d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1691:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1695:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c1699:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c169c:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c169f:	89 c7                	mov    %eax,%edi
  2c16a1:	e8 4a ff ff ff       	call   2c15f0 <console_vprintf>
  2c16a6:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c16a9:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c16ac:	c9                   	leave  
  2c16ad:	c3                   	ret    

00000000002c16ae <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c16ae:	55                   	push   %rbp
  2c16af:	48 89 e5             	mov    %rsp,%rbp
  2c16b2:	48 83 ec 20          	sub    $0x20,%rsp
  2c16b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c16ba:	89 f0                	mov    %esi,%eax
  2c16bc:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c16bf:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c16c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c16c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c16ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c16ce:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c16d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c16d6:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c16da:	48 39 c2             	cmp    %rax,%rdx
  2c16dd:	73 1a                	jae    2c16f9 <string_putc+0x4b>
        *sp->s++ = c;
  2c16df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c16e3:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c16e7:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c16eb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c16ef:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c16f3:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c16f7:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c16f9:	90                   	nop
  2c16fa:	c9                   	leave  
  2c16fb:	c3                   	ret    

00000000002c16fc <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c16fc:	55                   	push   %rbp
  2c16fd:	48 89 e5             	mov    %rsp,%rbp
  2c1700:	48 83 ec 40          	sub    $0x40,%rsp
  2c1704:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1708:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c170c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1710:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1714:	48 c7 45 e8 ae 16 2c 	movq   $0x2c16ae,-0x18(%rbp)
  2c171b:	00 
    sp.s = s;
  2c171c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1720:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1724:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1729:	74 33                	je     2c175e <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c172b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c172f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1733:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1737:	48 01 d0             	add    %rdx,%rax
  2c173a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c173e:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1742:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c1746:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c174a:	be 00 00 00 00       	mov    $0x0,%esi
  2c174f:	48 89 c7             	mov    %rax,%rdi
  2c1752:	e8 ea f3 ff ff       	call   2c0b41 <printer_vprintf>
        *sp.s = 0;
  2c1757:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c175b:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c175e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1762:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1766:	c9                   	leave  
  2c1767:	c3                   	ret    

00000000002c1768 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1768:	55                   	push   %rbp
  2c1769:	48 89 e5             	mov    %rsp,%rbp
  2c176c:	48 83 ec 70          	sub    $0x70,%rsp
  2c1770:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1774:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c1778:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c177c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1780:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1784:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1788:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c178f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1793:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c1797:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c179b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c179f:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c17a3:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c17a7:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c17ab:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c17af:	48 89 c7             	mov    %rax,%rdi
  2c17b2:	e8 45 ff ff ff       	call   2c16fc <vsnprintf>
  2c17b7:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c17ba:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c17bd:	c9                   	leave  
  2c17be:	c3                   	ret    

00000000002c17bf <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c17bf:	55                   	push   %rbp
  2c17c0:	48 89 e5             	mov    %rsp,%rbp
  2c17c3:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c17c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c17ce:	eb 13                	jmp    2c17e3 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c17d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c17d3:	48 98                	cltq   
  2c17d5:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c17dc:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c17df:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c17e3:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c17ea:	7e e4                	jle    2c17d0 <console_clear+0x11>
    }
    cursorpos = 0;
  2c17ec:	c7 05 06 78 df ff 00 	movl   $0x0,-0x2087fa(%rip)        # b8ffc <cursorpos>
  2c17f3:	00 00 00 
}
  2c17f6:	90                   	nop
  2c17f7:	c9                   	leave  
  2c17f8:	c3                   	ret    
