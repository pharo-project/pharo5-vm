A CArrayOfLongsAccessor is a class that wraps an Array stored in the heap.  It maps at:[put:] into a suitably aligned and offset longAt:[put:], for accessing Arrays stored in the heap, such as the primTraceLog.

Instance Variables
	address:			<Integer>
	entryByteSize:		<Integer>
	objectMemory:		<NewCoObjectMemorySimulator|Spur64BitMMLECoSimulator|Spur64BitMMLECoSimulator|Spur64BitMMBECoSimulator|Spur64BitMMBECoSimulator>

address
	- the base address in the heap of the start of the array

entryByteSize
	- the size of an element, in bytes

objectMemory
	- the memory manager whose heap is being accessed
