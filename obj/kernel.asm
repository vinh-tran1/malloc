
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	push   $0x0
        popfq
   4000c:	9d                   	popf   
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmp    40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	push   $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	push   $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	push   $0x0
        pushq $32
   40038:	6a 20                	push   $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	push   $0x0
        pushq $48
   4003e:	6a 30                	push   $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	push   $0x0
        pushq $49
   40044:	6a 31                	push   $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	push   $0x0
        pushq $50
   4004a:	6a 32                	push   $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	push   $0x0
        pushq $51
   40050:	6a 33                	push   $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	push   $0x0
        pushq $52
   40056:	6a 34                	push   $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	push   $0x0
        pushq $53
   4005c:	6a 35                	push   $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	push   $0x0
        pushq $54
   40062:	6a 36                	push   $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	push   $0x0
        pushq $55
   40068:	6a 37                	push   $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	push   $0x0
        pushq $56
   4006e:	6a 38                	push   $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	push   $0x0
        pushq $57
   40074:	6a 39                	push   $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	push   $0x0
        pushq $58
   4007a:	6a 3a                	push   $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	push   $0x0
        pushq $59
   40080:	6a 3b                	push   $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	push   $0x0
        pushq $60
   40086:	6a 3c                	push   $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	push   $0x0
        pushq $61
   4008c:	6a 3d                	push   $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	push   $0x0
        pushq $62
   40092:	6a 3e                	push   $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	push   $0x0
        pushq $63
   40098:	6a 3f                	push   $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	push   $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	push   %gs
        pushq %fs
   400a2:	0f a0                	push   %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 c9 06 00 00       	call   4078c <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	pop    %fs
        popq %gs
   400df:	0f a9                	pop    %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 4c 15 00 00       	call   416c4 <hardware_init>
    pageinfo_init();
   40178:	e8 c0 0b 00 00       	call   40d3d <pageinfo_init>
    console_clear();
   4017d:	e8 ea 4a 00 00       	call   44c6c <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 24 1a 00 00       	call   41bb0 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 e0 04 00       	mov    $0x4e000,%edi
   4019b:	e8 b2 3b 00 00       	call   43d52 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 00 e0 04 00 	lea    0x4e000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be e6 4c 04 00       	mov    $0x44ce6,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 40 3c 00 00       	call   43e4b <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 1);
   4020f:	be 01 00 00 00       	mov    $0x1,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 b8 00 00 00       	call   402d6 <process_setup>
   4021e:	e9 a9 00 00 00       	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 26                	je     40250 <kernel+0xe9>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be ed 4c 04 00       	mov    $0x44ced,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 10 3c 00 00       	call   43e4b <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 11                	jne    40250 <kernel+0xe9>
        process_setup(1, 2);
   4023f:	be 02 00 00 00       	mov    $0x2,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 88 00 00 00       	call   402d6 <process_setup>
   4024e:	eb 7c                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test") == 0){
   40250:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40255:	74 26                	je     4027d <kernel+0x116>
   40257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025b:	be f8 4c 04 00       	mov    $0x44cf8,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 e3 3b 00 00       	call   43e4b <strcmp>
   40268:	85 c0                	test   %eax,%eax
   4026a:	75 11                	jne    4027d <kernel+0x116>
        process_setup(1, 3);
   4026c:	be 03 00 00 00       	mov    $0x3,%esi
   40271:	bf 01 00 00 00       	mov    $0x1,%edi
   40276:	e8 5b 00 00 00       	call   402d6 <process_setup>
   4027b:	eb 4f                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test2") == 0) {
   4027d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40282:	74 39                	je     402bd <kernel+0x156>
   40284:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40288:	be fd 4c 04 00       	mov    $0x44cfd,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 b6 3b 00 00       	call   43e4b <strcmp>
   40295:	85 c0                	test   %eax,%eax
   40297:	75 24                	jne    402bd <kernel+0x156>
        for (pid_t i = 1; i <= 2; ++i) {
   40299:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a0:	eb 13                	jmp    402b5 <kernel+0x14e>
            process_setup(i, 3);
   402a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a5:	be 03 00 00 00       	mov    $0x3,%esi
   402aa:	89 c7                	mov    %eax,%edi
   402ac:	e8 25 00 00 00       	call   402d6 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b5:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402b9:	7e e7                	jle    402a2 <kernel+0x13b>
   402bb:	eb 0f                	jmp    402cc <kernel+0x165>
        }
    } else {
        process_setup(1, 0);
   402bd:	be 00 00 00 00       	mov    $0x0,%esi
   402c2:	bf 01 00 00 00       	mov    $0x1,%edi
   402c7:	e8 0a 00 00 00       	call   402d6 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402cc:	bf f0 e0 04 00       	mov    $0x4e0f0,%edi
   402d1:	e8 d6 09 00 00       	call   40cac <run>

00000000000402d6 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402d6:	55                   	push   %rbp
   402d7:	48 89 e5             	mov    %rsp,%rbp
   402da:	48 83 ec 10          	sub    $0x10,%rsp
   402de:	89 7d fc             	mov    %edi,-0x4(%rbp)
   402e1:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e7:	48 63 d0             	movslq %eax,%rdx
   402ea:	48 89 d0             	mov    %rdx,%rax
   402ed:	48 c1 e0 04          	shl    $0x4,%rax
   402f1:	48 29 d0             	sub    %rdx,%rax
   402f4:	48 c1 e0 04          	shl    $0x4,%rax
   402f8:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 36 1b 00 00       	call   41e41 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 06 32 00 00       	call   4351b <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba 08 4d 04 00       	mov    $0x44d08,%edx
   4031e:	be 7d 00 00 00       	mov    $0x7d,%esi
   40323:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40328:	e8 e2 22 00 00       	call   4260f <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 e0 04 00 	lea    0x4e000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 14 35 00 00       	call   43869 <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 38 4d 04 00       	mov    $0x44d38,%edx
   4035e:	be 80 00 00 00       	mov    $0x80,%esi
   40363:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40368:	e8 a2 22 00 00       	call   4260f <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 12 35 00 00       	call   438a1 <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   403a9:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   403af:	90                   	nop
   403b0:	c9                   	leave  
   403b1:	c3                   	ret    

00000000000403b2 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   403b2:	55                   	push   %rbp
   403b3:	48 89 e5             	mov    %rsp,%rbp
   403b6:	48 83 ec 10          	sub    $0x10,%rsp
   403ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   403be:	89 f0                	mov    %esi,%eax
   403c0:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   403c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   403cc:	48 85 c0             	test   %rax,%rax
   403cf:	75 20                	jne    403f1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   403d1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403d8:	00 
   403d9:	77 16                	ja     403f1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   403db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403df:	48 c1 e8 0c          	shr    $0xc,%rax
   403e3:	48 98                	cltq   
   403e5:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   403ec:	00 
   403ed:	84 c0                	test   %al,%al
   403ef:	74 07                	je     403f8 <assign_physical_page+0x46>
        return -1;
   403f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f6:	eb 2c                	jmp    40424 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40400:	48 98                	cltq   
   40402:	c6 84 00 21 ef 04 00 	movb   $0x1,0x4ef21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq   
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
        return 0;
   4041f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40424:	c9                   	leave  
   40425:	c3                   	ret    

0000000000040426 <syscall_fork>:

pid_t syscall_fork() {
   40426:	55                   	push   %rbp
   40427:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4042a:	48 8b 05 cf ea 00 00 	mov    0xeacf(%rip),%rax        # 4ef00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 1b 35 00 00       	call   43954 <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	ret    

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba ea 00 00 	mov    0xeaba(%rip),%rax        # 4ef00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 ea 2d 00 00       	call   43239 <process_free>
}
   4044f:	90                   	nop
   40450:	5d                   	pop    %rbp
   40451:	c3                   	ret    

0000000000040452 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   40452:	55                   	push   %rbp
   40453:	48 89 e5             	mov    %rsp,%rbp
   40456:	48 83 ec 10          	sub    $0x10,%rsp
   4045a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4045e:	48 8b 05 9b ea 00 00 	mov    0xea9b(%rip),%rax        # 4ef00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 72 37 00 00       	call   43be6 <process_page_alloc>
}
   40474:	c9                   	leave  
   40475:	c3                   	ret    

0000000000040476 <free_page>:

//--------------------MY HELPERS----------------------------//
//free all pages up to new brk address from sbrk and brk syscalls
void free_page(proc *p, uintptr_t brk_addr)
{
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 40          	sub    $0x40,%rsp
   4047e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   40482:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    uintptr_t virtual_addr = ROUNDUP(p->program_break, PAGESIZE);
   40486:	48 c7 45 f0 00 10 00 	movq   $0x1000,-0x10(%rbp)
   4048d:	00 
   4048e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40492:	48 8b 50 08          	mov    0x8(%rax),%rdx
   40496:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4049a:	48 01 d0             	add    %rdx,%rax
   4049d:	48 83 e8 01          	sub    $0x1,%rax
   404a1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   404a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404a9:	ba 00 00 00 00       	mov    $0x0,%edx
   404ae:	48 f7 75 f0          	divq   -0x10(%rbp)
   404b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404b6:	48 29 d0             	sub    %rdx,%rax
   404b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (virtual_addr; virtual_addr >= brk_addr; virtual_addr -= PAGESIZE)
   404bd:	e9 85 00 00 00       	jmp    40547 <free_page+0xd1>
    {
        vamapping vmap = virtual_memory_lookup(p->p_pagetable, virtual_addr);
   404c2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404c6:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   404cd:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   404d1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   404d5:	48 89 ce             	mov    %rcx,%rsi
   404d8:	48 89 c7             	mov    %rax,%rdi
   404db:	e8 f1 27 00 00       	call   42cd1 <virtual_memory_lookup>
        pageinfo[vmap.pn].refcount--;
   404e0:	8b 45 d0             	mov    -0x30(%rbp),%eax
   404e3:	48 63 d0             	movslq %eax,%rdx
   404e6:	0f b6 94 12 21 ef 04 	movzbl 0x4ef21(%rdx,%rdx,1),%edx
   404ed:	00 
   404ee:	83 ea 01             	sub    $0x1,%edx
   404f1:	48 98                	cltq   
   404f3:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
        if (pageinfo[vmap.pn].refcount == 0)
   404fa:	8b 45 d0             	mov    -0x30(%rbp),%eax
   404fd:	48 98                	cltq   
   404ff:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   40506:	00 
   40507:	84 c0                	test   %al,%al
   40509:	75 0d                	jne    40518 <free_page+0xa2>
            pageinfo[vmap.pn].owner = PO_FREE;
   4050b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4050e:	48 98                	cltq   
   40510:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   40517:	00 
        //unmaps the pages past the new break by mapping the PA to 0
        virtual_memory_map(p->p_pagetable, virtual_addr, 0, PAGESIZE, 0);     
   40518:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4051c:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40523:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40527:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   4052d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40532:	ba 00 00 00 00       	mov    $0x0,%edx
   40537:	48 89 c7             	mov    %rax,%rdi
   4053a:	e8 cf 23 00 00       	call   4290e <virtual_memory_map>
    for (virtual_addr; virtual_addr >= brk_addr; virtual_addr -= PAGESIZE)
   4053f:	48 81 6d f8 00 10 00 	subq   $0x1000,-0x8(%rbp)
   40546:	00 
   40547:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4054b:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   4054f:	0f 83 6d ff ff ff    	jae    404c2 <free_page+0x4c>
    }
}
   40555:	90                   	nop
   40556:	90                   	nop
   40557:	c9                   	leave  
   40558:	c3                   	ret    

0000000000040559 <brk>:

//takes in new brk address
int brk(proc *p, uintptr_t new_brk_addr)
{
   40559:	55                   	push   %rbp
   4055a:	48 89 e5             	mov    %rsp,%rbp
   4055d:	48 83 ec 10          	sub    $0x10,%rsp
   40561:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40565:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    //error checking out of bounds
    if ((new_brk_addr >= (MEMSIZE_VIRTUAL - PAGESIZE)) || new_brk_addr < p->original_break || !new_brk_addr)
   40569:	48 81 7d f0 ff ef 2f 	cmpq   $0x2fefff,-0x10(%rbp)
   40570:	00 
   40571:	77 15                	ja     40588 <brk+0x2f>
   40573:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40577:	48 8b 40 10          	mov    0x10(%rax),%rax
   4057b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4057f:	72 07                	jb     40588 <brk+0x2f>
   40581:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40586:	75 07                	jne    4058f <brk+0x36>
        return -1;
   40588:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4058d:	eb 32                	jmp    405c1 <brk+0x68>

    //decrement, deallocate to unmap for a negative move
    if (new_brk_addr < p->program_break)
   4058f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40593:	48 8b 40 08          	mov    0x8(%rax),%rax
   40597:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4059b:	73 13                	jae    405b0 <brk+0x57>
        free_page(p, new_brk_addr);   
   4059d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   405a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405a5:	48 89 d6             	mov    %rdx,%rsi
   405a8:	48 89 c7             	mov    %rax,%rdi
   405ab:	e8 c6 fe ff ff       	call   40476 <free_page>

    p->program_break = new_brk_addr; //set break to new address
   405b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405b4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   405b8:	48 89 50 08          	mov    %rdx,0x8(%rax)

    return 0;
   405bc:	b8 00 00 00 00       	mov    $0x0,%eax
}
   405c1:	c9                   	leave  
   405c2:	c3                   	ret    

00000000000405c3 <sbrk>:

//takes in increment in bytes
int sbrk(proc *p, intptr_t difference) {
   405c3:	55                   	push   %rbp
   405c4:	48 89 e5             	mov    %rsp,%rbp
   405c7:	48 83 ec 20          	sub    $0x20,%rsp
   405cb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   405cf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    // TODO : Your code here
    uintptr_t incr_addr = (uintptr_t)difference + p->program_break; //new address
   405d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405d7:	48 8b 50 08          	mov    0x8(%rax),%rdx
   405db:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   405df:	48 01 d0             	add    %rdx,%rax
   405e2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

    //error checking out of bounds
    if ((incr_addr >= (MEMSIZE_VIRTUAL - PAGESIZE)) || incr_addr < p->original_break || !incr_addr)
   405e6:	48 81 7d f8 ff ef 2f 	cmpq   $0x2fefff,-0x8(%rbp)
   405ed:	00 
   405ee:	77 15                	ja     40605 <sbrk+0x42>
   405f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405f4:	48 8b 40 10          	mov    0x10(%rax),%rax
   405f8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   405fc:	72 07                	jb     40605 <sbrk+0x42>
   405fe:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   40603:	75 07                	jne    4060c <sbrk+0x49>
        return -1;
   40605:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4060a:	eb 32                	jmp    4063e <sbrk+0x7b>

    //decrement, deallocate to unmap for a negative move
    if (incr_addr < p->program_break)
   4060c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40610:	48 8b 40 08          	mov    0x8(%rax),%rax
   40614:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40618:	73 13                	jae    4062d <sbrk+0x6a>
        free_page(p, incr_addr);
   4061a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4061e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40622:	48 89 d6             	mov    %rdx,%rsi
   40625:	48 89 c7             	mov    %rax,%rdi
   40628:	e8 49 fe ff ff       	call   40476 <free_page>

    p->program_break = incr_addr; //set break to new address
   4062d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40631:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40635:	48 89 50 08          	mov    %rdx,0x8(%rax)

    return 0;
   40639:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4063e:	c9                   	leave  
   4063f:	c3                   	ret    

0000000000040640 <syscall_mapping>:

//------------------END OF MY HELPERS-----------------------------//

void syscall_mapping(proc* p){
   40640:	55                   	push   %rbp
   40641:	48 89 e5             	mov    %rsp,%rbp
   40644:	48 83 ec 70          	sub    $0x70,%rsp
   40648:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4064c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40650:	48 8b 40 48          	mov    0x48(%rax),%rax
   40654:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40658:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4065c:	48 8b 40 40          	mov    0x40(%rax),%rax
   40660:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40664:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40668:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4066f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40673:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40677:	48 89 ce             	mov    %rcx,%rsi
   4067a:	48 89 c7             	mov    %rax,%rdi
   4067d:	e8 4f 26 00 00       	call   42cd1 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   40682:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40685:	48 98                	cltq   
   40687:	83 e0 06             	and    $0x6,%eax
   4068a:	48 83 f8 06          	cmp    $0x6,%rax
   4068e:	0f 85 89 00 00 00    	jne    4071d <syscall_mapping+0xdd>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   40694:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40698:	48 83 c0 17          	add    $0x17,%rax
   4069c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   406a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406a4:	48 c1 e8 0c          	shr    $0xc,%rax
   406a8:	89 c2                	mov    %eax,%edx
   406aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   406ae:	48 c1 e8 0c          	shr    $0xc,%rax
   406b2:	39 c2                	cmp    %eax,%edx
   406b4:	74 2c                	je     406e2 <syscall_mapping+0xa2>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   406b6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406ba:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406c1:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   406c5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   406c9:	48 89 ce             	mov    %rcx,%rsi
   406cc:	48 89 c7             	mov    %rax,%rdi
   406cf:	e8 fd 25 00 00       	call   42cd1 <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   406d4:	8b 45 b0             	mov    -0x50(%rbp),%eax
   406d7:	48 98                	cltq   
   406d9:	83 e0 03             	and    $0x3,%eax
   406dc:	48 83 f8 03          	cmp    $0x3,%rax
   406e0:	75 3e                	jne    40720 <syscall_mapping+0xe0>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   406e2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406e6:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406ed:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406f1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   406f5:	48 89 ce             	mov    %rcx,%rsi
   406f8:	48 89 c7             	mov    %rax,%rdi
   406fb:	e8 d1 25 00 00       	call   42cd1 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40700:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40704:	48 89 c1             	mov    %rax,%rcx
   40707:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4070b:	ba 18 00 00 00       	mov    $0x18,%edx
   40710:	48 89 c6             	mov    %rax,%rsi
   40713:	48 89 cf             	mov    %rcx,%rdi
   40716:	e8 39 35 00 00       	call   43c54 <memcpy>
   4071b:	eb 04                	jmp    40721 <syscall_mapping+0xe1>
        return;
   4071d:	90                   	nop
   4071e:	eb 01                	jmp    40721 <syscall_mapping+0xe1>
            return; 
   40720:	90                   	nop
}
   40721:	c9                   	leave  
   40722:	c3                   	ret    

0000000000040723 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40723:	55                   	push   %rbp
   40724:	48 89 e5             	mov    %rsp,%rbp
   40727:	48 83 ec 18          	sub    $0x18,%rsp
   4072b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   4072f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40733:	48 8b 40 48          	mov    0x48(%rax),%rax
   40737:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   4073a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4073e:	75 14                	jne    40754 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   40740:	0f b6 05 b9 58 00 00 	movzbl 0x58b9(%rip),%eax        # 46000 <disp_global>
   40747:	84 c0                	test   %al,%al
   40749:	0f 94 c0             	sete   %al
   4074c:	88 05 ae 58 00 00    	mov    %al,0x58ae(%rip)        # 46000 <disp_global>
   40752:	eb 36                	jmp    4078a <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40754:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40758:	78 2f                	js     40789 <syscall_mem_tog+0x66>
   4075a:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4075e:	7f 29                	jg     40789 <syscall_mem_tog+0x66>
   40760:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40764:	8b 00                	mov    (%rax),%eax
   40766:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40769:	75 1e                	jne    40789 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   4076b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4076f:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   40776:	84 c0                	test   %al,%al
   40778:	0f 94 c0             	sete   %al
   4077b:	89 c2                	mov    %eax,%edx
   4077d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40781:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   40787:	eb 01                	jmp    4078a <syscall_mem_tog+0x67>
            return;
   40789:	90                   	nop
    }
}
   4078a:	c9                   	leave  
   4078b:	c3                   	ret    

