compiled methods
methodClassOf: methodPointer
	<api>
	"Using a read barrier here simplifies the become implementation and costs very little
	 because the class index and ValueIndex of the association almost certainly share a cache line."
	^self cppIf: NewspeakVM
		ifTrue:
			[| literal |
			 literal := self followLiteral: (self literalCountOf: methodPointer) - 1 ofMethod: methodPointer.
			 literal = objectMemory nilObject
				ifTrue: [literal]
				ifFalse: [objectMemory followField: ValueIndex ofObject: literal]]
		ifFalse:
			[| literal |
			 literal := self followLiteral: (self literalCountOf: methodPointer) - 1 ofMethod: methodPointer.
			 objectMemory followField: ValueIndex ofObject: literal]