translation
ancilliaryClasses: options
	ProcessorClass ifNil:
		[Cogit initializeMiscConstants].
	^{	CogMethodZone.
		CogAbstractInstruction.
		self activeCompilerClass.
		CogBlockStart.
		CogBytecodeDescriptor.
		CogBytecodeFixup.
		CogInstructionAnnotation.
		CogPrimitiveDescriptor.
		CogBlockMethod.
		CogMethod },
	((options at: #NewspeakVM ifAbsent: [false])
		ifTrue: [{NewspeakCogMethod. NSSendCache}]
		ifFalse: [#()])