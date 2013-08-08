compiled methods
methodClassOf: methodPointer
	| literal |
	literal := self literal: (self literalCountOf: methodPointer) - 1 ofMethod: methodPointer.
	^literal = nilObj
		ifTrue: [literal]
		ifFalse: [self fetchPointer: ValueIndex ofObject: literal]