000000000004078c <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   4078c:	55                   	push   %rbp
   4078d:	48 89 e5             	mov    %rsp,%rbp
   40790:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
   40797:	48 89 bd e8 fe ff ff 	mov    %rdi,-0x118(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   4079e:	48 8b 05 5b e7 00 00 	mov    0xe75b(%rip),%rax        # 4ef00 <current>
   407a5:	48 8b 95 e8 fe ff ff 	mov    -0x118(%rbp),%rdx
   407ac:	48 83 c0 18          	add    $0x18,%rax
   407b0:	48 89 d6             	mov    %rdx,%rsi
   407b3:	ba 18 00 00 00       	mov    $0x18,%edx
   407b8:	48 89 c7             	mov    %rax,%rdi
   407bb:	48 89 d1             	mov    %rdx,%rcx
   407be:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   407c1:	48 8b 05 38 08 01 00 	mov    0x10838(%rip),%rax        # 51000 <kernel_pagetable>
   407c8:	48 89 c7             	mov    %rax,%rdi
   407cb:	e8 0d 20 00 00       	call   427dd <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   407d0:	8b 05 26 88 07 00    	mov    0x78826(%rip),%eax        # b8ffc <cursorpos>
   407d6:	89 c7                	mov    %eax,%edi
   407d8:	e8 2e 17 00 00       	call   41f0b <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   407dd:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   407e4:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407eb:	48 83 f8 0e          	cmp    $0xe,%rax
   407ef:	74 14                	je     40805 <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   407f1:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   407f8:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407ff:	48 83 f8 0d          	cmp    $0xd,%rax
   40803:	75 16                	jne    4081b <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   40805:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   4080c:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40813:	83 e0 04             	and    $0x4,%eax
   40816:	48 85 c0             	test   %rax,%rax
   40819:	74 1a                	je     40835 <exception+0xa9>
        check_virtual_memory();
   4081b:	e8 b4 08 00 00       	call   410d4 <check_virtual_memory>
        if(disp_global){
   40820:	0f b6 05 d9 57 00 00 	movzbl 0x57d9(%rip),%eax        # 46000 <disp_global>
   40827:	84 c0                	test   %al,%al
   40829:	74 0a                	je     40835 <exception+0xa9>
            memshow_physical();
   4082b:	e8 1c 0a 00 00       	call   4124c <memshow_physical>
            memshow_virtual_animate();
   40830:	e8 46 0d 00 00       	call   4157b <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40835:	e8 b4 1b 00 00       	call   423ee <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   4083a:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40841:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40848:	48 83 e8 0e          	sub    $0xe,%rax
   4084c:	48 83 f8 2c          	cmp    $0x2c,%rax
   40850:	0f 87 a7 03 00 00    	ja     40bfd <exception+0x471>
   40856:	48 8b 04 c5 f8 4d 04 	mov    0x44df8(,%rax,8),%rax
   4085d:	00 
   4085e:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   40860:	48 8b 05 99 e6 00 00 	mov    0xe699(%rip),%rax        # 4ef00 <current>
   40867:	48 8b 40 48          	mov    0x48(%rax),%rax
   4086b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
                    if((void *)addr == NULL)
   4086f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   40874:	75 0f                	jne    40885 <exception+0xf9>
                        kernel_panic(NULL);
   40876:	bf 00 00 00 00       	mov    $0x0,%edi
   4087b:	b8 00 00 00 00       	mov    $0x0,%eax
   40880:	e8 aa 1c 00 00       	call   4252f <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40885:	48 8b 05 74 e6 00 00 	mov    0xe674(%rip),%rax        # 4ef00 <current>
   4088c:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40893:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   40897:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   4089b:	48 89 ce             	mov    %rcx,%rsi
   4089e:	48 89 c7             	mov    %rax,%rdi
   408a1:	e8 2b 24 00 00       	call   42cd1 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   408a6:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   408aa:	48 89 c1             	mov    %rax,%rcx
   408ad:	48 8d 85 f8 fe ff ff 	lea    -0x108(%rbp),%rax
   408b4:	ba a0 00 00 00       	mov    $0xa0,%edx
   408b9:	48 89 ce             	mov    %rcx,%rsi
   408bc:	48 89 c7             	mov    %rax,%rdi
   408bf:	e8 90 33 00 00       	call   43c54 <memcpy>
                    kernel_panic(msg);
   408c4:	48 8d 85 f8 fe ff ff 	lea    -0x108(%rbp),%rax
   408cb:	48 89 c7             	mov    %rax,%rdi
   408ce:	b8 00 00 00 00       	mov    $0x0,%eax
   408d3:	e8 57 1c 00 00       	call   4252f <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   408d8:	48 8b 05 21 e6 00 00 	mov    0xe621(%rip),%rax        # 4ef00 <current>
   408df:	8b 10                	mov    (%rax),%edx
   408e1:	48 8b 05 18 e6 00 00 	mov    0xe618(%rip),%rax        # 4ef00 <current>
   408e8:	48 63 d2             	movslq %edx,%rdx
   408eb:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408ef:	e9 19 03 00 00       	jmp    40c0d <exception+0x481>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   408f4:	b8 00 00 00 00       	mov    $0x0,%eax
   408f9:	e8 28 fb ff ff       	call   40426 <syscall_fork>
   408fe:	89 c2                	mov    %eax,%edx
   40900:	48 8b 05 f9 e5 00 00 	mov    0xe5f9(%rip),%rax        # 4ef00 <current>
   40907:	48 63 d2             	movslq %edx,%rdx
   4090a:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   4090e:	e9 fa 02 00 00       	jmp    40c0d <exception+0x481>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   40913:	48 8b 05 e6 e5 00 00 	mov    0xe5e6(%rip),%rax        # 4ef00 <current>
   4091a:	48 89 c7             	mov    %rax,%rdi
   4091d:	e8 1e fd ff ff       	call   40640 <syscall_mapping>
                break;
   40922:	e9 e6 02 00 00       	jmp    40c0d <exception+0x481>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   40927:	b8 00 00 00 00       	mov    $0x0,%eax
   4092c:	e8 0a fb ff ff       	call   4043b <syscall_exit>
                schedule();
   40931:	e8 00 03 00 00       	call   40c36 <schedule>
                break;
   40936:	e9 d2 02 00 00       	jmp    40c0d <exception+0x481>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   4093b:	e8 f6 02 00 00       	call   40c36 <schedule>
                break;                  /* will not be reached */
   40940:	e9 c8 02 00 00       	jmp    40c0d <exception+0x481>

        case INT_SYS_BRK: 
            {
                // TODO : Your code here
                // goes straight to address
                uintptr_t new_break = current->p_registers.reg_rdi; //argument of new memory addr
   40945:	48 8b 05 b4 e5 00 00 	mov    0xe5b4(%rip),%rax        # 4ef00 <current>
   4094c:	48 8b 40 48          	mov    0x48(%rax),%rax
   40950:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
                current->p_registers.reg_rax = (uintptr_t)brk(current, new_break); //return 0 upon success
   40954:	48 8b 05 a5 e5 00 00 	mov    0xe5a5(%rip),%rax        # 4ef00 <current>
   4095b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4095f:	48 89 d6             	mov    %rdx,%rsi
   40962:	48 89 c7             	mov    %rax,%rdi
   40965:	e8 ef fb ff ff       	call   40559 <brk>
   4096a:	89 c2                	mov    %eax,%edx
   4096c:	48 8b 05 8d e5 00 00 	mov    0xe58d(%rip),%rax        # 4ef00 <current>
   40973:	48 63 d2             	movslq %edx,%rdx
   40976:	48 89 50 18          	mov    %rdx,0x18(%rax)
		        break;
   4097a:	e9 8e 02 00 00       	jmp    40c0d <exception+0x481>

        case INT_SYS_SBRK:
            {
                // TODO : Your code here
                // moves break by an increment
                uintptr_t curr_break = current->program_break;
   4097f:	48 8b 05 7a e5 00 00 	mov    0xe57a(%rip),%rax        # 4ef00 <current>
   40986:	48 8b 40 08          	mov    0x8(%rax),%rax
   4098a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
                //intptr_t incr_break_addr = curr_break + current->p_registers.reg_rdi; //adding increment to current break
                intptr_t incr_break_addr = (intptr_t)current->p_registers.reg_rdi; //argument for sbrk i.e. number of bytes to increment
   4098e:	48 8b 05 6b e5 00 00 	mov    0xe56b(%rip),%rax        # 4ef00 <current>
   40995:	48 8b 40 48          	mov    0x48(%rax),%rax
   40999:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

                if (sbrk(current, incr_break_addr) < 0)
   4099d:	48 8b 05 5c e5 00 00 	mov    0xe55c(%rip),%rax        # 4ef00 <current>
   409a4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   409a8:	48 89 d6             	mov    %rdx,%rsi
   409ab:	48 89 c7             	mov    %rax,%rdi
   409ae:	e8 10 fc ff ff       	call   405c3 <sbrk>
   409b3:	85 c0                	test   %eax,%eax
   409b5:	79 14                	jns    409cb <exception+0x23f>
                    current->p_registers.reg_rax = -1;
   409b7:	48 8b 05 42 e5 00 00 	mov    0xe542(%rip),%rax        # 4ef00 <current>
   409be:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   409c5:	ff 
                else //return OLD brk addr upon success
                    current->p_registers.reg_rax = curr_break;

                break;
   409c6:	e9 42 02 00 00       	jmp    40c0d <exception+0x481>
                    current->p_registers.reg_rax = curr_break;
   409cb:	48 8b 05 2e e5 00 00 	mov    0xe52e(%rip),%rax        # 4ef00 <current>
   409d2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   409d6:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   409da:	e9 2e 02 00 00       	jmp    40c0d <exception+0x481>
            }
	    case INT_SYS_PAGE_ALLOC:
            {
                intptr_t addr = reg->reg_rdi;
   409df:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   409e6:	48 8b 40 30          	mov    0x30(%rax),%rax
   409ea:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
                syscall_page_alloc(addr);
   409ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   409f2:	48 89 c7             	mov    %rax,%rdi
   409f5:	e8 58 fa ff ff       	call   40452 <syscall_page_alloc>
                break;
   409fa:	e9 0e 02 00 00       	jmp    40c0d <exception+0x481>
            }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   409ff:	48 8b 05 fa e4 00 00 	mov    0xe4fa(%rip),%rax        # 4ef00 <current>
   40a06:	48 89 c7             	mov    %rax,%rdi
   40a09:	e8 15 fd ff ff       	call   40723 <syscall_mem_tog>
                break;
   40a0e:	e9 fa 01 00 00       	jmp    40c0d <exception+0x481>
            }

        case INT_TIMER:
            {
                ++ticks;
   40a13:	8b 05 07 e9 00 00    	mov    0xe907(%rip),%eax        # 4f320 <ticks>
   40a19:	83 c0 01             	add    $0x1,%eax
   40a1c:	89 05 fe e8 00 00    	mov    %eax,0xe8fe(%rip)        # 4f320 <ticks>
                schedule();
   40a22:	e8 0f 02 00 00       	call   40c36 <schedule>
                break;                  /* will not be reached */
   40a27:	e9 e1 01 00 00       	jmp    40c0d <exception+0x481>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40a2c:	0f 20 d0             	mov    %cr2,%rax
   40a2f:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    return val;
   40a33:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2(); //address that caused the fault
   40a37:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
                //lazy allocation
                //if address that caused the fault is in bounds of break but hasn't been mapped yet, allocate memory
                if (addr <= current->program_break && addr >= current->original_break && !(reg->reg_err & PFERR_PRESENT))
   40a3b:	48 8b 05 be e4 00 00 	mov    0xe4be(%rip),%rax        # 4ef00 <current>
   40a42:	48 8b 40 08          	mov    0x8(%rax),%rax
   40a46:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   40a4a:	0f 82 b5 00 00 00    	jb     40b05 <exception+0x379>
   40a50:	48 8b 05 a9 e4 00 00 	mov    0xe4a9(%rip),%rax        # 4ef00 <current>
   40a57:	48 8b 40 10          	mov    0x10(%rax),%rax
   40a5b:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   40a5f:	0f 82 a0 00 00 00    	jb     40b05 <exception+0x379>
   40a65:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40a6c:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a73:	83 e0 01             	and    $0x1,%eax
   40a76:	48 85 c0             	test   %rax,%rax
   40a79:	0f 85 86 00 00 00    	jne    40b05 <exception+0x379>
                {
                    addr &= ~(PAGESIZE - 1); //from alignment macro
   40a7f:	48 81 65 d0 00 f0 ff 	andq   $0xfffffffffffff000,-0x30(%rbp)
   40a86:	ff 
                    uintptr_t pa = (uintptr_t)palloc(current->p_pid);
   40a87:	48 8b 05 72 e4 00 00 	mov    0xe472(%rip),%rax        # 4ef00 <current>
   40a8e:	8b 00                	mov    (%rax),%eax
   40a90:	89 c7                	mov    %eax,%edi
   40a92:	e8 89 26 00 00       	call   43120 <palloc>
   40a97:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

                    //valid map - if there is a physical page available and the map is successful
                    if (pa && (virtual_memory_map(current->p_pagetable, addr, pa, PAGESIZE, PTE_P | PTE_U | PTE_W) == 0))
   40a9b:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40aa0:	74 43                	je     40ae5 <exception+0x359>
   40aa2:	48 8b 05 57 e4 00 00 	mov    0xe457(%rip),%rax        # 4ef00 <current>
   40aa9:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40ab0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ab4:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40ab8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40abe:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40ac3:	48 89 c7             	mov    %rax,%rdi
   40ac6:	e8 43 1e 00 00       	call   4290e <virtual_memory_map>
   40acb:	85 c0                	test   %eax,%eax
   40acd:	75 16                	jne    40ae5 <exception+0x359>
                        current->p_state = P_RUNNABLE;
   40acf:	48 8b 05 2a e4 00 00 	mov    0xe42a(%rip),%rax        # 4ef00 <current>
   40ad6:	c7 80 d8 00 00 00 01 	movl   $0x1,0xd8(%rax)
   40add:	00 00 00 
                {
   40ae0:	e9 16 01 00 00       	jmp    40bfb <exception+0x46f>
                    else { //not valid
                        current->p_state = P_BROKEN;
   40ae5:	48 8b 05 14 e4 00 00 	mov    0xe414(%rip),%rax        # 4ef00 <current>
   40aec:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40af3:	00 00 00 
                        syscall_exit();
   40af6:	b8 00 00 00 00       	mov    $0x0,%eax
   40afb:	e8 3b f9 ff ff       	call   4043b <syscall_exit>
                {
   40b00:	e9 f6 00 00 00       	jmp    40bfb <exception+0x46f>
                    }
                }

                else
                {
                    const char* operation = reg->reg_err & PFERR_WRITE
   40b05:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b0c:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b13:	83 e0 02             	and    $0x2,%eax
                    ? "write" : "read";
   40b16:	48 85 c0             	test   %rax,%rax
   40b19:	74 07                	je     40b22 <exception+0x396>
   40b1b:	b8 6b 4d 04 00       	mov    $0x44d6b,%eax
   40b20:	eb 05                	jmp    40b27 <exception+0x39b>
   40b22:	b8 71 4d 04 00       	mov    $0x44d71,%eax
                    const char* operation = reg->reg_err & PFERR_WRITE
   40b27:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
                    const char* problem = reg->reg_err & PFERR_PRESENT
   40b2b:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b32:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b39:	83 e0 01             	and    $0x1,%eax
                    ? "protection problem" : "missing page";
   40b3c:	48 85 c0             	test   %rax,%rax
   40b3f:	74 07                	je     40b48 <exception+0x3bc>
   40b41:	b8 76 4d 04 00       	mov    $0x44d76,%eax
   40b46:	eb 05                	jmp    40b4d <exception+0x3c1>
   40b48:	b8 89 4d 04 00       	mov    $0x44d89,%eax
                    const char* problem = reg->reg_err & PFERR_PRESENT
   40b4d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)

                    if (!(reg->reg_err & PFERR_USER)) {
   40b51:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b58:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b5f:	83 e0 04             	and    $0x4,%eax
   40b62:	48 85 c0             	test   %rax,%rax
   40b65:	75 2f                	jne    40b96 <exception+0x40a>
                        kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40b67:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b6e:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40b75:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40b79:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   40b7d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40b81:	49 89 f0             	mov    %rsi,%r8
   40b84:	48 89 c6             	mov    %rax,%rsi
   40b87:	bf 98 4d 04 00       	mov    $0x44d98,%edi
   40b8c:	b8 00 00 00 00       	mov    $0x0,%eax
   40b91:	e8 99 19 00 00       	call   4252f <kernel_panic>
                                addr, operation, problem, reg->reg_rip);
                    }

                    console_printf(CPOS(24, 0), 0x0C00,
   40b96:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b9d:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                            "Process %d page fault for %p (%s %s, rip=%p)!\n",
                            current->p_pid, addr, operation, problem, reg->reg_rip);
   40ba4:	48 8b 05 55 e3 00 00 	mov    0xe355(%rip),%rax        # 4ef00 <current>
                    console_printf(CPOS(24, 0), 0x0C00,
   40bab:	8b 00                	mov    (%rax),%eax
   40bad:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
   40bb1:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40bb5:	52                   	push   %rdx
   40bb6:	ff 75 b8             	push   -0x48(%rbp)
   40bb9:	49 89 f1             	mov    %rsi,%r9
   40bbc:	49 89 c8             	mov    %rcx,%r8
   40bbf:	89 c1                	mov    %eax,%ecx
   40bc1:	ba c8 4d 04 00       	mov    $0x44dc8,%edx
   40bc6:	be 00 0c 00 00       	mov    $0xc00,%esi
   40bcb:	bf 80 07 00 00       	mov    $0x780,%edi
   40bd0:	b8 00 00 00 00       	mov    $0x0,%eax
   40bd5:	e8 2f 3f 00 00       	call   44b09 <console_printf>
   40bda:	48 83 c4 10          	add    $0x10,%rsp
                    current->p_state = P_BROKEN;
   40bde:	48 8b 05 1b e3 00 00 	mov    0xe31b(%rip),%rax        # 4ef00 <current>
   40be5:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40bec:	00 00 00 
                    syscall_exit();
   40bef:	b8 00 00 00 00       	mov    $0x0,%eax
   40bf4:	e8 42 f8 ff ff       	call   4043b <syscall_exit>
                }

                break;
   40bf9:	eb 12                	jmp    40c0d <exception+0x481>
   40bfb:	eb 10                	jmp    40c0d <exception+0x481>
            }

        default:
            default_exception(current);
   40bfd:	48 8b 05 fc e2 00 00 	mov    0xe2fc(%rip),%rax        # 4ef00 <current>
   40c04:	48 89 c7             	mov    %rax,%rdi
   40c07:	e8 33 1a 00 00       	call   4263f <default_exception>
            break;                  /* will not be reached */
   40c0c:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40c0d:	48 8b 05 ec e2 00 00 	mov    0xe2ec(%rip),%rax        # 4ef00 <current>
   40c14:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c1a:	83 f8 01             	cmp    $0x1,%eax
   40c1d:	75 0f                	jne    40c2e <exception+0x4a2>
        run(current);
   40c1f:	48 8b 05 da e2 00 00 	mov    0xe2da(%rip),%rax        # 4ef00 <current>
   40c26:	48 89 c7             	mov    %rax,%rdi
   40c29:	e8 7e 00 00 00       	call   40cac <run>
    } else {
        schedule();
   40c2e:	e8 03 00 00 00       	call   40c36 <schedule>
    }
}
   40c33:	90                   	nop
   40c34:	c9                   	leave  
   40c35:	c3                   	ret    

0000000000040c36 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40c36:	55                   	push   %rbp
   40c37:	48 89 e5             	mov    %rsp,%rbp
   40c3a:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40c3e:	48 8b 05 bb e2 00 00 	mov    0xe2bb(%rip),%rax        # 4ef00 <current>
   40c45:	8b 00                	mov    (%rax),%eax
   40c47:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40c4a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c4d:	8d 50 01             	lea    0x1(%rax),%edx
   40c50:	89 d0                	mov    %edx,%eax
   40c52:	c1 f8 1f             	sar    $0x1f,%eax
   40c55:	c1 e8 1c             	shr    $0x1c,%eax
   40c58:	01 c2                	add    %eax,%edx
   40c5a:	83 e2 0f             	and    $0xf,%edx
   40c5d:	29 c2                	sub    %eax,%edx
   40c5f:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40c62:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c65:	48 63 d0             	movslq %eax,%rdx
   40c68:	48 89 d0             	mov    %rdx,%rax
   40c6b:	48 c1 e0 04          	shl    $0x4,%rax
   40c6f:	48 29 d0             	sub    %rdx,%rax
   40c72:	48 c1 e0 04          	shl    $0x4,%rax
   40c76:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40c7c:	8b 00                	mov    (%rax),%eax
   40c7e:	83 f8 01             	cmp    $0x1,%eax
   40c81:	75 22                	jne    40ca5 <schedule+0x6f>
            run(&processes[pid]);
   40c83:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c86:	48 63 d0             	movslq %eax,%rdx
   40c89:	48 89 d0             	mov    %rdx,%rax
   40c8c:	48 c1 e0 04          	shl    $0x4,%rax
   40c90:	48 29 d0             	sub    %rdx,%rax
   40c93:	48 c1 e0 04          	shl    $0x4,%rax
   40c97:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   40c9d:	48 89 c7             	mov    %rax,%rdi
   40ca0:	e8 07 00 00 00       	call   40cac <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40ca5:	e8 44 17 00 00       	call   423ee <check_keyboard>
        pid = (pid + 1) % NPROC;
   40caa:	eb 9e                	jmp    40c4a <schedule+0x14>

0000000000040cac <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40cac:	55                   	push   %rbp
   40cad:	48 89 e5             	mov    %rsp,%rbp
   40cb0:	48 83 ec 10          	sub    $0x10,%rsp
   40cb4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40cb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cbc:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40cc2:	83 f8 01             	cmp    $0x1,%eax
   40cc5:	74 14                	je     40cdb <run+0x2f>
   40cc7:	ba 60 4f 04 00       	mov    $0x44f60,%edx
   40ccc:	be cf 01 00 00       	mov    $0x1cf,%esi
   40cd1:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40cd6:	e8 34 19 00 00       	call   4260f <assert_fail>
    current = p;
   40cdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cdf:	48 89 05 1a e2 00 00 	mov    %rax,0xe21a(%rip)        # 4ef00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40ce6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cea:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40cec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cf0:	8b 00                	mov    (%rax),%eax
   40cf2:	83 c0 02             	add    $0x2,%eax
   40cf5:	48 98                	cltq   
   40cf7:	0f b7 84 00 c0 4c 04 	movzwl 0x44cc0(%rax,%rax,1),%eax
   40cfe:	00 
    console_printf(CPOS(24, 79),
   40cff:	0f b7 c0             	movzwl %ax,%eax
   40d02:	89 d1                	mov    %edx,%ecx
   40d04:	ba 79 4f 04 00       	mov    $0x44f79,%edx
   40d09:	89 c6                	mov    %eax,%esi
   40d0b:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40d10:	b8 00 00 00 00       	mov    $0x0,%eax
   40d15:	e8 ef 3d 00 00       	call   44b09 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40d1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d1e:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40d25:	48 89 c7             	mov    %rax,%rdi
   40d28:	e8 b0 1a 00 00       	call   427dd <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40d2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d31:	48 83 c0 18          	add    $0x18,%rax
   40d35:	48 89 c7             	mov    %rax,%rdi
   40d38:	e8 86 f3 ff ff       	call   400c3 <exception_return>

0000000000040d3d <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40d3d:	55                   	push   %rbp
   40d3e:	48 89 e5             	mov    %rsp,%rbp
   40d41:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d45:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40d4c:	00 
   40d4d:	e9 81 00 00 00       	jmp    40dd3 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40d52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d56:	48 89 c7             	mov    %rax,%rdi
   40d59:	e8 1e 0f 00 00       	call   41c7c <physical_memory_isreserved>
   40d5e:	85 c0                	test   %eax,%eax
   40d60:	74 09                	je     40d6b <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40d62:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40d69:	eb 2f                	jmp    40d9a <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40d6b:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40d72:	00 
   40d73:	76 0b                	jbe    40d80 <pageinfo_init+0x43>
   40d75:	b8 10 70 05 00       	mov    $0x57010,%eax
   40d7a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d7e:	72 0a                	jb     40d8a <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40d80:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40d87:	00 
   40d88:	75 09                	jne    40d93 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40d8a:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40d91:	eb 07                	jmp    40d9a <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40d93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40d9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d9e:	48 c1 e8 0c          	shr    $0xc,%rax
   40da2:	89 c1                	mov    %eax,%ecx
   40da4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40da7:	89 c2                	mov    %eax,%edx
   40da9:	48 63 c1             	movslq %ecx,%rax
   40dac:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40db3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40db7:	0f 95 c2             	setne  %dl
   40dba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dbe:	48 c1 e8 0c          	shr    $0xc,%rax
   40dc2:	48 98                	cltq   
   40dc4:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40dcb:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40dd2:	00 
   40dd3:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40dda:	00 
   40ddb:	0f 86 71 ff ff ff    	jbe    40d52 <pageinfo_init+0x15>
    }
}
   40de1:	90                   	nop
   40de2:	90                   	nop
   40de3:	c9                   	leave  
   40de4:	c3                   	ret    

0000000000040de5 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40de5:	55                   	push   %rbp
   40de6:	48 89 e5             	mov    %rsp,%rbp
   40de9:	48 83 ec 50          	sub    $0x50,%rsp
   40ded:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40df1:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40df5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40dfb:	48 89 c2             	mov    %rax,%rdx
   40dfe:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e02:	48 39 c2             	cmp    %rax,%rdx
   40e05:	74 14                	je     40e1b <check_page_table_mappings+0x36>
   40e07:	ba 80 4f 04 00       	mov    $0x44f80,%edx
   40e0c:	be fd 01 00 00       	mov    $0x1fd,%esi
   40e11:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40e16:	e8 f4 17 00 00       	call   4260f <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e1b:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40e22:	00 
   40e23:	e9 9a 00 00 00       	jmp    40ec2 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40e28:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40e2c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40e30:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e34:	48 89 ce             	mov    %rcx,%rsi
   40e37:	48 89 c7             	mov    %rax,%rdi
   40e3a:	e8 92 1e 00 00       	call   42cd1 <virtual_memory_lookup>
        if (vam.pa != va) {
   40e3f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e43:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e47:	74 27                	je     40e70 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40e49:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40e4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e51:	49 89 d0             	mov    %rdx,%r8
   40e54:	48 89 c1             	mov    %rax,%rcx
   40e57:	ba 9f 4f 04 00       	mov    $0x44f9f,%edx
   40e5c:	be 00 c0 00 00       	mov    $0xc000,%esi
   40e61:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40e66:	b8 00 00 00 00       	mov    $0x0,%eax
   40e6b:	e8 99 3c 00 00       	call   44b09 <console_printf>
        }
        assert(vam.pa == va);
   40e70:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e74:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e78:	74 14                	je     40e8e <check_page_table_mappings+0xa9>
   40e7a:	ba a9 4f 04 00       	mov    $0x44fa9,%edx
   40e7f:	be 06 02 00 00       	mov    $0x206,%esi
   40e84:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40e89:	e8 81 17 00 00       	call   4260f <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40e8e:	b8 00 60 04 00       	mov    $0x46000,%eax
   40e93:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e97:	72 21                	jb     40eba <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40e99:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40e9c:	48 98                	cltq   
   40e9e:	83 e0 02             	and    $0x2,%eax
   40ea1:	48 85 c0             	test   %rax,%rax
   40ea4:	75 14                	jne    40eba <check_page_table_mappings+0xd5>
   40ea6:	ba b6 4f 04 00       	mov    $0x44fb6,%edx
   40eab:	be 08 02 00 00       	mov    $0x208,%esi
   40eb0:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40eb5:	e8 55 17 00 00       	call   4260f <assert_fail>
         va += PAGESIZE) {
   40eba:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40ec1:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40ec2:	b8 10 70 05 00       	mov    $0x57010,%eax
   40ec7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ecb:	0f 82 57 ff ff ff    	jb     40e28 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40ed1:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40ed8:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40ed9:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40edd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40ee1:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40ee5:	48 89 ce             	mov    %rcx,%rsi
   40ee8:	48 89 c7             	mov    %rax,%rdi
   40eeb:	e8 e1 1d 00 00       	call   42cd1 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40ef0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40ef4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40ef8:	74 14                	je     40f0e <check_page_table_mappings+0x129>
   40efa:	ba c7 4f 04 00       	mov    $0x44fc7,%edx
   40eff:	be 0f 02 00 00       	mov    $0x20f,%esi
   40f04:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40f09:	e8 01 17 00 00       	call   4260f <assert_fail>
    assert(vam.perm & PTE_W);
   40f0e:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40f11:	48 98                	cltq   
   40f13:	83 e0 02             	and    $0x2,%eax
   40f16:	48 85 c0             	test   %rax,%rax
   40f19:	75 14                	jne    40f2f <check_page_table_mappings+0x14a>
   40f1b:	ba b6 4f 04 00       	mov    $0x44fb6,%edx
   40f20:	be 10 02 00 00       	mov    $0x210,%esi
   40f25:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   40f2a:	e8 e0 16 00 00       	call   4260f <assert_fail>
}
   40f2f:	90                   	nop
   40f30:	c9                   	leave  
   40f31:	c3                   	ret    

0000000000040f32 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40f32:	55                   	push   %rbp
   40f33:	48 89 e5             	mov    %rsp,%rbp
   40f36:	48 83 ec 20          	sub    $0x20,%rsp
   40f3a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f3e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40f41:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40f44:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40f47:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40f4e:	48 8b 05 ab 00 01 00 	mov    0x100ab(%rip),%rax        # 51000 <kernel_pagetable>
   40f55:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40f59:	75 67                	jne    40fc2 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40f5b:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f62:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40f69:	eb 51                	jmp    40fbc <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40f6b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f6e:	48 63 d0             	movslq %eax,%rdx
   40f71:	48 89 d0             	mov    %rdx,%rax
   40f74:	48 c1 e0 04          	shl    $0x4,%rax
   40f78:	48 29 d0             	sub    %rdx,%rax
   40f7b:	48 c1 e0 04          	shl    $0x4,%rax
   40f7f:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40f85:	8b 00                	mov    (%rax),%eax
   40f87:	85 c0                	test   %eax,%eax
   40f89:	74 2d                	je     40fb8 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40f8b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f8e:	48 63 d0             	movslq %eax,%rdx
   40f91:	48 89 d0             	mov    %rdx,%rax
   40f94:	48 c1 e0 04          	shl    $0x4,%rax
   40f98:	48 29 d0             	sub    %rdx,%rax
   40f9b:	48 c1 e0 04          	shl    $0x4,%rax
   40f9f:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   40fa5:	48 8b 10             	mov    (%rax),%rdx
   40fa8:	48 8b 05 51 00 01 00 	mov    0x10051(%rip),%rax        # 51000 <kernel_pagetable>
   40faf:	48 39 c2             	cmp    %rax,%rdx
   40fb2:	75 04                	jne    40fb8 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40fb4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40fb8:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40fbc:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40fc0:	7e a9                	jle    40f6b <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40fc2:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40fc5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fc8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fcc:	be 00 00 00 00       	mov    $0x0,%esi
   40fd1:	48 89 c7             	mov    %rax,%rdi
   40fd4:	e8 03 00 00 00       	call   40fdc <check_page_table_ownership_level>
}
   40fd9:	90                   	nop
   40fda:	c9                   	leave  
   40fdb:	c3                   	ret    

0000000000040fdc <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40fdc:	55                   	push   %rbp
   40fdd:	48 89 e5             	mov    %rsp,%rbp
   40fe0:	48 83 ec 30          	sub    $0x30,%rsp
   40fe4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40fe8:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40feb:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40fee:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40ff1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ff5:	48 c1 e8 0c          	shr    $0xc,%rax
   40ff9:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40ffe:	7e 14                	jle    41014 <check_page_table_ownership_level+0x38>
   41000:	ba d8 4f 04 00       	mov    $0x44fd8,%edx
   41005:	be 2d 02 00 00       	mov    $0x22d,%esi
   4100a:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   4100f:	e8 fb 15 00 00       	call   4260f <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41014:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41018:	48 c1 e8 0c          	shr    $0xc,%rax
   4101c:	48 98                	cltq   
   4101e:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41025:	00 
   41026:	0f be c0             	movsbl %al,%eax
   41029:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   4102c:	74 14                	je     41042 <check_page_table_ownership_level+0x66>
   4102e:	ba f0 4f 04 00       	mov    $0x44ff0,%edx
   41033:	be 2e 02 00 00       	mov    $0x22e,%esi
   41038:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   4103d:	e8 cd 15 00 00       	call   4260f <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41042:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41046:	48 c1 e8 0c          	shr    $0xc,%rax
   4104a:	48 98                	cltq   
   4104c:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41053:	00 
   41054:	0f be c0             	movsbl %al,%eax
   41057:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4105a:	74 14                	je     41070 <check_page_table_ownership_level+0x94>
   4105c:	ba 18 50 04 00       	mov    $0x45018,%edx
   41061:	be 2f 02 00 00       	mov    $0x22f,%esi
   41066:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   4106b:	e8 9f 15 00 00       	call   4260f <assert_fail>
    if (level < 3) {
   41070:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41074:	7f 5b                	jg     410d1 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41076:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4107d:	eb 49                	jmp    410c8 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   4107f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41083:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41086:	48 63 d2             	movslq %edx,%rdx
   41089:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4108d:	48 85 c0             	test   %rax,%rax
   41090:	74 32                	je     410c4 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41092:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41096:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41099:	48 63 d2             	movslq %edx,%rdx
   4109c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   410a0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   410a6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   410aa:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   410ad:	8d 70 01             	lea    0x1(%rax),%esi
   410b0:	8b 55 e0             	mov    -0x20(%rbp),%edx
   410b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   410b7:	b9 01 00 00 00       	mov    $0x1,%ecx
   410bc:	48 89 c7             	mov    %rax,%rdi
   410bf:	e8 18 ff ff ff       	call   40fdc <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   410c4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   410c8:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   410cf:	7e ae                	jle    4107f <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   410d1:	90                   	nop
   410d2:	c9                   	leave  
   410d3:	c3                   	ret    

00000000000410d4 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   410d4:	55                   	push   %rbp
   410d5:	48 89 e5             	mov    %rsp,%rbp
   410d8:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   410dc:	8b 05 f6 cf 00 00    	mov    0xcff6(%rip),%eax        # 4e0d8 <processes+0xd8>
   410e2:	85 c0                	test   %eax,%eax
   410e4:	74 14                	je     410fa <check_virtual_memory+0x26>
   410e6:	ba 48 50 04 00       	mov    $0x45048,%edx
   410eb:	be 42 02 00 00       	mov    $0x242,%esi
   410f0:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   410f5:	e8 15 15 00 00       	call   4260f <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   410fa:	48 8b 05 ff fe 00 00 	mov    0xfeff(%rip),%rax        # 51000 <kernel_pagetable>
   41101:	48 89 c7             	mov    %rax,%rdi
   41104:	e8 dc fc ff ff       	call   40de5 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41109:	48 8b 05 f0 fe 00 00 	mov    0xfef0(%rip),%rax        # 51000 <kernel_pagetable>
   41110:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41115:	48 89 c7             	mov    %rax,%rdi
   41118:	e8 15 fe ff ff       	call   40f32 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4111d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41124:	e9 9c 00 00 00       	jmp    411c5 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   41129:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4112c:	48 63 d0             	movslq %eax,%rdx
   4112f:	48 89 d0             	mov    %rdx,%rax
   41132:	48 c1 e0 04          	shl    $0x4,%rax
   41136:	48 29 d0             	sub    %rdx,%rax
   41139:	48 c1 e0 04          	shl    $0x4,%rax
   4113d:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41143:	8b 00                	mov    (%rax),%eax
   41145:	85 c0                	test   %eax,%eax
   41147:	74 78                	je     411c1 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41149:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4114c:	48 63 d0             	movslq %eax,%rdx
   4114f:	48 89 d0             	mov    %rdx,%rax
   41152:	48 c1 e0 04          	shl    $0x4,%rax
   41156:	48 29 d0             	sub    %rdx,%rax
   41159:	48 c1 e0 04          	shl    $0x4,%rax
   4115d:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   41163:	48 8b 10             	mov    (%rax),%rdx
   41166:	48 8b 05 93 fe 00 00 	mov    0xfe93(%rip),%rax        # 51000 <kernel_pagetable>
   4116d:	48 39 c2             	cmp    %rax,%rdx
   41170:	74 4f                	je     411c1 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41172:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41175:	48 63 d0             	movslq %eax,%rdx
   41178:	48 89 d0             	mov    %rdx,%rax
   4117b:	48 c1 e0 04          	shl    $0x4,%rax
   4117f:	48 29 d0             	sub    %rdx,%rax
   41182:	48 c1 e0 04          	shl    $0x4,%rax
   41186:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   4118c:	48 8b 00             	mov    (%rax),%rax
   4118f:	48 89 c7             	mov    %rax,%rdi
   41192:	e8 4e fc ff ff       	call   40de5 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41197:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4119a:	48 63 d0             	movslq %eax,%rdx
   4119d:	48 89 d0             	mov    %rdx,%rax
   411a0:	48 c1 e0 04          	shl    $0x4,%rax
   411a4:	48 29 d0             	sub    %rdx,%rax
   411a7:	48 c1 e0 04          	shl    $0x4,%rax
   411ab:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   411b1:	48 8b 00             	mov    (%rax),%rax
   411b4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411b7:	89 d6                	mov    %edx,%esi
   411b9:	48 89 c7             	mov    %rax,%rdi
   411bc:	e8 71 fd ff ff       	call   40f32 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   411c1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411c5:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   411c9:	0f 8e 5a ff ff ff    	jle    41129 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   411d6:	eb 67                	jmp    4123f <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   411d8:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411db:	48 98                	cltq   
   411dd:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   411e4:	00 
   411e5:	84 c0                	test   %al,%al
   411e7:	7e 52                	jle    4123b <check_virtual_memory+0x167>
   411e9:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411ec:	48 98                	cltq   
   411ee:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   411f5:	00 
   411f6:	84 c0                	test   %al,%al
   411f8:	78 41                	js     4123b <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   411fa:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411fd:	48 98                	cltq   
   411ff:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41206:	00 
   41207:	0f be c0             	movsbl %al,%eax
   4120a:	48 63 d0             	movslq %eax,%rdx
   4120d:	48 89 d0             	mov    %rdx,%rax
   41210:	48 c1 e0 04          	shl    $0x4,%rax
   41214:	48 29 d0             	sub    %rdx,%rax
   41217:	48 c1 e0 04          	shl    $0x4,%rax
   4121b:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41221:	8b 00                	mov    (%rax),%eax
   41223:	85 c0                	test   %eax,%eax
   41225:	75 14                	jne    4123b <check_virtual_memory+0x167>
   41227:	ba 68 50 04 00       	mov    $0x45068,%edx
   4122c:	be 59 02 00 00       	mov    $0x259,%esi
   41231:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   41236:	e8 d4 13 00 00       	call   4260f <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4123b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4123f:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41246:	7e 90                	jle    411d8 <check_virtual_memory+0x104>
        }
    }
}
   41248:	90                   	nop
   41249:	90                   	nop
   4124a:	c9                   	leave  
   4124b:	c3                   	ret    

