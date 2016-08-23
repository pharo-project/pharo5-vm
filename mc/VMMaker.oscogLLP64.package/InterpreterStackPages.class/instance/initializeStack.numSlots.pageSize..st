initialization
initializeStack: theStackPages numSlots: stackSlots pageSize: slotsPerPage
	"Initialize the stack pages.  For testing I want stack addresses to be disjoint from
	 normal memory addresses so stack addresses are negative.  The first address is
	 -pageSize bytes.  So for example if there are 1024 bytes per page and 3 pages
	 then the pages are organized as

		byte address: -1024 <-> -2047 | -2048 <-> -3071 | -3072 <-> -4096 |
							page 3			page 2			page 1
		mem index:        769 <-> 513  |     512 <->  257  |   256 <->        1 |

	 The byte address is the external address corresponding to a real address in the VM.
	 mem index is the index in the memory Array holding the stack, an index internal to
	 the stack pages.  The first stack page allocated will be the last page in the array of pages
	 at the highest effective address.  Its base address be -1024  and grow down towards -2047."

	"The lFoo's are to get around the foo->variable scheme in the C call to allocStackPages below."
	<var: #theStackPages type: #'char *'>
	| numPages page structStackPageSize pageStructBase count |
	<var: #page type: #'StackPage *'>
	<var: #pageStructBase type: #'char *'>
	self cCode: ''
		inSmalltalk:
			[self assert: stackMemory size = stackSlots.
			 self assert: stackMemory == theStackPages].
	stackMemory := theStackPages. "For initialization in the C code."
	self cCode: '' inSmalltalk: [pageSizeInSlots := slotsPerPage].
	structStackPageSize := coInterpreter sizeof: CogStackPage.
	bytesPerPage := slotsPerPage * objectMemory wordSize.
	numPages := coInterpreter numStkPages.

	"Because stack pages grow down baseAddress is at the top of a stack page and so to avoid
	 subtracting BytesPerWord from baseAddress and lastAddress in the init loop below we simply
	 push the stackPage array up one word to avoid the overlap.  This word is extraStackBytes."
	pageStructBase := theStackPages + (numPages * bytesPerPage) + objectMemory wordSize.
	pages := self cCode: '(StackPage *)pageStructBase'
				  inSmalltalk:
						[pageStructBase class.
						 (1 to: numPages) collect: [:i| CogStackPage new]].

	"Simulation only.  Since addresses are negative the offset is positive.  To make all
	 stack addresses negative we make the offset a page more than it needs to be so the
	 address of the last slot in memory (the highest address in the stack, or its start) is
		- pageByteSize
	 and the address of the first slot (the lowest address, or its end) is
		- pageByteSize * (numPages + 1)"
	self cCode: '' inSmalltalk: [indexOffset := (numPages + 1) * slotsPerPage].
	"make sure there's enough headroom"
	self assert: coInterpreter stackPageByteSize - coInterpreter stackLimitBytes - coInterpreter stackLimitOffset
				>= coInterpreter stackPageHeadroom.
	0 to: numPages - 1 do:
		[:index|
		 page := self stackPageAt: index.
		 page
			lastAddress: (self cCode: '(char *)theStackPages + (index * GIV(bytesPerPage))'
							inSmalltalk: [(index * slotsPerPage - indexOffset) * objectMemory wordSize]);
			baseAddress: (page lastAddress + bytesPerPage);
			stackLimit: page baseAddress - coInterpreter stackLimitBytes;
			realStackLimit: page stackLimit;
			baseFP: 0;
			nextPage: (self stackPageAt: (index = (numPages - 1) ifTrue: [0] ifFalse: [index + 1]));
			prevPage: (self stackPageAt: (index = 0 ifTrue: [numPages - 1] ifFalse: [index - 1]))].
	self cCode: ''
		inSmalltalk:
			[| lowestAddress highestAddress |
			lowestAddress := (pages at: 1) lastAddress + objectMemory wordSize.
			highestAddress := (pages at: numPages) baseAddress.
			"see InterpreterStackPages>>longAt:"
			self assert: lowestAddress // objectMemory wordSize + indexOffset = 1.
			self assert: highestAddress // objectMemory wordSize + indexOffset = (numPages * slotsPerPage)].

	"The overflow limit is the amount of stack to retain when moving frames from an overflowing
	 stack to reduce thrashing.  See stackOverflowOrEvent:mayContextSwitch:"
	page := self stackPageAt: 0.
	overflowLimit := page baseAddress - page realStackLimit * 3 // 5.

	0 to: numPages - 1 do:
		[:index|
		 page := self stackPageAt: index.
		 self assert: (self pageIndexFor: page baseAddress) == index.
		 self assert: (self pageIndexFor: page baseAddress - (slotsPerPage - 1 * objectMemory wordSize)) == index.
		 self assert: (self stackPageFor: page baseAddress) == page.
		 self assert: (self stackPageFor: page stackLimit) == page.
		 self cCode: ''
			inSmalltalk:
				[| memIndex |
				 memIndex := index * slotsPerPage + 1. "this is memIndex in the block above"
				 self assert: (self memIndexFor: (self oopForPointer: page baseAddress))
							== (memIndex + slotsPerPage - 1).
				 index < (numPages - 1) ifTrue:
					[self assert: (self stackPageFor: page baseAddress + objectMemory wordSize) == (self stackPageAt: index + 1)]].
		coInterpreter initializePageTraceToInvalid: page].

	mostRecentlyUsedPage := self stackPageAt: 0.
	page := mostRecentlyUsedPage.
	count := 0.
	[| theIndex |
	 count := count + 1.
	 theIndex := self pageIndexFor: page baseAddress.
	 self assert: (self stackPageAt: theIndex) == page.
	 self assert: (self pageIndexFor: page baseAddress) == theIndex.
	 self assert: (self pageIndexFor: page stackLimit) == theIndex.
	 self assert: (self pageIndexFor: page lastAddress + objectMemory wordSize) == theIndex.
	 (page := page nextPage) ~= mostRecentlyUsedPage] whileTrue.
	self assert: count == numPages.
	self assert: self pageListIsWellFormed