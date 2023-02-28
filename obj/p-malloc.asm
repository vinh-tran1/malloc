
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

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

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 0f 30 10 00       	mov    $0x10300f,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 e9 1f 00 00 	mov    %rax,0x1fe9(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 cd 1f 00 00 	mov    %rax,0x1fcd(%rip)        # 102000 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 8a 07 00 00       	call   1007c6 <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 05 02 00 00       	call   100269 <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <init_node>:
//====================================================//

//-----------helper functions------------------//
void init_node(bh* ptr, int allocated, size_t size)
{
    ptr->allocated = allocated;
  100071:	89 37                	mov    %esi,(%rdi)
    ptr->size = size;
  100073:	48 89 57 08          	mov    %rdx,0x8(%rdi)
    ptr->block_payload = GET_PAYLOAD(ptr);
  100077:	48 8d 47 20          	lea    0x20(%rdi),%rax
  10007b:	48 89 47 18          	mov    %rax,0x18(%rdi)
}
  10007f:	c3                   	ret    

0000000000100080 <addToHeap>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100080:	cd 3a                	int    $0x3a
  100082:	48 89 05 97 1f 00 00 	mov    %rax,0x1f97(%rip)        # 102020 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100089:	48 89 c2             	mov    %rax,%rdx

bh* addToHeap(uint64_t alignedbytes)
{
    void *newbp = sbrk(alignedbytes);
    if (newbp == (void*)-1) 
  10008c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100090:	74 1e                	je     1000b0 <addToHeap+0x30>
    ptr->allocated = allocated;
  100092:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
    ptr->size = size;
  100098:	48 89 78 08          	mov    %rdi,0x8(%rax)
    ptr->block_payload = GET_PAYLOAD(ptr);
  10009c:	48 8d 48 20          	lea    0x20(%rax),%rcx
  1000a0:	48 89 48 18          	mov    %rcx,0x18(%rax)
        return NULL;
        
    bh *newhead = (bh*)newbp;
    init_node(newbp, 1, alignedbytes);

    newhead->next = NULL;  
  1000a4:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  1000ab:	00 

    return newhead;
}
  1000ac:	48 89 d0             	mov    %rdx,%rax
  1000af:	c3                   	ret    
        return NULL;
  1000b0:	ba 00 00 00 00       	mov    $0x0,%edx
  1000b5:	eb f5                	jmp    1000ac <addToHeap+0x2c>

00000000001000b7 <splitBlock>:

void splitBlock(uint64_t alignedbytes, bh* b)
{
    bh *new = NEXT_HEADER(b, alignedbytes); //new now points to end of curr's payload
  1000b7:	48 8d 04 3e          	lea    (%rsi,%rdi,1),%rax
    init_node(new, 0, b->size - alignedbytes); //set struct values
  1000bb:	48 8b 56 08          	mov    0x8(%rsi),%rdx
  1000bf:	48 29 fa             	sub    %rdi,%rdx
    ptr->allocated = allocated;
  1000c2:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    ptr->size = size;
  1000c8:	48 89 50 08          	mov    %rdx,0x8(%rax)
    ptr->block_payload = GET_PAYLOAD(ptr);
  1000cc:	48 8d 50 20          	lea    0x20(%rax),%rdx
  1000d0:	48 89 50 18          	mov    %rdx,0x18(%rax)

    if (b->next == NULL)//set new end pointer if b points to end (i.e. now new is end)        
  1000d4:	48 8b 56 10          	mov    0x10(%rsi),%rdx
  1000d8:	48 85 d2             	test   %rdx,%rdx
  1000db:	74 0d                	je     1000ea <splitBlock+0x33>
        end = new;
    
    new->next = b->next; 
  1000dd:	48 89 50 10          	mov    %rdx,0x10(%rax)
    b->next = new;
  1000e1:	48 89 46 10          	mov    %rax,0x10(%rsi)
    b->size = alignedbytes;
  1000e5:	48 89 7e 08          	mov    %rdi,0x8(%rsi)
}
  1000e9:	c3                   	ret    
        end = new;
  1000ea:	48 89 05 1f 1f 00 00 	mov    %rax,0x1f1f(%rip)        # 102010 <end>
  1000f1:	eb ea                	jmp    1000dd <splitBlock+0x26>

00000000001000f3 <setFreeAndAlloc>:
    int freeSpace = 0; //size of free space
    int largestFreeChunk = 0; //size of the largest free chunk

    //===========================================//
    //initial loop to get data for number of allocs and frees
    bh* curr = head;
  1000f3:	48 8b 05 1e 1f 00 00 	mov    0x1f1e(%rip),%rax        # 102018 <head>
    while (curr != NULL)
  1000fa:	48 85 c0             	test   %rax,%rax
  1000fd:	74 35                	je     100134 <setFreeAndAlloc+0x41>
    int largestFreeChunk = 0; //size of the largest free chunk
  1000ff:	b9 00 00 00 00       	mov    $0x0,%ecx
    int freeSpace = 0; //size of free space
  100104:	be 00 00 00 00       	mov    $0x0,%esi
    int numAllocs = 0; //store current number of allocations
  100109:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  10010f:	eb 0d                	jmp    10011e <setFreeAndAlloc+0x2b>
    {
        if (curr->allocated == 1)
            numAllocs++;
  100111:	41 83 c1 01          	add    $0x1,%r9d
        else {
            freeSpace += curr->size;
            if (curr->size > (uint64_t)largestFreeChunk) //basic algorithm for finding max
                largestFreeChunk = curr->size;
        }
        curr = curr->next;
  100115:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (curr != NULL)
  100119:	48 85 c0             	test   %rax,%rax
  10011c:	74 26                	je     100144 <setFreeAndAlloc+0x51>
        if (curr->allocated == 1)
  10011e:	83 38 01             	cmpl   $0x1,(%rax)
  100121:	74 ee                	je     100111 <setFreeAndAlloc+0x1e>
            freeSpace += curr->size;
  100123:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100127:	01 d6                	add    %edx,%esi
            if (curr->size > (uint64_t)largestFreeChunk) //basic algorithm for finding max
  100129:	4c 63 c1             	movslq %ecx,%r8
                largestFreeChunk = curr->size;
  10012c:	49 39 d0             	cmp    %rdx,%r8
  10012f:	0f 42 ca             	cmovb  %edx,%ecx
  100132:	eb e1                	jmp    100115 <setFreeAndAlloc+0x22>
    int largestFreeChunk = 0; //size of the largest free chunk
  100134:	b9 00 00 00 00       	mov    $0x0,%ecx
    int freeSpace = 0; //size of free space
  100139:	be 00 00 00 00       	mov    $0x0,%esi
    int numAllocs = 0; //store current number of allocations
  10013e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    }
    //===========================================//
    //set the 3 fields from previous while loop in the info struct
    info->free_space = freeSpace;
  100144:	89 77 18             	mov    %esi,0x18(%rdi)
    info->largest_free_chunk = largestFreeChunk;
  100147:	89 4f 1c             	mov    %ecx,0x1c(%rdi)
    info->num_allocs = numAllocs;
  10014a:	44 89 0f             	mov    %r9d,(%rdi)
    //===========================================//
}
  10014d:	c3                   	ret    

000000000010014e <swapSize>:
//qsort helpers via programiz.com
//===========================================//

// function to swap elements of type long
void swapSize(long *a, long *b) {
  long temp = *a;
  10014e:	48 8b 07             	mov    (%rdi),%rax
  *a = *b;
  100151:	48 8b 16             	mov    (%rsi),%rdx
  100154:	48 89 17             	mov    %rdx,(%rdi)
  *b = temp;
  100157:	48 89 06             	mov    %rax,(%rsi)
}
  10015a:	c3                   	ret    

000000000010015b <swapPtr>:

//function to swap elemnts of type void*
void swapPtr(void **a, void **b) {
  void *temp = *a;
  10015b:	48 8b 07             	mov    (%rdi),%rax
  *a = *b;
  10015e:	48 8b 16             	mov    (%rsi),%rdx
  100161:	48 89 17             	mov    %rdx,(%rdi)
  *b = temp;
  100164:	48 89 06             	mov    %rax,(%rsi)
}
  100167:	c3                   	ret    

0000000000100168 <partition>:

//function to partition the array on the basis of pivot element
int partition(long *sizeArray, void **ptrArray, int low, int high)
{
  100168:	55                   	push   %rbp
  100169:	48 89 e5             	mov    %rsp,%rbp
  10016c:	41 55                	push   %r13
  10016e:	41 54                	push   %r12
  100170:	53                   	push   %rbx
  100171:	49 89 f8             	mov    %rdi,%r8
  100174:	49 89 f1             	mov    %rsi,%r9
  100177:	41 89 ca             	mov    %ecx,%r10d
    // select the rightmost element as pivot
    long pivot = sizeArray[high];
  10017a:	48 63 c9             	movslq %ecx,%rcx
  10017d:	4c 8d 1c cd 00 00 00 	lea    0x0(,%rcx,8),%r11
  100184:	00 
  100185:	4a 8d 1c 1f          	lea    (%rdi,%r11,1),%rbx
  100189:	4c 8b 23             	mov    (%rbx),%r12
    // index of smaller element
    int i = low - 1;
  10018c:	8d 42 ff             	lea    -0x1(%rdx),%eax
    // traverse each element of the array and compare them with the pivot
    for (int j = low; j < high; j++) 
  10018f:	41 39 d2             	cmp    %edx,%r10d
  100192:	7e 42                	jle    1001d6 <partition+0x6e>
  100194:	48 63 d2             	movslq %edx,%rdx
  100197:	eb 09                	jmp    1001a2 <partition+0x3a>
  100199:	48 83 c2 01          	add    $0x1,%rdx
  10019d:	41 39 d2             	cmp    %edx,%r10d
  1001a0:	7e 34                	jle    1001d6 <partition+0x6e>
    {
        if (sizeArray[j] > pivot) 
  1001a2:	49 8b 34 d0          	mov    (%r8,%rdx,8),%rsi
  1001a6:	4c 39 e6             	cmp    %r12,%rsi
  1001a9:	7e ee                	jle    100199 <partition+0x31>
        {
            i++; //if element smaller than pivot is found swap it with the greater element pointed by i
  1001ab:	83 c0 01             	add    $0x1,%eax
            swapSize(&sizeArray[i], &sizeArray[j]); // swap element at i with element at j
  1001ae:	48 63 c8             	movslq %eax,%rcx
  1001b1:	48 c1 e1 03          	shl    $0x3,%rcx
  1001b5:	49 8d 3c 08          	lea    (%r8,%rcx,1),%rdi
  long temp = *a;
  1001b9:	4c 8b 2f             	mov    (%rdi),%r13
  *a = *b;
  1001bc:	48 89 37             	mov    %rsi,(%rdi)
  *b = temp;
  1001bf:	4d 89 2c d0          	mov    %r13,(%r8,%rdx,8)
            swapPtr(&ptrArray[i], &ptrArray[j]); // do the same but now with ptr array
  1001c3:	4c 01 c9             	add    %r9,%rcx
  void *temp = *a;
  1001c6:	48 8b 31             	mov    (%rcx),%rsi
  *a = *b;
  1001c9:	49 8b 3c d1          	mov    (%r9,%rdx,8),%rdi
  1001cd:	48 89 39             	mov    %rdi,(%rcx)
  *b = temp;
  1001d0:	49 89 34 d1          	mov    %rsi,(%r9,%rdx,8)
}
  1001d4:	eb c3                	jmp    100199 <partition+0x31>
        }
    }
    swapSize(&sizeArray[i+1], &sizeArray[high]); //swap the pivot element with the greater element at i
  1001d6:	48 63 d0             	movslq %eax,%rdx
  1001d9:	48 8d 34 d5 08 00 00 	lea    0x8(,%rdx,8),%rsi
  1001e0:	00 
  1001e1:	49 8d 14 30          	lea    (%r8,%rsi,1),%rdx
  long temp = *a;
  1001e5:	48 8b 0a             	mov    (%rdx),%rcx
  *a = *b;
  1001e8:	48 8b 3b             	mov    (%rbx),%rdi
  1001eb:	48 89 3a             	mov    %rdi,(%rdx)
  *b = temp;
  1001ee:	48 89 0b             	mov    %rcx,(%rbx)
    swapPtr(&ptrArray[i+1], &ptrArray[high]); //do the same ordering with with pointer array
  1001f1:	4b 8d 0c 19          	lea    (%r9,%r11,1),%rcx
  1001f5:	49 8d 14 31          	lea    (%r9,%rsi,1),%rdx
  void *temp = *a;
  1001f9:	48 8b 32             	mov    (%rdx),%rsi
  *a = *b;
  1001fc:	48 8b 39             	mov    (%rcx),%rdi
  1001ff:	48 89 3a             	mov    %rdi,(%rdx)
  *b = temp;
  100202:	48 89 31             	mov    %rsi,(%rcx)
    
    return (i + 1); // return the partition point
  100205:	83 c0 01             	add    $0x1,%eax
}
  100208:	5b                   	pop    %rbx
  100209:	41 5c                	pop    %r12
  10020b:	41 5d                	pop    %r13
  10020d:	5d                   	pop    %rbp
  10020e:	c3                   	ret    

000000000010020f <quickSort>:

//this will sort both size and ptr array because we have 2 swap functions we can call
//we will order the ptr array in the same order of the size array by using size array pivot points and mirroring that to ptr array
void quickSort(long *sizeArray, void **ptrArray, int low, int high) 
{
  if (low < high) 
  10020f:	39 ca                	cmp    %ecx,%edx
  100211:	7c 01                	jl     100214 <quickSort+0x5>
  100213:	c3                   	ret    
{
  100214:	55                   	push   %rbp
  100215:	48 89 e5             	mov    %rsp,%rbp
  100218:	41 57                	push   %r15
  10021a:	41 56                	push   %r14
  10021c:	41 55                	push   %r13
  10021e:	41 54                	push   %r12
  100220:	53                   	push   %rbx
  100221:	48 83 ec 08          	sub    $0x8,%rsp
  100225:	49 89 fd             	mov    %rdi,%r13
  100228:	49 89 f6             	mov    %rsi,%r14
  10022b:	41 89 d4             	mov    %edx,%r12d
  10022e:	89 cb                	mov    %ecx,%ebx
  {
    // find the pivot element such that elements smaller than pivot are on left of pivot elements greater than pivot are on right of pivot
    int pi = partition(sizeArray, ptrArray, low, high);
  100230:	e8 33 ff ff ff       	call   100168 <partition>
  100235:	41 89 c7             	mov    %eax,%r15d
    
    // recursive call on the left of pivot
    quickSort(sizeArray, ptrArray, low, pi - 1);
  100238:	8d 48 ff             	lea    -0x1(%rax),%ecx
  10023b:	44 89 e2             	mov    %r12d,%edx
  10023e:	4c 89 f6             	mov    %r14,%rsi
  100241:	4c 89 ef             	mov    %r13,%rdi
  100244:	e8 c6 ff ff ff       	call   10020f <quickSort>
    
    // recursive call on the right of pivot
    quickSort(sizeArray, ptrArray, pi + 1, high);
  100249:	41 8d 57 01          	lea    0x1(%r15),%edx
  10024d:	89 d9                	mov    %ebx,%ecx
  10024f:	4c 89 f6             	mov    %r14,%rsi
  100252:	4c 89 ef             	mov    %r13,%rdi
  100255:	e8 b5 ff ff ff       	call   10020f <quickSort>
  }
}
  10025a:	48 83 c4 08          	add    $0x8,%rsp
  10025e:	5b                   	pop    %rbx
  10025f:	41 5c                	pop    %r12
  100261:	41 5d                	pop    %r13
  100263:	41 5e                	pop    %r14
  100265:	41 5f                	pop    %r15
  100267:	5d                   	pop    %rbp
  100268:	c3                   	ret    

0000000000100269 <malloc>:

//===========================================//
//begin malloc functions
//===========================================//
void *malloc(uint64_t numbytes) {
  100269:	55                   	push   %rbp
  10026a:	48 89 e5             	mov    %rsp,%rbp
  10026d:	53                   	push   %rbx
  10026e:	48 83 ec 08          	sub    $0x8,%rsp
  100272:	48 89 f8             	mov    %rdi,%rax
    uint64_t alignedbytes = ALIGN_8(numbytes + HEADER_SIZE);
  100275:	48 8d 7f 27          	lea    0x27(%rdi),%rdi
  100279:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
    bh *curr = head;
  10027d:	48 8b 1d 94 1d 00 00 	mov    0x1d94(%rip),%rbx        # 102018 <head>

    //out of bounds
    if ((numbytes == 0) || ((numbytes + (uint64_t)HEADER_SIZE) > UINTMAX))
  100284:	48 85 c0             	test   %rax,%rax
  100287:	74 7c                	je     100305 <malloc+0x9c>
        return NULL;

    //traverse linked list
    while (curr != NULL)
  100289:	48 85 db             	test   %rbx,%rbx
  10028c:	75 4b                	jne    1002d9 <malloc+0x70>
        }
        curr = curr->next;
    }

    //else, curr == NULL means we are at end of heap, sbrk more mem for header, insert node at end
    curr = addToHeap(alignedbytes);
  10028e:	e8 ed fd ff ff       	call   100080 <addToHeap>
    if (curr == NULL) return NULL;
  100293:	48 85 c0             	test   %rax,%rax
  100296:	74 28                	je     1002c0 <malloc+0x57>
    //first iteration of malloc
    if (head == NULL){
  100298:	48 83 3d 78 1d 00 00 	cmpq   $0x0,0x1d78(%rip)        # 102018 <head>
  10029f:	00 
  1002a0:	74 5a                	je     1002fc <malloc+0x93>
        head = curr;
        end = curr;
    }
    //end pointer is used to link the new node at end to previous one, end is set to last non null node
    else{ 
        end->next = curr;
  1002a2:	48 8b 15 67 1d 00 00 	mov    0x1d67(%rip),%rdx        # 102010 <end>
  1002a9:	48 89 42 10          	mov    %rax,0x10(%rdx)
        end = curr;
  1002ad:	48 89 05 5c 1d 00 00 	mov    %rax,0x1d5c(%rip)        # 102010 <end>
        end = curr;
    }

    curr->next = NULL;  
  1002b4:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  1002bb:	00 

    return curr->block_payload; 
  1002bc:	48 8b 40 18          	mov    0x18(%rax),%rax
}
  1002c0:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1002c4:	c9                   	leave  
  1002c5:	c3                   	ret    
                splitBlock(alignedbytes, curr);
  1002c6:	48 89 de             	mov    %rbx,%rsi
  1002c9:	e8 e9 fd ff ff       	call   1000b7 <splitBlock>
  1002ce:	eb 26                	jmp    1002f6 <malloc+0x8d>
        curr = curr->next;
  1002d0:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    while (curr != NULL)
  1002d4:	48 85 db             	test   %rbx,%rbx
  1002d7:	74 b5                	je     10028e <malloc+0x25>
        if ((curr->allocated == 0) && (curr->size >= alignedbytes))
  1002d9:	83 3b 00             	cmpl   $0x0,(%rbx)
  1002dc:	75 f2                	jne    1002d0 <malloc+0x67>
  1002de:	48 8b 43 08          	mov    0x8(%rbx),%rax
  1002e2:	48 39 f8             	cmp    %rdi,%rax
  1002e5:	72 e9                	jb     1002d0 <malloc+0x67>
            curr->allocated = 1; //set to allocated 
  1002e7:	c7 03 01 00 00 00    	movl   $0x1,(%rbx)
            if (HEADER_SIZE <= (curr->size - alignedbytes)) //if there's left over room after inserting header and payload, then split current block into 2
  1002ed:	48 29 f8             	sub    %rdi,%rax
  1002f0:	48 83 f8 1f          	cmp    $0x1f,%rax
  1002f4:	77 d0                	ja     1002c6 <malloc+0x5d>
            return curr->block_payload; 
  1002f6:	48 8b 43 18          	mov    0x18(%rbx),%rax
  1002fa:	eb c4                	jmp    1002c0 <malloc+0x57>
        head = curr;
  1002fc:	48 89 05 15 1d 00 00 	mov    %rax,0x1d15(%rip)        # 102018 <head>
        end = curr;
  100303:	eb a8                	jmp    1002ad <malloc+0x44>
        return NULL;
  100305:	b8 00 00 00 00       	mov    $0x0,%eax
  10030a:	eb b4                	jmp    1002c0 <malloc+0x57>