000000000004124c <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   4124c:	55                   	push   %rbp
   4124d:	48 89 e5             	mov    %rsp,%rbp
   41250:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41254:	ba 98 50 04 00       	mov    $0x45098,%edx
   41259:	be 00 0f 00 00       	mov    $0xf00,%esi
   4125e:	bf 20 00 00 00       	mov    $0x20,%edi
   41263:	b8 00 00 00 00       	mov    $0x0,%eax
   41268:	e8 9c 38 00 00       	call   44b09 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4126d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41274:	e9 f8 00 00 00       	jmp    41371 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   41279:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4127c:	83 e0 3f             	and    $0x3f,%eax
   4127f:	85 c0                	test   %eax,%eax
   41281:	75 3c                	jne    412bf <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41283:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41286:	c1 e0 0c             	shl    $0xc,%eax
   41289:	89 c1                	mov    %eax,%ecx
   4128b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4128e:	8d 50 3f             	lea    0x3f(%rax),%edx
   41291:	85 c0                	test   %eax,%eax
   41293:	0f 48 c2             	cmovs  %edx,%eax
   41296:	c1 f8 06             	sar    $0x6,%eax
   41299:	8d 50 01             	lea    0x1(%rax),%edx
   4129c:	89 d0                	mov    %edx,%eax
   4129e:	c1 e0 02             	shl    $0x2,%eax
   412a1:	01 d0                	add    %edx,%eax
   412a3:	c1 e0 04             	shl    $0x4,%eax
   412a6:	83 c0 03             	add    $0x3,%eax
   412a9:	ba a8 50 04 00       	mov    $0x450a8,%edx
   412ae:	be 00 0f 00 00       	mov    $0xf00,%esi
   412b3:	89 c7                	mov    %eax,%edi
   412b5:	b8 00 00 00 00       	mov    $0x0,%eax
   412ba:	e8 4a 38 00 00       	call   44b09 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   412bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412c2:	48 98                	cltq   
   412c4:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   412cb:	00 
   412cc:	0f be c0             	movsbl %al,%eax
   412cf:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   412d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412d5:	48 98                	cltq   
   412d7:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   412de:	00 
   412df:	84 c0                	test   %al,%al
   412e1:	75 07                	jne    412ea <memshow_physical+0x9e>
            owner = PO_FREE;
   412e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   412ea:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412ed:	83 c0 02             	add    $0x2,%eax
   412f0:	48 98                	cltq   
   412f2:	0f b7 84 00 c0 4c 04 	movzwl 0x44cc0(%rax,%rax,1),%eax
   412f9:	00 
   412fa:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   412fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41301:	48 98                	cltq   
   41303:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4130a:	00 
   4130b:	3c 01                	cmp    $0x1,%al
   4130d:	7e 1a                	jle    41329 <memshow_physical+0xdd>
   4130f:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41314:	48 c1 e8 0c          	shr    $0xc,%rax
   41318:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4131b:	74 0c                	je     41329 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4131d:	b8 53 00 00 00       	mov    $0x53,%eax
   41322:	80 cc 0f             	or     $0xf,%ah
   41325:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41329:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4132c:	8d 50 3f             	lea    0x3f(%rax),%edx
   4132f:	85 c0                	test   %eax,%eax
   41331:	0f 48 c2             	cmovs  %edx,%eax
   41334:	c1 f8 06             	sar    $0x6,%eax
   41337:	8d 50 01             	lea    0x1(%rax),%edx
   4133a:	89 d0                	mov    %edx,%eax
   4133c:	c1 e0 02             	shl    $0x2,%eax
   4133f:	01 d0                	add    %edx,%eax
   41341:	c1 e0 04             	shl    $0x4,%eax
   41344:	89 c1                	mov    %eax,%ecx
   41346:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41349:	89 d0                	mov    %edx,%eax
   4134b:	c1 f8 1f             	sar    $0x1f,%eax
   4134e:	c1 e8 1a             	shr    $0x1a,%eax
   41351:	01 c2                	add    %eax,%edx
   41353:	83 e2 3f             	and    $0x3f,%edx
   41356:	29 c2                	sub    %eax,%edx
   41358:	89 d0                	mov    %edx,%eax
   4135a:	83 c0 0c             	add    $0xc,%eax
   4135d:	01 c8                	add    %ecx,%eax
   4135f:	48 98                	cltq   
   41361:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41365:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   4136c:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4136d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41371:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41378:	0f 8e fb fe ff ff    	jle    41279 <memshow_physical+0x2d>
    }
}
   4137e:	90                   	nop
   4137f:	90                   	nop
   41380:	c9                   	leave  
   41381:	c3                   	ret    

0000000000041382 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41382:	55                   	push   %rbp
   41383:	48 89 e5             	mov    %rsp,%rbp
   41386:	48 83 ec 40          	sub    $0x40,%rsp
   4138a:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4138e:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41392:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41396:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4139c:	48 89 c2             	mov    %rax,%rdx
   4139f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   413a3:	48 39 c2             	cmp    %rax,%rdx
   413a6:	74 14                	je     413bc <memshow_virtual+0x3a>
   413a8:	ba b0 50 04 00       	mov    $0x450b0,%edx
   413ad:	be 8a 02 00 00       	mov    $0x28a,%esi
   413b2:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   413b7:	e8 53 12 00 00       	call   4260f <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   413bc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   413c0:	48 89 c1             	mov    %rax,%rcx
   413c3:	ba dd 50 04 00       	mov    $0x450dd,%edx
   413c8:	be 00 0f 00 00       	mov    $0xf00,%esi
   413cd:	bf 3a 03 00 00       	mov    $0x33a,%edi
   413d2:	b8 00 00 00 00       	mov    $0x0,%eax
   413d7:	e8 2d 37 00 00       	call   44b09 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   413dc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   413e3:	00 
   413e4:	e9 80 01 00 00       	jmp    41569 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   413e9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   413ed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   413f1:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   413f5:	48 89 ce             	mov    %rcx,%rsi
   413f8:	48 89 c7             	mov    %rax,%rdi
   413fb:	e8 d1 18 00 00       	call   42cd1 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41400:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41403:	85 c0                	test   %eax,%eax
   41405:	79 0b                	jns    41412 <memshow_virtual+0x90>
            color = ' ';
   41407:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   4140d:	e9 d7 00 00 00       	jmp    414e9 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41412:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41416:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4141c:	76 14                	jbe    41432 <memshow_virtual+0xb0>
   4141e:	ba fa 50 04 00       	mov    $0x450fa,%edx
   41423:	be 93 02 00 00       	mov    $0x293,%esi
   41428:	bf 28 4d 04 00       	mov    $0x44d28,%edi
   4142d:	e8 dd 11 00 00       	call   4260f <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41432:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41435:	48 98                	cltq   
   41437:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   4143e:	00 
   4143f:	0f be c0             	movsbl %al,%eax
   41442:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41445:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41448:	48 98                	cltq   
   4144a:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41451:	00 
   41452:	84 c0                	test   %al,%al
   41454:	75 07                	jne    4145d <memshow_virtual+0xdb>
                owner = PO_FREE;
   41456:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   4145d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41460:	83 c0 02             	add    $0x2,%eax
   41463:	48 98                	cltq   
   41465:	0f b7 84 00 c0 4c 04 	movzwl 0x44cc0(%rax,%rax,1),%eax
   4146c:	00 
   4146d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41471:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41474:	48 98                	cltq   
   41476:	83 e0 04             	and    $0x4,%eax
   41479:	48 85 c0             	test   %rax,%rax
   4147c:	74 27                	je     414a5 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4147e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41482:	c1 e0 04             	shl    $0x4,%eax
   41485:	66 25 00 f0          	and    $0xf000,%ax
   41489:	89 c2                	mov    %eax,%edx
   4148b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4148f:	c1 f8 04             	sar    $0x4,%eax
   41492:	66 25 00 0f          	and    $0xf00,%ax
   41496:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41498:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4149c:	0f b6 c0             	movzbl %al,%eax
   4149f:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   414a1:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   414a5:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414a8:	48 98                	cltq   
   414aa:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   414b1:	00 
   414b2:	3c 01                	cmp    $0x1,%al
   414b4:	7e 33                	jle    414e9 <memshow_virtual+0x167>
   414b6:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   414bb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   414bf:	74 28                	je     414e9 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   414c1:	b8 53 00 00 00       	mov    $0x53,%eax
   414c6:	89 c2                	mov    %eax,%edx
   414c8:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414cc:	66 25 00 f0          	and    $0xf000,%ax
   414d0:	09 d0                	or     %edx,%eax
   414d2:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   414d6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   414d9:	48 98                	cltq   
   414db:	83 e0 04             	and    $0x4,%eax
   414de:	48 85 c0             	test   %rax,%rax
   414e1:	75 06                	jne    414e9 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   414e3:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   414e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414ed:	48 c1 e8 0c          	shr    $0xc,%rax
   414f1:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   414f4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414f7:	83 e0 3f             	and    $0x3f,%eax
   414fa:	85 c0                	test   %eax,%eax
   414fc:	75 34                	jne    41532 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   414fe:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41501:	c1 e8 06             	shr    $0x6,%eax
   41504:	89 c2                	mov    %eax,%edx
   41506:	89 d0                	mov    %edx,%eax
   41508:	c1 e0 02             	shl    $0x2,%eax
   4150b:	01 d0                	add    %edx,%eax
   4150d:	c1 e0 04             	shl    $0x4,%eax
   41510:	05 73 03 00 00       	add    $0x373,%eax
   41515:	89 c7                	mov    %eax,%edi
   41517:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4151b:	48 89 c1             	mov    %rax,%rcx
   4151e:	ba a8 50 04 00       	mov    $0x450a8,%edx
   41523:	be 00 0f 00 00       	mov    $0xf00,%esi
   41528:	b8 00 00 00 00       	mov    $0x0,%eax
   4152d:	e8 d7 35 00 00       	call   44b09 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41532:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41535:	c1 e8 06             	shr    $0x6,%eax
   41538:	89 c2                	mov    %eax,%edx
   4153a:	89 d0                	mov    %edx,%eax
   4153c:	c1 e0 02             	shl    $0x2,%eax
   4153f:	01 d0                	add    %edx,%eax
   41541:	c1 e0 04             	shl    $0x4,%eax
   41544:	89 c2                	mov    %eax,%edx
   41546:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41549:	83 e0 3f             	and    $0x3f,%eax
   4154c:	01 d0                	add    %edx,%eax
   4154e:	05 7c 03 00 00       	add    $0x37c,%eax
   41553:	89 c2                	mov    %eax,%edx
   41555:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41559:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41560:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41561:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41568:	00 
   41569:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41570:	00 
   41571:	0f 86 72 fe ff ff    	jbe    413e9 <memshow_virtual+0x67>
    }
}
   41577:	90                   	nop
   41578:	90                   	nop
   41579:	c9                   	leave  
   4157a:	c3                   	ret    

000000000004157b <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4157b:	55                   	push   %rbp
   4157c:	48 89 e5             	mov    %rsp,%rbp
   4157f:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41583:	8b 05 9b dd 00 00    	mov    0xdd9b(%rip),%eax        # 4f324 <last_ticks.1>
   41589:	85 c0                	test   %eax,%eax
   4158b:	74 13                	je     415a0 <memshow_virtual_animate+0x25>
   4158d:	8b 15 8d dd 00 00    	mov    0xdd8d(%rip),%edx        # 4f320 <ticks>
   41593:	8b 05 8b dd 00 00    	mov    0xdd8b(%rip),%eax        # 4f324 <last_ticks.1>
   41599:	29 c2                	sub    %eax,%edx
   4159b:	83 fa 31             	cmp    $0x31,%edx
   4159e:	76 2c                	jbe    415cc <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   415a0:	8b 05 7a dd 00 00    	mov    0xdd7a(%rip),%eax        # 4f320 <ticks>
   415a6:	89 05 78 dd 00 00    	mov    %eax,0xdd78(%rip)        # 4f324 <last_ticks.1>
        ++showing;
   415ac:	8b 05 52 4a 00 00    	mov    0x4a52(%rip),%eax        # 46004 <showing.0>
   415b2:	83 c0 01             	add    $0x1,%eax
   415b5:	89 05 49 4a 00 00    	mov    %eax,0x4a49(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   415bb:	eb 0f                	jmp    415cc <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   415bd:	8b 05 41 4a 00 00    	mov    0x4a41(%rip),%eax        # 46004 <showing.0>
   415c3:	83 c0 01             	add    $0x1,%eax
   415c6:	89 05 38 4a 00 00    	mov    %eax,0x4a38(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   415cc:	8b 05 32 4a 00 00    	mov    0x4a32(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   415d2:	83 f8 20             	cmp    $0x20,%eax
   415d5:	7f 34                	jg     4160b <memshow_virtual_animate+0x90>
   415d7:	8b 15 27 4a 00 00    	mov    0x4a27(%rip),%edx        # 46004 <showing.0>
   415dd:	89 d0                	mov    %edx,%eax
   415df:	c1 f8 1f             	sar    $0x1f,%eax
   415e2:	c1 e8 1c             	shr    $0x1c,%eax
   415e5:	01 c2                	add    %eax,%edx
   415e7:	83 e2 0f             	and    $0xf,%edx
   415ea:	29 c2                	sub    %eax,%edx
   415ec:	89 d0                	mov    %edx,%eax
   415ee:	48 63 d0             	movslq %eax,%rdx
   415f1:	48 89 d0             	mov    %rdx,%rax
   415f4:	48 c1 e0 04          	shl    $0x4,%rax
   415f8:	48 29 d0             	sub    %rdx,%rax
   415fb:	48 c1 e0 04          	shl    $0x4,%rax
   415ff:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41605:	8b 00                	mov    (%rax),%eax
   41607:	85 c0                	test   %eax,%eax
   41609:	74 b2                	je     415bd <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   4160b:	8b 15 f3 49 00 00    	mov    0x49f3(%rip),%edx        # 46004 <showing.0>
   41611:	89 d0                	mov    %edx,%eax
   41613:	c1 f8 1f             	sar    $0x1f,%eax
   41616:	c1 e8 1c             	shr    $0x1c,%eax
   41619:	01 c2                	add    %eax,%edx
   4161b:	83 e2 0f             	and    $0xf,%edx
   4161e:	29 c2                	sub    %eax,%edx
   41620:	89 d0                	mov    %edx,%eax
   41622:	89 05 dc 49 00 00    	mov    %eax,0x49dc(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   41628:	8b 05 d6 49 00 00    	mov    0x49d6(%rip),%eax        # 46004 <showing.0>
   4162e:	48 63 d0             	movslq %eax,%rdx
   41631:	48 89 d0             	mov    %rdx,%rax
   41634:	48 c1 e0 04          	shl    $0x4,%rax
   41638:	48 29 d0             	sub    %rdx,%rax
   4163b:	48 c1 e0 04          	shl    $0x4,%rax
   4163f:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41645:	8b 00                	mov    (%rax),%eax
   41647:	85 c0                	test   %eax,%eax
   41649:	74 76                	je     416c1 <memshow_virtual_animate+0x146>
   4164b:	8b 05 b3 49 00 00    	mov    0x49b3(%rip),%eax        # 46004 <showing.0>
   41651:	48 63 d0             	movslq %eax,%rdx
   41654:	48 89 d0             	mov    %rdx,%rax
   41657:	48 c1 e0 04          	shl    $0x4,%rax
   4165b:	48 29 d0             	sub    %rdx,%rax
   4165e:	48 c1 e0 04          	shl    $0x4,%rax
   41662:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41668:	0f b6 00             	movzbl (%rax),%eax
   4166b:	84 c0                	test   %al,%al
   4166d:	74 52                	je     416c1 <memshow_virtual_animate+0x146>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   4166f:	8b 15 8f 49 00 00    	mov    0x498f(%rip),%edx        # 46004 <showing.0>
   41675:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41679:	89 d1                	mov    %edx,%ecx
   4167b:	ba 14 51 04 00       	mov    $0x45114,%edx
   41680:	be 04 00 00 00       	mov    $0x4,%esi
   41685:	48 89 c7             	mov    %rax,%rdi
   41688:	b8 00 00 00 00       	mov    $0x0,%eax
   4168d:	e8 83 35 00 00       	call   44c15 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41692:	8b 05 6c 49 00 00    	mov    0x496c(%rip),%eax        # 46004 <showing.0>
   41698:	48 63 d0             	movslq %eax,%rdx
   4169b:	48 89 d0             	mov    %rdx,%rax
   4169e:	48 c1 e0 04          	shl    $0x4,%rax
   416a2:	48 29 d0             	sub    %rdx,%rax
   416a5:	48 c1 e0 04          	shl    $0x4,%rax
   416a9:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   416af:	48 8b 00             	mov    (%rax),%rax
   416b2:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   416b6:	48 89 d6             	mov    %rdx,%rsi
   416b9:	48 89 c7             	mov    %rax,%rdi
   416bc:	e8 c1 fc ff ff       	call   41382 <memshow_virtual>
    }
}
   416c1:	90                   	nop
   416c2:	c9                   	leave  
   416c3:	c3                   	ret    

00000000000416c4 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   416c4:	55                   	push   %rbp
   416c5:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   416c8:	e8 4f 01 00 00       	call   4181c <segments_init>
    interrupt_init();
   416cd:	e8 d0 03 00 00       	call   41aa2 <interrupt_init>
    virtual_memory_init();
   416d2:	e8 f3 0f 00 00       	call   426ca <virtual_memory_init>
}
   416d7:	90                   	nop
   416d8:	5d                   	pop    %rbp
   416d9:	c3                   	ret    

00000000000416da <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   416da:	55                   	push   %rbp
   416db:	48 89 e5             	mov    %rsp,%rbp
   416de:	48 83 ec 18          	sub    $0x18,%rsp
   416e2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   416e6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   416ea:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   416ed:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416f0:	48 98                	cltq   
   416f2:	48 c1 e0 2d          	shl    $0x2d,%rax
   416f6:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   416fa:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41701:	90 00 00 
   41704:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41707:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4170b:	48 89 10             	mov    %rdx,(%rax)
}
   4170e:	90                   	nop
   4170f:	c9                   	leave  
   41710:	c3                   	ret    

0000000000041711 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41711:	55                   	push   %rbp
   41712:	48 89 e5             	mov    %rsp,%rbp
   41715:	48 83 ec 28          	sub    $0x28,%rsp
   41719:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4171d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41721:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41724:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41728:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4172c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41730:	48 c1 e0 10          	shl    $0x10,%rax
   41734:	48 89 c2             	mov    %rax,%rdx
   41737:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   4173e:	00 00 00 
   41741:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41744:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41748:	48 c1 e0 20          	shl    $0x20,%rax
   4174c:	48 89 c1             	mov    %rax,%rcx
   4174f:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41756:	00 00 ff 
   41759:	48 21 c8             	and    %rcx,%rax
   4175c:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   4175f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41763:	48 83 e8 01          	sub    $0x1,%rax
   41767:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   4176a:	48 09 d0             	or     %rdx,%rax
        | type
   4176d:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41771:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41774:	48 63 d2             	movslq %edx,%rdx
   41777:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4177b:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   4177e:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41785:	80 00 00 
   41788:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4178b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4178f:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41792:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41796:	48 83 c0 08          	add    $0x8,%rax
   4179a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4179e:	48 c1 ea 20          	shr    $0x20,%rdx
   417a2:	48 89 10             	mov    %rdx,(%rax)
}
   417a5:	90                   	nop
   417a6:	c9                   	leave  
   417a7:	c3                   	ret    

00000000000417a8 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   417a8:	55                   	push   %rbp
   417a9:	48 89 e5             	mov    %rsp,%rbp
   417ac:	48 83 ec 20          	sub    $0x20,%rsp
   417b0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   417b4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   417b8:	89 55 ec             	mov    %edx,-0x14(%rbp)
   417bb:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   417bf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417c3:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   417c6:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   417ca:	8b 55 ec             	mov    -0x14(%rbp),%edx
   417cd:	48 63 d2             	movslq %edx,%rdx
   417d0:	48 c1 e2 2d          	shl    $0x2d,%rdx
   417d4:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   417d7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417db:	48 c1 e0 20          	shl    $0x20,%rax
   417df:	48 89 c1             	mov    %rax,%rcx
   417e2:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   417e9:	00 ff ff 
   417ec:	48 21 c8             	and    %rcx,%rax
   417ef:	48 09 c2             	or     %rax,%rdx
   417f2:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   417f9:	80 00 00 
   417fc:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   417ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41803:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41806:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4180a:	48 c1 e8 20          	shr    $0x20,%rax
   4180e:	48 89 c2             	mov    %rax,%rdx
   41811:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41815:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41819:	90                   	nop
   4181a:	c9                   	leave  
   4181b:	c3                   	ret    

000000000004181c <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   4181c:	55                   	push   %rbp
   4181d:	48 89 e5             	mov    %rsp,%rbp
   41820:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41824:	48 c7 05 11 db 00 00 	movq   $0x0,0xdb11(%rip)        # 4f340 <segments>
   4182b:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   4182f:	ba 00 00 00 00       	mov    $0x0,%edx
   41834:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4183b:	08 20 00 
   4183e:	48 89 c6             	mov    %rax,%rsi
   41841:	bf 48 f3 04 00       	mov    $0x4f348,%edi
   41846:	e8 8f fe ff ff       	call   416da <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   4184b:	ba 03 00 00 00       	mov    $0x3,%edx
   41850:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41857:	08 20 00 
   4185a:	48 89 c6             	mov    %rax,%rsi
   4185d:	bf 50 f3 04 00       	mov    $0x4f350,%edi
   41862:	e8 73 fe ff ff       	call   416da <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41867:	ba 00 00 00 00       	mov    $0x0,%edx
   4186c:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41873:	02 00 00 
   41876:	48 89 c6             	mov    %rax,%rsi
   41879:	bf 58 f3 04 00       	mov    $0x4f358,%edi
   4187e:	e8 57 fe ff ff       	call   416da <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41883:	ba 03 00 00 00       	mov    $0x3,%edx
   41888:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   4188f:	02 00 00 
   41892:	48 89 c6             	mov    %rax,%rsi
   41895:	bf 60 f3 04 00       	mov    $0x4f360,%edi
   4189a:	e8 3b fe ff ff       	call   416da <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   4189f:	b8 80 03 05 00       	mov    $0x50380,%eax
   418a4:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   418aa:	48 89 c1             	mov    %rax,%rcx
   418ad:	ba 00 00 00 00       	mov    $0x0,%edx
   418b2:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   418b9:	09 00 00 
   418bc:	48 89 c6             	mov    %rax,%rsi
   418bf:	bf 68 f3 04 00       	mov    $0x4f368,%edi
   418c4:	e8 48 fe ff ff       	call   41711 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   418c9:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   418cf:	b8 40 f3 04 00       	mov    $0x4f340,%eax
   418d4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   418d8:	ba 60 00 00 00       	mov    $0x60,%edx
   418dd:	be 00 00 00 00       	mov    $0x0,%esi
   418e2:	bf 80 03 05 00       	mov    $0x50380,%edi
   418e7:	e8 66 24 00 00       	call   43d52 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   418ec:	48 c7 05 8d ea 00 00 	movq   $0x80000,0xea8d(%rip)        # 50384 <kernel_task_descriptor+0x4>
   418f3:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   418f7:	ba 00 10 00 00       	mov    $0x1000,%edx
   418fc:	be 00 00 00 00       	mov    $0x0,%esi
   41901:	bf 80 f3 04 00       	mov    $0x4f380,%edi
   41906:	e8 47 24 00 00       	call   43d52 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4190b:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41912:	eb 30                	jmp    41944 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41914:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41919:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4191c:	48 c1 e0 04          	shl    $0x4,%rax
   41920:	48 05 80 f3 04 00    	add    $0x4f380,%rax
   41926:	48 89 d1             	mov    %rdx,%rcx
   41929:	ba 00 00 00 00       	mov    $0x0,%edx
   4192e:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41935:	0e 00 00 
   41938:	48 89 c7             	mov    %rax,%rdi
   4193b:	e8 68 fe ff ff       	call   417a8 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41940:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41944:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   4194b:	76 c7                	jbe    41914 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   4194d:	b8 36 00 04 00       	mov    $0x40036,%eax
   41952:	48 89 c1             	mov    %rax,%rcx
   41955:	ba 00 00 00 00       	mov    $0x0,%edx
   4195a:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41961:	0e 00 00 
   41964:	48 89 c6             	mov    %rax,%rsi
   41967:	bf 80 f5 04 00       	mov    $0x4f580,%edi
   4196c:	e8 37 fe ff ff       	call   417a8 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41971:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41976:	48 89 c1             	mov    %rax,%rcx
   41979:	ba 00 00 00 00       	mov    $0x0,%edx
   4197e:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41985:	0e 00 00 
   41988:	48 89 c6             	mov    %rax,%rsi
   4198b:	bf 50 f4 04 00       	mov    $0x4f450,%edi
   41990:	e8 13 fe ff ff       	call   417a8 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41995:	b8 32 00 04 00       	mov    $0x40032,%eax
   4199a:	48 89 c1             	mov    %rax,%rcx
   4199d:	ba 00 00 00 00       	mov    $0x0,%edx
   419a2:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   419a9:	0e 00 00 
   419ac:	48 89 c6             	mov    %rax,%rsi
   419af:	bf 60 f4 04 00       	mov    $0x4f460,%edi
   419b4:	e8 ef fd ff ff       	call   417a8 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   419b9:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   419c0:	eb 3e                	jmp    41a00 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   419c2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   419c5:	83 e8 30             	sub    $0x30,%eax
   419c8:	89 c0                	mov    %eax,%eax
   419ca:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   419d1:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   419d2:	48 89 c2             	mov    %rax,%rdx
   419d5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   419d8:	48 c1 e0 04          	shl    $0x4,%rax
   419dc:	48 05 80 f3 04 00    	add    $0x4f380,%rax
   419e2:	48 89 d1             	mov    %rdx,%rcx
   419e5:	ba 03 00 00 00       	mov    $0x3,%edx
   419ea:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   419f1:	0e 00 00 
   419f4:	48 89 c7             	mov    %rax,%rdi
   419f7:	e8 ac fd ff ff       	call   417a8 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   419fc:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41a00:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41a04:	76 bc                	jbe    419c2 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41a06:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41a0c:	b8 80 f3 04 00       	mov    $0x4f380,%eax
   41a11:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41a15:	b8 28 00 00 00       	mov    $0x28,%eax
   41a1a:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41a1e:	0f 00 d8             	ltr    %ax
   41a21:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41a25:	0f 20 c0             	mov    %cr0,%rax
   41a28:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41a2c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41a30:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41a33:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41a3a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41a3d:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41a40:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a43:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41a47:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41a4b:	0f 22 c0             	mov    %rax,%cr0
}
   41a4e:	90                   	nop
    lcr0(cr0);
}
   41a4f:	90                   	nop
   41a50:	c9                   	leave  
   41a51:	c3                   	ret    

0000000000041a52 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41a52:	55                   	push   %rbp
   41a53:	48 89 e5             	mov    %rsp,%rbp
   41a56:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41a5a:	0f b7 05 7f e9 00 00 	movzwl 0xe97f(%rip),%eax        # 503e0 <interrupts_enabled>
   41a61:	f7 d0                	not    %eax
   41a63:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41a67:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a6b:	0f b6 c0             	movzbl %al,%eax
   41a6e:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41a75:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a78:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41a7c:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41a7f:	ee                   	out    %al,(%dx)
}
   41a80:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41a81:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a85:	66 c1 e8 08          	shr    $0x8,%ax
   41a89:	0f b6 c0             	movzbl %al,%eax
   41a8c:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41a93:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a96:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41a9a:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41a9d:	ee                   	out    %al,(%dx)
}
   41a9e:	90                   	nop
}
   41a9f:	90                   	nop
   41aa0:	c9                   	leave  
   41aa1:	c3                   	ret    

0000000000041aa2 <interrupt_init>:

void interrupt_init(void) {
   41aa2:	55                   	push   %rbp
   41aa3:	48 89 e5             	mov    %rsp,%rbp
   41aa6:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41aaa:	66 c7 05 2d e9 00 00 	movw   $0x0,0xe92d(%rip)        # 503e0 <interrupts_enabled>
   41ab1:	00 00 
    interrupt_mask();
   41ab3:	e8 9a ff ff ff       	call   41a52 <interrupt_mask>
   41ab8:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41abf:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ac3:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41ac7:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41aca:	ee                   	out    %al,(%dx)
}
   41acb:	90                   	nop
   41acc:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41ad3:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ad7:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41adb:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41ade:	ee                   	out    %al,(%dx)
}
   41adf:	90                   	nop
   41ae0:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41ae7:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aeb:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41aef:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41af2:	ee                   	out    %al,(%dx)
}
   41af3:	90                   	nop
   41af4:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41afb:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aff:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41b03:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41b06:	ee                   	out    %al,(%dx)
}
   41b07:	90                   	nop
   41b08:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41b0f:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b13:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41b17:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41b1a:	ee                   	out    %al,(%dx)
}
   41b1b:	90                   	nop
   41b1c:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41b23:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b27:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41b2b:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41b2e:	ee                   	out    %al,(%dx)
}
   41b2f:	90                   	nop
   41b30:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41b37:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b3b:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41b3f:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41b42:	ee                   	out    %al,(%dx)
}
   41b43:	90                   	nop
   41b44:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41b4b:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b4f:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41b53:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41b56:	ee                   	out    %al,(%dx)
}
   41b57:	90                   	nop
   41b58:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41b5f:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b63:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41b67:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41b6a:	ee                   	out    %al,(%dx)
}
   41b6b:	90                   	nop
   41b6c:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41b73:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b77:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b7b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b7e:	ee                   	out    %al,(%dx)
}
   41b7f:	90                   	nop
   41b80:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41b87:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b8b:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b8f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b92:	ee                   	out    %al,(%dx)
}
   41b93:	90                   	nop
   41b94:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41b9b:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b9f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ba3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ba6:	ee                   	out    %al,(%dx)
}
   41ba7:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41ba8:	e8 a5 fe ff ff       	call   41a52 <interrupt_mask>
}
   41bad:	90                   	nop
   41bae:	c9                   	leave  
   41baf:	c3                   	ret    

