bytecode generators
genExtPushFullClosureBytecode
	"Full Block creation compilation. The block's actual code will be compiled separatedly."
	"*	255		11111111	xxxxxxxx	siyyyyyy	push Closure Compiled block literal index xxxxxxxx (+ Extend A * 256) numCopied yyyyyy receiverOnStack: s = 1 ignoreOuterContext: i = 1"
	| numCopied ignoreContext receiverIsOnStack compiledBlock |
	self assert: needsFrame.
	compiledBlock := self getLiteral: byte1 + (extA << 8).
	extA := 0.
	numCopied := byte2 bitAnd: 1<< 6 - 1.
	receiverIsOnStack := byte2 anyMask: 1 << 7.
	ignoreContext := byte2 anyMask: 1 << 6.
	objectRepresentation
		genCreateFullClosure: compiledBlock
		numArgs: (coInterpreter argumentCountOf: compiledBlock)
		numCopied: numCopied
		ignoreContext: ignoreContext
		contextNumArgs: methodOrBlockNumArgs
		large: (coInterpreter methodNeedsLargeContext: methodObj)
		inBlock: inBlock.
	"Closure in ReceiverResultReg"
	1 to: numCopied do:
		[:i|
		self
			PopR: TempReg;
			MoveR: TempReg
				Mw: numCopied - i + FullClosureFirstCopiedValueIndex * objectMemory bytesPerOop + objectMemory baseHeaderSize
					r: ReceiverResultReg].
	receiverIsOnStack
		ifTrue: [self PopR: TempReg]
		ifFalse: [ self MoveMw: FoxMFReceiver r: FPReg R: TempReg].
	self
		MoveR: TempReg
		Mw: FullClosureReceiverIndex * objectMemory bytesPerOop + objectMemory baseHeaderSize
		r: ReceiverResultReg.
	self PushR: ReceiverResultReg.
	^0