000000000010030c <calloc>:

void * calloc(uint64_t num, uint64_t sz) {
  10030c:	55                   	push   %rbp
  10030d:	48 89 e5             	mov    %rsp,%rbp
  100310:	41 54                	push   %r12
  100312:	53                   	push   %rbx
    //out of bounds
    if (num == 0 || sz == 0)
  100313:	48 85 ff             	test   %rdi,%rdi
  100316:	74 40                	je     100358 <calloc+0x4c>
  100318:	48 85 f6             	test   %rsi,%rsi
  10031b:	74 3b                	je     100358 <calloc+0x4c>
        return NULL;
    
    //out of bounds
    uint64_t size = num*sz;
  10031d:	48 89 fb             	mov    %rdi,%rbx
  100320:	48 0f af de          	imul   %rsi,%rbx
    if (size > (UINTMAX - HEADER_SIZE))
        return NULL;
  100324:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if (size > (UINTMAX - HEADER_SIZE))
  10032a:	48 83 fb df          	cmp    $0xffffffffffffffdf,%rbx
  10032e:	77 20                	ja     100350 <calloc+0x44>

    void *array = malloc(size);
  100330:	48 89 df             	mov    %rbx,%rdi
  100333:	e8 31 ff ff ff       	call   100269 <malloc>
  100338:	49 89 c4             	mov    %rax,%r12
    if (array != NULL)
  10033b:	48 85 c0             	test   %rax,%rax
  10033e:	74 10                	je     100350 <calloc+0x44>
        memset(array, 0, size);
  100340:	48 89 da             	mov    %rbx,%rdx
  100343:	be 00 00 00 00       	mov    $0x0,%esi
  100348:	48 89 c7             	mov    %rax,%rdi
  10034b:	e8 b9 02 00 00       	call   100609 <memset>
    return array;
}
  100350:	4c 89 e0             	mov    %r12,%rax
  100353:	5b                   	pop    %rbx
  100354:	41 5c                	pop    %r12
  100356:	5d                   	pop    %rbp
  100357:	c3                   	ret    
        return NULL;
  100358:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  10035e:	eb f0                	jmp    100350 <calloc+0x44>

0000000000100360 <free>:

void free(void *firstbyte) {
    if (firstbyte == NULL) 
  100360:	48 85 ff             	test   %rdi,%rdi
  100363:	74 07                	je     10036c <free+0xc>
        return;
    //given a block payload, move back to header struct
    bh* curr = GET_HEADER(firstbyte);
    curr->allocated = 0;
  100365:	c7 47 e0 00 00 00 00 	movl   $0x0,-0x20(%rdi)
    return;
}
  10036c:	c3                   	ret    

000000000010036d <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  10036d:	55                   	push   %rbp
  10036e:	48 89 e5             	mov    %rsp,%rbp
  100371:	41 55                	push   %r13
  100373:	41 54                	push   %r12
  100375:	53                   	push   %rbx
  100376:	48 83 ec 08          	sub    $0x8,%rsp
    //out of bounds
    if (sz > (UINTMAX - HEADER_SIZE))
  10037a:	48 83 fe df          	cmp    $0xffffffffffffffdf,%rsi
  10037e:	77 55                	ja     1003d5 <realloc+0x68>
  100380:	49 89 fc             	mov    %rdi,%r12
  100383:	48 89 f3             	mov    %rsi,%rbx
        return NULL;
     // if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
    if (ptr == NULL)
  100386:	48 85 ff             	test   %rdi,%rdi
  100389:	74 39                	je     1003c4 <realloc+0x57>
        malloc(sz);
    // if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr) 
    //unless ptr is NULL, it must have been returned by an earlier call to malloc(), or realloc().
    if (sz == 0 && ptr != NULL)
  10038b:	48 85 f6             	test   %rsi,%rsi
  10038e:	74 3e                	je     1003ce <realloc+0x61>
        free(ptr);
    
    // if the area pointed to was moved, a free(ptr) is done.
    void *re = malloc(sz);
  100390:	48 89 df             	mov    %rbx,%rdi
  100393:	e8 d1 fe ff ff       	call   100269 <malloc>
  100398:	49 89 c5             	mov    %rax,%r13
    if (re != NULL)
  10039b:	48 85 c0             	test   %rax,%rax
  10039e:	74 16                	je     1003b6 <realloc+0x49>
    {
         memcpy(re, ptr, sz);
  1003a0:	48 89 da             	mov    %rbx,%rdx
  1003a3:	4c 89 e6             	mov    %r12,%rsi
  1003a6:	48 89 c7             	mov    %rax,%rdi
  1003a9:	e8 5d 01 00 00       	call   10050b <memcpy>
         free(ptr);
  1003ae:	4c 89 e7             	mov    %r12,%rdi
  1003b1:	e8 aa ff ff ff       	call   100360 <free>
    }
       
    return re;
}
  1003b6:	4c 89 e8             	mov    %r13,%rax
  1003b9:	48 83 c4 08          	add    $0x8,%rsp
  1003bd:	5b                   	pop    %rbx
  1003be:	41 5c                	pop    %r12
  1003c0:	41 5d                	pop    %r13
  1003c2:	5d                   	pop    %rbp
  1003c3:	c3                   	ret    
        malloc(sz);
  1003c4:	48 89 f7             	mov    %rsi,%rdi
  1003c7:	e8 9d fe ff ff       	call   100269 <malloc>
    if (sz == 0 && ptr != NULL)
  1003cc:	eb c2                	jmp    100390 <realloc+0x23>
        free(ptr);
  1003ce:	e8 8d ff ff ff       	call   100360 <free>
  1003d3:	eb bb                	jmp    100390 <realloc+0x23>
        return NULL;
  1003d5:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1003db:	eb d9                	jmp    1003b6 <realloc+0x49>

00000000001003dd <defrag>:

//just loop through list and combine adjacent free blocks and update the size of the first one
void defrag() {
    bh *curr = head; 
  1003dd:	48 8b 15 34 1c 00 00 	mov    0x1c34(%rip),%rdx        # 102018 <head>
    while(curr != NULL && curr->next != NULL)
  1003e4:	48 85 d2             	test   %rdx,%rdx
  1003e7:	75 04                	jne    1003ed <defrag+0x10>
  1003e9:	c3                   	ret    
    {
        if (curr->allocated == 0 && curr->next->allocated == 0)
        {
            curr->size = curr->size + curr->next->size;
            curr->next = curr->next->next;
  1003ea:	48 89 c2             	mov    %rax,%rdx
    while(curr != NULL && curr->next != NULL)
  1003ed:	48 8b 42 10          	mov    0x10(%rdx),%rax
  1003f1:	48 85 c0             	test   %rax,%rax
  1003f4:	74 1f                	je     100415 <defrag+0x38>
        if (curr->allocated == 0 && curr->next->allocated == 0)
  1003f6:	83 3a 00             	cmpl   $0x0,(%rdx)
  1003f9:	75 ef                	jne    1003ea <defrag+0xd>
  1003fb:	83 38 00             	cmpl   $0x0,(%rax)
  1003fe:	75 ea                	jne    1003ea <defrag+0xd>
            curr->size = curr->size + curr->next->size;
  100400:	48 8b 48 08          	mov    0x8(%rax),%rcx
  100404:	48 01 4a 08          	add    %rcx,0x8(%rdx)
            curr->next = curr->next->next;
  100408:	48 8b 40 10          	mov    0x10(%rax),%rax
  10040c:	48 89 42 10          	mov    %rax,0x10(%rdx)
  100410:	48 89 d0             	mov    %rdx,%rax
  100413:	eb d5                	jmp    1003ea <defrag+0xd>
        }
        else
            curr = curr->next;
    }
}
  100415:	c3                   	ret    

0000000000100416 <heap_info>:

