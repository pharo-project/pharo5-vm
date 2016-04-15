internal interpreter access
isVanillaBlockClosure: aClosure
	"Answer if aClosure is a vanilla BlockClosure as in the first Cog release, BlockClosure laid out as 
	 'outerContext, startpc, numArgs.  FullBlockClosure is laid out as  outerContext, method, numArgs, receiver.
	 So either answer true if we're not supporting FullBlockClosure, or test the startpc/method field."
	<inline: true>
	^SistaV1BytecodeSet
		ifTrue: [objectMemory isIntegerObject: (objectMemory fetchPointer: ClosureStartPCIndex ofObject: aClosure)]
		ifFalse: [true]