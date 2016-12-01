bytecode generator support
mergeCurrentSimStackWith: mergeSimStack
	<var: #mergeSimStack type: #'SimStackEntry *'>
	"At a merge point the cogit expects the stack to be in the same state as mergeSimStack.
	 mergeSimStack is the state as of some jump forward to this point.  So make simStack agree
	 with mergeSimStack (it is, um, problematic to plant code at the jump).
	 Values may have to be assigned to registers.  Registers may have to be swapped.
	 The state of optStatus must agree."
	| currentRegsMask mergeRegsMask potentialConflictRegMask conflictingRegsMask
	   currentRegMask mergeRegMask currentEntry targetEntry |
	<var: #currentEntry type: #'SimStackEntry *'>
	<var: #targetEntry type: #'SimStackEntry *'>
	mergeSimStack ifNil: [^self].
	currentRegsMask := mergeRegsMask := potentialConflictRegMask := 0.
	0 to: simStackPtr do:
		[:i|
		 currentRegMask := (currentEntry := self simStack: simStack at: i) registerMaskOrNone.
		 mergeRegMask := (targetEntry := self simStack: mergeSimStack at: i) registerMaskOrNone.
		 currentRegMask = mergeRegMask
			ifTrue:
				[self assert: (currentEntry isSameEntryAs: targetEntry)]
			ifFalse: "This checks for a potential conflict..."
				[(currentRegMask ~= 0 or: [mergeRegMask ~= 0]) ifTrue:
					[potentialConflictRegMask := potentialConflictRegMask bitOr: (currentRegMask bitOr: mergeRegMask)]].
		 currentRegsMask := currentRegsMask bitOr: currentRegMask.
		 mergeRegsMask := mergeRegsMask bitOr: mergeRegMask].
	conflictingRegsMask := potentialConflictRegMask bitAnd: (currentRegsMask bitAnd: mergeRegsMask).
	"One simple algorithm is to spill everything if there are any conflicts and then pop back.
	 But this is terrible :-(  Can we do better? Yes... Consider the following two simStacks
		target:		0: | rA | __ | rB | rC | rD | <- sp
		current:	0: | __ | __ | rD | rA | rC | <- sp
	 If we were to assign in a naive order, 0 through sp rA would be overwritten before its value in current[3] is written to rC,
	 and rC would be overwritten before its value in current[4] is written to rD.  But if we swap the registers in current so that
	 they respect the reverse ordering in target we can assign directly:
		swap current[3] & current[4]
					0: | __ | __ | rD | rC | rA | <- sp
	now do the assignment in the order target[0] := current[0],  target[1] := current[1], ...  target[4] := current[4],
	i.e. rA := current[0]; rB := rD; (rC := rC); (rD := rD)."
	conflictingRegsMask ~= 0 ifTrue:
		[(self isAPowerOfTwo: conflictingRegsMask) "Multiple conflicts mean we have to sort"
			ifFalse: [self swapCurrentRegistersInMask: currentRegsMask accordingToRegisterOrderIn: mergeSimStack]
			ifTrue: [self assignToTempRegConflictingRegisterIn: conflictingRegsMask]].
	self assert: (self conflcitsResolvedBetweenSimStackAnd: mergeSimStack).
	simStackPtr to: 0 by: -1 do:
		[:i|
		 currentRegMask := (currentEntry := self simStack: simStack at: i) registerMaskOrNone.
		 mergeRegMask := (targetEntry := self simStack: mergeSimStack at: i) registerMaskOrNone.
		 mergeRegMask ~= 0
			ifTrue:
				[currentRegMask ~= mergeRegMask
					ifTrue:
						[currentEntry reconcilePoppingWith: targetEntry.
						 simStack
							at: i
							put: (self
									cCode: [mergeSimStack at: i]
									inSmalltalk: [(mergeSimStack at: i) copy])]
					ifFalse:
						[self assert: (currentEntry isSameEntryAs: targetEntry)]]
			ifFalse:
				[self assert: (currentRegMask = 0 or: [currentEntry spilled]).
				 self assert: (currentEntry isSameEntryAs: targetEntry) "really? here to check"]]