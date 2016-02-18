compile abstract instructions
compileMethodBody
	"Compile the top-level method body."
	<inline: true>
	endPC < initialPC ifTrue: [^0]. "quick primitives"
	"When compiling, skip any initial CallPrimitive and optional StorePrimErrCode bytecodes.
	 These are dealt with in compileFrameBuild."
	^self compileAbstractInstructionsFrom: initialPC
										+ (self deltaToSkipPrimAndErrorStoreIn: methodObj
												header: methodHeader)
		through: endPC