int heap_info(heap_info_struct * info) {
  100416:	55                   	push   %rbp
  100417:	48 89 e5             	mov    %rsp,%rbp
  10041a:	41 56                	push   %r14
  10041c:	41 55                	push   %r13
  10041e:	41 54                	push   %r12
  100420:	53                   	push   %rbx
  100421:	48 89 fb             	mov    %rdi,%rbx
    void **ptrArray = NULL; //pointer to an array of pointers of each allocation
    long *sizeArray = NULL; //pointer to an array of size of each allocation

    //===========================================//
    setFreeAndAlloc(info); //sets num_allocs, free_space, and largest_free_chunk
  100424:	e8 ca fc ff ff       	call   1000f3 <setFreeAndAlloc>
    if (info->num_allocs == 0) //if no size, just set arrays in struct to NULL
  100429:	8b 03                	mov    (%rbx),%eax
  10042b:	85 c0                	test   %eax,%eax
  10042d:	75 19                	jne    100448 <heap_info+0x32>
    {
        info->size_array = sizeArray;
  10042f:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  100436:	00 
        info->ptr_array = ptrArray;
  100437:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  10043e:	00 
    info->size_array = sizeArray;
    info->ptr_array = ptrArray;
    //===========================================//

    return 0;
}
  10043f:	5b                   	pop    %rbx
  100440:	41 5c                	pop    %r12
  100442:	41 5d                	pop    %r13
  100444:	41 5e                	pop    %r14
  100446:	5d                   	pop    %rbp
  100447:	c3                   	ret    
    uint64_t sizeLong = (uint64_t)info->num_allocs * sizeof(long); 
  100448:	48 98                	cltq   
  10044a:	4c 8d 24 c5 00 00 00 	lea    0x0(,%rax,8),%r12
  100451:	00 
    sizeArray = malloc(sizeLong);
  100452:	4c 89 e7             	mov    %r12,%rdi
  100455:	e8 0f fe ff ff       	call   100269 <malloc>
  10045a:	49 89 c5             	mov    %rax,%r13
    ptrArray = malloc(sizeUint);
  10045d:	4c 89 e7             	mov    %r12,%rdi
  100460:	e8 04 fe ff ff       	call   100269 <malloc>
  100465:	49 89 c4             	mov    %rax,%r12
    if (sizeArray == NULL || ptrArray == NULL)
  100468:	4d 85 ed             	test   %r13,%r13
  10046b:	74 18                	je     100485 <heap_info+0x6f>
  10046d:	48 85 c0             	test   %rax,%rax
  100470:	74 13                	je     100485 <heap_info+0x6f>
    bh *curr = head; int i = 0;
  100472:	48 8b 05 9f 1b 00 00 	mov    0x1b9f(%rip),%rax        # 102018 <head>
    while(curr != NULL)
  100479:	48 85 c0             	test   %rax,%rax
  10047c:	74 66                	je     1004e4 <heap_info+0xce>
    bh *curr = head; int i = 0;
  10047e:	b9 00 00 00 00       	mov    $0x0,%ecx
  100483:	eb 3d                	jmp    1004c2 <heap_info+0xac>
        for (int j = 0; j < info->num_allocs; j++)
  100485:	83 3b 00             	cmpl   $0x0,(%rbx)
  100488:	7e 18                	jle    1004a2 <heap_info+0x8c>
  10048a:	41 be 00 00 00 00    	mov    $0x0,%r14d
            free(ptrArray[j]);
  100490:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
  100494:	e8 c7 fe ff ff       	call   100360 <free>
        for (int j = 0; j < info->num_allocs; j++)
  100499:	49 83 c6 01          	add    $0x1,%r14
  10049d:	44 39 33             	cmp    %r14d,(%rbx)
  1004a0:	7f ee                	jg     100490 <heap_info+0x7a>
        free(sizeArray);
  1004a2:	4c 89 ef             	mov    %r13,%rdi
  1004a5:	e8 b6 fe ff ff       	call   100360 <free>
        free(ptrArray);
  1004aa:	4c 89 e7             	mov    %r12,%rdi
  1004ad:	e8 ae fe ff ff       	call   100360 <free>
        return -1;
  1004b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1004b7:	eb 86                	jmp    10043f <heap_info+0x29>
        curr = curr->next;
  1004b9:	48 8b 40 10          	mov    0x10(%rax),%rax
    while(curr != NULL)
  1004bd:	48 85 c0             	test   %rax,%rax
  1004c0:	74 22                	je     1004e4 <heap_info+0xce>
        if (curr->allocated == 1) //load in allocated chunks
  1004c2:	83 38 01             	cmpl   $0x1,(%rax)
  1004c5:	75 f2                	jne    1004b9 <heap_info+0xa3>
            sizeArray[i] = curr->size - HEADER_SIZE; //gets size of allocated requested from malloc i.e. payload
  1004c7:	48 63 f1             	movslq %ecx,%rsi
  1004ca:	48 8b 78 08          	mov    0x8(%rax),%rdi
  1004ce:	48 8d 57 e0          	lea    -0x20(%rdi),%rdx
  1004d2:	49 89 54 f5 00       	mov    %rdx,0x0(%r13,%rsi,8)
            ptrArray[i] = curr->block_payload; //pointer to payload allocations
  1004d7:	48 8b 50 18          	mov    0x18(%rax),%rdx
  1004db:	49 89 14 f4          	mov    %rdx,(%r12,%rsi,8)
            i++;
  1004df:	83 c1 01             	add    $0x1,%ecx
  1004e2:	eb d5                	jmp    1004b9 <heap_info+0xa3>
    quickSort(sizeArray, ptrArray, 0, info->num_allocs-1);
  1004e4:	8b 03                	mov    (%rbx),%eax
  1004e6:	8d 48 ff             	lea    -0x1(%rax),%ecx
  1004e9:	ba 00 00 00 00       	mov    $0x0,%edx
  1004ee:	4c 89 e6             	mov    %r12,%rsi
  1004f1:	4c 89 ef             	mov    %r13,%rdi
  1004f4:	e8 16 fd ff ff       	call   10020f <quickSort>
    info->size_array = sizeArray;
  1004f9:	4c 89 6b 08          	mov    %r13,0x8(%rbx)
    info->ptr_array = ptrArray;
  1004fd:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    return 0;
  100501:	b8 00 00 00 00       	mov    $0x0,%eax
  100506:	e9 34 ff ff ff       	jmp    10043f <heap_info+0x29>

000000000010050b <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10050b:	55                   	push   %rbp
  10050c:	48 89 e5             	mov    %rsp,%rbp
  10050f:	48 83 ec 28          	sub    $0x28,%rsp
  100513:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100517:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10051b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10051f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100523:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100527:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10052b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10052f:	eb 1c                	jmp    10054d <memcpy+0x42>
        *d = *s;
  100531:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100535:	0f b6 10             	movzbl (%rax),%edx
  100538:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10053c:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10053e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100543:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100548:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10054d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100552:	75 dd                	jne    100531 <memcpy+0x26>
    }
    return dst;
  100554:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100558:	c9                   	leave  
  100559:	c3                   	ret    

000000000010055a <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10055a:	55                   	push   %rbp
  10055b:	48 89 e5             	mov    %rsp,%rbp
  10055e:	48 83 ec 28          	sub    $0x28,%rsp
  100562:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100566:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10056a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10056e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100572:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100576:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10057a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  10057e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100582:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100586:	73 6a                	jae    1005f2 <memmove+0x98>
  100588:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10058c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100590:	48 01 d0             	add    %rdx,%rax
  100593:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100597:	73 59                	jae    1005f2 <memmove+0x98>
        s += n, d += n;
  100599:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10059d:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1005a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1005a5:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1005a9:	eb 17                	jmp    1005c2 <memmove+0x68>
            *--d = *--s;
  1005ab:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1005b0:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1005b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005b9:	0f b6 10             	movzbl (%rax),%edx
  1005bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1005c0:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1005c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1005c6:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1005ca:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1005ce:	48 85 c0             	test   %rax,%rax
  1005d1:	75 d8                	jne    1005ab <memmove+0x51>
    if (s < d && s + n > d) {
  1005d3:	eb 2e                	jmp    100603 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1005d5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1005d9:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1005dd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1005e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1005e5:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1005e9:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1005ed:	0f b6 12             	movzbl (%rdx),%edx
  1005f0:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1005f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1005f6:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1005fa:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1005fe:	48 85 c0             	test   %rax,%rax
  100601:	75 d2                	jne    1005d5 <memmove+0x7b>
        }
    }
    return dst;
  100603:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100607:	c9                   	leave  
  100608:	c3                   	ret    

0000000000100609 <memset>:

void* memset(void* v, int c, size_t n) {
  100609:	55                   	push   %rbp
  10060a:	48 89 e5             	mov    %rsp,%rbp
  10060d:	48 83 ec 28          	sub    $0x28,%rsp
  100611:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100615:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100618:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10061c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100620:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100624:	eb 15                	jmp    10063b <memset+0x32>
        *p = c;
  100626:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100629:	89 c2                	mov    %eax,%edx
  10062b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10062f:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100631:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100636:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10063b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100640:	75 e4                	jne    100626 <memset+0x1d>
    }
    return v;
  100642:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100646:	c9                   	leave  
  100647:	c3                   	ret    

0000000000100648 <strlen>:

size_t strlen(const char* s) {
  100648:	55                   	push   %rbp
  100649:	48 89 e5             	mov    %rsp,%rbp
  10064c:	48 83 ec 18          	sub    $0x18,%rsp
  100650:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100654:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10065b:	00 
  10065c:	eb 0a                	jmp    100668 <strlen+0x20>
        ++n;
  10065e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100663:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100668:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10066c:	0f b6 00             	movzbl (%rax),%eax
  10066f:	84 c0                	test   %al,%al
  100671:	75 eb                	jne    10065e <strlen+0x16>
    }
    return n;
  100673:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100677:	c9                   	leave  
  100678:	c3                   	ret    

0000000000100679 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100679:	55                   	push   %rbp
  10067a:	48 89 e5             	mov    %rsp,%rbp
  10067d:	48 83 ec 20          	sub    $0x20,%rsp
  100681:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100685:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100689:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100690:	00 
  100691:	eb 0a                	jmp    10069d <strnlen+0x24>
        ++n;
  100693:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100698:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10069d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006a1:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1006a5:	74 0b                	je     1006b2 <strnlen+0x39>
  1006a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006ab:	0f b6 00             	movzbl (%rax),%eax
  1006ae:	84 c0                	test   %al,%al
  1006b0:	75 e1                	jne    100693 <strnlen+0x1a>
    }
    return n;
  1006b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1006b6:	c9                   	leave  
  1006b7:	c3                   	ret    

00000000001006b8 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1006b8:	55                   	push   %rbp
  1006b9:	48 89 e5             	mov    %rsp,%rbp
  1006bc:	48 83 ec 20          	sub    $0x20,%rsp
  1006c0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1006c4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1006c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006cc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1006d0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1006d4:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1006d8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1006dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006e0:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1006e4:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1006e8:	0f b6 12             	movzbl (%rdx),%edx
  1006eb:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1006ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006f1:	48 83 e8 01          	sub    $0x1,%rax
  1006f5:	0f b6 00             	movzbl (%rax),%eax
  1006f8:	84 c0                	test   %al,%al
  1006fa:	75 d4                	jne    1006d0 <strcpy+0x18>
    return dst;
  1006fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100700:	c9                   	leave  
  100701:	c3                   	ret    

0000000000100702 <strcmp>:

int strcmp(const char* a, const char* b) {
  100702:	55                   	push   %rbp
  100703:	48 89 e5             	mov    %rsp,%rbp
  100706:	48 83 ec 10          	sub    $0x10,%rsp
  10070a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10070e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100712:	eb 0a                	jmp    10071e <strcmp+0x1c>
        ++a, ++b;
  100714:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100719:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10071e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100722:	0f b6 00             	movzbl (%rax),%eax
  100725:	84 c0                	test   %al,%al
  100727:	74 1d                	je     100746 <strcmp+0x44>
  100729:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10072d:	0f b6 00             	movzbl (%rax),%eax
  100730:	84 c0                	test   %al,%al
  100732:	74 12                	je     100746 <strcmp+0x44>
  100734:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100738:	0f b6 10             	movzbl (%rax),%edx
  10073b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10073f:	0f b6 00             	movzbl (%rax),%eax
  100742:	38 c2                	cmp    %al,%dl
  100744:	74 ce                	je     100714 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100746:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10074a:	0f b6 00             	movzbl (%rax),%eax
  10074d:	89 c2                	mov    %eax,%edx
  10074f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100753:	0f b6 00             	movzbl (%rax),%eax
  100756:	38 d0                	cmp    %dl,%al
  100758:	0f 92 c0             	setb   %al
  10075b:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  10075e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100762:	0f b6 00             	movzbl (%rax),%eax
  100765:	89 c1                	mov    %eax,%ecx
  100767:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10076b:	0f b6 00             	movzbl (%rax),%eax
  10076e:	38 c1                	cmp    %al,%cl
  100770:	0f 92 c0             	setb   %al
  100773:	0f b6 c0             	movzbl %al,%eax
  100776:	29 c2                	sub    %eax,%edx
  100778:	89 d0                	mov    %edx,%eax
}
  10077a:	c9                   	leave  
  10077b:	c3                   	ret    

