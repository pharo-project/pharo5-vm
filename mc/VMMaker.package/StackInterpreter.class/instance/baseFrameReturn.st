return bytecodes
baseFrameReturn
	"Return from a baseFrame (the bottom frame in a stackPage).  The context to
	 return to (which may be married) is stored in the saved instruction pointer slot."
	<inline: true>
	| contextToReturnTo isAContext theFP theSP thePage frameAbove |
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #frameAbove type: #'char *'>
	contextToReturnTo := self frameCallerContext: localFP.
	isAContext := objectMemory isContext: contextToReturnTo.
	(isAContext
	 and: [self isStillMarriedContext: contextToReturnTo])
		ifTrue:
			[theFP := self frameOfMarriedContext: contextToReturnTo.
			 thePage := stackPages stackPageFor: theFP.
			 theFP = thePage headFP
				ifTrue:
					[theSP := thePage headSP.
					 stackPages freeStackPageNoAssert: stackPage "for a short time invariant is violated; assert follows"]
				ifFalse:
					["Returning to some interior frame, presumably because of a sender assignment.
					  Move the frames above to another page (they may be in use, e.g. via coroutining).
					  Make the interior frame the top frame."
					 frameAbove := self findFrameAbove: theFP inPage: thePage.
					 "Reuse the page we're exiting, which avoids allocating a new page and
					  manipulating the page list to mark the page we're entering as least recently
					  used (to avoid it being deallocated when allocating a new page)."
					 self moveFramesIn: thePage through: frameAbove toPage: stackPage.
					 theFP := thePage headFP.
					 theSP := thePage headSP]]
		ifFalse:
			[(isAContext
			  and: [objectMemory isIntegerObject: (objectMemory fetchPointer: InstructionPointerIndex ofObject: contextToReturnTo)]) ifFalse:
				[^self internalCannotReturn: localReturnValue].
			 thePage := self makeBaseFrameFor: contextToReturnTo.
			 theFP := thePage headFP.
			 theSP := thePage headSP.
			 stackPages freeStackPageNoAssert: stackPage "for a short time invariant is violated; assert follows"].
	self setStackPageAndLimit: thePage.
	self assert: (stackPages stackPageFor: theFP) = stackPage.
	localSP := theSP.
	localFP := theFP.
	self setMethod: (self frameMethod: localFP).
	localIP := self pointerForOop: self internalStackTop.
	self internalStackTopPut: localReturnValue.
	self assert: (self checkIsStillMarriedContext: contextToReturnTo currentFP: localFP).
	^self fetchNextBytecode