control primitives
primitiveBlockCopy

	| context methodContext contextSize newContext initialIP |
	context := self stackValue: 1.
	(self isIntegerObject: (self fetchPointer: MethodIndex ofObject: context))
		ifTrue: ["context is a block; get the context of its enclosing method"
				methodContext := self fetchPointer: HomeIndex ofObject: context]
		ifFalse: [methodContext := context].
	contextSize := self sizeBitsOf: methodContext.  "in bytes, including header"
	context := nil.  "context is no longer needed and is not preserved across allocation"

	"remap methodContext in case GC happens during allocation"
	self pushRemappableOop: methodContext.
	newContext := self instantiateContext: (self splObj: ClassBlockContext) sizeInBytes: contextSize.
	methodContext := self popRemappableOop.

	initialIP := self integerObjectOf: (instructionPointer+1+3) - (method+self baseHeaderSize).
	"Was instructionPointer + 3, but now it's greater by 1 due to preIncrement"

	"Assume: have just allocated a new context; it must be young.
	 Thus, can use uncheck stores. See the comment in fetchContextRegisters."

	self storePointerUnchecked: InitialIPIndex ofObject: newContext withValue: initialIP.
	self storePointerUnchecked: InstructionPointerIndex ofObject: newContext withValue: initialIP.
	self storeStackPointerValue: 0 inContext: newContext.
	self storePointerUnchecked: BlockArgumentCountIndex ofObject: newContext withValue: (self stackValue: 0).
	self storePointerUnchecked: HomeIndex ofObject: newContext withValue: methodContext.
	self storePointerUnchecked: SenderIndex ofObject: newContext withValue: nilObj.

	self pop: 2 thenPush: newContext.