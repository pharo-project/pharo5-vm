translation
ancilliaryStructClasses
	ProcessorClass ifNil: [thisContext methodClass theNonMetaClass initialize].
	^{	CogAbstractInstruction.
		ProcessorClass basicNew abstractInstructionCompilerClass.
		CogBlockStart.
		CogBytecodeDescriptor.
		CogBytecodeFixup.
		CogInstructionAnnotation.
		CogPrimitiveDescriptor.
		CogBlockMethod.
		CogMethod	}