internal interpreter access
argumentCountOfClosure: closurePointer
	<api> "for Cogit"
	<inline: true>
	^self quickFetchInteger: ClosureNumArgsIndex ofObject: closurePointer