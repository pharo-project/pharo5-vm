page access
pageIndexFor: pointer "<Integer>" stackMemory: stackmem "<Integer>" bytesPerPage: pageByteSize "<Integer>"
	"Answer the page index for a pointer into stack memory, i.e. the index
	 for the page the address is in.  N.B.  This is a zero-relative index."
	| memIndex |
	<cmacro: '(pointer,stackmem,pageByteSize) (((char *)(pointer) - (stackmem) - 1) / (pageByteSize))'>
	memIndex := self memIndexFor: pointer.
	self assert: (memIndex between: 1 and: stackMemory size).
	^memIndex - 1 // pageSizeInSlots