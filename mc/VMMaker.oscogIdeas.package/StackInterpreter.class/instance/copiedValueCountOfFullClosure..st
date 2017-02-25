internal interpreter access
copiedValueCountOfFullClosure: closurePointer
	<api> "for Cogit"
	^(objectMemory numSlotsOf: closurePointer) - FullClosureFirstCopiedValueIndex