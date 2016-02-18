control primitives
closureNumArgs: numArgs instructionPointer: initialIP numCopiedValues: numCopied
	| newClosure |
	<inline: true>
	newClosure := self
					instantiateSmallClass: (self splObj: ClassBlockClosure)
					sizeInBytes: (self wordSize * (ClosureFirstCopiedValueIndex + numCopied)) + self baseHeaderSize.
	"Assume: have just allocated a new closure; it must be young. Thus, can use unchecked stores."
	self storePointerUnchecked: ClosureStartPCIndex ofObject: newClosure withValue: (self integerObjectOf: initialIP).
	self storePointerUnchecked: ClosureNumArgsIndex ofObject: newClosure withValue: (self integerObjectOf: numArgs).
	"It is up to the caller to store the outer context and copiedValues."
	^newClosure