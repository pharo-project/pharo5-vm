bytecode generator support
mergeCurrentSimStackWith: fixup forwards: forwards
	"At a merge point the cogit expects the stack to be in the same state as mergeSimStack.
	 mergeSimStack is the state as of some jump forward or backward to this point.  So make
	 simStack agree with mergeSimStack (it is, um, problematic to plant code at the jump).
	 Values may have to be assigned to registers.  Registers may have to be swapped.
	 The state of optStatus must agree.
	 Generate code to merge the current simStack with that of the target fixup,
	 the goal being to keep as many registers live as possible.  If the merge is forwards
	 registers can be deassigned (since registers are always written to temp vars).
	 But if backwards, nothing can be deassigned, and the state /must/ reflect the target."
	"self printSimStack; printSimStack: fixup mergeSimStack"
	"abstractOpcodes object copyFrom: startIndex to: opcodeIndex"
	<var: #fixup type: #'BytecodeFixup *'>
	| startIndex mergeSimStack |
	<var: #mergeSimStack type: #'SimStackEntry *'>
	<var: #targetEntry type: #'SimStackEntry *'>
	<var: #currentEntry type: #'SimStackEntry *'>
	(mergeSimStack := fixup mergeSimStack) ifNil: [^self].
	startIndex := opcodeIndex. "for debugging"
	"Assignments amongst the registers must be made in order to avoid overwriting.
	 If necessary exchange registers amongst simStack's entries to resolve any conflicts."
	self reconcileRegistersInTempVarsInCurrentSimStackWithThoseIn: mergeSimStack.
	(self asserta: (self conflictsResolvedBetweenSimStackAnd: mergeSimStack)) ifFalse:
		[Notification new tag: #failedMerge; signal].
	(self pushForMergeWith: mergeSimStack)
		ifTrue:
			[methodOrBlockNumTemps to: simStackPtr do:
				[:i| self mergePushingWithEntryInTargetSimStack: mergeSimStack at: i]]
		ifFalse:
			[simStackPtr to: methodOrBlockNumTemps by: -1 do:
				[:i| self mergePoppingWithEntryInTargetSimStack: mergeSimStack at: i]].
	"Still haven't handled simSpillBase."
	self assert: (simSpillBase > simStackPtr
				or: [simSpillBase < (methodOrBlockNumTemps max: 1)
				or: [(self simStack: mergeSimStack at: simSpillBase - 1) spilled]]).
	fixup isReceiverResultRegSelf ifTrue:
		[optStatus isReceiverResultRegLive ifFalse:
			[self putSelfInReceiverResultReg]]