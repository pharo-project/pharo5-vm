internal interpreter access
copiedValueCountOfClosure: closurePointer
	<api> "for Cogit"
	^(objectMemory numSlotsOf: closurePointer) - ClosureFirstCopiedValueIndex