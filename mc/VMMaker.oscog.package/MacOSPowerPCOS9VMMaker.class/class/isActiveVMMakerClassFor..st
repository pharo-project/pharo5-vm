initialisation
isActiveVMMakerClassFor: platformName
	"Does this class claim to be that properly active subclass of VMMaker for this platform?"

	^platformName = 'Mac OS'" and: [Smalltalk platformSubtype = 'PowerPC'] <- this used to be used but prevents any attempt to do the crossplatform generation thang. How can we handle that bit properly?"