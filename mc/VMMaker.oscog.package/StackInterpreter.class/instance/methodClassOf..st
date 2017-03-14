compiled methods
methodClassOf: methodPointer
	<api>
	"Answer the method class of a method which is the value of an Association in the last literal,
	 or answer nil if there isn't one.
	 Using a read barrier here simplifies the become implementation and costs very little
	 because the class index and ValueIndex of the association almost certainly share a cache line."
	| literal |
	literal := self followLiteral: (objectMemory literalCountOf: methodPointer) - 1 ofMethod: methodPointer.
	^ (literal ~= objectMemory nilObject 
		and: [objectMemory isPointers: literal]) "filters out fullBlock last literal"
			ifTrue: 
				[self assert: (objectMemory numSlotsOf: literal) > ValueIndex.
			 	objectMemory followField: ValueIndex ofObject: literal]
			ifFalse: [objectMemory nilObject]