000000000010077c <strchr>:

char* strchr(const char* s, int c) {
  10077c:	55                   	push   %rbp
  10077d:	48 89 e5             	mov    %rsp,%rbp
  100780:	48 83 ec 10          	sub    $0x10,%rsp
  100784:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100788:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  10078b:	eb 05                	jmp    100792 <strchr+0x16>
        ++s;
  10078d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100792:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100796:	0f b6 00             	movzbl (%rax),%eax
  100799:	84 c0                	test   %al,%al
  10079b:	74 0e                	je     1007ab <strchr+0x2f>
  10079d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007a1:	0f b6 00             	movzbl (%rax),%eax
  1007a4:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1007a7:	38 d0                	cmp    %dl,%al
  1007a9:	75 e2                	jne    10078d <strchr+0x11>
    }
    if (*s == (char) c) {
  1007ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007af:	0f b6 00             	movzbl (%rax),%eax
  1007b2:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1007b5:	38 d0                	cmp    %dl,%al
  1007b7:	75 06                	jne    1007bf <strchr+0x43>
        return (char*) s;
  1007b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007bd:	eb 05                	jmp    1007c4 <strchr+0x48>
    } else {
        return NULL;
  1007bf:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1007c4:	c9                   	leave  
  1007c5:	c3                   	ret    

00000000001007c6 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1007c6:	55                   	push   %rbp
  1007c7:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1007ca:	8b 05 58 18 00 00    	mov    0x1858(%rip),%eax        # 102028 <rand_seed_set>
  1007d0:	85 c0                	test   %eax,%eax
  1007d2:	75 0a                	jne    1007de <rand+0x18>
        srand(819234718U);
  1007d4:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1007d9:	e8 24 00 00 00       	call   100802 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1007de:	8b 05 48 18 00 00    	mov    0x1848(%rip),%eax        # 10202c <rand_seed>
  1007e4:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1007ea:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1007ef:	89 05 37 18 00 00    	mov    %eax,0x1837(%rip)        # 10202c <rand_seed>
    return rand_seed & RAND_MAX;
  1007f5:	8b 05 31 18 00 00    	mov    0x1831(%rip),%eax        # 10202c <rand_seed>
  1007fb:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100800:	5d                   	pop    %rbp
  100801:	c3                   	ret    

0000000000100802 <srand>:

void srand(unsigned seed) {
  100802:	55                   	push   %rbp
  100803:	48 89 e5             	mov    %rsp,%rbp
  100806:	48 83 ec 08          	sub    $0x8,%rsp
  10080a:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  10080d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100810:	89 05 16 18 00 00    	mov    %eax,0x1816(%rip)        # 10202c <rand_seed>
    rand_seed_set = 1;
  100816:	c7 05 08 18 00 00 01 	movl   $0x1,0x1808(%rip)        # 102028 <rand_seed_set>
  10081d:	00 00 00 
}
  100820:	90                   	nop
  100821:	c9                   	leave  
  100822:	c3                   	ret    

0000000000100823 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100823:	55                   	push   %rbp
  100824:	48 89 e5             	mov    %rsp,%rbp
  100827:	48 83 ec 28          	sub    $0x28,%rsp
  10082b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10082f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100833:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100836:	48 c7 45 f8 40 17 10 	movq   $0x101740,-0x8(%rbp)
  10083d:	00 
    if (base < 0) {
  10083e:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100842:	79 0b                	jns    10084f <fill_numbuf+0x2c>
        digits = lower_digits;
  100844:	48 c7 45 f8 60 17 10 	movq   $0x101760,-0x8(%rbp)
  10084b:	00 
        base = -base;
  10084c:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  10084f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100854:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100858:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  10085b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10085e:	48 63 c8             	movslq %eax,%rcx
  100861:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100865:	ba 00 00 00 00       	mov    $0x0,%edx
  10086a:	48 f7 f1             	div    %rcx
  10086d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100871:	48 01 d0             	add    %rdx,%rax
  100874:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100879:	0f b6 10             	movzbl (%rax),%edx
  10087c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100880:	88 10                	mov    %dl,(%rax)
        val /= base;
  100882:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100885:	48 63 f0             	movslq %eax,%rsi
  100888:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10088c:	ba 00 00 00 00       	mov    $0x0,%edx
  100891:	48 f7 f6             	div    %rsi
  100894:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100898:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10089d:	75 bc                	jne    10085b <fill_numbuf+0x38>
    return numbuf_end;
  10089f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1008a3:	c9                   	leave  
  1008a4:	c3                   	ret    

00000000001008a5 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1008a5:	55                   	push   %rbp
  1008a6:	48 89 e5             	mov    %rsp,%rbp
  1008a9:	53                   	push   %rbx
  1008aa:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1008b1:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1008b8:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1008be:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008c5:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1008cc:	e9 8a 09 00 00       	jmp    10125b <printer_vprintf+0x9b6>
        if (*format != '%') {
  1008d1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008d8:	0f b6 00             	movzbl (%rax),%eax
  1008db:	3c 25                	cmp    $0x25,%al
  1008dd:	74 31                	je     100910 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  1008df:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1008e6:	4c 8b 00             	mov    (%rax),%r8
  1008e9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008f0:	0f b6 00             	movzbl (%rax),%eax
  1008f3:	0f b6 c8             	movzbl %al,%ecx
  1008f6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1008fc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100903:	89 ce                	mov    %ecx,%esi
  100905:	48 89 c7             	mov    %rax,%rdi
  100908:	41 ff d0             	call   *%r8
            continue;
  10090b:	e9 43 09 00 00       	jmp    101253 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100910:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100917:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10091e:	01 
  10091f:	eb 44                	jmp    100965 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100921:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100928:	0f b6 00             	movzbl (%rax),%eax
  10092b:	0f be c0             	movsbl %al,%eax
  10092e:	89 c6                	mov    %eax,%esi
  100930:	bf 60 15 10 00       	mov    $0x101560,%edi
  100935:	e8 42 fe ff ff       	call   10077c <strchr>
  10093a:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  10093e:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100943:	74 30                	je     100975 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100945:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100949:	48 2d 60 15 10 00    	sub    $0x101560,%rax
  10094f:	ba 01 00 00 00       	mov    $0x1,%edx
  100954:	89 c1                	mov    %eax,%ecx
  100956:	d3 e2                	shl    %cl,%edx
  100958:	89 d0                	mov    %edx,%eax
  10095a:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  10095d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100964:	01 
  100965:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10096c:	0f b6 00             	movzbl (%rax),%eax
  10096f:	84 c0                	test   %al,%al
  100971:	75 ae                	jne    100921 <printer_vprintf+0x7c>
  100973:	eb 01                	jmp    100976 <printer_vprintf+0xd1>
            } else {
                break;
  100975:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100976:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  10097d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100984:	0f b6 00             	movzbl (%rax),%eax
  100987:	3c 30                	cmp    $0x30,%al
  100989:	7e 67                	jle    1009f2 <printer_vprintf+0x14d>
  10098b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100992:	0f b6 00             	movzbl (%rax),%eax
  100995:	3c 39                	cmp    $0x39,%al
  100997:	7f 59                	jg     1009f2 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100999:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1009a0:	eb 2e                	jmp    1009d0 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  1009a2:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1009a5:	89 d0                	mov    %edx,%eax
  1009a7:	c1 e0 02             	shl    $0x2,%eax
  1009aa:	01 d0                	add    %edx,%eax
  1009ac:	01 c0                	add    %eax,%eax
  1009ae:	89 c1                	mov    %eax,%ecx
  1009b0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009b7:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1009bb:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1009c2:	0f b6 00             	movzbl (%rax),%eax
  1009c5:	0f be c0             	movsbl %al,%eax
  1009c8:	01 c8                	add    %ecx,%eax
  1009ca:	83 e8 30             	sub    $0x30,%eax
  1009cd:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1009d0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009d7:	0f b6 00             	movzbl (%rax),%eax
  1009da:	3c 2f                	cmp    $0x2f,%al
  1009dc:	0f 8e 85 00 00 00    	jle    100a67 <printer_vprintf+0x1c2>
  1009e2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009e9:	0f b6 00             	movzbl (%rax),%eax
  1009ec:	3c 39                	cmp    $0x39,%al
  1009ee:	7e b2                	jle    1009a2 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  1009f0:	eb 75                	jmp    100a67 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  1009f2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009f9:	0f b6 00             	movzbl (%rax),%eax
  1009fc:	3c 2a                	cmp    $0x2a,%al
  1009fe:	75 68                	jne    100a68 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100a00:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a07:	8b 00                	mov    (%rax),%eax
  100a09:	83 f8 2f             	cmp    $0x2f,%eax
  100a0c:	77 30                	ja     100a3e <printer_vprintf+0x199>
  100a0e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a15:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a19:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a20:	8b 00                	mov    (%rax),%eax
  100a22:	89 c0                	mov    %eax,%eax
  100a24:	48 01 d0             	add    %rdx,%rax
  100a27:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a2e:	8b 12                	mov    (%rdx),%edx
  100a30:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a33:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a3a:	89 0a                	mov    %ecx,(%rdx)
  100a3c:	eb 1a                	jmp    100a58 <printer_vprintf+0x1b3>
  100a3e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a45:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a49:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a4d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a54:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a58:	8b 00                	mov    (%rax),%eax
  100a5a:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100a5d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a64:	01 
  100a65:	eb 01                	jmp    100a68 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100a67:	90                   	nop
        }

        // process precision
        int precision = -1;
  100a68:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100a6f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a76:	0f b6 00             	movzbl (%rax),%eax
  100a79:	3c 2e                	cmp    $0x2e,%al
  100a7b:	0f 85 00 01 00 00    	jne    100b81 <printer_vprintf+0x2dc>
            ++format;
  100a81:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a88:	01 
            if (*format >= '0' && *format <= '9') {
  100a89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a90:	0f b6 00             	movzbl (%rax),%eax
  100a93:	3c 2f                	cmp    $0x2f,%al
  100a95:	7e 67                	jle    100afe <printer_vprintf+0x259>
  100a97:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a9e:	0f b6 00             	movzbl (%rax),%eax
  100aa1:	3c 39                	cmp    $0x39,%al
  100aa3:	7f 59                	jg     100afe <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100aa5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100aac:	eb 2e                	jmp    100adc <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100aae:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100ab1:	89 d0                	mov    %edx,%eax
  100ab3:	c1 e0 02             	shl    $0x2,%eax
  100ab6:	01 d0                	add    %edx,%eax
  100ab8:	01 c0                	add    %eax,%eax
  100aba:	89 c1                	mov    %eax,%ecx
  100abc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ac3:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100ac7:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100ace:	0f b6 00             	movzbl (%rax),%eax
  100ad1:	0f be c0             	movsbl %al,%eax
  100ad4:	01 c8                	add    %ecx,%eax
  100ad6:	83 e8 30             	sub    $0x30,%eax
  100ad9:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100adc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ae3:	0f b6 00             	movzbl (%rax),%eax
  100ae6:	3c 2f                	cmp    $0x2f,%al
  100ae8:	0f 8e 85 00 00 00    	jle    100b73 <printer_vprintf+0x2ce>
  100aee:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100af5:	0f b6 00             	movzbl (%rax),%eax
  100af8:	3c 39                	cmp    $0x39,%al
  100afa:	7e b2                	jle    100aae <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100afc:	eb 75                	jmp    100b73 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100afe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b05:	0f b6 00             	movzbl (%rax),%eax
  100b08:	3c 2a                	cmp    $0x2a,%al
  100b0a:	75 68                	jne    100b74 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100b0c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b13:	8b 00                	mov    (%rax),%eax
  100b15:	83 f8 2f             	cmp    $0x2f,%eax
  100b18:	77 30                	ja     100b4a <printer_vprintf+0x2a5>
  100b1a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b21:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b25:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b2c:	8b 00                	mov    (%rax),%eax
  100b2e:	89 c0                	mov    %eax,%eax
  100b30:	48 01 d0             	add    %rdx,%rax
  100b33:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b3a:	8b 12                	mov    (%rdx),%edx
  100b3c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b3f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b46:	89 0a                	mov    %ecx,(%rdx)
  100b48:	eb 1a                	jmp    100b64 <printer_vprintf+0x2bf>
  100b4a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b51:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b55:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b59:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b60:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b64:	8b 00                	mov    (%rax),%eax
  100b66:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100b69:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b70:	01 
  100b71:	eb 01                	jmp    100b74 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100b73:	90                   	nop
            }
            if (precision < 0) {
  100b74:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100b78:	79 07                	jns    100b81 <printer_vprintf+0x2dc>
                precision = 0;
  100b7a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100b81:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100b88:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100b8f:	00 
        int length = 0;
  100b90:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100b97:	48 c7 45 c8 66 15 10 	movq   $0x101566,-0x38(%rbp)
  100b9e:	00 
    again:
        switch (*format) {
  100b9f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ba6:	0f b6 00             	movzbl (%rax),%eax
  100ba9:	0f be c0             	movsbl %al,%eax
  100bac:	83 e8 43             	sub    $0x43,%eax
  100baf:	83 f8 37             	cmp    $0x37,%eax
  100bb2:	0f 87 9f 03 00 00    	ja     100f57 <printer_vprintf+0x6b2>
  100bb8:	89 c0                	mov    %eax,%eax
  100bba:	48 8b 04 c5 78 15 10 	mov    0x101578(,%rax,8),%rax
  100bc1:	00 
  100bc2:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100bc4:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100bcb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100bd2:	01 
            goto again;
  100bd3:	eb ca                	jmp    100b9f <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100bd5:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100bd9:	74 5d                	je     100c38 <printer_vprintf+0x393>
  100bdb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100be2:	8b 00                	mov    (%rax),%eax
  100be4:	83 f8 2f             	cmp    $0x2f,%eax
  100be7:	77 30                	ja     100c19 <printer_vprintf+0x374>
  100be9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bf0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bf4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bfb:	8b 00                	mov    (%rax),%eax
  100bfd:	89 c0                	mov    %eax,%eax
  100bff:	48 01 d0             	add    %rdx,%rax
  100c02:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c09:	8b 12                	mov    (%rdx),%edx
  100c0b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c0e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c15:	89 0a                	mov    %ecx,(%rdx)
  100c17:	eb 1a                	jmp    100c33 <printer_vprintf+0x38e>
  100c19:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c20:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c24:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c28:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c2f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c33:	48 8b 00             	mov    (%rax),%rax
  100c36:	eb 5c                	jmp    100c94 <printer_vprintf+0x3ef>
  100c38:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c3f:	8b 00                	mov    (%rax),%eax
  100c41:	83 f8 2f             	cmp    $0x2f,%eax
  100c44:	77 30                	ja     100c76 <printer_vprintf+0x3d1>
  100c46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c4d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c51:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c58:	8b 00                	mov    (%rax),%eax
  100c5a:	89 c0                	mov    %eax,%eax
  100c5c:	48 01 d0             	add    %rdx,%rax
  100c5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c66:	8b 12                	mov    (%rdx),%edx
  100c68:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c6b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c72:	89 0a                	mov    %ecx,(%rdx)
  100c74:	eb 1a                	jmp    100c90 <printer_vprintf+0x3eb>
  100c76:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c7d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c81:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c85:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c8c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c90:	8b 00                	mov    (%rax),%eax
  100c92:	48 98                	cltq   
  100c94:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100c98:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100c9c:	48 c1 f8 38          	sar    $0x38,%rax
  100ca0:	25 80 00 00 00       	and    $0x80,%eax
  100ca5:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100ca8:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100cac:	74 09                	je     100cb7 <printer_vprintf+0x412>
  100cae:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100cb2:	48 f7 d8             	neg    %rax
  100cb5:	eb 04                	jmp    100cbb <printer_vprintf+0x416>
  100cb7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100cbb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100cbf:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100cc2:	83 c8 60             	or     $0x60,%eax
  100cc5:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100cc8:	e9 cf 02 00 00       	jmp    100f9c <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100ccd:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100cd1:	74 5d                	je     100d30 <printer_vprintf+0x48b>
  100cd3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cda:	8b 00                	mov    (%rax),%eax
  100cdc:	83 f8 2f             	cmp    $0x2f,%eax
  100cdf:	77 30                	ja     100d11 <printer_vprintf+0x46c>
  100ce1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ce8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cf3:	8b 00                	mov    (%rax),%eax
  100cf5:	89 c0                	mov    %eax,%eax
  100cf7:	48 01 d0             	add    %rdx,%rax
  100cfa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d01:	8b 12                	mov    (%rdx),%edx
  100d03:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d06:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d0d:	89 0a                	mov    %ecx,(%rdx)
  100d0f:	eb 1a                	jmp    100d2b <printer_vprintf+0x486>
  100d11:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d18:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d1c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d27:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d2b:	48 8b 00             	mov    (%rax),%rax
  100d2e:	eb 5c                	jmp    100d8c <printer_vprintf+0x4e7>
  100d30:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d37:	8b 00                	mov    (%rax),%eax
  100d39:	83 f8 2f             	cmp    $0x2f,%eax
  100d3c:	77 30                	ja     100d6e <printer_vprintf+0x4c9>
  100d3e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d45:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d50:	8b 00                	mov    (%rax),%eax
  100d52:	89 c0                	mov    %eax,%eax
  100d54:	48 01 d0             	add    %rdx,%rax
  100d57:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d5e:	8b 12                	mov    (%rdx),%edx
  100d60:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d63:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d6a:	89 0a                	mov    %ecx,(%rdx)
  100d6c:	eb 1a                	jmp    100d88 <printer_vprintf+0x4e3>
  100d6e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d75:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d79:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d7d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d84:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d88:	8b 00                	mov    (%rax),%eax
  100d8a:	89 c0                	mov    %eax,%eax
  100d8c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100d90:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100d94:	e9 03 02 00 00       	jmp    100f9c <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100d99:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100da0:	e9 28 ff ff ff       	jmp    100ccd <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100da5:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100dac:	e9 1c ff ff ff       	jmp    100ccd <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100db1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100db8:	8b 00                	mov    (%rax),%eax
  100dba:	83 f8 2f             	cmp    $0x2f,%eax
  100dbd:	77 30                	ja     100def <printer_vprintf+0x54a>
  100dbf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dc6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100dca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dd1:	8b 00                	mov    (%rax),%eax
  100dd3:	89 c0                	mov    %eax,%eax
  100dd5:	48 01 d0             	add    %rdx,%rax
  100dd8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ddf:	8b 12                	mov    (%rdx),%edx
  100de1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100de4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100deb:	89 0a                	mov    %ecx,(%rdx)
  100ded:	eb 1a                	jmp    100e09 <printer_vprintf+0x564>
  100def:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100df6:	48 8b 40 08          	mov    0x8(%rax),%rax
  100dfa:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100dfe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e05:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e09:	48 8b 00             	mov    (%rax),%rax
  100e0c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100e10:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100e17:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100e1e:	e9 79 01 00 00       	jmp    100f9c <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100e23:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e2a:	8b 00                	mov    (%rax),%eax
  100e2c:	83 f8 2f             	cmp    $0x2f,%eax
  100e2f:	77 30                	ja     100e61 <printer_vprintf+0x5bc>
  100e31:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e38:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e3c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e43:	8b 00                	mov    (%rax),%eax
  100e45:	89 c0                	mov    %eax,%eax
  100e47:	48 01 d0             	add    %rdx,%rax
  100e4a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e51:	8b 12                	mov    (%rdx),%edx
  100e53:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e56:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e5d:	89 0a                	mov    %ecx,(%rdx)
  100e5f:	eb 1a                	jmp    100e7b <printer_vprintf+0x5d6>
  100e61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e68:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e6c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e77:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e7b:	48 8b 00             	mov    (%rax),%rax
  100e7e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100e82:	e9 15 01 00 00       	jmp    100f9c <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100e87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e8e:	8b 00                	mov    (%rax),%eax
  100e90:	83 f8 2f             	cmp    $0x2f,%eax
  100e93:	77 30                	ja     100ec5 <printer_vprintf+0x620>
  100e95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e9c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ea0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ea7:	8b 00                	mov    (%rax),%eax
  100ea9:	89 c0                	mov    %eax,%eax
  100eab:	48 01 d0             	add    %rdx,%rax
  100eae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100eb5:	8b 12                	mov    (%rdx),%edx
  100eb7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100eba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ec1:	89 0a                	mov    %ecx,(%rdx)
  100ec3:	eb 1a                	jmp    100edf <printer_vprintf+0x63a>
  100ec5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ecc:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ed0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ed4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100edb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100edf:	8b 00                	mov    (%rax),%eax
  100ee1:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100ee7:	e9 67 03 00 00       	jmp    101253 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  100eec:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100ef0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100ef4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100efb:	8b 00                	mov    (%rax),%eax
  100efd:	83 f8 2f             	cmp    $0x2f,%eax
  100f00:	77 30                	ja     100f32 <printer_vprintf+0x68d>
  100f02:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f09:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f0d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f14:	8b 00                	mov    (%rax),%eax
  100f16:	89 c0                	mov    %eax,%eax
  100f18:	48 01 d0             	add    %rdx,%rax
  100f1b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f22:	8b 12                	mov    (%rdx),%edx
  100f24:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f27:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f2e:	89 0a                	mov    %ecx,(%rdx)
  100f30:	eb 1a                	jmp    100f4c <printer_vprintf+0x6a7>
  100f32:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f39:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f3d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f41:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f48:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f4c:	8b 00                	mov    (%rax),%eax
  100f4e:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100f51:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100f55:	eb 45                	jmp    100f9c <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  100f57:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100f5b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100f5f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f66:	0f b6 00             	movzbl (%rax),%eax
  100f69:	84 c0                	test   %al,%al
  100f6b:	74 0c                	je     100f79 <printer_vprintf+0x6d4>
  100f6d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f74:	0f b6 00             	movzbl (%rax),%eax
  100f77:	eb 05                	jmp    100f7e <printer_vprintf+0x6d9>
  100f79:	b8 25 00 00 00       	mov    $0x25,%eax
  100f7e:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100f81:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100f85:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f8c:	0f b6 00             	movzbl (%rax),%eax
  100f8f:	84 c0                	test   %al,%al
  100f91:	75 08                	jne    100f9b <printer_vprintf+0x6f6>
                format--;
  100f93:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100f9a:	01 
            }
            break;
  100f9b:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100f9c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f9f:	83 e0 20             	and    $0x20,%eax
  100fa2:	85 c0                	test   %eax,%eax
  100fa4:	74 1e                	je     100fc4 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100fa6:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100faa:	48 83 c0 18          	add    $0x18,%rax
  100fae:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100fb1:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100fb5:	48 89 ce             	mov    %rcx,%rsi
  100fb8:	48 89 c7             	mov    %rax,%rdi
  100fbb:	e8 63 f8 ff ff       	call   100823 <fill_numbuf>
  100fc0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100fc4:	48 c7 45 c0 66 15 10 	movq   $0x101566,-0x40(%rbp)
  100fcb:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100fcc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fcf:	83 e0 20             	and    $0x20,%eax
  100fd2:	85 c0                	test   %eax,%eax
  100fd4:	74 48                	je     10101e <printer_vprintf+0x779>
  100fd6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fd9:	83 e0 40             	and    $0x40,%eax
  100fdc:	85 c0                	test   %eax,%eax
  100fde:	74 3e                	je     10101e <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  100fe0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fe3:	25 80 00 00 00       	and    $0x80,%eax
  100fe8:	85 c0                	test   %eax,%eax
  100fea:	74 0a                	je     100ff6 <printer_vprintf+0x751>
                prefix = "-";
  100fec:	48 c7 45 c0 67 15 10 	movq   $0x101567,-0x40(%rbp)
  100ff3:	00 
            if (flags & FLAG_NEGATIVE) {
  100ff4:	eb 73                	jmp    101069 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100ff6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ff9:	83 e0 10             	and    $0x10,%eax
  100ffc:	85 c0                	test   %eax,%eax
  100ffe:	74 0a                	je     10100a <printer_vprintf+0x765>
                prefix = "+";
  101000:	48 c7 45 c0 69 15 10 	movq   $0x101569,-0x40(%rbp)
  101007:	00 
            if (flags & FLAG_NEGATIVE) {
  101008:	eb 5f                	jmp    101069 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  10100a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10100d:	83 e0 08             	and    $0x8,%eax
  101010:	85 c0                	test   %eax,%eax
  101012:	74 55                	je     101069 <printer_vprintf+0x7c4>
                prefix = " ";
  101014:	48 c7 45 c0 6b 15 10 	movq   $0x10156b,-0x40(%rbp)
  10101b:	00 
            if (flags & FLAG_NEGATIVE) {
  10101c:	eb 4b                	jmp    101069 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  10101e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101021:	83 e0 20             	and    $0x20,%eax
  101024:	85 c0                	test   %eax,%eax
  101026:	74 42                	je     10106a <printer_vprintf+0x7c5>
  101028:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10102b:	83 e0 01             	and    $0x1,%eax
  10102e:	85 c0                	test   %eax,%eax
  101030:	74 38                	je     10106a <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  101032:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  101036:	74 06                	je     10103e <printer_vprintf+0x799>
  101038:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  10103c:	75 2c                	jne    10106a <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  10103e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  101043:	75 0c                	jne    101051 <printer_vprintf+0x7ac>
  101045:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101048:	25 00 01 00 00       	and    $0x100,%eax
  10104d:	85 c0                	test   %eax,%eax
  10104f:	74 19                	je     10106a <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  101051:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101055:	75 07                	jne    10105e <printer_vprintf+0x7b9>
  101057:	b8 6d 15 10 00       	mov    $0x10156d,%eax
  10105c:	eb 05                	jmp    101063 <printer_vprintf+0x7be>
  10105e:	b8 70 15 10 00       	mov    $0x101570,%eax
  101063:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101067:	eb 01                	jmp    10106a <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  101069:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  10106a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10106e:	78 24                	js     101094 <printer_vprintf+0x7ef>
  101070:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101073:	83 e0 20             	and    $0x20,%eax
  101076:	85 c0                	test   %eax,%eax
  101078:	75 1a                	jne    101094 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  10107a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10107d:	48 63 d0             	movslq %eax,%rdx
  101080:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101084:	48 89 d6             	mov    %rdx,%rsi
  101087:	48 89 c7             	mov    %rax,%rdi
  10108a:	e8 ea f5 ff ff       	call   100679 <strnlen>
  10108f:	89 45 bc             	mov    %eax,-0x44(%rbp)
  101092:	eb 0f                	jmp    1010a3 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  101094:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101098:	48 89 c7             	mov    %rax,%rdi
  10109b:	e8 a8 f5 ff ff       	call   100648 <strlen>
  1010a0:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1010a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010a6:	83 e0 20             	and    $0x20,%eax
  1010a9:	85 c0                	test   %eax,%eax
  1010ab:	74 20                	je     1010cd <printer_vprintf+0x828>
  1010ad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1010b1:	78 1a                	js     1010cd <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  1010b3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1010b6:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  1010b9:	7e 08                	jle    1010c3 <printer_vprintf+0x81e>
  1010bb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1010be:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1010c1:	eb 05                	jmp    1010c8 <printer_vprintf+0x823>
  1010c3:	b8 00 00 00 00       	mov    $0x0,%eax
  1010c8:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1010cb:	eb 5c                	jmp    101129 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1010cd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010d0:	83 e0 20             	and    $0x20,%eax
  1010d3:	85 c0                	test   %eax,%eax
  1010d5:	74 4b                	je     101122 <printer_vprintf+0x87d>
  1010d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010da:	83 e0 02             	and    $0x2,%eax
  1010dd:	85 c0                	test   %eax,%eax
  1010df:	74 41                	je     101122 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1010e1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010e4:	83 e0 04             	and    $0x4,%eax
  1010e7:	85 c0                	test   %eax,%eax
  1010e9:	75 37                	jne    101122 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  1010eb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1010ef:	48 89 c7             	mov    %rax,%rdi
  1010f2:	e8 51 f5 ff ff       	call   100648 <strlen>
  1010f7:	89 c2                	mov    %eax,%edx
  1010f9:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1010fc:	01 d0                	add    %edx,%eax
  1010fe:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101101:	7e 1f                	jle    101122 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  101103:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101106:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101109:	89 c3                	mov    %eax,%ebx
  10110b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10110f:	48 89 c7             	mov    %rax,%rdi
  101112:	e8 31 f5 ff ff       	call   100648 <strlen>
  101117:	89 c2                	mov    %eax,%edx
  101119:	89 d8                	mov    %ebx,%eax
  10111b:	29 d0                	sub    %edx,%eax
  10111d:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101120:	eb 07                	jmp    101129 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  101122:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101129:	8b 55 bc             	mov    -0x44(%rbp),%edx
  10112c:	8b 45 b8             	mov    -0x48(%rbp),%eax
  10112f:	01 d0                	add    %edx,%eax
  101131:	48 63 d8             	movslq %eax,%rbx
  101134:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101138:	48 89 c7             	mov    %rax,%rdi
  10113b:	e8 08 f5 ff ff       	call   100648 <strlen>
  101140:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  101144:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101147:	29 d0                	sub    %edx,%eax
  101149:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10114c:	eb 25                	jmp    101173 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  10114e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101155:	48 8b 08             	mov    (%rax),%rcx
  101158:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10115e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101165:	be 20 00 00 00       	mov    $0x20,%esi
  10116a:	48 89 c7             	mov    %rax,%rdi
  10116d:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10116f:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101173:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101176:	83 e0 04             	and    $0x4,%eax
  101179:	85 c0                	test   %eax,%eax
  10117b:	75 36                	jne    1011b3 <printer_vprintf+0x90e>
  10117d:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101181:	7f cb                	jg     10114e <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  101183:	eb 2e                	jmp    1011b3 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  101185:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10118c:	4c 8b 00             	mov    (%rax),%r8
  10118f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101193:	0f b6 00             	movzbl (%rax),%eax
  101196:	0f b6 c8             	movzbl %al,%ecx
  101199:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10119f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1011a6:	89 ce                	mov    %ecx,%esi
  1011a8:	48 89 c7             	mov    %rax,%rdi
  1011ab:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1011ae:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1011b3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1011b7:	0f b6 00             	movzbl (%rax),%eax
  1011ba:	84 c0                	test   %al,%al
  1011bc:	75 c7                	jne    101185 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1011be:	eb 25                	jmp    1011e5 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1011c0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1011c7:	48 8b 08             	mov    (%rax),%rcx
  1011ca:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1011d0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1011d7:	be 30 00 00 00       	mov    $0x30,%esi
  1011dc:	48 89 c7             	mov    %rax,%rdi
  1011df:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1011e1:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1011e5:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1011e9:	7f d5                	jg     1011c0 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  1011eb:	eb 32                	jmp    10121f <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  1011ed:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1011f4:	4c 8b 00             	mov    (%rax),%r8
  1011f7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1011fb:	0f b6 00             	movzbl (%rax),%eax
  1011fe:	0f b6 c8             	movzbl %al,%ecx
  101201:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101207:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10120e:	89 ce                	mov    %ecx,%esi
  101210:	48 89 c7             	mov    %rax,%rdi
  101213:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101216:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  10121b:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10121f:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101223:	7f c8                	jg     1011ed <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101225:	eb 25                	jmp    10124c <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101227:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10122e:	48 8b 08             	mov    (%rax),%rcx
  101231:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101237:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10123e:	be 20 00 00 00       	mov    $0x20,%esi
  101243:	48 89 c7             	mov    %rax,%rdi
  101246:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101248:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10124c:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101250:	7f d5                	jg     101227 <printer_vprintf+0x982>
        }
    done: ;
  101252:	90                   	nop
    for (; *format; ++format) {
  101253:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10125a:	01 
  10125b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101262:	0f b6 00             	movzbl (%rax),%eax
  101265:	84 c0                	test   %al,%al
  101267:	0f 85 64 f6 ff ff    	jne    1008d1 <printer_vprintf+0x2c>
    }
}
  10126d:	90                   	nop
  10126e:	90                   	nop
  10126f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101273:	c9                   	leave  
  101274:	c3                   	ret    

0000000000101275 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101275:	55                   	push   %rbp
  101276:	48 89 e5             	mov    %rsp,%rbp
  101279:	48 83 ec 20          	sub    $0x20,%rsp
  10127d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101281:	89 f0                	mov    %esi,%eax
  101283:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101286:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101289:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10128d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101291:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101295:	48 8b 40 08          	mov    0x8(%rax),%rax
  101299:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  10129e:	48 39 d0             	cmp    %rdx,%rax
  1012a1:	72 0c                	jb     1012af <console_putc+0x3a>
        cp->cursor = console;
  1012a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1012a7:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1012ae:	00 
    }
    if (c == '\n') {
  1012af:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1012b3:	75 78                	jne    10132d <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1012b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1012b9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012bd:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1012c3:	48 d1 f8             	sar    %rax
  1012c6:	48 89 c1             	mov    %rax,%rcx
  1012c9:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1012d0:	66 66 66 
  1012d3:	48 89 c8             	mov    %rcx,%rax
  1012d6:	48 f7 ea             	imul   %rdx
  1012d9:	48 c1 fa 05          	sar    $0x5,%rdx
  1012dd:	48 89 c8             	mov    %rcx,%rax
  1012e0:	48 c1 f8 3f          	sar    $0x3f,%rax
  1012e4:	48 29 c2             	sub    %rax,%rdx
  1012e7:	48 89 d0             	mov    %rdx,%rax
  1012ea:	48 c1 e0 02          	shl    $0x2,%rax
  1012ee:	48 01 d0             	add    %rdx,%rax
  1012f1:	48 c1 e0 04          	shl    $0x4,%rax
  1012f5:	48 29 c1             	sub    %rax,%rcx
  1012f8:	48 89 ca             	mov    %rcx,%rdx
  1012fb:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1012fe:	eb 25                	jmp    101325 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101300:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101303:	83 c8 20             	or     $0x20,%eax
  101306:	89 c6                	mov    %eax,%esi
  101308:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10130c:	48 8b 40 08          	mov    0x8(%rax),%rax
  101310:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101314:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101318:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10131c:	89 f2                	mov    %esi,%edx
  10131e:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101321:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101325:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101329:	75 d5                	jne    101300 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  10132b:	eb 24                	jmp    101351 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  10132d:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101331:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101334:	09 d0                	or     %edx,%eax
  101336:	89 c6                	mov    %eax,%esi
  101338:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10133c:	48 8b 40 08          	mov    0x8(%rax),%rax
  101340:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101344:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101348:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10134c:	89 f2                	mov    %esi,%edx
  10134e:	66 89 10             	mov    %dx,(%rax)
}
  101351:	90                   	nop
  101352:	c9                   	leave  
  101353:	c3                   	ret    

0000000000101354 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101354:	55                   	push   %rbp
  101355:	48 89 e5             	mov    %rsp,%rbp
  101358:	48 83 ec 30          	sub    $0x30,%rsp
  10135c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10135f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101362:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101366:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  10136a:	48 c7 45 f0 75 12 10 	movq   $0x101275,-0x10(%rbp)
  101371:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101372:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101376:	78 09                	js     101381 <console_vprintf+0x2d>
  101378:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  10137f:	7e 07                	jle    101388 <console_vprintf+0x34>
        cpos = 0;
  101381:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101388:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10138b:	48 98                	cltq   
  10138d:	48 01 c0             	add    %rax,%rax
  101390:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101396:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  10139a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10139e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1013a2:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1013a5:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1013a9:	48 89 c7             	mov    %rax,%rdi
  1013ac:	e8 f4 f4 ff ff       	call   1008a5 <printer_vprintf>
    return cp.cursor - console;
  1013b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1013b5:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1013bb:	48 d1 f8             	sar    %rax
}
  1013be:	c9                   	leave  
  1013bf:	c3                   	ret    

00000000001013c0 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1013c0:	55                   	push   %rbp
  1013c1:	48 89 e5             	mov    %rsp,%rbp
  1013c4:	48 83 ec 60          	sub    $0x60,%rsp
  1013c8:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1013cb:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1013ce:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1013d2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1013d6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1013da:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1013de:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1013e5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1013e9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1013ed:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1013f1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1013f5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1013f9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1013fd:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101400:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101403:	89 c7                	mov    %eax,%edi
  101405:	e8 4a ff ff ff       	call   101354 <console_vprintf>
  10140a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10140d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101410:	c9                   	leave  
  101411:	c3                   	ret    

0000000000101412 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101412:	55                   	push   %rbp
  101413:	48 89 e5             	mov    %rsp,%rbp
  101416:	48 83 ec 20          	sub    $0x20,%rsp
  10141a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10141e:	89 f0                	mov    %esi,%eax
  101420:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101423:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101426:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10142a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  10142e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101432:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101436:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10143a:	48 8b 40 10          	mov    0x10(%rax),%rax
  10143e:	48 39 c2             	cmp    %rax,%rdx
  101441:	73 1a                	jae    10145d <string_putc+0x4b>
        *sp->s++ = c;
  101443:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101447:	48 8b 40 08          	mov    0x8(%rax),%rax
  10144b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10144f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101453:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101457:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10145b:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  10145d:	90                   	nop
  10145e:	c9                   	leave  
  10145f:	c3                   	ret    

0000000000101460 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101460:	55                   	push   %rbp
  101461:	48 89 e5             	mov    %rsp,%rbp
  101464:	48 83 ec 40          	sub    $0x40,%rsp
  101468:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  10146c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101470:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101474:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101478:	48 c7 45 e8 12 14 10 	movq   $0x101412,-0x18(%rbp)
  10147f:	00 
    sp.s = s;
  101480:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101484:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101488:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  10148d:	74 33                	je     1014c2 <vsnprintf+0x62>
        sp.end = s + size - 1;
  10148f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101493:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101497:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10149b:	48 01 d0             	add    %rdx,%rax
  10149e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1014a2:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1014a6:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1014aa:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1014ae:	be 00 00 00 00       	mov    $0x0,%esi
  1014b3:	48 89 c7             	mov    %rax,%rdi
  1014b6:	e8 ea f3 ff ff       	call   1008a5 <printer_vprintf>
        *sp.s = 0;
  1014bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014bf:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1014c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014c6:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1014ca:	c9                   	leave  
  1014cb:	c3                   	ret    

00000000001014cc <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1014cc:	55                   	push   %rbp
  1014cd:	48 89 e5             	mov    %rsp,%rbp
  1014d0:	48 83 ec 70          	sub    $0x70,%rsp
  1014d4:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1014d8:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1014dc:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1014e0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1014e4:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1014e8:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1014ec:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1014f3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1014f7:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1014fb:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1014ff:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101503:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101507:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10150b:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10150f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101513:	48 89 c7             	mov    %rax,%rdi
  101516:	e8 45 ff ff ff       	call   101460 <vsnprintf>
  10151b:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10151e:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101521:	c9                   	leave  
  101522:	c3                   	ret    

0000000000101523 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101523:	55                   	push   %rbp
  101524:	48 89 e5             	mov    %rsp,%rbp
  101527:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10152b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101532:	eb 13                	jmp    101547 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  101534:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101537:	48 98                	cltq   
  101539:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101540:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101543:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101547:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  10154e:	7e e4                	jle    101534 <console_clear+0x11>
    }
    cursorpos = 0;
  101550:	c7 05 a2 7a fb ff 00 	movl   $0x0,-0x4855e(%rip)        # b8ffc <cursorpos>
  101557:	00 00 00 
}
  10155a:	90                   	nop
  10155b:	c9                   	leave  
  10155c:	c3                   	ret    
