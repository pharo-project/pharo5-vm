compile abstract instructions
methodUsesPrimitiveErrorCode: aMethodObj header: aMethodHeader
	"Answer if aMethodObj contains a primitive and uses the primitive error code."
	<inline: true>
	^(coInterpreter primitiveIndexOfMethod: aMethodObj header: aMethodHeader) > 0
	  and: [(coInterpreter longStoreBytecodeForHeader: aMethodHeader)
			= (objectMemory
				fetchByte: initialPC + (coInterpreter sizeOfCallPrimitiveBytecode: aMethodHeader)
				ofObject: aMethodObj)]