0000000000041bb0 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41bb0:	55                   	push   %rbp
   41bb1:	48 89 e5             	mov    %rsp,%rbp
   41bb4:	48 83 ec 28          	sub    $0x28,%rsp
   41bb8:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41bbb:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41bbf:	0f 8e 9e 00 00 00    	jle    41c63 <timer_init+0xb3>
   41bc5:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41bcc:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bd0:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41bd4:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41bd7:	ee                   	out    %al,(%dx)
}
   41bd8:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41bd9:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41bdc:	89 c2                	mov    %eax,%edx
   41bde:	c1 ea 1f             	shr    $0x1f,%edx
   41be1:	01 d0                	add    %edx,%eax
   41be3:	d1 f8                	sar    %eax
   41be5:	05 de 34 12 00       	add    $0x1234de,%eax
   41bea:	99                   	cltd   
   41beb:	f7 7d dc             	idivl  -0x24(%rbp)
   41bee:	89 c2                	mov    %eax,%edx
   41bf0:	89 d0                	mov    %edx,%eax
   41bf2:	c1 f8 1f             	sar    $0x1f,%eax
   41bf5:	c1 e8 18             	shr    $0x18,%eax
   41bf8:	01 c2                	add    %eax,%edx
   41bfa:	0f b6 d2             	movzbl %dl,%edx
   41bfd:	29 c2                	sub    %eax,%edx
   41bff:	89 d0                	mov    %edx,%eax
   41c01:	0f b6 c0             	movzbl %al,%eax
   41c04:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41c0b:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c0e:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41c12:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c15:	ee                   	out    %al,(%dx)
}
   41c16:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41c17:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c1a:	89 c2                	mov    %eax,%edx
   41c1c:	c1 ea 1f             	shr    $0x1f,%edx
   41c1f:	01 d0                	add    %edx,%eax
   41c21:	d1 f8                	sar    %eax
   41c23:	05 de 34 12 00       	add    $0x1234de,%eax
   41c28:	99                   	cltd   
   41c29:	f7 7d dc             	idivl  -0x24(%rbp)
   41c2c:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41c32:	85 c0                	test   %eax,%eax
   41c34:	0f 48 c2             	cmovs  %edx,%eax
   41c37:	c1 f8 08             	sar    $0x8,%eax
   41c3a:	0f b6 c0             	movzbl %al,%eax
   41c3d:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41c44:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c47:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c4b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c4e:	ee                   	out    %al,(%dx)
}
   41c4f:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41c50:	0f b7 05 89 e7 00 00 	movzwl 0xe789(%rip),%eax        # 503e0 <interrupts_enabled>
   41c57:	83 c8 01             	or     $0x1,%eax
   41c5a:	66 89 05 7f e7 00 00 	mov    %ax,0xe77f(%rip)        # 503e0 <interrupts_enabled>
   41c61:	eb 11                	jmp    41c74 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41c63:	0f b7 05 76 e7 00 00 	movzwl 0xe776(%rip),%eax        # 503e0 <interrupts_enabled>
   41c6a:	83 e0 fe             	and    $0xfffffffe,%eax
   41c6d:	66 89 05 6c e7 00 00 	mov    %ax,0xe76c(%rip)        # 503e0 <interrupts_enabled>
    }
    interrupt_mask();
   41c74:	e8 d9 fd ff ff       	call   41a52 <interrupt_mask>
}
   41c79:	90                   	nop
   41c7a:	c9                   	leave  
   41c7b:	c3                   	ret    

0000000000041c7c <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41c7c:	55                   	push   %rbp
   41c7d:	48 89 e5             	mov    %rsp,%rbp
   41c80:	48 83 ec 08          	sub    $0x8,%rsp
   41c84:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41c88:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41c8d:	74 14                	je     41ca3 <physical_memory_isreserved+0x27>
   41c8f:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41c96:	00 
   41c97:	76 11                	jbe    41caa <physical_memory_isreserved+0x2e>
   41c99:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41ca0:	00 
   41ca1:	77 07                	ja     41caa <physical_memory_isreserved+0x2e>
   41ca3:	b8 01 00 00 00       	mov    $0x1,%eax
   41ca8:	eb 05                	jmp    41caf <physical_memory_isreserved+0x33>
   41caa:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41caf:	c9                   	leave  
   41cb0:	c3                   	ret    

0000000000041cb1 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41cb1:	55                   	push   %rbp
   41cb2:	48 89 e5             	mov    %rsp,%rbp
   41cb5:	48 83 ec 10          	sub    $0x10,%rsp
   41cb9:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41cbc:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41cbf:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41cc2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41cc5:	c1 e0 10             	shl    $0x10,%eax
   41cc8:	89 c2                	mov    %eax,%edx
   41cca:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ccd:	c1 e0 0b             	shl    $0xb,%eax
   41cd0:	09 c2                	or     %eax,%edx
   41cd2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41cd5:	c1 e0 08             	shl    $0x8,%eax
   41cd8:	09 d0                	or     %edx,%eax
}
   41cda:	c9                   	leave  
   41cdb:	c3                   	ret    

0000000000041cdc <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41cdc:	55                   	push   %rbp
   41cdd:	48 89 e5             	mov    %rsp,%rbp
   41ce0:	48 83 ec 18          	sub    $0x18,%rsp
   41ce4:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41ce7:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41cea:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ced:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41cf0:	09 d0                	or     %edx,%eax
   41cf2:	0d 00 00 00 80       	or     $0x80000000,%eax
   41cf7:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41cfe:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41d01:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d04:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d07:	ef                   	out    %eax,(%dx)
}
   41d08:	90                   	nop
   41d09:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41d10:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d13:	89 c2                	mov    %eax,%edx
   41d15:	ed                   	in     (%dx),%eax
   41d16:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41d19:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41d1c:	c9                   	leave  
   41d1d:	c3                   	ret    

0000000000041d1e <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41d1e:	55                   	push   %rbp
   41d1f:	48 89 e5             	mov    %rsp,%rbp
   41d22:	48 83 ec 28          	sub    $0x28,%rsp
   41d26:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41d29:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41d2c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41d33:	eb 73                	jmp    41da8 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41d35:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41d3c:	eb 60                	jmp    41d9e <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41d3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41d45:	eb 4a                	jmp    41d91 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41d47:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d4a:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41d4d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d50:	89 ce                	mov    %ecx,%esi
   41d52:	89 c7                	mov    %eax,%edi
   41d54:	e8 58 ff ff ff       	call   41cb1 <pci_make_configaddr>
   41d59:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41d5c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d5f:	be 00 00 00 00       	mov    $0x0,%esi
   41d64:	89 c7                	mov    %eax,%edi
   41d66:	e8 71 ff ff ff       	call   41cdc <pci_config_readl>
   41d6b:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41d6e:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41d71:	c1 e0 10             	shl    $0x10,%eax
   41d74:	0b 45 dc             	or     -0x24(%rbp),%eax
   41d77:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41d7a:	75 05                	jne    41d81 <pci_find_device+0x63>
                    return configaddr;
   41d7c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d7f:	eb 35                	jmp    41db6 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41d81:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41d85:	75 06                	jne    41d8d <pci_find_device+0x6f>
   41d87:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41d8b:	74 0c                	je     41d99 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41d8d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41d91:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41d95:	75 b0                	jne    41d47 <pci_find_device+0x29>
   41d97:	eb 01                	jmp    41d9a <pci_find_device+0x7c>
                    break;
   41d99:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41d9a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41d9e:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41da2:	75 9a                	jne    41d3e <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41da4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41da8:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41daf:	75 84                	jne    41d35 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41db6:	c9                   	leave  
   41db7:	c3                   	ret    

0000000000041db8 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41db8:	55                   	push   %rbp
   41db9:	48 89 e5             	mov    %rsp,%rbp
   41dbc:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41dc0:	be 13 71 00 00       	mov    $0x7113,%esi
   41dc5:	bf 86 80 00 00       	mov    $0x8086,%edi
   41dca:	e8 4f ff ff ff       	call   41d1e <pci_find_device>
   41dcf:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41dd2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41dd6:	78 30                	js     41e08 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41dd8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ddb:	be 40 00 00 00       	mov    $0x40,%esi
   41de0:	89 c7                	mov    %eax,%edi
   41de2:	e8 f5 fe ff ff       	call   41cdc <pci_config_readl>
   41de7:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41dec:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41def:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41df2:	83 c0 04             	add    $0x4,%eax
   41df5:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41df8:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41dfe:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41e02:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e05:	66 ef                	out    %ax,(%dx)
}
   41e07:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41e08:	ba 20 51 04 00       	mov    $0x45120,%edx
   41e0d:	be 00 c0 00 00       	mov    $0xc000,%esi
   41e12:	bf 80 07 00 00       	mov    $0x780,%edi
   41e17:	b8 00 00 00 00       	mov    $0x0,%eax
   41e1c:	e8 e8 2c 00 00       	call   44b09 <console_printf>
 spinloop: goto spinloop;
   41e21:	eb fe                	jmp    41e21 <poweroff+0x69>

0000000000041e23 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41e23:	55                   	push   %rbp
   41e24:	48 89 e5             	mov    %rsp,%rbp
   41e27:	48 83 ec 10          	sub    $0x10,%rsp
   41e2b:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41e32:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e36:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e3a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e3d:	ee                   	out    %al,(%dx)
}
   41e3e:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41e3f:	eb fe                	jmp    41e3f <reboot+0x1c>

0000000000041e41 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41e41:	55                   	push   %rbp
   41e42:	48 89 e5             	mov    %rsp,%rbp
   41e45:	48 83 ec 10          	sub    $0x10,%rsp
   41e49:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e4d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41e50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e54:	48 83 c0 18          	add    $0x18,%rax
   41e58:	ba c0 00 00 00       	mov    $0xc0,%edx
   41e5d:	be 00 00 00 00       	mov    $0x0,%esi
   41e62:	48 89 c7             	mov    %rax,%rdi
   41e65:	e8 e8 1e 00 00       	call   43d52 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41e6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e6e:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41e75:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41e77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e7b:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41e82:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41e86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e8a:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41e91:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41e95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e99:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41ea0:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41ea2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ea6:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41ead:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41eb1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41eb4:	83 e0 01             	and    $0x1,%eax
   41eb7:	85 c0                	test   %eax,%eax
   41eb9:	74 1c                	je     41ed7 <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41ebb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ebf:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41ec6:	80 cc 30             	or     $0x30,%ah
   41ec9:	48 89 c2             	mov    %rax,%rdx
   41ecc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ed0:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41ed7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41eda:	83 e0 02             	and    $0x2,%eax
   41edd:	85 c0                	test   %eax,%eax
   41edf:	74 1c                	je     41efd <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41ee1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ee5:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41eec:	80 e4 fd             	and    $0xfd,%ah
   41eef:	48 89 c2             	mov    %rax,%rdx
   41ef2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ef6:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41efd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f01:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41f08:	90                   	nop
   41f09:	c9                   	leave  
   41f0a:	c3                   	ret    

0000000000041f0b <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41f0b:	55                   	push   %rbp
   41f0c:	48 89 e5             	mov    %rsp,%rbp
   41f0f:	48 83 ec 28          	sub    $0x28,%rsp
   41f13:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41f16:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41f1a:	78 09                	js     41f25 <console_show_cursor+0x1a>
   41f1c:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41f23:	7e 07                	jle    41f2c <console_show_cursor+0x21>
        cpos = 0;
   41f25:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41f2c:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41f33:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f37:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41f3b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41f3e:	ee                   	out    %al,(%dx)
}
   41f3f:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41f40:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f43:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41f49:	85 c0                	test   %eax,%eax
   41f4b:	0f 48 c2             	cmovs  %edx,%eax
   41f4e:	c1 f8 08             	sar    $0x8,%eax
   41f51:	0f b6 c0             	movzbl %al,%eax
   41f54:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41f5b:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f5e:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41f62:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f65:	ee                   	out    %al,(%dx)
}
   41f66:	90                   	nop
   41f67:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41f6e:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f72:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41f76:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f79:	ee                   	out    %al,(%dx)
}
   41f7a:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41f7b:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41f7e:	89 d0                	mov    %edx,%eax
   41f80:	c1 f8 1f             	sar    $0x1f,%eax
   41f83:	c1 e8 18             	shr    $0x18,%eax
   41f86:	01 c2                	add    %eax,%edx
   41f88:	0f b6 d2             	movzbl %dl,%edx
   41f8b:	29 c2                	sub    %eax,%edx
   41f8d:	89 d0                	mov    %edx,%eax
   41f8f:	0f b6 c0             	movzbl %al,%eax
   41f92:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41f99:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f9c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fa0:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41fa3:	ee                   	out    %al,(%dx)
}
   41fa4:	90                   	nop
}
   41fa5:	90                   	nop
   41fa6:	c9                   	leave  
   41fa7:	c3                   	ret    

0000000000041fa8 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41fa8:	55                   	push   %rbp
   41fa9:	48 89 e5             	mov    %rsp,%rbp
   41fac:	48 83 ec 20          	sub    $0x20,%rsp
   41fb0:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41fb7:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fba:	89 c2                	mov    %eax,%edx
   41fbc:	ec                   	in     (%dx),%al
   41fbd:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41fc0:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41fc4:	0f b6 c0             	movzbl %al,%eax
   41fc7:	83 e0 01             	and    $0x1,%eax
   41fca:	85 c0                	test   %eax,%eax
   41fcc:	75 0a                	jne    41fd8 <keyboard_readc+0x30>
        return -1;
   41fce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41fd3:	e9 e7 01 00 00       	jmp    421bf <keyboard_readc+0x217>
   41fd8:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41fdf:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41fe2:	89 c2                	mov    %eax,%edx
   41fe4:	ec                   	in     (%dx),%al
   41fe5:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41fe8:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41fec:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41fef:	0f b6 05 ec e3 00 00 	movzbl 0xe3ec(%rip),%eax        # 503e2 <last_escape.2>
   41ff6:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41ff9:	c6 05 e2 e3 00 00 00 	movb   $0x0,0xe3e2(%rip)        # 503e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42000:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42004:	75 11                	jne    42017 <keyboard_readc+0x6f>
        last_escape = 0x80;
   42006:	c6 05 d5 e3 00 00 80 	movb   $0x80,0xe3d5(%rip)        # 503e2 <last_escape.2>
        return 0;
   4200d:	b8 00 00 00 00       	mov    $0x0,%eax
   42012:	e9 a8 01 00 00       	jmp    421bf <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42017:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4201b:	84 c0                	test   %al,%al
   4201d:	79 60                	jns    4207f <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   4201f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42023:	83 e0 7f             	and    $0x7f,%eax
   42026:	89 c2                	mov    %eax,%edx
   42028:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   4202c:	09 d0                	or     %edx,%eax
   4202e:	48 98                	cltq   
   42030:	0f b6 80 40 51 04 00 	movzbl 0x45140(%rax),%eax
   42037:	0f b6 c0             	movzbl %al,%eax
   4203a:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   4203d:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42044:	7e 2f                	jle    42075 <keyboard_readc+0xcd>
   42046:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   4204d:	7f 26                	jg     42075 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   4204f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42052:	2d fa 00 00 00       	sub    $0xfa,%eax
   42057:	ba 01 00 00 00       	mov    $0x1,%edx
   4205c:	89 c1                	mov    %eax,%ecx
   4205e:	d3 e2                	shl    %cl,%edx
   42060:	89 d0                	mov    %edx,%eax
   42062:	f7 d0                	not    %eax
   42064:	89 c2                	mov    %eax,%edx
   42066:	0f b6 05 76 e3 00 00 	movzbl 0xe376(%rip),%eax        # 503e3 <modifiers.1>
   4206d:	21 d0                	and    %edx,%eax
   4206f:	88 05 6e e3 00 00    	mov    %al,0xe36e(%rip)        # 503e3 <modifiers.1>
        }
        return 0;
   42075:	b8 00 00 00 00       	mov    $0x0,%eax
   4207a:	e9 40 01 00 00       	jmp    421bf <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   4207f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42083:	0a 45 fa             	or     -0x6(%rbp),%al
   42086:	0f b6 c0             	movzbl %al,%eax
   42089:	48 98                	cltq   
   4208b:	0f b6 80 40 51 04 00 	movzbl 0x45140(%rax),%eax
   42092:	0f b6 c0             	movzbl %al,%eax
   42095:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42098:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4209c:	7e 57                	jle    420f5 <keyboard_readc+0x14d>
   4209e:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   420a2:	7f 51                	jg     420f5 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   420a4:	0f b6 05 38 e3 00 00 	movzbl 0xe338(%rip),%eax        # 503e3 <modifiers.1>
   420ab:	0f b6 c0             	movzbl %al,%eax
   420ae:	83 e0 02             	and    $0x2,%eax
   420b1:	85 c0                	test   %eax,%eax
   420b3:	74 09                	je     420be <keyboard_readc+0x116>
            ch -= 0x60;
   420b5:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   420b9:	e9 fd 00 00 00       	jmp    421bb <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   420be:	0f b6 05 1e e3 00 00 	movzbl 0xe31e(%rip),%eax        # 503e3 <modifiers.1>
   420c5:	0f b6 c0             	movzbl %al,%eax
   420c8:	83 e0 01             	and    $0x1,%eax
   420cb:	85 c0                	test   %eax,%eax
   420cd:	0f 94 c2             	sete   %dl
   420d0:	0f b6 05 0c e3 00 00 	movzbl 0xe30c(%rip),%eax        # 503e3 <modifiers.1>
   420d7:	0f b6 c0             	movzbl %al,%eax
   420da:	83 e0 08             	and    $0x8,%eax
   420dd:	85 c0                	test   %eax,%eax
   420df:	0f 94 c0             	sete   %al
   420e2:	31 d0                	xor    %edx,%eax
   420e4:	84 c0                	test   %al,%al
   420e6:	0f 84 cf 00 00 00    	je     421bb <keyboard_readc+0x213>
            ch -= 0x20;
   420ec:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   420f0:	e9 c6 00 00 00       	jmp    421bb <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   420f5:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   420fc:	7e 30                	jle    4212e <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   420fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42101:	2d fa 00 00 00       	sub    $0xfa,%eax
   42106:	ba 01 00 00 00       	mov    $0x1,%edx
   4210b:	89 c1                	mov    %eax,%ecx
   4210d:	d3 e2                	shl    %cl,%edx
   4210f:	89 d0                	mov    %edx,%eax
   42111:	89 c2                	mov    %eax,%edx
   42113:	0f b6 05 c9 e2 00 00 	movzbl 0xe2c9(%rip),%eax        # 503e3 <modifiers.1>
   4211a:	31 d0                	xor    %edx,%eax
   4211c:	88 05 c1 e2 00 00    	mov    %al,0xe2c1(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   42122:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42129:	e9 8e 00 00 00       	jmp    421bc <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   4212e:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42135:	7e 2d                	jle    42164 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42137:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4213a:	2d fa 00 00 00       	sub    $0xfa,%eax
   4213f:	ba 01 00 00 00       	mov    $0x1,%edx
   42144:	89 c1                	mov    %eax,%ecx
   42146:	d3 e2                	shl    %cl,%edx
   42148:	89 d0                	mov    %edx,%eax
   4214a:	89 c2                	mov    %eax,%edx
   4214c:	0f b6 05 90 e2 00 00 	movzbl 0xe290(%rip),%eax        # 503e3 <modifiers.1>
   42153:	09 d0                	or     %edx,%eax
   42155:	88 05 88 e2 00 00    	mov    %al,0xe288(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   4215b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42162:	eb 58                	jmp    421bc <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42164:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42168:	7e 31                	jle    4219b <keyboard_readc+0x1f3>
   4216a:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42171:	7f 28                	jg     4219b <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42173:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42176:	8d 50 80             	lea    -0x80(%rax),%edx
   42179:	0f b6 05 63 e2 00 00 	movzbl 0xe263(%rip),%eax        # 503e3 <modifiers.1>
   42180:	0f b6 c0             	movzbl %al,%eax
   42183:	83 e0 03             	and    $0x3,%eax
   42186:	48 98                	cltq   
   42188:	48 63 d2             	movslq %edx,%rdx
   4218b:	0f b6 84 90 40 52 04 	movzbl 0x45240(%rax,%rdx,4),%eax
   42192:	00 
   42193:	0f b6 c0             	movzbl %al,%eax
   42196:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42199:	eb 21                	jmp    421bc <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   4219b:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4219f:	7f 1b                	jg     421bc <keyboard_readc+0x214>
   421a1:	0f b6 05 3b e2 00 00 	movzbl 0xe23b(%rip),%eax        # 503e3 <modifiers.1>
   421a8:	0f b6 c0             	movzbl %al,%eax
   421ab:	83 e0 02             	and    $0x2,%eax
   421ae:	85 c0                	test   %eax,%eax
   421b0:	74 0a                	je     421bc <keyboard_readc+0x214>
        ch = 0;
   421b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421b9:	eb 01                	jmp    421bc <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   421bb:	90                   	nop
    }

    return ch;
   421bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   421bf:	c9                   	leave  
   421c0:	c3                   	ret    

00000000000421c1 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   421c1:	55                   	push   %rbp
   421c2:	48 89 e5             	mov    %rsp,%rbp
   421c5:	48 83 ec 20          	sub    $0x20,%rsp
   421c9:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421d0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   421d3:	89 c2                	mov    %eax,%edx
   421d5:	ec                   	in     (%dx),%al
   421d6:	88 45 e3             	mov    %al,-0x1d(%rbp)
   421d9:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   421e0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   421e3:	89 c2                	mov    %eax,%edx
   421e5:	ec                   	in     (%dx),%al
   421e6:	88 45 eb             	mov    %al,-0x15(%rbp)
   421e9:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   421f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   421f3:	89 c2                	mov    %eax,%edx
   421f5:	ec                   	in     (%dx),%al
   421f6:	88 45 f3             	mov    %al,-0xd(%rbp)
   421f9:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42200:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42203:	89 c2                	mov    %eax,%edx
   42205:	ec                   	in     (%dx),%al
   42206:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42209:	90                   	nop
   4220a:	c9                   	leave  
   4220b:	c3                   	ret    

000000000004220c <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4220c:	55                   	push   %rbp
   4220d:	48 89 e5             	mov    %rsp,%rbp
   42210:	48 83 ec 40          	sub    $0x40,%rsp
   42214:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42218:	89 f0                	mov    %esi,%eax
   4221a:	89 55 c0             	mov    %edx,-0x40(%rbp)
   4221d:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42220:	8b 05 be e1 00 00    	mov    0xe1be(%rip),%eax        # 503e4 <initialized.0>
   42226:	85 c0                	test   %eax,%eax
   42228:	75 1e                	jne    42248 <parallel_port_putc+0x3c>
   4222a:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42231:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42235:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42239:	8b 55 f8             	mov    -0x8(%rbp),%edx
   4223c:	ee                   	out    %al,(%dx)
}
   4223d:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   4223e:	c7 05 9c e1 00 00 01 	movl   $0x1,0xe19c(%rip)        # 503e4 <initialized.0>
   42245:	00 00 00 
    }

    for (int i = 0;
   42248:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4224f:	eb 09                	jmp    4225a <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42251:	e8 6b ff ff ff       	call   421c1 <delay>
         ++i) {
   42256:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   4225a:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42261:	7f 18                	jg     4227b <parallel_port_putc+0x6f>
   42263:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4226a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4226d:	89 c2                	mov    %eax,%edx
   4226f:	ec                   	in     (%dx),%al
   42270:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42273:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42277:	84 c0                	test   %al,%al
   42279:	79 d6                	jns    42251 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   4227b:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   4227f:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42286:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42289:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   4228d:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42290:	ee                   	out    %al,(%dx)
}
   42291:	90                   	nop
   42292:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42299:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4229d:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   422a1:	8b 55 e0             	mov    -0x20(%rbp),%edx
   422a4:	ee                   	out    %al,(%dx)
}
   422a5:	90                   	nop
   422a6:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   422ad:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422b1:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   422b5:	8b 55 e8             	mov    -0x18(%rbp),%edx
   422b8:	ee                   	out    %al,(%dx)
}
   422b9:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   422ba:	90                   	nop
   422bb:	c9                   	leave  
   422bc:	c3                   	ret    

00000000000422bd <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   422bd:	55                   	push   %rbp
   422be:	48 89 e5             	mov    %rsp,%rbp
   422c1:	48 83 ec 20          	sub    $0x20,%rsp
   422c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   422c9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   422cd:	48 c7 45 f8 0c 22 04 	movq   $0x4220c,-0x8(%rbp)
   422d4:	00 
    printer_vprintf(&p, 0, format, val);
   422d5:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   422d9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   422dd:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   422e1:	be 00 00 00 00       	mov    $0x0,%esi
   422e6:	48 89 c7             	mov    %rax,%rdi
   422e9:	e8 00 1d 00 00       	call   43fee <printer_vprintf>
}
   422ee:	90                   	nop
   422ef:	c9                   	leave  
   422f0:	c3                   	ret    

00000000000422f1 <log_printf>:

void log_printf(const char* format, ...) {
   422f1:	55                   	push   %rbp
   422f2:	48 89 e5             	mov    %rsp,%rbp
   422f5:	48 83 ec 60          	sub    $0x60,%rsp
   422f9:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   422fd:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42301:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42305:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42309:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4230d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42311:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42318:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4231c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42320:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42324:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42328:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4232c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42330:	48 89 d6             	mov    %rdx,%rsi
   42333:	48 89 c7             	mov    %rax,%rdi
   42336:	e8 82 ff ff ff       	call   422bd <log_vprintf>
    va_end(val);
}
   4233b:	90                   	nop
   4233c:	c9                   	leave  
   4233d:	c3                   	ret    

000000000004233e <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   4233e:	55                   	push   %rbp
   4233f:	48 89 e5             	mov    %rsp,%rbp
   42342:	48 83 ec 40          	sub    $0x40,%rsp
   42346:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42349:	89 75 d8             	mov    %esi,-0x28(%rbp)
   4234c:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42350:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42354:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42358:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4235c:	48 8b 0a             	mov    (%rdx),%rcx
   4235f:	48 89 08             	mov    %rcx,(%rax)
   42362:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42366:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4236a:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   4236e:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42372:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42376:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4237a:	48 89 d6             	mov    %rdx,%rsi
   4237d:	48 89 c7             	mov    %rax,%rdi
   42380:	e8 38 ff ff ff       	call   422bd <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42385:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42389:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4238d:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42390:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42393:	89 c7                	mov    %eax,%edi
   42395:	e8 03 27 00 00       	call   44a9d <console_vprintf>
}
   4239a:	c9                   	leave  
   4239b:	c3                   	ret    

000000000004239c <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   4239c:	55                   	push   %rbp
   4239d:	48 89 e5             	mov    %rsp,%rbp
   423a0:	48 83 ec 60          	sub    $0x60,%rsp
   423a4:	89 7d ac             	mov    %edi,-0x54(%rbp)
   423a7:	89 75 a8             	mov    %esi,-0x58(%rbp)
   423aa:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   423ae:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   423b2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   423b6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   423ba:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   423c1:	48 8d 45 10          	lea    0x10(%rbp),%rax
   423c5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   423c9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   423cd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   423d1:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   423d5:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   423d9:	8b 75 a8             	mov    -0x58(%rbp),%esi
   423dc:	8b 45 ac             	mov    -0x54(%rbp),%eax
   423df:	89 c7                	mov    %eax,%edi
   423e1:	e8 58 ff ff ff       	call   4233e <error_vprintf>
   423e6:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   423e9:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   423ec:	c9                   	leave  
   423ed:	c3                   	ret    

00000000000423ee <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   423ee:	55                   	push   %rbp
   423ef:	48 89 e5             	mov    %rsp,%rbp
   423f2:	53                   	push   %rbx
   423f3:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   423f7:	e8 ac fb ff ff       	call   41fa8 <keyboard_readc>
   423fc:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   423ff:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42403:	74 1c                	je     42421 <check_keyboard+0x33>
   42405:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   42409:	74 16                	je     42421 <check_keyboard+0x33>
   4240b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   4240f:	74 10                	je     42421 <check_keyboard+0x33>
   42411:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42415:	74 0a                	je     42421 <check_keyboard+0x33>
   42417:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4241b:	0f 85 e9 00 00 00    	jne    4250a <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42421:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42428:	00 
        memset(pt, 0, PAGESIZE * 3);
   42429:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4242d:	ba 00 30 00 00       	mov    $0x3000,%edx
   42432:	be 00 00 00 00       	mov    $0x0,%esi
   42437:	48 89 c7             	mov    %rax,%rdi
   4243a:	e8 13 19 00 00       	call   43d52 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   4243f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42443:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   4244a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4244e:	48 05 00 10 00 00    	add    $0x1000,%rax
   42454:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   4245b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4245f:	48 05 00 20 00 00    	add    $0x2000,%rax
   42465:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   4246c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42470:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42474:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42478:	0f 22 d8             	mov    %rax,%cr3
}
   4247b:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   4247c:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   42483:	48 c7 45 e8 98 52 04 	movq   $0x45298,-0x18(%rbp)
   4248a:	00 
        if (c == 'a') {
   4248b:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4248f:	75 0a                	jne    4249b <check_keyboard+0xad>
            argument = "allocator";
   42491:	48 c7 45 e8 9f 52 04 	movq   $0x4529f,-0x18(%rbp)
   42498:	00 
   42499:	eb 2e                	jmp    424c9 <check_keyboard+0xdb>
        } else if (c == 'c') {
   4249b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   4249f:	75 0a                	jne    424ab <check_keyboard+0xbd>
            argument = "alloctests";
   424a1:	48 c7 45 e8 a9 52 04 	movq   $0x452a9,-0x18(%rbp)
   424a8:	00 
   424a9:	eb 1e                	jmp    424c9 <check_keyboard+0xdb>
        } else if(c == 't'){
   424ab:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   424af:	75 0a                	jne    424bb <check_keyboard+0xcd>
            argument = "test";
   424b1:	48 c7 45 e8 b4 52 04 	movq   $0x452b4,-0x18(%rbp)
   424b8:	00 
   424b9:	eb 0e                	jmp    424c9 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   424bb:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   424bf:	75 08                	jne    424c9 <check_keyboard+0xdb>
            argument = "test2";
   424c1:	48 c7 45 e8 b9 52 04 	movq   $0x452b9,-0x18(%rbp)
   424c8:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   424c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   424cd:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   424d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   424d6:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   424da:	73 14                	jae    424f0 <check_keyboard+0x102>
   424dc:	ba bf 52 04 00       	mov    $0x452bf,%edx
   424e1:	be 5c 02 00 00       	mov    $0x25c,%esi
   424e6:	bf db 52 04 00       	mov    $0x452db,%edi
   424eb:	e8 1f 01 00 00       	call   4260f <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   424f0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   424f4:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   424f7:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   424fb:	48 89 c3             	mov    %rax,%rbx
   424fe:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42503:	e9 f8 da ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42508:	eb 11                	jmp    4251b <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   4250a:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   4250e:	74 06                	je     42516 <check_keyboard+0x128>
   42510:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42514:	75 05                	jne    4251b <check_keyboard+0x12d>
        poweroff();
   42516:	e8 9d f8 ff ff       	call   41db8 <poweroff>
    }
    return c;
   4251b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   4251e:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42522:	c9                   	leave  
   42523:	c3                   	ret    

