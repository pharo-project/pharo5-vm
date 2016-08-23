compile abstract instructions
deltaToSkipPrimAndErrorStoreIn: aMethodObj header: aMethodHeader
	"Answer the number of bytecodes to skip to get to the first bytecode
	 past the primitive call and any store of the error code."
	^(self methodUsesPrimitiveErrorCode: aMethodObj header: aMethodHeader)
		ifTrue: [(coInterpreter sizeOfCallPrimitiveBytecode: aMethodHeader)
			  + (coInterpreter sizeOfLongStoreTempBytecode: aMethodHeader)]
		ifFalse: [0]