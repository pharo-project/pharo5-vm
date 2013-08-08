translation
monticelloDescription
	"Override to include the ADPCMCodec class."
	"self monticelloDescription"
	^super monticelloDescription, '\' withCRs, (CCodeGenerator monticelloDescriptionFor: ADPCMCodec)