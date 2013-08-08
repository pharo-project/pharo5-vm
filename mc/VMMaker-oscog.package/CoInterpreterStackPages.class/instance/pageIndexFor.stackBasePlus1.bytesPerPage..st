page access
pageIndexFor: pointer "<Integer>" stackBasePlus1: stkBasePlus1 "<Integer>" bytesPerPage: pageByteSize "<Integer>"
	"Answer the page index for a pointer into stack memory, i.e. the index
	 for the page the address is in.  N.B.  This is a zero-relative index."
	<cmacro: '(pointer,stkBasePlus1,pageByteSize) (((char *)(pointer) - (stkBasePlus1)) / (pageByteSize))'>
	^pointer - stkBasePlus1 // pageByteSize