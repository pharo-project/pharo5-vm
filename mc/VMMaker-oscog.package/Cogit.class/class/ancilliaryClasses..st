translation
ancilliaryClasses: options
	ProcessorClass ifNil: [thisContext methodClass theNonMetaClass initialize].
	^{	CogMethodZone.
		CogAbstractInstruction.
		ProcessorClass basicNew abstractInstructionCompilerClass.
		CogBlockStart.
		CogBytecodeDescriptor.
		CogBytecodeFixup.
		CogInstructionAnnotation.
		CogPrimitiveDescriptor.
		CogBlockMethod.
		CogMethod },
	((options at: #NewspeakVM ifAbsent: [false])
		ifTrue: [{NewspeakCogMethod}]
		ifFalse: [#()])