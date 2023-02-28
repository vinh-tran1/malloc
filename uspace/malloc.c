#include "malloc.h"

//====================================================//
//My struct for implicit free list, is a header struct
//====================================================//
typedef struct block_header{
    int allocated; //0 for free, 1 for allocated
    uint64_t size; //size of whole chunk (headersize + payload)
    struct block_header* next; //points to next block_header
    void *block_payload; //points to payload
} bh;

//declare head and end node
bh* head = NULL; bh *end = NULL;

//====================================================//
//My Macros
//====================================================//
#define ALIGNMENT 8
#define ALIGN_8(size) (((size) + (ALIGNMENT-1)) & ~(ALIGNMENT-1))
#define HEADER_SIZE ALIGN_8(sizeof(bh))
#define GET_HEADER(block_payload) ((bh*)((uintptr_t)block_payload - HEADER_SIZE))
#define NEXT_HEADER(header, alignedbytes) ((bh*)((uintptr_t)header + alignedbytes)) //aligned bytes = payload + headersize
#define GET_PAYLOAD(header) ((void*)((uintptr_t)header + HEADER_SIZE))
#define UINTMAX 0xFFFFFFFFFFFFFFFF

//====================================================//
//Helper Declarations
//====================================================//
void init_node(bh* ptr, int allocated, size_t size);
bh* addToHeap(uint64_t size);
void splitBlock(uint64_t alignedbytes, bh* b);
void setFreeAndAlloc(heap_info_struct * info);
void swapSize(long *a, long *b);
void swapPtr(void **a, void **b);
void quickSort(long *sizeArray, void **ptrArray, int low, int high);
//====================================================//

//-----------helper functions------------------//
void init_node(bh* ptr, int allocated, size_t size)
{
    ptr->allocated = allocated;
    ptr->size = size;
    ptr->block_payload = GET_PAYLOAD(ptr);
}

bh* addToHeap(uint64_t alignedbytes)
{
    void *newbp = sbrk(alignedbytes);
    if (newbp == (void*)-1) 
        return NULL;
        
    bh *newhead = (bh*)newbp;
    init_node(newbp, 1, alignedbytes);

    newhead->next = NULL;  

    return newhead;
}

void splitBlock(uint64_t alignedbytes, bh* b)
{
    bh *new = NEXT_HEADER(b, alignedbytes); //new now points to end of curr's payload
    init_node(new, 0, b->size - alignedbytes); //set struct values

    if (b->next == NULL)//set new end pointer if b points to end (i.e. now new is end)        
        end = new;
    
    new->next = b->next; 
    b->next = new;
    b->size = alignedbytes;
}

void setFreeAndAlloc(heap_info_struct * info)
{
    int numAllocs = 0; //store current number of allocations
    int freeSpace = 0; //size of free space
    int largestFreeChunk = 0; //size of the largest free chunk

    //===========================================//
    //initial loop to get data for number of allocs and frees
    bh* curr = head;
    while (curr != NULL)
    {
        if (curr->allocated == 1)
            numAllocs++;
        else {
            freeSpace += curr->size;
            if (curr->size > (uint64_t)largestFreeChunk) //basic algorithm for finding max
                largestFreeChunk = curr->size;
        }
        curr = curr->next;
    }
    //===========================================//
    //set the 3 fields from previous while loop in the info struct
    info->free_space = freeSpace;
    info->largest_free_chunk = largestFreeChunk;
    info->num_allocs = numAllocs;
    //===========================================//
}
//===========================================//
//qsort helpers via programiz.com
//===========================================//

// function to swap elements of type long
void swapSize(long *a, long *b) {
  long temp = *a;
  *a = *b;
  *b = temp;
}

//function to swap elemnts of type void*
void swapPtr(void **a, void **b) {
  void *temp = *a;
  *a = *b;
  *b = temp;
}

//function to partition the array on the basis of pivot element
int partition(long *sizeArray, void **ptrArray, int low, int high)
{
    // select the rightmost element as pivot
    long pivot = sizeArray[high];
    // index of smaller element
    int i = low - 1;
    // traverse each element of the array and compare them with the pivot
    for (int j = low; j < high; j++) 
    {
        if (sizeArray[j] > pivot) 
        {
            i++; //if element smaller than pivot is found swap it with the greater element pointed by i
            swapSize(&sizeArray[i], &sizeArray[j]); // swap element at i with element at j
            swapPtr(&ptrArray[i], &ptrArray[j]); // do the same but now with ptr array
        }
    }
    swapSize(&sizeArray[i+1], &sizeArray[high]); //swap the pivot element with the greater element at i
    swapPtr(&ptrArray[i+1], &ptrArray[high]); //do the same ordering with with pointer array
    
    return (i + 1); // return the partition point
}

