compile abstract instructions
primitiveGeneratorOrNil
	"If there is a generator for the current primitive then answer it;
	 otherwise answer nil."
	<returnTypeC: #'PrimitiveDescriptor *'>
	| primitiveDescriptor |
	<var: #primitiveDescriptor type: #'PrimitiveDescriptor *'>
	(coInterpreter isQuickPrimitiveIndex: primitiveIndex) ifTrue:
		[primitiveDescriptor := self addressOf: (primitiveGeneratorTable at: 0). "an unused one"
		 primitiveDescriptor primitiveGenerator: (coInterpreter quickPrimitiveGeneratorFor: primitiveIndex).
		 ^primitiveDescriptor].
	(primitiveIndex between: 1 and: MaxCompiledPrimitiveIndex) ifTrue:
		[^self addressOf: (primitiveGeneratorTable at: primitiveIndex)].
	^nil