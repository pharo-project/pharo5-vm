*Cog-method prototypes
CompiledMethodclassPROTOTYPEheaderFlagForEncoder: anEncoder
	anEncoder class == PrimaryBytecodeSetEncoderClass ifTrue:
		[^0].
	anEncoder class == SecondaryBytecodeSetEncoderClass ifTrue:
		[^SmallInteger minVal].
	self error: 'The encoder is not one of the two installed bytecode sets'