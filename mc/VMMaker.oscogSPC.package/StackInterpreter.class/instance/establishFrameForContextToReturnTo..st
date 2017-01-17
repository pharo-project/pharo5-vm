frame access
establishFrameForContextToReturnTo: contextToReturnTo
	| thePage |
	<var: #thePage type: #'StackPage *'>
	<returnTypeC: 'char *'>
	(objectMemory isContext: contextToReturnTo) ifFalse:
		[^0].
	(self isMarriedOrWidowedContext: contextToReturnTo) ifTrue:
		[(self isWidowedContext: contextToReturnTo) ifTrue:
			["error: home's sender is dead; cannot return"
			 ^0].
		 ^self frameOfMarriedContext: contextToReturnTo].
	(objectMemory isIntegerObject: (objectMemory fetchPointer: InstructionPointerIndex ofObject: contextToReturnTo)) ifFalse:
		[^0].
	thePage := self makeBaseFrameFor: contextToReturnTo.
	stackPages markStackPageMostRecentlyUsed: thePage.
	^thePage baseFP