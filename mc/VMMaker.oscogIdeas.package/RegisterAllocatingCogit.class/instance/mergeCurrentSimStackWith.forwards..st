bytecode generator support
mergeCurrentSimStackWith: fixup forwards: forwards
	"At a merge point the cogit expects the stack to be in the same state as mergeSimStack.
	 mergeSimStack is the state as of some jump forward or backward to this point.  So make simStack agree
	 with mergeSimStack (it is, um, problematic to plant code at the jump).
	 Values may have to be assigned to registers.  Registers may have to be swapped.
	 The state of optStatus must agree.
	 Generate code to merge the current simStack with that of the target fixup,
	 the goal being to keep as many registers live as possible.  If the merge is forwards
	 registers can be deassigned (since registers are always written to temp vars).
	 But if backwards, nothing can be deassigned, and the state /must/ reflect the target."
	"self printSimStack; printSimStack: fixup mergeSimStack"
	"abstractOpcodes object copyFrom: startIndex to: opcodeIndex"
	<var: #fixup type: #'BytecodeFixup *'>
	| startIndex mergeSimStack currentEntry targetEntry writtenToRegisters |
	<var: #mergeSimStack type: #'SimStackEntry *'>
	<var: #targetEntry type: #'SimStackEntry *'>
	<var: #currentEntry type: #'SimStackEntry *'>
	(mergeSimStack := fixup mergeSimStack) ifNil: [^self].
	startIndex := opcodeIndex. "for debugging"
	"Assignments amongst the registers must be made in order to avoid overwriting.
	 If necessary exchange registers amongst simStack's entries to resolve any conflicts."
	self resolveRegisterOrderConflictsBetweenCurrentSimStackAnd: mergeSimStack.
	(self asserta: (self conflictsResolvedBetweenSimStackAnd: mergeSimStack)) ifFalse:
		[Notification new tag: #failedMerge; signal].
	writtenToRegisters := 0.
	(self pushForMergeWith: mergeSimStack)
		ifTrue:
			[methodOrBlockNumArgs to: simStackPtr do:
				[:i|
				 currentEntry := self simStack: simStack at: i.
				 targetEntry := self simStack: mergeSimStack at: i.
				 writtenToRegisters := writtenToRegisters bitOr: targetEntry registerMask.
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
			[simStackPtr to: methodOrBlockNumArgs by: -1 do:
				[:i|
				 currentEntry := self simStack: simStack at: i.
				 targetEntry := self simStack: mergeSimStack at: i.
				 writtenToRegisters := writtenToRegisters bitOr: targetEntry registerMask.
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
	methodOrBlockNumArgs - 1 to: 0 by: -1 do:
		[:i|
		 targetEntry := self simStack: mergeSimStack at: i.
		 (targetEntry registerMask noMask: writtenToRegisters) ifTrue:
			[currentEntry := self simStack: simStack at: i.
			 writtenToRegisters := writtenToRegisters bitOr: targetEntry registerMask.
			 (currentEntry reconcileForwardsWith: targetEntry) ifTrue:
				[self assert: i >= methodOrBlockNumArgs.
				 self deassignRegisterForTempVar: targetEntry in: mergeSimStack]]].
	optStatus isReceiverResultRegLive ifFalse:
		[forwards
			ifTrue: "a.k.a. fixup isReceiverResultRegSelf: (fixup isReceiverResultRegSelf and: [optStatus isReceiverResultRegLive])"
				[fixup isReceiverResultRegSelf: false]
			ifFalse:
				[fixup isReceiverResultRegSelf ifTrue:
					[self putSelfInReceiverResultReg]]]