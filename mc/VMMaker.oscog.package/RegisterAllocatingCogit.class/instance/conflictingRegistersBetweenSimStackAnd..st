bytecode generator support
conflictingRegistersBetweenSimStackAnd: mergeSimStack
	<var: #mergeSimStack type: #'SimStackEntry *'>
	| currentRegsMask mergeRegsMask potentialConflictRegMask |
	<var: #currentEntry type: #'SimStackEntry *'>
	<var: #targetEntry type: #'SimStackEntry *'>
	currentRegsMask := mergeRegsMask := potentialConflictRegMask := 0.
	0 to: simStackPtr do:
		[:i| | currentEntry targetEntry currentRegMask mergeRegMask |
		 currentRegMask := (currentEntry := self simStack: simStack at: i) registerMaskOrNone.
		 mergeRegMask := (targetEntry := self simStack: mergeSimStack at: i) registerMaskOrNone.
		 (currentRegMask ~= mergeRegMask
		  and: [currentRegMask ~= 0 or: [mergeRegMask ~= 0]]) ifTrue:
			[potentialConflictRegMask := potentialConflictRegMask bitOr: (currentRegMask bitOr: mergeRegMask)].
		 currentRegsMask := currentRegsMask bitOr: currentRegMask.
		 mergeRegsMask := mergeRegsMask bitOr: mergeRegMask].
	^potentialConflictRegMask bitAnd: (currentRegsMask bitAnd: mergeRegsMask)