0000000000042524 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42524:	55                   	push   %rbp
   42525:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42528:	e8 c1 fe ff ff       	call   423ee <check_keyboard>
   4252d:	eb f9                	jmp    42528 <fail+0x4>

000000000004252f <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   4252f:	55                   	push   %rbp
   42530:	48 89 e5             	mov    %rsp,%rbp
   42533:	48 83 ec 60          	sub    $0x60,%rsp
   42537:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4253b:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4253f:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42543:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42547:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4254b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4254f:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42556:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4255a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   4255e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42562:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42566:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   4256b:	0f 84 80 00 00 00    	je     425f1 <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42571:	ba ef 52 04 00       	mov    $0x452ef,%edx
   42576:	be 00 c0 00 00       	mov    $0xc000,%esi
   4257b:	bf 30 07 00 00       	mov    $0x730,%edi
   42580:	b8 00 00 00 00       	mov    $0x0,%eax
   42585:	e8 12 fe ff ff       	call   4239c <error_printf>
   4258a:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   4258d:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42591:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42595:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42598:	be 00 c0 00 00       	mov    $0xc000,%esi
   4259d:	89 c7                	mov    %eax,%edi
   4259f:	e8 9a fd ff ff       	call   4233e <error_vprintf>
   425a4:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   425a7:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   425aa:	48 63 c1             	movslq %ecx,%rax
   425ad:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   425b4:	48 c1 e8 20          	shr    $0x20,%rax
   425b8:	89 c2                	mov    %eax,%edx
   425ba:	c1 fa 05             	sar    $0x5,%edx
   425bd:	89 c8                	mov    %ecx,%eax
   425bf:	c1 f8 1f             	sar    $0x1f,%eax
   425c2:	29 c2                	sub    %eax,%edx
   425c4:	89 d0                	mov    %edx,%eax
   425c6:	c1 e0 02             	shl    $0x2,%eax
   425c9:	01 d0                	add    %edx,%eax
   425cb:	c1 e0 04             	shl    $0x4,%eax
   425ce:	29 c1                	sub    %eax,%ecx
   425d0:	89 ca                	mov    %ecx,%edx
   425d2:	85 d2                	test   %edx,%edx
   425d4:	74 34                	je     4260a <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   425d6:	8b 45 cc             	mov    -0x34(%rbp),%eax
   425d9:	ba f7 52 04 00       	mov    $0x452f7,%edx
   425de:	be 00 c0 00 00       	mov    $0xc000,%esi
   425e3:	89 c7                	mov    %eax,%edi
   425e5:	b8 00 00 00 00       	mov    $0x0,%eax
   425ea:	e8 ad fd ff ff       	call   4239c <error_printf>
   425ef:	eb 19                	jmp    4260a <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   425f1:	ba f9 52 04 00       	mov    $0x452f9,%edx
   425f6:	be 00 c0 00 00       	mov    $0xc000,%esi
   425fb:	bf 30 07 00 00       	mov    $0x730,%edi
   42600:	b8 00 00 00 00       	mov    $0x0,%eax
   42605:	e8 92 fd ff ff       	call   4239c <error_printf>
    }

    va_end(val);
    fail();
   4260a:	e8 15 ff ff ff       	call   42524 <fail>

000000000004260f <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   4260f:	55                   	push   %rbp
   42610:	48 89 e5             	mov    %rsp,%rbp
   42613:	48 83 ec 20          	sub    $0x20,%rsp
   42617:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4261b:	89 75 f4             	mov    %esi,-0xc(%rbp)
   4261e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42622:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42626:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42629:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4262d:	48 89 c6             	mov    %rax,%rsi
   42630:	bf ff 52 04 00       	mov    $0x452ff,%edi
   42635:	b8 00 00 00 00       	mov    $0x0,%eax
   4263a:	e8 f0 fe ff ff       	call   4252f <kernel_panic>

000000000004263f <default_exception>:
}

void default_exception(proc* p){
   4263f:	55                   	push   %rbp
   42640:	48 89 e5             	mov    %rsp,%rbp
   42643:	48 83 ec 20          	sub    $0x20,%rsp
   42647:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   4264b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4264f:	48 83 c0 18          	add    $0x18,%rax
   42653:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   42657:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4265b:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42662:	48 89 c6             	mov    %rax,%rsi
   42665:	bf 1d 53 04 00       	mov    $0x4531d,%edi
   4266a:	b8 00 00 00 00       	mov    $0x0,%eax
   4266f:	e8 bb fe ff ff       	call   4252f <kernel_panic>

0000000000042674 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42674:	55                   	push   %rbp
   42675:	48 89 e5             	mov    %rsp,%rbp
   42678:	48 83 ec 10          	sub    $0x10,%rsp
   4267c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42680:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42683:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42687:	78 06                	js     4268f <pageindex+0x1b>
   42689:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   4268d:	7e 14                	jle    426a3 <pageindex+0x2f>
   4268f:	ba 38 53 04 00       	mov    $0x45338,%edx
   42694:	be 1e 00 00 00       	mov    $0x1e,%esi
   42699:	bf 51 53 04 00       	mov    $0x45351,%edi
   4269e:	e8 6c ff ff ff       	call   4260f <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   426a3:	b8 03 00 00 00       	mov    $0x3,%eax
   426a8:	2b 45 f4             	sub    -0xc(%rbp),%eax
   426ab:	89 c2                	mov    %eax,%edx
   426ad:	89 d0                	mov    %edx,%eax
   426af:	c1 e0 03             	shl    $0x3,%eax
   426b2:	01 d0                	add    %edx,%eax
   426b4:	83 c0 0c             	add    $0xc,%eax
   426b7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   426bb:	89 c1                	mov    %eax,%ecx
   426bd:	48 d3 ea             	shr    %cl,%rdx
   426c0:	48 89 d0             	mov    %rdx,%rax
   426c3:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   426c8:	c9                   	leave  
   426c9:	c3                   	ret    

00000000000426ca <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   426ca:	55                   	push   %rbp
   426cb:	48 89 e5             	mov    %rsp,%rbp
   426ce:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   426d2:	48 c7 05 23 e9 00 00 	movq   $0x52000,0xe923(%rip)        # 51000 <kernel_pagetable>
   426d9:	00 20 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   426dd:	ba 00 50 00 00       	mov    $0x5000,%edx
   426e2:	be 00 00 00 00       	mov    $0x0,%esi
   426e7:	bf 00 20 05 00       	mov    $0x52000,%edi
   426ec:	e8 61 16 00 00       	call   43d52 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   426f1:	b8 00 30 05 00       	mov    $0x53000,%eax
   426f6:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   426fa:	48 89 05 ff f8 00 00 	mov    %rax,0xf8ff(%rip)        # 52000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42701:	b8 00 40 05 00       	mov    $0x54000,%eax
   42706:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   4270a:	48 89 05 ef 08 01 00 	mov    %rax,0x108ef(%rip)        # 53000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42711:	b8 00 50 05 00       	mov    $0x55000,%eax
   42716:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   4271a:	48 89 05 df 18 01 00 	mov    %rax,0x118df(%rip)        # 54000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42721:	b8 00 60 05 00       	mov    $0x56000,%eax
   42726:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   4272a:	48 89 05 d7 18 01 00 	mov    %rax,0x118d7(%rip)        # 54008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42731:	48 8b 05 c8 e8 00 00 	mov    0xe8c8(%rip),%rax        # 51000 <kernel_pagetable>
   42738:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4273e:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42743:	ba 00 00 00 00       	mov    $0x0,%edx
   42748:	be 00 00 00 00       	mov    $0x0,%esi
   4274d:	48 89 c7             	mov    %rax,%rdi
   42750:	e8 b9 01 00 00       	call   4290e <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42755:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4275c:	00 
   4275d:	eb 62                	jmp    427c1 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   4275f:	48 8b 0d 9a e8 00 00 	mov    0xe89a(%rip),%rcx        # 51000 <kernel_pagetable>
   42766:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4276a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4276e:	48 89 ce             	mov    %rcx,%rsi
   42771:	48 89 c7             	mov    %rax,%rdi
   42774:	e8 58 05 00 00       	call   42cd1 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   42779:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4277d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42781:	74 14                	je     42797 <virtual_memory_init+0xcd>
   42783:	ba 65 53 04 00       	mov    $0x45365,%edx
   42788:	be 2d 00 00 00       	mov    $0x2d,%esi
   4278d:	bf 75 53 04 00       	mov    $0x45375,%edi
   42792:	e8 78 fe ff ff       	call   4260f <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42797:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4279a:	48 98                	cltq   
   4279c:	83 e0 03             	and    $0x3,%eax
   4279f:	48 83 f8 03          	cmp    $0x3,%rax
   427a3:	74 14                	je     427b9 <virtual_memory_init+0xef>
   427a5:	ba 88 53 04 00       	mov    $0x45388,%edx
   427aa:	be 2e 00 00 00       	mov    $0x2e,%esi
   427af:	bf 75 53 04 00       	mov    $0x45375,%edi
   427b4:	e8 56 fe ff ff       	call   4260f <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   427b9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   427c0:	00 
   427c1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   427c8:	00 
   427c9:	76 94                	jbe    4275f <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   427cb:	48 8b 05 2e e8 00 00 	mov    0xe82e(%rip),%rax        # 51000 <kernel_pagetable>
   427d2:	48 89 c7             	mov    %rax,%rdi
   427d5:	e8 03 00 00 00       	call   427dd <set_pagetable>
}
   427da:	90                   	nop
   427db:	c9                   	leave  
   427dc:	c3                   	ret    

00000000000427dd <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   427dd:	55                   	push   %rbp
   427de:	48 89 e5             	mov    %rsp,%rbp
   427e1:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   427e5:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   427e9:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427ed:	25 ff 0f 00 00       	and    $0xfff,%eax
   427f2:	48 85 c0             	test   %rax,%rax
   427f5:	74 14                	je     4280b <set_pagetable+0x2e>
   427f7:	ba b5 53 04 00       	mov    $0x453b5,%edx
   427fc:	be 3d 00 00 00       	mov    $0x3d,%esi
   42801:	bf 75 53 04 00       	mov    $0x45375,%edi
   42806:	e8 04 fe ff ff       	call   4260f <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   4280b:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42810:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42814:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42818:	48 89 ce             	mov    %rcx,%rsi
   4281b:	48 89 c7             	mov    %rax,%rdi
   4281e:	e8 ae 04 00 00       	call   42cd1 <virtual_memory_lookup>
   42823:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42827:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4282c:	48 39 d0             	cmp    %rdx,%rax
   4282f:	74 14                	je     42845 <set_pagetable+0x68>
   42831:	ba d0 53 04 00       	mov    $0x453d0,%edx
   42836:	be 3f 00 00 00       	mov    $0x3f,%esi
   4283b:	bf 75 53 04 00       	mov    $0x45375,%edi
   42840:	e8 ca fd ff ff       	call   4260f <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42845:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42849:	48 8b 0d b0 e7 00 00 	mov    0xe7b0(%rip),%rcx        # 51000 <kernel_pagetable>
   42850:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42854:	48 89 ce             	mov    %rcx,%rsi
   42857:	48 89 c7             	mov    %rax,%rdi
   4285a:	e8 72 04 00 00       	call   42cd1 <virtual_memory_lookup>
   4285f:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42863:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42867:	48 39 c2             	cmp    %rax,%rdx
   4286a:	74 14                	je     42880 <set_pagetable+0xa3>
   4286c:	ba 38 54 04 00       	mov    $0x45438,%edx
   42871:	be 41 00 00 00       	mov    $0x41,%esi
   42876:	bf 75 53 04 00       	mov    $0x45375,%edi
   4287b:	e8 8f fd ff ff       	call   4260f <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42880:	48 8b 05 79 e7 00 00 	mov    0xe779(%rip),%rax        # 51000 <kernel_pagetable>
   42887:	48 89 c2             	mov    %rax,%rdx
   4288a:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   4288e:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42892:	48 89 ce             	mov    %rcx,%rsi
   42895:	48 89 c7             	mov    %rax,%rdi
   42898:	e8 34 04 00 00       	call   42cd1 <virtual_memory_lookup>
   4289d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   428a1:	48 8b 15 58 e7 00 00 	mov    0xe758(%rip),%rdx        # 51000 <kernel_pagetable>
   428a8:	48 39 d0             	cmp    %rdx,%rax
   428ab:	74 14                	je     428c1 <set_pagetable+0xe4>
   428ad:	ba 98 54 04 00       	mov    $0x45498,%edx
   428b2:	be 43 00 00 00       	mov    $0x43,%esi
   428b7:	bf 75 53 04 00       	mov    $0x45375,%edi
   428bc:	e8 4e fd ff ff       	call   4260f <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   428c1:	ba 0e 29 04 00       	mov    $0x4290e,%edx
   428c6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   428ca:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   428ce:	48 89 ce             	mov    %rcx,%rsi
   428d1:	48 89 c7             	mov    %rax,%rdi
   428d4:	e8 f8 03 00 00       	call   42cd1 <virtual_memory_lookup>
   428d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428dd:	ba 0e 29 04 00       	mov    $0x4290e,%edx
   428e2:	48 39 d0             	cmp    %rdx,%rax
   428e5:	74 14                	je     428fb <set_pagetable+0x11e>
   428e7:	ba 00 55 04 00       	mov    $0x45500,%edx
   428ec:	be 45 00 00 00       	mov    $0x45,%esi
   428f1:	bf 75 53 04 00       	mov    $0x45375,%edi
   428f6:	e8 14 fd ff ff       	call   4260f <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   428fb:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   428ff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42903:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42907:	0f 22 d8             	mov    %rax,%cr3
}
   4290a:	90                   	nop
}
   4290b:	90                   	nop
   4290c:	c9                   	leave  
   4290d:	c3                   	ret    

000000000004290e <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   4290e:	55                   	push   %rbp
   4290f:	48 89 e5             	mov    %rsp,%rbp
   42912:	53                   	push   %rbx
   42913:	48 83 ec 58          	sub    $0x58,%rsp
   42917:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4291b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   4291f:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42923:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42927:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4292b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4292f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42934:	48 85 c0             	test   %rax,%rax
   42937:	74 14                	je     4294d <virtual_memory_map+0x3f>
   42939:	ba 66 55 04 00       	mov    $0x45566,%edx
   4293e:	be 66 00 00 00       	mov    $0x66,%esi
   42943:	bf 75 53 04 00       	mov    $0x45375,%edi
   42948:	e8 c2 fc ff ff       	call   4260f <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   4294d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42951:	25 ff 0f 00 00       	and    $0xfff,%eax
   42956:	48 85 c0             	test   %rax,%rax
   42959:	74 14                	je     4296f <virtual_memory_map+0x61>
   4295b:	ba 79 55 04 00       	mov    $0x45579,%edx
   42960:	be 67 00 00 00       	mov    $0x67,%esi
   42965:	bf 75 53 04 00       	mov    $0x45375,%edi
   4296a:	e8 a0 fc ff ff       	call   4260f <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   4296f:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42973:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42977:	48 01 d0             	add    %rdx,%rax
   4297a:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   4297e:	73 24                	jae    429a4 <virtual_memory_map+0x96>
   42980:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42984:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42988:	48 01 d0             	add    %rdx,%rax
   4298b:	48 85 c0             	test   %rax,%rax
   4298e:	74 14                	je     429a4 <virtual_memory_map+0x96>
   42990:	ba 8c 55 04 00       	mov    $0x4558c,%edx
   42995:	be 68 00 00 00       	mov    $0x68,%esi
   4299a:	bf 75 53 04 00       	mov    $0x45375,%edi
   4299f:	e8 6b fc ff ff       	call   4260f <assert_fail>
    if (perm & PTE_P) {
   429a4:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429a7:	48 98                	cltq   
   429a9:	83 e0 01             	and    $0x1,%eax
   429ac:	48 85 c0             	test   %rax,%rax
   429af:	74 6e                	je     42a1f <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   429b1:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   429b5:	25 ff 0f 00 00       	and    $0xfff,%eax
   429ba:	48 85 c0             	test   %rax,%rax
   429bd:	74 14                	je     429d3 <virtual_memory_map+0xc5>
   429bf:	ba aa 55 04 00       	mov    $0x455aa,%edx
   429c4:	be 6a 00 00 00       	mov    $0x6a,%esi
   429c9:	bf 75 53 04 00       	mov    $0x45375,%edi
   429ce:	e8 3c fc ff ff       	call   4260f <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   429d3:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   429d7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   429db:	48 01 d0             	add    %rdx,%rax
   429de:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   429e2:	73 14                	jae    429f8 <virtual_memory_map+0xea>
   429e4:	ba bd 55 04 00       	mov    $0x455bd,%edx
   429e9:	be 6b 00 00 00       	mov    $0x6b,%esi
   429ee:	bf 75 53 04 00       	mov    $0x45375,%edi
   429f3:	e8 17 fc ff ff       	call   4260f <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   429f8:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   429fc:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a00:	48 01 d0             	add    %rdx,%rax
   42a03:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42a09:	76 14                	jbe    42a1f <virtual_memory_map+0x111>
   42a0b:	ba cb 55 04 00       	mov    $0x455cb,%edx
   42a10:	be 6c 00 00 00       	mov    $0x6c,%esi
   42a15:	bf 75 53 04 00       	mov    $0x45375,%edi
   42a1a:	e8 f0 fb ff ff       	call   4260f <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42a1f:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42a23:	78 09                	js     42a2e <virtual_memory_map+0x120>
   42a25:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42a2c:	7e 14                	jle    42a42 <virtual_memory_map+0x134>
   42a2e:	ba e7 55 04 00       	mov    $0x455e7,%edx
   42a33:	be 6e 00 00 00       	mov    $0x6e,%esi
   42a38:	bf 75 53 04 00       	mov    $0x45375,%edi
   42a3d:	e8 cd fb ff ff       	call   4260f <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42a42:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a46:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a4b:	48 85 c0             	test   %rax,%rax
   42a4e:	74 14                	je     42a64 <virtual_memory_map+0x156>
   42a50:	ba 08 56 04 00       	mov    $0x45608,%edx
   42a55:	be 6f 00 00 00       	mov    $0x6f,%esi
   42a5a:	bf 75 53 04 00       	mov    $0x45375,%edi
   42a5f:	e8 ab fb ff ff       	call   4260f <assert_fail>

    int last_index123 = -1;
   42a64:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42a6b:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42a72:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42a73:	e9 e1 00 00 00       	jmp    42b59 <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42a78:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a7c:	48 c1 e8 15          	shr    $0x15,%rax
   42a80:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42a83:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a86:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42a89:	74 20                	je     42aab <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42a8b:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42a8e:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42a92:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a96:	48 89 ce             	mov    %rcx,%rsi
   42a99:	48 89 c7             	mov    %rax,%rdi
   42a9c:	e8 ce 00 00 00       	call   42b6f <lookup_l4pagetable>
   42aa1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42aa5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42aa8:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42aab:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42aae:	48 98                	cltq   
   42ab0:	83 e0 01             	and    $0x1,%eax
   42ab3:	48 85 c0             	test   %rax,%rax
   42ab6:	74 34                	je     42aec <virtual_memory_map+0x1de>
   42ab8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42abd:	74 2d                	je     42aec <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42abf:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ac2:	48 63 d8             	movslq %eax,%rbx
   42ac5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42ac9:	be 03 00 00 00       	mov    $0x3,%esi
   42ace:	48 89 c7             	mov    %rax,%rdi
   42ad1:	e8 9e fb ff ff       	call   42674 <pageindex>
   42ad6:	89 c2                	mov    %eax,%edx
   42ad8:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42adc:	48 89 d9             	mov    %rbx,%rcx
   42adf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ae3:	48 63 d2             	movslq %edx,%rdx
   42ae6:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42aea:	eb 55                	jmp    42b41 <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42aec:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42af1:	74 26                	je     42b19 <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42af3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42af7:	be 03 00 00 00       	mov    $0x3,%esi
   42afc:	48 89 c7             	mov    %rax,%rdi
   42aff:	e8 70 fb ff ff       	call   42674 <pageindex>
   42b04:	89 c2                	mov    %eax,%edx
   42b06:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b09:	48 63 c8             	movslq %eax,%rcx
   42b0c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42b10:	48 63 d2             	movslq %edx,%rdx
   42b13:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42b17:	eb 28                	jmp    42b41 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42b19:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b1c:	48 98                	cltq   
   42b1e:	83 e0 01             	and    $0x1,%eax
   42b21:	48 85 c0             	test   %rax,%rax
   42b24:	74 1b                	je     42b41 <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42b26:	be 84 00 00 00       	mov    $0x84,%esi
   42b2b:	bf 30 56 04 00       	mov    $0x45630,%edi
   42b30:	b8 00 00 00 00       	mov    $0x0,%eax
   42b35:	e8 b7 f7 ff ff       	call   422f1 <log_printf>
            return -1;
   42b3a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42b3f:	eb 28                	jmp    42b69 <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42b41:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42b48:	00 
   42b49:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42b50:	00 
   42b51:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42b58:	00 
   42b59:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42b5e:	0f 85 14 ff ff ff    	jne    42a78 <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42b64:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42b69:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42b6d:	c9                   	leave  
   42b6e:	c3                   	ret    

0000000000042b6f <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42b6f:	55                   	push   %rbp
   42b70:	48 89 e5             	mov    %rsp,%rbp
   42b73:	48 83 ec 40          	sub    $0x40,%rsp
   42b77:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42b7b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42b7f:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42b82:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b86:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42b8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42b91:	e9 2b 01 00 00       	jmp    42cc1 <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42b96:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42b99:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b9d:	89 d6                	mov    %edx,%esi
   42b9f:	48 89 c7             	mov    %rax,%rdi
   42ba2:	e8 cd fa ff ff       	call   42674 <pageindex>
   42ba7:	89 c2                	mov    %eax,%edx
   42ba9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42bad:	48 63 d2             	movslq %edx,%rdx
   42bb0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42bb4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42bb8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bbc:	83 e0 01             	and    $0x1,%eax
   42bbf:	48 85 c0             	test   %rax,%rax
   42bc2:	75 63                	jne    42c27 <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42bc4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42bc7:	8d 48 02             	lea    0x2(%rax),%ecx
   42bca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bce:	25 ff 0f 00 00       	and    $0xfff,%eax
   42bd3:	48 89 c2             	mov    %rax,%rdx
   42bd6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bda:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42be0:	48 89 c6             	mov    %rax,%rsi
   42be3:	bf 78 56 04 00       	mov    $0x45678,%edi
   42be8:	b8 00 00 00 00       	mov    $0x0,%eax
   42bed:	e8 ff f6 ff ff       	call   422f1 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42bf2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bf5:	48 98                	cltq   
   42bf7:	83 e0 01             	and    $0x1,%eax
   42bfa:	48 85 c0             	test   %rax,%rax
   42bfd:	75 0a                	jne    42c09 <lookup_l4pagetable+0x9a>
                return NULL;
   42bff:	b8 00 00 00 00       	mov    $0x0,%eax
   42c04:	e9 c6 00 00 00       	jmp    42ccf <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42c09:	be a7 00 00 00       	mov    $0xa7,%esi
   42c0e:	bf e0 56 04 00       	mov    $0x456e0,%edi
   42c13:	b8 00 00 00 00       	mov    $0x0,%eax
   42c18:	e8 d4 f6 ff ff       	call   422f1 <log_printf>
            return NULL;
   42c1d:	b8 00 00 00 00       	mov    $0x0,%eax
   42c22:	e9 a8 00 00 00       	jmp    42ccf <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42c27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c2b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c31:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42c37:	76 14                	jbe    42c4d <lookup_l4pagetable+0xde>
   42c39:	ba 28 57 04 00       	mov    $0x45728,%edx
   42c3e:	be ac 00 00 00       	mov    $0xac,%esi
   42c43:	bf 75 53 04 00       	mov    $0x45375,%edi
   42c48:	e8 c2 f9 ff ff       	call   4260f <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42c4d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c50:	48 98                	cltq   
   42c52:	83 e0 02             	and    $0x2,%eax
   42c55:	48 85 c0             	test   %rax,%rax
   42c58:	74 20                	je     42c7a <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42c5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c5e:	83 e0 02             	and    $0x2,%eax
   42c61:	48 85 c0             	test   %rax,%rax
   42c64:	75 14                	jne    42c7a <lookup_l4pagetable+0x10b>
   42c66:	ba 48 57 04 00       	mov    $0x45748,%edx
   42c6b:	be ae 00 00 00       	mov    $0xae,%esi
   42c70:	bf 75 53 04 00       	mov    $0x45375,%edi
   42c75:	e8 95 f9 ff ff       	call   4260f <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42c7a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c7d:	48 98                	cltq   
   42c7f:	83 e0 04             	and    $0x4,%eax
   42c82:	48 85 c0             	test   %rax,%rax
   42c85:	74 20                	je     42ca7 <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42c87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c8b:	83 e0 04             	and    $0x4,%eax
   42c8e:	48 85 c0             	test   %rax,%rax
   42c91:	75 14                	jne    42ca7 <lookup_l4pagetable+0x138>
   42c93:	ba 53 57 04 00       	mov    $0x45753,%edx
   42c98:	be b1 00 00 00       	mov    $0xb1,%esi
   42c9d:	bf 75 53 04 00       	mov    $0x45375,%edi
   42ca2:	e8 68 f9 ff ff       	call   4260f <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42ca7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42cae:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42caf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cb3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42cb9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42cbd:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42cc1:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42cc5:	0f 8e cb fe ff ff    	jle    42b96 <lookup_l4pagetable+0x27>
    }
    return pt;
   42ccb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42ccf:	c9                   	leave  
   42cd0:	c3                   	ret    

0000000000042cd1 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42cd1:	55                   	push   %rbp
   42cd2:	48 89 e5             	mov    %rsp,%rbp
   42cd5:	48 83 ec 50          	sub    $0x50,%rsp
   42cd9:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42cdd:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42ce1:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42ce5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42ce9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42ced:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42cf4:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42cf5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42cfc:	eb 41                	jmp    42d3f <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42cfe:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42d01:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42d05:	89 d6                	mov    %edx,%esi
   42d07:	48 89 c7             	mov    %rax,%rdi
   42d0a:	e8 65 f9 ff ff       	call   42674 <pageindex>
   42d0f:	89 c2                	mov    %eax,%edx
   42d11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d15:	48 63 d2             	movslq %edx,%rdx
   42d18:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42d1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d20:	83 e0 06             	and    $0x6,%eax
   42d23:	48 f7 d0             	not    %rax
   42d26:	48 21 d0             	and    %rdx,%rax
   42d29:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42d2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d31:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d37:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42d3b:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42d3f:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42d43:	7f 0c                	jg     42d51 <virtual_memory_lookup+0x80>
   42d45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d49:	83 e0 01             	and    $0x1,%eax
   42d4c:	48 85 c0             	test   %rax,%rax
   42d4f:	75 ad                	jne    42cfe <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42d51:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42d58:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42d5f:	ff 
   42d60:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42d67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d6b:	83 e0 01             	and    $0x1,%eax
   42d6e:	48 85 c0             	test   %rax,%rax
   42d71:	74 34                	je     42da7 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42d73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d77:	48 c1 e8 0c          	shr    $0xc,%rax
   42d7b:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42d7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d82:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d88:	48 89 c2             	mov    %rax,%rdx
   42d8b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42d8f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d94:	48 09 d0             	or     %rdx,%rax
   42d97:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42d9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d9f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42da4:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42da7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42dab:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42daf:	48 89 10             	mov    %rdx,(%rax)
   42db2:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42db6:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42dba:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42dbe:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42dc2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42dc6:	c9                   	leave  
   42dc7:	c3                   	ret    

