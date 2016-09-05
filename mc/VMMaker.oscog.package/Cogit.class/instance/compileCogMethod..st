compile abstract instructions
compileCogMethod: selector
	<returnTypeC: #'CogMethod *'>
	| numBytecodes numBlocks numCleanBlocks result extra |
	hasYoungReferent := (objectMemory isYoungObject: methodObj)
						  or: [objectMemory isYoung: selector].
	methodOrBlockNumArgs := coInterpreter argumentCountOf: methodObj.
	inBlock := 0.
	postCompileHook := nil.
	maxLitIndex := -1.
	extra := ((primitiveIndex := coInterpreter primitiveIndexOf: methodObj) > 0
			and: [(coInterpreter isQuickPrimitiveIndex: primitiveIndex) not])
				ifTrue: [30]
				ifFalse: [10].
	initialPC := coInterpreter startPCOfMethod: methodObj.
	"initial estimate.  Actual endPC is determined in scanMethod."
	endPC := (coInterpreter isQuickPrimitiveIndex: primitiveIndex)
					ifTrue: [initialPC - 1]
					ifFalse: [objectMemory numBytesOf: methodObj].
	numBytecodes := endPC - initialPC + 1.
	self allocateOpcodes: (numBytecodes + extra) * self estimateOfAbstractOpcodesPerBytecodes
		bytecodes: numBytecodes
		ifFail: [^coInterpreter cCoerceSimple: MethodTooBig to: #'CogMethod *'].
	(numBlocks := self scanMethod) < 0 ifTrue:
		[^coInterpreter cCoerceSimple: numBlocks to: #'CogMethod *'].
	numCleanBlocks := self scanForCleanBlocks.
	self allocateBlockStarts: numBlocks + numCleanBlocks.
	blockCount := 0.
	numCleanBlocks > 0 ifTrue:
		[self addCleanBlockStarts].
	(self maybeAllocAndInitCounters
	 and: [self maybeAllocAndInitIRCs]) ifFalse: "Inaccurate error code, but it'll do.  This will likely never fail."
		[^coInterpreter cCoerceSimple: InsufficientCodeSpace to: #'CogMethod *'].
	
	blockEntryLabel := nil.
	methodLabel dependent: nil.
	(result := self compileEntireMethod) < 0 ifTrue:
		[^coInterpreter cCoerceSimple: result to: #'CogMethod *'].
	^self generateCogMethod: selector