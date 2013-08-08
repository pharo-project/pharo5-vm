compiled methods
methodClassOf: methodPointer

	^self cppIf: NewspeakVM
		ifTrue:
			[ | literal |
			literal := self literal: (self literalCountOf: methodPointer) - 1 ofMethod: methodPointer.
			literal = objectMemory nilObject
				ifTrue: [literal]
				ifFalse: [objectMemory fetchPointer: ValueIndex ofObject: literal]]
		ifFalse:
			[objectMemory fetchPointer: ValueIndex ofObject: (self literal: (self literalCountOf: methodPointer) - 1 ofMethod: methodPointer)]