0000000000042dc8 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42dc8:	55                   	push   %rbp
   42dc9:	48 89 e5             	mov    %rsp,%rbp
   42dcc:	48 83 ec 40          	sub    $0x40,%rsp
   42dd0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42dd4:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42dd7:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42ddb:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42de2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42de6:	78 08                	js     42df0 <program_load+0x28>
   42de8:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42deb:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42dee:	7c 14                	jl     42e04 <program_load+0x3c>
   42df0:	ba 60 57 04 00       	mov    $0x45760,%edx
   42df5:	be 2e 00 00 00       	mov    $0x2e,%esi
   42dfa:	bf 90 57 04 00       	mov    $0x45790,%edi
   42dff:	e8 0b f8 ff ff       	call   4260f <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42e04:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42e07:	48 98                	cltq   
   42e09:	48 c1 e0 04          	shl    $0x4,%rax
   42e0d:	48 05 20 60 04 00    	add    $0x46020,%rax
   42e13:	48 8b 00             	mov    (%rax),%rax
   42e16:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42e1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e1e:	8b 00                	mov    (%rax),%eax
   42e20:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42e25:	74 14                	je     42e3b <program_load+0x73>
   42e27:	ba a2 57 04 00       	mov    $0x457a2,%edx
   42e2c:	be 30 00 00 00       	mov    $0x30,%esi
   42e31:	bf 90 57 04 00       	mov    $0x45790,%edi
   42e36:	e8 d4 f7 ff ff       	call   4260f <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42e3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e3f:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42e43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e47:	48 01 d0             	add    %rdx,%rax
   42e4a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e4e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42e55:	e9 94 00 00 00       	jmp    42eee <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42e5a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e5d:	48 63 d0             	movslq %eax,%rdx
   42e60:	48 89 d0             	mov    %rdx,%rax
   42e63:	48 c1 e0 03          	shl    $0x3,%rax
   42e67:	48 29 d0             	sub    %rdx,%rax
   42e6a:	48 c1 e0 03          	shl    $0x3,%rax
   42e6e:	48 89 c2             	mov    %rax,%rdx
   42e71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e75:	48 01 d0             	add    %rdx,%rax
   42e78:	8b 00                	mov    (%rax),%eax
   42e7a:	83 f8 01             	cmp    $0x1,%eax
   42e7d:	75 6b                	jne    42eea <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42e7f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e82:	48 63 d0             	movslq %eax,%rdx
   42e85:	48 89 d0             	mov    %rdx,%rax
   42e88:	48 c1 e0 03          	shl    $0x3,%rax
   42e8c:	48 29 d0             	sub    %rdx,%rax
   42e8f:	48 c1 e0 03          	shl    $0x3,%rax
   42e93:	48 89 c2             	mov    %rax,%rdx
   42e96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e9a:	48 01 d0             	add    %rdx,%rax
   42e9d:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42ea1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ea5:	48 01 d0             	add    %rdx,%rax
   42ea8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42eac:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42eaf:	48 63 d0             	movslq %eax,%rdx
   42eb2:	48 89 d0             	mov    %rdx,%rax
   42eb5:	48 c1 e0 03          	shl    $0x3,%rax
   42eb9:	48 29 d0             	sub    %rdx,%rax
   42ebc:	48 c1 e0 03          	shl    $0x3,%rax
   42ec0:	48 89 c2             	mov    %rax,%rdx
   42ec3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ec7:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42ecb:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42ecf:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42ed3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ed7:	48 89 c7             	mov    %rax,%rdi
   42eda:	e8 3d 00 00 00       	call   42f1c <program_load_segment>
   42edf:	85 c0                	test   %eax,%eax
   42ee1:	79 07                	jns    42eea <program_load+0x122>
                return -1;
   42ee3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42ee8:	eb 30                	jmp    42f1a <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42eea:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42eee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ef2:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42ef6:	0f b7 c0             	movzwl %ax,%eax
   42ef9:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42efc:	0f 8c 58 ff ff ff    	jl     42e5a <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42f02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f06:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42f0a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f0e:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42f15:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f1a:	c9                   	leave  
   42f1b:	c3                   	ret    

0000000000042f1c <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42f1c:	55                   	push   %rbp
   42f1d:	48 89 e5             	mov    %rsp,%rbp
   42f20:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42f24:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   42f28:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   42f2c:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   42f30:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42f34:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   42f38:	48 8b 40 10          	mov    0x10(%rax),%rax
   42f3c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42f40:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   42f44:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42f48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f4c:	48 01 d0             	add    %rdx,%rax
   42f4f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42f53:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   42f57:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42f5b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f5f:	48 01 d0             	add    %rdx,%rax
   42f62:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42f66:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42f6d:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f72:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42f76:	eb 7c                	jmp    42ff4 <program_load_segment+0xd8>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42f78:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   42f7c:	8b 00                	mov    (%rax),%eax
   42f7e:	89 c7                	mov    %eax,%edi
   42f80:	e8 9b 01 00 00       	call   43120 <palloc>
   42f85:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42f89:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   42f8e:	74 2a                	je     42fba <program_load_segment+0x9e>
   42f90:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   42f94:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f9b:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42f9f:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42fa3:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42fa9:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42fae:	48 89 c7             	mov    %rax,%rdi
   42fb1:	e8 58 f9 ff ff       	call   4290e <virtual_memory_map>
   42fb6:	85 c0                	test   %eax,%eax
   42fb8:	79 32                	jns    42fec <program_load_segment+0xd0>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42fba:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   42fbe:	8b 00                	mov    (%rax),%eax
   42fc0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42fc4:	49 89 d0             	mov    %rdx,%r8
   42fc7:	89 c1                	mov    %eax,%ecx
   42fc9:	ba c0 57 04 00       	mov    $0x457c0,%edx
   42fce:	be 00 c0 00 00       	mov    $0xc000,%esi
   42fd3:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42fd8:	b8 00 00 00 00       	mov    $0x0,%eax
   42fdd:	e8 27 1b 00 00       	call   44b09 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42fe2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42fe7:	e9 32 01 00 00       	jmp    4311e <program_load_segment+0x202>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42fec:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42ff3:	00 
   42ff4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ff8:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42ffc:	0f 82 76 ff ff ff    	jb     42f78 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43002:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43006:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4300d:	48 89 c7             	mov    %rax,%rdi
   43010:	e8 c8 f7 ff ff       	call   427dd <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43015:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43019:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4301d:	48 89 c2             	mov    %rax,%rdx
   43020:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43024:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43028:	48 89 ce             	mov    %rcx,%rsi
   4302b:	48 89 c7             	mov    %rax,%rdi
   4302e:	e8 21 0c 00 00       	call   43c54 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43033:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43037:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4303b:	48 89 c2             	mov    %rax,%rdx
   4303e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43042:	be 00 00 00 00       	mov    $0x0,%esi
   43047:	48 89 c7             	mov    %rax,%rdi
   4304a:	e8 03 0d 00 00       	call   43d52 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   4304f:	48 8b 05 aa df 00 00 	mov    0xdfaa(%rip),%rax        # 51000 <kernel_pagetable>
   43056:	48 89 c7             	mov    %rax,%rdi
   43059:	e8 7f f7 ff ff       	call   427dd <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   4305e:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43062:	8b 40 04             	mov    0x4(%rax),%eax
   43065:	83 e0 02             	and    $0x2,%eax
   43068:	85 c0                	test   %eax,%eax
   4306a:	75 60                	jne    430cc <program_load_segment+0x1b0>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4306c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43070:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43074:	eb 4c                	jmp    430c2 <program_load_segment+0x1a6>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43076:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4307a:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   43081:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   43085:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43089:	48 89 ce             	mov    %rcx,%rsi
   4308c:	48 89 c7             	mov    %rax,%rdi
   4308f:	e8 3d fc ff ff       	call   42cd1 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   43094:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   43098:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4309c:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   430a3:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   430a7:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   430ad:	b9 00 10 00 00       	mov    $0x1000,%ecx
   430b2:	48 89 c7             	mov    %rax,%rdi
   430b5:	e8 54 f8 ff ff       	call   4290e <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430ba:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   430c1:	00 
   430c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430c6:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   430ca:	72 aa                	jb     43076 <program_load_segment+0x15a>
                    PTE_P | PTE_U);
        }
    }
    // TODO : Add code here
    // gives address of break so you know where to sbreak in heap
    p->original_break = ROUNDUP(end_mem, PAGESIZE); //starter break
   430cc:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   430d3:	00 
   430d4:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   430d8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430dc:	48 01 d0             	add    %rdx,%rax
   430df:	48 83 e8 01          	sub    $0x1,%rax
   430e3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   430e7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   430eb:	ba 00 00 00 00       	mov    $0x0,%edx
   430f0:	48 f7 75 d0          	divq   -0x30(%rbp)
   430f4:	48 89 d1             	mov    %rdx,%rcx
   430f7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   430fb:	48 29 c8             	sub    %rcx,%rax
   430fe:	48 89 c2             	mov    %rax,%rdx
   43101:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43105:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = p->original_break; //set initial position
   43109:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4310d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43111:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43115:	48 89 50 08          	mov    %rdx,0x8(%rax)

    return 0;
   43119:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4311e:	c9                   	leave  
   4311f:	c3                   	ret    

0000000000043120 <palloc>:
   43120:	55                   	push   %rbp
   43121:	48 89 e5             	mov    %rsp,%rbp
   43124:	48 83 ec 20          	sub    $0x20,%rsp
   43128:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4312b:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43132:	00 
   43133:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43137:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4313b:	e9 95 00 00 00       	jmp    431d5 <palloc+0xb5>
   43140:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43144:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43148:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4314f:	00 
   43150:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43154:	48 c1 e8 0c          	shr    $0xc,%rax
   43158:	48 98                	cltq   
   4315a:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   43161:	00 
   43162:	84 c0                	test   %al,%al
   43164:	75 6f                	jne    431d5 <palloc+0xb5>
   43166:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4316a:	48 c1 e8 0c          	shr    $0xc,%rax
   4316e:	48 98                	cltq   
   43170:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43177:	00 
   43178:	84 c0                	test   %al,%al
   4317a:	75 59                	jne    431d5 <palloc+0xb5>
   4317c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43180:	48 c1 e8 0c          	shr    $0xc,%rax
   43184:	89 c2                	mov    %eax,%edx
   43186:	48 63 c2             	movslq %edx,%rax
   43189:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43190:	00 
   43191:	83 c0 01             	add    $0x1,%eax
   43194:	89 c1                	mov    %eax,%ecx
   43196:	48 63 c2             	movslq %edx,%rax
   43199:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   431a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431a4:	48 c1 e8 0c          	shr    $0xc,%rax
   431a8:	89 c1                	mov    %eax,%ecx
   431aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
   431ad:	89 c2                	mov    %eax,%edx
   431af:	48 63 c1             	movslq %ecx,%rax
   431b2:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
   431b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431bd:	ba 00 10 00 00       	mov    $0x1000,%edx
   431c2:	be cc 00 00 00       	mov    $0xcc,%esi
   431c7:	48 89 c7             	mov    %rax,%rdi
   431ca:	e8 83 0b 00 00       	call   43d52 <memset>
   431cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431d3:	eb 2c                	jmp    43201 <palloc+0xe1>
   431d5:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   431dc:	00 
   431dd:	0f 86 5d ff ff ff    	jbe    43140 <palloc+0x20>
   431e3:	ba f8 57 04 00       	mov    $0x457f8,%edx
   431e8:	be 00 0c 00 00       	mov    $0xc00,%esi
   431ed:	bf 80 07 00 00       	mov    $0x780,%edi
   431f2:	b8 00 00 00 00       	mov    $0x0,%eax
   431f7:	e8 0d 19 00 00       	call   44b09 <console_printf>
   431fc:	b8 00 00 00 00       	mov    $0x0,%eax
   43201:	c9                   	leave  
   43202:	c3                   	ret    

0000000000043203 <palloc_target>:
   43203:	55                   	push   %rbp
   43204:	48 89 e5             	mov    %rsp,%rbp
   43207:	48 8b 05 f2 3d 01 00 	mov    0x13df2(%rip),%rax        # 57000 <palloc_target_proc>
   4320e:	48 85 c0             	test   %rax,%rax
   43211:	75 14                	jne    43227 <palloc_target+0x24>
   43213:	ba 11 58 04 00       	mov    $0x45811,%edx
   43218:	be 27 00 00 00       	mov    $0x27,%esi
   4321d:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   43222:	e8 e8 f3 ff ff       	call   4260f <assert_fail>
   43227:	48 8b 05 d2 3d 01 00 	mov    0x13dd2(%rip),%rax        # 57000 <palloc_target_proc>
   4322e:	8b 00                	mov    (%rax),%eax
   43230:	89 c7                	mov    %eax,%edi
   43232:	e8 e9 fe ff ff       	call   43120 <palloc>
   43237:	5d                   	pop    %rbp
   43238:	c3                   	ret    

0000000000043239 <process_free>:
   43239:	55                   	push   %rbp
   4323a:	48 89 e5             	mov    %rsp,%rbp
   4323d:	48 83 ec 60          	sub    $0x60,%rsp
   43241:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43244:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43247:	48 63 d0             	movslq %eax,%rdx
   4324a:	48 89 d0             	mov    %rdx,%rax
   4324d:	48 c1 e0 04          	shl    $0x4,%rax
   43251:	48 29 d0             	sub    %rdx,%rax
   43254:	48 c1 e0 04          	shl    $0x4,%rax
   43258:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   4325e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43264:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   4326b:	00 
   4326c:	e9 ad 00 00 00       	jmp    4331e <process_free+0xe5>
   43271:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43274:	48 63 d0             	movslq %eax,%rdx
   43277:	48 89 d0             	mov    %rdx,%rax
   4327a:	48 c1 e0 04          	shl    $0x4,%rax
   4327e:	48 29 d0             	sub    %rdx,%rax
   43281:	48 c1 e0 04          	shl    $0x4,%rax
   43285:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   4328b:	48 8b 08             	mov    (%rax),%rcx
   4328e:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   43292:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43296:	48 89 ce             	mov    %rcx,%rsi
   43299:	48 89 c7             	mov    %rax,%rdi
   4329c:	e8 30 fa ff ff       	call   42cd1 <virtual_memory_lookup>
   432a1:	8b 45 c8             	mov    -0x38(%rbp),%eax
   432a4:	48 98                	cltq   
   432a6:	83 e0 01             	and    $0x1,%eax
   432a9:	48 85 c0             	test   %rax,%rax
   432ac:	74 68                	je     43316 <process_free+0xdd>
   432ae:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432b1:	48 63 d0             	movslq %eax,%rdx
   432b4:	0f b6 94 12 21 ef 04 	movzbl 0x4ef21(%rdx,%rdx,1),%edx
   432bb:	00 
   432bc:	83 ea 01             	sub    $0x1,%edx
   432bf:	48 98                	cltq   
   432c1:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
   432c8:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432cb:	48 98                	cltq   
   432cd:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   432d4:	00 
   432d5:	84 c0                	test   %al,%al
   432d7:	75 0f                	jne    432e8 <process_free+0xaf>
   432d9:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432dc:	48 98                	cltq   
   432de:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   432e5:	00 
   432e6:	eb 2e                	jmp    43316 <process_free+0xdd>
   432e8:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432eb:	48 98                	cltq   
   432ed:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   432f4:	00 
   432f5:	0f be c0             	movsbl %al,%eax
   432f8:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   432fb:	75 19                	jne    43316 <process_free+0xdd>
   432fd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43301:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43304:	48 89 c6             	mov    %rax,%rsi
   43307:	bf 38 58 04 00       	mov    $0x45838,%edi
   4330c:	b8 00 00 00 00       	mov    $0x0,%eax
   43311:	e8 db ef ff ff       	call   422f1 <log_printf>
   43316:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4331d:	00 
   4331e:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43325:	00 
   43326:	0f 86 45 ff ff ff    	jbe    43271 <process_free+0x38>
   4332c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4332f:	48 63 d0             	movslq %eax,%rdx
   43332:	48 89 d0             	mov    %rdx,%rax
   43335:	48 c1 e0 04          	shl    $0x4,%rax
   43339:	48 29 d0             	sub    %rdx,%rax
   4333c:	48 c1 e0 04          	shl    $0x4,%rax
   43340:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43346:	48 8b 00             	mov    (%rax),%rax
   43349:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4334d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43351:	48 8b 00             	mov    (%rax),%rax
   43354:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4335a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4335e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43362:	48 8b 00             	mov    (%rax),%rax
   43365:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4336b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4336f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43373:	48 8b 00             	mov    (%rax),%rax
   43376:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4337c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43380:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43384:	48 8b 40 08          	mov    0x8(%rax),%rax
   43388:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4338e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   43392:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43396:	48 c1 e8 0c          	shr    $0xc,%rax
   4339a:	48 98                	cltq   
   4339c:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   433a3:	00 
   433a4:	3c 01                	cmp    $0x1,%al
   433a6:	74 14                	je     433bc <process_free+0x183>
   433a8:	ba 70 58 04 00       	mov    $0x45870,%edx
   433ad:	be 4f 00 00 00       	mov    $0x4f,%esi
   433b2:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   433b7:	e8 53 f2 ff ff       	call   4260f <assert_fail>
   433bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433c0:	48 c1 e8 0c          	shr    $0xc,%rax
   433c4:	48 98                	cltq   
   433c6:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   433cd:	00 
   433ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433d2:	48 c1 e8 0c          	shr    $0xc,%rax
   433d6:	48 98                	cltq   
   433d8:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   433df:	00 
   433e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433e4:	48 c1 e8 0c          	shr    $0xc,%rax
   433e8:	48 98                	cltq   
   433ea:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   433f1:	00 
   433f2:	3c 01                	cmp    $0x1,%al
   433f4:	74 14                	je     4340a <process_free+0x1d1>
   433f6:	ba 98 58 04 00       	mov    $0x45898,%edx
   433fb:	be 52 00 00 00       	mov    $0x52,%esi
   43400:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   43405:	e8 05 f2 ff ff       	call   4260f <assert_fail>
   4340a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4340e:	48 c1 e8 0c          	shr    $0xc,%rax
   43412:	48 98                	cltq   
   43414:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4341b:	00 
   4341c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43420:	48 c1 e8 0c          	shr    $0xc,%rax
   43424:	48 98                	cltq   
   43426:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4342d:	00 
   4342e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43432:	48 c1 e8 0c          	shr    $0xc,%rax
   43436:	48 98                	cltq   
   43438:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4343f:	00 
   43440:	3c 01                	cmp    $0x1,%al
   43442:	74 14                	je     43458 <process_free+0x21f>
   43444:	ba c0 58 04 00       	mov    $0x458c0,%edx
   43449:	be 55 00 00 00       	mov    $0x55,%esi
   4344e:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   43453:	e8 b7 f1 ff ff       	call   4260f <assert_fail>
   43458:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4345c:	48 c1 e8 0c          	shr    $0xc,%rax
   43460:	48 98                	cltq   
   43462:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43469:	00 
   4346a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4346e:	48 c1 e8 0c          	shr    $0xc,%rax
   43472:	48 98                	cltq   
   43474:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4347b:	00 
   4347c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43480:	48 c1 e8 0c          	shr    $0xc,%rax
   43484:	48 98                	cltq   
   43486:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4348d:	00 
   4348e:	3c 01                	cmp    $0x1,%al
   43490:	74 14                	je     434a6 <process_free+0x26d>
   43492:	ba e8 58 04 00       	mov    $0x458e8,%edx
   43497:	be 58 00 00 00       	mov    $0x58,%esi
   4349c:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   434a1:	e8 69 f1 ff ff       	call   4260f <assert_fail>
   434a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434aa:	48 c1 e8 0c          	shr    $0xc,%rax
   434ae:	48 98                	cltq   
   434b0:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   434b7:	00 
   434b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434bc:	48 c1 e8 0c          	shr    $0xc,%rax
   434c0:	48 98                	cltq   
   434c2:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   434c9:	00 
   434ca:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434ce:	48 c1 e8 0c          	shr    $0xc,%rax
   434d2:	48 98                	cltq   
   434d4:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   434db:	00 
   434dc:	3c 01                	cmp    $0x1,%al
   434de:	74 14                	je     434f4 <process_free+0x2bb>
   434e0:	ba 10 59 04 00       	mov    $0x45910,%edx
   434e5:	be 5b 00 00 00       	mov    $0x5b,%esi
   434ea:	bf 2c 58 04 00       	mov    $0x4582c,%edi
   434ef:	e8 1b f1 ff ff       	call   4260f <assert_fail>
   434f4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434f8:	48 c1 e8 0c          	shr    $0xc,%rax
   434fc:	48 98                	cltq   
   434fe:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43505:	00 
   43506:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4350a:	48 c1 e8 0c          	shr    $0xc,%rax
   4350e:	48 98                	cltq   
   43510:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43517:	00 
   43518:	90                   	nop
   43519:	c9                   	leave  
   4351a:	c3                   	ret    

000000000004351b <process_config_tables>:
   4351b:	55                   	push   %rbp
   4351c:	48 89 e5             	mov    %rsp,%rbp
   4351f:	48 83 ec 40          	sub    $0x40,%rsp
   43523:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43526:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43529:	89 c7                	mov    %eax,%edi
   4352b:	e8 f0 fb ff ff       	call   43120 <palloc>
   43530:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43534:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43537:	89 c7                	mov    %eax,%edi
   43539:	e8 e2 fb ff ff       	call   43120 <palloc>
   4353e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43542:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43545:	89 c7                	mov    %eax,%edi
   43547:	e8 d4 fb ff ff       	call   43120 <palloc>
   4354c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43550:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43553:	89 c7                	mov    %eax,%edi
   43555:	e8 c6 fb ff ff       	call   43120 <palloc>
   4355a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4355e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43561:	89 c7                	mov    %eax,%edi
   43563:	e8 b8 fb ff ff       	call   43120 <palloc>
   43568:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4356c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43571:	74 20                	je     43593 <process_config_tables+0x78>
   43573:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43578:	74 19                	je     43593 <process_config_tables+0x78>
   4357a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4357f:	74 12                	je     43593 <process_config_tables+0x78>
   43581:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43586:	74 0b                	je     43593 <process_config_tables+0x78>
   43588:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4358d:	0f 85 e1 00 00 00    	jne    43674 <process_config_tables+0x159>
   43593:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43598:	74 24                	je     435be <process_config_tables+0xa3>
   4359a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4359e:	48 c1 e8 0c          	shr    $0xc,%rax
   435a2:	48 98                	cltq   
   435a4:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   435ab:	00 
   435ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435b0:	48 c1 e8 0c          	shr    $0xc,%rax
   435b4:	48 98                	cltq   
   435b6:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   435bd:	00 
   435be:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   435c3:	74 24                	je     435e9 <process_config_tables+0xce>
   435c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435c9:	48 c1 e8 0c          	shr    $0xc,%rax
   435cd:	48 98                	cltq   
   435cf:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   435d6:	00 
   435d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435db:	48 c1 e8 0c          	shr    $0xc,%rax
   435df:	48 98                	cltq   
   435e1:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   435e8:	00 
   435e9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   435ee:	74 24                	je     43614 <process_config_tables+0xf9>
   435f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435f4:	48 c1 e8 0c          	shr    $0xc,%rax
   435f8:	48 98                	cltq   
   435fa:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43601:	00 
   43602:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43606:	48 c1 e8 0c          	shr    $0xc,%rax
   4360a:	48 98                	cltq   
   4360c:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43613:	00 
   43614:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43619:	74 24                	je     4363f <process_config_tables+0x124>
   4361b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4361f:	48 c1 e8 0c          	shr    $0xc,%rax
   43623:	48 98                	cltq   
   43625:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4362c:	00 
   4362d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43631:	48 c1 e8 0c          	shr    $0xc,%rax
   43635:	48 98                	cltq   
   43637:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4363e:	00 
   4363f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43644:	74 24                	je     4366a <process_config_tables+0x14f>
   43646:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4364a:	48 c1 e8 0c          	shr    $0xc,%rax
   4364e:	48 98                	cltq   
   43650:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43657:	00 
   43658:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4365c:	48 c1 e8 0c          	shr    $0xc,%rax
   43660:	48 98                	cltq   
   43662:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43669:	00 
   4366a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4366f:	e9 f3 01 00 00       	jmp    43867 <process_config_tables+0x34c>
   43674:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43678:	ba 00 10 00 00       	mov    $0x1000,%edx
   4367d:	be 00 00 00 00       	mov    $0x0,%esi
   43682:	48 89 c7             	mov    %rax,%rdi
   43685:	e8 c8 06 00 00       	call   43d52 <memset>
   4368a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4368e:	ba 00 10 00 00       	mov    $0x1000,%edx
   43693:	be 00 00 00 00       	mov    $0x0,%esi
   43698:	48 89 c7             	mov    %rax,%rdi
   4369b:	e8 b2 06 00 00       	call   43d52 <memset>
   436a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436a4:	ba 00 10 00 00       	mov    $0x1000,%edx
   436a9:	be 00 00 00 00       	mov    $0x0,%esi
   436ae:	48 89 c7             	mov    %rax,%rdi
   436b1:	e8 9c 06 00 00       	call   43d52 <memset>
   436b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   436ba:	ba 00 10 00 00       	mov    $0x1000,%edx
   436bf:	be 00 00 00 00       	mov    $0x0,%esi
   436c4:	48 89 c7             	mov    %rax,%rdi
   436c7:	e8 86 06 00 00       	call   43d52 <memset>
   436cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436d0:	ba 00 10 00 00       	mov    $0x1000,%edx
   436d5:	be 00 00 00 00       	mov    $0x0,%esi
   436da:	48 89 c7             	mov    %rax,%rdi
   436dd:	e8 70 06 00 00       	call   43d52 <memset>
   436e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436e6:	48 83 c8 07          	or     $0x7,%rax
   436ea:	48 89 c2             	mov    %rax,%rdx
   436ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436f1:	48 89 10             	mov    %rdx,(%rax)
   436f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436f8:	48 83 c8 07          	or     $0x7,%rax
   436fc:	48 89 c2             	mov    %rax,%rdx
   436ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43703:	48 89 10             	mov    %rdx,(%rax)
   43706:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4370a:	48 83 c8 07          	or     $0x7,%rax
   4370e:	48 89 c2             	mov    %rax,%rdx
   43711:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43715:	48 89 10             	mov    %rdx,(%rax)
   43718:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4371c:	48 83 c8 07          	or     $0x7,%rax
   43720:	48 89 c2             	mov    %rax,%rdx
   43723:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43727:	48 89 50 08          	mov    %rdx,0x8(%rax)
   4372b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4372f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43735:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   4373b:	b9 00 00 10 00       	mov    $0x100000,%ecx
   43740:	ba 00 00 00 00       	mov    $0x0,%edx
   43745:	be 00 00 00 00       	mov    $0x0,%esi
   4374a:	48 89 c7             	mov    %rax,%rdi
   4374d:	e8 bc f1 ff ff       	call   4290e <virtual_memory_map>
   43752:	85 c0                	test   %eax,%eax
   43754:	75 2f                	jne    43785 <process_config_tables+0x26a>
   43756:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   4375b:	be 00 80 0b 00       	mov    $0xb8000,%esi
   43760:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43764:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4376a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43770:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43775:	48 89 c7             	mov    %rax,%rdi
   43778:	e8 91 f1 ff ff       	call   4290e <virtual_memory_map>
   4377d:	85 c0                	test   %eax,%eax
   4377f:	0f 84 bb 00 00 00    	je     43840 <process_config_tables+0x325>
   43785:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43789:	48 c1 e8 0c          	shr    $0xc,%rax
   4378d:	48 98                	cltq   
   4378f:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43796:	00 
   43797:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4379b:	48 c1 e8 0c          	shr    $0xc,%rax
   4379f:	48 98                	cltq   
   437a1:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   437a8:	00 
   437a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437ad:	48 c1 e8 0c          	shr    $0xc,%rax
   437b1:	48 98                	cltq   
   437b3:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   437ba:	00 
   437bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437bf:	48 c1 e8 0c          	shr    $0xc,%rax
   437c3:	48 98                	cltq   
   437c5:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   437cc:	00 
   437cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437d1:	48 c1 e8 0c          	shr    $0xc,%rax
   437d5:	48 98                	cltq   
   437d7:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   437de:	00 
   437df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437e3:	48 c1 e8 0c          	shr    $0xc,%rax
   437e7:	48 98                	cltq   
   437e9:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   437f0:	00 
   437f1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437f5:	48 c1 e8 0c          	shr    $0xc,%rax
   437f9:	48 98                	cltq   
   437fb:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43802:	00 
   43803:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43807:	48 c1 e8 0c          	shr    $0xc,%rax
   4380b:	48 98                	cltq   
   4380d:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43814:	00 
   43815:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43819:	48 c1 e8 0c          	shr    $0xc,%rax
   4381d:	48 98                	cltq   
   4381f:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43826:	00 
   43827:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4382b:	48 c1 e8 0c          	shr    $0xc,%rax
   4382f:	48 98                	cltq   
   43831:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43838:	00 
   43839:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4383e:	eb 27                	jmp    43867 <process_config_tables+0x34c>
   43840:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43843:	48 63 d0             	movslq %eax,%rdx
   43846:	48 89 d0             	mov    %rdx,%rax
   43849:	48 c1 e0 04          	shl    $0x4,%rax
   4384d:	48 29 d0             	sub    %rdx,%rax
   43850:	48 c1 e0 04          	shl    $0x4,%rax
   43854:	48 8d 90 e0 e0 04 00 	lea    0x4e0e0(%rax),%rdx
   4385b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4385f:	48 89 02             	mov    %rax,(%rdx)
   43862:	b8 00 00 00 00       	mov    $0x0,%eax
   43867:	c9                   	leave  
   43868:	c3                   	ret    

