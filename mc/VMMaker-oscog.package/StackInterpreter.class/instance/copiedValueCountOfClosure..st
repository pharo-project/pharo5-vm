internal interpreter access
copiedValueCountOfClosure: closurePointer

	^(objectMemory fetchWordLengthOf: closurePointer) - ClosureFirstCopiedValueIndex