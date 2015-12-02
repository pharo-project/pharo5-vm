compile abstract instructions
checkForQuickPrimitiveAdjustingIntialPCIfErrorCodeUsed
	"Answer if methodObj contains a quick primitive.  In addition, if it has a primitive
	 that uses an error code, update the initialPC to skip this code.  The code to
	 process the error code is generated in compileFrameBuild.  For fixups to work
	 correctly, the initialPC must be updated before scanning for backward branches."

	| methodHeader |
	primitiveIndex = 0 ifTrue:
		[^false].
	methodHeader := objectMemory methodHeaderOf: methodObj.
	(self methodUsesPrimitiveErrorCode: methodHeader) ifTrue:
		[initialPC := initialPC
				+ (coInterpreter sizeOfCallPrimitiveBytecode: methodHeader)
				+ (coInterpreter sizeOfLongStoreTempBytecode: methodHeader)].
	^coInterpreter isQuickPrimitiveIndex: primitiveIndex