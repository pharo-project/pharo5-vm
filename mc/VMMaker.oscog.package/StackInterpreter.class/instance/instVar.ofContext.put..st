frame access
instVar: index ofContext: aMarriedContext put: anOop
	| theFP |
	"Assign the field of a married context.  The important case to optimize is
	 assigning the sender.  We could also consider optimizing assigning the IP but
	 typically that is followed by an assignment to the stack pointer and we can't
	 efficiently assign the stack pointer because it involves moving frames around."
	<inline: true>
	self assert: (self isMarriedOrWidowedContext: aMarriedContext).
	self deny: (objectMemory isObjImmutable: aMarriedContext).
	self writeBackHeadFramePointers.
	(self isStillMarriedContext: aMarriedContext) ifFalse:
		[objectMemory storePointer: index ofObject: aMarriedContext withValue: anOop.
		 index = StackPointerIndex ifTrue:
			[self ensureContextIsExecutionSafeAfterAssignToStackPointer: aMarriedContext].
		 ^nil].
	theFP := self frameOfMarriedContext: aMarriedContext.
	index == SenderIndex ifTrue:
		[| thePage onCurrentPage |
		 thePage := stackPages stackPageFor: theFP.
		 self assert: stackPage = stackPages mostRecentlyUsedPage.
		 onCurrentPage := thePage = stackPage.
		 self storeSenderOfFrame: theFP withValue: anOop.
		 onCurrentPage
			ifTrue:
				[localFP := stackPage headFP.
				 localSP := stackPage headSP]
			ifFalse:
				[stackPages markStackPageMostRecentlyUsed: stackPage].
		 ^nil].
	self externalizeIPandSP.
	self externalDivorceFrame: theFP andContext: aMarriedContext.
	objectMemory storePointer: index ofObject: aMarriedContext withValue: anOop.
	index = StackPointerIndex ifTrue:
		[self ensureContextIsExecutionSafeAfterAssignToStackPointer: aMarriedContext].
	self internalizeIPandSP.
	"Assigning various fields can force a divorce which can change the stackPage."
	stackPages markStackPageMostRecentlyUsed: stackPage.
	self assertValidExecutionPointe: localIP asUnsignedInteger r: localFP s: localSP imbar: true line: #'__LINE__'