//this will sort both size and ptr array because we have 2 swap functions we can call
//we will order the ptr array in the same order of the size array by using size array pivot points and mirroring that to ptr array
void quickSort(long *sizeArray, void **ptrArray, int low, int high) 
{
  if (low < high) 
  {
    // find the pivot element such that elements smaller than pivot are on left of pivot elements greater than pivot are on right of pivot
    int pi = partition(sizeArray, ptrArray, low, high);
    
    // recursive call on the left of pivot
    quickSort(sizeArray, ptrArray, low, pi - 1);
    
    // recursive call on the right of pivot
    quickSort(sizeArray, ptrArray, pi + 1, high);
  }
}

//===========================================//
//begin malloc functions
//===========================================//
void *malloc(uint64_t numbytes) {
    uint64_t alignedbytes = ALIGN_8(numbytes + HEADER_SIZE);
    bh *curr = head;

    //out of bounds
    if ((numbytes == 0) || ((numbytes + (uint64_t)HEADER_SIZE) > UINTMAX))
        return NULL;

    //traverse linked list
    while (curr != NULL)
    {   
        //if open spot is big enough, then insert malloc call in curr node by changing header struct data
        if ((curr->allocated == 0) && (curr->size >= alignedbytes))
        {
            curr->allocated = 1; //set to allocated 

            if (HEADER_SIZE <= (curr->size - alignedbytes)) //if there's left over room after inserting header and payload, then split current block into 2
                splitBlock(alignedbytes, curr);

            return curr->block_payload; 
        }
        curr = curr->next;
    }

    //else, curr == NULL means we are at end of heap, sbrk more mem for header, insert node at end
    curr = addToHeap(alignedbytes);
    if (curr == NULL) return NULL;
    //first iteration of malloc
    if (head == NULL){
        head = curr;
        end = curr;
    }
    //end pointer is used to link the new node at end to previous one, end is set to last non null node
    else{ 
        end->next = curr;
        end = curr;
    }

    curr->next = NULL;  

    return curr->block_payload; 
}

void * calloc(uint64_t num, uint64_t sz) {
    //out of bounds
    if (num == 0 || sz == 0)
        return NULL;
    
    //out of bounds
    uint64_t size = num*sz;
    if (size > (UINTMAX - HEADER_SIZE))
        return NULL;

    void *array = malloc(size);
    if (array != NULL)
        memset(array, 0, size);
    return array;
}

void free(void *firstbyte) {
    if (firstbyte == NULL) 
        return;
    //given a block payload, move back to header struct
    bh* curr = GET_HEADER(firstbyte);
    curr->allocated = 0;
    return;
}

void * realloc(void * ptr, uint64_t sz) {
    //out of bounds
    if (sz > (UINTMAX - HEADER_SIZE))
        return NULL;
     // if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
    if (ptr == NULL)
        malloc(sz);
    // if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr) 
    //unless ptr is NULL, it must have been returned by an earlier call to malloc(), or realloc().
    if (sz == 0 && ptr != NULL)
        free(ptr);
    
    // if the area pointed to was moved, a free(ptr) is done.
    void *re = malloc(sz);
    if (re != NULL)
    {
         memcpy(re, ptr, sz);
         free(ptr);
    }
       
    return re;
}

//just loop through list and combine adjacent free blocks and update the size of the first one
void defrag() {
    bh *curr = head; 
    while(curr != NULL && curr->next != NULL)
    {
        if (curr->allocated == 0 && curr->next->allocated == 0)
        {
            curr->size = curr->size + curr->next->size;
            curr->next = curr->next->next;
        }
        else
            curr = curr->next;
    }
}

int heap_info(heap_info_struct * info) {
    void **ptrArray = NULL; //pointer to an array of pointers of each allocation
    long *sizeArray = NULL; //pointer to an array of size of each allocation

    //===========================================//
    setFreeAndAlloc(info); //sets num_allocs, free_space, and largest_free_chunk
    if (info->num_allocs == 0) //if no size, just set arrays in struct to NULL
    {
        info->size_array = sizeArray;
        info->ptr_array = ptrArray;
        return 0;
    }
       
    //===========================================//
    //now we fill in array values
    //===========================================//
    uint64_t sizeLong = (uint64_t)info->num_allocs * sizeof(long); 
    uint64_t sizeUint = (uint64_t)info->num_allocs * sizeof(uintptr_t);
    sizeArray = malloc(sizeLong);
    ptrArray = malloc(sizeUint);

    if (sizeArray == NULL || ptrArray == NULL)
    {
        //free malloced arrays I declared earlier
        for (int j = 0; j < info->num_allocs; j++)
            free(ptrArray[j]);
        free(sizeArray);
        free(ptrArray);

        return -1;
    }
       
    bh *curr = head; int i = 0;
    while(curr != NULL)
    {
        if (curr->allocated == 1) //load in allocated chunks
        {
            sizeArray[i] = curr->size - HEADER_SIZE; //gets size of allocated requested from malloc i.e. payload
            ptrArray[i] = curr->block_payload; //pointer to payload allocations
            i++;
        }
        curr = curr->next;
    }
    //===========================================//
    //qsort implementation via programiz.com
    quickSort(sizeArray, ptrArray, 0, info->num_allocs-1);
    info->size_array = sizeArray;
    info->ptr_array = ptrArray;
    //===========================================//

    return 0;
}
