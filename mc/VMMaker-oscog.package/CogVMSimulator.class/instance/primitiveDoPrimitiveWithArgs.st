debugging traps
primitiveDoPrimitiveWithArgs
	| primIndex |
	primIndex := objectMemory integerValueOf: (self stackValue: 1).
	NewspeakVM ifFalse:
		[transcript nextPutAll: 'DO PRIMITIVE: '; print: (self functionPointerFor: primIndex inClass: nil); cr; flush].
	primIndex = 76 ifTrue:
		[self halt].
	^super primitiveDoPrimitiveWithArgs