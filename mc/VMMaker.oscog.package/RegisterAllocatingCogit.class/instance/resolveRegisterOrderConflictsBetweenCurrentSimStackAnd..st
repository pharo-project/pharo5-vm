bytecode generator support
resolveRegisterOrderConflictsBetweenCurrentSimStackAnd: mergeSimStack
	<var: #mergeSimStack type: #'SimStackEntry *'>
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
	 i.e. rA := current[0]; rB := rD; (rC := rC); (rD := rD).

	 So find any conflicts, and if there are any, swap registers in the simStack to resolve them.
	 The trivial case of a single conflict is resolved by assigning that conflict to TempReg."
	| conflictingRegsMask |
	conflictingRegsMask := self conflictingRegistersBetweenSimStackAnd: mergeSimStack.
	conflictingRegsMask ~= 0 ifTrue:
		[(self isAPowerOfTwo: conflictingRegsMask) "Multiple conflicts mean we have to sort"
			ifFalse: [self swapCurrentRegistersInMask: conflictingRegsMask accordingToRegisterOrderIn: mergeSimStack]
			ifTrue: [self assignToTempRegConflictingRegisterIn: conflictingRegsMask]].