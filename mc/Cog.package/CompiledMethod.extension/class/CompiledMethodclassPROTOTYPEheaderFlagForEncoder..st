*Cog-method prototypes
CompiledMethodclassPROTOTYPEheaderFlagForEncoder: anEncoder
	^ 0
	"anEncoder class == PrimaryBytecodeSetEncoderClass ifTrue: [ ^0 ].
	anEncoder class == SecondaryBytecodeSetEncoderClass ifTrue: [ ^SmallInteger minVal ].
	self error: 'The encoder is not one of the two installed byte code sets'"