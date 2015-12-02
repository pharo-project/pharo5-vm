compile abstract instructions
methodUsesPrimitiveErrorCode
	"Answer if methodObj contains a primitive and uses the primitive error code."
	^(coInterpreter primitiveIndexOfMethod: methodObj header: methodHeader) > 0
	  and: [(coInterpreter longStoreBytecodeForHeader: methodHeader)
			= (objectMemory
				fetchByte: initialPC + (coInterpreter sizeOfCallPrimitiveBytecode: methodHeader)
				ofObject: methodObj)]