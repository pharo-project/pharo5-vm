translation
monticelloDescription
	"Override to include the AbstractSound class."
	"self monticelloDescription"
	^super monticelloDescription, '\' withCRs, (CCodeGenerator monticelloDescriptionFor: AbstractSound)