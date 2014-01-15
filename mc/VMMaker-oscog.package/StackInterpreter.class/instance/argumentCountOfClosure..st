internal interpreter access
argumentCountOfClosure: closurePointer

	^self quickFetchInteger: ClosureNumArgsIndex ofObject: closurePointer