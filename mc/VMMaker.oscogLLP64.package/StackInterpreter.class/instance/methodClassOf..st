compiled methods
methodClassOf: methodPointer
	<api>
	"Using a read barrier here simplifies the become implementation and costs very little
	 because the class index and ValueIndex of the association almost certainly share a cache line."
	| literal |
	literal := self followLiteral: (objectMemory literalCountOf: methodPointer) - 1 ofMethod: methodPointer.
	NewspeakVM
		ifTrue:
			[literal ~= objectMemory nilObject ifTrue:
				[literal := objectMemory followField: ValueIndex ofObject: literal]]
		ifFalse:
			[self assert: ((objectMemory isPointers: literal) and: [(objectMemory numSlotsOf: literal) > ValueIndex]).
			 literal := objectMemory followField: ValueIndex ofObject: literal].
	^literal