initialize-release
initializeObjectMap
	objectMap := IdentityDictionary new.
	headerToMethodMap := Dictionary new.
	{ nil. false. true. Smalltalk primitiveErrorTable. Float } do:
		[:o| self oopForObject: o]