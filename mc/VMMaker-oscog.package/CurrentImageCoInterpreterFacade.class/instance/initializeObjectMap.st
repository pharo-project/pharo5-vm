initialize-release
initializeObjectMap
	objectMap := IdentityDictionary new.
	{ nil. false. true. Smalltalk primitiveErrorTable. Float } do:
		[:o| self oopForObject: o]