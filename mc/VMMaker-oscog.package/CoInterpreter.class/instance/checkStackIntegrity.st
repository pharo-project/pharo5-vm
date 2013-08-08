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
	<var: #frameRcvrOffset type: #'char *'>
	<var: #cogMethod type: #'CogMethod *'>
	ok := true.
	0 to: numStackPages - 1 do:
		[:i| | thePage theSP theFP frameRcvrOffset callerFP oop |
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
				[theSP := theSP + BytesPerWord].
			 [frameRcvrOffset := self frameReceiverOffset: theFP.
			  [theSP <= frameRcvrOffset] whileTrue:
				[oop := stackPages longAt: theSP.
				 ((objectMemory isNonIntegerObject: oop) 
				   and: [(self heapMapAtWord: (self pointerForOop: oop)) = 0]) ifTrue:
					[self printFrameThing: 'object leak in frame temp' at: theSP; cr.
					 ok := false].
				 theSP := theSP + BytesPerWord].
			 (self frameHasContext: theFP) ifTrue:
				[oop := self frameContext: theFP.
				 ((objectMemory isIntegerObject: oop) 
				   or: [(self heapMapAtWord: (self pointerForOop: oop)) = 0]) ifTrue:
					[self printFrameThing: 'object leak in frame ctxt' at: theFP + FoxThisContext; cr.
					 ok := false].
				 (oop = objectMemory nilObject or: [objectMemory isContext: oop]) ifFalse:
					[self printFrameThing: 'frame ctxt should be context' at: theFP + FoxThisContext; cr.
					 ok := false]].
			 (self isMachineCodeFrame: theFP)
				ifTrue:
					[| cogMethod |
					 cogMethod := self mframeHomeMethod: theFP.
					 (self heapMapAtWord: (self pointerForOop: cogMethod)) = 0 ifTrue:
						[self printFrameThing: 'object leak in mframe mthd' at: theFP + FoxMethod; cr.
						 ok := false]]
				ifFalse:
					[oop := self iframeMethod: theFP.
					 ((objectMemory isIntegerObject: oop) 
					   or: [(self heapMapAtWord: (self pointerForOop: oop)) = 0]) ifTrue:
						[self printFrameThing: 'object leak in iframe mthd' at: theFP + FoxMethod; cr.
						 ok := false]].
			 (callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
				[theSP := theFP + FoxCallerSavedIP + BytesPerWord.
				 theFP := callerFP].
			 theSP := theFP + FoxCallerSavedIP + BytesPerWord.
			 [theSP <= thePage baseAddress] whileTrue:
				[oop := stackPages longAt: theSP.
				 ((objectMemory isNonIntegerObject: oop) 
				   and: [(self heapMapAtWord: (self pointerForOop: oop)) = 0]) ifTrue:
					[self printFrameThing: 'object leak in frame arg' at: theSP; cr.
					 ok := false].
				 theSP := theSP + BytesPerWord]]].
	^ok