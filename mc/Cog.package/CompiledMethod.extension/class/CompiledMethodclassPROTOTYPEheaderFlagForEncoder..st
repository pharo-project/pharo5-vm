*Cog-method prototypes
CompiledMethodclassPROTOTYPEheaderFlagForEncoder: anEncoder
	anEncoder == PrimaryBytecodeSetEncoderClass ifTrue: [ ^ 0 ].
	anEncoder == SecondaryBytecodeSetEncoderClass ifTrue: [ ^ SmallInteger minVal ].
	^ self error: 'not one of the two installed bytecode set'