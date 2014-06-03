compiled methods
methodClassOf: methodPointer
	<api>
	^self cppIf: NewspeakVM
		ifTrue:
			[| literal |
			 literal := self literal: (self literalCountOf: methodPointer) - 1 ofMethod: methodPointer.
			 self assert: (objectMemory isForwarded: literal) not.
			 literal = objectMemory nilObject
				ifTrue: [literal]
				ifFalse: [objectMemory fetchPointer: ValueIndex ofObject: literal]]
		ifFalse:
			[| literal |
			 literal := self literal: (self literalCountOf: methodPointer) - 1 ofMethod: methodPointer.
			 self assert: (objectMemory isForwarded: literal) not.
			 objectMemory fetchPointer: ValueIndex ofObject: literal]