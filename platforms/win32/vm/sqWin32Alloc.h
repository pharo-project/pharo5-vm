#ifndef __SQ_WIN32_ALLOC_H
#define __SQ_WIN32_ALLOC_H

#ifndef NO_VIRTUAL_MEMORY

/*
   Limit the default size for virtual memory to 512MB to avoid nasty
   spurious problems when large dynamic libraries are loaded later.
   Applications needing more virtual memory can increase the size by
   defining it appropriately - here we try to cater for the common
   case by using a "reasonable" size that will leave enough space for
   other libraries. 
   
   Note, the amount of virtual memory can be changed in .ini file
   by adding
   AddressSpaceLimit = <your value> 
   in MBytes.
   The MAX_VIRTUAL_MEMORY is a default value, if AddressSpaceLimit is not specified in .ini file
   
*/
#ifndef MAX_VIRTUAL_MEMORY
#define MAX_VIRTUAL_MEMORY 512 /* in MBytes */
#endif

/* Memory initialize-release */
#undef sqAllocateMemory
#undef sqGrowMemoryBy
#undef sqShrinkMemoryBy
#undef sqMemoryExtraBytesLeft

void *sqAllocateMemory(usqInt minHeapSize, usqInt desiredHeapSize);
#define allocateMemoryMinimumImageFileHeaderSize(heapSize, minimumMemory, fileStream, headerSize) \
sqAllocateMemory(minimumMemory, heapSize)
int sqGrowMemoryBy(int oldLimit, int delta);
int sqShrinkMemoryBy(int oldLimit, int delta);
int sqMemoryExtraBytesLeft(int includingSwap);

void sqReleaseMemory(void);

#endif /* NO_VIRTUAL_MEMORY */
#endif /* __SQ_WIN32_ALLOC_H */
