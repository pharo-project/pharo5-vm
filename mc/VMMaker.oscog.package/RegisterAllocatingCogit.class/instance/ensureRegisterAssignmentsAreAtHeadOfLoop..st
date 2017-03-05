bytecode generator support
ensureRegisterAssignmentsAreAtHeadOfLoop: target
	"Compiling a loop body will compute a set of live registers.  The backward branch must merge
	 with the head of the loop.  So it is preferrable to make the register assignments at the end of
	 the loop available at the head.  To do this, simply copy the register assignments to the loop
	 head's fixup in the first compilation pass and schedule a second compilation pass.  On the
	 second pass the merge will occur when encountering the fixup for the loop head, using
	 exactly the same code as for a merge at the end of an if."
	| conflictingRegsMask |
	compilationPass > 1 ifTrue:
		["self deny: (self mergeRequiredToTarget: target mergeSimStack)."
		 self assert: (target mergeSimStack isNil or: [self simStack: simStack isIdenticalTo: target mergeSimStack]).
		 ^self].
	(self mergeRequiredToTarget: target mergeSimStack) ifFalse:
		[^self].
	"Schedule a recompile and merge the end-of-loop assignments into the head of the loop,
	 giving priority to the assignments at this point, and preserving any other non-conflicting
	 assignments."
	recompileForLoopRegisterAssignments := true.
	conflictingRegsMask := self conflictingRegistersBetweenSimStackAnd: target mergeSimStack.
	self deny: (self register: FPReg isInMask: conflictingRegsMask).
	0 to: simStackPtr do:
		[:i| | currentEntry targetEntry |
		 currentEntry := self simStack: simStack at: i.
		 targetEntry := self simStack: target mergeSimStack at: i.
		 currentEntry liveRegister ~= NoReg
			ifTrue:
				[targetEntry liveRegister: currentEntry liveRegister]
			ifFalse:
				[(targetEntry registerMask anyMask: conflictingRegsMask) ifTrue:
					[targetEntry liveRegister: NoReg]]].
	optStatus isReceiverResultRegLive ifTrue:
		[target isReceiverResultRegSelf: true]