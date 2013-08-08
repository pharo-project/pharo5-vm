initialization
computeStackZoneSize
	"In C the StackPage structs live next to the actual stack pages in the alloca'ed stack
	 zone.  In simulation these live in some dictionary and don't exist in the memory."
	^numStackPages * ((self cCode: 'sizeof(StackPage)' inSmalltalk: [0])
						+ self stackPageByteSize)
	 + stackPages extraStackBytes