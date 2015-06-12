translation
ancilliaryClasses: options
	ProcessorClass ifNil:
		[Cogit initializeMiscConstants].
	^(self activeCompilerClass withAllSuperclasses copyUpThrough: CogAbstractInstruction),
	  {	CogMethodZone.
		CogBlockStart.
		CogBytecodeDescriptor.
		CogBytecodeFixup.
		CogPrimitiveDescriptor.
		CogBlockMethod.
		CogMethod.
		self activeCompilerClass literalsManagerClass},
	((options at: #NewspeakVM ifAbsent: [false])
		ifTrue: [{NewspeakCogMethod. NSSendCache}]
		ifFalse: [#()])