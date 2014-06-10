internal interpreter access
copiedValueCountOfClosure: closurePointer
	<api> "for Cogit"
	^(objectMemory fetchWordLengthOf: closurePointer) - ClosureFirstCopiedValueIndex