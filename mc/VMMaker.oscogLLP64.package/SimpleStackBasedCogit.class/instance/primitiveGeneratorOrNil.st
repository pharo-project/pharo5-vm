primitive generators
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
		[self cCode: [] inSmalltalk: "for debugging, allow excluding specific primitives"
			[self class initializationOptions at: #DoNotJIT ifPresent:
				[:excluded|
				((excluded includes: primitiveIndex)
				 and: [(primitiveGeneratorTable at: primitiveIndex) primitiveGenerator notNil]) ifTrue:
					[coInterpreter transcript nextPutAll: 'EXCLUDING primitive #'; print: primitiveIndex; space; nextPutAll: (primitiveGeneratorTable at: primitiveIndex) primitiveGenerator; cr; flush.
				 ^nil]]].
		 ^self addressOf: (primitiveGeneratorTable at: primitiveIndex)].
	^nil