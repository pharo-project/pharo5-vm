frame access
marriedContext: spouseContext pointsTo: anOop stackDeltaForCurrentFrame: stackDeltaForCurrentFrame
	"This is a helper for primitiveObjectPointsTo so it *does not* check the frameContext field because that is an implicit self-reference not present in the state ."
	| theFP thePage theSP rcvrOffset |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #rcvrOffset type: #'char *'>
	theFP := self frameOfMarriedContext: spouseContext.
	theFP = framePointer
		ifTrue: [theSP := stackPointer + (stackDeltaForCurrentFrame * objectMemory wordSize)]
		ifFalse:
			[thePage := stackPages stackPageFor: theFP.
			theSP := self findSPOf: theFP on: thePage].
	(objectMemory isIntegerObject: anOop)
		ifTrue: "Check stack and instruction pointer fields."
			[(anOop = (objectMemory integerObjectOf: (self stackPointerIndexForFrame: theFP WithSP: theSP))
			or: [anOop = (self externalInstVar: InstructionPointerIndex ofContext: spouseContext)]) ifTrue:
				[^true]]
		ifFalse: "Check method and sender fields, avoiding unnecessarily reifying sender context."
			[anOop = (self frameMethodObject: theFP) ifTrue:
				[^true].
			 (self isBaseFrame: theFP)
				ifTrue: [anOop = (self frameCallerContext: theFP) ifTrue:
							[^true]]
				ifFalse: [((self frameHasContext: (self frameCallerFP: theFP))
						and: [anOop = (self frameContext: (self frameCallerFP: theFP))]) ifTrue:
							[^true]]].
	"Now check receiver, temps and stack contents"
	rcvrOffset := self frameReceiverLocation: theFP.
	 [theSP <= rcvrOffset] whileTrue:
		[anOop = (stackPages longAt: theSP) ifTrue:
			[^true].
		 theSP := theSP + objectMemory wordSize].
	"Finally check stacked receiver (closure field or duplicate of receiver) and arguments"
	theSP := theFP + FoxCallerSavedIP + objectMemory wordSize.
	rcvrOffset := theFP + (self frameStackedReceiverOffset: theFP).
	 [theSP <= rcvrOffset] whileTrue:
		[anOop = (stackPages longAt: theSP) ifTrue:
			[^true].
		 theSP := theSP + objectMemory wordSize].
	^false