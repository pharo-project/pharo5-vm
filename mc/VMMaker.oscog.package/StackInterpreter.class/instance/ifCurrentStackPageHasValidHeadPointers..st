stack pages
ifCurrentStackPageHasValidHeadPointers: thePage
	"If thePage is the stackPage and the stackPointer and/or the framePointer are pointing within it,
	 answer if thePage's heapSP and headFP are equal to the stackPointer and framePointer respectively."
	<var: #thePage type: #'StackPage *'>
	thePage = stackPage ifTrue:
		[(thePage addressIsInPage: framePointer) ifTrue:
			[thePage headFP ~= framePointer ifTrue:
				[^false]].
		(thePage addressIsInPage: stackPointer) ifTrue:
			[thePage headSP ~= stackPointer ifTrue:
				[^false]]].
	^true