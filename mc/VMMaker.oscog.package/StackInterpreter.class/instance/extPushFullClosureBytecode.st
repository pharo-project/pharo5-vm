stack bytecodes
extPushFullClosureBytecode
	"255		11111111	xxxxxxxx	siyyyyyy	
		push Closure Compiled block literal index xxxxxxxx (+ Extend A * 256) 
		numCopied yyyyyy 
		receiverOnStack: s = 1 
		ignoreOuterContext: i = 1
	 The compiler has pushed the values to be copied, if any. The receiver has been pushed on stack before if specified. 
	 Create a Closure with space for the copiedValues and pop numCopied values off the stack into the closure.
	 Sets outerContext, compiledBlock, numArgs and receiver as specified.."
	| compiledBlockLiteralIndex compiledBlock byte numArgs numCopied receiverIsOnStack ignoreContext |
	compiledBlockLiteralIndex := self fetchByte + (extA << 8).
	extA := 0.
	compiledBlock := self literal: compiledBlockLiteralIndex.
	self assert: (objectMemory isOopCompiledMethod: compiledBlock).
	numArgs := self argumentCountOf: compiledBlock.
	byte := self fetchByte.
	numCopied := byte bitAnd: 1<< 6 - 1.
	receiverIsOnStack := byte anyMask: 1 << 7.
	ignoreContext := byte anyMask: 1 << 6.
	self pushFullClosureNumArgs: numArgs copiedValues: numCopied compiledBlock: compiledBlock receiverIsOnStack: receiverIsOnStack ignoreContext: ignoreContext