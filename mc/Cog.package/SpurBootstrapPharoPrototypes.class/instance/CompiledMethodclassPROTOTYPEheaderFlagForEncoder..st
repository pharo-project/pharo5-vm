method prototypes
CompiledMethodclassPROTOTYPEheaderFlagForEncoder: anEncoderClass
	"anEncoderClass == PrimaryBytecodeSetEncoderClass ifTrue: [ ^ 0 ].
	anEncoderClass == SecondaryBytecodeSetEncoderClass ifTrue: [ ^ SmallInteger minVal ].
	self error: 'The encoder is not one of the two installed bytecode sets'"
	^ 0