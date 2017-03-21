frame access
externalInstVar: index ofContext: maybeMarriedContext put: anOop
	| theFP thePage onCurrentPage |
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	self assert: (objectMemory isContext: maybeMarriedContext).
	self externalWriteBackHeadFramePointers.
	"Assign the field of a married context."
	self deny: (objectMemory isObjImmutable: maybeMarriedContext).
	(self isStillMarriedContext: maybeMarriedContext) ifFalse:
		[objectMemory storePointer: index ofObject: maybeMarriedContext withValue: anOop.
		 index = StackPointerIndex ifTrue:
			[self ensureContextIsExecutionSafeAfterAssignToStackPointer: maybeMarriedContext].
		 ^nil].
	theFP := self frameOfMarriedContext: maybeMarriedContext.
	thePage := stackPages stackPageFor: theFP.
	self assert: stackPage = stackPages mostRecentlyUsedPage.
	onCurrentPage := thePage = stackPage.
	index = SenderIndex
		ifTrue:
			[self storeSenderOfFrame: theFP withValue: anOop]
		ifFalse:
			[self externalDivorceFrame: theFP andContext: maybeMarriedContext.
			 (self is: index methodAssignmentToContextWithMachineCodePC: maybeMarriedContext) ifTrue:
				[self ensureContextHasBytecodePC: maybeMarriedContext].
			 objectMemory storePointer: index ofObject: maybeMarriedContext withValue: anOop.
			 index = StackPointerIndex ifTrue:
				[self ensureContextIsExecutionSafeAfterAssignToStackPointer: maybeMarriedContext]].
	onCurrentPage
		ifTrue:
			[self setStackPointersFromPage: stackPage]
		ifFalse:
			[stackPages markStackPageMostRecentlyUsed: stackPage].
	stackPages assert: stackPage = stackPages mostRecentlyUsedPage.
	stackPages assert: stackPages pageListIsWellFormed.
	stackPages assert: self validStackPageBaseFrames