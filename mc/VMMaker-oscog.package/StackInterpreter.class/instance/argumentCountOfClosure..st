internal interpreter access
argumentCountOfClosure: closurePointer
	<api> "for Cogit"
	^self quickFetchInteger: ClosureNumArgsIndex ofObject: closurePointer