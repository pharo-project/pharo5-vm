stack bytecodes
storeAndPopReceiverVariableBytecode
	"Note: This code uses 
	storePointerUnchecked:ofObject:withValue: and does the 
	store check explicitely in order to help the translator 
	produce better code."
	| rcvr top |
	rcvr := self receiver.
	top := self internalStackTop.
	self internalPop: 1.
	self
		cCode: "Slang will inline currentBytecode to a constant so this will work in C"
			[self fetchNextBytecode.
			 objectMemory
				storePointerImmutabilityCheck: (currentBytecode bitAnd: 7)
				ofObject: rcvr
				withValue: top]
		inSmalltalk: "But in Smalltalk we must use the currentBytecode's value, not the next. 
			We cant use the following code when generating C code as slang 
			won't inline currentBytecode correctly due to the extra temp."
			[ | instVarIndex |
			 instVarIndex := currentBytecode bitAnd: 7.
			 self fetchNextBytecode.
			 objectMemory
				storePointerImmutabilityCheck: instVarIndex
				ofObject: rcvr
				withValue: top]