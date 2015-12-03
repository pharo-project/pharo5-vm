compile abstract instructions
compileMethodBody
	"Compile the top-level method body."
	| deltaForPrimErrorCode |
	<inline: true>
	endPC < initialPC ifTrue: [^0]. "quick primitives"
	deltaForPrimErrorCode := self methodUsesPrimitiveErrorCode
									ifTrue: [(coInterpreter sizeOfCallPrimitiveBytecode: methodHeader)
										  + (coInterpreter sizeOfLongStoreTempBytecode: methodHeader)]
									ifFalse: [0].
	^self compileAbstractInstructionsFrom: initialPC + deltaForPrimErrorCode through: endPC