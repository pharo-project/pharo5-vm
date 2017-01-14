compile abstract instructions
compileCogFullBlockMethod: numCopied
	<returnTypeC: #'CogMethod *'>
	<option: #SistaV1BytecodeSet>
	| numBytecodes numBlocks numCleanBlocks result |
	hasYoungReferent := (objectMemory isYoungObject: methodObj).
	methodOrBlockNumArgs := coInterpreter argumentCountOf: methodObj.
	inBlock := InFullBlock.
	postCompileHook := nil.
	maxLitIndex := -1.
	self assert: (coInterpreter primitiveIndexOf: methodObj) = 0.
	initialPC := coInterpreter startPCOfMethod: methodObj.
	"initial estimate.  Actual endPC is determined in scanMethod."
	endPC := objectMemory numBytesOf: methodObj.
	numBytecodes := endPC - initialPC + 1.
	primitiveIndex := 0.
	self allocateOpcodes: (numBytecodes + 10) * self estimateOfAbstractOpcodesPerBytecodes
		bytecodes: numBytecodes
		ifFail: [^coInterpreter cCoerceSimple: MethodTooBig to: #'CogMethod *'].
	self flag: #TODO. "currently copiedValue access implies frameful method, this is suboptimal"
	(numBlocks := self scanMethod) < 0 ifTrue:
		[^coInterpreter cCoerceSimple: numBlocks to: #'CogMethod *'].
	self assert: numBlocks = 0. "blocks in full blocks are full blocks, they are not inlined."
	numCleanBlocks := self scanForCleanBlocks.
	self assert: numCleanBlocks = 0. "blocks in full blocks are full blocks, they are not inlined."
	self allocateBlockStarts: numBlocks + numCleanBlocks.
	blockCount := 0.
	numCleanBlocks > 0 ifTrue:
		[self addCleanBlockStarts].
	(self maybeAllocAndInitCounters
	 and: [self maybeAllocAndInitIRCs]) ifFalse: "Inaccurate error code, but it'll do.  This will likely never fail."
		[^coInterpreter cCoerceSimple: InsufficientCodeSpace to: #'CogMethod *'].

	blockEntryLabel := nil.
	methodLabel dependent: nil.
	(result := self compileEntireFullBlockMethod: numCopied) < 0 ifTrue:
		[^coInterpreter cCoerceSimple: result to: #'CogMethod *'].
	^self generateCogFullBlock