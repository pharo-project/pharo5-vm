translation
ancilliaryClasses: options
	ProcessorClass ifNil:
		[Cogit initializeMiscConstants].
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