0000000000043869 <process_load>:
   43869:	55                   	push   %rbp
   4386a:	48 89 e5             	mov    %rsp,%rbp
   4386d:	48 83 ec 20          	sub    $0x20,%rsp
   43871:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43875:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43878:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4387c:	48 89 05 7d 37 01 00 	mov    %rax,0x1377d(%rip)        # 57000 <palloc_target_proc>
   43883:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   43886:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4388a:	ba 03 32 04 00       	mov    $0x43203,%edx
   4388f:	89 ce                	mov    %ecx,%esi
   43891:	48 89 c7             	mov    %rax,%rdi
   43894:	e8 2f f5 ff ff       	call   42dc8 <program_load>
   43899:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4389c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4389f:	c9                   	leave  
   438a0:	c3                   	ret    

00000000000438a1 <process_setup_stack>:
   438a1:	55                   	push   %rbp
   438a2:	48 89 e5             	mov    %rsp,%rbp
   438a5:	48 83 ec 20          	sub    $0x20,%rsp
   438a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   438ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438b1:	8b 00                	mov    (%rax),%eax
   438b3:	89 c7                	mov    %eax,%edi
   438b5:	e8 66 f8 ff ff       	call   43120 <palloc>
   438ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   438be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438c2:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   438c9:	00 00 30 00 
   438cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438d1:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   438d8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   438dc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   438e2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   438e8:	b9 00 10 00 00       	mov    $0x1000,%ecx
   438ed:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   438f2:	48 89 c7             	mov    %rax,%rdi
   438f5:	e8 14 f0 ff ff       	call   4290e <virtual_memory_map>
   438fa:	90                   	nop
   438fb:	c9                   	leave  
   438fc:	c3                   	ret    

00000000000438fd <find_free_pid>:
   438fd:	55                   	push   %rbp
   438fe:	48 89 e5             	mov    %rsp,%rbp
   43901:	48 83 ec 10          	sub    $0x10,%rsp
   43905:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4390c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43913:	eb 24                	jmp    43939 <find_free_pid+0x3c>
   43915:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43918:	48 63 d0             	movslq %eax,%rdx
   4391b:	48 89 d0             	mov    %rdx,%rax
   4391e:	48 c1 e0 04          	shl    $0x4,%rax
   43922:	48 29 d0             	sub    %rdx,%rax
   43925:	48 c1 e0 04          	shl    $0x4,%rax
   43929:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   4392f:	8b 00                	mov    (%rax),%eax
   43931:	85 c0                	test   %eax,%eax
   43933:	74 0c                	je     43941 <find_free_pid+0x44>
   43935:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43939:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4393d:	7e d6                	jle    43915 <find_free_pid+0x18>
   4393f:	eb 01                	jmp    43942 <find_free_pid+0x45>
   43941:	90                   	nop
   43942:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   43946:	74 05                	je     4394d <find_free_pid+0x50>
   43948:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4394b:	eb 05                	jmp    43952 <find_free_pid+0x55>
   4394d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43952:	c9                   	leave  
   43953:	c3                   	ret    

0000000000043954 <process_fork>:
   43954:	55                   	push   %rbp
   43955:	48 89 e5             	mov    %rsp,%rbp
   43958:	48 83 ec 40          	sub    $0x40,%rsp
   4395c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43960:	b8 00 00 00 00       	mov    $0x0,%eax
   43965:	e8 93 ff ff ff       	call   438fd <find_free_pid>
   4396a:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4396d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   43971:	75 0a                	jne    4397d <process_fork+0x29>
   43973:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43978:	e9 67 02 00 00       	jmp    43be4 <process_fork+0x290>
   4397d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43980:	48 63 d0             	movslq %eax,%rdx
   43983:	48 89 d0             	mov    %rdx,%rax
   43986:	48 c1 e0 04          	shl    $0x4,%rax
   4398a:	48 29 d0             	sub    %rdx,%rax
   4398d:	48 c1 e0 04          	shl    $0x4,%rax
   43991:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   43997:	be 00 00 00 00       	mov    $0x0,%esi
   4399c:	48 89 c7             	mov    %rax,%rdi
   4399f:	e8 9d e4 ff ff       	call   41e41 <process_init>
   439a4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439a7:	89 c7                	mov    %eax,%edi
   439a9:	e8 6d fb ff ff       	call   4351b <process_config_tables>
   439ae:	83 f8 ff             	cmp    $0xffffffff,%eax
   439b1:	75 0a                	jne    439bd <process_fork+0x69>
   439b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   439b8:	e9 27 02 00 00       	jmp    43be4 <process_fork+0x290>
   439bd:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   439c4:	00 
   439c5:	e9 79 01 00 00       	jmp    43b43 <process_fork+0x1ef>
   439ca:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   439ce:	8b 00                	mov    (%rax),%eax
   439d0:	48 63 d0             	movslq %eax,%rdx
   439d3:	48 89 d0             	mov    %rdx,%rax
   439d6:	48 c1 e0 04          	shl    $0x4,%rax
   439da:	48 29 d0             	sub    %rdx,%rax
   439dd:	48 c1 e0 04          	shl    $0x4,%rax
   439e1:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   439e7:	48 8b 08             	mov    (%rax),%rcx
   439ea:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   439ee:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   439f2:	48 89 ce             	mov    %rcx,%rsi
   439f5:	48 89 c7             	mov    %rax,%rdi
   439f8:	e8 d4 f2 ff ff       	call   42cd1 <virtual_memory_lookup>
   439fd:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43a00:	48 98                	cltq   
   43a02:	83 e0 07             	and    $0x7,%eax
   43a05:	48 83 f8 07          	cmp    $0x7,%rax
   43a09:	0f 85 a1 00 00 00    	jne    43ab0 <process_fork+0x15c>
   43a0f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a12:	89 c7                	mov    %eax,%edi
   43a14:	e8 07 f7 ff ff       	call   43120 <palloc>
   43a19:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43a1d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43a22:	75 14                	jne    43a38 <process_fork+0xe4>
   43a24:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a27:	89 c7                	mov    %eax,%edi
   43a29:	e8 0b f8 ff ff       	call   43239 <process_free>
   43a2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a33:	e9 ac 01 00 00       	jmp    43be4 <process_fork+0x290>
   43a38:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a3c:	48 89 c1             	mov    %rax,%rcx
   43a3f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a43:	ba 00 10 00 00       	mov    $0x1000,%edx
   43a48:	48 89 ce             	mov    %rcx,%rsi
   43a4b:	48 89 c7             	mov    %rax,%rdi
   43a4e:	e8 01 02 00 00       	call   43c54 <memcpy>
   43a53:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   43a57:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a5a:	48 63 d0             	movslq %eax,%rdx
   43a5d:	48 89 d0             	mov    %rdx,%rax
   43a60:	48 c1 e0 04          	shl    $0x4,%rax
   43a64:	48 29 d0             	sub    %rdx,%rax
   43a67:	48 c1 e0 04          	shl    $0x4,%rax
   43a6b:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43a71:	48 8b 00             	mov    (%rax),%rax
   43a74:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43a78:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43a7e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43a84:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a89:	48 89 fa             	mov    %rdi,%rdx
   43a8c:	48 89 c7             	mov    %rax,%rdi
   43a8f:	e8 7a ee ff ff       	call   4290e <virtual_memory_map>
   43a94:	85 c0                	test   %eax,%eax
   43a96:	0f 84 9f 00 00 00    	je     43b3b <process_fork+0x1e7>
   43a9c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a9f:	89 c7                	mov    %eax,%edi
   43aa1:	e8 93 f7 ff ff       	call   43239 <process_free>
   43aa6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43aab:	e9 34 01 00 00       	jmp    43be4 <process_fork+0x290>
   43ab0:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43ab3:	48 98                	cltq   
   43ab5:	83 e0 05             	and    $0x5,%eax
   43ab8:	48 83 f8 05          	cmp    $0x5,%rax
   43abc:	75 7d                	jne    43b3b <process_fork+0x1e7>
   43abe:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43ac2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ac5:	48 63 d0             	movslq %eax,%rdx
   43ac8:	48 89 d0             	mov    %rdx,%rax
   43acb:	48 c1 e0 04          	shl    $0x4,%rax
   43acf:	48 29 d0             	sub    %rdx,%rax
   43ad2:	48 c1 e0 04          	shl    $0x4,%rax
   43ad6:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43adc:	48 8b 00             	mov    (%rax),%rax
   43adf:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43ae3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43ae9:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43aef:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43af4:	48 89 fa             	mov    %rdi,%rdx
   43af7:	48 89 c7             	mov    %rax,%rdi
   43afa:	e8 0f ee ff ff       	call   4290e <virtual_memory_map>
   43aff:	85 c0                	test   %eax,%eax
   43b01:	74 14                	je     43b17 <process_fork+0x1c3>
   43b03:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b06:	89 c7                	mov    %eax,%edi
   43b08:	e8 2c f7 ff ff       	call   43239 <process_free>
   43b0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b12:	e9 cd 00 00 00       	jmp    43be4 <process_fork+0x290>
   43b17:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b1b:	48 c1 e8 0c          	shr    $0xc,%rax
   43b1f:	89 c2                	mov    %eax,%edx
   43b21:	48 63 c2             	movslq %edx,%rax
   43b24:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43b2b:	00 
   43b2c:	83 c0 01             	add    $0x1,%eax
   43b2f:	89 c1                	mov    %eax,%ecx
   43b31:	48 63 c2             	movslq %edx,%rax
   43b34:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   43b3b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43b42:	00 
   43b43:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43b4a:	00 
   43b4b:	0f 86 79 fe ff ff    	jbe    439ca <process_fork+0x76>
   43b51:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43b55:	8b 08                	mov    (%rax),%ecx
   43b57:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b5a:	48 63 d0             	movslq %eax,%rdx
   43b5d:	48 89 d0             	mov    %rdx,%rax
   43b60:	48 c1 e0 04          	shl    $0x4,%rax
   43b64:	48 29 d0             	sub    %rdx,%rax
   43b67:	48 c1 e0 04          	shl    $0x4,%rax
   43b6b:	48 8d b0 10 e0 04 00 	lea    0x4e010(%rax),%rsi
   43b72:	48 63 d1             	movslq %ecx,%rdx
   43b75:	48 89 d0             	mov    %rdx,%rax
   43b78:	48 c1 e0 04          	shl    $0x4,%rax
   43b7c:	48 29 d0             	sub    %rdx,%rax
   43b7f:	48 c1 e0 04          	shl    $0x4,%rax
   43b83:	48 8d 90 10 e0 04 00 	lea    0x4e010(%rax),%rdx
   43b8a:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43b8e:	48 83 c2 08          	add    $0x8,%rdx
   43b92:	b9 18 00 00 00       	mov    $0x18,%ecx
   43b97:	48 89 c7             	mov    %rax,%rdi
   43b9a:	48 89 d6             	mov    %rdx,%rsi
   43b9d:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43ba0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ba3:	48 63 d0             	movslq %eax,%rdx
   43ba6:	48 89 d0             	mov    %rdx,%rax
   43ba9:	48 c1 e0 04          	shl    $0x4,%rax
   43bad:	48 29 d0             	sub    %rdx,%rax
   43bb0:	48 c1 e0 04          	shl    $0x4,%rax
   43bb4:	48 05 18 e0 04 00    	add    $0x4e018,%rax
   43bba:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43bc1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43bc4:	48 63 d0             	movslq %eax,%rdx
   43bc7:	48 89 d0             	mov    %rdx,%rax
   43bca:	48 c1 e0 04          	shl    $0x4,%rax
   43bce:	48 29 d0             	sub    %rdx,%rax
   43bd1:	48 c1 e0 04          	shl    $0x4,%rax
   43bd5:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43bdb:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43be1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43be4:	c9                   	leave  
   43be5:	c3                   	ret    

0000000000043be6 <process_page_alloc>:
   43be6:	55                   	push   %rbp
   43be7:	48 89 e5             	mov    %rsp,%rbp
   43bea:	48 83 ec 20          	sub    $0x20,%rsp
   43bee:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43bf2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43bf6:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43bfd:	00 
   43bfe:	77 07                	ja     43c07 <process_page_alloc+0x21>
   43c00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43c05:	eb 4b                	jmp    43c52 <process_page_alloc+0x6c>
   43c07:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c0b:	8b 00                	mov    (%rax),%eax
   43c0d:	89 c7                	mov    %eax,%edi
   43c0f:	e8 0c f5 ff ff       	call   43120 <palloc>
   43c14:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c18:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43c1d:	74 2e                	je     43c4d <process_page_alloc+0x67>
   43c1f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c27:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43c2e:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   43c32:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43c38:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43c3e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43c43:	48 89 c7             	mov    %rax,%rdi
   43c46:	e8 c3 ec ff ff       	call   4290e <virtual_memory_map>
   43c4b:	eb 05                	jmp    43c52 <process_page_alloc+0x6c>
   43c4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43c52:	c9                   	leave  
   43c53:	c3                   	ret    

0000000000043c54 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43c54:	55                   	push   %rbp
   43c55:	48 89 e5             	mov    %rsp,%rbp
   43c58:	48 83 ec 28          	sub    $0x28,%rsp
   43c5c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c60:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43c64:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43c68:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c6c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43c70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c74:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43c78:	eb 1c                	jmp    43c96 <memcpy+0x42>
        *d = *s;
   43c7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c7e:	0f b6 10             	movzbl (%rax),%edx
   43c81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c85:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43c87:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43c8c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43c91:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43c96:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43c9b:	75 dd                	jne    43c7a <memcpy+0x26>
    }
    return dst;
   43c9d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43ca1:	c9                   	leave  
   43ca2:	c3                   	ret    

0000000000043ca3 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43ca3:	55                   	push   %rbp
   43ca4:	48 89 e5             	mov    %rsp,%rbp
   43ca7:	48 83 ec 28          	sub    $0x28,%rsp
   43cab:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43caf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43cb3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43cb7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43cbb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43cbf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cc3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43cc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ccb:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43ccf:	73 6a                	jae    43d3b <memmove+0x98>
   43cd1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43cd5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cd9:	48 01 d0             	add    %rdx,%rax
   43cdc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43ce0:	73 59                	jae    43d3b <memmove+0x98>
        s += n, d += n;
   43ce2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43ce6:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43cea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cee:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43cf2:	eb 17                	jmp    43d0b <memmove+0x68>
            *--d = *--s;
   43cf4:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43cf9:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43cfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d02:	0f b6 10             	movzbl (%rax),%edx
   43d05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d09:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43d0b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d0f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43d13:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43d17:	48 85 c0             	test   %rax,%rax
   43d1a:	75 d8                	jne    43cf4 <memmove+0x51>
    if (s < d && s + n > d) {
   43d1c:	eb 2e                	jmp    43d4c <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43d1e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43d22:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43d26:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43d2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d2e:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43d32:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43d36:	0f b6 12             	movzbl (%rdx),%edx
   43d39:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43d3b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d3f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43d43:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43d47:	48 85 c0             	test   %rax,%rax
   43d4a:	75 d2                	jne    43d1e <memmove+0x7b>
        }
    }
    return dst;
   43d4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d50:	c9                   	leave  
   43d51:	c3                   	ret    

0000000000043d52 <memset>:

void* memset(void* v, int c, size_t n) {
   43d52:	55                   	push   %rbp
   43d53:	48 89 e5             	mov    %rsp,%rbp
   43d56:	48 83 ec 28          	sub    $0x28,%rsp
   43d5a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d5e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43d61:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43d65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d69:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43d6d:	eb 15                	jmp    43d84 <memset+0x32>
        *p = c;
   43d6f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43d72:	89 c2                	mov    %eax,%edx
   43d74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d78:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43d7a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43d7f:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43d84:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43d89:	75 e4                	jne    43d6f <memset+0x1d>
    }
    return v;
   43d8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d8f:	c9                   	leave  
   43d90:	c3                   	ret    

0000000000043d91 <strlen>:

size_t strlen(const char* s) {
   43d91:	55                   	push   %rbp
   43d92:	48 89 e5             	mov    %rsp,%rbp
   43d95:	48 83 ec 18          	sub    $0x18,%rsp
   43d99:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43d9d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43da4:	00 
   43da5:	eb 0a                	jmp    43db1 <strlen+0x20>
        ++n;
   43da7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43dac:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43db1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43db5:	0f b6 00             	movzbl (%rax),%eax
   43db8:	84 c0                	test   %al,%al
   43dba:	75 eb                	jne    43da7 <strlen+0x16>
    }
    return n;
   43dbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43dc0:	c9                   	leave  
   43dc1:	c3                   	ret    

0000000000043dc2 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43dc2:	55                   	push   %rbp
   43dc3:	48 89 e5             	mov    %rsp,%rbp
   43dc6:	48 83 ec 20          	sub    $0x20,%rsp
   43dca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43dce:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43dd2:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43dd9:	00 
   43dda:	eb 0a                	jmp    43de6 <strnlen+0x24>
        ++n;
   43ddc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43de1:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43de6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dea:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43dee:	74 0b                	je     43dfb <strnlen+0x39>
   43df0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43df4:	0f b6 00             	movzbl (%rax),%eax
   43df7:	84 c0                	test   %al,%al
   43df9:	75 e1                	jne    43ddc <strnlen+0x1a>
    }
    return n;
   43dfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43dff:	c9                   	leave  
   43e00:	c3                   	ret    

0000000000043e01 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43e01:	55                   	push   %rbp
   43e02:	48 89 e5             	mov    %rsp,%rbp
   43e05:	48 83 ec 20          	sub    $0x20,%rsp
   43e09:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43e0d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43e11:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e15:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43e19:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43e1d:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43e21:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43e25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e29:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43e2d:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43e31:	0f b6 12             	movzbl (%rdx),%edx
   43e34:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43e36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e3a:	48 83 e8 01          	sub    $0x1,%rax
   43e3e:	0f b6 00             	movzbl (%rax),%eax
   43e41:	84 c0                	test   %al,%al
   43e43:	75 d4                	jne    43e19 <strcpy+0x18>
    return dst;
   43e45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43e49:	c9                   	leave  
   43e4a:	c3                   	ret    

0000000000043e4b <strcmp>:

int strcmp(const char* a, const char* b) {
   43e4b:	55                   	push   %rbp
   43e4c:	48 89 e5             	mov    %rsp,%rbp
   43e4f:	48 83 ec 10          	sub    $0x10,%rsp
   43e53:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43e57:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43e5b:	eb 0a                	jmp    43e67 <strcmp+0x1c>
        ++a, ++b;
   43e5d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43e62:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43e67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e6b:	0f b6 00             	movzbl (%rax),%eax
   43e6e:	84 c0                	test   %al,%al
   43e70:	74 1d                	je     43e8f <strcmp+0x44>
   43e72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e76:	0f b6 00             	movzbl (%rax),%eax
   43e79:	84 c0                	test   %al,%al
   43e7b:	74 12                	je     43e8f <strcmp+0x44>
   43e7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e81:	0f b6 10             	movzbl (%rax),%edx
   43e84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e88:	0f b6 00             	movzbl (%rax),%eax
   43e8b:	38 c2                	cmp    %al,%dl
   43e8d:	74 ce                	je     43e5d <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43e8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e93:	0f b6 00             	movzbl (%rax),%eax
   43e96:	89 c2                	mov    %eax,%edx
   43e98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e9c:	0f b6 00             	movzbl (%rax),%eax
   43e9f:	38 d0                	cmp    %dl,%al
   43ea1:	0f 92 c0             	setb   %al
   43ea4:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43ea7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43eab:	0f b6 00             	movzbl (%rax),%eax
   43eae:	89 c1                	mov    %eax,%ecx
   43eb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43eb4:	0f b6 00             	movzbl (%rax),%eax
   43eb7:	38 c1                	cmp    %al,%cl
   43eb9:	0f 92 c0             	setb   %al
   43ebc:	0f b6 c0             	movzbl %al,%eax
   43ebf:	29 c2                	sub    %eax,%edx
   43ec1:	89 d0                	mov    %edx,%eax
}
   43ec3:	c9                   	leave  
   43ec4:	c3                   	ret    

0000000000043ec5 <strchr>:

