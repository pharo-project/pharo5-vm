message sending
getErrorObjectFromPrimFailCode
	"Answer the errorCode object to supply to a failing primitive method that accepts one.
	 If there is a primitive error table and the primFailCode is a valid index there-in answer
	 the coprresponding entry in the table, otherwise simply answer the code as an integer."
	| table |
	primFailCode > 0 ifTrue:
		[table := objectMemory splObj: PrimErrTableIndex.
		 primFailCode <= (objectMemory numSlotsOf: table) ifTrue:
			[^objectMemory fetchPointer: primFailCode - 1 ofObject: table]].
	^objectMemory integerObjectOf: primFailCode