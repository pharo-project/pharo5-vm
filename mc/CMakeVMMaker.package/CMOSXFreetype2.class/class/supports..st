testing
supports: aConfig 
	"just for iPhone"

	^ (super supports: aConfig) 
		and: [ (aConfig isKindOf: StackIPhoneConfig) not ]