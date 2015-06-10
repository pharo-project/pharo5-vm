translation
ancilliaryClasses: options
	ProcessorClass ifNil:
		[Cogit initializeMiscConstants].
	^{	CogMethodZone.
		CogBlockStart.
		CogBytecodeDescriptor.
		CogBytecodeFixup.
		CogInstructionAnnotation.
		CogPrimitiveDescriptor.
		CogBlockMethod.
		CogMethod },
	(self activeCompilerClass withAllSuperclasses copyUpThrough: CogAbstractInstruction),
	((options at: #NewspeakVM ifAbsent: [false])
		ifTrue: [{NewspeakCogMethod. NSSendCache}]
		ifFalse: [#()])