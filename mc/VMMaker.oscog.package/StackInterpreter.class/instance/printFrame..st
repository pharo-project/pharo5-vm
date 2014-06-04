debug printing
printFrame: theFP
	| thePage theSP |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	theFP = framePointer
		ifTrue: [theSP := stackPointer]
		ifFalse:
			[thePage := stackPages stackPageFor: theFP.
			 (stackPages isFree: thePage) ifTrue:
				[self printHexPtr: theFP; print: ' is on a free page?!'; cr.
				 ^nil].
			 theSP := self findSPOrNilOf: theFP
						on: thePage
						startingFrom: ((thePage = stackPage
									and: [framePointer < thePage headFP])
										ifTrue: [framePointer]
										ifFalse: [thePage headFP])].
	theSP isNil ifTrue:
		[self print: 'could not find sp; using bogus value'; cr.
		 theSP := theFP + FoxReceiver].
	self printFrame: theFP WithSP: theSP