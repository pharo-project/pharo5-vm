debug printing
printFrame: theFP
	| thePage frameAbove theSP |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<var: #frameAbove type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	(stackPages couldBeFramePointer: theFP) ifFalse:
		[self printHexPtr: theFP; print: ' is not in the stack zone?!'; cr.
		 ^nil].
	frameAbove := nil.
	theFP = framePointer
		ifTrue: [theSP := stackPointer]
		ifFalse:
			[thePage := stackPages stackPageFor: theFP.
			 (stackPages isFree: thePage) ifTrue:
				[self printHexPtr: theFP; print: ' is on a free page?!'; cr.
				 ^nil].
			 (thePage ~= stackPage
			  and: [theFP = thePage headFP])
				ifTrue: [theSP := thePage headSP]
				ifFalse:
					[frameAbove := self safeFindFrameAbove: theFP
										on: thePage
										startingFrom: ((thePage = stackPage
														and: [framePointer
																between: thePage realStackLimit
																and: thePage baseAddress])
														ifTrue: [framePointer]
														ifFalse: [thePage headFP]).
					 theSP := frameAbove ifNotNil:
								[self frameCallerSP: frameAbove]]].
	theSP ifNil:
		[self print: 'could not find sp; using bogus value'; cr.
		 theSP := self frameReceiverLocation: theFP].
	self printFrame: theFP WithSP: theSP.
	frameAbove ifNotNil:
		[self printFrameThing: 'frame pc' at: frameAbove + FoxCallerSavedIP]