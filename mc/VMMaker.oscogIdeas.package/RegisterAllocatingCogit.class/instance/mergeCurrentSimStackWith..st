bytecode generator support
mergeCurrentSimStackWith: fixup
	<var: #fixup type: #'BytecodeFixup *'>
	| mergeSimStack currentEntry targetEntry |
	<var: #mergeSimStack type: #'SimStackEntry *'>
	"At a merge point the cogit expects the stack to be in the same state as mergeSimStack.
	 mergeSimStack is the state as of some jump forward to this point.  So make simStack agree
	 with mergeSimStack (it is, um, problematic to plant code at the jump).
	 Values may have to be assigned to registers.  Registers may have to be swapped.
	 The state of optStatus must agree."
	<var: #targetEntry type: #'SimStackEntry *'>
	<var: #currentEntry type: #'SimStackEntry *'>
	(mergeSimStack := fixup mergeSimStack) ifNil: [^self].
	"Assignments amongst the registers must be made in order to avoid overwriting.
	 If necessary exchange registers amongst simStack's entries to resolve any conflicts."
	self resolveRegisterOrderConflictsBetweenCurrentSimStackAnd: mergeSimStack.
	self assert: (self conflictsResolvedBetweenSimStackAnd: mergeSimStack).
	(self pushForMergeWith: mergeSimStack)
		ifTrue:
			[0 to: simStackPtr do:
				[:i|
				 currentEntry := self simStack: simStack at: i.
				 targetEntry := self simStack: mergeSimStack at: i.
				 (currentEntry reconcileForwardsWith: targetEntry) ifTrue:
					[self assert: i >= methodOrBlockNumArgs.
					 self deassignRegisterForTempVar: targetEntry in: mergeSimStack].
				 "Note, we could update the simStack and spillBase here but that is done in restoreSimStackAtMergePoint:
				 spilled ifFalse:
					[simSpillBase := i - 1].
				 simStack
					at: i
					put: (self
							cCode: [mergeSimStack at: i]
							inSmalltalk: [(mergeSimStack at: i) copy])"]]
		ifFalse:
			[simStackPtr to: 0 by: -1 do:
				[:i|
				 currentEntry := self simStack: simStack at: i.
				 targetEntry := self simStack: mergeSimStack at: i.
				 (currentEntry reconcileForwardsWith: targetEntry) ifTrue:
					[self assert: i >= methodOrBlockNumArgs.
					 self deassignRegisterForTempVar: targetEntry in: mergeSimStack].
				 "Note, we could update the simStack and spillBase here but that is done in restoreSimStackAtMergePoint:
				 spilled ifFalse:
					[simSpillBase := i - 1].
				 simStack
					at: i
					put: (self
							cCode: [mergeSimStack at: i]
							inSmalltalk: [(mergeSimStack at: i) copy])"]].

	"a.k.a. fixup isReceiverResultRegSelf: (fixup isReceiverResultRegSelf and: [optStatus isReceiverResultRegLive])"
	optStatus isReceiverResultRegLive ifFalse:
		[fixup isReceiverResultRegSelf: false]