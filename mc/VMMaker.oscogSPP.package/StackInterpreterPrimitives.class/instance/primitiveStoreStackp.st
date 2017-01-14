object access primitives
primitiveStoreStackp
	"Atomic store into context stackPointer. 
	Also ensures that any newly accessible cells are initialized to nil "
	| ctxt newStackp theFP thePage onCurrentPage stackp |
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	ctxt := self stackValue: 1.
	newStackp := self stackIntegerValue: 0.
	(self successful
	 and: [newStackp between: 0 and: (objectMemory numSlotsOf: ctxt) - CtxtTempFrameStart]) ifFalse:
		[^self primitiveFail].
	self externalWriteBackHeadFramePointers.
	(self isStillMarriedContext: ctxt) ifTrue:
		[theFP := self frameOfMarriedContext: ctxt.
		 thePage := stackPages stackPageFor: theFP.
		 ((onCurrentPage := thePage = stackPage)
		 and: [theFP = framePointer]) ifTrue:
			[^self primitiveFail]. "Probably easy to do this right here right now (just move stackPointer).  But fail for now."
		 self externalDivorceFrame: theFP andContext: ctxt.
		 onCurrentPage
			ifTrue:
				[framePointer := stackPage headFP.
				 stackPointer := stackPage headSP]
			ifFalse:
				[self assert: stackPage = (stackPages stackPageFor: framePointer).
				 stackPages markStackPageMostRecentlyUsed: stackPage]].
	stackp := self fetchStackPointerOf: ctxt.
	"Nil any newly accessible cells"
	stackp + 1 to: newStackp do:
		[:i | objectMemory storePointerUnchecked: i + CtxtTempFrameStart - 1 ofObject: ctxt withValue: objectMemory nilObject].
	self storeStackPointerValue: newStackp inContext: ctxt.
	self ensureContextIsExecutionSafeAfterAssignToStackPointer: ctxt.
	self pop: 1