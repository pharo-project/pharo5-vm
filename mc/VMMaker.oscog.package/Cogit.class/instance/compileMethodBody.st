compile abstract instructions
compileMethodBody
	"Compile the top-level method body."
	| deltaForPrimErrorCode |
	<inline: true>
	endPC < initialPC ifTrue: [^0]. "quick primitives"
	deltaForPrimErrorCode := self methodUsesPrimitiveErrorCode
									ifTrue: 
										[ self cppIf: IMMUTABILITY ifTrue: 
											[ self Nop. "to avoid conflict with interrrupt check mapping".
											self annotateBytecode: self Label ].
										(coInterpreter sizeOfCallPrimitiveBytecode: methodHeader)
										  + (coInterpreter sizeOfLongStoreTempBytecode: methodHeader)]
									ifFalse: [0].
	^self compileAbstractInstructionsFrom: initialPC + deltaForPrimErrorCode through: endPC