char* strchr(const char* s, int c) {
   43ec5:	55                   	push   %rbp
   43ec6:	48 89 e5             	mov    %rsp,%rbp
   43ec9:	48 83 ec 10          	sub    $0x10,%rsp
   43ecd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43ed1:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43ed4:	eb 05                	jmp    43edb <strchr+0x16>
        ++s;
   43ed6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43edb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43edf:	0f b6 00             	movzbl (%rax),%eax
   43ee2:	84 c0                	test   %al,%al
   43ee4:	74 0e                	je     43ef4 <strchr+0x2f>
   43ee6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43eea:	0f b6 00             	movzbl (%rax),%eax
   43eed:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43ef0:	38 d0                	cmp    %dl,%al
   43ef2:	75 e2                	jne    43ed6 <strchr+0x11>
    }
    if (*s == (char) c) {
   43ef4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ef8:	0f b6 00             	movzbl (%rax),%eax
   43efb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43efe:	38 d0                	cmp    %dl,%al
   43f00:	75 06                	jne    43f08 <strchr+0x43>
        return (char*) s;
   43f02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f06:	eb 05                	jmp    43f0d <strchr+0x48>
    } else {
        return NULL;
   43f08:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43f0d:	c9                   	leave  
   43f0e:	c3                   	ret    

0000000000043f0f <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43f0f:	55                   	push   %rbp
   43f10:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43f13:	8b 05 ef 30 01 00    	mov    0x130ef(%rip),%eax        # 57008 <rand_seed_set>
   43f19:	85 c0                	test   %eax,%eax
   43f1b:	75 0a                	jne    43f27 <rand+0x18>
        srand(819234718U);
   43f1d:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43f22:	e8 24 00 00 00       	call   43f4b <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43f27:	8b 05 df 30 01 00    	mov    0x130df(%rip),%eax        # 5700c <rand_seed>
   43f2d:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43f33:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43f38:	89 05 ce 30 01 00    	mov    %eax,0x130ce(%rip)        # 5700c <rand_seed>
    return rand_seed & RAND_MAX;
   43f3e:	8b 05 c8 30 01 00    	mov    0x130c8(%rip),%eax        # 5700c <rand_seed>
   43f44:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43f49:	5d                   	pop    %rbp
   43f4a:	c3                   	ret    

0000000000043f4b <srand>:

void srand(unsigned seed) {
   43f4b:	55                   	push   %rbp
   43f4c:	48 89 e5             	mov    %rsp,%rbp
   43f4f:	48 83 ec 08          	sub    $0x8,%rsp
   43f53:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43f56:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43f59:	89 05 ad 30 01 00    	mov    %eax,0x130ad(%rip)        # 5700c <rand_seed>
    rand_seed_set = 1;
   43f5f:	c7 05 9f 30 01 00 01 	movl   $0x1,0x1309f(%rip)        # 57008 <rand_seed_set>
   43f66:	00 00 00 
}
   43f69:	90                   	nop
   43f6a:	c9                   	leave  
   43f6b:	c3                   	ret    

0000000000043f6c <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43f6c:	55                   	push   %rbp
   43f6d:	48 89 e5             	mov    %rsp,%rbp
   43f70:	48 83 ec 28          	sub    $0x28,%rsp
   43f74:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43f78:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43f7c:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43f7f:	48 c7 45 f8 20 5b 04 	movq   $0x45b20,-0x8(%rbp)
   43f86:	00 
    if (base < 0) {
   43f87:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43f8b:	79 0b                	jns    43f98 <fill_numbuf+0x2c>
        digits = lower_digits;
   43f8d:	48 c7 45 f8 40 5b 04 	movq   $0x45b40,-0x8(%rbp)
   43f94:	00 
        base = -base;
   43f95:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43f98:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43f9d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43fa1:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43fa4:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43fa7:	48 63 c8             	movslq %eax,%rcx
   43faa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43fae:	ba 00 00 00 00       	mov    $0x0,%edx
   43fb3:	48 f7 f1             	div    %rcx
   43fb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fba:	48 01 d0             	add    %rdx,%rax
   43fbd:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43fc2:	0f b6 10             	movzbl (%rax),%edx
   43fc5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43fc9:	88 10                	mov    %dl,(%rax)
        val /= base;
   43fcb:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43fce:	48 63 f0             	movslq %eax,%rsi
   43fd1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43fd5:	ba 00 00 00 00       	mov    $0x0,%edx
   43fda:	48 f7 f6             	div    %rsi
   43fdd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43fe1:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43fe6:	75 bc                	jne    43fa4 <fill_numbuf+0x38>
    return numbuf_end;
   43fe8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43fec:	c9                   	leave  
   43fed:	c3                   	ret    

0000000000043fee <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43fee:	55                   	push   %rbp
   43fef:	48 89 e5             	mov    %rsp,%rbp
   43ff2:	53                   	push   %rbx
   43ff3:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43ffa:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   44001:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   44007:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4400e:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   44015:	e9 8a 09 00 00       	jmp    449a4 <printer_vprintf+0x9b6>
        if (*format != '%') {
   4401a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44021:	0f b6 00             	movzbl (%rax),%eax
   44024:	3c 25                	cmp    $0x25,%al
   44026:	74 31                	je     44059 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   44028:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4402f:	4c 8b 00             	mov    (%rax),%r8
   44032:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44039:	0f b6 00             	movzbl (%rax),%eax
   4403c:	0f b6 c8             	movzbl %al,%ecx
   4403f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44045:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4404c:	89 ce                	mov    %ecx,%esi
   4404e:	48 89 c7             	mov    %rax,%rdi
   44051:	41 ff d0             	call   *%r8
            continue;
   44054:	e9 43 09 00 00       	jmp    4499c <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   44059:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   44060:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44067:	01 
   44068:	eb 44                	jmp    440ae <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   4406a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44071:	0f b6 00             	movzbl (%rax),%eax
   44074:	0f be c0             	movsbl %al,%eax
   44077:	89 c6                	mov    %eax,%esi
   44079:	bf 40 59 04 00       	mov    $0x45940,%edi
   4407e:	e8 42 fe ff ff       	call   43ec5 <strchr>
   44083:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   44087:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4408c:	74 30                	je     440be <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   4408e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   44092:	48 2d 40 59 04 00    	sub    $0x45940,%rax
   44098:	ba 01 00 00 00       	mov    $0x1,%edx
   4409d:	89 c1                	mov    %eax,%ecx
   4409f:	d3 e2                	shl    %cl,%edx
   440a1:	89 d0                	mov    %edx,%eax
   440a3:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   440a6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   440ad:	01 
   440ae:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440b5:	0f b6 00             	movzbl (%rax),%eax
   440b8:	84 c0                	test   %al,%al
   440ba:	75 ae                	jne    4406a <printer_vprintf+0x7c>
   440bc:	eb 01                	jmp    440bf <printer_vprintf+0xd1>
            } else {
                break;
   440be:	90                   	nop
            }
        }

        // process width
        int width = -1;
   440bf:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   440c6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440cd:	0f b6 00             	movzbl (%rax),%eax
   440d0:	3c 30                	cmp    $0x30,%al
   440d2:	7e 67                	jle    4413b <printer_vprintf+0x14d>
   440d4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440db:	0f b6 00             	movzbl (%rax),%eax
   440de:	3c 39                	cmp    $0x39,%al
   440e0:	7f 59                	jg     4413b <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   440e2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   440e9:	eb 2e                	jmp    44119 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   440eb:	8b 55 e8             	mov    -0x18(%rbp),%edx
   440ee:	89 d0                	mov    %edx,%eax
   440f0:	c1 e0 02             	shl    $0x2,%eax
   440f3:	01 d0                	add    %edx,%eax
   440f5:	01 c0                	add    %eax,%eax
   440f7:	89 c1                	mov    %eax,%ecx
   440f9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44100:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44104:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4410b:	0f b6 00             	movzbl (%rax),%eax
   4410e:	0f be c0             	movsbl %al,%eax
   44111:	01 c8                	add    %ecx,%eax
   44113:	83 e8 30             	sub    $0x30,%eax
   44116:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44119:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44120:	0f b6 00             	movzbl (%rax),%eax
   44123:	3c 2f                	cmp    $0x2f,%al
   44125:	0f 8e 85 00 00 00    	jle    441b0 <printer_vprintf+0x1c2>
   4412b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44132:	0f b6 00             	movzbl (%rax),%eax
   44135:	3c 39                	cmp    $0x39,%al
   44137:	7e b2                	jle    440eb <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   44139:	eb 75                	jmp    441b0 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   4413b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44142:	0f b6 00             	movzbl (%rax),%eax
   44145:	3c 2a                	cmp    $0x2a,%al
   44147:	75 68                	jne    441b1 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   44149:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44150:	8b 00                	mov    (%rax),%eax
   44152:	83 f8 2f             	cmp    $0x2f,%eax
   44155:	77 30                	ja     44187 <printer_vprintf+0x199>
   44157:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4415e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44162:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44169:	8b 00                	mov    (%rax),%eax
   4416b:	89 c0                	mov    %eax,%eax
   4416d:	48 01 d0             	add    %rdx,%rax
   44170:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44177:	8b 12                	mov    (%rdx),%edx
   44179:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4417c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44183:	89 0a                	mov    %ecx,(%rdx)
   44185:	eb 1a                	jmp    441a1 <printer_vprintf+0x1b3>
   44187:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4418e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44192:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44196:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4419d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441a1:	8b 00                	mov    (%rax),%eax
   441a3:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   441a6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441ad:	01 
   441ae:	eb 01                	jmp    441b1 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   441b0:	90                   	nop
        }

        // process precision
        int precision = -1;
   441b1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   441b8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441bf:	0f b6 00             	movzbl (%rax),%eax
   441c2:	3c 2e                	cmp    $0x2e,%al
   441c4:	0f 85 00 01 00 00    	jne    442ca <printer_vprintf+0x2dc>
            ++format;
   441ca:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441d1:	01 
            if (*format >= '0' && *format <= '9') {
   441d2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441d9:	0f b6 00             	movzbl (%rax),%eax
   441dc:	3c 2f                	cmp    $0x2f,%al
   441de:	7e 67                	jle    44247 <printer_vprintf+0x259>
   441e0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441e7:	0f b6 00             	movzbl (%rax),%eax
   441ea:	3c 39                	cmp    $0x39,%al
   441ec:	7f 59                	jg     44247 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   441ee:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   441f5:	eb 2e                	jmp    44225 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   441f7:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   441fa:	89 d0                	mov    %edx,%eax
   441fc:	c1 e0 02             	shl    $0x2,%eax
   441ff:	01 d0                	add    %edx,%eax
   44201:	01 c0                	add    %eax,%eax
   44203:	89 c1                	mov    %eax,%ecx
   44205:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4420c:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44210:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44217:	0f b6 00             	movzbl (%rax),%eax
   4421a:	0f be c0             	movsbl %al,%eax
   4421d:	01 c8                	add    %ecx,%eax
   4421f:	83 e8 30             	sub    $0x30,%eax
   44222:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44225:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4422c:	0f b6 00             	movzbl (%rax),%eax
   4422f:	3c 2f                	cmp    $0x2f,%al
   44231:	0f 8e 85 00 00 00    	jle    442bc <printer_vprintf+0x2ce>
   44237:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4423e:	0f b6 00             	movzbl (%rax),%eax
   44241:	3c 39                	cmp    $0x39,%al
   44243:	7e b2                	jle    441f7 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   44245:	eb 75                	jmp    442bc <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   44247:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4424e:	0f b6 00             	movzbl (%rax),%eax
   44251:	3c 2a                	cmp    $0x2a,%al
   44253:	75 68                	jne    442bd <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   44255:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4425c:	8b 00                	mov    (%rax),%eax
   4425e:	83 f8 2f             	cmp    $0x2f,%eax
   44261:	77 30                	ja     44293 <printer_vprintf+0x2a5>
   44263:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4426a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4426e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44275:	8b 00                	mov    (%rax),%eax
   44277:	89 c0                	mov    %eax,%eax
   44279:	48 01 d0             	add    %rdx,%rax
   4427c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44283:	8b 12                	mov    (%rdx),%edx
   44285:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44288:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4428f:	89 0a                	mov    %ecx,(%rdx)
   44291:	eb 1a                	jmp    442ad <printer_vprintf+0x2bf>
   44293:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4429a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4429e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442a2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442a9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442ad:	8b 00                	mov    (%rax),%eax
   442af:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   442b2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   442b9:	01 
   442ba:	eb 01                	jmp    442bd <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   442bc:	90                   	nop
            }
            if (precision < 0) {
   442bd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   442c1:	79 07                	jns    442ca <printer_vprintf+0x2dc>
                precision = 0;
   442c3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   442ca:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   442d1:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   442d8:	00 
        int length = 0;
   442d9:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   442e0:	48 c7 45 c8 46 59 04 	movq   $0x45946,-0x38(%rbp)
   442e7:	00 
    again:
        switch (*format) {
   442e8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   442ef:	0f b6 00             	movzbl (%rax),%eax
   442f2:	0f be c0             	movsbl %al,%eax
   442f5:	83 e8 43             	sub    $0x43,%eax
   442f8:	83 f8 37             	cmp    $0x37,%eax
   442fb:	0f 87 9f 03 00 00    	ja     446a0 <printer_vprintf+0x6b2>
   44301:	89 c0                	mov    %eax,%eax
   44303:	48 8b 04 c5 58 59 04 	mov    0x45958(,%rax,8),%rax
   4430a:	00 
   4430b:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   4430d:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   44314:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4431b:	01 
            goto again;
   4431c:	eb ca                	jmp    442e8 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   4431e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44322:	74 5d                	je     44381 <printer_vprintf+0x393>
   44324:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4432b:	8b 00                	mov    (%rax),%eax
   4432d:	83 f8 2f             	cmp    $0x2f,%eax
   44330:	77 30                	ja     44362 <printer_vprintf+0x374>
   44332:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44339:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4433d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44344:	8b 00                	mov    (%rax),%eax
   44346:	89 c0                	mov    %eax,%eax
   44348:	48 01 d0             	add    %rdx,%rax
   4434b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44352:	8b 12                	mov    (%rdx),%edx
   44354:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44357:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4435e:	89 0a                	mov    %ecx,(%rdx)
   44360:	eb 1a                	jmp    4437c <printer_vprintf+0x38e>
   44362:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44369:	48 8b 40 08          	mov    0x8(%rax),%rax
   4436d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44371:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44378:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4437c:	48 8b 00             	mov    (%rax),%rax
   4437f:	eb 5c                	jmp    443dd <printer_vprintf+0x3ef>
   44381:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44388:	8b 00                	mov    (%rax),%eax
   4438a:	83 f8 2f             	cmp    $0x2f,%eax
   4438d:	77 30                	ja     443bf <printer_vprintf+0x3d1>
   4438f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44396:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4439a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443a1:	8b 00                	mov    (%rax),%eax
   443a3:	89 c0                	mov    %eax,%eax
   443a5:	48 01 d0             	add    %rdx,%rax
   443a8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443af:	8b 12                	mov    (%rdx),%edx
   443b1:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443b4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443bb:	89 0a                	mov    %ecx,(%rdx)
   443bd:	eb 1a                	jmp    443d9 <printer_vprintf+0x3eb>
   443bf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443c6:	48 8b 40 08          	mov    0x8(%rax),%rax
   443ca:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443ce:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443d5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443d9:	8b 00                	mov    (%rax),%eax
   443db:	48 98                	cltq   
   443dd:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   443e1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   443e5:	48 c1 f8 38          	sar    $0x38,%rax
   443e9:	25 80 00 00 00       	and    $0x80,%eax
   443ee:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   443f1:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   443f5:	74 09                	je     44400 <printer_vprintf+0x412>
   443f7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   443fb:	48 f7 d8             	neg    %rax
   443fe:	eb 04                	jmp    44404 <printer_vprintf+0x416>
   44400:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44404:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   44408:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   4440b:	83 c8 60             	or     $0x60,%eax
   4440e:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44411:	e9 cf 02 00 00       	jmp    446e5 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   44416:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4441a:	74 5d                	je     44479 <printer_vprintf+0x48b>
   4441c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44423:	8b 00                	mov    (%rax),%eax
   44425:	83 f8 2f             	cmp    $0x2f,%eax
   44428:	77 30                	ja     4445a <printer_vprintf+0x46c>
   4442a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44431:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44435:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4443c:	8b 00                	mov    (%rax),%eax
   4443e:	89 c0                	mov    %eax,%eax
   44440:	48 01 d0             	add    %rdx,%rax
   44443:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4444a:	8b 12                	mov    (%rdx),%edx
   4444c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4444f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44456:	89 0a                	mov    %ecx,(%rdx)
   44458:	eb 1a                	jmp    44474 <printer_vprintf+0x486>
   4445a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44461:	48 8b 40 08          	mov    0x8(%rax),%rax
   44465:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44469:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44470:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44474:	48 8b 00             	mov    (%rax),%rax
   44477:	eb 5c                	jmp    444d5 <printer_vprintf+0x4e7>
   44479:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44480:	8b 00                	mov    (%rax),%eax
   44482:	83 f8 2f             	cmp    $0x2f,%eax
   44485:	77 30                	ja     444b7 <printer_vprintf+0x4c9>
   44487:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4448e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44492:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44499:	8b 00                	mov    (%rax),%eax
   4449b:	89 c0                	mov    %eax,%eax
   4449d:	48 01 d0             	add    %rdx,%rax
   444a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444a7:	8b 12                	mov    (%rdx),%edx
   444a9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444ac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444b3:	89 0a                	mov    %ecx,(%rdx)
   444b5:	eb 1a                	jmp    444d1 <printer_vprintf+0x4e3>
   444b7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444be:	48 8b 40 08          	mov    0x8(%rax),%rax
   444c2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444cd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444d1:	8b 00                	mov    (%rax),%eax
   444d3:	89 c0                	mov    %eax,%eax
   444d5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   444d9:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   444dd:	e9 03 02 00 00       	jmp    446e5 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   444e2:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   444e9:	e9 28 ff ff ff       	jmp    44416 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   444ee:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   444f5:	e9 1c ff ff ff       	jmp    44416 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   444fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44501:	8b 00                	mov    (%rax),%eax
   44503:	83 f8 2f             	cmp    $0x2f,%eax
   44506:	77 30                	ja     44538 <printer_vprintf+0x54a>
   44508:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4450f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44513:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4451a:	8b 00                	mov    (%rax),%eax
   4451c:	89 c0                	mov    %eax,%eax
   4451e:	48 01 d0             	add    %rdx,%rax
   44521:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44528:	8b 12                	mov    (%rdx),%edx
   4452a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4452d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44534:	89 0a                	mov    %ecx,(%rdx)
   44536:	eb 1a                	jmp    44552 <printer_vprintf+0x564>
   44538:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4453f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44543:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44547:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4454e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44552:	48 8b 00             	mov    (%rax),%rax
   44555:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   44559:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   44560:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   44567:	e9 79 01 00 00       	jmp    446e5 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   4456c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44573:	8b 00                	mov    (%rax),%eax
   44575:	83 f8 2f             	cmp    $0x2f,%eax
   44578:	77 30                	ja     445aa <printer_vprintf+0x5bc>
   4457a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44581:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44585:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4458c:	8b 00                	mov    (%rax),%eax
   4458e:	89 c0                	mov    %eax,%eax
   44590:	48 01 d0             	add    %rdx,%rax
   44593:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4459a:	8b 12                	mov    (%rdx),%edx
   4459c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4459f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445a6:	89 0a                	mov    %ecx,(%rdx)
   445a8:	eb 1a                	jmp    445c4 <printer_vprintf+0x5d6>
   445aa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445b1:	48 8b 40 08          	mov    0x8(%rax),%rax
   445b5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445b9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445c0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445c4:	48 8b 00             	mov    (%rax),%rax
   445c7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   445cb:	e9 15 01 00 00       	jmp    446e5 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   445d0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445d7:	8b 00                	mov    (%rax),%eax
   445d9:	83 f8 2f             	cmp    $0x2f,%eax
   445dc:	77 30                	ja     4460e <printer_vprintf+0x620>
   445de:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445e5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445f0:	8b 00                	mov    (%rax),%eax
   445f2:	89 c0                	mov    %eax,%eax
   445f4:	48 01 d0             	add    %rdx,%rax
   445f7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445fe:	8b 12                	mov    (%rdx),%edx
   44600:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44603:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4460a:	89 0a                	mov    %ecx,(%rdx)
   4460c:	eb 1a                	jmp    44628 <printer_vprintf+0x63a>
   4460e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44615:	48 8b 40 08          	mov    0x8(%rax),%rax
   44619:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4461d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44624:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44628:	8b 00                	mov    (%rax),%eax
   4462a:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   44630:	e9 67 03 00 00       	jmp    4499c <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   44635:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44639:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   4463d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44644:	8b 00                	mov    (%rax),%eax
   44646:	83 f8 2f             	cmp    $0x2f,%eax
   44649:	77 30                	ja     4467b <printer_vprintf+0x68d>
   4464b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44652:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44656:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4465d:	8b 00                	mov    (%rax),%eax
   4465f:	89 c0                	mov    %eax,%eax
   44661:	48 01 d0             	add    %rdx,%rax
   44664:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4466b:	8b 12                	mov    (%rdx),%edx
   4466d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44670:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44677:	89 0a                	mov    %ecx,(%rdx)
   44679:	eb 1a                	jmp    44695 <printer_vprintf+0x6a7>
   4467b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44682:	48 8b 40 08          	mov    0x8(%rax),%rax
   44686:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4468a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44691:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44695:	8b 00                	mov    (%rax),%eax
   44697:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   4469a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   4469e:	eb 45                	jmp    446e5 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   446a0:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   446a4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   446a8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   446af:	0f b6 00             	movzbl (%rax),%eax
   446b2:	84 c0                	test   %al,%al
   446b4:	74 0c                	je     446c2 <printer_vprintf+0x6d4>
   446b6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   446bd:	0f b6 00             	movzbl (%rax),%eax
   446c0:	eb 05                	jmp    446c7 <printer_vprintf+0x6d9>
   446c2:	b8 25 00 00 00       	mov    $0x25,%eax
   446c7:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   446ca:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   446ce:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   446d5:	0f b6 00             	movzbl (%rax),%eax
   446d8:	84 c0                	test   %al,%al
   446da:	75 08                	jne    446e4 <printer_vprintf+0x6f6>
                format--;
   446dc:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   446e3:	01 
            }
            break;
   446e4:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   446e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446e8:	83 e0 20             	and    $0x20,%eax
   446eb:	85 c0                	test   %eax,%eax
   446ed:	74 1e                	je     4470d <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   446ef:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   446f3:	48 83 c0 18          	add    $0x18,%rax
   446f7:	8b 55 e0             	mov    -0x20(%rbp),%edx
   446fa:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   446fe:	48 89 ce             	mov    %rcx,%rsi
   44701:	48 89 c7             	mov    %rax,%rdi
   44704:	e8 63 f8 ff ff       	call   43f6c <fill_numbuf>
   44709:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   4470d:	48 c7 45 c0 46 59 04 	movq   $0x45946,-0x40(%rbp)
   44714:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44715:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44718:	83 e0 20             	and    $0x20,%eax
   4471b:	85 c0                	test   %eax,%eax
   4471d:	74 48                	je     44767 <printer_vprintf+0x779>
   4471f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44722:	83 e0 40             	and    $0x40,%eax
   44725:	85 c0                	test   %eax,%eax
   44727:	74 3e                	je     44767 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   44729:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4472c:	25 80 00 00 00       	and    $0x80,%eax
   44731:	85 c0                	test   %eax,%eax
   44733:	74 0a                	je     4473f <printer_vprintf+0x751>
                prefix = "-";
   44735:	48 c7 45 c0 47 59 04 	movq   $0x45947,-0x40(%rbp)
   4473c:	00 
            if (flags & FLAG_NEGATIVE) {
   4473d:	eb 73                	jmp    447b2 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   4473f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44742:	83 e0 10             	and    $0x10,%eax
   44745:	85 c0                	test   %eax,%eax
   44747:	74 0a                	je     44753 <printer_vprintf+0x765>
                prefix = "+";
   44749:	48 c7 45 c0 49 59 04 	movq   $0x45949,-0x40(%rbp)
   44750:	00 
            if (flags & FLAG_NEGATIVE) {
   44751:	eb 5f                	jmp    447b2 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44753:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44756:	83 e0 08             	and    $0x8,%eax
   44759:	85 c0                	test   %eax,%eax
   4475b:	74 55                	je     447b2 <printer_vprintf+0x7c4>
                prefix = " ";
   4475d:	48 c7 45 c0 4b 59 04 	movq   $0x4594b,-0x40(%rbp)
   44764:	00 
            if (flags & FLAG_NEGATIVE) {
   44765:	eb 4b                	jmp    447b2 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44767:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4476a:	83 e0 20             	and    $0x20,%eax
   4476d:	85 c0                	test   %eax,%eax
   4476f:	74 42                	je     447b3 <printer_vprintf+0x7c5>
   44771:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44774:	83 e0 01             	and    $0x1,%eax
   44777:	85 c0                	test   %eax,%eax
   44779:	74 38                	je     447b3 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   4477b:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   4477f:	74 06                	je     44787 <printer_vprintf+0x799>
   44781:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44785:	75 2c                	jne    447b3 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   44787:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4478c:	75 0c                	jne    4479a <printer_vprintf+0x7ac>
   4478e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44791:	25 00 01 00 00       	and    $0x100,%eax
   44796:	85 c0                	test   %eax,%eax
   44798:	74 19                	je     447b3 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   4479a:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4479e:	75 07                	jne    447a7 <printer_vprintf+0x7b9>
   447a0:	b8 4d 59 04 00       	mov    $0x4594d,%eax
   447a5:	eb 05                	jmp    447ac <printer_vprintf+0x7be>
   447a7:	b8 50 59 04 00       	mov    $0x45950,%eax
   447ac:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   447b0:	eb 01                	jmp    447b3 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   447b2:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   447b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   447b7:	78 24                	js     447dd <printer_vprintf+0x7ef>
   447b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   447bc:	83 e0 20             	and    $0x20,%eax
   447bf:	85 c0                	test   %eax,%eax
   447c1:	75 1a                	jne    447dd <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   447c3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   447c6:	48 63 d0             	movslq %eax,%rdx
   447c9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   447cd:	48 89 d6             	mov    %rdx,%rsi
   447d0:	48 89 c7             	mov    %rax,%rdi
   447d3:	e8 ea f5 ff ff       	call   43dc2 <strnlen>
   447d8:	89 45 bc             	mov    %eax,-0x44(%rbp)
   447db:	eb 0f                	jmp    447ec <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   447dd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   447e1:	48 89 c7             	mov    %rax,%rdi
   447e4:	e8 a8 f5 ff ff       	call   43d91 <strlen>
   447e9:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   447ec:	8b 45 ec             	mov    -0x14(%rbp),%eax
   447ef:	83 e0 20             	and    $0x20,%eax
   447f2:	85 c0                	test   %eax,%eax
   447f4:	74 20                	je     44816 <printer_vprintf+0x828>
   447f6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   447fa:	78 1a                	js     44816 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   447fc:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   447ff:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44802:	7e 08                	jle    4480c <printer_vprintf+0x81e>
   44804:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44807:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4480a:	eb 05                	jmp    44811 <printer_vprintf+0x823>
   4480c:	b8 00 00 00 00       	mov    $0x0,%eax
   44811:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44814:	eb 5c                	jmp    44872 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44816:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44819:	83 e0 20             	and    $0x20,%eax
   4481c:	85 c0                	test   %eax,%eax
   4481e:	74 4b                	je     4486b <printer_vprintf+0x87d>
   44820:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44823:	83 e0 02             	and    $0x2,%eax
   44826:	85 c0                	test   %eax,%eax
   44828:	74 41                	je     4486b <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   4482a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4482d:	83 e0 04             	and    $0x4,%eax
   44830:	85 c0                	test   %eax,%eax
   44832:	75 37                	jne    4486b <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   44834:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44838:	48 89 c7             	mov    %rax,%rdi
   4483b:	e8 51 f5 ff ff       	call   43d91 <strlen>
   44840:	89 c2                	mov    %eax,%edx
   44842:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44845:	01 d0                	add    %edx,%eax
   44847:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   4484a:	7e 1f                	jle    4486b <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   4484c:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4484f:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44852:	89 c3                	mov    %eax,%ebx
   44854:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44858:	48 89 c7             	mov    %rax,%rdi
   4485b:	e8 31 f5 ff ff       	call   43d91 <strlen>
   44860:	89 c2                	mov    %eax,%edx
   44862:	89 d8                	mov    %ebx,%eax
   44864:	29 d0                	sub    %edx,%eax
   44866:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44869:	eb 07                	jmp    44872 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   4486b:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44872:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44875:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44878:	01 d0                	add    %edx,%eax
   4487a:	48 63 d8             	movslq %eax,%rbx
   4487d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44881:	48 89 c7             	mov    %rax,%rdi
   44884:	e8 08 f5 ff ff       	call   43d91 <strlen>
   44889:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   4488d:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44890:	29 d0                	sub    %edx,%eax
   44892:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44895:	eb 25                	jmp    448bc <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   44897:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4489e:	48 8b 08             	mov    (%rax),%rcx
   448a1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448a7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448ae:	be 20 00 00 00       	mov    $0x20,%esi
   448b3:	48 89 c7             	mov    %rax,%rdi
   448b6:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   448b8:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   448bc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448bf:	83 e0 04             	and    $0x4,%eax
   448c2:	85 c0                	test   %eax,%eax
   448c4:	75 36                	jne    448fc <printer_vprintf+0x90e>
   448c6:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   448ca:	7f cb                	jg     44897 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   448cc:	eb 2e                	jmp    448fc <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   448ce:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448d5:	4c 8b 00             	mov    (%rax),%r8
   448d8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   448dc:	0f b6 00             	movzbl (%rax),%eax
   448df:	0f b6 c8             	movzbl %al,%ecx
   448e2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448e8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448ef:	89 ce                	mov    %ecx,%esi
   448f1:	48 89 c7             	mov    %rax,%rdi
   448f4:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   448f7:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   448fc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44900:	0f b6 00             	movzbl (%rax),%eax
   44903:	84 c0                	test   %al,%al
   44905:	75 c7                	jne    448ce <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   44907:	eb 25                	jmp    4492e <printer_vprintf+0x940>
            p->putc(p, '0', color);
   44909:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44910:	48 8b 08             	mov    (%rax),%rcx
   44913:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44919:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44920:	be 30 00 00 00       	mov    $0x30,%esi
   44925:	48 89 c7             	mov    %rax,%rdi
   44928:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   4492a:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   4492e:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44932:	7f d5                	jg     44909 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   44934:	eb 32                	jmp    44968 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   44936:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4493d:	4c 8b 00             	mov    (%rax),%r8
   44940:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44944:	0f b6 00             	movzbl (%rax),%eax
   44947:	0f b6 c8             	movzbl %al,%ecx
   4494a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44950:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44957:	89 ce                	mov    %ecx,%esi
   44959:	48 89 c7             	mov    %rax,%rdi
   4495c:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   4495f:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44964:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44968:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   4496c:	7f c8                	jg     44936 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   4496e:	eb 25                	jmp    44995 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   44970:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44977:	48 8b 08             	mov    (%rax),%rcx
   4497a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44980:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44987:	be 20 00 00 00       	mov    $0x20,%esi
   4498c:	48 89 c7             	mov    %rax,%rdi
   4498f:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44991:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44995:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44999:	7f d5                	jg     44970 <printer_vprintf+0x982>
        }
    done: ;
   4499b:	90                   	nop
    for (; *format; ++format) {
   4499c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   449a3:	01 
   449a4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   449ab:	0f b6 00             	movzbl (%rax),%eax
   449ae:	84 c0                	test   %al,%al
   449b0:	0f 85 64 f6 ff ff    	jne    4401a <printer_vprintf+0x2c>
    }
}
   449b6:	90                   	nop
   449b7:	90                   	nop
   449b8:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   449bc:	c9                   	leave  
   449bd:	c3                   	ret    

00000000000449be <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   449be:	55                   	push   %rbp
   449bf:	48 89 e5             	mov    %rsp,%rbp
   449c2:	48 83 ec 20          	sub    $0x20,%rsp
   449c6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   449ca:	89 f0                	mov    %esi,%eax
   449cc:	89 55 e0             	mov    %edx,-0x20(%rbp)
   449cf:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   449d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   449d6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   449da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449de:	48 8b 40 08          	mov    0x8(%rax),%rax
   449e2:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   449e7:	48 39 d0             	cmp    %rdx,%rax
   449ea:	72 0c                	jb     449f8 <console_putc+0x3a>
        cp->cursor = console;
   449ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449f0:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   449f7:	00 
    }
    if (c == '\n') {
   449f8:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   449fc:	75 78                	jne    44a76 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   449fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a02:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a06:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44a0c:	48 d1 f8             	sar    %rax
   44a0f:	48 89 c1             	mov    %rax,%rcx
   44a12:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44a19:	66 66 66 
   44a1c:	48 89 c8             	mov    %rcx,%rax
   44a1f:	48 f7 ea             	imul   %rdx
   44a22:	48 c1 fa 05          	sar    $0x5,%rdx
   44a26:	48 89 c8             	mov    %rcx,%rax
   44a29:	48 c1 f8 3f          	sar    $0x3f,%rax
   44a2d:	48 29 c2             	sub    %rax,%rdx
   44a30:	48 89 d0             	mov    %rdx,%rax
   44a33:	48 c1 e0 02          	shl    $0x2,%rax
   44a37:	48 01 d0             	add    %rdx,%rax
   44a3a:	48 c1 e0 04          	shl    $0x4,%rax
   44a3e:	48 29 c1             	sub    %rax,%rcx
   44a41:	48 89 ca             	mov    %rcx,%rdx
   44a44:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44a47:	eb 25                	jmp    44a6e <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   44a49:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44a4c:	83 c8 20             	or     $0x20,%eax
   44a4f:	89 c6                	mov    %eax,%esi
   44a51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a55:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a59:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44a5d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44a61:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a65:	89 f2                	mov    %esi,%edx
   44a67:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44a6a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44a6e:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44a72:	75 d5                	jne    44a49 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44a74:	eb 24                	jmp    44a9a <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44a76:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   44a7a:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44a7d:	09 d0                	or     %edx,%eax
   44a7f:	89 c6                	mov    %eax,%esi
   44a81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a85:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a89:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44a8d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44a91:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a95:	89 f2                	mov    %esi,%edx
   44a97:	66 89 10             	mov    %dx,(%rax)
}
   44a9a:	90                   	nop
   44a9b:	c9                   	leave  
   44a9c:	c3                   	ret    

0000000000044a9d <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44a9d:	55                   	push   %rbp
   44a9e:	48 89 e5             	mov    %rsp,%rbp
   44aa1:	48 83 ec 30          	sub    $0x30,%rsp
   44aa5:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44aa8:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44aab:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44aaf:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44ab3:	48 c7 45 f0 be 49 04 	movq   $0x449be,-0x10(%rbp)
   44aba:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44abb:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44abf:	78 09                	js     44aca <console_vprintf+0x2d>
   44ac1:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44ac8:	7e 07                	jle    44ad1 <console_vprintf+0x34>
        cpos = 0;
   44aca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44ad1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44ad4:	48 98                	cltq   
   44ad6:	48 01 c0             	add    %rax,%rax
   44ad9:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44adf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44ae3:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44ae7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44aeb:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44aee:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44af2:	48 89 c7             	mov    %rax,%rdi
   44af5:	e8 f4 f4 ff ff       	call   43fee <printer_vprintf>
    return cp.cursor - console;
   44afa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44afe:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44b04:	48 d1 f8             	sar    %rax
}
   44b07:	c9                   	leave  
   44b08:	c3                   	ret    

0000000000044b09 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44b09:	55                   	push   %rbp
   44b0a:	48 89 e5             	mov    %rsp,%rbp
   44b0d:	48 83 ec 60          	sub    $0x60,%rsp
   44b11:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44b14:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44b17:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44b1b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44b1f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44b23:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44b27:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44b2e:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44b32:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44b36:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44b3a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44b3e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44b42:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44b46:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44b49:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44b4c:	89 c7                	mov    %eax,%edi
   44b4e:	e8 4a ff ff ff       	call   44a9d <console_vprintf>
   44b53:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44b56:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44b59:	c9                   	leave  
   44b5a:	c3                   	ret    

0000000000044b5b <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44b5b:	55                   	push   %rbp
   44b5c:	48 89 e5             	mov    %rsp,%rbp
   44b5f:	48 83 ec 20          	sub    $0x20,%rsp
   44b63:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44b67:	89 f0                	mov    %esi,%eax
   44b69:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44b6c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44b6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44b73:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44b77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b7b:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44b7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b83:	48 8b 40 10          	mov    0x10(%rax),%rax
   44b87:	48 39 c2             	cmp    %rax,%rdx
   44b8a:	73 1a                	jae    44ba6 <string_putc+0x4b>
        *sp->s++ = c;
   44b8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b90:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b94:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44b98:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44b9c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44ba0:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44ba4:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44ba6:	90                   	nop
   44ba7:	c9                   	leave  
   44ba8:	c3                   	ret    

0000000000044ba9 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44ba9:	55                   	push   %rbp
   44baa:	48 89 e5             	mov    %rsp,%rbp
   44bad:	48 83 ec 40          	sub    $0x40,%rsp
   44bb1:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44bb5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44bb9:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44bbd:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44bc1:	48 c7 45 e8 5b 4b 04 	movq   $0x44b5b,-0x18(%rbp)
   44bc8:	00 
    sp.s = s;
   44bc9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44bcd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44bd1:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44bd6:	74 33                	je     44c0b <vsnprintf+0x62>
        sp.end = s + size - 1;
   44bd8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44bdc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44be0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44be4:	48 01 d0             	add    %rdx,%rax
   44be7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44beb:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44bef:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44bf3:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44bf7:	be 00 00 00 00       	mov    $0x0,%esi
   44bfc:	48 89 c7             	mov    %rax,%rdi
   44bff:	e8 ea f3 ff ff       	call   43fee <printer_vprintf>
        *sp.s = 0;
   44c04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44c08:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44c0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44c0f:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44c13:	c9                   	leave  
   44c14:	c3                   	ret    

0000000000044c15 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44c15:	55                   	push   %rbp
   44c16:	48 89 e5             	mov    %rsp,%rbp
   44c19:	48 83 ec 70          	sub    $0x70,%rsp
   44c1d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44c21:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44c25:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44c29:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44c2d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44c31:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44c35:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44c3c:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44c40:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44c44:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44c48:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44c4c:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44c50:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44c54:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44c58:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44c5c:	48 89 c7             	mov    %rax,%rdi
   44c5f:	e8 45 ff ff ff       	call   44ba9 <vsnprintf>
   44c64:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44c67:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44c6a:	c9                   	leave  
   44c6b:	c3                   	ret    

0000000000044c6c <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44c6c:	55                   	push   %rbp
   44c6d:	48 89 e5             	mov    %rsp,%rbp
   44c70:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44c74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44c7b:	eb 13                	jmp    44c90 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44c7d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44c80:	48 98                	cltq   
   44c82:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44c89:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44c8c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44c90:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44c97:	7e e4                	jle    44c7d <console_clear+0x11>
    }
    cursorpos = 0;
   44c99:	c7 05 59 43 07 00 00 	movl   $0x0,0x74359(%rip)        # b8ffc <cursorpos>
   44ca0:	00 00 00 
}
   44ca3:	90                   	nop
   44ca4:	c9                   	leave  
   44ca5:	c3                   	ret    
