testing
supports: aConfig 
	"just for iPhone"

	^ (self platformName = aConfig platformName) 
		and: [ aConfig isKindOf: StackIPhoneConfig ]