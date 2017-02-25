bytecode generator support
swapCurrentRegistersInMask: conflictingRegsMask accordingToRegisterOrderIn: mergeSimStack
	<var: #mergeSimStack type: #'SimStackEntry *'>
	"Swap liveRegisters in simStack entries according to their order in mergeSimStack so as to avoid
	 overwriting live registers when merging simStack into mergeSimStack.  Consider the following two simStacks
		target:		0: | rA | __ | rB | rC | rD | <- sp
		current:	0: | __ | __ | rD | rA | rC | <- sp
	 If we were to assign in a naive order, 0 through sp rA would be overwritten before its value in current[3] is written to rC,
	 and rC would be overwritten before its value in current[4] is written to rD.  But if we swap the registers in current so that
	 they respect the reverse ordering in target we can assign directly:
		swap current[3] & current[4]
					0: | __ | __ | rD | rC | rA | <- sp
	 now do the assignment in the order target[0] := current[0],  target[1] := current[1], ...  target[4] := current[4],
	 i.e. rA := current[0]; rB := rD; (rC := rC); (rD := rD).

	 See https://hal.inria.fr/inria-00435844/file/article-hal.pdf
		Florent Bouchez, Quentin Colombet, Alain Darte, Christophe Guillon, Fabrice Rastello.
		Parallel Copy Motion. SCOPES, ACM, 2010, pp.0. <inria-00435844>

	 So find any conflicts, and if there are any, swap registers in the simStack to resolve them."

	"self printSimStack; printSimStack: mergeSimStack"

	"Some processors have a SwapRR but not all.  Write one-size-fits-all code that moves things through TempReg."
	| order n visitedMask ssEntry regA regB |
	<var: 'order' declareC: 'sqInt order[8*BytesPerWord]'>
	<var: 'ssEntry' type: #'SimStackEntry *'>
	self cCode: [self me: order ms: 0 et: (self sizeof: order)]
		inSmalltalk: [order := CArrayAccessor on: (Array new: 8*BytesPerWord withAll: 0)].
	n := 0.
	visitedMask := conflictingRegsMask.
	0 to: methodOrBlockNumTemps - 1 do:
		[:i|
		 ssEntry := self simStack: mergeSimStack at: i.
		(ssEntry registerMaskOrNone anyMask: visitedMask) ifTrue:
			[order at: ssEntry registerOrNone put: (n := n + 1).
			 visitedMask := visitedMask - ssEntry registerMaskOrNone]].
	self assert: n >= 1.
	n <= 2 ifTrue: "simple case; here to show me what I have to do in addition to the sort"
		[regA := conflictingRegsMask highBit - 1.
		 regB := (conflictingRegsMask - (1 << regA)) highBit - 1.
		 self SwapR: regA R: regB Scratch: TempReg.
		 0 to: simStackPtr do:
			[:i|
			 ssEntry := self simStack: simStack at: i.
			 (ssEntry registerMaskOrNone anyMask: conflictingRegsMask) ifTrue:
				[| reg |
				 reg := ssEntry registerOrNone = regA ifTrue: [regB] ifFalse: [regA].
				 ssEntry type = SSRegister ifTrue:
					[ssEntry register: reg].
				 ssEntry liveRegister: reg]].
		 ^self].

	self halt