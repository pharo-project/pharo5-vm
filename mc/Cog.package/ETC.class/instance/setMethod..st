initialize-release
setMethod: aCompiledMethod
	scanner := InstructionStream new method: aCompiledMethod pc: aCompiledMethod initialPC.
	contextStack := OrderedCollection new.
	currentContext := MethodContext
						sender: nil
						receiver: nil
						method: aCompiledMethod
						arguments: ((1 to: aCompiledMethod numArgs) collect:
										[:i| 'arg', i printString]).
	aCompiledMethod numArgs + 1 to: aCompiledMethod numTemps do:
		[:i| currentContext at: i put: 'tmp', (i - aCompiledMethod numArgs) printString].
	sends := Dictionary new.
	joinOffsets := Dictionary new.
	blockEndStack := OrderedCollection new.
	blockEnd := aCompiledMethod endPC.
	topIsVector := false