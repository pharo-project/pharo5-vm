object memory support
checkStackIntegrity
	"Perform an integrity/leak check using the heapMap.  Assume
	 clearLeakMapAndMapAccesibleObjects has set a bit at each
	 object's header.  Scan all objects accessible from the stack
	 checking that every pointer points to a header.  Answer if no
	 dangling pointers were detected."
	| ok |
	<inline: false>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	ok := true.
	0 to: numStackPages - 1 do:
		[:i| | thePage theSP theFP callerFP oop |
		thePage := stackPages stackPageAt: i.
		(stackPages isFree: thePage) ifFalse:
			[thePage = stackPage
				ifTrue:
					[theSP := stackPointer.
					 theFP := framePointer]
				ifFalse:
					[theSP := thePage headSP.
					 theFP := thePage  headFP].
			 "Skip the instruction pointer on top of stack of inactive pages."
			 thePage = stackPage ifFalse:
				[theSP := theSP + objectMemory wordSize].
			 [[theSP <= (theFP + FoxReceiver)] whileTrue:
				[oop := stackPages longAt: theSP.
				 ((objectMemory isNonImmediate: oop) 
				   and: [(objectMemory heapMapAtWord: (self pointerForOop: oop)) = 0]) ifTrue:
					[self printFrameThing: 'object leak in frame temp' andFrame: theFP at: theSP.
					 ok := false].
				 theSP := theSP + objectMemory wordSize].
			 (self frameHasContext: theFP) ifTrue:
				[oop := self frameContext: theFP.
				 ((objectMemory isImmediate: oop) 
				   or: [(objectMemory heapMapAtWord: (self pointerForOop: oop)) = 0]) ifTrue:
					[self printFrameThing: 'object leak in frame ctxt' andFrame: theFP at: theFP + FoxThisContext.
					 ok := false].
				 (objectMemory isContext: oop) ifFalse:
					[self printFrameThing: 'frame ctxt should be context' andFrame: theFP at: theFP + FoxThisContext.
					 ok := false].
				 ((objectMemory isContext: oop) and: [self isMarriedOrWidowedContext: oop]) ifFalse:
					[self printFrameThing: 'frame ctxt should be married' andFrame: theFP at: theFP + FoxThisContext.
					 ok := false].
				 ((objectMemory isContext: oop)
				  and: [(self isMarriedOrWidowedContext: oop)
				  and: [(self frameOfMarriedContext: oop) = theFP]]) ifFalse:
					[self printFrameThing: 'frame ctxt should be married to this frame ' andFrame: theFP at: theFP + FoxThisContext.
					 ok := false]].
			 oop := self frameMethod: theFP.
			 ((objectMemory isImmediate: oop) 
			   or: [(objectMemory heapMapAtWord: (self pointerForOop: oop)) = 0]) ifTrue:
				[self printFrameThing: 'object leak in frame mthd' andFrame: theFP at: theFP + FoxMethod.
				 ok := false].
			 (callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
				[theSP := theFP + FoxCallerSavedIP + objectMemory wordSize.
				 theFP := callerFP].
			 theSP := theFP + FoxCallerSavedIP + objectMemory wordSize.
			 [theSP <= thePage baseAddress] whileTrue:
				[oop := stackPages longAt: theSP.
				 ((objectMemory isNonImmediate: oop) 
				   and: [(objectMemory heapMapAtWord: (self pointerForOop: oop)) = 0]) ifTrue:
					[self printFrameThing: 'object leak in frame arg' andFrame: theFP at: theSP.
					 ok := false].
				 theSP := theSP + objectMemory wordSize]]].
	^ok