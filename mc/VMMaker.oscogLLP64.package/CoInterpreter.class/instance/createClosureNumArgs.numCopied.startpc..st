trampolines
createClosureNumArgs: numArgs numCopied: numCopied startpc: initialIP
	<api>
	<option: #SqueakV3ObjectMemory>
	| context newClosure |
	self assert: (self isMachineCodeFrame: framePointer).
	"Do *not* include the return pc or copied values in the stack contents;
	 hence + ((1 + numCopied) * BytesPerWord)"
	context := self ensureFrameIsMarried: framePointer
					SP: stackPointer + ((1 + numCopied) * objectMemory wordSize).
	newClosure := self
					closureIn: context
					numArgs: numArgs
					instructionPointer: initialIP
					numCopiedValues: numCopied.
	cogit recordSendTrace ifTrue:
		[self recordTrace: TraceBlockCreation thing: newClosure source: TraceIsFromMachineCode].
	numCopied > 0 ifTrue:
		["N.B. the expression ((numCopied - i) * BytesPerWord)) skips the return address"
		 0 to: numCopied - 1 do:
			[:i|
			"Assume: have just allocated a new BlockClosure; it must be young.
			 Thus, can use unchecked stores."
			 objectMemory storePointerUnchecked: i + ClosureFirstCopiedValueIndex
				ofObject: newClosure
				withValue: (stackPages longAt: stackPointer + ((numCopied - i) * objectMemory wordSize))]].
	"Assume caller will pop stack"
	^newClosure