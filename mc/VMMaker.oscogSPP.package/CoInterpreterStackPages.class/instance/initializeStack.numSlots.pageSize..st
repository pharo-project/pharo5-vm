initialization
initializeStack: theStackPages numSlots: stackSlots pageSize: slotsPerPage
	"Initialize the stack pages.  In the C VM theStackPages will be alloca'ed memory to hold the
	 stack pages on the C stack.  In the simulator they are housed in the memory between the
	 cogMethodZone and the heap."

	<var: #theStackPages type: #'char *'>
	<returnTypeC: #void>
	| numPages page structStackPageSize pageStructBase count |
	<var: #page type: #'StackPage *'>
	<var: #pageStructBase type: #'char *'>
	self cCode: []
		inSmalltalk:
			[self assert: objectMemory startOfMemory - coInterpreter cogCodeSize - Cogit guardPageSize - coInterpreter methodCacheSize - coInterpreter primTraceLogSize - coInterpreter rumpCStackSize
					= (stackSlots * objectMemory wordSize roundUpTo: objectMemory allocationUnit)].
	structStackPageSize := coInterpreter sizeof: CogStackPage.
	bytesPerPage := slotsPerPage * objectMemory wordSize.
	numPages := coInterpreter numStkPages.

	"Because stack pages grow down baseAddress is at the top of a stack page and so to avoid
	 subtracting BytesPerWord from baseAddress and lastAddress in the init loop below we simply
	 push the stackPage array up one word to avoid the overlap.  This word is extraStackBytes."
	pageStructBase := theStackPages + (numPages * bytesPerPage) + objectMemory wordSize.
	pages := self cCode: [self cCoerceSimple: pageStructBase to: #'StackPage *']
				  inSmalltalk:
					[pageMap := Dictionary new.
					 ((0 to: numPages - 1) collect:
						[:i|
						 CogStackPage surrogateClass new
							address: pageStructBase + (i * structStackPageSize)
							simulator: coInterpreter
							zoneBase: coInterpreter stackZoneBase
							zoneLimit: objectMemory startOfMemory])
						do: [:pageSurrogate|
							pageMap at: pageSurrogate address put: pageSurrogate];
						yourself].
	"make sure there's enough headroom"
	self assert: coInterpreter stackPageByteSize - coInterpreter stackLimitBytes - coInterpreter stackLimitOffset
				>= coInterpreter stackPageHeadroom.
	0 to: numPages - 1 do:
		[:index|
		 page := self stackPageAt: index.
		 page
			lastAddress: theStackPages + (index * bytesPerPage);
			baseAddress: page lastAddress + bytesPerPage;
			stackLimit: page baseAddress - coInterpreter stackLimitBytes;
			realStackLimit: page stackLimit;
			baseFP: 0;
			nextPage: (self stackPageAt: (index = (numPages - 1) ifTrue: [0] ifFalse: [index + 1]));
			prevPage: (self stackPageAt: (index = 0 ifTrue: [numPages - 1] ifFalse: [index - 1]))].

	"Now compute stackBasePlus1 so that the pageIndexFor: call maps all addresses from
	 aPage baseAddress to aBase limitAddress + 1 to the same index (stacks grow down)"
	stackBasePlus1 := (self cCoerceSimple: theStackPages to: #'char *') + 1.
	self cCode: []
		inSmalltalk:
			[minStackAddress := theStackPages.
			 maxStackAddress := theStackPages + (numPages * bytesPerPage) + objectMemory wordSize - 1].

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
		 self cCode: []
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
	 self assert: (self pageIndexFor: page lastAddress + 1) == theIndex.
	 (page := page nextPage) ~= mostRecentlyUsedPage] whileTrue.
	self assert: count == numPages.
	self assert: self pageListIsWellFormed